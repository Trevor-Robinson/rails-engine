require 'rails_helper'

describe "Merchant API" do
  it "sends a list of books" do
    create_list(:merchant_with_items, 20)

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

  it "can get one merchant by its id" do

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


end
