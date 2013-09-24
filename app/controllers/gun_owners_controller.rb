class GunOwnersController < ApplicationController

  def show
    @gun_owner = GunOwner.find(params[:id])
    @guns = @gun_owner.guns
  end

  def edit
    @gun_owner = GunOwner.find(params[:id])
  end
  def update
    @gun_owner = GunOwner.find(params[:id])
    @gun_owner.update_attributes(params[:gun_owner])
  end

  
end
