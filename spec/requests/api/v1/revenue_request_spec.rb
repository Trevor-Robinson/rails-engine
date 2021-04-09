require 'rails_helper'

describe "item endpoints" do
  before :each do
    @merchant1 = create(:merchant)
    @customer1 = create(:customer)
    @item1 = create(:item)
    @invoice1 = create(:invoice, merchant_id: @merchant1.id, customer_id: @customer1.id, status: 'shipped')
    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: "success")
    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 20, unit_price: 10.00)

    @merchant2 = create(:merchant)
    @customer2 = create(:customer)
    @item2 = create(:item)
    @invoice2 = create(:invoice, merchant_id: @merchant2.id, customer_id: @customer2.id, status: 'shipped')
    @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: "success")
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 40, unit_price: 10.00)

    @merchant3 = create(:merchant)
    @customer3 = create(:customer)
    @item3 = create(:item)
    @invoice3 = create(:invoice, merchant_id: @merchant3.id, customer_id: @customer3.id, status: 'shipped')
    @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: "success")
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, quantity: 40, unit_price: 10.00)

    @merchant4 = create(:merchant)
    @customer4 = create(:customer)
    @item4 = create(:item)
    @invoice4 = create(:invoice, merchant_id: @merchant4.id, customer_id: @customer4.id, status: 'shipped')
    @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: "success")
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, quantity: 5, unit_price: 10.00)

    @merchant5 = create(:merchant)
    @customer5 = create(:customer)
    @item5 = create(:item)
    @invoice5 = create(:invoice, merchant_id: @merchant5.id, customer_id: @customer5.id, status: 'shipped')
    @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: "success")
    @invoice_item5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, quantity: 6, unit_price: 10.00)

    @merchant6 = create(:merchant)
    @customer6 = create(:customer)
    @item6 = create(:item)
    @invoice6 = create(:invoice, merchant_id: @merchant6.id, customer_id: @customer6.id, status: 'shipped')
    @transaction6 = create(:transaction, invoice_id: @invoice6.id, result: "success")
    @invoice_item6 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice6.id, quantity: 7, unit_price: 10.00)

    @merchant7 = create(:merchant)
    @customer7 = create(:customer)
    @item7 = create(:item)
    @invoice7 = create(:invoice, merchant_id: @merchant7.id, customer_id: @customer7.id, status: 'shipped')
    @transaction7 = create(:transaction, invoice_id: @invoice7.id, result: "success")
    @invoice_item7 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice7.id, quantity: 8, unit_price: 10.00)

    @merchant8 = create(:merchant)
    @customer8 = create(:customer)
    @item8 = create(:item)
    @invoice8 = create(:invoice, merchant_id: @merchant8.id, customer_id: @customer8.id, status: 'shipped')
    @transaction8 = create(:transaction, invoice_id: @invoice8.id, result: "success")
    @invoice_item8 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice8.id, quantity: 9, unit_price: 10.00)

    @merchant9 = create(:merchant)
    @customer9 = create(:customer)
    @item9 = create(:item)
    @invoice9 = create(:invoice, merchant_id: @merchant9.id, customer_id: @customer9.id, status: 'shipped')
    @transaction9 = create(:transaction, invoice_id: @invoice9.id, result: "success")
    @invoice_item9 = create(:invoice_item, item_id: @item9.id, invoice_id: @invoice9.id, quantity: 1, unit_price: 10.00)

    @merchant10 = create(:merchant)
    @customer10 = create(:customer)
    @item10 = create(:item)
    @invoice10 = create(:invoice, merchant_id: @merchant10.id, customer_id: @customer10.id, status: 'shipped')
    @transaction10 = create(:transaction, invoice_id: @invoice10.id, result: "success")
    @invoice_item10 = create(:invoice_item, item_id: @item10.id, invoice_id: @invoice10.id, quantity: 2, unit_price: 41.00)

    @merchant11 = create(:merchant)
    @customer11 = create(:customer)
    @item11 = create(:item)
    @invoice11 = create(:invoice, merchant_id: @merchant11.id, customer_id: @customer11.id, status: 'shipped')
    @transaction11 = create(:transaction, invoice_id: @invoice11.id, result: "success")
    @invoice_item11 = create(:invoice_item, item_id: @item11.id, invoice_id: @invoice11.id, quantity: 1, unit_price: 10.00)

    @merchant12 = create(:merchant)
    @customer12 = create(:customer)
    @item12 = create(:item)
    @invoice12 = create(:invoice, merchant_id: @merchant12.id, customer_id: @customer12.id, status: 'failed')
    @transaction12 = create(:transaction, invoice_id: @invoice12.id, result: "success")
    @invoice_item12 = create(:invoice_item, item_id: @item12.id, invoice_id: @invoice12.id, quantity: 1, unit_price: 10.00)
  end

  it "gets merchants with most revenue" do
    get '/api/v1/revenue/merchants?quantity=10'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(10)

    merchants["data"].each do |merchant|
      expect(merchant).to have_key("id")
      expect(merchant["id"]).to be_an(String)
      expect(merchant).to have_key("type")
      expect(merchant["type"]).to eq("merchant_name_revenue")
      expect(merchant).to have_key("attributes")
      expect(merchant["attributes"]).to have_key("name")
      expect(merchant["attributes"]["name"]).to be_an(String)
    end
  end

  it "gets merchants who sold most items" do
    get '/api/v1/merchants/most_items?quantity=8'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(8)

    merchants["data"].each do |merchant|
      expect(merchant).to have_key("id")
      expect(merchant["id"]).to be_an(String)
      expect(merchant).to have_key("type")
      expect(merchant["type"]).to eq("merchant_name_revenue")
      expect(merchant).to have_key("attributes")
      expect(merchant["attributes"]).to have_key("name")
      expect(merchant["attributes"]["name"]).to be_an(String)
    end

  end


  it "can get revenue between dates" do
    get '/api/v1/revenue?start=2012-03-09&end=2012-03-24'

    expect(response).to be_successful
  end

  it "can get revenue for a merchant" do
    get "/api/v1/revenue/merchants/#{@merchant1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(@merchant1.id.to_s)
    expect(merchant["data"]["type"]).to eq("merchant_revenue")
    expect(merchant["data"]["attributes"]["revenue"]).to eq("200.0")
  end

  it "can get items with most revenue" do
    get '/api/v1/revenue/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(10)

    items["data"].each do |item|
      expect(item).to have_key("id")
      expect(item["id"]).to be_an(String)
      expect(item).to have_key("type")
      expect(item["type"]).to eq("item_revenue")
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

  it "can get unshipped revenue" do
    get '/api/v1/revenue/unshipped'

    expect(response).to be_successful

    revenue = JSON.parse(response.body)
    expect(revenue["data"].first["type"]).to eq("unshipped_order")
    expect(revenue["data"].first["attributes"]["potential_revenue"]).to eq("10.0")
  end
end
