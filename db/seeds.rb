# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Size.destroy_all

Size.create([
  {icon: 'desktop', height: 800, width: 1500, slug: 'desktop', primary: true,
   display: 'Desktop (1500x800)'},
   {icon: 'laptop', height: 800, width: 1200, slug: 'laptop', primary: true,
   display: 'Laptop (1200x800)'},
   {icon: 'tablet', height: 1200, width: 1000, slug: 'tablet', primary: true,
   display: 'Tablet (1000x1200)'},
   {icon: 'mobile', height: 800, width: 400, slug: 'mobile', primary: true,
   display: 'Mobile (400x800)'},
   {icon: 'tablet rotate-90', height: 1000, width: 1200, slug: 'tablet-horizontal', primary: false,
   display: 'Mobile (1200x1000)'},
  ])
