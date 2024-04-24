import { HTMLToJSON } from 'html-to-json-parser';

const requestUrl = 'https://partyajanlo.hu/services/embed/index_api.php?city=Budapest&type=&side='

async function getEventsForToday(page) {

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
  
  console.log(parsed)
}

getEventsForToday(1)