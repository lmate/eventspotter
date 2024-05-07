import PocketBase from 'pocketbase';
import express from 'express';
import startGetDailyPlaces from './getDailyPlaces.js';

const app = express()
const port = 3000

const url = 'https://places.pockethost.io/'
const pb = new PocketBase(url)
const authData = await pb.admins.authWithPassword(process.env.DB_EMAIL,process.env.DB_PASSWORD);


app.get('/api/places/today', async (req, res) => {
  const places = await pb.collection('places').getFullList({
    filter: `date = "${new Date().toISOString().split('T')[0]}"`,
  });
  res.json(places)
})

app.get('/api/getdailyplaces', async (req, res) => {
  const places = await startGetDailyPlaces()
  console.log(places)
  res.send(JSON.stringify(places))
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})