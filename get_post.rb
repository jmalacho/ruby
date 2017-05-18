def jget( url, path, user="", pass="")
  uri = URI( url + "/" + path)
  puts "URI: #{uri}" if DEBUG
  req = Net::HTTP::Get.new(uri)
  req.basic_auth user, pass unless user.empty?

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")

  res = http.request(req)
  JSON.parse( res.body )
end

def jpost(url, path, form, user="", pass="")
  uri = URI.parse( url + "/" + path)
  puts "URI: #{uri}" if DEBUG
  req = Net::HTTP::Post.new( uri, 'Content-Type' => 'application/json' )
  req.basic_auth user, pass unless user.empty?
  #req.set_form_data( form ) # common old style for form
  req.body = form.to_json

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")

  res = http.request(req)
  raise res.body unless res.code.start_with?("2")
  JSON.parse( res.body )
end
