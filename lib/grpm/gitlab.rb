require 'gitlab'
require 'uri'
require 'yaml'
require 'fileutils'
require 'pathname'
require 'ostruct'

module Grpm
  class Gitlab
    attr_reader :project, :client

    def initialize(repository, ref='master')
      @info = parse_uri(repository)
      @ref = ref

      token = Env.info.select {|env|
        env['host'] == @info.host
      }.first['token']

      @client = ::Gitlab.client(endpoint: @info.endpoint, private_token: token)
      @project = @client.project(@info.project)
      @id = @project.id
    end

    def parse_uri(repository)
      uri = URI(repository)
      path_args = uri.path.sub('.git', '').split('/')
      uri.path = '/api/v4'

      OpenStruct.new({
        host: uri.host,
        name: path_args.last,
        endpoint: uri.to_s,
        project: path_args.select { |e| e != "" }.join('/')
      })
    end

    def package
      @package ||= YAML.load @client.file_contents(@id, 'grpc.yml', @ref)
    end

    def install
      package['deps'].map { |dep|
        if dep[0] == '/'
          dep
        else
          '/' + dep
        end
      }.each { |path|
        dir = Pathname.new('./grpm').join(@info.name)
        file_name = Pathname.new(path).basename.to_s
        file = @client.file_contents(@id, path)

        puts file_name

        FileUtils.mkdir_p(dir)
        File.write dir.join(file_name), file
      }
    end
  end
end