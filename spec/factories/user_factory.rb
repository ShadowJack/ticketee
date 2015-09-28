FactoryGirl.define do
  factory :user do
    name "ShadowJack"
    email 'kostyap@hotmail.ru'
    password "password"

    factory :admin_user do
      admin true
    end
  end
end
