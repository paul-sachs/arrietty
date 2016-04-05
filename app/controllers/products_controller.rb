class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @products = Product.where.not(user_id: current_user.id)
  end
  
  def my_products
    @products = current_user.products
  end

  def new
    @product = Product.new
    render :layout => false
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to @product, notice: 'product was successfully created.'
    else
      render :new, :layout => false
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'product was successfully updated.'
    else
      render :edit, :layout => false
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'product was successfully destroyed.'
  end
  
  def show 
    render :layout => false
  end
  
  def edit 
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :category_id, :price, :image)
    end
end
