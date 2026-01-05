const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();

app.get("/stream", (req, res) => {
  const filePath = path.join(__dirname, "bigfile.txt");

  // check if file exist or not!
  if (!fs.existsSync(filePath)) {
    return res.status(404).send("File not found");
  }
  // header
  res.setHeader("Content-Type", "text/plain");

  const readStream = fs.createReadStream(filePath, "utf-8");

  // Pipe data directly to response(Writable Stream)
  // Pipe the readable stream into writable stream
  readStream.pipe(res);

  readStream.on("error", err => {
    console.error("Stream Error :", err);
    res.status(500).send("Error Reading the file");
  });

  readStream.on("end", () => {
    console.log("File Streaming completed");
  });
});

// Root route
app.get("/", (req, res) => {
  res.send('Visit <a href="/stream">/stream</a> to see file streaming.');
});

// Start server
app.listen(3000, () => console.log("Server running on http://localhost:3000"));
