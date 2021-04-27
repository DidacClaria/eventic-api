class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password_digest
      t.string :name
      t.string :username
      t.string :phone
      t.string :nif
      t.string :image
      t.string :language
      t.integer :longitude
      t.integer :latitude
      t.string :login_token
      t.string :role, :null => false, :default => "customer"

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :login_token, unique: true

  end
end
