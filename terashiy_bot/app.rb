# frozen_string_literal: true

require 'json'
require 'time'
require 'dotenv'
require_relative './blog_content'
require_relative './ddb'
require_relative './messanger'

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

  send_message(blog_title: post[:title], url: blog_url)
  ddb.update_date(table_name: table_name, id: blog_url, new_date: post[:date])
end

def older_than_latest_date?(post_date:, latest_date:)
  post_date <= latest_date
end

def send_message(blog_title:, url:)
  token = ENV['LINE_ACCESS_TOKEN']
  messanger = LineMessanger.new(token)
  messanger.send(blog_title, url)
end
