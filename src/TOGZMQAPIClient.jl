module TOGZMQAPIClient

using Serialization, ZMQ
using TOGZMQAPIServer, TOGZMQ

const SOCKET = Ref{Socket}()

function awaken(socketlocation)
    @show "TOGZMQAPIClient.awaken(socketlocation)", socketlocation
    SOCKET[] = Socket(REQ)
    connect(SOCKET[], socketlocation)
end
# const FUNCTIONS = TOGZMQAPIServer.FUNCTIONS
# function call(f::Function, x...)
function call(f::Symbol, x...)
    @show "TOGZMQAPIClient.call", x, typeof(x), length(x)
    # buffer = IOBuffer()
    # serialize(buffer, TOGZMQAPIServer.APIData(f, x))
    # message = Message(take!(buffer))
    # @show "TOGZMQAPIClient.call", message
    # send(SOCKET[], message)
    TOGZMQ.send(SOCKET[], "", false, "", Symbol(""), "", TOGZMQAPIServer.APIData(f, x))
    @show "TOGZMQAPIClient.call, send"
    # deserialize(IOBuffer(recv(SOCKET[])))
    TOGZMQ.recv(SOCKET[])
    # @show "TOGZMQAPIClient.call, x", x
    # x
end
call(f::Symbol) = call(f, nothing)

end
