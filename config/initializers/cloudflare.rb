# Configure cloudflare-rails to properly handle IP addresses
# This ensures request.remote_ip returns the correct client IP
# when requests are proxied through Cloudflare

# The gem automatically fetches and caches Cloudflare's IP ranges
# No additional configuration needed - it works out of the box!