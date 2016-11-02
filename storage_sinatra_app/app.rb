require 'sinatra'
require 'json'
require 'storage'

def fail(message, http_status = 400)
  status http_status
  message
end

def success(data: nil?, http_status: 200)
  status http_status
  if data.nil?
    ''
  else
    data.to_json
  end
end

post '/keys' do
  parameters = JSON.parse(request.body.read)
  if parameters.has_key? 'key'
    Storage.instance.add(parameters['key'])
    success(http_status: 201)
  else
    fail('Key was not provided')
  end
end

get '/keys/:key' do |key|
  success(data: { result: Storage.instance.contains?(key) } )
end

get '/words/:word' do |word|
  begin
    success(data: { words: Storage.instance.find(word) } )
  rescue ArgumentError => e
    fail(e.message)
  end
end