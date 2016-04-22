class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  # validate uniqueness for wiki_id and user_id
end
