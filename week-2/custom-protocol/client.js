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
  const client = net.createConnection(options, async () => {
    console.log("Connected to Server...🥳");
    // Get username & token
    const username = await rl.question("Enter username ->: ");
    const token = await rl.question("Enter token ->: ");

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
  });

  client.on("data", async chunk => {
    const parsedMessage = parseMessage(chunk.toString());

    if (parsedMessage.command === "ERROR") {
      // client is not authenticated , so close the conn from client end as well
      client.end();
      return;
    }
    if (parsedMessage.command === "OK" && parsedMessage.headers["Response-For"] === "AUTH") {
      // client is authenticated
      // send JOIN command
      const joinCommand = buildCommand(
        "JOIN",
        {
          "content-length": "0",
        },
        ""
      );
      client.write(joinCommand);
    }
    if (
      (parsedMessage.command === "OK" && parsedMessage.headers["Response-For"] === "JOIN") ||
      parsedMessage.command === "MESSAGE"
    ) {
      if (parsedMessage.headers["Response-For"] === "JOIN") {
        console.log("You are now connected...🥳");
      }
      if (parsedMessage.command === "MESSAGE") {
        console.log(parsedMessage.body);
      }
      // now client can send message
      const msg = await rl.question("");
      if (msg === "quit") {
        const leaveCommand = buildCommand("LEAVE", { "content-length": 0 }, "");
        client.write(leaveCommand);
      }
      // send this message to server and server will broadcast to all
      const sendCommand = buildCommand("SEND", { "content-length": msg.length }, msg);
      client.write(sendCommand);
    }
  });

  client.on("error", err => {
    console.error("Client Error : ", err.message);
  });
}

createClient();
