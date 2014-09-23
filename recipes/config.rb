include_recipe "nginx"

directory "/etc/nginx/shared"
directory "/etc/nginx/http"
directory "/etc/nginx/ssl"

node[:deploy].each do |application, deploy|
  app_puma_config = deploy[:puma] || {}
  puma_config application do
    directory      deploy[:deploy_to]
    environment    deploy[:rails_env]
    logrotate      app_puma_config[:logrotate]
    thread_min     app_puma_config[:thread_min]
    thread_max     app_puma_config[:thread_max]
    workers        app_puma_config[:workers]
    worker_timeout app_puma_config[:worker_timeout]
    bin_path       app_puma_config[:bin_path]
  end
end
