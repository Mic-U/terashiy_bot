require 'spec_helper'

require_relative '../terashiy_bot/messanger'

RSpec.describe LineMessanger do
  before do
    @messanger = LineMessanger.new(token: 'test_token')
  end

  describe 'http_header' do
    it 'set Authorization' do
      header = @messanger.http_header
      expect(header).to eql({
        'Content-Type' => 'application/json',
        'Authorization' => 'Bearer test_token'
      })
    end
  end

  describe 'convert_message' do
    it 'return object according to LINE API' do
      messages = @messanger.convert_message(blog_title: 'test_title', url: 'example.com')
      expect(messages).to eql({
        messages: [
          {
            type: 'text',
            text: "【新着】 test_title\nexample.com"
          }
        ]
      })
    end
  end
end
