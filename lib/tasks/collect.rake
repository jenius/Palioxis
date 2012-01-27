desc "Charges everyone the amount they specified if they fail their goals"
task :collect => :environment do
  puts "Finding failed goals"
end

# Charge Policy

  # You might ask yourself, where does my money go if I fail? To a good cause, perhaps? To a charity at least? 
  # NO. If your money went to a good cause, you would feel good about yourself after failing your goals, which
  # is the exact opposite of our intention here. Here's what happens with the money:

  # Each week, anyone who failed their goals is charged, and the money is pooled together. ~10% comes off the
  # top for transaction fees I have to pay in order to get all of the transactions processed and server 
  # costs/maintanance (this is subject to go up or down based on what I'm paying for hosting to keep the site 
  # running smoothly for everyone). I'm not making money off this (at least for now, it's pretty low maintenance). 
  # After this, all users that have been active in making goals for themselves in the last 2 weeks are pooled 
  # together and one person is randomly selected to recieve all of the money. This person will be emailed (so
  # you'd better enter a valid emai, or I'M KEEPING IT ALL BUAHAHA), and have their choice of transfer methods.

  # So your money could be going to someone who needs it or sponsoring a $10,000 crack party. Overall, I would 
  # conclude that it's more or less a bad cause, and that you are just giving your money away for free, something
  # most people don't want to do. At the same time, by being active and pushing yourself to achieve your goals, 
  # you do get a small reward - a free lottery ticket and a chance to win a bunch of cash as a reward for going 
  # after your dreams, hard.