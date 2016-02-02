module API
  module V1
    class User < ActiveRecord::Base
      before_save   :downcase_email
      validates :name,  presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
      validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
      has_secure_password
      validates :password, presence: true, length: { minimum: 6 }, allow_nil: false
      before_create :api_token_generator
      # Returns the hash digest of the given string.
      def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      # Returns a random token.
      def User.new_token
        SecureRandom.urlsafe_base64
      end


      # Forgets a user.
      def forget
        update_attribute(:api_token, nil)
      end

      private
        # Converts email to all lower-case.
        def downcase_email
          self.email = email.downcase
        end

        #log ip address
        def log_ip_address
          self.ip_address = request.ip
        end

        #api token
        def api_token_generator
        begin
          self.api_token = User.new_token
        end while User.exists?(api_token: api_token)
      end

    end
  end
end