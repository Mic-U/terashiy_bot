# frozen_string_literal: true

require 'json'
require 'time'
require 'dotenv'

require_relative './blog_content'
require_relative './ddb'
require_relative './messanger'

require 'aws-xray-sdk/lambda'

Dotenv.load! "#{__dir__}/.env"

def lambda_handler(event:, context:)
  blog_url = 'http://blog.livedoor.jp/terashimatakuma/'
  table_name = ENV['DYNAMO_TABLE']
  post = latest_post(blog_url: blog_url)
  puts "post: #{post}"

  ddb = DDBConnector.new
  latest_date = ddb.latest_date(table_name: table_name, id: blog_url)

  puts "latest_date #{latest_date}"
  if older_than_latest_date?(post_date: post[:date], latest_date: latest_date)
    return
  end

  token = ENV['LINE_ACCESS_TOKEN']
  send_message(blog_title: post[:title], url: blog_url, token: token)
  ddb.update_date(table_name: table_name, id: blog_url, new_date: post[:date])
end

def older_than_latest_date?(post_date:, latest_date:)
  post_date <= latest_date
end

def send_message(blog_title:, url:, token:)
  puts 'sending messages...'
  messanger = LineMessanger.new(token: token)
  response = messanger.send(blog_title: blog_title, url: url)
  puts "response: #{response}"
  raise 'Sending message failed.' unless response.success?
end
