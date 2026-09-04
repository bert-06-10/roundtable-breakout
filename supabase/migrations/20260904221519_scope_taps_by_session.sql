-- Scope tap counts by a facilitator-provided session name, so counts from
-- different groups/days don't mix together in the admin (?taps=1) view.

alter table public.question_taps
  add column if not exists session_id text not null default 'unscoped';

alter table public.question_taps
  drop constraint question_taps_pkey;

alter table public.question_taps
  add primary key (session_id, question);

drop function if exists public.increment_tap(text);

create or replace function public.increment_tap(q text, s text)
returns public.question_taps
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.question_taps;
begin
  insert into public.question_taps (session_id, question, count)
  values (s, q, 1)
  on conflict (session_id, question)
  do update set count = question_taps.count + 1, updated_at = now()
  returning * into result;
  return result;
end;
$$;

grant execute on function public.increment_tap(text, text) to anon;
