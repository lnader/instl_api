require 'aws-sdk'
require 'uri'
class S3Utils
  def self.get_file_by_url(url)
    # TODO: Validate url
    uri = URI(url)
    path = uri.path
    bucket_name = path.slice(1, path.index("/", 1) - 1)
    key = path.slice(path.index("/", 1) + 1, path.length)
    # TODO: validate bucket_name and key
    s3 = Aws::S3::Client.new(region: 'us-east-1')
    # the xml files small enough to hold in memory
    resp = s3.get_object({ bucket:bucket_name, key: key })
    # TODO: check response for errors
    return resp
  end
end
