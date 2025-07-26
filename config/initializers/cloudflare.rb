# Configure cloudflare-rails to properly handle IP addresses
# This ensures request.remote_ip returns the correct client IP
# when requests are proxied through Cloudflare

Rails.application.configure do
  # Add Cloudflare's IP ranges to trusted proxies
  config.cloudflare.ips = CloudflareRails::Importer.fetch_ips!
end