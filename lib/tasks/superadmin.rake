namespace :superadmin do
  desc "Make a user a superadmin by email"
  task :make, [ :email ] => :environment do |t, args|
    unless args[:email]
      puts "Please provide an email: rake superadmin:make[user@example.com]"
      exit 1
    end

    user = User.find_by(email: args[:email])

    if user.nil?
      puts "User with email '#{args[:email]}' not found"
      exit 1
    end

    if user.superadmin?
      puts "User '#{args[:email]}' is already a superadmin"
    else
      user.make_superadmin!
      puts "User '#{args[:email]}' has been made a superadmin"
    end
  end

  desc "Remove superadmin role from a user by email"
  task :unmake, [ :email ] => :environment do |t, args|
    unless args[:email]
      puts "Please provide an email: rake superadmin:unmake[user@example.com]"
      exit 1
    end

    user = User.find_by(email: args[:email])

    if user.nil?
      puts "User with email '#{args[:email]}' not found"
      exit 1
    end

    if user.superadmin?
      user.remove_superadmin!
      puts "Superadmin role removed from user '#{args[:email]}'"
    else
      puts "User '#{args[:email]}' is not a superadmin"
    end
  end

  desc "List all superadmins"
  task list: :environment do
    superadmins = User.joins(:roles).where(roles: { name: Role::SUPERADMIN })

    if superadmins.any?
      puts "Superadmins:"
      superadmins.each do |user|
        puts "  - #{user.email} (#{user.name})"
      end
    else
      puts "No superadmins found"
    end
  end
end
