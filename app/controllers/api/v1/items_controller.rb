class Api::V1::ItemsController < ApplicationController
  def index
    if params.include?("merchant_id")
      merchant = Merchant.find(params["merchant_id"])
      render json: ItemSerializer.new(merchant.items).serialized_json
    else
      render json: ItemSerializer.new(Item.paginate(params["page"], params["per_page"])).serialized_json
    end
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serialized_json
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item).serialized_json, status: :created
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def destroy
    item = Item.destroy(params[:id])
    render json: ItemSerializer.new(item).serialized_json
  end

  def find

    render json: ItemSerializer.new(Item.find_by_name(params["name"]).first).serialized_json
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
