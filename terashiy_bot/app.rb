# frozen_string_literal: true

require 'json'
require 'time'
require 'dotenv'

require_relative './blog_content'
require_relative './ddb'
require_relative './messanger'

Dotenv.load! "#{__dir__}/.env"

def lambda_handler(event:, context:)
  require 'aws-xray-sdk/lambda'
  blog_url = 'http://blog.livedoor.jp/terashimatakuma/'
  post = latest_post(blog_url: blog_url)
  puts "post: #{post}"

  ddb = DDBConnector.new(table_name: ENV.fetch('DYNAMO_TABLE'))
  return if new_post?(ddb: ddb, id: blog_url, post_date: post[:date])

  token = ENV.fetch('LINE_ACCESS_TOKEN')
  send_message(blog_title: post[:title], url: blog_url, token: token)
  ddb.update_date(id: blog_url, new_date: post[:date])
end

def new_post?(ddb:, id:, post_date:)
  latest_date = ddb.latest_date(id: id)
  puts "latest_date #{latest_date}"
  older_than_latest_date?(post_date: post_date, latest_date: latest_date)
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
