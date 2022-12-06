class CreateBaggages < ActiveRecord::Migration[7.0]
  def change
    create_table :baggages do |t|
      t.integer :num
      t.float :weight

      t.timestamps
    end
  end
end
