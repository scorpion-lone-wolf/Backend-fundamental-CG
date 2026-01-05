# Build a Real-Time Log Streamer

## Assignment Overview

Build a real-time log streaming application that pushes server-side log messages to connected clients instantly.

---

## Requirements

### 1. Server Setup

- Create a web server
- Prepare a data source for log messages (could be an array, a file, or generated strings)

### 2. Real-Time Streaming

- Use a method to push new log entries to the client as they appear (Server-Sent Events or a similar approach)
- Keep the connection open so new messages are automatically sent

### 3. Client Viewer

- Build a minimal page that subscribes to the log stream
- Display each new log entry in real time

### 4. Verification

- Ensure logs appear as soon as they are generated
- Confirm that the connection stays active over time

---

## Deliverables

1. A server endpoint that sends new log messages continuously
2. A client page that shows each incoming log message right away

---

## Notes

This assignment focuses on implementing real-time communication between server and client. Choose appropriate technologies and methods that best demonstrate streaming capabilities.
