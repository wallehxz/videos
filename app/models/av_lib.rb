#coding=utf-8
# t.string   "av_title"
# t.string   "av_type"
# t.string   "av_duration"
# t.string   "av_poster"
# t.string   "av_source"
# t.string   "av_introduction"
# t.datetime "created_at"
# t.datetime "updated_at"
class AvLib < ActiveRecord::Base
  validates_presence_of :av_title, :av_type, :av_source
  validates_uniqueness_of :av_poster, :av_source
end
