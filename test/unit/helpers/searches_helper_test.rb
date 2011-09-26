require 'test_helper'

class SearchesHelperTest < ActionView::TestCase

  setup do
    @search = searches(:kittens)
    @validXML = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><rsp stat=\"ok\"><photos page=\"1\" pages=\"8316\" perpage=\"5\" total=\"41580\"><photo id=\"6176684496\" owner=\"59283046@N00\" secret=\"cbbde943e5\" server=\"6174\" farm=\"7\" title=\"IMGP3471rd\" ispublic=\"1\" isfriend=\"0\" isfamily=\"0\" /></photos></rsp>"
    @badXML = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><BadXML><bad>This is not well-formed</awful></TerribleXML>"
  end


  #Testing construct_default_parameters.
  test "parameters should contain required elements" do
     puts "default params contain required elements"
    result = construct_default_parameters(@search.searchtext)
    assert result.has_key?("api_key")
    assert result.has_key?("per_page")
    assert result.has_key?("license")
    assert result.has_key?("text")
  end

  #Testing call_flickr_api

  test "should fail flickr call with bad api key" do
    
    puts "should fail flickr call with bad api key"
    
    params = {'method'=>'flickr.photos.search',
      'api_key'=> 'a bad api key',
      'per_page' => PICS_PER_PAGE,
      'license' => COMMONS_LICENSES,
      'text' => 'kittens'}

    output=call_flickr_api(params)
    result=validate_xml(output)
    assert_not_nil result #A nil result would indicate success.
  end

  test "should get results from flickr" do
    puts "Valid call to Flickr API returns a valid result."
    params = {'method'=>'flickr.photos.search',
      'api_key'=> MY_API_KEY,
      'per_page' => PICS_PER_PAGE,
      'license' => COMMONS_LICENSES,
      'text' => 'kittens'}
    output= call_flickr_api(params)
    assert_not_nil(output)
    assert_nil validate_xml(output)    #A nil result indicates suceess.
  end

#Testing validate_xml
  test "should fail on bad xml" do
    puts "Should fail on bad XML"
    assert_not_nil validate_xml(@badXML)
  end
  
  test "should succeed on valid xml" do
    puts "Should succeed on valid XML"
    assert_nil validate_xml(@validXML)
  end

#Testing construct_urls
  test "should construct urls" do
    "construct_urls should return result"
    assert_not_nil construct_urls(@validxml)
  end
end
