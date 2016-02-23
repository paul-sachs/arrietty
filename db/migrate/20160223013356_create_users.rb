class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.float :rating
      t.string :phone

      t.timestamps null: false
    end
  end
end
