import net from "node:net";
import readline from "node:readline/promises";
import { buildCommand, parseMessage } from "./helper.js";

const options = {
  port: 1337,
  host: "localhost",
};

// This will help to read and Write to stdin and stdout (here its terminal)
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  prompt: "=>",
});

async function createClient() {
  // create a client
  const client = net.createConnection(options, () => {
    console.log("Connected to Server...🥳");
  });

  // Get username & token
  const username = await rl.question("Enter username: ");
  const token = await rl.question("Enter token: ");

  // Prepare AUTH command
  const authCommand = buildCommand(
    "AUTH",
    {
      User: username,
      Token: token,
      "content-length": 0,
    },
    ""
  );
  client.write(authCommand); // send AUTH command to server for authentication

  client.on("data", chunk => {
    const parsedMessage = parseMessage(chunk.toString());
    console.log("parsedMessage", parsedMessage);
  });

  client.on("error", err => {
    console.error("Client Error : ", err.message);
  });
}

createClient();

// TODO: Complete remaining functionality like : JOIN, SEND, LEAVE
