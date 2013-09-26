class Admin::GunOwnersController < ApplicationController
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
    if @gun_owner.update_attributes(gun_owner_params)
      redirect_to @gun_owner, notice: 'Updated Succssfully'
    else
      render action: "edit"
    end



  end

  # def update
  #   @status = current_user.statuses.find(params[:id])
  #   if params[:status] && params[:status].has_key?(:user_id) 
  #     params[:status].delete(:user_id) 
  #   end
  #   respond_to do |format|
  #     if @status.update_attributes(params[:status])
  #       format.html { redirect_to @status, notice: 'Status was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @status.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def gun_owner_params
    params.required(:gun_owner).permit(:name, :address, :city, :province, :region)
  end
end
