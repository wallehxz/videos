require 'qiniu'

Qiniu.establish_connection! :access_key => Settings.qiniu_key,
  :secret_key => Settings.qiniu_secret