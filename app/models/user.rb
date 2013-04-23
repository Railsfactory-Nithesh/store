  require 'digest/sha2'
  class User < ActiveRecord::Base
    attr_accessor :password_confirmation,:commit_type
    attr_reader :password
    attr_accessible :hashed_password, :salt, :username,:password,:password_confirmation, :is_admin, :commit_type, :email_id, :uid, :provider, :token
    validates :username, :presence => true, :uniqueness => true
    validates_length_of :username, :maximum => 30
    validates :password, :presence => true, :if => Proc.new{|f|  f.commit_type != 'Update User' }
    validates :password_confirmation , :presence => true , :if => Proc.new{|f|  f.commit_type != 'Update User' }
    validates :email_id, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
   validate :password_must_be_present
   has_many :authentications, :dependent => :delete_all
  before_create { generate_token(:auth_token) }
  
def apply_omniauth(auth)

  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  self.email_id = auth['extra']['raw_info']['email']
  self.username = auth['extra']['raw_info']['username']
  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
end
    

    class << self
      def authenticate(name, password)
          if user = find_by_username(name)
          if user.hashed_password == encrypt_password(password, user.salt)
          user
          end
        end
      end
      def encrypt_password(password, salt)
        Digest::SHA2.hexdigest(password + "wibble" + salt)
      end
    end
    # 'password' is a virtual attribute
      def password=(password)
        @password = password
          if password.present?
          generate_salt
          self.hashed_password = self.class.encrypt_password(password, salt)
        end
      end
      
      
      def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end
      
      private
      def password_must_be_present
        errors.add(:password, "Missing password" ) unless hashed_password.present?
      end
      def generate_salt
        self.salt = self.object_id.to_s + rand.to_s
      end
      


def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end
end