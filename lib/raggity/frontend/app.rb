require 'raggity'
require 'sinatra'

module Raggity
  class Application < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    # List repositories
    get '/' do
      "ok"
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
        # return escape_html repo.tree(path).inspect
        @tree = repo.tree(@path)
        erb :tree
      when :blob
        @blob = repo.blob(@path)
        erb :blob
      end
    end

    helpers do
      def tree_path(tree)
        "hello"
      end

      def blob_path(blob)
        "/browse/#{@name}/blob/#{@ref}/#{@path}#{blob.name}"
      end
    end

  end
end
