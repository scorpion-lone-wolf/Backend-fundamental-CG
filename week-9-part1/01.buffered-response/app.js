// -------------------- Buffered Response means loading all the content inmemory before sending the response ------------------
// app.js
const express = require("express");
const fs = require("fs");
const path = require("path");
const app = express();
const pdfFileName = "sample.pdf";
const txtFilename = "sample.txt";
app.get("/pdf", (req, res) => {
  const filePath = path.join(__dirname, pdfFileName);

  // Read the entire file into memory (buffered)
  fs.readFile(filePath, (err, data) => {
    if (err) {
      console.error(err);
      return res.status(500).send("Error reading PDF file");
    }

    // Set headers for PDF
    res.setHeader("Content-Type", "application/pdf");
    res.setHeader("Content-Disposition", `inline; filename="${pdfFileName}"`); // this will open and view the pdf in same browser
    //res.setHeader("Content-Disposition", `attachment; filename="${pdfFileName}"`); // this will download the pdf.

    res.send(data); // Send entire file as response
  });
});

app.get("/txt", (req, res) => {
  const filePath = path.join(__dirname, txtFilename);
  // Read the entire file into memory (buffered)
  fs.readFile(filePath, (err, data) => {
    if (err) {
      console.error(err);
      return res.status(500).send("Error reading txt file");
    }

    // Set headers for txt
    res.setHeader("Content-Type", "text/plain");
    res.send(data); // Send entire content as response
  });
});

app.get("/", (req, res) => {
  res.send("Visit /pdf to view the PDF file and /txt to view the txt file");
});

app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
