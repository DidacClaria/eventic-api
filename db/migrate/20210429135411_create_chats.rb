class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.belongs_to :evento
      t.references :company
      t.references :customer
      t.timestamps
    end
    add_foreign_key :chats, :users, column: :company_id, primary_key: :id
    add_foreign_key :chats, :users, column: :customer_id, primary_key: :id
  end
end
