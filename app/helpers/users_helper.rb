module UsersHelper

  def time_until_due(due)
    if due > Date.today
      if due == Date.tomorrow
        "due tomorrow"
      else
        "due in #{time_ago_in_words(due)}"
      end
    else
      "overdue!"
    end
  end

end
