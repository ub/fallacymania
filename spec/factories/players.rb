# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    user nil
    nick "MyString"
    score 1
    game nil
  end
end
