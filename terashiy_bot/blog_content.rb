# frozen_string_literal: true

require 'time'
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

def latest_post(blog_url:)
  page = Page.get(blog_url)
  selector = '#blog .autopagerize_page_element .fullbody:nth-of-type(1)'
  latest_post = page.css(selector)

  # for example 2020年02月16日
  date_text = latest_post.css('.datebody .date').text
  {
    date: Time.strptime(date_text, '%Y年%m月%d日'),
    title: latest_post.css('.titlebody .title').text
  }
end
