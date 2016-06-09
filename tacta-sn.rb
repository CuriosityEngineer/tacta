require 'sinatra'

set :port, 4567

get '/' do
   "<h1>Tacta Contact Manager</h1>"
end

get '/' do
   # ...
end

require './contacts_file'

get '/contacts' do
   @contacts = read_contacts
   erb :'contacts/index'
end
