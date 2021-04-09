class Api::V1::RevenueController < ApplicationController
  def merchants
    if params["quantity"].nil?
      render json: { error: 'Incorrect parameters' }, status: 400
    else
      render json: MerchantRevenueSerializer.new(Merchant.most_revenue(params["quantity"])).serialized_json
    end
  end

  def merchant
    merchant = Merchant.find(params["merchant_id"])
    render json: RevenueSerializer.new(merchant.merchant_revenue.first)
  end
  def most_items
    if params["quantity"].nil?
      render json: { error: 'Incorrect parameters' }, status: 400
    else
      render json: MerchantItemsSerializer.new(Merchant.most_items(params["quantity"])).serialized_json
    end
  end

  def items
    render json: ItemRevenueSerializer.new(Item.most_revenue(params["quantity"])).serialized_json
  end

  def unshipped
    render json: InvoiceSerializer.new(Invoice.unshipped_revenue(params["quantity"])).serialized_json
  end
  def date_range
    if params["start"].nil? || params["end"].nil? || params["start"].empty? || params["end"].empty?
      render json: { error: 'Incorrect parameters' }, status: 400
    elsif params["start"].to_time > params["end"].to_time
      render json: { error: 'Incorrect parameters' }, status: 400
    else
      render json: DateRangeSerializer.range_revenue(InvoiceItem.revenue_date_range(params["start"], params["end"]))
    end
  end
  def weekly

  end
end
