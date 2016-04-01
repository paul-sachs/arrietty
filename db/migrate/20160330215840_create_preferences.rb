class CreatePreferences < ActiveRecord::Migration
  def up
    create_table :preferences do |t|
      t.text :about_me, default: ''
      t.string :location, default: ''
      t.string :email, default: ''
      t.boolean :notification_message, default: true
      t.boolean :notification_interest, default: true
      t.integer :user_id

      t.timestamps null: false
    end
    
    User.find_each do |user|
      user.preference = Preference.new
      user.save
    end
    
  end
  
  def down 
    drop_table :preferences
  end
end
