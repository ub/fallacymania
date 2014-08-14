# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    description "MyString"
    status "OPEN"
    game_master nil
  end
end
