-- Rooms: one row per breakout group, so a facilitator pick made on one
-- device (whoever "drives" the roster/picker) is visible on every other
-- device in that same group. Distinct from question_taps' session_id,
-- which is deliberately shared across breakout groups for aggregate taps
-- -- room_id is per-group and unique, generated client-side.

create table if not exists public.rooms (
  room_id text primary key,
  facilitator_name text not null,
  created_at timestamptz not null default now()
);

alter table public.rooms enable row level security;

create policy "Anyone can read rooms"
  on public.rooms for select
  to anon
  using (true);

-- First writer for a room_id wins; later calls just return the existing
-- row so a race between two devices in the same group can't overwrite
-- each other's pick.
create or replace function public.claim_facilitator(r text, name text)
returns public.rooms
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.rooms;
begin
  insert into public.rooms (room_id, facilitator_name)
  values (r, name)
  on conflict (room_id) do nothing;

  select * into result from public.rooms where room_id = r;
  return result;
end;
$$;

grant select on public.rooms to anon;
grant execute on function public.claim_facilitator(text, text) to anon;
