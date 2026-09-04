-- Tap counts for backup discussion questions, aggregated across everyone
-- in a session. Writes only happen through increment_tap() so the public
-- anon key can bump a count but never overwrite arbitrary rows/columns.

create table if not exists public.question_taps (
  question text primary key,
  count integer not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.question_taps enable row level security;

create policy "Anyone can read tap counts"
  on public.question_taps for select
  to anon
  using (true);

create or replace function public.increment_tap(q text)
returns public.question_taps
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.question_taps;
begin
  insert into public.question_taps (question, count)
  values (q, 1)
  on conflict (question)
  do update set count = question_taps.count + 1, updated_at = now()
  returning * into result;
  return result;
end;
$$;

grant select on public.question_taps to anon;
grant execute on function public.increment_tap(text) to anon;
