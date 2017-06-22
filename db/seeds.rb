# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mtl_unit = Unit.where(ad_name: "Montreal Beauty").first_or_create(ad_name: "Montreal Beauty", tax_percent: 0.20)
sfo_unit = Unit.where(ad_name: "San Francisco Special").first_or_create(ad_name: "San Francisco Special", tax_percent: 0.19)

Date.current.upto(10.days.from_now.to_date) do |date|
  DayPrice.create(unit: mtl_unit, date: date, price: (100 + 20*rand).round(2))
  DayPrice.create(unit: sfo_unit, date: date, price: (200 + 20*rand).round(2))
end

user1 = User.where(name: "Mark").first_or_create(name: "Mark", email: "farp@farpo.net", phone_number: "555 555-5555")
user2 = User.where(name: "Mark2").first_or_create(name: "Mark2", email: "farp2@farpo.net", phone_number: "555 555-5555")
user3 = User.where(name: "Mark3").first_or_create(name: "Mark3", email: "farp3@farpo.net", phone_number: "555 555-5555")
user4 = User.where(name: "Mark4").first_or_create(name: "Mark4", email: "farp4@farpo.net", phone_number: "555 555-5555")

Inquiry.create(user: user1, start_date: Date.new(2017, 6, 20), end_date: Date.new(2017, 6, 22), unit: mtl_unit)
Inquiry.create(user: user1, start_date: Date.new(2017, 6, 22), end_date: Date.new(2017, 6, 28), unit: sfo_unit)
Inquiry.create(user: user2, start_date: Date.new(2017, 6, 20), end_date: Date.new(2017, 6, 22), unit: sfo_unit)
Inquiry.create(user: user3, start_date: Date.new(2017, 6, 22), end_date: Date.new(2017, 6, 24), unit: mtl_unit)
Inquiry.create(user: user4, start_date: Date.new(2017, 6, 24), end_date: Date.new(2017, 6, 27), unit: mtl_unit)
