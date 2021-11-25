# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# メインのサンプルユーザーを1人作成する
User.create!(name:  "校長（管理者）",
            email: "example@rails.org",
            user_area: 11,
            user_job: 1,
            school_year: 9,
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name:  "だいち＠体育主任",
            email: "e5khtamcx@test.com",
            user_area: 11,
            user_job: 4,
            school_year: 5,
            password:              "foobar",
            password_confirmation: "foobar",
            profile: "ご覧いただきありがとうございます！5年間越谷市で教員を務め、体育主任を3年間経験しました。
                      学校の働き方が改善されるようなアイデアなどを発信していきたいです！",
            activated: true,
            activated_at: Time.zone.now)  
             

User.create!(name:  "宮澤ゆうい教育研究所",
            email: "hogehoge@example.com",
            user_area: 20,
            user_job: nil,
            school_year: 6,
            avatar: File.open("#{Rails.root}/public/seedimg/miyazawa_icon.jpg"),
            password:              "foobar",
            password_confirmation: "foobar",
            profile: "一人でも多くの子どもや先生が笑顔になりますように。これは、そのためのチャンネルです",
            activated: true,
            activated_at: Time.zone.now,
            )  
            
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
Year.create!(
  [
    {
      year_number: '小１'
    },
    {
      year_number: '小２'
    },
    {
      year_number: '小３'
    },
    {
      year_number: '小４'
    },
    {
      year_number: '小５'
    },
    {
      year_number: '小６'
    },
    {
      year_number: '中１'
    },
    {
      year_number: '中２'
    },
    {
      year_number: '中３'
    },
  ]
)
# 追加のユーザーをまとめて生成する
30.times do |n|
    area_num = rand(1..47)
    job_num = rand(1..8)
    email = "example-#{n+1}@ideabox.com"
    second_name_a = "教員#{rand(1..15)}年目"
    second_name_b = "＠#{Label.find("#{rand(1..9)}").name}主任"
    User.create!(name:  Gimei.first.hiragana + "#{second_name_b}",
                email: email,
                user_area: area_num,
                user_job: job_num,
                school_year: "#{rand(1..9)}",
                password:              "foobar",
                password_confirmation: "foobar",
                profile: "はじめまして！ #{User.user_areas.key area_num}で
                          教員をしております。今年度で#{second_name_a}です！
                          いろんな先生たちと繋がりたいです！よろしくお願いします！",
                activated: true,
                activated_at: Time.zone.now,
                )
    end
  


Topic.create!(
    id: 1,
    user_id: 15,
    description: "「漢字の花」\n従来の漢字ゲームや漢字クイズは、漢字が得意な生徒は楽しめますが、漢字が苦手な生徒は、どうしてもお客さんになりがちです。それは、答えが１つか有限であることが原因ではないでしょうか。。
                　そこで考えたのが、限られた答えを見つけるのではなく、教師も思いつかないところまで、みんなの力で探究の輪を広げていく、拡散型漢字ゲーム「漢字の花火」と「漢字の池」です。
                　生徒がチョークをリレーして、題に合う漢字を一文字ずつ書いていくゲームですが、どんどん可能性が広がるので、楽しく探究心と発想が喚起されます。
                　学力に関わらず参加でき、ある程度漢字を覚えた小学校高学年以上なら、中学校、高校、どの学校種でも活用できます。２人から1クラスまで、いろいろな人数で実施が可能です。",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/1/large.jpg")],
                      #プロジェクトの親フォルダ
  )
  
  Labelling.create(topic_id: 1, label_id: 2) 
  
  
  Topic.create!(
    id: 2,
    user_id: 23,
    description: "[白熱！かけ算リレー！]\n学年末の算数オリンピックをしています。かけ算九九の復習として、かけ算リレーをしました。学習したことが、しっかり定着しています！",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/2/EwQpCcrVkAEQDpn.jpg"), 
            File.open("#{Rails.root}/public/seedimg/2/EwQpCcsVoAExwo_.jpg"), 
            File.open("#{Rails.root}/public/seedimg/2/EwQpCcuVIAISNTq.jpg")],
                      #プロジェクトの親フォルダ
  )
  
  Labelling.create(topic_id: 2, label_id: 3) 
  Yearing.create(topic_id: 2, year_id: 2)    
  
  Topic.create!(
    id: 3,
    user_id: 12,
    description: "【教師の働き方改革】宿題チェックはバーコードで瞬殺！そして、何より子どもたちが喜んで「ピッ」と宿題を提出するようになります。
                  このページにて、詳しい機能や使い方を説明しています。誰でも使えるように無料で公開しているので、もし良かったら使って下さい！＼(^o^)／
                  http://shakainomado.blog.jp/archives/34385970.html",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/syukudai (1).jpg")],
                      #プロジェクトの親フォルダ
  )
  
  Labelling.create(topic_id: 3, label_id: 1)
  
  Topic.create!(
    id: 4,
    user_id: 2,
    description: "【体育主任お助けグッズ】トラックのレーンやボール投げのゾーンをラインで引くのはめんどくさい
                  そんなときに、このトンボが活躍します！１ｍ間隔に釘を打ってあるので、ライン引きがグッと楽になりますよ！",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/tombo1.jpeg"), File.open("#{Rails.root}/public/seedimg/tombo2.jpeg")],
                      #プロジェクトの親フォルダ
  )
  
  Topic.create!(
    id: 5,
    user_id: 2,
    description: "【コインゲットジャンプ】2年生のゴム跳び遊びの場の1つです！走り幅跳びにつながる動きで、目線が自然と上がり、腕を振って力強く踏み切る
                  力を身につけることができます。子どもにとってなじみのあるゲームが授業に出てくると子どもたちの目はキラキラしますね！
                  添付ファイルは簡易ですが授業の計画書になっていますので参考にしてみてください。",
    docment: File.open("#{Rails.root}/public/seeddocment/体ほぐしの運動・跳の運動遊び.docx"),
    images: [File.open("#{Rails.root}/public/seedimg/IMG_8794.mp4"), File.open("#{Rails.root}/public/seedimg/coin_jump.jpeg"), File.open("#{Rails.root}/public/seedimg/coin_jump_2.jpeg")],
                      #プロジェクトの親フォルダ
  )
  Labelling.create(topic_id: 5, label_id: 9) 
  
  Yearing.create(topic_id: 5, year_id: 2)    
  
  Topic.create!(
    id: 6,
    user_id: 3,
    description: "現在１０年目のまだまだ若手教師の宮澤悠維と申します。2020年1月1日、現役教師としてyoutuberデビューしました。不登校や学級崩壊で苦しむ子どもや先生を多く見る中で、自分に何かできることはないのかと考えた結果、自分のこれまでの経験を少しでも全体に還元することができると思いました。よければ一度動画を御覧ください。活動に賛同していただける方がおられましたら、チャンネル登録をしてくださるとうれしいです！よろしくお願いします！！
                  https://www.youtube.com/channel/UCQtT1dKhGTWIXN_kyB4hhVw?view_as=subscriber",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/miyazawa.jpg")],
                      #プロジェクトの親フォルダ
  )
  
  Labelling.create(topic_id: 6, label_id: 1) 
  
  Topic.create!(
    id: 7,
    user_id: 2,
    description: "【2年道徳オリエンテーション】学級がスタートして間もない4月にいきなり道徳の授業をしても子どもは発言しません。
                  まずは手を挙げやすい雰囲気をつくるために道徳に対するイメージをもってもらうために、こんな資料をつくってみました。
                  これをやるかやらないかで大きく違うと思います。よかったら参考にしてください！",
    docment: File.open("#{Rails.root}/public/seeddocment/2年道徳　オリエンテーション.pptx"),
    images: nil,
                      #プロジェクトの親フォルダ
  )
  
  Topic.create!(
    id: 8,
    user_id: 4,
    description: "【クラスの成長の「見える可」】私は教室の壁面にその学級のあゆみを掲示しています！そのクラスで企画したイベント、
                  活躍した行事など、貼り溜めていくと子どもたちの思い出にも残りますよ！ちなみにこの掲示最後はどうするかって？
                  ビンゴ大会を開いて上がった人から選んで持ち帰ります。掲示物争奪戦！で、何もなくなった教室を見て子どもたちは
                  「いよいよお別れだな」と実感します。",
    docment: nil,
    images: [File.open("#{Rails.root}/public/seedimg/IMG_7980.jpeg")],
                      #プロジェクトの親フォルダ
  )
  Labelling.create(topic_id: 8, label_id: 1)
  
  Topic.create!(
    id: 9,
    user_id: 2,
    description: "【2年生ボール蹴り遊び】サッカーにつながる2年生のボールゲーム。パスをつないでシュート
                  することに重きを置いてゲームを考えました。動画でも分かるように、ディフェンスの動ける範囲を制限することで
                  「ボールを持たないときにパスをもらえる位置に動く」という動きが現れています。",
    docment:  File.open("#{Rails.root}/public/seeddocment/ボール蹴りゲームについて.docx"),
    images: [File.open("#{Rails.root}/public/seedimg/IMG_8879.mp4")],
                      #プロジェクトの親フォルダ
  )
  Labelling.create(topic_id: 9, label_id: 9)
  
  Yearing.create(topic_id: 9, year_id: 2) 
  
  Topic.create!(
    id: 10,
    user_id: 6,
    description: "「『鳥獣戯画』を読む」第2～3時。説明文の学習では、二瓶先生の説明文の家を作る活動を毎回必ず行っている。かなり自分の力でできるようになってきた。",
    docment:  nil,
    images: [File.open("#{Rails.root}/public/seedimg/tyojuugiga.jpeg")],
                      #プロジェクトの親フォルダ
  )
  Labelling.create(topic_id: 10, label_id: 2)
  
  Yearing.create(topic_id: 10, year_id: 6) 
 
  
   
  
  
  
