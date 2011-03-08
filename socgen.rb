require 'sinatra'
require 'haml'


get '/' do
  #haml :index
  Hellow from Sinatra on Heroku
end


__END__
@@ layout
%html
  %head
    %title Socgenactif Test
  %body
    = yield

@@ index
  Hi, we're up
