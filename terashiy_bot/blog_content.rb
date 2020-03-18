require 'httparty'
require 'nokogiri'

class HtmlParserIncluded < HTTParty::Parser
  def html
    Nokogiri::HTML(body)
  end
end

class Page
  include HTTParty
  parser HtmlParserIncluded
end

def get_latest_post
  blog_url = 'http://blog.livedoor.jp/terashimatakuma/'

  page = Page.get(blog_url)
  latest_post = page.css("#blog .autopagerize_page_element .fullbody:nth-of-type(1)")
  {
    date: latest_post.css(".datebody .date").text,
    title: latest_post.css(".titlebody .title").text
  }
end
