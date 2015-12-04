class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end
end
