# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.create!(bio: FFaker::HipsterIpsum.paragraph,
#              name: 'admin',
#              email:'admin@gmail.com',
#              password:'password',
#              password_confirmation: 'password')

# User.create!(bio: FFaker::HipsterIpsum.paragraph,
#              name: 'moi',
#              email:'pat@localhost',
#              password:'12345678',
#              password_confirmation: '12345678')
price = [1.29, 4.00, 5.25, 7.75, 9.99, 10.00, 25.5, 49.99, 66.66, 74.99, 99.99]
5.times do |tm|
  mk = Brand.create!(name: FFaker::Product.brand,
                     avatar: open(FFaker::Avatar.image))

  10.times do |tw|
    Product.create!(name: FFaker::Product.product,
                    pict: open(FFaker::Avatar.image),
                    description: FFaker::HipsterIpsum.paragraph,
                    brand_id: mk.id, price: price.sample)
  end
end