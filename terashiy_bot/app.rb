# frozen_string_literal: true

require 'json'
require_relative './blog_content'

def lambda_handler(event:, context:)
  post = latest_post

  puts post.to_json
end
