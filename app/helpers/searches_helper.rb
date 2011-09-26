module SearchesHelper

  #Doug's Note - For simplicity in the controller class, I broke the functionality down into four methods.
  #construct_default_params prepares the paramters for the call to the flickr API. Most of the requirements logic is here.
  # =>             5 photo results per page, Commons liscenes
  #call_flickr_api makes the actual call to flickr.
  #validate_xml validates the return from the flickr call.
  #construct URLs parses the results of the flickr call into an array of URLs for display on the results page.

  #Breaking the functionality out like this allows each piece to be tested seperately.
  def get_urls_from_searchtext(text_to_find)
    params = construct_default_parameters(text_to_find)
    xmldata = call_flickr_api(params)
    errs = validate_xml(xmldata)
    if(errs==nil)
      return construct_urls(xmldata)
    else
    return errs
    end
  end

  #Constructs a set of default parameters.
  #The values for the constants are in config/initializers/doug_constants.rb
  def construct_default_parameters(text_to_find)

    params = {'method'=>'flickr.photos.search',
      'api_key'=> MY_API_KEY,
      'per_page' => PICS_PER_PAGE,
      'license' => COMMONS_LICENSES,
      'text' => text_to_find}

  end

  #Doug's note. This helper method is where I make the actual api call.

  def call_flickr_api(parameters)

    uri = URI.parse( "http://api.flickr.com/services/rest/" )
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.path)
    request.set_form_data( parameters )
    request = Net::HTTP::Get.new( uri.path+ '?' + request.body )
    response = http.request(request)
    xml_data = response.body

    return xml_data
  end

  def validate_xml(xml_data) #A nil return value means a valid result.

    error = nil

    begin
      doc = REXML::Document.new(xml_data)
    rescue Exception => e
    error = e.message
    end

    if error==nil
      if doc.root.attributes["stat"] =="ok"
        else
        doc.elements.each("*/err") do |ele|
          error = ele.attributes["msg"]
        end
      end
    end

    return error

  end

  #Doug's note. This helper method parses the XML from Flickr in a document object and constructs an
  # array of URLs for the images to be displayed on the results page.
  def construct_urls(xml_data)

    doc = REXML::Document.new(xml_data)
    urls = []

    doc.elements.each('*/photos/photo') do |ele|
      farm=ele.attributes["farm"]
      server=ele.attributes["server"]
      p_id=ele.attributes["id"]
      secret=ele.attributes["secret"]
      #Doug's note. The "m" at the end of the string stands for "medium". I chose the size for you.
      url="http://farm" + farm + ".static.flickr.com/" +  server + "/" + p_id + "_" + secret + "_m.jpg"
      urls << url
    end

    if urls.size==0
      url="nada.JPG"
    urls << url
    end

    return urls
  end
end
