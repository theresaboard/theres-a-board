namespace :app_setup do
  desc "Setup roles"
  task :buildroles => :environment do
    student_role = Role.create(name: "Student")
    mentor_role = Role.create(name: "Mentor")

    User.all.each do |student| 
      student.roles << student_role
    end
  end
end