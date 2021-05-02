## 🔎 Simple Search Engine

- ✔ A web app written in ruby on rails along with postgresql.
- ✔ Supports user signup/login + auth.
- 🔳 The users sessions are cahched in redis.
- 🔳 The user can search for a word.
- - The user enters a url to start crawling from and a word to search for.
	- A custom algorithm would start crawling then indexing (inverted index).
	- The output is then returned to the user: 1) The whole index.  2) The index of the word he searched for.
- 🔳 All users' searches are saved.
- 🔳 Use elastic search beside my algorithm and compare the performance.
