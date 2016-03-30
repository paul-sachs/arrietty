class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.text :about_me
      t.string :location
      t.string :email
      t.boolean :notification_message
      t.boolean :notification_interest
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
