class ActualitzarUser < ActiveRecord::Migration[6.1]
  def change
  	add_column :users, :username, :string
  	add_column :users, :language, :string
  	remove_column :users, :nickname, :string
  	remove_column :users, :confirmation_token, :string
    remove_column :users, :confirmed_at, :string
    remove_column :users, :confirmation_sent_at, :string
    remove_column :users, :unconfirmed_email, :string

  end
end
