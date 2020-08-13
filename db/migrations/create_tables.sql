CREATE TABLE IF NOT EXISTS "spaces" (
  "id" serial primary key,
  "name" varchar(60),
  "price" decimal(12,2),
  "description" varchar(280),
  "availability_start" date,
  "availability_end" date,
  "host_id" integer,
  "bookable" boolean default TRUE,
  "published" timestamp default (now() at time zone 'utc')
);

CREATE TABLE IF NOT EXISTS "users" (
  "id" serial primary key,
  "name" varchar(60),
  "email" varchar(60),
  "password" varchar(60)
);

CREATE TABLE IF NOT EXISTS "requests" (
  "id" serial primary key,
  "space_id" integer,
  "guest_id" integer,
  "start_date" date,
  "end_date" date,
  "response_date" timestamptz,
  "accepted" boolean default NULL
);

CREATE TABLE IF NOT EXISTS "user_messages" (
  "id" serial primary key,
  "thread_id" integer,
  "message_id" integer,
  "user_id" integer
);

CREATE TABLE IF NOT EXISTS "message" (
  "id" serial primary key,
  "content" varchar(280),
  "published" date,
  "poster_id" integer
);

ALTER TABLE "requests" ADD FOREIGN KEY ("space_id") REFERENCES "spaces" ("id");

ALTER TABLE "requests" ADD FOREIGN KEY ("guest_id") REFERENCES "users" ("id");

ALTER TABLE "spaces" ADD FOREIGN KEY ("host_id") REFERENCES "users" ("id");

ALTER TABLE "user_messages" ADD FOREIGN KEY ("thread_id") REFERENCES "requests" ("id");

ALTER TABLE "user_messages" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "user_messages" ADD FOREIGN KEY ("message_id") REFERENCES "message" ("id");
