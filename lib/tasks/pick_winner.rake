desc "Pools members who have made a goal in the last 2 weeks and picks one randomly as the winner"
task :pick_winner => :environment do
  active_users = []
  User.all.each do |usr|
    usr.goals.each do |goal|
      if goal.created_at > 2.weeks.ago && goal.created_at < Time.now
        active_users << usr.id
        puts "#{usr.full_name} is active, created a goal at #{goal.created_at.strftime("%m/%d/%Y")}"
        break
      end
    end
  end
  puts "Active users: #{active_users.inspect}"
end