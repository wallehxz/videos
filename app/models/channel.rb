#coding: utf-8
# t.string   "title"
# t.text     "description"
# t.string   "english"
# t.string   "cover"
# t.datetime "created_at"
# t.datetime "updated_at"

class Channel < ActiveRecord::Base
	validates_uniqueness_of :title
	validates_presence_of :title, :cover, :english
	has_many :channel_videos, :dependent => :destroy

	def self.admin_account(admin)
		return true if admin = Settings.account
		return false
	end

	#获取七牛的文件列表
	# ChannelVideo.qiniu_list
	def self.qiniu_list(marker = '',prefix= '')
		bucket = 'meteor' #指定空间
		limit = 15
		list_policy = Qiniu::Storage::ListPolicy.new(bucket,limit,prefix)
		list_policy.marker = marker  #加上对象
		code,result,headers = Qiniu::Storage.list(list_policy)
		return result['marker'],result['items']
	end

	#缓存本地文件
	# ChannelVideo.qiniu_cache_file
	def self.qiniu_cache_file(file)
		dir_path = "#{Rails.root}/public/"
		ext = File.extname(file.original_filename).to_s #文件扩展名
		if Settings.img_type.include?(ext)
			file_rename = "img_#{[*'a'..'z',*'0'..'9',*'A'..'Z'].sample(20).join}#{ext}"
		elsif Settings.vcd_type.include?(ext)
			file_rename = "vcd_#{[*'a'..'z',*'0'..'9',*'A'..'Z'].sample(20).join}#{ext}"
		else
			file_rename = "file_#{[*'a'..'z',*'0'..'9',*'A'..'Z'].sample(20).join}#{ext}"
		end
		file_path = "#{dir_path}#{file_rename}"
		File.open(file_path,'wb+') do |item|
			item.write(file.read)
		end
		return file_path, file_rename
	end

	def self.clear_qiniu_cache(file)
		file_path = "#{Rails.root}/public/#{file}"
		if File.exist?(file_path)
			File.delete(file_path)
		end
	end

end
