class CreateEventos < ActiveRecord::Migration[6.1]
  def change
    create_table :eventos do |t|
      t.string :nomesdeveniment
      t.string :descripcio
      t.date :data
      t.string :foto
      t.integer :aforament
      t.string :ubicacio
      t.integer :participants
      t.integer :preu
      t.string :link_compartir
      t.string :link_pagina
      t.time :hora_inici
      t.time :hora_fi
      t.string :email_creador

      t.timestamps

      
    end
  end
end
