class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  #layout 'order_layout'
  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash.notice = "The order record was updated"
      redirect_to @order
    else
      flash.now.alert = @order.errors.full_messages.to_sentence
      render :edit
    end
  end


  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through
    def order_params
      params.require(:order).permit(:product_name, :product_count, :customer_id)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a 'not found' exception")
          flash.alert = e.to_s
          redirect_to customers_path
    end
end
