class CreateValoracios < ActiveRecord::Migration[6.1]
  def change
    create_table :valoracios do |t|
      t.integer :rating
      t.string :text

      t.timestamps
    end
  end
end
