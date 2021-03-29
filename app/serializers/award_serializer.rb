class AwardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :ein, :name, :address1, :city, :state, :zip_code, :amount
end
