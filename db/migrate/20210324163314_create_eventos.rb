class CreateEventos < ActiveRecord::Migration[6.1]
  def change
    create_table :eventos do |t|
      t.string :title
      t.string :description
      t.date :date
      t.integer :capacity
      t.string :location
      t.integer :participants
      t.integer :price
      t.string :URL_share
      t.string :URL_page
      t.time :start_time
      t.time :end_time
      t.string :id_creator
      t.timestamps

    end
  end
end
