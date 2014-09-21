class User < ActiveRecord::Base;
  include Sluggable
  has_many :posts
  has_many :comments
  has_many :votes
  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length:{minimum:5}
  sluggable_column :username

  def admin?
    self.role =='admin'
  end

  def moderator?
    self.role = 'moderator?'
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def send_pin_to_twilio
    account_sid = 'ACa1917872284d8a814d58546e313e28f5'
    auth_token =  'b820abd8c23fc3e28da46e07b28c8e51'

    client = Twilio::REST::Client.new(account_sid, auth_token)
    account = client.account

    msg = "Hi, please input pin to continue login #{self.pin}"

    client.account.messages.create({
                                       :from => '+14696063492',
                                       :to => '1111111111',
                                       :body => msg ,
                                   })
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end
end