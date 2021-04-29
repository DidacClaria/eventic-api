class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :text
      t.belongs_to :User
      t.belongs_to :Chat
      t.timestamps
    end
  end
end
