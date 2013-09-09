class UsersController < ApplicationController
  def upload
  end

  def import
    User.import(params[:file])
    redirect_to root_url, notice: "Users Imported"
  end
end
