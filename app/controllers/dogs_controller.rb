class DogsController < ApplicationController
  def new
  	@dog = Dog.new
  end

  def show
  	@dog = Dog.find(params[:id])
  end

  def create
  	@dog = Dog.new(dog_params)
  	if @dog.save
      flash[:success] = "Welcome to Dog Park!"
  		redirect_to @dog
  	else
  		render 'new'
  	end
  end

  private

  	def dog_params
      params.require(:dog).permit(:name, :email, :password, :password_confirmation)
    end
end
