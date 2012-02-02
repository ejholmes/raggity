require 'raggit'
require 'sinatra'
require 'mustache/sinatra'

module Station
  class App < Sinatra::Base

    get '/repositores' do
      # list repositories
    end

    get '/browse/:repo/:ref/:branch/*' do
      # show blob or tree
    end

  end
end
