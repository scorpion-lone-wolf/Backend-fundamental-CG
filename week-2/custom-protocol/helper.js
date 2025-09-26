// helper function to build command in predefined structure
export function buildCommand(command, headers, body) {
  const startLine = `CHAT/1.0 ${command}`;

  const headerLines = [];
  for (const key in headers) {
    const header = `${key}:${headers[key]}`;
    headerLines.push(header);
  }
  return `${startLine}\r\n${headerLines.join("\r\n")}\r\n\r\n${body}`;
}

export function parseMessage(message) {
  const parts = message.split("\r\n\r\n");
  console.log("part :", parts);
  if (parts.length < 2) return null; // Missing  body

  const headerPart = parts[0];
  const body = parts[1];

  const [firstLine, ...arrayOfHeaders] = headerPart.split("\r\n");
  const [protocolVersion, command] = firstLine.split(" ");
  if (!protocolVersion || !command) return null;
  if (arrayOfHeaders.length === 0) return 0;

  const headers = {};
  let contentLength = 0;
  for (let header of arrayOfHeaders) {
    const [key, value] = header.split(":");
    headers[key.trim()] = value.trim();
    if (key.trim().toLowerCase() === "content-length") {
      contentLength = +value.trim();
    }
  }
  if (body.length !== contentLength) {
    console.warn(`Warning : body length ${body.length} does not match content length header`);
  }
  return { protocolVersion, command, headers, body };
}

/**
 *  CHAT/1.0 AUTH
    User:rahul
    Token:123A
    content-length:0

    body
 *
 */

export function handleMessage(socket, parsedMessage) {
  switch (parsedMessage.command) {
    case "AUTH":
      handleAuth(socket, parsedMessage);
      break;
    case "JOIN":
      handleJoin(socket, parsedMessage);
      break;
    case "SEND":
      handleSend(socket, parsedMessage);
      break;
    case "LEAVE":
      handleLeave(socket, parsedMessage);
      break;
    default:
      console.log("No command Matched...");
  }
}

function handleAuth(socket, parsedMessage) {
  const user = parsedMessage.headers["User"];
  const token = parsedMessage.headers["Token"];

  // TODO: move the secret to db, don't hardcode.
  if (user && token && token === "secret123") {
    socket.authenticated = true;
    socket.username = user;
    socket.write(
      formatResponse(
        "OK",
        "AUTH",
        {
          "content-length": 0,
        },
        ""
      )
    );
  } else {
    socket.write(
      formatResponse(
        "ERROR",
        "AUTH",
        {
          Error: "Incorrect Token",
          "content-length": 0,
        },
        ""
      )
    );
    socket.end();
  }
}
function formatResponse(command, responseFor, headers, body = "", user) {
  let startLine = `CHAT/1.0 ${command}`;
  const headerLines = [];
  headerLines.push(`Response-For: ${responseFor}`);

  if (user) {
    headerLines.push(`User: ${user}`);
  }
  for (const key in headers) {
    headerLines.push(`${key}: ${headers[key]}`);
  }

  console.log(startLine);
  console.log(headerLines);
  console.log(body);
  return `${startLine}\r\n${headerLines.join("\r\n")}\r\n\r\n${body}`;
}
