require 'sinatra/activerecord'
require 'sinatra/json'
require './models/order'
require './lib/response/order'
require './lib/controllers/helpers'
require './presenters/order_presenter'
require './controllers/orders_controller'

register Sinatra::ActiveRecordExtension

class HatchApi < OrdersController;end
