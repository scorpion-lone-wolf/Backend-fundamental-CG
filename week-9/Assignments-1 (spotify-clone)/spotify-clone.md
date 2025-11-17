# Music Streaming Service (Spotify Clone)

## Assignment Overview

Build a music streaming service that demonstrates audio streaming capabilities using range requests and partial content delivery.

---

## Requirements

### 1. Server Setup

- Create a web server using Node.js (or your preferred language)
- Store a few music files on the server
- Ensure the server is capable of handling HTTP range requests

### 2. Streaming Endpoint

- Implement partial content (range requests) functionality
- Enable the client to stream audio efficiently
- Return proper HTTP headers for partial playback
- Support resumable downloads and seeking

### 3. Client Player

- Create a basic frontend page
- Implement an audio player using:
  - HTML5 `<audio>` element, OR
  - Custom player logic for enhanced control
- Ensure the player can communicate with the streaming endpoint

### 4. Verification

Test your implementation thoroughly:

- **Playback Control**: Verify pause, seek, and resume functionality
- **Network Inspection**: Check network requests to confirm:
  - Partial file requests are being made
  - Range headers are properly sent and received
  - The server responds with `206 Partial Content` status code

---

## Deliverables

1. **Working Server**

   - Functional server that streams music files
   - Proper implementation of range request handling

2. **Client Interface**

   - Simple HTML page with audio player
   - Ability to play streamed music files
   - Functional playback controls

3. **Documentation** (optional but recommended)
   - Brief explanation of your implementation
   - Instructions to run the project
   - List of dependencies

---

## Technical Concepts to Implement

- HTTP Range Requests
- Partial Content (HTTP 206)
- Audio streaming
- Client-server communication
- Media playback controls

---

## Evaluation Criteria

- Correct implementation of range requests
- Smooth audio playback experience
- Clean and organized code
- Proper error handling
- Working pause/seek/resume functionality

---

## Getting Started

1. Set up your development environment
2. Create the server with streaming capabilities
3. Build the client interface
4. Test thoroughly with different audio files
5. Verify network behavior using browser DevTools

Good luck!
