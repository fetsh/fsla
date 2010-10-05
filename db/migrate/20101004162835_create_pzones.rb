class CreatePzones < ActiveRecord::Migration
  def self.up
    create_table :pzones do |t|
      t.integer :task_id
      t.string :l

      t.timestamps
    end
  end

  def self.down
    drop_table :pzones
  end
end
