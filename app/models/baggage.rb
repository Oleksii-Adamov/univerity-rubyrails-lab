class Baggage < ApplicationRecord
  validates :num, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :weight, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
