class AddAttachmentDataToAssets < ActiveRecord::Migration
  def self.up
    change_table :ueditor_assets do |t|
      t.attachment :data
    end
  end

  def self.down
    drop_attached_file :ueditor_assets, :data
  end
end
