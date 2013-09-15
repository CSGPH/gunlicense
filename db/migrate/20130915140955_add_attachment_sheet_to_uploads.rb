class AddAttachmentSheetToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :sheet
    end
  end

  def self.down
    drop_attached_file :uploads, :sheet
  end
end
