require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant_with_items, 50)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(20)

    merchants["data"].each do |merchant|
      expect(merchant).to have_key("id")
      expect(merchant["id"]).to be_an(String)
      expect(merchant).to have_key("type")
      expect(merchant["type"]).to eq("merchant")
      expect(merchant).to have_key("attributes")
      expect(merchant["attributes"]).to have_key("name")
      expect(merchant["attributes"]["name"]).to be_an(String)
    end
  end

  it "sends one merchant by its id" do

    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]).to have_key("id")
    expect(merchant["data"]["id"]).to be_an(String)
    expect(merchant["data"]).to have_key("type")
    expect(merchant["data"]["type"]).to eq("merchant")
    expect(merchant["data"]).to have_key("attributes")
    expect(merchant["data"]["attributes"]).to have_key("name")
    expect(merchant["data"]["attributes"]["name"]).to be_an(String)
  end
  it "returns subset of merchants based on pagination" do
    create_list(:merchant_with_items, 30)

    get '/api/v1/merchants?page=1'

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].count).to eq(20)

  end

  it "returns other pages of merchants" do

    create_list(:merchant_with_items, 30)

    get '/api/v1/merchants?page=2'

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].count).to eq(10)
  end

  it "can return items for a merchant" do
    create_list(:merchant_with_items, 3)
    get "/api/v1/merchants/#{Merchant.first.id}/items"
    items = JSON.parse(response.body)
    expect(response).to be_successful
    expect(items["data"].count).to eq(5)

    items["data"].each do |item|
      expect(item).to have_key("id")
      expect(item["id"]).to be_an(String)
      expect(item).to have_key("type")
      expect(item["type"]).to eq("item")
      expect(item["attributes"]).to have_key("name")
      expect(item["attributes"]["name"]).to be_an(String)
      expect(item["attributes"]).to have_key("description")
      expect(item["attributes"]["description"]).to be_an(String)
      expect(item["attributes"]).to have_key("unit_price")
      expect(item["attributes"]["unit_price"]).to be_an(Float)
      expect(item["attributes"]).to have_key("merchant_id")
      expect(item["attributes"]["merchant_id"]).to be_an(Integer)
    end
  end
  it 'can return merchants by name search' do
    get '/api/v1/merchants/find_all?name=chroe'

    merchants = JSON.parse(response.body)

  end
end
