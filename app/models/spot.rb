class Spot < ActiveRecord::Base
  belongs_to :user
  
  validates :date, :time, :address, :floor, :section, :row, :spot, :note, :name, presence: true
end
