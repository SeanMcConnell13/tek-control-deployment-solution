const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.json({ ok: true, service: 'secure-demo-app', time: new Date().toISOString() });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Secure Node.js container listening on ${port}`);
});
