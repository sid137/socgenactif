require 'sinatra'
require 'haml'


get '/' do
  haml :index
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
