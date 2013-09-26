class GunOwnersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @gun_owner = GunOwner.find(params[:id])
    @guns = @gun_owner.guns
    @json = @gun_owner.to_gmaps4rails
  end

  def edit
    @gun_owner = GunOwner.find(params[:id])
  end

  def update
    @gun_owner = GunOwner.find(params[:id])
    @gun_owner.update_attributes(gun_owner_params)
  end

  private

  def gun_owner_params
    params.required(:gun_owner).permit(:name, :address, :city, :province, :region)
  end
end
