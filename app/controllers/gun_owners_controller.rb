class GunOwnersController < ApplicationController
  def show
    @gun_owner = GunOwner.find(params[:id])
    @guns = @gun_owner.guns
  end

end
