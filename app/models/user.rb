class User < ActiveRecord::Base
	has_many :goals
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :username, :goals, :stripe_token

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
  	"#{first_name} #{last_name}"
  end

  def save_card
    if valid?
      customer = Stripe::Customer.create(:description => "#{first_name} #{last_name}, #{email}", :email => email, :card => stripe_token)
      self.stripe_token = customer.id
      save!
    end
    
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

end
