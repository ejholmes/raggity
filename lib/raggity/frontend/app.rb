require 'raggity'
require 'sinatra'
require 'github/markup'
require 'pygments'

module Raggity
  class Application < Sinatra::Base
    dir = File.dirname(File.expand_path(__FILE__))

    Raggity.configure do |config|
      config.base = File.expand_path("spec/fixtures/repositories")
    end

    # List repositories
    get '/' do
      @repos = Raggity.list_repos
      erb :index
    end

    # Browse a tree or blob
    get %r{/(.*?)/(blob|tree|raw)/(\w+)/?(.*)} do
      @params[:name] = params[:captures][0]
      @params[:type] = params[:captures][1] || 'tree'
      @params[:ref]  = params[:captures][2] || 'master'
      @params[:path] = params[:captures][3] || ''

      @repo = Repo.new @params[:name], @params[:ref]
      @object = @repo.object(@params[:path])

      case @params[:type]
      when 'tree'
        erb :tree
      when 'blob', 'raw'
        erb @params[:type].to_sym, :layout => @params[:type] == 'blob' ? true : false
      end
    end

    helpers do
      def path(object, options={})
        defaults = @params.clone
        defaults[:type] = object.is_a?(Grit::Tree) ? 'tree' : 'blob'
        defaults.merge(options)
        options = defaults
        options[:path] = "#{options[:path]}/#{object.name}"
        if object.is_a?(Grit::Repo)
          return "/#{options[:name]}/tree/#{options[:ref]}"
        else
          return "/#{options[:name]}/#{options[:type]}/#{options[:ref]}/#{options[:path]}"
        end
      end
    end

  end
end
