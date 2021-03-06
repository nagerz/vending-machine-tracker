require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see the name of all snacks with a price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    snack_1 = Snack.create!(machine_id: dons.id, name: "White Castle Burger", price: 3.5)
    snack_2 = Snack.create(machine_id: dons.id, name: "Pop Rocks", price: 1.5)
    snack_3 = Snack.create(machine_id: dons.id, name: "Flaming Hot Cheetos", price: 2.5)
    snacks = [snack_1, snack_2, snack_3]

    visit machine_path(dons)

    expect(page).to have_content("Snacks:")
    snacks.each do |snack|
      expect(page).to have_content("#{snack.name}: $#{snack.price}")
    end
  end

  scenario 'they see the average price of all snacks' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    Snack.create!(machine_id: dons.id, name: "White Castle Burger", price: 3.5)
    Snack.create(machine_id: dons.id, name: "Pop Rocks", price: 1.5)
    Snack.create(machine_id: dons.id, name: "Flaming Hot Cheetos", price: 2.5)

    visit machine_path(dons)

    expect(page).to have_content("Average price: $2.5")
  end
end
