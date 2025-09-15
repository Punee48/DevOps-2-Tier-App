const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors()); // allow frontend to call backend from different origin in local testing

app.get('/api', (req, res) => {
  res.json({ message: 'Hello from backend!', time: new Date().toISOString() });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Backend listening on port ${PORT}`));