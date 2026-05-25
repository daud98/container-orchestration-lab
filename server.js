const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('API Operational'));

const server = app.listen(port, () => console.log(`Server running on port ${port}`));

// Handle graceful shutdown for Task 5
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
    process.exit(0);
  });
});