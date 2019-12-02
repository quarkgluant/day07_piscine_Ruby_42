class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, presence: true, on: :create
  validates :email, presence: true, on: :create

  def admin?
    name.casecmp 'admin' || role == 'admin'
  end
end
