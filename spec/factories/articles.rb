# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    doc_id "MyString"
    speech_id "MyString"
    speech_title "MyString"
    speaker "MyString"
    gender "MyString"
    title_of_speaker "MyString"
    date "2013-08-10"
    event "MyString"
    topic "MyString"
    word_count 1
    difficulty_level "MyString"
    text_features "MyString"
    chinese_paragraph_num 1
    english_paragraph_num 1
    last_editor_id 1
  end
end
