import { HTMLToJSON } from 'html-to-json-parser';
import { initializeApp } from 'firebase/app';
import 'dotenv/config'
import { getDatabase, ref, set, child, get } from "firebase/database";

const firebaseConfig = {
  apiKey: process.env.FB_APIKEY,
  authDomain: process.env.FB_AUTHDOMAIN,
  databaseURL: process.env.FB_DATABASEURL,
  projectId: process.env.FB_PROJECTID,
  storageBucket: process.env.FB_STORAGEBUCKET,
  messagingSenderId: process.env.FB_MESSAGINGSENDERID,
  appId: process.env.FB_APPID
};

const app = initializeApp(firebaseConfig);

const requestUrl = 'https://partyajanlo.hu/services/embed/index_api.php?city=Budapest&type=&side='

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
    return await getEventsForDate(new Date().toISOString().split('T')[0])
  } catch (e) {
    console.log('valmai error, nyilvan... Trying again in 30 seconds')
    setTimeout(getEventsForToday, 30000)
  }
}

async function start() {
  await set(ref(getDatabase(), `places/${new Date().toISOString().split('T')[0]}`), await getEventsForToday());

  /* Get just uploaded events for testing
  await get(child(ref(getDatabase()), `places/${new Date().toISOString().split('T')[0]}`)).then((snapshot) => {
    console.log(snapshot.val());
  });*/

  return
}
start()
