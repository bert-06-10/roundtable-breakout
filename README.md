# Roundtable

A short guided flow to open a group discussion: name the session,
introductions with an optional quiet timer, an opening question, then a
free discussion screen with a pull-out list of backup questions if the
conversation stalls. One single link works for every participant in every
breakout group, independently — nobody needs to coordinate with anyone
else in their group to use it.

Live at https://roundtable-prototype-rose.vercel.app

## Running it

Static, single-file, no build step — just open `index.html` in a browser,
or serve the folder with any static server (`.claude/launch.json` runs one
via `python3 -m http.server`).

## Starting a session

The first screen asks for a session name (e.g. `tuesday-standup`), appended
to the URL as `?session=<name>`. This is shared across every breakout group
in the event on purpose — `?session=<name>&taps=1` shows one combined tally
of backup-question taps for everyone using that session name, regardless of
which breakout group they were in. Name it once and hand out the resulting
link; every participant opens the exact same URL.

## Notes

- All facilitator-editable content (`OPENING_QUESTION`, `BACKUP_QUESTIONS`)
  lives at the top of the `<script>` block in `index.html`.
- Tap counts (`question_taps` table) live in Supabase
  (`supabase/migrations/`). Writes only happen through the
  `increment_tap()` RPC — the public anon key embedded in `index.html` can
  bump a count but never write arbitrary rows/columns.
- `supabase/migrations/` also has an older `rooms` table + a
  `claim_facilitator()` RPC from a since-removed per-breakout-group
  facilitator picker. They're unused by the app now and safe to drop
  whenever Supabase CLI access is handy.
