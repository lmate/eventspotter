import { HTMLToJSON } from 'html-to-json-parser';
import PocketBase from 'pocketbase';

const requestUrl = 'https://partyajanlo.hu/services/embed/index_api.php?city=Budapest&type=&side='

const url = 'https://places.pockethost.io/'
const pb = new PocketBase(url)
const authData = await pb.admins.authWithPassword(process.env.DB_EMAIL, process.env.DB_PASSWORD);

async function getEventsForDate(date) {
  let fetchingPage = 1
  let allEvents = [...(await getEvents(fetchingPage))]

  while (allEvents.at(-1).startDate.split('T')[0] == date) {
    fetchingPage++
    allEvents = [...allEvents, ...(await getEvents(fetchingPage))]
  }

  const newAllEvents = []
  for (const event of allEvents) {
    if (event.startDate.split('T')[0] == date) {
      newAllEvents.push(event)
    }
  }
  allEvents = newAllEvents

  return allEvents
}

async function getEvents(page) {
  let response = await fetch(`${requestUrl}${page == 1 ? '' : page}`)
  let result = await response.text()

  let parsed = await HTMLToJSON(result, false)

  let newparsed = []
  for (const record of parsed.content) {
    if (typeof record !== 'string') {
      if (record.type === 'script') {
        newparsed.push(JSON.parse(record.content.toString()
          .replace(/(\r\n|\n|\r)/gm, " ")
          .replace(/\s\s+/g, ' ')
          .replaceAll("\\'", '')
          .replaceAll("@", ''))
        )

        delete newparsed.at(-1).image
        delete newparsed.at(-1).context
        delete newparsed.at(-1).type
        delete newparsed.at(-1).performer
        delete newparsed.at(-1).location.type
      }
    }
  }
  parsed = newparsed

  return parsed
}

async function getEventsForToday() {
  try {
    console.log(new Date().toISOString().split('T')[0])
    return await getEventsForDate(new Date().toISOString().split('T')[0])
  } catch (e) {
    console.log('valmai error, nyilvan... Trying again in 30 seconds')
    setTimeout(startGetDailyPlaces, 30000)
  }
}

export default async function startGetDailyPlaces() {
  let eventsForToday = await getEventsForToday()

  if (!getEventsForToday) {
    return
  }

  let today = new Date().toISOString().split('T')[0]
  console.log(`Running getDailyPlaces - ${new Date().toISOString()}`)

  for (let i = 0; i < eventsForToday.length; i++) {
    setTimeout(async () => {
      let response
      if (!eventsForToday[i].location.name.toLowerCase().includes('budapest')) {
        response = await fetch(`https://geocode.maps.co/search?q=${eventsForToday[i].location.name}+Budapest+Hungary&api_key=6638ba211b71e107446338ldq446418`)
      } else {
        response = await fetch(`https://geocode.maps.co/search?q=${eventsForToday[i].location.name}&api_key=6638ba211b71e107446338ldq446418`)
      }
      let result = await response.json()

      if (result[0] == undefined) {
        upladPlaceToDb(eventsForToday[i], 0, 0, today)
      } else {
        upladPlaceToDb(eventsForToday[i], parseFloat(result[0].lat), parseFloat(result[0].lon), today)
      }

    }, i * 3000)
  }

  setTimeout(async () => {
    console.log(`getDailyPlaces done! - ${new Date().toISOString()}`)
  }, 2000 * (eventsForToday.length + 5))
}

async function upladPlaceToDb(event, lat, lng, today) {
  try {
    const data = {
      "name": event.name,
      "start": event.startDate,
      "date": today,
      "url": event.url,
      "location_name": event.location.name,
      "address": event.location.address,
      "lat": lat,
      "lng": lng,
      "description": event.description
    };

    await pb.collection('places').create(data, { requestKey: null });
  } catch (e) {
    console.log(`Uploading to DB failed with error: ${e}`)
  }
}