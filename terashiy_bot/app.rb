require 'httparty'
require 'nokogiri'
require 'json'
require 'aws-sdk-dynamodb'

class HtmlParserIncluded < HTTParty::Parser
  def html
    Nokogiri::HTML(body)
  end
end

class Page
  include HTTParty
  parser HtmlParserIncluded
end

def lambda_handler(event:, context:)
  dynamodb = Aws::DynamoDB::Client.new
  table_name = ENV['DYNAMO_TABLE']
  blog_url = 'http://blog.livedoor.jp/terashimatakuma/'

  page = Page.get(blog_url)
  latest_post = page.css("#blog .autopagerize_page_element .fullbody:nth-of-type(1)")
  {
    statusCode: 200,
    body: {
      message: latest_post.css(".datebody .date").text,
      # location: response.body
    }.to_json
  }
end
