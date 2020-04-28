# frozen_string_literal: true

require 'time'
require 'aws-sdk-dynamodb'

# Save and load with DDB
class DDBConnector
  def initialize(table_name:)
    @dynamo_db = Aws::DynamoDB::Client.new
    @table_name = table_name
  end

  def latest_date(id:)
    resp = @dynamo_db.get_item({
      key: {
        'id' => id
      },
      table_name: @table_name
    })
    if resp.item.nil?
      puts 'No Item'
      now = Time.now
      update_date(table_name: @table_name, id: id, new_date: now)
      now
    else
      Time.at(resp.item['latest_date'])
    end
  end

  def update_date(id:, new_date:)
    @dynamo_db.put_item({
      item: {
        'id' => id,
        'latest_date' => new_date.to_i
      },
      table_name: @table_name
    })
  end
end
