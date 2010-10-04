# == Schema Information
# Schema version: 20101003220620
#
# Table name: tasks
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  exp           :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  HydroStage    :boolean
#  HeatStage     :boolean
#  ExchangeStage :boolean
#  source        :boolean
#  tauPulse      :decimal(, )
#  fluence       :decimal(, )
#  deltaSkin     :decimal(, )
#  courant       :decimal(, )
#  maxTime       :decimal(, )
#

class Task < ActiveRecord::Base
  attr_accessible :exp, :title
  
  has_many :nzones, :dependent => :destroy
  accepts_nested_attributes_for :nzones

  default_scope :order => 'tasks.created_at DESC'
  
  validates :exp, :presence => true, :numericality => true
  validates :title, :presence => true, :length => { :maximum => 140 }

  
end
