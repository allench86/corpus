namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Administrator",
                 username: "admin",
                 password: "123qwe",
                 password_confirmation: "123qwe")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      username = "corpus_user_#{n+1}"
      password  = "password"
      User.create!(name: name,
                   username: username,
                   password: password,
                   password_confirmation: password)
    end
  end
end