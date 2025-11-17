import cors from "cors";
import express from "express";
import fs from "fs";
import { readdir } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "url";

const app = express();
const PORT = 3000;
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const SONGS_DIR = path.join(__dirname, "songs");

app.use(cors());
app.get("/", (req, res) => {
  res.send("Welcome to spotify clone");
});

/**
 * This endpoints returns list of all songs from songs folder
 */
app.get("/songs", async (req, res) => {
  try {
    const files = await readdir(SONGS_DIR);
    const allSongOnlyFiles = files.filter(f => {
      if (f.endsWith(".mp3") || f.endsWith(".wav") || f.endsWith(".ogg") || f.endsWith(".m4a"))
        return f;
    });

    res.json({
      status: 200,
      message: "All audio fetch successfully",
      data: allSongOnlyFiles,
    });
  } catch (error) {
    console.log(error);
  }
});

app.get("/songs/:id", async (req, res) => {
  try {
    const requestedAudio = req.params.id;
    const requestedAudioPath = path.resolve(SONGS_DIR, requestedAudio);

    // calculating file size
    const fileSize = fs.statSync(requestedAudioPath).size;
    const range = req.headers.range;

    const ext = path.extname(requestedAudioPath).toLowerCase();
    const mime =
      ext === ".mp3"
        ? "audio/mpeg"
        : ext === ".wav"
        ? "audio/wav"
        : ext === ".ogg"
        ? "audio/ogg"
        : ext === ".m4a"
        ? "audio/mp4"
        : "application/octet-stream";
    if (range) {
      const parts = range.replace(/bytes=/, "").split("-");
      const start = parseInt(parts[0], 10);
      const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
      const chunkSize = end - start + 1;

      const head = {
        "Content-Type": mime,
        "Content-Length": chunkSize,
        "Accept-Range": "bytes",
        "Content-Range": `bytes ${start}-${end}/${fileSize}`,
      };
      res.writeHead(206, head);
      fs.createReadStream(requestedAudioPath, { start, end }).pipe(res);
    } else {
      res.writeHead(200, {
        "content-length": fileSize,
        "content-type": mime,
        "Accept-Ranges": "bytes",
      });

      fs.createReadStream(requestedAudioPath).pipe(res);
    }
  } catch (error) {
    console.error("Stream error : ", error);
    res.status(500).send("Server error");
  }
});

app.listen(PORT, () => {
  console.log("Server started...");
});
