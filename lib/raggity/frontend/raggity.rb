require 'raggity'
require 'sinatra'
require 'mustache/sinatra'

module Raggity
  class Application < Sinatra::Base

    # List repositories
    get '/' do
    end

    # Browse a tree or blob
    get %r{/browse/(.*?)/(blob|tree|)/(\w+)/?(.*)} do
      name = params[:captures][0]
      type = params[:captures][1]
      ref  = params[:captures][2]
      path = params[:captures][3]
    end

  end
end
