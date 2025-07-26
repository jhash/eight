# Cloudflare R2 Setup Guide

This application is configured to use Cloudflare R2 for file storage with Active Storage.

## Prerequisites

1. A Cloudflare account with R2 enabled
2. An R2 bucket created in your Cloudflare dashboard
3. R2 API credentials (Access Key ID and Secret Access Key)

## Setup Instructions

### 1. Create R2 Bucket

1. Log into your Cloudflare dashboard
2. Navigate to R2 Object Storage
3. Create a new bucket (e.g., "rails-app-production")
4. Note the bucket name and jurisdiction

### 2. Generate API Credentials

1. In R2 dashboard, go to "Manage R2 API Tokens"
2. Create a new API token with appropriate permissions:
   - Object Read & Write
   - (Optional) List permissions if you need to browse files
3. Save the Access Key ID and Secret Access Key

### 3. Configure Rails Credentials

Run the following command to edit your Rails credentials:

```bash
EDITOR="code --wait" bin/rails credentials:edit
```

Add the following configuration:

```yaml
cloudflare:
  access_key_id: YOUR_R2_ACCESS_KEY_ID
  secret_access_key: YOUR_R2_SECRET_ACCESS_KEY
  bucket: your-bucket-name
  endpoint: https://YOUR_ACCOUNT_ID.r2.cloudflarestorage.com
```

To find your endpoint:
- Go to your R2 bucket settings
- Look for "Bucket Details" 
- The endpoint format is: `https://[account_id].r2.cloudflarestorage.com`

### 4. Configure CORS (if needed for direct uploads)

If you plan to use Direct Uploads from the browser, configure CORS in your R2 bucket:

```json
[
  {
    "AllowedOrigins": ["https://rails.jakehash.com"],
    "AllowedMethods": ["GET", "PUT", "POST", "DELETE", "HEAD"],
    "AllowedHeaders": ["*"],
    "ExposeHeaders": ["ETag"],
    "MaxAgeSeconds": 3600
  }
]
```

### 5. Configure CDN (Optional but Recommended)

1. In Cloudflare dashboard, set up a custom domain for your R2 bucket
2. This provides automatic CDN distribution for your files
3. Update your Rails app to use the CDN URL:

```ruby
# config/environments/production.rb
config.active_storage.resolve_model_to_route = :cdn
config.active_storage.cdn_host = "https://cdn.yourdomain.com"
```

## Usage

### Attaching Files to Models

```ruby
class BlogPost < ApplicationRecord
  has_one_attached :featured_image
  has_many_attached :images
end
```

### In Controllers

```ruby
def create
  @blog_post = BlogPost.new(blog_post_params)
  @blog_post.featured_image.attach(params[:featured_image])
  # ...
end

private
def blog_post_params
  params.require(:blog_post).permit(:title, :content, :featured_image, images: [])
end
```

### In Views

```erb
<%= form_with model: @blog_post do |form| %>
  <%= form.file_field :featured_image %>
  <%= form.file_field :images, multiple: true %>
<% end %>

<!-- Display images -->
<% if @blog_post.featured_image.attached? %>
  <%= image_tag @blog_post.featured_image, class: "w-full" %>
<% end %>
```

## Testing

To test in development with R2:

1. Update `config/environments/development.rb`:
   ```ruby
   config.active_storage.service = :cloudflare
   ```

2. Ensure your credentials are set correctly

3. Try uploading a file through your application

## Troubleshooting

1. **Access Denied Errors**: Check your API token permissions
2. **Bucket Not Found**: Verify bucket name in credentials
3. **CORS Errors**: Configure CORS rules in R2 bucket settings
4. **Slow Uploads**: Consider using Direct Uploads for large files

## Benefits

1. **Cost Effective**: R2 has no egress fees
2. **Fast**: Automatic CDN distribution through Cloudflare's network
3. **Reliable**: Built on Cloudflare's infrastructure
4. **S3 Compatible**: Works with existing S3 tools and libraries