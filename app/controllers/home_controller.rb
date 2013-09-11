class HomeController < ApplicationController
  def index
    @guns = Gun.includes(:gun_owner).paginate(:page => params[:page])
  end
end
