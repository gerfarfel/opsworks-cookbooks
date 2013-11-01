#
# Cookbook Name:: deploy-propmaster
# Recipe:: default
#
# Copyright 2013, DK PIctures, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Transfer jar files from S3 to the server.
execute "s3cmd" do
  command "mkdir /home/ubuntu/propmaster ; s3cmd sync --recursive s3://doink-propmaster/target /home/ubuntu/propmaster/"
  cwd "/home/ubuntu"
  action :run
end

# Fire up the server as a service!
runit_service "deploy-propmaster"

# Install the database backup script.
cookbook_file "/usr/bin/backup-db.sh" do
  source "backup-db.sh"
  mode 0755
  owner "root"
  group "root"
end

# Set up cron tasks to perform backups at scheduled intervals.
# cron "backup-db_0300" do
#   hour "3"
#   minute "0"
#   command "/usr/bin/backup-db.sh"
# end

# cron "backup-db_0900" do
#   hour "9"
#   minute "0"
#   command "/usr/bin/backup-db.sh"
# end

# cron "backup-db_1500" do
#   hour "15"
#   minute "0"
#   command "/usr/bin/backup-db.sh"
# end

# cron "backup-db_2100" do
#   hour "21"
#   minute "0"
#   command "/usr/bin/backup-db.sh"
# end
