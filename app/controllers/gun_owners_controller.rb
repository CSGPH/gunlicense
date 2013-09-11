class GunOwnersController < ApplicationController
  def upload
  end

  def import
    GunOwner.import(params[:file])
    redirect_to root_url, notice: "Users Imported"
  end
end
