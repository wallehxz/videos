require 'qiniu'
class Cattle < ActiveRecord::Base

  #获取七牛服务文件列表
  def self.files_list(prefix= '',marker = '')
    bucket = 'meteor' #指定空间
    limit = 15
    list_policy = Qiniu::Storage::ListPolicy.new(bucket,limit,prefix)
    list_policy.marker = marker  #加上对象
    code,result,headers = Qiniu::Storage.list(list_policy)
    return result['marker'],result['items']
  end

  #将文件缓存到本地磁盘，生成新的名称和地址
  def self.local_cache_file(file)
    dir_path = "#{Rails.root}/public/uploads" #软链文件 授权 chmod -R 777 uploads
    FileUtils.mkdir(dir_path) unless File.exist?(dir_path) #如果目录不存在,创建目录
    ext = File.extname(file.original_filename).to_s #文件扩展名.xxx
    file_name = rename_ext_file(ext)
    file_path = "#{dir_path}/#{file_name}"
    File.open(file_path,'wb+') do |item|
      item.write(file.read)
    end
    return file_name,file_path
  end

  def self.file_to_info(key)
    code, result, response_headers = Qiniu::Storage.stat('meteor', key)
    return result
  end

  #根据文件扩展名不同生成相应的名称
  def self.rename_ext_file(ext)
    if Settings.img_type.include?(ext)
      rename = "img_#{rand_string_name 20}#{ext}"
    elsif Settings.vcd_type.include?(ext)
      rename = "vcd_#{rand_string_name 20}#{ext}"
    else
      rename = "file_#{rand_string_name 20}#{ext}"
    end
    return rename
  end

  #随机生成字符串
  def self.rand_string_name(num)
    return [*'a'..'z',*'0'..'9',*'A'..'Z'].sample(num).join
  end

  #删除本地缓存文件
  def self.delete_local_cache(file)
    file_path = "#{Rails.root}/public/uploads/#{file}"
    if File.exist?(file_path)
      File.delete(file_path)
    end
  end

  #上传到七牛云服务器
  def self.upload_yun(name,path)
    put_policy = Qiniu::Auth::PutPolicy.new('meteor',name) #服务器文件名称
    code, result, response = Qiniu::Storage.upload_with_put_policy(put_policy, path)
    file_url = Settings.qiniu_cdn_host+name
  end

  #本地文件上传至七牛服务器
  def self.cache_to_yun(file)
    name,path = local_cache_file(file)
    file_url = upload_yun(name,path)
    #delete_local_cache name 删除缓存的文件
    return file_url
  end

  #更改文件在服务器的名称
  def self.rename_yun_file_name(old_name,new_name)
    code, result, response_headers = Qiniu::Storage.move('meteor', old_name, 'meteor', new_name)
    if code != 614
      return true
    else
      return false
    end
  end

  #删除服务器的文件
  def self.delete_yun_file(name)
    code, result, response_headers = Qiniu::Storage.delete('meteor', name)
    if code == 200
      return true
    else
      return false
    end
  end

end
