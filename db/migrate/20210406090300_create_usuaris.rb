class CreateUsuaris < ActiveRecord::Migration[6.1]
  def change
    create_table :usuaris do |t|
      t.string :email, :null => false
      t.string :name
      t.string :username
      t.string :image
      t.string :language
      t.string :location
      t.string :login_token
      t.string :password_digest
      t.string :tipus, :null => false, :default => "client"

      t.timestamps
    end
    add_index :usuaris, :email, unique: true

  end
end
