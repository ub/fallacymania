class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]

  def  password_required?
    false
  end

  def self.from_omniauth(auth_hash)
    if user = User.find_by_email(auth_hash.info.email)
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user
    else
      where(auth_hash.slice(:provider, :uid)).first_or_create do |user| #BUG does not validates
        user.provider = auth_hash.provider
        user.uid = auth_hash.uid
        user.name = auth_hash.info.name
        user.email = auth_hash.info.email
        user.avatar = auth_hash.info.image
      end
    end
  end
end
