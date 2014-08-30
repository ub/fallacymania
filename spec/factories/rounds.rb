# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :round do
    ordinal 1
    game ""
    workflow_state "MyString"
  end
end
