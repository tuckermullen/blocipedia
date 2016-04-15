class Collaborator < ActiveRecord::Base
  belongs_to :users
  belongs_to :wikis
end
