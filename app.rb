require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'mysql2'

Dir.glob('./models/*.rb') do |model|
  require model
end

class HatchApi < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  post '/order' do
    text_order = params[:text_order]
    name = params[:name]
    order = Order.new(text_order: text_order, name: name)

    if order.save
      "Order placed for #{name}. Order: #{text_order}. Thanks!"
    else
      'Something went wrong'
    end
  end

  get '/current_order' do
    "Order so far:\n- #{formatted_todays_orders}"
  end

  def formatted_todays_orders
    todays_orders.map{ |order| order.text_order }.join("\n- ")
  end

  def todays_orders
    Order.where("created_at > DATE_SUB(NOW(), INTERVAL 1 DAY)")
  end
end
