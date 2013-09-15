class HomeController < ApplicationController
  def index
    @guns = Gun.includes(:gun_owner).paginate(:page => params[:page])
    @json = GunOwner.where(:id => @guns.collect(&:gun_owner_id).uniq).to_gmaps4rails
  end
end
