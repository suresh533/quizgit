class Exam < ActiveRecord::Base
   attr_accessible :email,:score,:question_id,:user_id
  has_many :questions, :through=>:user_answers
  has_many :user_answers
  belongs_to :user
  set_primary_key 'score'
#set_primary_key :email
#set_primary_key :score
  has_one :question_id
end

