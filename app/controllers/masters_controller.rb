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
      sign_in @master
      flash[:success] = "Welcome to Dog Park!"
  		redirect_to @master
  	else
  		render 'new'
  	end
  end

  def edit
    @master = Master.find(params[:id])
  end

  def update
    @master = Master.find(params[:id])
    if @master.update_attributes(master_params)
      flash[:success] = "Profile updated"
      redirect_to @master
    else
      render 'edit'
    end
  end

  private

  	def master_params
      params.require(:master).permit(:name, :email, :password, :password_confirmation)
    end
end
