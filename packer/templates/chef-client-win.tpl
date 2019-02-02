log_level        :info
log_location     STDOUT
local_mode       true
cookbook_path    "C:/chef/cookbooks"
data_bag_path    "C:/chef/data_bags"
environment_path "C:/chef/environments"
chef_server_url  "{{.ServerUrl}}"
client_key       "{{.ClientKey}}"
{{if ne .EncryptedDataBagSecretPath ""}}
encrypted_data_bag_secret "{{.EncryptedDataBagSecretPath}}"
{{end}}
{{if ne .ValidationClientName ""}}
validation_client_name "{{.ValidationClientName}}"
{{else}}
validation_client_name "chef-validator"
{{end}}
{{if ne .ValidationKeyPath ""}}
validation_key "{{.ValidationKeyPath}}"
{{end}}
node_name "{{.NodeName}}"
{{if ne .ChefEnvironment ""}}
environment "{{.ChefEnvironment}}"
{{end}}
{{if ne .SslVerifyMode ""}}
ssl_verify_mode :{{.SslVerifyMode}}
{{end}}
