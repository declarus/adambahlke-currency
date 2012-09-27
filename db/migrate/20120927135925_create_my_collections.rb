class CreateMyCollections < ActiveRecord::Migration
  def self.up
    create_table :my_collections do |t|
      t.string :country_id
      t.string :currency_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :my_collections
  end
end
