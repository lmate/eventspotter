import PocketBase from 'pocketbase';
import express from 'express';

const app = express()
const port = 3000

const url = 'https://places.pockethost.io/'
const pb = new PocketBase(url)
const authData = await pb.admins.authWithPassword(process.env.DB_EMAIL,process.env.DB_PASSWORD);


app.get('/api/places/:date', (req, res) => {

  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})