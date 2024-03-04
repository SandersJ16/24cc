CREATE TABLE "Parctipant" (
  "participant_id" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "date_of_birth" timestamp,
  "height" integer
);

CREATE TABLE "Event" (
  "event_id" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "date" date
);

CREATE TABLE "Team" (
  "team_id" integer PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE "Activity" (
  "activity_id" integer PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" varchar
);

CREATE TABLE "EventActivity" (
  "event_activity_id" integer PRIMARY KEY,
  "activity_id" integer,
  "event_id" integer,
  "score_modifer" double
);

CREATE TABLE "EventParticipant" (
  "team_participant_event_id" integer PRIMARY KEY,
  "team_id" integer,
  "participant_id" integer NOT NULL,
  "event_id" integer NOT NULL,
  "start_weight" integer,
  "end_weight" integer,
  "goals" varchar
);

CREATE TABLE "ParticipantActivity" (
  "participant_activity_id" integer PRIMARY KEY,
  "participant_id" integer NOT NULL,
  "event_activity_id" integer NOT NULL
);

CREATE UNIQUE INDEX ON "EventActivity" ("activity_id", "event_id");

CREATE UNIQUE INDEX ON "EventParticipant" ("participant_id", "event_id");

CREATE UNIQUE INDEX ON "ParticipantActivity" ("participant_id", "event_activity_id");

ALTER TABLE "EventActivity" ADD FOREIGN KEY ("activity_id") REFERENCES "Activity" ("activity_id");

ALTER TABLE "EventActivity" ADD FOREIGN KEY ("event_id") REFERENCES "Event" ("event_id");

ALTER TABLE "EventParticipant" ADD FOREIGN KEY ("team_id") REFERENCES "Team" ("team_id");

ALTER TABLE "EventParticipant" ADD FOREIGN KEY ("participant_id") REFERENCES "Parctipant" ("participant_id");

ALTER TABLE "EventParticipant" ADD FOREIGN KEY ("event_id") REFERENCES "Event" ("event_id");

ALTER TABLE "ParticipantActivity" ADD FOREIGN KEY ("participant_id") REFERENCES "Parctipant" ("participant_id");

ALTER TABLE "ParticipantActivity" ADD FOREIGN KEY ("event_activity_id") REFERENCES "EventActivity" ("event_activity_id");
