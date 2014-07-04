# encoding: utf-8

##
# Backup Generated: db_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t db_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
db_config           = YAML.load_file('/u/apps/promoker/shared/config/database.yml')['production']
Model.new(:db_backup, 'Description for db_backup') do

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = db_config['database']
    db.username           = db_config['username']
    db.password           = db_config['password']
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "/u/apps/promoker/backups/"
    local.keep       = 10
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = false
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "service@promoker.com"
    mail.to                   = "linyaoyi011@gmail.com"
    mail.address              = "smtp.exmail.qq.com"
    mail.port                 = 465
    mail.domain               = "exmail.qq.com"
    mail.user_name            = "service@promoker.com"
    mail.password             = "qQWu3SeRmQU4"
    mail.authentication       = :plain
    mail.encryption           = :ssl
  end

end
