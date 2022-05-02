# require "aws-sdk-s3"

# S3Client = Aws::S3::Client.new(
#   access_key_id:  Rails.application.credentials.dig(:aws, :access_key_id),
#   secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
#   region: ENV['AWS_REGION']
# ) 