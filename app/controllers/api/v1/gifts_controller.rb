class Api::V1::GiftsController < ApplicationController
# before_action :doorkeeper_authorize!, only: [:create]
  def index
    gifts = Gift.includes(image_attachment: :blob).order(id: :asc)

    gifts = gifts.map do |gift|
      gift.attributes.merge(image: gift.image_attachment.present? ? url_for(gift.image) : "")
    end

    render json: {
      message: "List of All Gifts",
      gifts: ,
      success: true
    }, status: :ok
  end

  def show
    gift = Gift.find_by(id: params[:id])
    render json: gift, status: :ok
  end

  def create
    gift = Gift.new(gifts_params)
    if gift.save
      render json: { message: "Successfully Created Gift", gift: gift, success: true }, status: :ok
    else
      render json: { message: gift.errors.full_messages.join(" ").to_s, success: false }, status: :not_found
    end
  end

  def destroy
    gift = Gift.find_by(id: params[:id])
    gift.destroy
    render json: { message: "Successfully Deleted Gift", success: true }, status: :ok
  end
  private

  def gifts_params
    params.require(:gift).permit(:name, :price, :description, :image)
  end
end
