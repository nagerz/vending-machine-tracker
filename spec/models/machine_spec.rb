require 'rails_helper'

describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through :machine_snacks }
  end

  describe 'instance methods' do
    it 'can calculate average snack price' do
      owner = Owner.create(name: "Sam's Snacks")
      dons  = owner.machines.create(location: "Don's Mixed Drinks")

      Snack.create!(machine_id: dons.id, name: "White Castle Burger", price: 3.5)
      Snack.create(machine_id: dons.id, name: "Pop Rocks", price: 1.5)
      Snack.create(machine_id: dons.id, name: "Flaming Hot Cheetos", price: 2.5)

      expect(dons.average_price). to eq(2.5)
    end
  end

end
