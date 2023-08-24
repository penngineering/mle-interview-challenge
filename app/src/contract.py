from pydantic import BaseModel
from typing import List


class Event(BaseModel):
    home_team: str
    away_team: str
    time_slot: str
    week_of_season: int
    home_users: int
    away_users: int
    all_users: int
    all_registered: int


class EventList(BaseModel):
    events: List[Event]
