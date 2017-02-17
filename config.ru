require './config/boot'


map('/orders') { run OrdersController }
map('/sms') { run SmsController }
map('/slack') { run SlackController }
map('/commands') { run CommandsController }

$stdout.sync = true
