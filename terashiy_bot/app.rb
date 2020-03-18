require 'json'
require_relative './blog_content'

def lambda_handler(event:, context:)

  latest_post = get_latest_post

  puts latest_post.to_json
end
