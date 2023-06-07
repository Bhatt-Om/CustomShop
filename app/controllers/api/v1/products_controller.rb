class Api::V1::ProductsController < ApplicationController
  # before_action :doorkeeper_authorize!, only: [:create]
  
  def index 
    products = Product.includes(image_attachment: :blob).order(id: :asc)
    if params[:product_type].present?
      products = Product.where(name: params[:product_type]).order(id: :asc)
      if params[:product_type].eql?('T-Shirt') && params[:category].present?
        products = Product.where(name: params[:product_type], category: params[:category]).order(id: :asc)
      end
    else
      products = Product.order(id: :asc)
    end
    products = products.map do |product|
      product.attributes.merge(image: product.image_attachment.present? ? url_for(product.image) : "")
    end
    render json: products, status: :ok
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product, status: :ok
  end

  def create
    product = Product.new(
    name: params[:name],
    category: params[:category],
    product_description: params[:product_description],
    price: params[:price],
    discount: params[:discount],
    color: params[:color],
    size:  JSON.parse(params[:size]),
    material: JSON.parse(params[:material]),
    printing_type: JSON.parse(params[:printing_type])
    )
    product.image.attach(params[:image])

    if product.save
      render json: { message: "SuccessFully Created", product: product, success: true }, status: :ok
    else
      render json: { message: product.errors.full_messages.join(", ").to_s, success: false}, status: :not_found
    end
  end

  def update
    product = Product.find_by(id: params[:id])
    if product.update(products_params)
      render json: product, status: :ok
    else
      render json: product.errors.full_messages.join(", ").to_s, status: :not_found
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {
      messages: 'Product was successfully destroyed',
      success: true
    },status: :ok
  end
  # def upload_images
  #   product = Product.find_by_id(params[:id])
  #   render json: { message: 'Images uploaded successfully' }
  # end

  # def destroy_images
  #   product = Product.find_by_id( params[:id])
  #   attachments = ActiveStorage::Attachment.where(record_id: product.id)
  #   attachments.each(&:purge)
  #   render json: {error: "images deleted successfully"}
  # end
  # private

  # def products_params
  #   params.require(:product).permit(:name, :category, :product_description, :price, :discount, :color, :image, size: [], material: {}, printing_type: {})
  # end
end
