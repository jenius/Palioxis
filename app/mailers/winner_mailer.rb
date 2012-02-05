class WinnerMailer < ActionMailer::Base
  default :from => "palioxisapp@gmail.com"

  def winner_proclamation(winner)
    @winner = winner
    mail :to => "escalantejeff@gmail.com", :subject => "This Month's Palioxis Winner"
  end

  def winner_congrats(winner)
    @winner = winner
    mail :to => winner, :subject => "You just won the Palioxis jackpot!"
  end

end
