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

  def add_new_card(token)
    if valid?
      customer = Stripe::Customer.create(:description => "#{first_name} #{last_name}, #{email}", :email => email, :card => token)
      self.stripe_token = customer.id
      save!
    end
    
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

  def edit_card(token)
    customer = Stripe::Customer.retrieve(self.stripe_token)
    customer.card = token
    customer.save ? true : false
  end

  def charge_card(amount)
    create_stripe_charge(amount)
  end

  private

    def create_stripe_charge(amount)
      Stripe::Charge.create(
        :amount => amount.to_i,
        :currency => "usd",
        :customer => Stripe::Customer.retrieve(stripe_token),
        :description => "Donation from #{email}"
      )
    end

end
