require 'rails_helper'

describe "item API" do
  before :each do
    @merchant1 = create(:merchant_with_items)
    @merchant2 = create(:merchant_with_items)
    @merchant3 = create(:merchant_with_items)
    @merchant4 = create(:merchant_with_items)
  end
  it "sends a list of items" do

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(20)

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

  it "can get one item by its id" do

    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"]).to have_key("id")
    expect(item["data"]["id"]).to be_an(String)
    expect(item["data"]).to have_key("type")
    expect(item["data"]["type"]).to eq("item")
    expect(item["data"]["attributes"]).to have_key("name")
    expect(item["data"]["attributes"]["name"]).to be_an(String)
    expect(item["data"]["attributes"]).to have_key("description")
    expect(item["data"]["attributes"]["description"]).to be_an(String)
    expect(item["data"]["attributes"]).to have_key("unit_price")
    expect(item["data"]["attributes"]["unit_price"]).to be_an(Float)
    expect(item["data"]["attributes"]).to have_key("merchant_id")
    expect(item["data"]["attributes"]["merchant_id"]).to be_an(Integer)
  end

  it "can create a new item" do
    item_params = ({
                  name: 'Test Item 1',
                  description: 'THIS IS A TEST ITEM',
                  unit_price: 342.38,
                  merchant_id: @merchant1.id
                })
    headers = {"CONTENT_TYPE" => "application/json"}
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = Item.first.id

    previous_name = Item.first.name

    item_params = { name: "New Name"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("New Name")
  end

  it "can destroy an item" do
    item = Item.last

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
