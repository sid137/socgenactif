require 'sinatra'
require 'haml'
require 'yaml'

request_binary  = 'plugin/bin/request'
response_binary = 'plugin/bin/response'

# For each key and value in the options hash, it rejects the keys with empty
# values, creates the string "key=value" for each k,v pair, 
# and joins them via a space
def parameter_string opts
  opts.reject{|k,v| v.nil? }.collect{ |k,v| "#{k}=#{v}"}.join(' ')
end


get '/' do
  haml :index
end

get '/call_request' do
  socgen_params = YAML.load_file('test_params.yaml')
  # merge user-level params in nhere with defaulss
  request_params = parameter_string(socgen_params)
  result = `#{request_binary} #{request_params}`
  null, code, error, message = result.split('!')
  if (code.empty? && error.empty?)
    "Error calling request. Executable not found"
  elsif (code != "0")
    "Error calling the payment API.  Error message #{error}"
  else
    haml :call_request, :locals => {:error => error, :message => message}
  end
end

post '/call_response' do

end


post '/call_autoresponse' do

end


__END__
@@ layout
%html
  %head
    %title SOGENACTIF - Paiement Securise sur Internet
  %body
    = yield

@@ index
This is the test app for SocgenActif in Ruby
%p
  %a{:href => url('/call_request')} Call Request (Confirm Payment)


@@ call_request
= error
= message

