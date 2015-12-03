require "sinatra/base"
require 'sinatra/activerecord'
require 'sinatra/json'

load_order = "models,lib/response,helpers,presenters,controllers"
Dir.glob("./{#{load_order}}/*.rb").each { |file| require file }

map('/orders') { run OrdersController }
map('/sms') { run SmsController }
