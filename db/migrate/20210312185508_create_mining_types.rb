class CreateMiningTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :mining_types do |t|
      t.string :name
      t.string :acornym

      t.timestamps
    end
  end
end
