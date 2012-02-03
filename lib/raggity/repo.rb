require 'grit'

module Raggity

  class << self
    def list_repos
      repos = []
      Dir.glob(File.join(Raggity.configuration.base, "*")) do |directory|
        repos.push(File.basename(directory).gsub('.git', ''))
      end
      repos
    end
  end

  class Repo < Grit::Repo
    attr_reader :path
    attr_reader :ref
    attr_reader :name

    def initialize(name, ref)
      @path = File.join(Raggity.configuration.base, "#{name}.git")
      @name = name
      @ref  = ref
      super @path
    end

    def object(path)
      commits(@ref).first.tree / path || commits(@ref).first.tree
    end

    # Tries to find a readme in the tree
    def readme(tree)
      file = nil
      tree.blobs.each { |blob| file = blob if blob.name =~ /readme/i }
      return file
    end
  end

end
