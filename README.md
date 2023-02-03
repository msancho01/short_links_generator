# ShortLinks Generator

ShortLink generator is a simple URL shortening service that allows you to shorten long URLs into short and memorable links.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
You will need to have the following installed on your system:

* Ruby (version 3.1.2)
* Rails (version 7 or higher)
* Sidekiq (version 6.5.8 or lower)

### Installation

1. Clone the repository to your local machine:
```git clone https://github.com/msancho01/short_links_generator.git```

2. Navigate to the project directory:
```cd short_links_generator```

3. Install the dependencies:
```bundle install```

4. Start the Redis service:
```brew services start redis```
> if Redis is not installed run this command and then validate if service is already running:
```brew install redis```

5. Create and set up the database:
```
rails db:create
rails db:migrate
rails db:seed
```

6. Start the development server:
```rails server```

7. Open a new terminal and navigate to the project and Start the Sidekiq server
``` bundle exec sidekiq ```

### Usage

To use ShortLink Generator,
* To create a ShortLink simply send an API request to `http://localhost:3000/short_links` and send a JSON with the url you want to shorten.
```
{
    "long_url": "https://www.example.com"
}
```

* To navigate to the Top 100 most used ShortLinks, open `http://localhost:3000` in your preferred browser

* To open a ShortLink and be redirected to the original URL, just navigate to `http://localhost:3000/`+ the token generated in the system
