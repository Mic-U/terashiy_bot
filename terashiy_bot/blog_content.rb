# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

# HTML Parser using Nokogiri
class HtmlParserIncluded < HTTParty::Parser
  def html
    Nokogiri::HTML(body)
  end
end

# HTML Page
class Page
  include HTTParty
  parser HtmlParserIncluded
end

def latest_post
  blog_url = 'http://blog.livedoor.jp/terashimatakuma/'

  page = Page.get(blog_url)
  selector = '#blog .autopagerize_page_element .fullbody:nth-of-type(1)'
  latest_post = page.css(selector)
  {
    date: latest_post.css('.datebody .date').text,
    title: latest_post.css('.titlebody .title').text
  }
end
