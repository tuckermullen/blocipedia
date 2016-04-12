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

  def downgrade!
    self.role = 'standard'
    self.save
    if self.role == "standard"
      make_wikis_public
    else
      redirect_to root_path
      flash[:alert] = "There was an error downgrading your account, please try again."
    end
  end

  def make_wikis_public
    wikis.each do |wiki|
      wiki.update_attributes!(private: false)
    end
  end
end
