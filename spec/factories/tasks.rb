FactoryBot.define do
  factory :task do
    name { 'Specを書く' }
    description { 'RSpec, Capybara, FactoryBotを使ってテストを作成する' }
    user
  end

  factory :admin_task do
    name { 'ユーザーを作る' }
    description { '新規にユーザーを登録する' }
    association :user, factory: :admin_user
  end
end