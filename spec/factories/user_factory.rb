FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }
  sequence(:name) {|n| "user#{n}" }

  factory :user do
    name { generate(:name) }
    password 'password'
    email { generate(:email) }

    factory :admin_user do
      admin true
    end
  end
end
