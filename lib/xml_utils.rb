require 'nokogiri'

class XmlUtils

  # TODO: brute forcing variations in schema there's probably a better way of
  # doing this
  @ein_strings = ["EIN", "EINOfRecipient", "RecipientEIN"]
  @name_strings = ["Name", "BusinessName", "RecipientNameBusiness", "RecipientBusinessName"]
  @address1_strings = ["AddressLine1", "AddressLine1Txt"]
  @city_strings = ["City", "CityNm"]
  @state_strings = ["State", "StateAbbreviationCd"]
  @zip_code_strings = ["ZipCode", "ZIPCd", "ZIPCode"]
  @tax_year_strings = ["TaxYear", "TaxYr"]
  @grant_amount_strings = ["AmountOfCashGrant", "CashGrantAmt"]

  def self.get_xml_from_string(xml_string)
    # TODO: Validate inputs
    doc = Nokogiri::XML(xml_string)
    root = doc.root
    return root
  end

  def self.add_efile(root)
    # TODO: Validate inputs
    return_header = root.at_xpath("//xmlns:ReturnHeader")
    filer = return_header.at_xpath("//xmlns:Filer")
    ein = get_text(filer, @ein_strings)
    name = get_text(filer, @name_strings)
    address1 = get_text(filer, @address1_strings)
    city = get_text(filer, @city_strings)
    state = get_text(filer, @state_strings)
    zip_code = get_text(filer, @zip_code_strings)
    tax_year = get_number(return_header, @tax_year_strings, "integer")
    efile = Efile.create(ein: ein,
      name: name,
      address1: address1,
      city: city,
      state: state,
      zip_code: zip_code,
      tax_year: tax_year)
    schedule_i = root.at_xpath("//xmlns:IRS990ScheduleI")
    if !schedule_i.nil?
      recipients = schedule_i.xpath("//xmlns:RecipientTable")
      recipients.each do |recipient|
        add_award(efile, recipient)
      end
    end
    return efile
  end

  # decided againts making filer it's own model for expediency
  # def self.add_filer(root)
  #   # TODO: Validate inputs
  #   return_header = root.at_xpath("//xmlns:ReturnHeader")
  #   filer = return_header.at_xpath("//xmlns:Filer")
  #   ein = get_text(filer, @ein_strings)
  #   name = get_text(filer, @name_strings)
  #   address1 = get_text(filer, @address1_strings)
  #   city = get_text(filer, @city_strings)
  #   state = get_text(filer, @state_strings)
  #   zip_code = get_text(filer, @zip_code_strings)
  #
  #   filer = Filer.create(ein: ein, name: name, address1: address1, city: city, state: state, zip_code: zip_code)
  #   return filer
  # end

  def self.add_award(efile, recipient)
    # TODO: Validate inputs
    ein = get_text(recipient, @ein_strings)
    name = get_text(recipient, @name_strings)
    address1 = get_text(recipient, @address1_strings)
    city = get_text(recipient, @city_strings)
    state = get_text(recipient, @state_strings)
    zip_code = get_text(recipient, @zip_code_strings)
    grant_amount = get_number(recipient, @grant_amount_strings, "float")
    award = Award.create(efile_id: efile.id,
      ein: ein,
      name: name,
      address1: address1,
      city: city,
      state: state,
      zip_code: zip_code,
      amount: grant_amount)
  end

  def self.get_text(xml_doc, element_names)
    # TODO: Validate inputs
    element_names.each do |name|
      text = (!xml_doc.at(name).nil?) ? xml_doc.at(name).text.strip : nil
      return text if !text.nil?
    end
    return nil
  end

  def self.get_number(xml_doc, element_names, type)
    # TODO: Validate inputs
    element_names.each do |name|
      text = (!xml_doc.at(name).nil?) ? xml_doc.at(name).text.strip : nil
      if !text.nil?
        # TODO: there's definitely a better way of doing this but don't
        # have time to it look up
        number = (type == "integer") ? text.to_i : text.to_f
        return number
      end
    end
    return 0
  end
end
