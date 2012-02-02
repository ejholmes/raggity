require 'grit'

module Raggity
  class Repo
    attr_reader :repo

    def initialize(name, ref)
      path = File.expand_path("spec/fixtures/repositories/#{name}.git")
      @ref = ref
      @repo = Grit::Repo.new path
    end

    def tree(path)
      if path == ''
        return @repo.commits(@ref).first.tree
      else
        return @repo.commits(@ref).first.tree / path
      end
    end

    def blob(path)
      blob = @repo.commits(@ref).first.tree / path
    end
  end
end
