class Machine < ApplicationRecord
  validates_presence_of :location

  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  def average_price
    @snacks = Snack.where(machine_id: id)
    @snacks.sum(&:price) / @snacks.count
  end

end
