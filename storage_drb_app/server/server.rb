require 'drb'
require 'storage/core/storage'
require 'storage/extensions/singleton'

class Server
  def start
    DRb.start_service('druby://localhost:9999', Storage.instance)
    puts 'Service started'
    trap("INT") { DRb.stop_service }
    DRb.thread.join
  end
end

Server.new.start