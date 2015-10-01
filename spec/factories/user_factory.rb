FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }

  factory :user do
    name 'ShadowJack'
    password 'password'
    email { generate(:email) }

    factory :admin_user do
      admin true
    end
  end
end
