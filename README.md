 # The Challenge

Sportsball wagering provides a great source of entertainment for people in the country of Bettorvania.

There are 16 teams in the Major Sportsball League and they are spread across 12 provinces. We currently provide wagering services for 4 of those provinces: Regensland, Alterburg, Vistatown, and Boroughsville.

For this technical challenge we are asking you to deliver a model which can predict the number of dollars wagered (a.k.a. "handle") on the matches in week 12 of the 2020 season. To do so, you will craft a sql query using pgAdmin to pull a feature set (some hints on useful features are provided in the text), then build a data science model (or a couple of models if you like and there is time) to predict that handle.

This problem is simplified for the sake of time but is representative of actual project work that we do here at Penn Interactive/TheScore Bet.

Please do not spend more than 4 hours on this challenge. Don't let this take up your whole weekend. We understand that you could likely spend days on this, but we are more interested in seeing your thought process than the actual final model. If you find yourself getting close to time, focus on providing insights into your thoughts in the write-up portion.

### Requirements

To complete this challenge, you will need docker and docker-compose installed on your computer.

If you do not already have these tools, we recommend using Docker Desktop:

* Mac: https://docs.docker.com/desktop/install/mac-install/
* Windows: https://docs.docker.com/desktop/install/windows-install/
* Linux: https://docs.docker.com/desktop/install/linux-install/

# Setup

We've provided a `docker-compose.yml` file which will create everything you need to complete this challenge. To setup your environment, simply navigate in your Command Prompt/Terminal to the directory where you unpacked these files and run `docker-compose up -d`. This may take a minute to finish running, especially if it's your first time running it.

## The Database

After `docker-compose up -d` has finished, you will have access to a Postgres Database and PGAdmin to play around with the data. To access PGAdmin, navigate to `localhost:5050` in your web browser. From here, you will need to configure a connection to the the server. You can do this by selecting "Add New Server" from the dashboard.sa

Connection Details:

* host: `local_pg`
* port: `5432`
* user: `postgres`
* password `postgres`

The database has 3 tables:

### `events` (`SELECT * FROM events`) - Data for the Sportsball events

| Column Name            | Data Type | Description                            |
|------------------------|-----------|----------------------------------------|
| event_id (primary_key) | VARCHAR   | Unique id given to the event           |
| home_team              | VARCHAR   | The home team for the event            |
| away_team              | VARCHAR   | The away team for the event            |
| home_team_location     | VARCHAR   | Base city for the home team            |
| away_team_location     | VARCHAR   | Base city for the away team            |
| day_of_week            | VARCHAR   | day of the week ('Sunday' etc)         |
| time_slot              | VARCHAR   | Categorical indicating time/day grouping     |
| game_day               | TIMESTAMP | Game date (EST)                              |
| game_start_time        | TIMESTAMP | Start time of the event (EST)          |
| week_start             | TIMESTAMP | Start time for this week of the season (EST) |
| week_of_season         | FLOAT     | Week number of the season              |

### `users` (`SELECT * FROM users`) - User demographic data

| Column Name               | Data Type | Description                                 |
|---------------------------|-----------|---------------------------------------------|
| user_number (primary_key) | VARCHAR   | Unique identifier for the user              |
| age                       | FLOAT     | User age in years                           |
| registration_timestamp    | TIMESTAMP | Datetime the user registered for the sportsbook (EST)|
| location                  | VARCHAR   | Where the user resides                      |

### `wagers` (`SELECT * FROM wagers`) - Data on the individual wagers placed on Sportsball games

| Column Name           | Data Type | Description                             | Additional Resources                                                                                                                                                                                |
|-----------------------|-----------|-----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| bet_id (primary_key)  | INTEGER   | Unique identifier for the bet            |
| user_number           | VARCHAR   | Unique identifier for the user           |                                                                                                                                             |
| event_id              | VARCHAR   | Event the bet was placed on             |                                                                                                                                                                                                     |
| bet_offer_type_name   | VARCHAR   | Describes the type of bet placed        | https://www.actionnetwork.com/education/point-spread (Spread)  https://www.actionnetwork.com/education/over-under-total (Over/Under)  https://www.actionnetwork.com/education/moneyline (Outright) |
| wager_amount          | FLOAT     | Amount in USD bet                       |                                                                                                                                                                                                     |
| outcome_decimal_odds  | FLOAT     | The odds of the bet in decimal format   | https://www.actionnetwork.com/education/decimal-odds                                                                                                                                                |
| outcome_american_odds | FLOAT     | The odds of the bet in american format  | https://www.actionnetwork.com/education/american-odds#Read                                                                                                                                          |
| bet_placed_time       | TIMESTAMP | Time the bet was placed (EST)                |                                                                                                                                                                                                     |
| bet_status            | VARCHAR   | Whether or not the bet has settled       |                                                                                                                                                                                                     |
| bet_result            | VARCHAR   | Outcome of the bet                      |                                                                                                                                                                                                     |
| payout                | FLOAT     | Payout amount in USD if the bet was won |                                                                                                                                                                                                     |

## Jupyter Server

The compose file also creates a Jupyter Server instance for you to use. You can access it by navigating to `localhost:8888?token=sports` in your web browser.

### Adding to your environment
We have taken the liberty of installing some basic DS packages in Jupyter for you (Pandas, Matplotlib, Scikit-learn, and Statsmodels). If you would like to install additional packages, add them to the `requirements.txt` file found in this repo.
For the changes to take affect you will need to first kill any running services with `docker-compose down`. Then, simply rebuild and rerun the containers by first running `docker-compose build` and then `docker-compose up -d`

### Code

All code and the writeup should be written in the provided `handle_forecast.ipynb` file.

# Challenge Structure

These three sections are noted in `handle_forecast.ipynb`

### Part 1 - SQL Feature Pull

We are interested in seeing your ability to use SQL to create feature sets based on data from multiple tables. What those features are is entirely up to you.

It is important that the SQL you use for your feature pull is included in the Jupyter notebook so that we can review it.  Before getting into the data and crafting your query, it may be worthwhile to review the "some tips" section in the Jupyter notebook.  You do not have to follow any of these tips if you don't want to or have a different approach, but they might be useful.

### Part 2 - The Model

You have free reign to develop any kind of model that you wish, given the time constraints and suitability to the problem.  Most importantly, we want to know how you approach a problem - let us know why you made the decision(s) you did.

### Part 3 - Write-up

This is the real meat of the challenge.  Using markdown cells in the Jupyter notebook, let us know what you did, what you would have liked to do, and what kind of limitations and problems you encountered in the process.  How do you feel about the results?  If you had more time, how would you have liked to improve upon your model?

# Submission

Your submission will be assessed on the quality of the SQL and/or pandas used to prepare the feature set, EDA, creativity and relevancy of the feature engineering, appropriate use of data-preprocessing, choice of metrics, model performance, and *overall quality / thought process shown in the writeup*.

When you have completed the challenge, rename the the .ipynb file to `<your-name>_handle_forecast.ipynb` and email back to the recruiter.
