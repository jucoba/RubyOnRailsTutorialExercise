# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  churchname :string(255)
#

class User < ActiveRecord::Base
  mail_reg_exp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  :presence => true, 
                    :length => { :maximum => 60 }
  validates :email, :presence => true,
                    :format => { :with => mail_reg_exp },
                    :uniqueness => { :case_sensitive => false }
  validates :churchname, :presence => true
end