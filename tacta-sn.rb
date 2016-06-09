require 'sinatra'
require './contacts_file'

set :port, 4567

get '/' do
   "<h1>Tacta Contact Manager</h1>"
end

#Show the index of contacts
get '/contacts' do
   @contacts = read_contacts
   erb :'contacts/index'
end

#Search (something in process)
get '/contacts/search_form' do
  erb :'contacts/search_form'
end

get '/contacts/new' do
   erb :'contacts/new'
end

#show the contact info
get '/contacts/:i' do
   @i = params[:i].to_i
   contacts = read_contacts
   @contact = contacts[@i]
   erb :'contacts/show'
end

#create new contact
post '/contacts' do
   new_contact = { name: params[:name], phone: params[:phone], email: params[:email] }

   contacts = read_contacts
   contacts << new_contact
   write_contacts( contacts )

   i = contacts.length - 1

   redirect "/contacts/#{i}"
end

#Edit the contact info
get '/contacts/:i/edit' do
   @i = params[:i].to_i

   contacts = read_contacts
   @contact = contacts[@i]

   erb :'contacts/edit'
end

#Saving the update of edited contacts
post '/contacts/:i/update' do
   i = params[:i].to_i

   updated_contact = { name: params[:name], phone: params[:phone], email: params[:email] }

   contacts = read_contacts
   contacts[i] = updated_contact
   write_contacts( contacts )

   redirect "/contacts/#{i}"
end

#Delete a contact
get '/contacts/:i/delete' do
   i = params[:i].to_i

   contacts = read_contacts
   contacts.delete_at( i )
   write_contacts( contacts )

   redirect "/contacts"
end




# def action_search( contacts )
#    puts
#    pattern = ask "Search for? "
#    puts
#
#    contacts.each do |contact|
#       if contact[:name] =~ /\b#{pattern}/i
#          show( contact )
#          puts
#       end
#    end
# end
