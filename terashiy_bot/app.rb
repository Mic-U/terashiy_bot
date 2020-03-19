# frozen_string_literal: true

require 'json'
require 'time'
require_relative './blog_content'
require_relative './ddb'

@blog_url = 'http://blog.livedoor.jp/terashimatakuma/'
@table_name = ENV['DYNAMO_TABLE']

def lambda_handler(event:, context:)
  post = latest_post(blog_url: @blog_url)

  ddb = DDBConnector.new
  latest_date = ddb.latest_date(table_name: @table_name, id: @blog_url)

  unless newer_than_latest_date?(post_date: post.date, latest_date: latest_date)
    return
  end

  # TODO: Notify function
  ddb.update_date(table_name: @table_name, id: @blog_url, new_date: post.date)
end

def newer_than_latest_date?(post_date:, latest_date:)
  post_date > latest_date
end
