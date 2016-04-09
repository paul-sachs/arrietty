class AddDisplayNameToPreferences < ActiveRecord::Migration
  def up
    add_column :preferences, :display_name, :string

    Preference.find_each do |p|
    	p.display_name = p.user.email
    	p.save
    end
  end

  def down
  	remove_column :preferences, :display_name
  end
end
