class GunOwnersController < ApplicationController
  def show
    @gun_owner = GunOwner.find(params[:id])
  end
end
