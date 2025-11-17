const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();

const videoPath = path.join(__dirname, "..", "../assets/earth.mp4");

console.log("video path", videoPath);
app.get("/video", (req, res) => {
  const range = req.headers.range;

  const videoSize = fs.statSync(videoPath).size;
  if (range) {
    const chunkSize = 10 ** 6; // 1 MB
    const start = Number(range.replace(/\D/g, ""));
    const end = Math.min(start + chunkSize, videoSize - 1);

    const head = {
      "Content-Type": "video/mp4",
      "Content-Length": end - start + 1,
      "Accept-Range": "bytes",
      "Content-Range": `bytes ${start}-${end}/${videoSize}`,
    };

    res.writeHead(206, head);
    const videoStream = fs.createReadStream(videoPath, { start, end });
    videoStream.pipe(res);
  } else {
    // header
    console.log("stream");
    const head = {
      "Content-Type": "video/mp4",
      "Content-Length": videoSize,
    };
    res.writeHead(200, head);
    const readStream = fs.createReadStream(videoPath);
    readStream.pipe(res);
  }
});

app.get("/", (req, res) => {
  res.send('<h2>Visit <a href="/video">/video</a> to stream video.</h2>');
});
app.listen(3000, () => {
  console.log("✅ Server running at http://localhost:3000");
});
