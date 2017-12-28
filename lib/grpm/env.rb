require "yaml"

module Grpm
  class Env
    class << self
      def info
        @info ||= YAML.load_file("#{ENV['HOME']}/.grpm")
      end
    end
  end
end
