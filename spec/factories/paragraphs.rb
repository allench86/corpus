# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paragraph do
    language 1
    content "MyString"
    article_id 1
  end
end
