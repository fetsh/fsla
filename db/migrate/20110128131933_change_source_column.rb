class ChangeSourceColumn < ActiveRecord::Migration
  def self.up
    change_column :tasks, :source, :string
  end

  def self.down
    change_column :tasks, :source, :boolean
  end
end
