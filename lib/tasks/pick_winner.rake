desc "Pools members who have made a goal in the last 2 weeks and picks one randomly as the winner"
task :pick_winner => :environment do
  active_users = []

  # go through each user's goals until (or if) we find one made in the last 2 weeks
  # if we do, add this user to the pool of active users.
  User.all.each do |usr|
    usr.goals.each do |goal|
      if goal.created_at > 2.weeks.ago && goal.created_at < Time.now
        active_users << usr.email
        puts "#{usr.full_name} (#{usr.email}) is active, created a goal at #{goal.created_at.strftime("%m/%d/%Y")}"
        break
      end
    end
  end

  # the list of emails from users that have been active in the last 2 weeks
  puts "Active users: #{active_users.inspect}"

  # roll the dice
  lottery_number = rand(active_users.length)

  # pick the lucky winner and email it to me
  winner = active_users[lottery_number]
  puts "Aaaand the winner is... #{winner}!!!"
  WinnerMailer.winner_proclamation(winner).deliver
end