class CreateUeditorAssets < ActiveRecord::Migration
  def change
    create_table :ueditor_assets do |t|
      t.string :type   # for identify type of assets.  image, attachment etc..
      t.string :title    # for image title.
      t.timestamps
    end
  end
end
