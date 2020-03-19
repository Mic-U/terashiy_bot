# frozen_string_literal: true

require 'time'
require 'aws-sdk-dynamodb'

# Save and load with DDB
class DDBConnector
  def initialize
    @dynamo_db = Aws::DynamoDB::Client.new
  end

  def latest_date(table_name:, id:)
    resp = @dynamo_db.get_item({
      key: {
        'id' => id
      },
      table_name: table_name
    })
    if resp.item.nil?
      Time.now
    else
      Time.at(resp.item['latest_date'])
    end
  end
end
