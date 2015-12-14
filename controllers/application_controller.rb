class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end

  def slack_authenticate!
    return if params[:token] == ENV['SLACK_TOKEN']
    halt 401, json({ status: '401', message: 'Not authorized' })
  end
end
