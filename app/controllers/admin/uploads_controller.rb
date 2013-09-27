class Admin::UploadsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @uploads = Upload.all
  end

  def create
    @upload = Upload.create upload_params
    if @upload
      UploadWorker.perform_async(@upload.id)
      redirect_to admin_dashboard_path, notice: "Users Imported"
    end
  end

  def new
    @upload = Upload.new
  end

  private

  def upload_params
    params.require(:upload).permit(:upload, :sheet, :sheet_file_name)
  end
end
