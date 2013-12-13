class MastersController < ApplicationController
  before_action "signed_in_master", only: [:index, :edit, :update]
  before_action "correct_master", only: [:edit, :update]
	
  def index
    @masters = Master.paginate(page: params[:page])
  end

  def new
  	@master = Master.new
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

  def show
    @master = Master.find(params[:id])
  end

  def edit
  end

  def update
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

    #Before filters

    def signed_in_master
      unless signed_in?
        store_location
        redirect_to playtime_url, notice: "Please sign in."
      end
    end

    def correct_master
      @master = Master.find(params[:id])
      redirect_to root_url, notice: "You do not have access to this request." unless current_master?(@master)
    end
end

















