class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order('created_at DESC')}
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true

  def owned_by?(owner)
    return false unless owner.is_a?(User)
    user == owner
  end
end
