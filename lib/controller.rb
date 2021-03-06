require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base

    get '/gossips/new/' do
        erb :new_gossip
    end

    post '/gossips/new/?' do
        Gossip.new(params["gossip_author"],params["gossip_content"]).save
        redirect '/'
    end

    get '/?' do
        erb :index, locals: {gossips: Gossip.all}
    end
      
    get '/gossips/:id/?' do
        erb :show, locals: {gossip: Gossip.find(params['id']), comments: Comment.all(params['id'])}
    end

    post '/gossips/:id/?' do
        Comment.new(params["gossip_comment"],params['id']).save
        redirect '/'
    end

    get '/gossips/:id/edit/?' do
        erb :edit, locals: {id: params['id'], gossip: Gossip.find(params['id'])}
    end

    post '/gossips/:id/edit/?' do
        Gossip.update(params["gossip_author"],params["gossip_content"],params['id'])
        redirect '/'
    end


end