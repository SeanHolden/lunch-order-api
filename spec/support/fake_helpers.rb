module FakeCommandsHelper
  def params
    { user_name: user_name, text: text, user_id: user_id }
  end
end

module FakeSmsHelper
  class FakeWebhook;end

  def params
    { MessageStatus: 'sent', token: 'token' }
  end

  def request
    FakeWebhook.new
  end
end

module FakeSlackHelper
  def params
    { Body: 'This is a body' }
  end
end
