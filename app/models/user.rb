# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  nick_name              :string
#  avatar                 :string
#  phone                  :string
#  role                   :string           default("looker")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  web_style              :string           default("sidebar-mini wysihtml5-supported skin-blue")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :role_asc, ->{order(role: :asc)}
  scope :role_desc, ->{order(role: :desc)}
  scope :recent, -> {order(created_at: :asc)}
  before_create :set_name

  def can_av?
    return true if self.role =='admin' || self.role == 'fucker' || self.sign_in_count >= 50
  end

  def set_name
    self.nick_name = Comment::Name[rand(Comment::Name.size)]
  end

end
