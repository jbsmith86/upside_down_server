require 'socket'

server = TCPServer.new 1337

puts "Prepare the cannon, incoming on port 1337!"

loop do
  client = server.accept

  request = client.gets
  puts request

  path = File.join("public", request.split(" ")[1])

  File.open(path, "rb") do |file|
    client.puts "HTTP/1.1 200 OK"
    client.puts "Content-Type: text/html"
    client.puts "Content-Length: #{file.size}"
    client.puts "Connection: close"
    client.puts

    client.puts file.read
  end

  client.close
end
