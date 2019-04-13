FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password' }
  end

  factory :admin_user, class: User do
    name { '管理者ユーザー' }
    email { 'admim@example.com' }
    password { 'passwordAdmin' }
    admin { true }
  end
end