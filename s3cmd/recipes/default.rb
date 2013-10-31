#
# Cookbook Name:: s3cmd
# Recipe:: default
#

#install s3cmd
package "s3cmd" do 
  action :upgrade
end

node[:s3cmd][:users].each do |user| 
  
  home = user == :root ? "/root" : "/home/#{user}"
  
  template "s3cfg" do
      path "#{home}/.s3cfg"
      source "s3cfg.erb"
      mode 0655
      variables({
        :aws_access_key_id => node[:aws_access_key_id],
        :aws_secret_access_key => node[:aws_secret_access_key]
      })
  end  
end
