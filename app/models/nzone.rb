# == Schema Information
# Schema version: 20101003220620
#
# Table name: nzones
#
#  id         :integer         not null, primary key
#  task_id    :integer
#  l          :decimal(, )
#  nSize      :decimal(, )
#  ro         :decimal(, )
#  ti         :decimal(, )
#  te         :decimal(, )
#  v          :decimal(, )
#  exp        :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class Nzone < ActiveRecord::Base
  belongs_to :task, :inverse_of => :nzones
  
  validates_presence_of :l
  validates_numericality_of :l
  validates :l,     :inclusion => { :in => 1..5000 }
  validates :nSize, :inclusion => { :in => 1..10_000 }
  validates :ro,    :inclusion => { :in => 50..4000 }
  validates :ti,    :inclusion => { :in => 299..99_000}
  validates :te,    :inclusion => { :in => 299..99_000}
  validates :v,     :inclusion => { :in => -10_000..10_000}

  DEFAULTS = {:l              => 200,
              :nSize          => 200,
              :ro             => 2700,
              :ti             => 300,
              :te             => 300,
              :v              => 0}
  
  
end
