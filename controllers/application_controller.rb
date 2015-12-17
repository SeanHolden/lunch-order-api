class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end

  def slack_authenticate!
    if !valid_token?
      halt 401, json({ message: 'Not authorized' })
    elsif !correct_channel?
      halt 401, json(wrong_channel_message)
    end
  end

  private

  def wrong_channel_message
    SlackResponse::Formatter.display(
      'Wrong channel, silly!',
      'This command will only work in #the-hatch'
    )
  end

  def valid_token?
    params[:token] == ENV['SLACK_TOKEN']
  end

  def correct_channel?
    params[:channel_id] == ENV['SLACK_CHANNEL_ID']
  end
end
