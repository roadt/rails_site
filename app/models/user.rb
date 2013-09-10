class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body
  attr_accessible  :roles


  #
  #
  # Notes, to keep back compatibility, only append role name, doesn't modify
  
  ROLES = [:owner, :admin, :editor, :commenter]
  def self.generate_role_methods 
    ROLES.each_index do|idx|
      role_name = ROLES[idx]
      code = """def #{role_name}?
            self.roles & 2**#{idx} != 0
        end
          def grant_#{role_name}
            self.roles |= 2**#{idx}
            save
          end
          def revoke_#{role_name}
            self.roles &= ~(2**#{idx})
            save
          end
      """
      class_eval code
    end    
  end
  generate_role_methods

  def default?
    roles == 0
  end
end
