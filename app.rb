require 'sinatra/activerecord'
require 'sinatra/json'
require 'mysql2'
require './models/order'
require './helpers/orders_helper'
require './controllers/orders_controller'

configure do
  set :json_encoder, :to_json
end

register Sinatra::ActiveRecordExtension

module HatchApi
  class Application < OrdersController;end
end
