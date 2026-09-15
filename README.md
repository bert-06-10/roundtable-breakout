# Roundtable

A short guided flow to open a group discussion: an optional facilitator
picker, introductions with an optional quiet timer, an opening question,
then a free discussion screen with a pull-out list of backup questions if
the conversation stalls. The same single link works for every participant,
and each person moves through the screens independently, at their own pace
— nobody needs to coordinate with or wait on anyone else to use it.

Live at https://roundtable-prototype-rose.vercel.app

## Running it

Static, single-file, no build step — just open `index.html` in a browser,
or serve the folder with any static server (`.claude/launch.json` runs one
via `python3 -m http.server`).

## Facilitator picker

The welcome screen is the first thing everyone sees. Clicking "Begin" goes
straight to introductions. Next to it, "Having trouble picking a
facilitator? Click here first" links to a screen that takes one name per
line, then randomly picks one and shows the result before continuing on to
introductions. This runs entirely client-side (nothing saved to Supabase)
— it's per-browser and doesn't need coordination between participants any
more than the rest of the flow does.

## Session id

Everyone lands straight on the welcome screen — no name-a-session step, no
link to copy and hand out. Backup-question taps are still tallied in
Supabase, grouped under a `SESSION_ID` that defaults to today's date (UTC)
so the admin view (`?taps=1`) stays meaningful without anyone having to set
it up. Add `?session=<name>` to the URL to override that default, e.g. to
keep one tally running across midnight.

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
