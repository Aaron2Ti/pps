class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    if Supplier.create!(params[:supplier])
      redirect_to new_supplier_url
    else
      redirect_to suppliers_url
    end
  end

  def show
    @suppiler = Supplier.find params[:id]
    @parts = []
    10.times{ @parts << Part.all.rand }
    @parts.uniq!
  end
end
