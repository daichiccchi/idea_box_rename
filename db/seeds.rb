# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# メインのサンプルユーザーを1人作成する
# User.create!(name:  "校長",
#             email: "example@rails.org",
#             user_area: 11,
#             user_job: 1,
#             school_year: nil,
#             password:              "foobar",
#             password_confirmation: "foobar",
#             admin: true,
#             activated: true,
#             activated_at: Time.zone.now)

# User.create!(name:  "だいち＠体育主任",
#             email: "e5khtamcx@test.com",
#             user_area: 11,
#             user_job: 4,
#             school_year: 5,
#             password:              "foobar",
#             password_confirmation: "foobar",
#             profile: "ご覧いただきありがとうございます！5年間越谷市で教員を務め、体育主任を3年間経験しました。
#                       学校の働き方が改善されるようなアイデアなどを発信していきたいです！",
#             activated: true,
#             activated_at: Time.zone.now)  
             

# # 追加のユーザーをまとめて生成する
# 30.times do |n|
#    area_num = rand(1..47)
#    job_num = rand(1..8)
#    email = "example-#{n+1}@ideabox.com"
#    second_name_a = "教員#{rand(1..15)}年目"
#    second_name_b = "＠#{Label.find("#{rand(2..10)}").name}主任"
#    User.create!(name:  Gimei.first.hiragana + "#{second_name_b}",
#                email: email,
#                user_area: area_num,
#                user_job: job_num,
#                school_year: "#{rand(1..9)}",
#                password:              "foobar",
#                password_confirmation: "foobar",
#                profile: "はじめまして！ #{User.user_areas.key area_num}で
#                          教員をしております。今年度で#{second_name_a}です！
#                          いろんな先生たちと繋がりたいです！よろしくお願いします！",
#                activated: true,
#                activated_at: Time.zone.now,
#                )
#    end
  
# Label.create!(
#   [
#     {
#       name: '学級経営'
#     },
#     {
#       name: '国語'
#     },
#     {
#       name: '算数'
#     },
#     {
#       name: '理科'
#     },
#     {
#       name: '社会'
#     },
#     {
#       name: '外国語'
#     },
#     {
#       name: '音楽'
#     },
#     {
#       name: '図工'
#     },
#     {
#       name: '体育'
#     },
#     {
#       name: '道徳'
#     }
#   ]
# )

# Year.create!(
#   [
#     {
#       year_number: '小１'
#     },
#     {
#       year_number: '小２'
#     },
#     {
#       year_number: '小３'
#     },
#     {
#       year_number: '小４'
#     },
#     {
#       year_number: '小５'
#     },
#     {
#       year_number: '小６'
#     },
#     {
#       year_number: '中１'
#     },
#     {
#       year_number: '中２'
#     },
#     {
#       year_number: '中３'
#     },
#   ]
# )

# Topic.create!(
#     id: 1,
#     user_id: 15,
#     description: "「漢字の花」\n従来の漢字ゲームや漢字クイズは、漢字が得意な生徒は楽しめますが、漢字が苦手な生徒は、どうしてもお客さんになりがちです。それは、答えが１つか有限であることが原因ではないでしょうか。。
#                 　そこで考えたのが、限られた答えを見つけるのではなく、教師も思いつかないところまで、みんなの力で探究の輪を広げていく、拡散型漢字ゲーム「漢字の花火」と「漢字の池」です。
#                 　生徒がチョークをリレーして、題に合う漢字を一文字ずつ書いていくゲームですが、どんどん可能性が広がるので、楽しく探究心と発想が喚起されます。
#                 　学力に関わらず参加でき、ある程度漢字を覚えた小学校高学年以上なら、中学校、高校、どの学校種でも活用できます。２人から1クラスまで、いろいろな人数で実施が可能です。",
#     docment: nil,
#     images: [File.open("#{Rails.root}/public/seedimg/1/large.jpg")],
#                       #プロジェクトの親フォルダ
#   )
#   Labelling.create(topic_id: 1, label_id: 2) 
  
  
#   Topic.create!(
#     id: 2,
#     user_id: 23,
#     description: "[白熱！かけ算リレー！]\n学年末の算数オリンピックをしています。かけ算九九の復習として、かけ算リレーをしました。学習したことが、しっかり定着しています！",
#     docment: nil,
#     images: [File.open("#{Rails.root}/public/seedimg/2/EwQpCcrVkAEQDpn.jpg"), 
#             File.open("#{Rails.root}/public/seedimg/2/EwQpCcsVoAExwo_.jpg"), 
#             File.open("#{Rails.root}/public/seedimg/2/EwQpCcuVIAISNTq.jpg")],
#                       #プロジェクトの親フォルダ
#   )
  
#   Labelling.create(topic_id: 2, label_id: 3) 
#   Yearing.create(topic_id: 2, year_id: 2)    
  
  # Topic.create!(
  #   id: 3,
  #   user_id: 12,
  #   description: "【教師の働き方改革】宿題チェックはバーコードで瞬殺！そして、何より子どもたちが喜んで「ピッ」と宿題を提出するようになります。
  #                 このページにて、詳しい機能や使い方を説明しています。誰でも使えるように無料で公開しているので、もし良かったら使って下さい！＼(^o^)／
  #                 http://shakainomado.blog.jp/archives/34385970.html",
  #   docment: nil,
  #   images: [File.open("#{Rails.root}/public/seedimg/syukudai (1).jpg")],
  #                     #プロジェクトの親フォルダ
  # )
  
  # Labelling.create(topic_id: 3, label_id: 1)
  
  Topic.create!(
    id: 4,
    user_id: 2,
    description: "【体育主任お助けグッズ】トラックのレーンやボール投げのゾーンをラインで引くのはめんどくさい
                  そんなときに、このトンボが活躍します！１ｍ間隔に釘を打ってあるので、ライン引きがグッと楽になりますよ！",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/tombo1.jpeg"), File.open("#{Rails.root}/public/seedimg/tombo2.jpeg")],
                      #プロジェクトの親フォルダ
  )
  
  # Labelling.create(topic_id: 2, label_id: 2) 
  
  # Yearing.create(topic_id: 2, year_id: 2)    
