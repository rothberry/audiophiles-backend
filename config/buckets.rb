# Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# This file is licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License. A copy of the
# License is located at
#
# http://aws.amazon.com/apache2.0/
#
# This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
# OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

# TODO
# require 'aws-sdk-s3'  # v2: require 'aws-sdk'

# region = 'us-west-1'
# s3 = Aws::S3::Resource.new(region: region)

# s3.buckets.limit(50).each do |b|
#   if s3.client.get_bucket_location(bucket: b.name).location_constraint == region
#     puts "#{b.name}"
#   end
# end
