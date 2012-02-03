module Raggity
  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

  end

  class Configuration
    # The base directory for the repositories. Defaults to current shell
    # directory.
    attr_accessor :base
    attr_accessor :clone_template

    def initialize
      @base = File.expand_path(".")
      @clone_template = "git@git.com:{{name}}.git" 
    end
  end
end
