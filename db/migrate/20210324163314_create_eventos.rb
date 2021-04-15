class CreateEventos < ActiveRecord::Migration[6.1]
  def change
    create_table :eventos do |t|
      t.string :title
      t.string :description
      t.date :start_date
      t.date :end_date
      t.binary :image
      t.integer :capacity
      t.integer :latitude
      t.integer :longitude
      t.integer :participants
      t.integer :price
      t.string :URL_share
      t.string :URL_page
      t.time :start_time
      t.time :end_time
      t.integer :id_creator
      t.timestamps
      
      
    end
  end
end
