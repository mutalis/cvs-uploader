class OrdersController < ApplicationController

  def index
    @orders = Order.active

  end

  def import
    if Order.process(params[:file])
      message = 'Data imported'
    else
      message = 'The data was not imported'
    end
    redirect_to root_url, notice: message
  end

  def show
    order = Order.find(params[:id])
    @patients = order.patients
  end
end
