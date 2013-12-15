class MastersController < ApplicationController
  before_action :signed_in_master, only: [:index, :edit, :update, :destroy]
  before_action :correct_master, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :already_signed_in, only: [:new, :create]
	
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

  def destroy
    @master.destroy
    flash[:success] = "Master deleted. Hope you feel good about yourself."
    redirect_to masters_url
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

    def admin_user
      @master = Master.find(params[:id])
      redirect_to root_url, notice: "You can't delete this person." if !current_master.admin? || current_master?(@master) 
    end

    def already_signed_in
        redirect_to root_url, notice: "You cannot complete this request when signed in." if signed_in?
    end
end

















