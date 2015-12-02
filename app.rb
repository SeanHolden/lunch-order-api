require 'sinatra/activerecord'
require 'sinatra/json'
require './models/order'
require './helpers/orders_helper'
require './controllers/orders_controller'

register Sinatra::ActiveRecordExtension

class HatchApi < OrdersController;end
