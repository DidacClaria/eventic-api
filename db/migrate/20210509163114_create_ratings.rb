class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.string :text
      t.references :company
      t.references :customer
      t.timestamps
    end
    add_foreign_key :ratings, :users, column: :company_id, primary_key: :id
    add_foreign_key :ratings, :users, column: :customer_id, primary_key: :id
  end
end