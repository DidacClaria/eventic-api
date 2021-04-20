class CreateFollowerstable < ActiveRecord::Migration[6.1]
  def change
    create_table :followers, :id => false do |t|
    	
    	t.belongs_to :company, class_name: "User", foreign_key: "company_id"
  		t.belongs_to :user, class_name: "User", foreign_key: "user_id"
    	t.timestamps


    end
  end
end
