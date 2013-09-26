class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def show
    @guns = Gun.includes(:gun_owner).paginate(:page => params[:page])
    @json = GunOwner.where(:id => @guns.collect(&:gun_owner_id).uniq).to_gmaps4rails
  end

  def unmapped_addresses
    @gun_owners = GunOwner.unmapped_addresses.paginate(:page => params[:page])
  end
end
