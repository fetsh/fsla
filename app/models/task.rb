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

  
  has_many :nzones, :dependent => :destroy
  accepts_nested_attributes_for :nzones, :reject_if => lambda { |a| a[:nSize].blank? }

  default_scope :order => 'tasks.created_at DESC'
  
  validates :title, :presence => true, :length => { :maximum => 140 }

  
end
