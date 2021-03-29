# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'uri'

seed_urls = [
  "http://s3.amazonaws.com/irs-form-990/201132069349300318_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201612429349300846_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201521819349301247_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201641949349301259_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201921719349301032_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831309349303578_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201823309349300127_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201401839349300020_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201522139349100402_public.xml",
  "http://s3.amazonaws.com/irs-form-990/201831359349101003_public.xml"
]
puts "Seeding the DB with XML files"
seed_urls.each do |url|
  resp = S3Utils::get_file_by_url(url)
  root = XmlUtils::get_xml_from_string(resp.body.read)
  # puts root.attribute("returnVersion")
  XmlUtils::add_efile(root)
end
