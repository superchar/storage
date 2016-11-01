require 'sinatra'
require 'json'
require_relative '../storage_app/storage'
require './storage_mixins'


before do
  if request.request_method == "POST"
    params.merge!(JSON.parse(request.body.read))
  end
end

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
  if params.has_key? 'key'
    Storage.instance.add(params['key'])
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