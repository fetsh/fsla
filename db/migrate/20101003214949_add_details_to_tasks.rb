class AddDetailsToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :HydroStage, :boolean
    add_column :tasks, :HeatStage, :boolean
    add_column :tasks, :ExchangeStage, :boolean
    add_column :tasks, :source, :boolean
    add_column :tasks, :tauPulse, :decimal
    add_column :tasks, :fluence, :decimal
    add_column :tasks, :deltaSkin, :decimal
    add_column :tasks, :courant, :decimal
    add_column :tasks, :maxTime, :decimal
  end

  def self.down
    remove_column :tasks, :maxTime
    remove_column :tasks, :courant
    remove_column :tasks, :deltaSkin
    remove_column :tasks, :fluence
    remove_column :tasks, :tauPulse
    remove_column :tasks, :source
    remove_column :tasks, :ExchangeStage
    remove_column :tasks, :HeatStage
    remove_column :tasks, :HydroStage
  end
end
