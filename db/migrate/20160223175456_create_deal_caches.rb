class CreateDealCaches < ActiveRecord::Migration
  def change
    create_table :deal_caches do |t|
      t.text :data

      t.timestamps
    end
  end
end
