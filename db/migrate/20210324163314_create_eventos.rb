class CreateEventos < ActiveRecord::Migration[6.1]
  def change
    create_table :eventos do |t|
      t.string :title
      t.string :description
      t.string :start_date
      t.string :end_date
      t.string :image
      t.integer :capacity
      t.string :latitude
      t.string :longitude
      t.integer :participants
      t.integer :price
      t.string :URL_share
      t.string :URL_page
      t.string :start_time
      t.string :end_time
      t.integer :id_creator
      t.timestamps

    end
  end
end
