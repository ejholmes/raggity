require 'raggity'
require 'sinatra'
require 'github/markup'
require 'pygments'

module Raggity
  class Application < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    # List repositories
    get '/' do
      @repos = Raggity.list_repos
      erb :index
    end

    # Browse a tree or blob
    get %r{/browse/(.*?)/(blob|tree|)/(\w+)/?(.*)} do
      @name = params[:captures][0]
      @type = params[:captures][1].to_sym
      @ref  = params[:captures][2]
      @path = params[:captures][3]

      repo = Raggity::Repo.new @name, @ref


      case @type
      when :tree
        @tree = repo.tree(@path)
        return erb :bare if @tree.nil?
        erb :tree
      when :blob
        @blob = repo.blob(@path)
        erb :blob
      end
    end

    helpers do
      def repo_path(repo, ref='master')
        "/browse/#{repo}/tree/#{ref}"
      end

      def tree_path(tree)
        "/browse/#{@name}/tree/#{@ref}/#{@path}#{tree.name}"
      end

      def blob_path(blob)
        if @path == ''
          "/browse/#{@name}/blob/#{@ref}/#{blob.name}"
        else
          "/browse/#{@name}/blob/#{@ref}/#{@path}/#{blob.name}"
        end
      end
    end

  end
end
