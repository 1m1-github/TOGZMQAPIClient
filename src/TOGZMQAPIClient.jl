module TOGZMQAPIClient

using Serialization, ZMQ
using TOGZMQAPIServer, TOGZMQ

const SOCKET = Ref{Socket}()

function awaken(socketlocation)
    @show "TOGZMQAPIClient.awaken(socketlocation)", socketlocation
    SOCKET[] = Socket(REQ)
    connect(SOCKET[], socketlocation)
end
function call(f::Symbol, x...)
    @show "TOGZMQAPIClient.call", x, typeof(x), length(x)
    TOGZMQ.send(SOCKET[], "", false, "", Symbol(""), "", TOGZMQAPIServer.APIData(f, x))
    _, _, _, _, _, information = TOGZMQ.recv(SOCKET[])
    information
end
call(f::Symbol) = call(f, nothing)

end
