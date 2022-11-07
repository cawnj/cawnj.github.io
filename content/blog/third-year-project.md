---
title: "Sonic - 3rd Year University Project"
date: 2022-08-21T23:56:09+01:00
---

A short summary of what the project is and how it was implemented.

## What is Sonic?

Sonic is a system my project partner [Jason](https://www.linkedin.com/in/jason-henderson-837258216/) and I designed for our third-year project at university. It was a solution to a problem we were facing often at the time, which was COVID contact tracing, and how to efficiently implement this.
Sonic consists of a Go REST API, a PostgreSQL database, NFC cards and both Python and React Native clients.

The idea was to enable contact tracing in, for example, a restaurant, via NFC cards - imagine tapping while getting on and getting off a train, for instance, the same idea applies here. Users would tap their card on a scanner device on entry and exit, and if they test positive for COVID, they can use the app to anonymously send a notification to every other person who was in the building at the time, so that they are aware that they may be a close contact.

*NOTE: The name "Sonic" comes from the video game character of course, because of his speed. Speed was a big goal in implementing this project.*


## What the system looks like

![](/sonic/topology.jpg 'Sonic Topology')

In the above image, we can see the different parts of the Sonic system, which include:
- a Raspberry Pi NFC Scanner, running Python
- a React Native frontend app
- use of Cloudflare, for DNS and added security
- a Traefik reverse proxy, for HTTPS
- a PostgreSQL database
- a Go REST API
- use of Firebase API, for authentication
- use of Expo API, for notifications


## The Raspberry Pi NFC scanner

![](/sonic/scanner.jpg 'Raspberry Pi NFC scanner')

The NFC scanner is a Raspberry Pi 3B+ with a Waveshare PN532 NFC HAT providing the scanning functionality.

This Raspberry Pi on boot would run a Python script that would scan and parse a given user ID that would be stored on an NFC card. It would then send a POST request to the `/entrylog` endpoint of the Go REST API, containing the user ID and current timestamp, which will then be processed on the server side.


## The Go REST API

The Go REST API was implemented using the [go-chi](https://github.com/go-chi/chi) router, and has 8 different endpoints:
- `GET: /health` - to check for the alive-ness of the service
- `GET: /user` - get a given user's info
- `GET: /users` - get info on all users
- `GET: /locations` - get info all locations
- `POST: /entrylog` - writes entry/exit info to database
- `POST: /trace` - finds and notifies all close contacts of a given user
- `POST: /register` - registers a new user
- `GET: /latestlocation` - gets a users latest location


## The React Native App

![](/sonic/app.png 'React Native App')

The app enables users to notify other potential close contacts if they test positive by clicking the *"I Have Covid"* button. This sends a POST request to the `/trace` endpoint of the API, containing the user ID, which will then go ahead and notify the close contacts of that user. The app also contains both login and registration functionality, enabled by both the Go REST API and the Firebase API.


## The NFC Card

![](/sonic/nfc-card.jpg 'NFC Card')

The NFC card used is an NTAG215. It simply stores a user ID as a string and is formatted using NDEF.


## The PostgreSQL database

The PostgreSQL database stores basic info on users, locations, and entry/exit times logged via Sonic.

### Tables

#### `users`
![](/sonic/db-users.png 'Users table')

#### `locations`
![](/sonic/db-locations.png 'Locations table')

#### `entrylog`
![](/sonic/db-entrylog.png 'Entrylog table')


## Tooling

We used the opportunity of this project to learn more about tooling and DevOps. Some examples of tools we used to ease development, testing and deployment:
- docker
- docker-compose
- make
- traefik

I loved experimenting and getting better at using the tools above, DevOps is a field I am highly interested in and making use of these made the development process a lot easier.


## Conclusion

The project was done alongside our other college work and took us around 4 months including planning, and about 1 month was spent dedicating most of our time purely to development. It was challenging at times, but interesting enough that we did enjoy implementing and completing this project. The project was received well overall, with us getting an A grade for our work, which we were both very pleased with.

Thanks for reading!
