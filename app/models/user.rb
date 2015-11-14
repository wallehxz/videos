#coding: utf-8
#   t.string   "email",                  default: "", null: false
#   t.string   "encrypted_password",     default: "", null: false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          default: 0,  null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.inet     "current_sign_in_ip"
#   t.inet     "last_sign_in_ip"
#   t.datetime "created_at"
#   t.datetime "updated_at"
#   t.integer "level"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :video_comments, dependent: :destroy
  has_one :user_detail, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :set_user_detail

  protected
    def set_user_detail
      self.build_user_detail
    end
end
