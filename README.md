# Roundtable

A short guided flow to open a group discussion: name the session, introductions
with an optional quiet timer, an opening question, then a free discussion
screen with a pull-out list of backup questions if the conversation stalls.

Live at https://roundtable-prototype-rose.vercel.app

## Running it

Static, single-file, no build step — just open `index.html` in a browser,
or serve the folder with any static server (`.claude/launch.json` runs one
via `python3 -m http.server`).

## Starting a session

The first screen asks the facilitator to name the session (e.g.
`tuesday-standup`) and appends it to the URL as `?session=<name>`. Share the
resulting link with the group — everyone should open that same link so their
backup-question taps land in the same session. Add `?taps=1` alongside
`?session=<name>` to see a demo admin panel of tap counts for that session.

## Notes

- All facilitator-editable content (`OPENING_QUESTION`, `BACKUP_QUESTIONS`)
  lives at the top of the `<script>` block in `index.html`.
- Tap counts live in Supabase (`supabase/migrations/`), scoped by session
  name so different groups/days don't mix in the admin view. Writes only
  happen through the `increment_tap()` RPC — the public anon key embedded in
  `index.html` can bump a count but never write arbitrary rows/columns.
