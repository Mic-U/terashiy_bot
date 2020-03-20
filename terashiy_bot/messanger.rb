# frozen_string_literal: true

require 'httparty'

# Send message to LINE channel
class LineMessanger
  def initialize(token:)
    @line_url = 'https://api.line.me/v2/bot/message/broadcast'
    @token = token
  end

  def send(blog_title:, url:)
    messages = convert_message(blog_title: blog_title, url: url)
    puts "messages: #{messages}"
    HTTParty.post(@line_url,
                  body: messages.to_json,
                  headers: http_header)
  end

  def http_header
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def convert_message(blog_title:, url:)
    {
      messages: [
        {
          type: 'text',
          text: "【新着】 #{blog_title}\n#{url}"
        }
      ]
    }
  end
end
