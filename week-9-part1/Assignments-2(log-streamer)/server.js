import cors from "cors";
import express from "express";
import path, { dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
// middleware
app.use(cors());
app.use(express.static(path.join(__dirname, "public")));

let clients = [];

app.get("/logs", (req, res) => {
  // Set headers to keep the connection alive and tell the client we're sending event-stream data
  res.setHeader("Content-Type", "text/event-stream");
  res.setHeader("Cache-Control", "no-cache");
  res.setHeader("Connection", "keep-alive");

  clients.push(res);

  res.on("close", () => {
    console.log("Client disconnected...");
    res.end();
    clients = clients.filter(client => client !== res);
  });
});

// function that send msg to all clients
function broadcastMSG(msg) {
  clients.map(client => {
    client.write(`data: ${msg}\n\n`);
  });
}

//  interval that will broadcast msg to all clients
setInterval(() => {
  const log = `Log => ${new Date().toLocaleDateString()}`;
  console.log("Server log :", log);
  broadcastMSG(log);
}, 2000);

const PORT = 3000;
app.listen(PORT, () => {
  console.log("Server Running on port :", PORT);
});
