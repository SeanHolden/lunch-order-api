require './config/boot'

map('/orders') { run OrdersController }
map('/sms') { run SmsController }
