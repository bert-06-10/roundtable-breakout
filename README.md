# Roundtable

A short guided flow to open a group discussion: name the session, pick a
facilitator, introductions with an optional quiet timer, an opening
question, then a free discussion screen with a pull-out list of backup
questions if the conversation stalls. Built for everyone in a breakout
group to open the same link on their own device.

Live at https://roundtable-prototype-rose.vercel.app

## Running it

Static, single-file, no build step — just open `index.html` in a browser,
or serve the folder with any static server (`.claude/launch.json` runs one
via `python3 -m http.server`).

## Starting a session

The first screen asks for a session name (e.g. `tuesday-standup`), appended
to the URL as `?session=<name>`. This is deliberately shared across every
breakout group in the event — `?session=<name>&taps=1` shows one combined
tally of backup-question taps for everyone using that session name,
regardless of which breakout group they were in.

## Picking a facilitator per breakout group

Whoever first opens the link for a given breakout table hits the "Pick a
facilitator" screen and either names a volunteer or has the app spin
through a typed-in roster to choose one at random. That device then gets a
room-scoped link (`&room=<code>`, auto-generated, distinct from the shared
session name) to send to the other 4 people at that table. Anyone opening
the room-scoped link sees the same facilitator result immediately — synced
via Supabase — and skips straight past the picker. Different breakout
groups never see each other's rosters or results, even while sharing one
session name for taps.

## Notes

- All facilitator-editable content (`OPENING_QUESTION`, `BACKUP_QUESTIONS`)
  lives at the top of the `<script>` block in `index.html`.
- Tap counts (`question_taps` table) and facilitator picks (`rooms` table)
  live in Supabase (`supabase/migrations/`). Writes only happen through the
  `increment_tap()` and `claim_facilitator()` RPCs — the public anon key
  embedded in `index.html` can bump a tap or claim a facilitator for a new
  room, but never write arbitrary rows/columns, and can't overwrite an
  already-claimed room's facilitator.
