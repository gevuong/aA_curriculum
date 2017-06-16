# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :authored_polls,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :author_id

  has_many :responses,
    class_name: :Response,
    primary_key: :id,
    foreign_key: :user_id
end
