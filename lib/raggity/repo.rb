require 'grit'

module Raggity

  class << self
    def list_repos
      repos = []
      Dir.glob("spec/fixtures/repositories/*") do |directory|
        repos.push(File.basename(directory).gsub('.git', ''))
      end
      repos
    end
  end

  class Repo
    attr_reader :repo

    def initialize(name, ref)
      path = File.expand_path("spec/fixtures/repositories/#{name}.git")
      @ref = ref
      @repo = Grit::Repo.new path
    end

    def tree(path)
      commit = @repo.commits(@ref).first
      return nil if commit.nil?
      if path == ''
        return commit.tree
      else
        return commit.tree / path
      end
    end

    def blob(path)
      blob = @repo.commits(@ref).first.tree / path
    end

    def branches
      @repo.heads
    end

    def tags
      @repo.tags
    end
  end

end
