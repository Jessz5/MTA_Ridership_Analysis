CREATE DATABASE mta_ridership;

--Terminate active connections
/*
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'mta_ridership';
*/

--DROP DATABASE IF EXISTS mta_ridership;
