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
    get %r{/browse/(.*?)/(blob|tree|raw)/(\w+)/?(.*)} do
      @name = params[:captures][0]
      @type = params[:captures][1].to_sym
      @ref  = params[:captures][2]
      @path = params[:captures][3]

      @repo = Raggity::Repo.new @name, @ref


      case @type
      when :tree
        @tree = @repo.tree(@path)
        return erb :bare if @tree.nil?
        erb :tree
      when :blob, :raw
        @blob = @repo.blob(@path)
        halt 404, "Not found" if @blob.nil?
        content_type "text/plain" if @type == :raw
        erb @type, :layout => @type == :blob ? true : false
      end
    end

    helpers do

      def repo_path(repo, ref='master')
        "/browse/#{repo}/tree/#{ref}"
      end

      def object_path(options={})
        options = {
          :name => @name,
          :ref  => @ref,
          :path => @path,
          :type => @type
        }.merge(options)
        "/browse/#{options[:name]}/#{options[:type].to_s}/#{options[:ref]}/#{options[:path]}"
      end

      def root_path
        object_path(:type => :tree, :path => "")
      end

      def tree_path(tree)
        object_path(:type => :tree, :path => "#{@path}#{tree.name}")
      end

      def blob_path(blob, type=:blob)
        if @path == ''
          object_path(:type => type, :path => blob.name)
        else
          object_path(:type => type, :path => "#{@path}/#{blob.name}")
        end
      end

      def readme?(name)
        /readme/i.match(name)
      end

      def readme(contents)
        contents = [ contents ] if !contents.is_a?(Array)
        contents.each do |obj|
          if obj.is_a?(Grit::Blob) && readme?(obj.name)
            return GitHub::Markup.render(obj.name, obj.data)
          end
        end
        nil
      end

    end

  end
end
