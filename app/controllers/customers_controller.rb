class CustomersController < ApplicationController
  autocomplete :customer, :name, full: true

  def index
    @customers = Customer.paginate(page: params[:page])
  end
  
  def show
    @customer = Customer.find params[:id]
  end
end
