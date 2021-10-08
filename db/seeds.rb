# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             user_area: 1,
             user_job: 4,
             school_year: 3,
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               user_area: 1,
               user_job: 4,
               school_year: 3,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  end
  
Label.create!(
  [
    {
      name: '学級経営'
    },
    {
      name: '国語'
    },
    {
      name: '算数'
    },
    {
      name: '理科'
    },
    {
      name: '社会'
    },
    {
      name: '外国語'
    },
    {
      name: '音楽'
    },
    {
      name: '図工'
    },
    {
      name: '体育'
    },
    {
      name: '道徳'
    }
  ]
)
