import dgram from "node:dgram";

// create a server using socket from dgram
const server = dgram.createSocket("udp4");

server.on("error", err => {
  console.error(`server error:\n${err.stack}`);
  server.close();
});

// rinfo = remote inforamtion
server.on("message", (msg, rinfo) => {
  console.log("Message is :", msg.toString());
  console.log("Remote info is :", rinfo);
});

server.on("listening", () => {
  const address = server.address();
  console.log(`server listening ${address.address}:${address.port}`);
});

// start listening listen
server.bind(41234, "localhost");

// Client terminal using netcat -> "nc -u 127.0.0.1 41234"
