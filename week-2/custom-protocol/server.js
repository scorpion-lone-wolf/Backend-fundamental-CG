import net from "node:net";
import { handleMessage, parseMessage } from "./helper.js";

const PORT = 1337;
const HOST = "localhost";

const clients = [];
const server = net.createServer(socket => {
  console.log("Client Connected...🍻");

  socket.setEncoding("utf-8");
  socket.authenticated = false;
  socket.joined = false;
  socket.username = "";

  clients.push(socket);

  // When data is received from the client through this socket
  socket.on("data", chunk => {
    const parsedMessage = parseMessage(chunk.toString());
    if (!parsedMessage) {
      console.error("Invalid message format");
      return;
    }
    handleMessage(socket, parsedMessage);
  });

  // when client closes the socket connection
  socket.on("close", () => {
    console.log("Connection is Closed.. ☹️");
  });

  // when any error occurs on that socket
  socket.on("error", err => {
    console.error("Socket Error : ", err.message);
  });
});

server.listen(PORT, HOST, () => {
  console.log(`Server Started Successfully on port:${PORT}`);
});

server.on("error", err => {
  console.error("Server Error :", err.message);
});
