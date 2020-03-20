require 'spec_helper'
require 'time'

require_relative '../terashiy_bot/app'

RSpec.describe 'app.rb' do
  describe 'older_than_latest_date?' do
    before do
      @later = Time.parse('2017/04/25 19:23:55')
      @older = Time.parse('2017/04/25 19:23:54')
    end
    context 'post_date > latest_date' do
      it 'return false' do
        expect(older_than_latest_date?(post_date: @later, latest_date: @older)).to be false
      end
    end
    context 'post_date <= latest_date' do
      it 'return true' do
        expect(older_than_latest_date?(post_date: @later, latest_date: @later)).to be true
      end
      it 'return true' do
        expect(older_than_latest_date?(post_date: @older, latest_date: @later)).to be true
      end
    end
  end
end
