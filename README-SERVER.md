# Running the Game with Auto-Refresh

To enable automatic browser refresh after code changes:

1. **Start the server** (choose one method):
   - If you have Node.js: Run `node server.js` in this directory
   - If you have Python: Run `python -m http.server 8080` in this directory
   - Or use any other local web server on port 8080

2. **Open the game**: Navigate to `http://localhost:8080/game.html` in your browser

3. **Auto-refresh**: The browser extension will automatically refresh the page after each code change.

Note: The game must be served via HTTP (not file://) for the browser extension to work properly.


