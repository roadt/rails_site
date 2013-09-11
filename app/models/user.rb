class User < ActiveRecord::Base
  
  has_many :comments, :foreign_key => :owner_id, :dependent=>:destroy
  has_many :posts, :foreign_key => :owner_id, :dependent=>:destroy

  #-------------- Devise ---------------------------------
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # attr_accessible :title, :body
   attr_accessible :email, :password, :password_confirmation, :remember_me,:roles



  #-----------------  Role Based ACL --------------------------------
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
            self
          end
          def revoke_#{role_name}
            self.roles &= ~(2**#{idx})
            self
          end
      """
      class_eval code
    end    
  end
  generate_role_methods

  def default?
    roles == 0
  end

  # the created/formal user can comment by default
  before_save :set_default_roles
  def set_default_roles
    grant_commenter
  end
end
