# Roundtable

A short guided flow to open a group discussion: an optional facilitator
picker, introductions with an optional quiet timer, an opening question,
then a free discussion screen with a pull-out list of backup questions if
the conversation stalls. The same single link works for every participant,
and each person moves through the screens independently, at their own pace
— nobody needs to coordinate with or wait on anyone else to use it.

Live at https://roundtable-prototype-rose.vercel.app

## Running it

Static, single-file, no build step, no external services — just open
`index.html` in a browser, or serve the folder with any static server
(`.claude/launch.json` runs one via `python3 -m http.server`).

## Facilitator picker

The welcome screen is the first thing everyone sees. Clicking "Begin" goes
straight to introductions. Next to it, "Having trouble picking a
facilitator? Click here first" links to a screen that takes one name per
line, then randomly picks one and shows the result before continuing on to
introductions. This runs entirely client-side (nothing saved to Supabase)
— it's per-browser and doesn't need coordination between participants any
more than the rest of the flow does.

## Notes

- All facilitator-editable content (`OPENING_QUESTION`, `BACKUP_QUESTIONS`)
  lives at the top of the `<script>` block in `index.html`.
- Everyone lands straight on the welcome screen — no name-a-session step,
  no link to copy and hand out.
- `supabase/` holds migrations from a since-removed tap-tracking feature
  (and an even older per-breakout-group facilitator picker before that).
  Nothing in `index.html` talks to Supabase anymore; the folder and the
  Supabase project are safe to drop whenever it's convenient.
