class User < ActiveRecord::Base
  #attr_accessor :name, :email, :churchname 

  mail_reg_exp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  :presence => true, 
                    :length => { :maximum => 60 }
  validates :email, :presence => true,
                    :format => { :with => mail_reg_exp },
                    :uniqueness => { :case_sensitive => false }
  validates :churchname, :presence => true

end
