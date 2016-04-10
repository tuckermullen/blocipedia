class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :assign_role

  def standard?
    role == 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def assign_role
    self.role ||= 'standard'
  end

  def make_wikis_public
    wikis.each.do |wiki|
    if wiki.private == true
      wiki.update_attribute!(private: false)
    end
  end
end
