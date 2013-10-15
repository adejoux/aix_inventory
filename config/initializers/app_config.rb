APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
FIELD_RENAMING = YAML.load_file("#{Rails.root}/config/field_renaming_config.yml")
if File.file? "#{Rails.root}/config/customer_renaming_config.yml"
  CUSTOMER_RENAMING = YAML.load_file("#{Rails.root}/config/customer_renaming_config.yml")
else
  CUSTOMER_RENAMING={}
end


