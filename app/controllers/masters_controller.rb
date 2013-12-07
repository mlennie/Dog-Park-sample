class MastersController < ApplicationController
	
  def new
  	@master = Master.new
  end

  def show
  	@master = Master.find(params[:id])
  end

  def create
  	@master = Master.new(master_params)
  	if @master.save
      flash[:success] = "Welcome to Dog Park!"
  		redirect_to @master
  	else
  		render 'new'
  	end
  end

  private

  	def master_params
      params.require(:master).permit(:name, :email, :password, :password_confirmation)
    end
end
