class UploadWorker
  include Sidekiq::Worker

  def perform(id)
    upload = Upload.find(id)
    GunOwner.import(upload.sheet.path)
  end
end
