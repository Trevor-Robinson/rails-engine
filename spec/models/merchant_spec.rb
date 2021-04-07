require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "returns paginated data" do
    create_list(:merchant_with_items, 30)
    expect(Merchant.paginate(1,20).count).to eq(20)
  end
end
