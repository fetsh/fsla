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
  belongs_to :task
end
