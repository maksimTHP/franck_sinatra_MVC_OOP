require 'pry'
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show_gossip, locals: {gossip_row: Gossip.find(params['id']), gossip_id: params['id']}
  end

  get '/gossips/:id/edit/' do
    erb :edit_gossip, locals: {gossip_row: Gossip.find(params['id']), gossip_id: params['id']}
  end

  post '/gossip/:id/edit/' do
    Gossip.edit(params["gossip_author"],params["gossip_content"])
  redirect '/'

  end

end
