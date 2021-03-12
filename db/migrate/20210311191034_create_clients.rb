class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :NomIdentificador
      t.string :Contrasenya
      t.integer :IdUsuari
      t.string :Correu
      t.string :Idioma

      t.timestamps
    end
  end
end
