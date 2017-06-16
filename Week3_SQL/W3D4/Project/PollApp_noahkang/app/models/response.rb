# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_choice_id

  has_many :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_one :question, through: :answer_choice
end

def sibling_responses
  self.question.responses.where.not(id: self.id)
end

def respondent_already_answered?
  sibling_responses.where(user_id: self.user_id).exists?
end

private

def not_duplicate_response
  if respondent_already_answered?
    errors[:base] << "Can't respond twice."
  end
end
