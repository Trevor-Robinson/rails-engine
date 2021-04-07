class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.paginate(params["page"], params["per_page"]))
  end

  def show
    if params.include?("item_id")
      render json: MerchantSerializer.new(Item.find(params["item_id"]).merchant).serialized_json
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end
end
