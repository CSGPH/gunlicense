class SessionsController < ApplicationController
  def new
  end

  def create
    owner = GunOwner.authenticate(params[:serial_number])
    if owner
      session[:owner_id] = owner.id
    else
      render "new"
    end
  end

  def destroy
  end
end
