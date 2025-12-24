const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 8080;
const directory = __dirname;

const server = http.createServer((req, res) => {
  let filePath = path.join(directory, req.url === '/' ? 'game.html' : req.url);
  
  // Security: prevent directory traversal
  if (!filePath.startsWith(directory)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }
  
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('File not found');
      return;
    }
    
    const ext = path.extname(filePath);
    const contentType = ext === '.html' ? 'text/html' : 
                       ext === '.js' ? 'application/javascript' :
                       ext === '.css' ? 'text/css' :
                       ext === '.png' ? 'image/png' :
                       ext === '.jpg' || ext === '.jpeg' ? 'image/jpeg' :
                       ext === '.gif' ? 'image/gif' : 'text/plain';
    
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(data);
  });
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});
