module TOGZMQAPIClient

using ZMQ
using TOGZMQAPIServer, TOGZMQ

sleep(socket::Socket) = TOGZMQAPIServer.sleep(socket)
function awaken(socketlocation)
    # @show "TOGZMQAPIClient.awaken", socketlocation
    socket = Socket(REQ)
    connect(socket, socketlocation)
    socket
end
function call(socket::Socket, f::Symbol, x...)
    # @show "TOGZMQAPIClient.call", f, x, typeof(x), length(x)
    TOGZMQ.send(socket, TOGZMQAPIServer.APIData(f, x...))
    _, _, _, _, _, information = TOGZMQ.receive(socket)
    # @show "TOGZMQAPIClient.call", typeof(information) #, information
    information
end
call(socket::Socket, f::Symbol) = call(socket, f, nothing)

end
