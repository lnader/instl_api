class EfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :ein, :name, :address1, :city, :state, :zip_code, :tax_year
  has_many :awards
end
