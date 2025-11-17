const fs = require("fs");

async function createBigFile() {
  const filePath = "bigfile.txt";

  // Create a writable stream — this allows us to write data to the file
  // in small chunks instead of loading everything into memory at once.
  const writeStream = fs.createWriteStream(filePath);

  for (let i = 0; i < 1000000; ++i) {
    const data = `This is Line no - ${i + 1}\n`;

    // Attempt to write the current chunk into the stream's internal buffer.
    // writeStream.write() returns:
    //   → true  → buffer still has space, keep writing
    //   → false → buffer is full, need to wait before writing more
    if (!writeStream.write(data)) {
      // Wait until the 'drain' event fires — meaning the buffer
      // has been flushed (written to disk) and is ready for more data.
      await new Promise(resolve => writeStream.once("drain", resolve));
    }
  }

  // Signal that we are done writing data to the file.
  // This flushes any remaining buffered data and closes the stream.
  writeStream.end();

  console.log("✅ bigfile.txt created successfully");
}

createBigFile();
