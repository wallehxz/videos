class Column < ActiveRecord::Base
  validates_presence_of :name, :english, :cover
  validates_uniqueness_of :name, :english, :cover
  scope :latest, -> { order(updated_at: :desc) }

  def self.picture_url(file)
    if file.present?
      return Cattle.cache_to_yun(file)
    else
      return nil
    end
  end
end
