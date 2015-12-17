require './spec/spec_helper'

describe Request do
  subject(:req) { Request.new('http://test.com', { text: 'some body'}) }

  before do
    stub_request(:post, 'http://test.com/').with(
      body: { text: 'some body' },
      headers: {
        'Content-Type' => 'application/json',
        'User-Agent' => 'Faraday v0.9.2'
      }
    ).to_return(status: 200, body: 'mock response', :headers => {})
  end

  describe '#post' do
    it 'performs a http post request' do
      expect(req.post.body).to eql('mock response')
    end
  end
end
