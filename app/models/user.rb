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
#  location               :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :role_asc, ->{order(role: :asc)}
  scope :role_desc, ->{order(role: :desc)}
  scope :recent, -> {order(updated_at: :desc)}
  before_create :set_name
  before_save :set_location

  def can_av?
    return true if self.role =='admin' || self.role == 'fucker' || self.sign_in_count >= 50
  end

  def set_name
    self.nick_name = Comment::Name[rand(Comment::Name.size)]
  end

  def set_location
    self.location = User.baidu_ip_info(self.current_sign_in_ip.to_s)
  end

  def self.baidu_ip_info(user_ip)
    if user_ip != '127.0.0.1'
      baidu_json = $baidu_api.get do |req|
        req.url '/location/ip'
        req.params['ip'] = user_ip
        req.params['ak'] = '5PELDwT7pnzGDOjTjrV5oGq8'
      end
      body = JSON.parse(baidu_json.body)
      if body['status'] == 0
        return "#{body['content']['address']}"
      else
        return '火星用户'
      end
    else
      return '潘多拉星球'
    end
  end
end
