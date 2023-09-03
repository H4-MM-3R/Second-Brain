Poling is the process where the client ( web browser ), makes an HTTP request to the server, which sends back the appropriate response.

# Short Poling
1. The client sends a HTTP request to the server requesting information.
2. The server, if it has any information  sends it back.
3. The client then waits for some time and repeats the above two steps again.

The problem with Poling is that the client has to keep asking the server for any new data. As a result, a lot of responses are empty, create HTTP overhead.

![](https://github.com/PriyankaKhire/SystemDesign/blob/main/Basics/Polling%20SSE%20and%20Web%20Sockets/img/ShortPolling.png?raw=true)
Example of short polling: 
`00:00:00 C-> Is the cake ready?`  
`00:00:01 S-> No, wait.`  
`00:00:01 C-> Is the cake ready?`  
`00:00:02 S-> No, wait.`  
`00:00:02 C-> Is the cake ready?`  
`00:00:03 S-> Yes. Have some lad.`  
`00:00:03 C-> Is the other cake ready? ..`

# Long Polling 
1. The client opens a TCP tunnel and sends a HTTP request to the server requesting information.
2. The server waits until there is new information abailable and then sends the response back.
3. After recieving the information the client immediately makes another request and repeats the above two steps.
4. If the server doesn't have any new data and the long polling reuqest times out, then the client has to make another reuqest.

The server has to handle the case where it gets new information to send, but the client hasn;t sent a new request yet.

The HTTP long polling mechanism can be applied to either persistent or non-persistent HTTP connections. The use of persistent HTTP connections will avoid the additional overhead of establishing a new TCP/IP connection (TCP) for every long poll request.

![](https://github.com/PriyankaKhire/SystemDesign/blob/main/Basics/Polling%20SSE%20and%20Web%20Sockets/img/LongPolling.png?raw=true)
Example of long polling: 
`12:00 00:00:00 C-> Is the cake ready?`  
`12:00 00:00:03 S-> Yes.Have some lad.`  
`12:00 00:00:03 C-> Is the cake ready?`

# Server Sent Events (SSE)
In this process, the server establishes a one way, long term connection with the client. Only the server is allowed to push data to the client. If the client wants to send data to the server, it needs to use another technology/protocol to do so.

This way the client can send data to the server, without having to re-establish a connection every time.
1. The client requests for a new SSE connection.
2. The server registers the new SSE connection.
3. The server begins pushing new data to the client.
4. Either sides are allowed to close the connection.
The main benefit of SSEs is it provides an efficient one directional data stream where the client and server don't need to constantly reestablish the connection.
![](https://github.com/PriyankaKhire/SystemDesign/blob/main/Basics/Polling%20SSE%20and%20Web%20Sockets/img/SSE.png?raw=true)
Example of SSE:
`12:00 00:00:00 C-> Is the cake ready?`  
`12:00 00:00:03 S-> Yes.Have some lad.`  
`12:00 00:00:05 S-> Here is more cake.`  
`12:00 00:00:08 S-> Here is some more cake.`

# WebSockets
It is a two-way message passing protocol based on TCP, WebSockets are faster for data transmission than HTTP.
1. The client establishes a WebSocket connection with the server, throught a process known as the WebSocket handshake.
2. The messages are transmitted in both directions over port 443.
3. Either side can close the connection.

The main advantage of WebScokets is speed; the client and server don't have to find and reestablist their connetion with each other evert time a message is sent.

TCP ensures that the messages will always arrrive in order.

The main downside of WebSockets is it takes a good amount of initial develoepers work to implement.
![](https://github.com/PriyankaKhire/SystemDesign/blob/main/Basics/Polling%20SSE%20and%20Web%20Sockets/img/WebSockets.png?raw=true)
Example of WebSockets:
`00:00 00:00:00 C-> Is the cake ready?`  
`00:00 00:00:03 S-> Yes.Have some lad.`  
`00:00 00:00:05 C-> I want more cake ?`  
`00:00 00:00:05 S-> Here is some more cake.`
An example where WebSockets is really useful is multiplayer online gaming.
