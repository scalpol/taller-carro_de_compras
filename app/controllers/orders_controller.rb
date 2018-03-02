class OrdersController < ApplicationController
before_action :authenticate_user!
before_action :set_cart, only: [:index, :empty]

  def create
    order = Order.find_by(user: current_user, product_id: params[:product_id])
    if order.nil?
      Order.create(user: current_user, product_id: params[:product_id])
      redirect_to root_path, notice: 'El producto ha sido agregado'
    elsif order.save
      redirect_to root_path, notice: 'El producto ha sido agregado'
    else
      redirect_to root_path, alert: 'No se ha podido agregar el producto'
    end
  end

  def index
    @total = @orders.inject(0) { |sum, order| sum += order.product.price }
  end

  def destroy
    order = Order.find(params[:id])
    if order.quantity > 1
      order.update(quantity: (order.quantity -= 2))
      redirect_to orders_path, notice: 'Carro actualizado'
    else
      order.destroy
      redirect_to orders_path, notice: 'Producto eliminado'
    end
  end

  def empty
    @orders.destroy_all
    redirect_to orders_path, notice: 'Su carro se ha vaciado'
  end

  private

  def set_cart
    @orders = current_user.orders.where(payed: false)
  end
end
