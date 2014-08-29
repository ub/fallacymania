FactoryGirl.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "secret"

    # three fixed users for various scenarios
    factory :alice do
      email "alice@example.com"
      name "Alice"
    end
    factory :bob do
      email "bob@example.com"
      name "Bob"
    end
    factory :clare do
      email "clare@example.com"
      name "Clare"
    end
  end
end
