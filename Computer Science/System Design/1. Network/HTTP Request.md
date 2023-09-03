HTTP (Hyper text Transfer Protocol), is the underlying format that is used to structure request and responses between a client and a server.

![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/HTTP%20Requests/img/HTTP.png)
The client (your computer) opens a TCP (Transmission Control Protocol) channel with the server it wants to communicate to. HTTP is the command language that the devices on both sides of the connection must follow in order to communicate.

After the server sends the response it closes the TCP connection.
![](https://github.com/PriyankaKhire/SystemDesign/raw/main/Basics/HTTP%20Requests/img/TCP.png)
# HTTP vs HTTPS
HTTPS stands for HTTP secure, it encrypts the data you send to server. Thus, its more secure.

## Popular Types of HTTP Request Methods

### GET:
Client sends a GET request to the server to get the requested contents from it.

### POST:
Used to send dat to a server to create/update a resource, these requests are NOT *idempotent.*
So if you retry the request N times, you will end up having N resources with N different URIs created on server.
**Example**: User uploading a profile picture.

### PUT:
PUT requests are same as POST requests, except for they are *idempotent*.
so if you send retry a request multiple times, that should be equivalent to single request modification.
**Example**: Adding caption under the profile picture.

# Easy Way to remembering GET, POST, PUT
Create NEW record => POST
Read => Get
If the record exists then update else create a new record => PUT
Update/modify => PATCH
Delete => DELETE