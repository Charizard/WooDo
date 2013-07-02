FactoryGirl.define do
    factory :user do
        name "Yuvaraja"
        sequence(:email){|n| "user#{n}@gmail.com"}
        password "foobar"
        password_confirmation "foobar"
    end
    factory :list do
        sequence(:title){|n| "title#{n}"}
    end

    factory :task do
        content "Sample content"
        list_id nil
        order_number nil
    end
end
