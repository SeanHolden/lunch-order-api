require "sinatra/base"
require 'sinatra/activerecord'
require 'sinatra/json'

load_order = [
  "config/initializers",
  "models",
  "models/*",
  "lib/*",
  "helpers",
  "presenters",
  "controllers",
].join(',')

Dir.glob("./{#{load_order}}/*.rb").each { |file| require file }
