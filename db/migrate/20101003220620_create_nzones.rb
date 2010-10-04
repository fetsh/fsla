class CreateNzones < ActiveRecord::Migration
  def self.up
    create_table :nzones do |t|
      t.integer :task_id
      t.decimal :l
      t.decimal :nSize
      t.decimal :ro
      t.decimal :ti
      t.decimal :te
      t.decimal :v
      t.decimal :exp

      t.timestamps
    end
    add_index  :nzones, :task_id
  end

  def self.down
    drop_table :nzones
  end
end
