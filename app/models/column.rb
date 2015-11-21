# == Schema Information
#
# Table name: columns
#
#  id         :integer          not null, primary key
#  name       :string
#  english    :string
#  cover      :string
#  summary    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Column < ActiveRecord::Base
  validates_presence_of :name, :english, :icon
  validates_uniqueness_of :name, :english
  has_many :videos, :dependent => :destroy
  scope :latest, -> { order(updated_at: :desc) }

  def self.picture_url(file)
    if file.present?
      return Cattle.cache_to_yun(file)
    else
      return nil
    end
  end
end
