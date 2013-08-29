class CreateShowData < ActiveRecord::Migration
  def change
    create_table :show_data do |t|
      t.string :host
      t.integer :port
      t.string :user
      t.string :pass
      t.string :db
      t.string :table
      t.references :show

      t.timestamps
    end
  end
end
