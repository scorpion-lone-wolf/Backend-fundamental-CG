import net from "node:net";

const clients = [];
const server = net.createServer(socket => {
  console.log("Client Connected");

  clients.push(socket);
  console.log(`Toatal Connected clients: ${clients.length}`);

  socket.write("Welcome to the Coders TCP Char ! \n");
  socket.write("Type you message and press Enter to broadcast.\n");

  socket.on("data", chunk => {
    const message = chunk.toString().trim();
    clients.map(client => {
      client.write(`Client Says: ${chunk}`);
    });
  });

  socket.on("end", () => {
    const index = clients.indexOf(socket);
    if (index !== -1) {
      clients.splice(index, 1);
    }
    console.log("A Client disconnected");
    console.log(`Toatal Connected clients: ${clients.length}`);
  });

  socket.on("error", err => {
    console.error("Socket error:", err);
  });
});

server.listen(1373, () => {
  console.log("Server started on port: 1373");
});

server.on("error", err => {
  console.error("Server error:", err);
});
