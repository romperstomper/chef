#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'java-1.8.0-openjdk-devel.x86_64'

group 'tomcat'

user 'tomcat' do
  manage_home false
  shell '/bin/nologin'
  group 'tomcat'
  home '/opt/tomcat'
end

directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
  action :create
end

remote_file 'apache-tomcat-8.5.4.tar.gz' do
  source 'http://ftp.heanet.ie/mirrors/www.apache.org/dist/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz'
end

execute 'tar xvf apache-tomcat-8.5.4.tar.gz -C /opt/tomcat --strip-components=1'
# TODO: NOT Desired
execute 'chown -R tomcat:tomcat /opt/tomcat'

# TODO: NOT Desired
execute 'chmod g+r /opt/tomcat/conf/*'

directory '/opt/tomcat/conf' do
  mode '0070'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end


