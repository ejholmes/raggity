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

    def initialize
      @base = File.expand_path(".")
    end
  end
end
