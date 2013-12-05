class DogsController < ApplicationController
  def new
  	@dog = Dog.new
  end

  def show
  	@dog = Dog.find(params[:id])
  end
end
