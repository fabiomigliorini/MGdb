SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state,
  application_name 
  --*
FROM pg_stat_activity
--WHERE (now() - pg_stat_activity.query_start) > interval '1 minutes'
--where state = 'active'
order by state, pg_stat_activity.query_start

SELECT pg_cancel_backend(204898)
