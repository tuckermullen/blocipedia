class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates :wiki_id, :user_id, presence: true
  validates :wiki_id, uniqueness: { scope: [:wiki_id, :user_id] }
end
