## 🔎 Simple Search Engine

- ✔ A web app written in ruby on rails along with postgresql.
- ✔ Supports user signup/login + auth.
- ✔ The users sessions are cahched in redis.
- ✔ The user can search for a word.
- - The user enters: 1) A word to search for 2) A url to start crawling from 3) The number number of pages to crawl.
	- A custom algorithm would start crawling then indexing (inverted index).
	- The output is then returned to the user: 1) The whole index.  2) The index of the word he searched for.
- ✔ All users' searches are saved.
- 🔳 Use elastic search beside my algorithm and compare the performance.




### Some notes:

- DB:
- - You need to install postgres before running this app. By default postgres adds a new user to the system. Through which you can access psql(the postgres terminal).
- - After installing, write in the cmd `sudo -i -u postgres` to switch to postgres user. You might be prompt to enter a password (default is `postgres` and you can change it.)
- - Now if you write `psql`, you will enter the postgres command line.
- - Write `exit` to exit the command line. Then another `exit` to exit the postgres user.
- - The root user in postgres is "postgres" user We want to make another user for our app with a password.
- - `sudo -u postgres createuser <user name>` This command creates a new user with the specified user name.
- - Now we need to give it a password. `sudo -i -u postgres` then `psql` then `\password <user name>` then enter the password.
- - Now create 3 databases with names: &lt;name&gt;_development - &lt;name&gt;_production - &lt;name&gt;_test using the command `CREATE DATABASE <name>_<env> OWNER rubyuser;` (use `simple_search_engine` as the name to be consistent)
- - Now, if you want to access the command line interface for the db write: `psql -U <user name> -d <dbname>`
- - In rails app add local_env.yml file in the "config/" directory. It will be like this:
		<code>
		DATABASE_USERNAME: '&lt;user name&gt;'
		DATABASE_PASSWORD: '&lt;password&gt;'
		</code>
- - In "database.yml" add the `  username: <%= ENV.fetch("DATABASE_USERNAME")%>` and `password: <%= ENV.fetch("DATABASE_PASSWORD")%>` under all the environments

- Redis
- - You should have redis installed.
- - You should make sure that the service is running specially if you're using WSL `sudo service redis-server start`
- - To access redis cli use `redis-cli` command.
- - In "/config/environments/*.rb" and search for the line `if Rails.root.join('tmp', 'caching-dev.txt').exist?` then go to the else statement and change the line `config.cache_store = :null_store` to `config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }` and set `config.action_controller.perform_caching = false` to true and lastly add this line `config.session_store :cache_store, key: ENV['APP_SESSION_KEY']` outside the else scope. (If you pulled the repo, you would find this already done)
- - Add `REDIS_URL: "redis://127.0.0.1:6379/0"` to your "local_env.yml". This is the connection url for Redis.
- - Add `APP_SESSION_KEY: "<key name>"` to "local_env.yml". This would be the name of the cookie that's sent to the user to carry his ID in the cache store (session storage)
- - Make sure that the gems 'redis' and 'hiredis' are in your gem file and installed using `bundle install`
- - Take a look at this answer to have a breif understanding of how redis is used in session storage for user auth instead of visiting the db. <a href="https://stackoverflow.com/questions/39601527/how-session-works-in-rails#answer-39602237">Stack overflow answer</a>. <br/>
	<a href="https://kirillshevch.medium.com/configuration-cache-and-rails-session-store-with-redis-b3ce6f64d1fc">Also this link might be useful for the setup</a>
- - Check that Redis is working by entering the redis-cli then `KEYS *`. If a user is logged in you would find his session.