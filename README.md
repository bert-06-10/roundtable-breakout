# Roundtable

A short guided flow to open a group discussion: introductions with an optional
quiet timer, an opening question, then a free discussion screen with a
pull-out list of backup questions if the conversation stalls.

## Running it

Static, single-file, no build step — just open `index.html` in a browser,
or serve the folder with any static server.

Add `?taps=1` to the URL to see a demo admin panel of how often each backup
question has been tapped (stored in that browser's `localStorage`).

## Notes

- All facilitator-editable content (`OPENING_QUESTION`, `BACKUP_QUESTIONS`)
  lives at the top of the `<script>` block in `index.html`.
- Tap counts are per-browser (`localStorage`), not shared across
  participants. To aggregate across everyone in a session, swap
  `getTapCounts()` / `logTap()` for calls to a backend (e.g. Supabase).
