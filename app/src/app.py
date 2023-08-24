from fastapi import FastAPI, Request, Response, status, BackgroundTasks, HTTPException
from fastapi_utils.tasks import repeat_every
from fastapi.responses import JSONResponse
from contract import EventList
import numpy as np
import json
import uvicorn

app = FastAPI(
    title="data-sportsball-events",
    description="Provides up to date details on this weeks upcoming Sportsball events",
    version='2.1.3',
    root_path="/sportsball-events"
)

with open('events.json') as f:
    events = json.load(f)


@app.on_event("startup")
@repeat_every(seconds=3600)
async def refresh_dummy_data():
    total_users = events['events'][0]['all_registered'] + 3
    i = 0
    for event in events['events']:
        event['home_users'] = np.random.randint(11369, 12000)
        event['away_users'] = np.random.randint(0, 2400)
        event['all_users'] = event['home_users'] + event['away_users']
        event['all_registered'] = total_users
        events['events'][i] = event
        i += 1


@app.get("/health", status_code=status.HTTP_200_OK)
async def health_check():
    return Response(status_code=200)


@app.get('/events', status_code=200, description='Get a list of the upcoming sportsball events for the current week',
         response_model=EventList)
def get_current_week_events():
    return JSONResponse(content=events, status_code=200)


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
