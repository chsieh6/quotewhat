class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :confirmable,
  				:rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :pins, :dependent => :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "https://s3.amazonaws.com/travelfig_heroku/images/home/missing.jpg"

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  validates_attachment :avatar, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']}, size: { less_than: 5.megabytes}

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(first_name:auth.extra.raw_info.first_name,
                         last_name:auth.extra.raw_info.last_name,
                         username:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
