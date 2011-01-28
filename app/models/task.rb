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

class Task < ActiveRecord::Base
  
  include ServerTalking
  
  belongs_to :user
  has_many :nzones, :dependent => :destroy, :inverse_of => :task
  accepts_nested_attributes_for :nzones

  default_scope :order => 'tasks.created_at DESC'
  
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates_presence_of  :tauPulse, :fluence, :deltaSkin, :courant, :maxTime, :nzones, :source
  validates_numericality_of :tauPulse, :fluence, :deltaSkin, :courant, :maxTime
  validates_inclusion_of :HydroStage, :HeatStage, :ExchangeStage, :in => [true, false]
  validates :tauPulse, :inclusion => { :in => 1..1_000_000 }
  validates :fluence, :inclusion => { :in => 0..1_000_000 }
  validates :deltaSkin, :inclusion => { :in => 1..100 }
  validates :courant, :inclusion => { :in => 0..1 }
  validates :maxTime, :inclusion => { :in => 0.01..1000 }
  validates :user_id, :presence => true
  
  validates_associated :nzones
  
  DEFAULTS = {:HydroStage     => true,
              :HeatStage      => true,
              :ExchangeStage  => true,
              :source         => true,
              :tauPulse       => 120,
              :fluence        => 650,
              :deltaSkin      => 10,
              :courant        => 0.1,
              :maxTime        => 100 }
  SOURCE = ['Al', 'Al_glass', 'Al_glass_sq']
  
  def progress
    @progress = get_progress(self.id)
    if @progress.code == "200"
      @current_time = @progress.body.to_f * 10.power!(12)
    else
      return "server error"
    end
  end
  
end
