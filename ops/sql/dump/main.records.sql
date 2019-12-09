-- Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.1 (Ubuntu 12.1-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.schema_version (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	xj schema	SQL	V1__xj_schema.sql	797233822	root	2019-12-04 14:12:48.625595	7	t
2	2	create extension uuid ossp	SQL	V2__create_extension_uuid_ossp.sql	2034728600	root	2019-12-04 14:12:48.692838	6	t
3	3	create updated at now	SQL	V3__create_updated_at_now.sql	-981124898	root	2019-12-04 14:12:48.713998	6	t
4	4	user	SQL	V4__user.sql	913045606	root	2019-12-04 14:12:48.733551	26	t
5	5	user auth	SQL	V5__user_auth.sql	-448926434	root	2019-12-04 14:12:48.775717	30	t
6	6	user auth token	SQL	V6__user_auth_token.sql	-1426970887	root	2019-12-04 14:12:48.818524	20	t
7	7	user role	SQL	V7__user_role.sql	520858385	root	2019-12-04 14:12:48.850479	17	t
8	8	account	SQL	V8__account.sql	-1413282908	root	2019-12-04 14:12:48.882071	19	t
9	9	account user	SQL	V9__account_user.sql	1415864885	root	2019-12-04 14:12:48.914022	14	t
10	10	library	SQL	V10__library.sql	1259098220	root	2019-12-04 14:12:48.937796	13	t
11	11	instrument	SQL	V11__instrument.sql	-1433436616	root	2019-12-04 14:12:48.961778	30	t
12	12	instrument meme	SQL	V12__instrument_meme.sql	-1027003655	root	2019-12-04 14:12:49.003721	17	t
13	13	instrument audio	SQL	V13__instrument_audio.sql	-1261244184	root	2019-12-04 14:12:49.032907	20	t
14	14	instrument audio chord	SQL	V14__instrument_audio_chord.sql	1803612396	root	2019-12-04 14:12:49.0635	18	t
15	15	instrument audio event	SQL	V15__instrument_audio_event.sql	1426476358	root	2019-12-04 14:12:49.094287	30	t
16	16	program	SQL	V16__program.sql	-941829822	root	2019-12-04 14:12:49.134538	20	t
17	17	program meme	SQL	V17__program_meme.sql	1450167054	root	2019-12-04 14:12:49.163972	18	t
18	18	program voice	SQL	V18__program_voice.sql	-276352046	root	2019-12-04 14:12:49.195	28	t
19	19	program voice track	SQL	V19__program_voice_track.sql	1664915003	root	2019-12-04 14:12:49.232651	14	t
20	20	program sequence	SQL	V20__program_sequence.sql	-1827766662	root	2019-12-04 14:12:49.257177	24	t
21	21	program sequence chord	SQL	V21__program_sequence_chord.sql	-261844648	root	2019-12-04 14:12:49.294483	19	t
22	22	program sequence binding	SQL	V22__program_sequence_binding.sql	42064776	root	2019-12-04 14:12:49.324964	14	t
23	23	program sequence binding meme	SQL	V23__program_sequence_binding_meme.sql	-1024515531	root	2019-12-04 14:12:49.350161	12	t
24	24	program sequence pattern	SQL	V24__program_sequence_pattern.sql	-2133019060	root	2019-12-04 14:12:49.373425	30	t
25	25	program sequence pattern event	SQL	V25__program_sequence_pattern_event.sql	1863665119	root	2019-12-04 14:12:49.415563	18	t
26	26	chain	SQL	V26__chain.sql	-817753471	root	2019-12-04 14:12:49.444766	20	t
27	27	chain config	SQL	V27__chain_config.sql	-1978914320	root	2019-12-04 14:12:49.475484	30	t
28	28	chain binding	SQL	V28__chain_binding.sql	1711464431	root	2019-12-04 14:12:49.519417	17	t
29	29	segment	SQL	V29__segment.sql	839872793	root	2019-12-04 14:12:49.547668	21	t
30	30	segment meme	SQL	V30__segment_meme.sql	1945287463	root	2019-12-04 14:12:49.580692	18	t
31	31	segment chord	SQL	V31__segment_chord.sql	-23710397	root	2019-12-04 14:12:49.613189	20	t
32	32	segment choice	SQL	V32__segment_choice.sql	745522750	root	2019-12-04 14:12:49.648343	19	t
33	33	segment choice arrangement	SQL	V33__segment_choice_arrangement.sql	-1859160	root	2019-12-04 14:12:49.683612	13	t
34	34	segment choice arrangement pick	SQL	V34__segment_choice_arrangement_pick.sql	438997014	root	2019-12-04 14:12:49.707439	18	t
35	35	segment message	SQL	V35__segment_message.sql	-895760763	root	2019-12-04 14:12:49.737529	28	t
36	36	platform message	SQL	V36__platform_message.sql	-1549213473	root	2019-12-04 14:12:49.776578	19	t
37	37	work	SQL	V37__work.sql	-1737567323	root	2019-12-04 14:12:49.808665	19	t
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.account (id, name, created_at, updated_at) FROM stdin;
14e468ba-16eb-11ea-8a37-53e6360023c1	Alpha	2019-12-04 15:09:11.18569	2019-12-04 15:09:11.18569
14e58a74-16eb-11ea-8a37-27b15e9fd30c	Aircraftâ„¢	2019-12-04 15:09:11.193333	2019-12-04 15:09:11.193333
14e623e4-16eb-11ea-8a37-671d88a1c344	Dave Cole Sandbox	2019-12-04 15:09:11.197241	2019-12-04 15:09:11.197241
14e6be4e-16eb-11ea-8a37-ab08baffb7a7	Mark Stewart Sandbox	2019-12-04 15:09:11.201191	2019-12-04 15:09:11.201191
14e75e08-16eb-11ea-8a37-7f4ba9639c65	Jay Whitaker Sandbox	2019-12-04 15:09:11.205266	2019-12-04 15:09:11.205266
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj."user" (id, name, email, avatar_url, created_at, updated_at) FROM stdin;
488ada38-16ea-11ea-88e3-573050fbaae5	Charney Kaye	charneykaye@gmail.com	https://lh3.googleusercontent.com/a-/AAuE7mCrwaXkA797eSgfxhvuJJkq-HarLA4voM3h5ivUwR4=s50	2019-12-04 15:03:28.342799	2019-12-04 15:03:28.342799
14796768-16eb-11ea-8a37-330f05571303	Charney Kaye	charneykaye@gmail.com	https://static.xj.io/charneykaye.jpg	2017-02-09 16:03:24	2019-12-04 15:09:10.483974
147d397e-16eb-11ea-8a37-87be9159498b	Chris Luken	christopher.luken@gmail.com	https://lh6.googleusercontent.com/-LPlAziFhPyU/AAAAAAAAAAI/AAAAAAAAADA/P4VW3DIXFlw/photo.jpg?sz=50	2017-02-09 16:03:24	2019-12-04 15:09:10.509645
14802d14-16eb-11ea-8a37-ff75275e34c2	David Cole	davecolemusic@gmail.com	https://static.xj.io/davecole.jpg	2017-03-07 18:26:51	2019-12-04 15:09:10.529004
1484cd56-16eb-11ea-8a37-67d77cefcb75	Shannon Holloway	shannon.holloway@gmail.com	https://lh3.googleusercontent.com/-fvuNROyYKxk/AAAAAAAAAAI/AAAAAAAACo4/1d4e9rStIzY/photo.jpg?sz=50	2017-03-08 10:14:53	2019-12-04 15:09:10.559209
1487cd4e-16eb-11ea-8a37-83d2eae0e391	Lev Kaye	lev@kaye.com	https://lh3.googleusercontent.com/-Jq1k3laPQ08/AAAAAAAAAAI/AAAAAAAAAAA/l7dj-EXs8jQ/photo.jpg?sz=50	2017-03-09 15:47:12	2019-12-04 15:09:10.57887
148a07bc-16eb-11ea-8a37-075f1966b269	Justin Knowlden (gus)	gus@gusg.us	https://lh4.googleusercontent.com/-U7mR8RgRhDE/AAAAAAAAAAI/AAAAAAAAB1k/VuF8nayQqdI/photo.jpg?sz=50	2017-04-14 13:41:41	2019-12-04 15:09:10.593557
148df3ea-16eb-11ea-8a37-97f115f0bedd	dave farkas	sakrafd@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-04-14 13:42:36	2019-12-04 15:09:10.619289
149554a0-16eb-11ea-8a37-97c0864fd98e	Aji Putra	aji.perdana.putra@gmail.com	https://lh5.googleusercontent.com/-yRjdJCgBHjQ/AAAAAAAAAAI/AAAAAAAABis/_Xue_78MM44/photo.jpg?sz=50	2017-04-21 10:33:25	2019-12-04 15:09:10.667583
14978a40-16eb-11ea-8a37-076e9e062171	live espn789	scoreplace@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-04-21 12:13:22	2019-12-04 15:09:10.682085
14990bae-16eb-11ea-8a37-a7327ff72f8c	Dmitry Solomadin	dmitry.solomadin@gmail.com	https://lh6.googleusercontent.com/-Ns78xq2VzKk/AAAAAAAAAAI/AAAAAAAAE44/ZOuBZnZqYeU/photo.jpg?sz=50	2017-05-03 14:09:33	2019-12-04 15:09:10.691977
149a7c6e-16eb-11ea-8a37-17f8e34538c8	Michael Prolagaev	prolagaev@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-05-04 09:13:06	2019-12-04 15:09:10.701487
149bde88-16eb-11ea-8a37-8b1169e1c6d0	Charney Kaye	nick.c.kaye@gmail.com	https://lh5.googleusercontent.com/-_oXIqxZhTkk/AAAAAAAAAAI/AAAAAAAAUks/dg9oNRfPFco/photo.jpg?sz=50	2017-05-18 10:37:32	2019-12-04 15:09:10.71057
149f194a-16eb-11ea-8a37-c3ef8b613a99	Charney Kaye	charney@outrightmental.com	https://lh5.googleusercontent.com/-3yrpEvNKIvE/AAAAAAAAAAI/AAAAAAAAASc/Gls7ZJcVqCk/photo.jpg?sz=50	2017-06-19 13:39:46	2019-12-04 15:09:10.731742
14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	Philip Z. Kimball	pzkimball@pzklaw.com	https://lh4.googleusercontent.com/-xnsM2SBKwaE/AAAAAAAAAAI/AAAAAAAAABs/uJouNj6fMgw/photo.jpg?sz=50	2017-06-26 06:56:57	2019-12-04 15:09:10.751923
14a5deb0-16eb-11ea-8a37-47e8b9b9f25a	Janae' Leonard	janaeleo55@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-06-28 02:30:40	2019-12-04 15:09:10.776073
14a79886-16eb-11ea-8a37-430f7eac1f53	yuan liu	minamotoclan@gmail.com	https://lh6.googleusercontent.com/-4orhpHPwHN4/AAAAAAAAAAI/AAAAAAAAFGc/HYueBarZIwA/photo.jpg?sz=50	2017-07-02 20:16:24	2019-12-04 15:09:10.787374
14a91d14-16eb-11ea-8a37-b30273a4ae00	Nick Podgurski	nickpodgurski@gmail.com	https://lh5.googleusercontent.com/-Cly5aKHLBMc/AAAAAAAAAAI/AAAAAAAAAYQ/wu8BxP-Zwxk/photo.jpg?sz=50	2017-07-03 20:59:02	2019-12-04 15:09:10.79733
14aaae86-16eb-11ea-8a37-eb68019fc4a5	Brian Sweeny	brian@vibesinternational.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-07-05 09:01:53	2019-12-04 15:09:10.807525
14acb140-16eb-11ea-8a37-275a6bc6aead	John Bennett	johnalsobennett@gmail.com	https://lh6.googleusercontent.com/-kFMmioNSrEM/AAAAAAAAAAI/AAAAAAAABfg/SfT2vo__XgI/photo.jpg?sz=50	2017-07-06 08:08:32	2019-12-04 15:09:10.820776
14aefe6e-16eb-11ea-8a37-a74a0a8ce70a	Aditi Hebbar	adhebbar@gmail.com	https://lh4.googleusercontent.com/-gUnZUky1WtE/AAAAAAAAAAI/AAAAAAAAEJ8/sFumIpFdaUA/photo.jpg?sz=50	2017-07-07 01:42:46	2019-12-04 15:09:10.835895
14b161fe-16eb-11ea-8a37-db0f5ecefe44	HANKYOL CHO	hankyolcho@mail.adelphi.edu	https://lh3.googleusercontent.com/-skrgmZw2fas/AAAAAAAAAAI/AAAAAAAAAAA/iwMwVr_CL2U/photo.jpg?sz=50	2017-07-10 07:10:03	2019-12-04 15:09:10.851552
14b3fb12-16eb-11ea-8a37-1b2feca8ca9a	Charles Frantz	charlesfrantz@gmail.com	https://lh4.googleusercontent.com/-WtgVMTchHkY/AAAAAAAAAAI/AAAAAAAAAMU/4hX0mxVuIBE/photo.jpg?sz=50	2017-07-13 07:28:39	2019-12-04 15:09:10.868453
14b88628-16eb-11ea-8a37-bb97ff523cc4	Alice Gamarnik	ajgamarnik@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-07-14 09:25:46	2019-12-04 15:09:10.898238
14bbac72-16eb-11ea-8a37-57b9b0855f3d	liu xin	xinliu2530@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-07-17 11:46:18	2019-12-04 15:09:10.918864
14bef634-16eb-11ea-8a37-9b5c94c4efae	Outright Mental	outrightmental@gmail.com	https://lh5.googleusercontent.com/-2HcQgfYoQRU/AAAAAAAAAAI/AAAAAAAAANE/-ttDusZjeuk/photo.jpg?sz=50	2017-07-30 09:26:49	2019-12-04 15:09:10.940434
14c466a0-16eb-11ea-8a37-7f9d94616956	Joey Lorjuste	joeylorjuste@gmail.com	https://lh4.googleusercontent.com/-WPQgkyb-M5A/AAAAAAAAAAI/AAAAAAAAH-Q/Lf9IG0JJl5c/photo.jpg?sz=50	2017-08-20 12:25:12	2019-12-04 15:09:10.976133
14c688fe-16eb-11ea-8a37-a798275d637c	Mark Stewart	mark.si.stewart@gmail.com	https://static.xj.io/markstewart.jpg	2017-08-25 12:30:40	2019-12-04 15:09:10.990172
14c96c72-16eb-11ea-8a37-ab809d222c21	Rosalind Kaye	rckaye@kaye.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-10-15 17:11:49	2019-12-04 15:09:11.009109
14cac298-16eb-11ea-8a37-cfbc84ec2a89	Matthew DellaRatta	mdellaratta8@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-10-16 17:00:36	2019-12-04 15:09:11.017866
14cc0072-16eb-11ea-8a37-bfe8fe56bf82	Justice Whitaker	justice512@gmail.com	https://lh5.googleusercontent.com/-Y9sCwQKldqA/AAAAAAAAAAI/AAAAAAAAADE/3wU9xJLYRG0/photo.jpg?sz=50	2017-12-08 12:45:40	2019-12-04 15:09:11.025995
14ceb736-16eb-11ea-8a37-4bcf05f4efe0	Ed Carney	ed@steirmancpas.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50	2017-12-13 07:13:49	2019-12-04 15:09:11.043744
14d0e254-16eb-11ea-8a37-cf89c5a4023b	Tamil Selvan	prtamil@gmail.com	https://lh6.googleusercontent.com/-iVWQ0iJwSvY/AAAAAAAAAAI/AAAAAAAAAJo/KlOXVs2XwFI/photo.jpg?sz=50	2018-02-04 00:50:11	2019-12-04 15:09:11.058005
14d2c7e0-16eb-11ea-8a37-9bb9460b2667	Riyadh Abdullatif	coldmo@gmail.com	https://lh6.googleusercontent.com/-NQk0LpgjTc0/AAAAAAAAAAI/AAAAAAAAAGk/SCEchWKOh7g/photo.jpg?sz=50	2018-02-26 13:36:44	2019-12-04 15:09:11.070433
14d4a88a-16eb-11ea-8a37-23200faf4adf	Ken Kaye	ken@kaye.com	https://lh3.googleusercontent.com/-r0rl7N0eE7g/AAAAAAAAAAI/AAAAAAAAAEc/IC1Dir_2XjE/photo.jpg?sz=50	2018-05-15 05:24:58	2019-12-04 15:09:11.082732
14d5edda-16eb-11ea-8a37-c3273ffc006f	Eden Zhong	hydrosulfate@gmail.com	https://lh3.googleusercontent.com/-Ty-LN9tk8TQ/AAAAAAAAAAI/AAAAAAAADi4/J1bPsII4IFY/photo.jpg?sz=50	2018-06-04 13:57:29	2019-12-04 15:09:11.091039
14d7533c-16eb-11ea-8a37-a704da8d90d0	Jacky Huang	jackyxhu@usc.edu	https://lh6.googleusercontent.com/-0MMr2iRpOHE/AAAAAAAAAAI/AAAAAAAAAH4/xXcj5T7YPbQ/photo.jpg?sz=50	2018-07-03 12:30:38	2019-12-04 15:09:11.10022
14d8eff8-16eb-11ea-8a37-2b61f0378af8	Simon Kalmus	simon.kalmus@gmail.com	https://lh3.googleusercontent.com/-ED1Ob9JwfVg/AAAAAAAAAAI/AAAAAAAACH0/jGu6rsiQiC4/photo.jpg?sz=50	2018-11-12 18:16:12	2019-12-04 15:09:11.110739
14da6e50-16eb-11ea-8a37-67aadff2ee00	Charney Kaye	charneykaye@gmail.com	https://lh6.googleusercontent.com/-uVJxoVmL42M/AAAAAAAAAAI/AAAAAAAAp3I/O1sKk36Dfiw/s50/photo.jpg	2019-04-03 19:05:31	2019-12-04 15:09:11.120523
14dca4f4-16eb-11ea-8a37-9b49bdcb2e7d	David Cole	davecolemusic@gmail.com	https://lh6.googleusercontent.com/-4KwLE88wOfw/AAAAAAAAAAI/AAAAAAAADa0/wfqGtqAR8wo/s50/photo.jpg	2019-04-03 19:20:04	2019-12-04 15:09:11.135057
14deee62-16eb-11ea-8a37-53d507873c72	Mark Stewart	mark.si.stewart@gmail.com	https://lh3.googleusercontent.com/-PtMRcK_-Bkg/AAAAAAAAAAI/AAAAAAAAASs/YlN0XjZSvdg/s50/photo.jpg	2019-04-05 22:16:16	2019-12-04 15:09:11.150042
14e0e8c0-16eb-11ea-8a37-336eae21d833	Jay Whitaker	jaywhitaker93@gmail.com	https://lh6.googleusercontent.com/-TX6cFyyy4Lk/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rfOS7bcB1zZrLSP24erZqNVpql1Ow/s50-mo/photo.jpg	2019-06-10 19:23:39	2019-12-04 15:09:11.163006
\.


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.account_user (id, user_id, account_id, created_at, updated_at) FROM stdin;
14e80c68-16eb-11ea-8a37-bf320a18887b	14796768-16eb-11ea-8a37-330f05571303	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.209696	2019-12-04 15:09:11.209696
14e92e9a-16eb-11ea-8a37-8fbaa4fcb8ec	147d397e-16eb-11ea-8a37-87be9159498b	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.21719	2019-12-04 15:09:11.21719
14eaa158-16eb-11ea-8a37-9717a552383d	14796768-16eb-11ea-8a37-330f05571303	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.2264	2019-12-04 15:09:11.2264
14ec269a-16eb-11ea-8a37-9fa161c5a5b1	14802d14-16eb-11ea-8a37-ff75275e34c2	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.236325	2019-12-04 15:09:11.236325
14edb000-16eb-11ea-8a37-3b6b64b26fae	1487cd4e-16eb-11ea-8a37-83d2eae0e391	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.246257	2019-12-04 15:09:11.246257
14ef1a08-16eb-11ea-8a37-d39739114ca8	148a07bc-16eb-11ea-8a37-075f1966b269	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.255828	2019-12-04 15:09:11.255828
14f06ffc-16eb-11ea-8a37-6be0d137b004	148df3ea-16eb-11ea-8a37-97f115f0bedd	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.264587	2019-12-04 15:09:11.264587
14f1b826-16eb-11ea-8a37-278ca8146f84	149bde88-16eb-11ea-8a37-8b1169e1c6d0	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.272964	2019-12-04 15:09:11.272964
14f34a1a-16eb-11ea-8a37-7bb4e6716968	14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.283181	2019-12-04 15:09:11.283181
14f47c0a-16eb-11ea-8a37-733c2ef75710	14b3fb12-16eb-11ea-8a37-1b2feca8ca9a	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.291055	2019-12-04 15:09:11.291055
14f5805a-16eb-11ea-8a37-8b0223672042	14b88628-16eb-11ea-8a37-bb97ff523cc4	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.297858	2019-12-04 15:09:11.297858
14f682a2-16eb-11ea-8a37-cf1a8c652814	14bbac72-16eb-11ea-8a37-57b9b0855f3d	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.304399	2019-12-04 15:09:11.304399
14f78828-16eb-11ea-8a37-a38f1c376e74	149f194a-16eb-11ea-8a37-c3ef8b613a99	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.31112	2019-12-04 15:09:11.31112
14f888d6-16eb-11ea-8a37-f7d507724303	14bef634-16eb-11ea-8a37-9b5c94c4efae	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.317688	2019-12-04 15:09:11.317688
14f98bf0-16eb-11ea-8a37-23f3dcbbaba3	14c688fe-16eb-11ea-8a37-a798275d637c	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.324326	2019-12-04 15:09:11.324326
14fab8e0-16eb-11ea-8a37-cbb6377b0b44	14802d14-16eb-11ea-8a37-ff75275e34c2	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.33208	2019-12-04 15:09:11.33208
14fba246-16eb-11ea-8a37-7f03b8e5e5e9	14c688fe-16eb-11ea-8a37-a798275d637c	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.338111	2019-12-04 15:09:11.338111
14fce566-16eb-11ea-8a37-efef847ce189	14c96c72-16eb-11ea-8a37-ab809d222c21	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.346387	2019-12-04 15:09:11.346387
14fe2296-16eb-11ea-8a37-a35de5491748	14cc0072-16eb-11ea-8a37-bfe8fe56bf82	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.354508	2019-12-04 15:09:11.354508
14ff6070-16eb-11ea-8a37-d3aaaef27148	148a07bc-16eb-11ea-8a37-075f1966b269	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.362644	2019-12-04 15:09:11.362644
1500a2d2-16eb-11ea-8a37-c3cc94f6920a	148df3ea-16eb-11ea-8a37-97f115f0bedd	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.370869	2019-12-04 15:09:11.370869
1501b96a-16eb-11ea-8a37-b3d65ec2fb9c	14802d14-16eb-11ea-8a37-ff75275e34c2	14e623e4-16eb-11ea-8a37-671d88a1c344	2019-12-04 15:09:11.378026	2019-12-04 15:09:11.378026
1502ebbe-16eb-11ea-8a37-97236603758a	14c688fe-16eb-11ea-8a37-a798275d637c	14e6be4e-16eb-11ea-8a37-ab08baffb7a7	2019-12-04 15:09:11.385828	2019-12-04 15:09:11.385828
15040bac-16eb-11ea-8a37-8ffb2d3a380b	14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.39323	2019-12-04 15:09:11.39323
15052f32-16eb-11ea-8a37-8fd9663d5956	1487cd4e-16eb-11ea-8a37-83d2eae0e391	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.400684	2019-12-04 15:09:11.400684
1505eabc-16eb-11ea-8a37-dba7af9f6341	14e0e8c0-16eb-11ea-8a37-336eae21d833	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.405487	2019-12-04 15:09:11.405487
15069f34-16eb-11ea-8a37-8f523b7ff575	14796768-16eb-11ea-8a37-330f05571303	14e75e08-16eb-11ea-8a37-7f4ba9639c65	2019-12-04 15:09:11.410161	2019-12-04 15:09:11.410161
15074e7a-16eb-11ea-8a37-077d0c36c062	14e0e8c0-16eb-11ea-8a37-336eae21d833	14e75e08-16eb-11ea-8a37-7f4ba9639c65	2019-12-04 15:09:11.414637	2019-12-04 15:09:11.414637
\.


--
-- Data for Name: chain_binding; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.chain_binding (id, chain_id, target_id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: library; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.library (id, name, account_id, created_at, updated_at) FROM stdin;
15085f36-16eb-11ea-8a37-57a336f886a8	Pots and Pans #2	14e468ba-16eb-11ea-8a37-53e6360023c1	2019-12-04 15:09:11.421381	2019-12-04 15:09:11.421381
1509102a-16eb-11ea-8a37-4764c2a771db	Cool Ambienceâ„¢	14e58a74-16eb-11ea-8a37-27b15e9fd30c	2019-12-04 15:09:11.426084	2019-12-04 15:09:11.426084
1509b610-16eb-11ea-8a37-731d17ba5549	Test Library	14e623e4-16eb-11ea-8a37-671d88a1c344	2019-12-04 15:09:11.430339	2019-12-04 15:09:11.430339
150a5700-16eb-11ea-8a37-7bbb0a3ef1d4	Test Library	14e6be4e-16eb-11ea-8a37-ab08baffb7a7	2019-12-04 15:09:11.434496	2019-12-04 15:09:11.434496
\.


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.instrument (id, user_id, library_id, type, state, name, density, created_at, updated_at) FROM stdin;
150bc66c-16eb-11ea-8a37-83d91cc4d60b	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Harmonic	Published	Earth Bass Harmony	0.6	2019-12-04 15:09:11.443647	2019-12-04 15:09:11.443647
15162544-16eb-11ea-8a37-5f8791ecc0c1	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Harmonic	Published	Fire String Hits	0.6	2019-12-04 15:09:11.511813	2019-12-04 15:09:11.511813
151b16ee-16eb-11ea-8a37-7755b75f4dfb	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Harmonic	Published	Water Sitar Harmony	0.6	2019-12-04 15:09:11.544222	2019-12-04 15:09:11.544222
15204e7a-16eb-11ea-8a37-7f93cb6b74b4	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Harmonic	Published	Water Whale Harmony	0.6	2019-12-04 15:09:11.57841	2019-12-04 15:09:11.57841
1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Harmonic	Published	Wind Flute Note	0.6	2019-12-04 15:09:11.613229	2019-12-04 15:09:11.613229
152fbc70-16eb-11ea-8a37-2f91c79f438d	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Acoustic	0.6	2019-12-04 15:09:11.67958	2019-12-04 15:09:11.67958
158a6738-16eb-11ea-8a37-3706e5d25249	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Earth A (legacy)	0.6	2019-12-04 15:09:12.273773	2019-12-04 15:09:12.273773
15cd8374-16eb-11ea-8a37-8f22eedc54b2	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Earth B (legacy)	0.6	2019-12-04 15:09:12.713337	2019-12-04 15:09:12.713337
15f4f92c-16eb-11ea-8a37-2f529693f38a	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Earth Large	0.6	2019-12-04 15:09:12.97219	2019-12-04 15:09:12.97219
1637e066-16eb-11ea-8a37-c7f42ae039d6	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Earth Small	0.6	2019-12-04 15:09:13.410626	2019-12-04 15:09:13.410626
166815c4-16eb-11ea-8a37-634bb3ccef01	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Electronic	0.6	2019-12-04 15:09:13.726617	2019-12-04 15:09:13.726617
169ea38c-16eb-11ea-8a37-b799503ae436	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Fire A  (legacy)	0.6	2019-12-04 15:09:14.084156	2019-12-04 15:09:14.084156
16c8d008-16eb-11ea-8a37-dbdfe140dd35	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Fire Large	0.6	2019-12-04 15:09:14.36053	2019-12-04 15:09:14.36053
1787297c-16eb-11ea-8a37-6f3014c0a6fc	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Fire Small	0.6	2019-12-04 15:09:15.608032	2019-12-04 15:09:15.608032
17af4286-16eb-11ea-8a37-7f9963e0dfa2	14802d14-16eb-11ea-8a37-ff75275e34c2	1509b610-16eb-11ea-8a37-731d17ba5549	Percussive	Published	Flammy Clap	0.6	2019-12-04 15:09:15.870807	2019-12-04 15:09:15.870807
17b34ca0-16eb-11ea-8a37-6b86e3816409	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	New Earth Large	0.6	2019-12-04 15:09:15.89727	2019-12-04 15:09:15.89727
17e50f74-16eb-11ea-8a37-e3561e92fad1	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Pots & Pans	0.6	2019-12-04 15:09:16.223284	2019-12-04 15:09:16.223284
1860788a-16eb-11ea-8a37-87eb83753fe4	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Water B (legacy)	0.6	2019-12-04 15:09:17.032209	2019-12-04 15:09:17.032209
1884dbb2-16eb-11ea-8a37-077ec33cd155	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Water Basic X	0	2019-12-04 15:09:17.270528	2019-12-04 15:09:17.270528
18860e06-16eb-11ea-8a37-1fe3e47ff5a8	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Water Large	0.6	2019-12-04 15:09:17.278371	2019-12-04 15:09:17.278371
19138e3e-16eb-11ea-8a37-0b2895a9ceb9	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Water Small	0.6	2019-12-04 15:09:18.20572	2019-12-04 15:09:18.20572
193a8eee-16eb-11ea-8a37-4f72c68eb48d	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Wind A (legacy)	0.6	2019-12-04 15:09:18.461323	2019-12-04 15:09:18.461323
196d485c-16eb-11ea-8a37-3b9fc50a2c86	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Percussive	Published	Wind B (legacy)	0.6	2019-12-04 15:09:18.793759	2019-12-04 15:09:18.793759
199a5e8c-16eb-11ea-8a37-0f841ec0351d	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Wind Large	0.6	2019-12-04 15:09:19.089236	2019-12-04 15:09:19.089236
19ea21a6-16eb-11ea-8a37-cb712a6674d9	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Percussive	Published	Wind Small	0.6	2019-12-04 15:09:19.611932	2019-12-04 15:09:19.611932
\.


--
-- Data for Name: instrument_audio; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.instrument_audio (id, instrument_id, name, waveform_key, start, length, tempo, pitch, density, created_at, updated_at) FROM stdin;
150ee1ee-16eb-11ea-8a37-2307c778ff2f	150bc66c-16eb-11ea-8a37-83d91cc4d60b	Omen Pad	0732ee48-5a9b-4a1d-bafd-e8c2ef23231d-instrument-9-audio.wav	0	4.45	88	65.333	0.6	2019-12-04 15:09:11.463951	2019-12-04 15:09:11.463951
15133370-16eb-11ea-8a37-8724b57c0e6f	150bc66c-16eb-11ea-8a37-83d91cc4d60b	Bass Pad	69dfbe99-bca5-4171-bbae-b69c4599531e-instrument-9-audio.wav	0	4.073	88	49.606	0.6	2019-12-04 15:09:11.49254	2019-12-04 15:09:11.49254
1516f172-16eb-11ea-8a37-73aaa398022f	15162544-16eb-11ea-8a37-5f8791ecc0c1	Koto	eb8bca2c-994f-4e62-9bf6-1242acc79d21-instrument-12-audio.wav	0	1.294	88	132.831	0.6	2019-12-04 15:09:11.517036	2019-12-04 15:09:11.517036
151853c8-16eb-11ea-8a37-bf468ce03e99	15162544-16eb-11ea-8a37-5f8791ecc0c1	Shamisen	e5eff131-8813-48bc-9bda-d378b3eeee9a-instrument-12-audio.wav	0.005	1.353	88	264.072	0.6	2019-12-04 15:09:11.526119	2019-12-04 15:09:11.526119
1519b42a-16eb-11ea-8a37-d7660d66fff9	15162544-16eb-11ea-8a37-5f8791ecc0c1	Shami	a166a69f-8944-4577-9a68-8b323dff7a68-instrument-12-audio.wav	0.006	0.999	88	262.5	0.6	2019-12-04 15:09:11.535137	2019-12-04 15:09:11.535137
151cdb64-16eb-11ea-8a37-0fbee363ef1c	151b16ee-16eb-11ea-8a37-7755b75f4dfb	Sitar	9dc36d01-fd2e-49f7-a75b-545897962c9d-instrument-8-audio.wav	0	2.424	88	262.5	0.6	2019-12-04 15:09:11.555853	2019-12-04 15:09:11.555853
152244c8-16eb-11ea-8a37-3b1f1d391206	15204e7a-16eb-11ea-8a37-7f93cb6b74b4	Whale Pad	c477ff4c-3212-4cfe-8712-6add5f697a98-instrument-10-audio.wav	0	3.249	88	226.154	0.6	2019-12-04 15:09:11.591342	2019-12-04 15:09:11.591342
1527e75c-16eb-11ea-8a37-2fdd46928f5a	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	Shakuhachi	e02b5c6c-21a8-47b9-94fc-aaa5d1b2975f-instrument-7-audio.wav	0	2.681	88	525	0.6	2019-12-04 15:09:11.62805	2019-12-04 15:09:11.62805
152afb04-16eb-11ea-8a37-97ae873f39b9	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	Pan Flute	de11db96-dfee-4fc3-8a02-3285d3bd2d80-instrument-7-audio.wav	0	1.624	88	518.824	0.6	2019-12-04 15:09:11.648349	2019-12-04 15:09:11.648349
152d7e9c-16eb-11ea-8a37-7f5cf33fdf95	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	Shamisen	0e57fd93-11b6-49d8-b617-2d1b8e657180-instrument-12-audio.wav	0	1	88	262.5	0.6	2019-12-04 15:09:11.664876	2019-12-04 15:09:11.664876
15363cd0-16eb-11ea-8a37-27a31b17dbaf	152fbc70-16eb-11ea-8a37-2f91c79f438d	Conga High	511f5a68-1eca-4ca3-9713-956a219d734c-instrument-4-audio.wav	0.002	0.425	120	187.66	0.6	2019-12-04 15:09:11.722258	2019-12-04 15:09:11.722258
15378202-16eb-11ea-8a37-636a1cd2978d	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Get 2	22efe6d1-3dea-45a5-906c-1e4bd4465606-instrument-4-audio.wav	0.027	0.29	120	386.842	0.6	2019-12-04 15:09:11.730562	2019-12-04 15:09:11.730562
1538bc62-16eb-11ea-8a37-3358e01ed2fc	152fbc70-16eb-11ea-8a37-2f91c79f438d	Clap 2	81f55d83-39fe-4832-99bf-4e4f3af69496-instrument-4-audio.wav	0	0.684	120	188.462	0.6	2019-12-04 15:09:11.738606	2019-12-04 15:09:11.738606
153958f2-16eb-11ea-8a37-2f03c7ade378	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare Rim 5	d404857a-6bf8-43c4-ad76-5259945d16fe-instrument-4-audio.wav	0	0.463	120	181.481	0.6	2019-12-04 15:09:11.742609	2019-12-04 15:09:11.742609
153be676-16eb-11ea-8a37-039732693844	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tom	d5bcc3a5-d98f-434f-8fcb-987f1913a684-instrument-4-audio.wav	0.009	0.445	120	225	0.6	2019-12-04 15:09:11.759152	2019-12-04 15:09:11.759152
154018d6-16eb-11ea-8a37-8f2bb6d34a52	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Open 6	9a57a402-98e9-4ceb-86c2-ea60607b56d1-instrument-4-audio.wav	0	0.809	120	648.529	0.6	2019-12-04 15:09:11.786785	2019-12-04 15:09:11.786785
15423e90-16eb-11ea-8a37-d7faa5b05767	152fbc70-16eb-11ea-8a37-2f91c79f438d	Stick Side 5	99f7dbea-c1fb-419e-ad44-c90804516aa3-instrument-4-audio.wav	0	0.248	120	1837.5	0.6	2019-12-04 15:09:11.800887	2019-12-04 15:09:11.800887
15448308-16eb-11ea-8a37-27f2caacfef3	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Open 5	bf2c9ad8-ceb4-4c7e-98ae-a9c561680a1f-instrument-4-audio.wav	0.003	1.115	120	648.529	0.6	2019-12-04 15:09:11.81577	2019-12-04 15:09:11.81577
154606d8-16eb-11ea-8a37-cf4ff5bbe496	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Baz	76a3e02c-979c-4d64-9bab-3b1a91d3635d-instrument-4-audio.wav	0.018	0.405	120	918.75	0.6	2019-12-04 15:09:11.82559	2019-12-04 15:09:11.82559
1547a7f4-16eb-11ea-8a37-9f3c8105b1e0	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal Woo	c7b78912-493a-4e19-a023-10a6b334e2b3-instrument-4-audio.wav	0.01	0.522	120	464.211	0.6	2019-12-04 15:09:11.836346	2019-12-04 15:09:11.836346
15490b26-16eb-11ea-8a37-d70d1b708307	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Closed 8	cb1ffbff-c31d-4e06-9d84-649c1f257a24-instrument-4-audio.wav	0	0.905	120	648.529	0.6	2019-12-04 15:09:11.845466	2019-12-04 15:09:11.845466
154a55d0-16eb-11ea-8a37-33b0911d4fb1	152fbc70-16eb-11ea-8a37-2f91c79f438d	Kick Long 2	b12bf5ff-ebec-47e3-9259-6cd0c9f57724-instrument-4-audio.wav	0.01	1.476	120	59.036	0.6	2019-12-04 15:09:11.853944	2019-12-04 15:09:11.853944
154c71d0-16eb-11ea-8a37-cbd64f0f6e31	152fbc70-16eb-11ea-8a37-2f91c79f438d	Cymbal Crash 1	378df92f-aec2-4a5c-9243-d08384971761-instrument-4-audio.wav	0.018	1.878	120	1297.06	0.6	2019-12-04 15:09:11.86777	2019-12-04 15:09:11.86777
154e94a6-16eb-11ea-8a37-0b11b42e8842	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare Rim 6	5a840f38-7623-442b-b9a9-a0ff1927c7a0-instrument-4-audio.wav	0	0.527	120	245	0.6	2019-12-04 15:09:11.88177	2019-12-04 15:09:11.88177
15507104-16eb-11ea-8a37-af12828a21c7	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tom High	4888db8b-1c81-4178-8af5-332ae7067ca8-instrument-4-audio.wav	0.002	0.42	120	187.66	0.6	2019-12-04 15:09:11.893968	2019-12-04 15:09:11.893968
1552474a-16eb-11ea-8a37-cb38ed01cfba	152fbc70-16eb-11ea-8a37-2f91c79f438d	Kick 3	3a79549f-cf7b-4338-8756-f75b3fc5deaa-instrument-4-audio.wav	0.005	0.742	120	52.128	0.6	2019-12-04 15:09:11.906007	2019-12-04 15:09:11.906007
15538af6-16eb-11ea-8a37-e367a876ead9	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tom 5	bf45a337-c86a-4c44-9663-06093d3ca9ba-instrument-4-audio.wav	0	0.59	120	90.928	0.6	2019-12-04 15:09:11.914291	2019-12-04 15:09:11.914291
1554c4c0-16eb-11ea-8a37-2345cc31ce9f	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal Eh	a6049156-69e0-4128-a4b1-6a17ee4ca0bd-instrument-4-audio.wav	0.018	0.449	120	668.182	0.6	2019-12-04 15:09:11.92233	2019-12-04 15:09:11.92233
155560d8-16eb-11ea-8a37-b39bb50ef9eb	152fbc70-16eb-11ea-8a37-2f91c79f438d	Stick Side 6	0d65a838-e76f-407d-a06b-6485d67ba44c-instrument-4-audio.wav	0	0.335	120	2321.05	0.6	2019-12-04 15:09:11.926324	2019-12-04 15:09:11.926324
15569b56-16eb-11ea-8a37-d7215abb3a5e	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare Rim 7	12e36076-5944-4101-a41b-b39136cf78a4-instrument-4-audio.wav	0	0.461	120	254.913	0.6	2019-12-04 15:09:11.93437	2019-12-04 15:09:11.93437
15583e8e-16eb-11ea-8a37-8bc75fc43cb2	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tom High 5	83294480-eef2-4171-8d69-8f16092557df-instrument-4-audio.wav	0.003	0.444	120	126	0.6	2019-12-04 15:09:11.945096	2019-12-04 15:09:11.945096
155a552a-16eb-11ea-8a37-eb3f35c7cb8d	152fbc70-16eb-11ea-8a37-2f91c79f438d	Cymbal Crash 2	b921f58d-1ce0-4c1e-82d0-08479c25bfff-instrument-4-audio.wav	0.01	3.241	120	469.149	0.6	2019-12-04 15:09:11.958794	2019-12-04 15:09:11.958794
155c47a4-16eb-11ea-8a37-d32a09c8ca9d	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal Ehh	7806beda-4655-4323-adb0-d9a41d2fc939-instrument-4-audio.wav	0.018	0.297	120	648.529	0.6	2019-12-04 15:09:11.971552	2019-12-04 15:09:11.971552
155e2164-16eb-11ea-8a37-0f8720e663f1	152fbc70-16eb-11ea-8a37-2f91c79f438d	Stick Side 7	ea042c27-551b-44c7-998b-1df185d319cf-instrument-4-audio.wav	0.003	0.159	120	436.634	0.6	2019-12-04 15:09:11.98368	2019-12-04 15:09:11.98368
155fb448-16eb-11ea-8a37-e34f6dc290a2	152fbc70-16eb-11ea-8a37-2f91c79f438d	Conga	2059cab7-8052-46cf-8fd1-2930cfe5ce59-instrument-4-audio.wav	0.001	0.547	120	183.231	0.6	2019-12-04 15:09:11.993991	2019-12-04 15:09:11.993991
15611450-16eb-11ea-8a37-e7e2ac8abc8c	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tom Low 5	246190da-65fd-41a9-a943-2c8e3b763fa5-instrument-4-audio.wav	0	0.73	120	84.483	0.6	2019-12-04 15:09:12.002993	2019-12-04 15:09:12.002993
15625b44-16eb-11ea-8a37-23e57d34732b	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare Rim	7b2d94b3-c218-498b-906e-11c313054cd1-instrument-4-audio.wav	0	1.147	120	239.674	0.6	2019-12-04 15:09:12.011376	2019-12-04 15:09:12.011376
156391ee-16eb-11ea-8a37-b712d708e099	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Open 7	4c3c5673-e8f1-4452-ad8c-5466cce0492d-instrument-4-audio.wav	0	2	120	648.529	0.6	2019-12-04 15:09:12.019305	2019-12-04 15:09:12.019305
15654a20-16eb-11ea-8a37-07d72615569e	152fbc70-16eb-11ea-8a37-2f91c79f438d	Kick 7	2fd75fb8-b968-46ba-8c43-ac6ad2db9a80-instrument-4-audio.wav	0.008	0.537	120	43.534	0.6	2019-12-04 15:09:12.030595	2019-12-04 15:09:12.030595
15678812-16eb-11ea-8a37-1bcd8dd6ac89	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Get	e5e8a85b-1c3c-46b5-8394-3b44b5c7e6e1-instrument-4-audio.wav	0.027	0.311	120	386.842	0.6	2019-12-04 15:09:12.045237	2019-12-04 15:09:12.045237
15698978-16eb-11ea-8a37-d79e71007907	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Me	3fbbf18b-eb45-4375-8bd2-efd5e490c4cb-instrument-4-audio.wav	14	0.336	120	367.5	0.6	2019-12-04 15:09:12.058445	2019-12-04 15:09:12.058445
156b6db0-16eb-11ea-8a37-8f3fe6d10174	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare 3	d373a2f8-8c8f-4afa-b7e3-c21623d15f42-instrument-4-audio.wav	0.008	0.404	120	2450	0.6	2019-12-04 15:09:12.070813	2019-12-04 15:09:12.070813
156d0a44-16eb-11ea-8a37-17812fa803d5	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Baz2	94bd651e-ce98-4b09-95b8-6e36819e2721-instrument-4-audio.wav	0.032	0.29	120	367.5	0.6	2019-12-04 15:09:12.081381	2019-12-04 15:09:12.081381
156e6e34-16eb-11ea-8a37-47f5ddc9a46e	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Closed 7	e15dc427-b556-4a72-bec8-6b59c6d8bbc8-instrument-4-audio.wav	0.003	0.962	120	8820	0.6	2019-12-04 15:09:12.090498	2019-12-04 15:09:12.090498
156fb35c-16eb-11ea-8a37-fbf69aef5b16	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hihat Closed 9	0f28ef83-2213-4bbb-ae68-3eecc201ead3-instrument-4-audio.wav	0	0.849	120	648.529	0.6	2019-12-04 15:09:12.098828	2019-12-04 15:09:12.098828
15717976-16eb-11ea-8a37-73b4b60bcc02	152fbc70-16eb-11ea-8a37-2f91c79f438d	Shim	4a00b7f2-5634-40b0-801a-2f1f65a8cb54-instrument-4-audio.wav	0	1	120	120	0.6	2019-12-04 15:09:12.110337	2019-12-04 15:09:12.110337
15726eda-16eb-11ea-8a37-73643cacdb7a	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Uhh	3bc65d7a-00a0-42cc-9d15-292f9fbe98ee-instrument-4-audio.wav	0	0.408	120	474.194	0.6	2019-12-04 15:09:12.116596	2019-12-04 15:09:12.116596
157551fe-16eb-11ea-8a37-2f20589d7422	152fbc70-16eb-11ea-8a37-2f91c79f438d	Ugh	8c37b691-4b93-47e8-9bbf-3821bdaf1bbc-instrument-4-audio.wav	0	1	120	120	0.6	2019-12-04 15:09:12.135431	2019-12-04 15:09:12.135431
1576b24c-16eb-11ea-8a37-636d7ca3aeb2	152fbc70-16eb-11ea-8a37-2f91c79f438d	Clap 1	27b08205-9921-4d48-bc54-ba4110fe238f-instrument-4-audio.wav	0	0.572	120	185.294	0.6	2019-12-04 15:09:12.144516	2019-12-04 15:09:12.144516
15797a40-16eb-11ea-8a37-1ba3846d9460	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal JB Hit	686906da-cc85-4abb-a902-121e98def35d-instrument-4-audio.wav	0.05	0.313	120	512.791	0.6	2019-12-04 15:09:12.16276	2019-12-04 15:09:12.16276
157bf86a-16eb-11ea-8a37-bb60c54ef05b	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare 5	cce1763b-fca3-49c5-9024-c665c1fea7f3-instrument-4-audio.wav	0.008	0.407	120	180.738	0.6	2019-12-04 15:09:12.179115	2019-12-04 15:09:12.179115
157e3fb2-16eb-11ea-8a37-43bdb3eb766c	152fbc70-16eb-11ea-8a37-2f91c79f438d	Snare 4	511168e1-3291-4ec8-a6ac-652249206287-instrument-4-audio.wav	0.008	0.439	120	204.167	0.6	2019-12-04 15:09:12.194007	2019-12-04 15:09:12.194007
158025ac-16eb-11ea-8a37-7ff0ee6377bd	152fbc70-16eb-11ea-8a37-2f91c79f438d	Cymbal Crash 3	484d5dc0-4627-477d-8de7-f4c30cc4f538-instrument-4-audio.wav	0.01	3.044	120	181.481	0.6	2019-12-04 15:09:12.206486	2019-12-04 15:09:12.206486
15821696-16eb-11ea-8a37-cfc2c3291f1a	152fbc70-16eb-11ea-8a37-2f91c79f438d	Shammers	b13399ea-a8be-44ec-9923-d096f6edccdc-instrument-4-audio.wav	0	1	120	120	0.6	2019-12-04 15:09:12.219195	2019-12-04 15:09:12.219195
1583199c-16eb-11ea-8a37-e32a35cc0ada	152fbc70-16eb-11ea-8a37-2f91c79f438d	Test	579b3ad1-e23b-4a2c-bd07-a2c416e1edaf-instrument-4-audio.wav	0	1	100	100	0.6	2019-12-04 15:09:12.225821	2019-12-04 15:09:12.225821
15840ed8-16eb-11ea-8a37-e349062177e3	152fbc70-16eb-11ea-8a37-2f91c79f438d	Kick 3	c076a674-1626-4b22-bc07-a639ca90b363-instrument-4-audio.wav	0.01	0.677	120	56.178	0.6	2019-12-04 15:09:12.232099	2019-12-04 15:09:12.232099
1586371c-16eb-11ea-8a37-bbacf86fd3a0	152fbc70-16eb-11ea-8a37-2f91c79f438d	Vocal Hey	5d808588-5930-4075-a034-4f96b0e2b06f-instrument-4-audio.wav	0.046	0.453	120	760.345	0.6	2019-12-04 15:09:12.246339	2019-12-04 15:09:12.246339
1588694c-16eb-11ea-8a37-f3996bdbad4c	152fbc70-16eb-11ea-8a37-2f91c79f438d	Cowbell	392a388d-8e32-46f9-ad57-b3bd29929262-instrument-4-audio.wav	0.002	0.298	120	525	0.6	2019-12-04 15:09:12.260751	2019-12-04 15:09:12.260751
158c39dc-16eb-11ea-8a37-e3725d5c4c41	158a6738-16eb-11ea-8a37-3706e5d25249	Snare Rim	911ff421-989d-4c3d-8bc8-85eddc0d4d62-instrument-33-audio.wav	0	1.147	120	239.674	0.6	2019-12-04 15:09:12.285761	2019-12-04 15:09:12.285761
158dbfd2-16eb-11ea-8a37-6bc5f72ececd	158a6738-16eb-11ea-8a37-3706e5d25249	Conga High	bf0ee9b7-de10-4826-b48a-5c3ae361258c-instrument-33-audio.wav	0.002	0.425	120	187.66	0.6	2019-12-04 15:09:12.295751	2019-12-04 15:09:12.295751
158efe9c-16eb-11ea-8a37-13014c2f115a	158a6738-16eb-11ea-8a37-3706e5d25249	Tom Low 5	3bfab5c2-974b-452d-b7ee-53347f0b12eb-instrument-33-audio.wav	0	0.73	120	84.483	0.6	2019-12-04 15:09:12.303872	2019-12-04 15:09:12.303872
159042a2-16eb-11ea-8a37-ebec7a4234be	158a6738-16eb-11ea-8a37-3706e5d25249	Kick 7	713f3c48-10ed-4f90-90a4-a28afc53f33e-instrument-33-audio.wav	0.008	0.537	120	43.534	0.6	2019-12-04 15:09:12.312201	2019-12-04 15:09:12.312201
159196a2-16eb-11ea-8a37-03b250beb804	158a6738-16eb-11ea-8a37-3706e5d25249	Cymbal Crash 1	505cba94-a3ff-4e64-8b25-dbe25176e410-instrument-33-audio.wav	0.018	1.878	120	1297.06	0.6	2019-12-04 15:09:12.320916	2019-12-04 15:09:12.320916
15934bc8-16eb-11ea-8a37-73c9b3662648	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Closed 7	cacdebae-527f-44ac-98f7-ba3bfeefa4fb-instrument-33-audio.wav	0.003	0.962	120	8820	0.6	2019-12-04 15:09:12.332101	2019-12-04 15:09:12.332101
15956a98-16eb-11ea-8a37-c39ed5467310	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Closed 9	8059bae2-1e79-4623-839e-dae5dc29cb3c-instrument-33-audio.wav	0	0.849	120	648.529	0.6	2019-12-04 15:09:12.346017	2019-12-04 15:09:12.346017
1597f740-16eb-11ea-8a37-0343a07e973e	158a6738-16eb-11ea-8a37-3706e5d25249	Cowbell	9602390a-51f8-44dc-a9a3-d40d9d26b509-instrument-33-audio.wav	0.002	0.298	120	525	0.6	2019-12-04 15:09:12.362589	2019-12-04 15:09:12.362589
159a9798-16eb-11ea-8a37-6778357cb367	158a6738-16eb-11ea-8a37-3706e5d25249	Conga	70fbac42-0c65-4acf-bc6d-216b656e1ab2-instrument-33-audio.wav	0.001	0.547	120	183.231	0.6	2019-12-04 15:09:12.379779	2019-12-04 15:09:12.379779
159cde68-16eb-11ea-8a37-dfb4f154dd49	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Open 5	a3cda1c6-d620-4b5e-a819-0ab5fc49097a-instrument-33-audio.wav	0.003	1.115	120	648.529	0.6	2019-12-04 15:09:12.394732	2019-12-04 15:09:12.394732
159ebe68-16eb-11ea-8a37-03c7d0e4ede8	158a6738-16eb-11ea-8a37-3706e5d25249	Tom 5	4840ae0e-5b15-4ad3-893f-78ba35950c8f-instrument-33-audio.wav	0	0.59	120	90.928	0.6	2019-12-04 15:09:12.406998	2019-12-04 15:09:12.406998
15a09f62-16eb-11ea-8a37-e32d9fcb84a4	158a6738-16eb-11ea-8a37-3706e5d25249	Snare Rim 7	907fadd8-8e79-46a2-b6ae-6ba1068becbf-instrument-33-audio.wav	0	0.461	120	254.913	0.6	2019-12-04 15:09:12.419311	2019-12-04 15:09:12.419311
15a250c8-16eb-11ea-8a37-ebe11f607753	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Open 7	5ac13b1b-5314-4e10-b23f-3ee7e4ee832b-instrument-33-audio.wav	0	2	120	648.529	0.6	2019-12-04 15:09:12.430479	2019-12-04 15:09:12.430479
15a445b8-16eb-11ea-8a37-63add7371ead	158a6738-16eb-11ea-8a37-3706e5d25249	Stick Side 5	a0f17131-c241-474d-8aa1-e955e3815e72-instrument-33-audio.wav	0	0.248	120	1837.5	0.6	2019-12-04 15:09:12.44331	2019-12-04 15:09:12.44331
15a6b37a-16eb-11ea-8a37-371c7bf5c306	158a6738-16eb-11ea-8a37-3706e5d25249	Kick Long 2	129a9d14-1cc3-4699-8428-457ee7cea45f-instrument-33-audio.wav	0.01	1.476	120	59.036	0.6	2019-12-04 15:09:12.459204	2019-12-04 15:09:12.459204
15a90026-16eb-11ea-8a37-0bb1f8fb7aae	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Closed 8	03ebbe93-4900-4638-88d8-ddcc75a745ce-instrument-33-audio.wav	0	0.905	120	648.529	0.6	2019-12-04 15:09:12.474305	2019-12-04 15:09:12.474305
15aaed46-16eb-11ea-8a37-a3310f2b1faa	158a6738-16eb-11ea-8a37-3706e5d25249	Stick Side 7	34341f53-8995-4d09-9157-34f72feccaef-instrument-33-audio.wav	0.003	0.159	120	436.634	0.6	2019-12-04 15:09:12.486969	2019-12-04 15:09:12.486969
15ac7f94-16eb-11ea-8a37-b30bdde5e058	158a6738-16eb-11ea-8a37-3706e5d25249	Tom High	bcb153cd-b375-4da0-877d-add68dfbac71-instrument-33-audio.wav	0.002	0.42	120	187.66	0.6	2019-12-04 15:09:12.497281	2019-12-04 15:09:12.497281
15adc7d2-16eb-11ea-8a37-eba0a422e90b	158a6738-16eb-11ea-8a37-3706e5d25249	Clap 2	00646186-d34e-4924-aefd-6c7f8c35cd2c-instrument-33-audio.wav	0	0.684	120	188.462	0.6	2019-12-04 15:09:12.505669	2019-12-04 15:09:12.505669
15ae6c46-16eb-11ea-8a37-bf97dcf2184f	158a6738-16eb-11ea-8a37-3706e5d25249	Tom High 5	acecd4e5-ec2e-40f9-a02e-a0903590c08b-instrument-33-audio.wav	0.003	0.444	120	126	0.6	2019-12-04 15:09:12.509892	2019-12-04 15:09:12.509892
15b01c76-16eb-11ea-8a37-e36b6db5328c	158a6738-16eb-11ea-8a37-3706e5d25249	Snare 5	ed2f4c2d-0d10-4131-b948-53dd3c8fbed9-instrument-33-audio.wav	0.008	0.407	120	180.738	0.6	2019-12-04 15:09:12.520833	2019-12-04 15:09:12.520833
15b1d958-16eb-11ea-8a37-b34aa616e2ff	158a6738-16eb-11ea-8a37-3706e5d25249	Kick 3	b502bc7f-2569-48d4-a407-1f3be100c6c6-instrument-33-audio.wav	0.01	0.677	120	56.178	0.6	2019-12-04 15:09:12.532211	2019-12-04 15:09:12.532211
15b4a50c-16eb-11ea-8a37-23d43c4e8e1a	158a6738-16eb-11ea-8a37-3706e5d25249	Snare Rim 6	24f783b2-e67e-44bd-a65d-d772569a62a7-instrument-33-audio.wav	0	0.527	120	245	0.6	2019-12-04 15:09:12.550501	2019-12-04 15:09:12.550501
15b74af0-16eb-11ea-8a37-73d7aa087140	158a6738-16eb-11ea-8a37-3706e5d25249	Snare 3	f3635b83-f52d-4d6b-a447-73718408762a-instrument-33-audio.wav	0.008	0.404	120	2450	0.6	2019-12-04 15:09:12.567882	2019-12-04 15:09:12.567882
15b9ab1a-16eb-11ea-8a37-2f47c03fc9f8	158a6738-16eb-11ea-8a37-3706e5d25249	Cymbal Crash 2	ec5c6494-21d6-44fc-9b47-72d9c321b3e3-instrument-33-audio.wav	0.01	3.241	120	469.149	0.6	2019-12-04 15:09:12.583463	2019-12-04 15:09:12.583463
15bc2494-16eb-11ea-8a37-db6fe392b666	158a6738-16eb-11ea-8a37-3706e5d25249	Snare 4	dcc530f8-ba21-4b98-aa3a-71168868b94a-instrument-33-audio.wav	0.008	0.439	120	204.167	0.6	2019-12-04 15:09:12.599644	2019-12-04 15:09:12.599644
15bde9e6-16eb-11ea-8a37-1f7977fbb70d	158a6738-16eb-11ea-8a37-3706e5d25249	Hihat Open 6	3cfaedd6-d3f9-4a64-9353-ce4b91f4c59b-instrument-33-audio.wav	0	0.809	120	648.529	0.6	2019-12-04 15:09:12.611281	2019-12-04 15:09:12.611281
15bfa966-16eb-11ea-8a37-4f933eb4be7e	158a6738-16eb-11ea-8a37-3706e5d25249	Snare Rim 5	1a1fb20f-a03c-4640-a6d6-c650b1120998-instrument-33-audio.wav	0	0.463	120	181.481	0.6	2019-12-04 15:09:12.622749	2019-12-04 15:09:12.622749
15c19e56-16eb-11ea-8a37-fbc32b45407c	158a6738-16eb-11ea-8a37-3706e5d25249	Tom	1493e34b-a70b-4c4b-b319-6fa154905d29-instrument-33-audio.wav	0.009	0.445	120	225	0.6	2019-12-04 15:09:12.635555	2019-12-04 15:09:12.635555
15c352f0-16eb-11ea-8a37-0f3aa3ebbf5d	158a6738-16eb-11ea-8a37-3706e5d25249	Clap 1	27168cb8-ebc1-4e9a-aff1-b551cc7c9035-instrument-33-audio.wav	0	0.572	120	185.294	0.6	2019-12-04 15:09:12.646755	2019-12-04 15:09:12.646755
15c5e768-16eb-11ea-8a37-33eec03fda08	158a6738-16eb-11ea-8a37-3706e5d25249	Stick Side 6	610db17f-f525-4696-a6c9-122724e6bed5-instrument-33-audio.wav	0	0.335	120	2321.05	0.6	2019-12-04 15:09:12.663662	2019-12-04 15:09:12.663662
15c89238-16eb-11ea-8a37-f700647fffbf	158a6738-16eb-11ea-8a37-3706e5d25249	Kick 3	94f456f1-832e-464b-8c0f-fd072e9c3d51-instrument-33-audio.wav	0.005	0.742	120	52.128	0.6	2019-12-04 15:09:12.681134	2019-12-04 15:09:12.681134
15cb1d6e-16eb-11ea-8a37-a7a0c1487717	158a6738-16eb-11ea-8a37-3706e5d25249	Cymbal Crash 3	2119399f-7d57-4256-8195-0fd5c9318865-instrument-33-audio.wav	0.01	3.044	120	181.481	0.6	2019-12-04 15:09:12.697768	2019-12-04 15:09:12.697768
15cf3e08-16eb-11ea-8a37-c33fa6144649	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Tom 1	042d2f0a-6e50-4e46-8842-315cee1e9bbf-instrument-34-audio.wav	0	0.658	121	156.216	0.6	2019-12-04 15:09:12.724907	2019-12-04 15:09:12.724907
15d0a572-16eb-11ea-8a37-b77d3acff86e	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Open 4	e127c584-e507-43db-9a09-ede286f3855e-instrument-34-audio.wav	0.048	0.456	121	4894.78	0.6	2019-12-04 15:09:12.734117	2019-12-04 15:09:12.734117
15d1e522-16eb-11ea-8a37-4750e297d84b	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Kick B3	956b5970-2552-4b2e-867e-53391e487b62-instrument-34-audio.wav	0	0.719	121	76.085	0.6	2019-12-04 15:09:12.742328	2019-12-04 15:09:12.742328
15d31ce4-16eb-11ea-8a37-0b19574512c9	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Closed 5	ff67294e-2e40-430b-900e-97635b2fb28d-instrument-34-audio.wav	0	0.397	121	3671.08	0.6	2019-12-04 15:09:12.750323	2019-12-04 15:09:12.750323
15d53fce-16eb-11ea-8a37-8b549035857a	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Closed 2	8ea17691-f68b-429f-9702-8b3a632fb143-instrument-34-audio.wav	0.005	0.232	121	299.68	0.6	2019-12-04 15:09:12.764304	2019-12-04 15:09:12.764304
15d7643e-16eb-11ea-8a37-47f203d1021e	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Closed 4	950b053a-d83f-4f26-860d-543694b2daf4-instrument-34-audio.wav	0.005	0.447	121	4004.82	0.6	2019-12-04 15:09:12.778356	2019-12-04 15:09:12.778356
15d92e90-16eb-11ea-8a37-7fcd51c6e8bb	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Open 3	c248a5f8-6d25-4db6-a8ab-f5aeb4df85b4-instrument-34-audio.wav	0.048	0.453	121	4894.78	0.6	2019-12-04 15:09:12.790094	2019-12-04 15:09:12.790094
15daf540-16eb-11ea-8a37-ef891c7c3de0	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Open 2	55633d22-d328-469d-98a0-ca771ad21a00-instrument-34-audio.wav	0.05	0.467	121	4894.78	0.6	2019-12-04 15:09:12.801742	2019-12-04 15:09:12.801742
15dc2ec4-16eb-11ea-8a37-93de29c88f89	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Tom 4	7456aef7-0c4c-4cc5-a509-089389157349-instrument-34-audio.wav	0	0.746	121	147.829	0.6	2019-12-04 15:09:12.809775	2019-12-04 15:09:12.809775
15dd61c2-16eb-11ea-8a37-5f4252464cf5	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Tom 2	1393d95f-a8eb-40b2-ad39-bc09edfbdbdf-instrument-34-audio.wav	0	0.207	121	157.896	0.6	2019-12-04 15:09:12.817578	2019-12-04 15:09:12.817578
15de8c32-16eb-11ea-8a37-bf933a29a6f2	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Snare 1	44b5b9b4-7316-432f-b092-f98bcdfd07ac-instrument-34-audio.wav	0.019	0.607	121	321.555	0.6	2019-12-04 15:09:12.825269	2019-12-04 15:09:12.825269
15dfae50-16eb-11ea-8a37-cfcfff8fbd5e	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Crash 1	82a7ed83-e780-4499-8847-5f38bde617c7-instrument-34-audio.wav	0	4.032	121	4900	0.6	2019-12-04 15:09:12.832693	2019-12-04 15:09:12.832693
15e24fb6-16eb-11ea-8a37-77148e5000b2	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Kick B4	35ac1df2-b427-4cb8-b8d0-dbbfbf092118-instrument-34-audio.wav	0	0.844	121	3671.08	0.6	2019-12-04 15:09:12.849897	2019-12-04 15:09:12.849897
15e475f2-16eb-11ea-8a37-472002a9619f	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Tom 5	4cf09790-cf28-4dd2-9588-5df94368cec1-instrument-34-audio.wav	0	0.78	121	148.828	0.6	2019-12-04 15:09:12.864018	2019-12-04 15:09:12.864018
15e64a94-16eb-11ea-8a37-3fc3208bdf8a	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Snare 2	84511e45-abbe-46c2-926a-b305dbb053a7-instrument-34-audio.wav	0.015	0.489	121	917.771	0.6	2019-12-04 15:09:12.876021	2019-12-04 15:09:12.876021
15e81cf2-16eb-11ea-8a37-ff3c37e62cdb	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Tom 3	f6b2905a-6c8c-4a5c-9f78-5fbced18d5ad-instrument-34-audio.wav	0	0.205	121	156.216	0.6	2019-12-04 15:09:12.887952	2019-12-04 15:09:12.887952
15e95540-16eb-11ea-8a37-8310b1b3b1b3	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Snare 5	4f6bfbe3-a8f1-4d49-bd8d-b3a4a8d1e3a5-instrument-34-audio.wav	0.012	0.57	121	270.264	0.6	2019-12-04 15:09:12.895952	2019-12-04 15:09:12.895952
15ea94be-16eb-11ea-8a37-afd4d8df22f2	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Snare 3	6de10769-b73a-49c3-9e2d-a066caa2c4b6-instrument-34-audio.wav	0.009	0.633	121	160.777	0.6	2019-12-04 15:09:12.904109	2019-12-04 15:09:12.904109
15ebcfe6-16eb-11ea-8a37-672c26cf8c0b	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Snare 4	8d18a3b1-bc07-46ae-a704-12141ffde112-instrument-34-audio.wav	0.009	0.595	121	518.271	0.6	2019-12-04 15:09:12.912115	2019-12-04 15:09:12.912115
15ed1090-16eb-11ea-8a37-2ffe7d230287	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Open 1	d4b1b624-3bc8-40c5-835e-b276b6ab4e93-instrument-34-audio.wav	0.042	0.426	121	4894.78	0.6	2019-12-04 15:09:12.920403	2019-12-04 15:09:12.920403
15ef2808-16eb-11ea-8a37-c7126a46d583	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Closed 1	5a5f246d-3af0-4eaa-984b-df605e690e54-instrument-34-audio.wav	0.014	0.357	121	1631.59	0.6	2019-12-04 15:09:12.934108	2019-12-04 15:09:12.934108
15f1426e-16eb-11ea-8a37-a7db091794e9	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Hihat Closed 3	97f96d1f-7af4-4d3e-911e-654f12b0b06e-instrument-34-audio.wav	0.01	0.248	121	3388.69	0.6	2019-12-04 15:09:12.947892	2019-12-04 15:09:12.947892
15f32002-16eb-11ea-8a37-2b9699682645	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Crash 2	98212bf8-f414-45d2-b110-7feb549e4649-instrument-34-audio.wav	0	4.024	121	4009.09	0.6	2019-12-04 15:09:12.960121	2019-12-04 15:09:12.960121
15f6d3b4-16eb-11ea-8a37-3b196945f756	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 8	d6add194-6fa5-4cb7-ba33-8cc353e18486-instrument-32-audio.wav	0	0.319	121	380.952	0.6	2019-12-04 15:09:12.984377	2019-12-04 15:09:12.984377
15f80cc0-16eb-11ea-8a37-f7e122e42b5d	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 6	f2e4b541-9a12-4ccd-b8ec-831dfa481075-instrument-32-audio.wav	0	0.244	121	842.105	0.6	2019-12-04 15:09:12.992387	2019-12-04 15:09:12.992387
15f9350a-16eb-11ea-8a37-17cc83e69c3e	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 8	1b7bb65b-9ce3-41db-bd80-9b7e2d8d07c1-instrument-32-audio.wav	0	0.269	121	80.672	0.6	2019-12-04 15:09:12.999969	2019-12-04 15:09:12.999969
15fada54-16eb-11ea-8a37-dff32f945cc6	15f4f92c-16eb-11ea-8a37-2f529693f38a	Crash 3	053b6a93-4cfc-4262-9e2e-d4e998849eed-instrument-32-audio.wav	0.015	1.109	121	506.897	0.6	2019-12-04 15:09:13.01075	2019-12-04 15:09:13.01075
15fcee34-16eb-11ea-8a37-77b0e480684a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 10	9b9db8ec-f772-4369-8250-ed750493e569-instrument-32-audio.wav	0	0.269	121	214.286	0.6	2019-12-04 15:09:13.024386	2019-12-04 15:09:13.024386
15fedb7c-16eb-11ea-8a37-7f01beb1835a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 4	362e452b-e168-4e06-aa04-bad9866b0cad-instrument-32-audio.wav	0	0.232	121	279.07	0.6	2019-12-04 15:09:13.036975	2019-12-04 15:09:13.036975
1600be60-16eb-11ea-8a37-1be582427bd7	15f4f92c-16eb-11ea-8a37-2f529693f38a	Crash 10	5f59b257-1dba-44e1-9a15-86912f7250ce-instrument-32-audio.wav	0.029	2.116	121	774.194	0.6	2019-12-04 15:09:13.049341	2019-12-04 15:09:13.049341
1602496a-16eb-11ea-8a37-9fd1a7179292	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 6	ec419cb6-de9d-4ebc-8e8b-3ae98541819b-instrument-32-audio.wav	0.006	0.36	121	78.947	0.6	2019-12-04 15:09:13.059453	2019-12-04 15:09:13.059453
16038dde-16eb-11ea-8a37-3be2bb617d99	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 11	0587a41b-ddf3-4802-a8b1-de671321a5c5-instrument-32-audio.wav	0	0.237	121	4000	0.6	2019-12-04 15:09:13.067788	2019-12-04 15:09:13.067788
1604b2e0-16eb-11ea-8a37-23631f1c8467	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 9	973a5ed8-3dd6-41db-a83a-1e3f52071a8e-instrument-32-audio.wav	0	0.264	121	75	0.6	2019-12-04 15:09:13.075326	2019-12-04 15:09:13.075326
1605d71a-16eb-11ea-8a37-67d880f623f5	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 10	c6396c9f-1e57-46ff-acab-0f408ea87c2d-instrument-32-audio.wav	0	0.28	121	66.946	0.6	2019-12-04 15:09:13.082786	2019-12-04 15:09:13.082786
1607ea6e-16eb-11ea-8a37-bb1a343cdc3a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 3	c5091d09-3df0-4563-adc2-b36b4057a955-instrument-32-audio.wav	0	0.269	121	4000	0.6	2019-12-04 15:09:13.096258	2019-12-04 15:09:13.096258
160a7004-16eb-11ea-8a37-47724b9e225b	15f4f92c-16eb-11ea-8a37-2f529693f38a	Crash 7	1f776bdc-517f-4a25-82cb-2abcac09cda0-instrument-32-audio.wav	0.091	0.98	121	6300	0.6	2019-12-04 15:09:13.112792	2019-12-04 15:09:13.112792
160cf28e-16eb-11ea-8a37-bf00d4f95b34	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 4	15d9f7f2-be82-4a30-9d82-e00b5628c78a-instrument-32-audio.wav	0	0.287	121	8000	0.6	2019-12-04 15:09:13.129228	2019-12-04 15:09:13.129228
160f78f6-16eb-11ea-8a37-3f46f247080e	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 5	e3f9975f-1827-4853-a949-4a72fd01df41-instrument-32-audio.wav	0	0.243	121	333.333	0.6	2019-12-04 15:09:13.145686	2019-12-04 15:09:13.145686
16119f96-16eb-11ea-8a37-2374ce2bb83a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 2 	63fb2984-fdf3-4100-86f1-5f70b77e0df8-instrument-32-audio.wav	0	0.306	121	111.111	0.6	2019-12-04 15:09:13.159887	2019-12-04 15:09:13.159887
16135bec-16eb-11ea-8a37-772f78675e55	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 1	897ffb89-a52b-4223-92a7-529dd458c45a-instrument-32-audio.wav	0	0.355	121	55.879	0.6	2019-12-04 15:09:13.171262	2019-12-04 15:09:13.171262
16150bfe-16eb-11ea-8a37-ef41b3298ca3	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 7	3f1fc10d-de1a-470a-8745-1c3580407016-instrument-32-audio.wav	0	0.255	121	12000	0.6	2019-12-04 15:09:13.182311	2019-12-04 15:09:13.182311
1616b6d4-16eb-11ea-8a37-d7b29d431d11	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 2	56d29d62-3a85-4ba8-8987-ffcda52e49e8-instrument-32-audio.wav	0	0.297	121	9600	0.6	2019-12-04 15:09:13.193236	2019-12-04 15:09:13.193236
1618d75c-16eb-11ea-8a37-a7b2b0baf722	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 7	77b26556-ce32-4500-9955-4508915e8b8e-instrument-32-audio.wav	0	0.349	121	98.969	0.6	2019-12-04 15:09:13.207192	2019-12-04 15:09:13.207192
161b7f98-16eb-11ea-8a37-3b109d091684	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 5	44c4ce78-ca9c-4dda-a931-7266c0a9295b-instrument-32-audio.wav	0	0.269	121	100.84	0.6	2019-12-04 15:09:13.224593	2019-12-04 15:09:13.224593
161ecd1a-16eb-11ea-8a37-c74ca21d9554	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 4	41a86e00-13e1-43bd-b6a9-124dd8eab117-instrument-32-audio.wav	0.002	0.285	121	113.475	0.6	2019-12-04 15:09:13.246194	2019-12-04 15:09:13.246194
16210698-16eb-11ea-8a37-5f46b002376d	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 9	9ca6169c-d5f6-4da7-ae33-901b909537d4-instrument-32-audio.wav	0	0.275	121	8000	0.6	2019-12-04 15:09:13.260818	2019-12-04 15:09:13.260818
1622cb40-16eb-11ea-8a37-57b5501b3aab	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kenkeni 4	5b5ae8cd-5987-49fa-9c48-bd461e0ef90a-instrument-28-audio.wav	0	1.25	121	125	0.6	2019-12-04 15:09:13.272414	2019-12-04 15:09:13.272414
16247c56-16eb-11ea-8a37-5bfffc524466	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kenkeni 3	554de69f-0434-42d0-989c-dc7a02179dec-instrument-28-audio.wav	0	1	121	46.967	0.6	2019-12-04 15:09:13.283512	2019-12-04 15:09:13.283512
16261ae8-16eb-11ea-8a37-8bd8ad8ff48a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 1	c59874f8-5e5c-40e5-9761-75f32286c8b6-instrument-32-audio.wav	0	0.344	121	159.468	0.6	2019-12-04 15:09:13.29413	2019-12-04 15:09:13.29413
1628043e-16eb-11ea-8a37-8bd6d91c4249	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 6	4070a2df-a5cd-434e-9902-7e607310de1d-instrument-32-audio.wav	0	0.333	121	163.265	0.6	2019-12-04 15:09:13.306641	2019-12-04 15:09:13.306641
162a96f4-16eb-11ea-8a37-c32f50f5240f	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 7	c49cd26a-64e2-4a50-9133-55b18ce389b2-instrument-32-audio.wav	0	0.232	121	169.014	0.6	2019-12-04 15:09:13.323486	2019-12-04 15:09:13.323486
162d1b72-16eb-11ea-8a37-13bc67959774	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 8	2e672449-b46e-4633-8758-72d18fb98b99-instrument-32-audio.wav	0	0.333	121	206.009	0.6	2019-12-04 15:09:13.339993	2019-12-04 15:09:13.339993
162f6c2e-16eb-11ea-8a37-e702d5dcab08	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kick 3	b0ceec8f-376c-479b-95b0-e61ed56de370-instrument-32-audio.wav	0.003	0.487	121	85.868	0.6	2019-12-04 15:09:13.355179	2019-12-04 15:09:13.355179
1631b27c-16eb-11ea-8a37-43f400097d9a	15f4f92c-16eb-11ea-8a37-2f529693f38a	Kenkeni 7	ac215ada-a632-456d-9894-305ca6e13fc0-instrument-28-audio.wav	0.0003	1.375	121	110.092	0.6	2019-12-04 15:09:13.370039	2019-12-04 15:09:13.370039
16339754-16eb-11ea-8a37-27e92bd7db81	15f4f92c-16eb-11ea-8a37-2f529693f38a	Snare 2	f0bd8b02-29d2-42d5-a122-da1c58408f77-instrument-32-audio.wav	0	0.285	121	175.182	0.6	2019-12-04 15:09:13.382433	2019-12-04 15:09:13.382433
163534ce-16eb-11ea-8a37-d7e892297c8b	15f4f92c-16eb-11ea-8a37-2f529693f38a	Djembe Rattle	824ac18d-cf19-4ebe-9f4b-d2a16a20a526-instrument-28-audio.wav	0.0003	0.5	121	12000	0.6	2019-12-04 15:09:13.393128	2019-12-04 15:09:13.393128
1636799c-16eb-11ea-8a37-77ca1514f090	15f4f92c-16eb-11ea-8a37-2f529693f38a	Hi-Hat 1	87dc20e3-67d8-4639-805f-3787d384a45a-instrument-32-audio.wav	0	0.239	121	12000	0.6	2019-12-04 15:09:13.40148	2019-12-04 15:09:13.40148
163b6c40-16eb-11ea-8a37-3749a746e87c	1637e066-16eb-11ea-8a37-c7f42ae039d6	Punchy Kick 4	4066c8ba-28ad-464c-a87a-ebc6107b2de3-instrument-28-audio.wav	0.0002	0.375	121	95.618	0.6	2019-12-04 15:09:13.433907	2019-12-04 15:09:13.433907
163d96d2-16eb-11ea-8a37-cf8ff2161c76	1637e066-16eb-11ea-8a37-c7f42ae039d6	Long Snare	f4144bde-9ccd-4851-b855-f00280689b2a-instrument-28-audio.wav	0	0.375	121	142.433	0.6	2019-12-04 15:09:13.448043	2019-12-04 15:09:13.448043
163fa170-16eb-11ea-8a37-f326c004690e	1637e066-16eb-11ea-8a37-c7f42ae039d6	Shaker 2	d48bc52b-95f4-4a5c-81f2-804ff13b84d3-instrument-28-audio.wav	0	0.203	121	5333.33	0.6	2019-12-04 15:09:13.461509	2019-12-04 15:09:13.461509
164142dc-16eb-11ea-8a37-574e08f07300	1637e066-16eb-11ea-8a37-c7f42ae039d6	Weird Snap	7793c912-032b-41e4-9fcf-c2d43df4389d-instrument-28-audio.wav	0.0006	0.25	121	8000	0.6	2019-12-04 15:09:13.472085	2019-12-04 15:09:13.472085
164305fe-16eb-11ea-8a37-936492f9f199	1637e066-16eb-11ea-8a37-c7f42ae039d6	Kenkeni 6	8a4c6a10-841f-46d7-94e3-be8370624824-instrument-28-audio.wav	0	0.5	121	4363.64	0.6	2019-12-04 15:09:13.483602	2019-12-04 15:09:13.483602
1644dd52-16eb-11ea-8a37-b37e942f3857	1637e066-16eb-11ea-8a37-c7f42ae039d6	Open Kick	24012246-e99a-4391-a1e9-800b5fcf3e7d-instrument-28-audio.wav	0.0004	0.625	121	85.409	0.6	2019-12-04 15:09:13.495723	2019-12-04 15:09:13.495723
16465e66-16eb-11ea-8a37-cb8018b1e6d9	1637e066-16eb-11ea-8a37-c7f42ae039d6	Kenkeni 2	9edcee06-73e2-4fcd-80c1-d0b58ecf30c6-instrument-28-audio.wav	0	1.5	121	85.258	0.6	2019-12-04 15:09:13.505544	2019-12-04 15:09:13.505544
16484eec-16eb-11ea-8a37-2f2cc6784740	1637e066-16eb-11ea-8a37-c7f42ae039d6	Punchy Kick	5b1c7886-c39e-4904-8621-670e7b40f789-instrument-28-audio.wav	0.012	0.375	121	67.321	0.6	2019-12-04 15:09:13.51837	2019-12-04 15:09:13.51837
164a62d6-16eb-11ea-8a37-2f8d078d8455	1637e066-16eb-11ea-8a37-c7f42ae039d6	Djembe Slap 	4685744e-ab0c-4cc0-904e-9c2698df6e96-instrument-28-audio.wav	0.0004	0.375	121	238.806	0.6	2019-12-04 15:09:13.531998	2019-12-04 15:09:13.531998
164c66ee-16eb-11ea-8a37-43474b909f06	1637e066-16eb-11ea-8a37-c7f42ae039d6	Open Kick 3	10290e3b-a443-4354-a82c-d153c21515ae-instrument-28-audio.wav	0.0002	0.375	121	124.031	0.6	2019-12-04 15:09:13.545212	2019-12-04 15:09:13.545212
164e846a-16eb-11ea-8a37-9f6407ac6092	1637e066-16eb-11ea-8a37-c7f42ae039d6	Punchy Kick 2	a736fa1d-cece-4f2b-b2ab-966969c4b9af-instrument-28-audio.wav	0.0001	0.375	121	8000	0.6	2019-12-04 15:09:13.559011	2019-12-04 15:09:13.559011
165011f4-16eb-11ea-8a37-87b795c582ae	1637e066-16eb-11ea-8a37-c7f42ae039d6	Punchy Kick 3	ee1d1039-a388-4e5f-9504-77a40d59ab5f-instrument-28-audio.wav	0.0002	0.375	121	8000	0.6	2019-12-04 15:09:13.569229	2019-12-04 15:09:13.569229
16515d70-16eb-11ea-8a37-cbb6f1410315	1637e066-16eb-11ea-8a37-c7f42ae039d6	Kenkeni 5	ce6f3bb6-3d7d-4c2f-ab3a-70899d3f737e-instrument-28-audio.wav	0	0.5	121	77.922	0.6	2019-12-04 15:09:13.577729	2019-12-04 15:09:13.577729
1652abbc-16eb-11ea-8a37-f388a2787123	1637e066-16eb-11ea-8a37-c7f42ae039d6	Kenkeni	e5c79d56-7dca-4dfe-8d3e-c6cd4215d798-instrument-28-audio.wav	0.0047	0.5	121	80.672	0.6	2019-12-04 15:09:13.586275	2019-12-04 15:09:13.586275
1653f71a-16eb-11ea-8a37-b7b2bfebe335	1637e066-16eb-11ea-8a37-c7f42ae039d6	Djembe Slap 2	2d3b1bc7-919a-4419-abc4-25acdf57ee9d-instrument-28-audio.wav	0.0009	0.375	121	375	0.6	2019-12-04 15:09:13.594774	2019-12-04 15:09:13.594774
1655d972-16eb-11ea-8a37-0f53a1489e7c	1637e066-16eb-11ea-8a37-c7f42ae039d6	Fat Snare	f92fa9e7-a7e9-43c0-93fa-4df241b476a9-instrument-28-audio.wav	0	0.375	121	3692.31	0.6	2019-12-04 15:09:13.607128	2019-12-04 15:09:13.607128
16583b5e-16eb-11ea-8a37-e77e136d9512	1637e066-16eb-11ea-8a37-c7f42ae039d6	Crash 1	cd981b05-844f-4ede-b849-2acb4ad52537-instrument-28-audio.wav	0.006	0.799	121	6300	0.6	2019-12-04 15:09:13.622735	2019-12-04 15:09:13.622735
165a149c-16eb-11ea-8a37-d77f93b10495	1637e066-16eb-11ea-8a37-c7f42ae039d6	Snappy Rim Click	cb5fb85c-4aa5-4359-824f-bff600563ea0-instrument-28-audio.wav	0.0002	0.375	121	1170.73	0.6	2019-12-04 15:09:13.634869	2019-12-04 15:09:13.634869
165c0f90-16eb-11ea-8a37-7f7fbe67c77d	1637e066-16eb-11ea-8a37-c7f42ae039d6	Djembe Palm	0dcb66b5-e8e7-41b3-87df-7e3f5c0cd32d-instrument-28-audio.wav	0	0.375	121	238.806	0.6	2019-12-04 15:09:13.647755	2019-12-04 15:09:13.647755
165e80ea-16eb-11ea-8a37-0bfb1e61bef8	1637e066-16eb-11ea-8a37-c7f42ae039d6	Shaker	74c870b3-df58-4aea-80ad-aa2d10b64bd4-instrument-28-audio.wav	0	0.203	121	6000	0.6	2019-12-04 15:09:13.663849	2019-12-04 15:09:13.663849
165fbd66-16eb-11ea-8a37-37ca11a9734a	1637e066-16eb-11ea-8a37-c7f42ae039d6	Crash 14	88c12e09-171c-4c4d-825d-0d9f6e486e89-instrument-28-audio.wav	0.129	2.142	121	4000	0.6	2019-12-04 15:09:13.67193	2019-12-04 15:09:13.67193
16612070-16eb-11ea-8a37-27594286833f	1637e066-16eb-11ea-8a37-c7f42ae039d6	Shaker 3	a20f3994-de53-4648-abb2-77370b098db5-instrument-28-audio.wav	0	0.203	121	12000	0.6	2019-12-04 15:09:13.680906	2019-12-04 15:09:13.680906
166259c2-16eb-11ea-8a37-03b0b8cd5360	1637e066-16eb-11ea-8a37-c7f42ae039d6	Crispy Snare	baebb6b9-a4b9-4686-9c78-1222135faff3-instrument-28-audio.wav	0.002	0.25	121	187.5	0.6	2019-12-04 15:09:13.689029	2019-12-04 15:09:13.689029
16642b26-16eb-11ea-8a37-cf7307bb521d	1637e066-16eb-11ea-8a37-c7f42ae039d6	Open Kick 2	6f884c6b-a519-4bff-aaac-ac9eb57fcade-instrument-28-audio.wav	0	0.625	121	127.321	0.6	2019-12-04 15:09:13.700926	2019-12-04 15:09:13.700926
166639de-16eb-11ea-8a37-331e7c34d001	1637e066-16eb-11ea-8a37-c7f42ae039d6	Crash 6	7135b241-ebbd-48fa-91b1-45d64489b2ce-instrument-28-audio.wav	0.011	0.849	121	11025	0.6	2019-12-04 15:09:13.714448	2019-12-04 15:09:13.714448
166fb446-16eb-11ea-8a37-83f5c556d4bf	166815c4-16eb-11ea-8a37-634bb3ccef01	Maracas 2	f20dcce7-a936-446c-8692-c8caf37d8896-instrument-3-audio.wav	0.009	0.43	120	11025	0.6	2019-12-04 15:09:13.776571	2019-12-04 15:09:13.776571
1671bc82-16eb-11ea-8a37-3b8c927de119	166815c4-16eb-11ea-8a37-634bb3ccef01	Tom	a6bf0d86-6b45-4cf1-b404-2242095c7876-instrument-3-audio.wav	0	0.36	120	104.751	0.6	2019-12-04 15:09:13.789875	2019-12-04 15:09:13.789875
16738846-16eb-11ea-8a37-2f4665b30020	166815c4-16eb-11ea-8a37-634bb3ccef01	Tom 2	3fcb76bf-6168-4aef-a160-facd1bb18071-instrument-3-audio.wav	0	0.488	120	149.492	0.6	2019-12-04 15:09:13.801662	2019-12-04 15:09:13.801662
167541a4-16eb-11ea-8a37-37a42ae57760	166815c4-16eb-11ea-8a37-634bb3ccef01	Kick 2	a731fc44-5ae0-4e9f-a728-edfe1895da4b-instrument-3-audio.wav	0	0.34	120	69.122	0.6	2019-12-04 15:09:13.812937	2019-12-04 15:09:13.812937
16768fd2-16eb-11ea-8a37-cb3800cdf2dd	166815c4-16eb-11ea-8a37-634bb3ccef01	Clap 2	9a3e9e07-b1dd-44a5-9399-3b6c11bd72b1-instrument-3-audio.wav	0.002	0.356	120	1225	0.6	2019-12-04 15:09:13.821501	2019-12-04 15:09:13.821501
1677ae26-16eb-11ea-8a37-f36106242997	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Eow	0e2d5fb2-9d40-4741-9da8-bc9943722d66-instrument-3-audio.wav	0.045	0.486	120	383.478	0.6	2019-12-04 15:09:13.828845	2019-12-04 15:09:13.828845
1678c860-16eb-11ea-8a37-47d06217fb9c	166815c4-16eb-11ea-8a37-634bb3ccef01	Kick Long	ed1957b9-eea0-42f8-8493-b8874e1a6bf9-instrument-3-audio.wav	0	0.865	120	57.05	0.6	2019-12-04 15:09:13.836071	2019-12-04 15:09:13.836071
1679db88-16eb-11ea-8a37-f7ff8ee3a07e	166815c4-16eb-11ea-8a37-634bb3ccef01	Clap 3	f24484dd-b879-42c5-9c2a-71857555c319-instrument-3-audio.wav	0	0.734	120	980	0.6	2019-12-04 15:09:13.84312	2019-12-04 15:09:13.84312
167ba24c-16eb-11ea-8a37-67140810ac7e	166815c4-16eb-11ea-8a37-634bb3ccef01	Cymbal Crash	37a35a63-23e4-4ef6-a78e-db2577aa9a00-instrument-3-audio.wav	0	2.229	120	109.701	0.6	2019-12-04 15:09:13.854741	2019-12-04 15:09:13.854741
167d99f8-16eb-11ea-8a37-ebb6dd898fe9	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Hie	0248ed87-19e8-449c-9211-4722d6ab8342-instrument-3-audio.wav	0.1	0.477	120	364.463	0.6	2019-12-04 15:09:13.867653	2019-12-04 15:09:13.867653
167f61e8-16eb-11ea-8a37-fb65f456cd1d	166815c4-16eb-11ea-8a37-634bb3ccef01	Hihat Closed	0b7ea3d0-13ab-4c7c-ac66-1bec2e572c14-instrument-3-audio.wav	0	0.053	120	6300	0.6	2019-12-04 15:09:13.879319	2019-12-04 15:09:13.879319
16811d30-16eb-11ea-8a37-279e52ce8624	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Grunt Ooh 2	8896e8d4-0c31-4dd8-93ff-6982a30febdb-instrument-3-audio.wav	0.015	0.247	120	404.587	0.6	2019-12-04 15:09:13.890663	2019-12-04 15:09:13.890663
16825f24-16eb-11ea-8a37-d7649ee2248f	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Grunt Ooh	ef489ad1-fb9d-4e77-9b5c-a7b3570c8c09-instrument-3-audio.wav	0.011	0.213	120	1696.15	0.6	2019-12-04 15:09:13.8989	2019-12-04 15:09:13.8989
16837a08-16eb-11ea-8a37-efab00e02be8	166815c4-16eb-11ea-8a37-634bb3ccef01	Snare Rim	58fd7eae-b55e-4567-9c27-ead64b83488a-instrument-3-audio.wav	0	0.014	120	445.445	0.6	2019-12-04 15:09:13.90618	2019-12-04 15:09:13.90618
168492ee-16eb-11ea-8a37-874a30830408	166815c4-16eb-11ea-8a37-634bb3ccef01	Claves	aea2483c-7707-4100-aa86-b680668cd1a0-instrument-3-audio.wav	0	0.03	120	2594	0.6	2019-12-04 15:09:13.913348	2019-12-04 15:09:13.913348
1685b052-16eb-11ea-8a37-178d141033de	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Ahh	d35678fa-f163-433d-8741-250a530b5532-instrument-3-audio.wav	0.012	1.037	120	948.696	0.6	2019-12-04 15:09:13.920621	2019-12-04 15:09:13.920621
16877784-16eb-11ea-8a37-8b8f0451ee3c	166815c4-16eb-11ea-8a37-634bb3ccef01	Kick Long 2	84b1974c-02b0-406f-b78e-21414282986e-instrument-3-audio.wav	0	1.963	120	60.494	0.6	2019-12-04 15:09:13.932298	2019-12-04 15:09:13.932298
16897124-16eb-11ea-8a37-cb39f7e26b37	166815c4-16eb-11ea-8a37-634bb3ccef01	Snare	7ec44b7f-77fd-4a3a-a2df-f80f6cd7fcfe-instrument-3-audio.wav	0	0.093	120	177.823	0.6	2019-12-04 15:09:13.945254	2019-12-04 15:09:13.945254
168b3414-16eb-11ea-8a37-830848b56eba	166815c4-16eb-11ea-8a37-634bb3ccef01	Cowbell	aaa877a8-0c89-4781-93f8-69c722285b2a-instrument-3-audio.wav	0	0.34	120	268.902	0.6	2019-12-04 15:09:13.956806	2019-12-04 15:09:13.956806
168ce5de-16eb-11ea-8a37-cbd1e75b7017	166815c4-16eb-11ea-8a37-634bb3ccef01	Conga	f772f19f-b51b-414e-9dc8-8ceb23faa779-instrument-3-audio.wav	0	0.26	120	213	0.6	2019-12-04 15:09:13.967902	2019-12-04 15:09:13.967902
168e33e4-16eb-11ea-8a37-e3b56cf4ce34	166815c4-16eb-11ea-8a37-634bb3ccef01	Clap	ce0662a2-3f7e-425b-8105-fb639d395235-instrument-3-audio.wav	0	0.361	120	1102.5	0.6	2019-12-04 15:09:13.976429	2019-12-04 15:09:13.976429
168f588c-16eb-11ea-8a37-731cf262ac35	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Hoo	54d3503d-af44-4480-a0d0-8044fb403c5a-instrument-3-audio.wav	0.079	0.45	120	205.116	0.6	2019-12-04 15:09:13.983946	2019-12-04 15:09:13.983946
16907348-16eb-11ea-8a37-8bd1e4ce065d	166815c4-16eb-11ea-8a37-634bb3ccef01	Conga High	c0975d3a-4f26-44b2-a9d3-800320bfa3e1-instrument-3-audio.wav	0	0.179	120	397.297	0.6	2019-12-04 15:09:13.991156	2019-12-04 15:09:13.991156
16918f62-16eb-11ea-8a37-6719a136e377	166815c4-16eb-11ea-8a37-634bb3ccef01	Maracas	ffe4edd6-5b83-4ac9-8e69-156ddb06762f-instrument-3-audio.wav	0	0.026	120	190.086	0.6	2019-12-04 15:09:13.998451	2019-12-04 15:09:13.998451
16935b8a-16eb-11ea-8a37-a355e344b3ae	166815c4-16eb-11ea-8a37-634bb3ccef01	Hihat Open	020ad575-af86-4fe2-a869-957d50d59ac4-instrument-3-audio.wav	0	0.598	120	7350	0.6	2019-12-04 15:09:14.010225	2019-12-04 15:09:14.010225
16955c6e-16eb-11ea-8a37-97a63970d338	166815c4-16eb-11ea-8a37-634bb3ccef01	Cymbal Crash 2	bb3e2a48-8f59-4ad0-a05f-30aca579524f-instrument-3-audio.wav	0	2	120	816.667	0.6	2019-12-04 15:09:14.023368	2019-12-04 15:09:14.023368
169727b0-16eb-11ea-8a37-1f22887960fb	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal Haa	79b9c4f4-037a-4f6f-bc51-7a7a2dff5528-instrument-3-audio.wav	0.053	0.36	120	864.706	0.6	2019-12-04 15:09:14.035096	2019-12-04 15:09:14.035096
1698e8ca-16eb-11ea-8a37-9f700cc8c6b3	166815c4-16eb-11ea-8a37-634bb3ccef01	Kick	80454e35-5693-4b42-aa6a-218383a9f584-instrument-3-audio.wav	0	0.702	120	57.495	0.6	2019-12-04 15:09:14.046587	2019-12-04 15:09:14.046587
169a51ce-16eb-11ea-8a37-8b94ff7cffcb	166815c4-16eb-11ea-8a37-634bb3ccef01	Tom High 2	618bc8e5-f51f-4635-895c-5bd6522f8d8c-instrument-3-audio.wav	0.002	0.411	120	201.37	0.6	2019-12-04 15:09:14.055842	2019-12-04 15:09:14.055842
169b886e-16eb-11ea-8a37-97bffa57c894	166815c4-16eb-11ea-8a37-634bb3ccef01	Tom High	aea1351b-bb96-4487-8feb-ae8ad3e499ad-instrument-3-audio.wav	0	0.2	120	190.909	0.6	2019-12-04 15:09:14.063788	2019-12-04 15:09:14.063788
169cab04-16eb-11ea-8a37-63d2898e87ee	166815c4-16eb-11ea-8a37-634bb3ccef01	Vocal How	f70ead8e-f770-4782-83ce-854a1cb3c640-instrument-3-audio.wav	0.074	0.454	120	284.516	0.6	2019-12-04 15:09:14.071265	2019-12-04 15:09:14.071265
169d36dc-16eb-11ea-8a37-0fb41e36f4f2	166815c4-16eb-11ea-8a37-634bb3ccef01	Tom Low 2	014c8939-c9e7-4911-9620-9c4075a3b4a2-instrument-3-audio.wav	0	0.701	120	111.646	0.6	2019-12-04 15:09:14.07484	2019-12-04 15:09:14.07484
16a0ae66-16eb-11ea-8a37-cf034b98fd70	169ea38c-16eb-11ea-8a37-b799503ae436	Hihat Open	7067e7ee-f192-459a-8733-49e550467c67-instrument-35-audio.wav	0	0.598	120	7350	0.6	2019-12-04 15:09:14.097512	2019-12-04 15:09:14.097512
16a2a572-16eb-11ea-8a37-db831b623c02	169ea38c-16eb-11ea-8a37-b799503ae436	Tom	794713a0-e00d-4918-a729-7d343e09c719-instrument-35-audio.wav	0	0.36	120	104.751	0.6	2019-12-04 15:09:14.110418	2019-12-04 15:09:14.110418
16a48d7e-16eb-11ea-8a37-3bbfdc534b3c	169ea38c-16eb-11ea-8a37-b799503ae436	Cowbell	fd71cbf9-1677-49d6-b4d5-60ea65d78d09-instrument-35-audio.wav	0	0.34	120	268.902	0.6	2019-12-04 15:09:14.122873	2019-12-04 15:09:14.122873
16a659b0-16eb-11ea-8a37-5b1387f09634	169ea38c-16eb-11ea-8a37-b799503ae436	Conga High	fe30bbf3-a789-4c71-97b4-40f2746139be-instrument-35-audio.wav	0	0.179	120	397.297	0.6	2019-12-04 15:09:14.134678	2019-12-04 15:09:14.134678
16a7bd00-16eb-11ea-8a37-e3aa472ec8f4	169ea38c-16eb-11ea-8a37-b799503ae436	Clap 3	7ff0e518-ab41-469f-89d2-a28b8bdba0e9-instrument-35-audio.wav	0	0.734	120	980	0.6	2019-12-04 15:09:14.143772	2019-12-04 15:09:14.143772
16a92d7a-16eb-11ea-8a37-df595bc77f26	169ea38c-16eb-11ea-8a37-b799503ae436	Snare Rim	e149c7fb-76bc-4ef5-92eb-38498f87e768-instrument-35-audio.wav	0	0.014	120	445.445	0.6	2019-12-04 15:09:14.153113	2019-12-04 15:09:14.153113
16aacc02-16eb-11ea-8a37-4fa401877f76	169ea38c-16eb-11ea-8a37-b799503ae436	Claves	5f76cf95-4e48-47bb-b161-2fe38871c72e-instrument-35-audio.wav	0	0.03	120	2594	0.6	2019-12-04 15:09:14.163738	2019-12-04 15:09:14.163738
16acac8e-16eb-11ea-8a37-73e8fbd7d57d	169ea38c-16eb-11ea-8a37-b799503ae436	Kick 2	89f40f31-a538-4afa-871d-861f555f7dbe-instrument-35-audio.wav	0	0.34	120	69.122	0.6	2019-12-04 15:09:14.175971	2019-12-04 15:09:14.175971
16af3c38-16eb-11ea-8a37-238b17b5b05d	169ea38c-16eb-11ea-8a37-b799503ae436	Kick Long 2	a47b2510-6e4a-4933-a51a-8a14b2218c40-instrument-35-audio.wav	0	1.963	120	60.494	0.6	2019-12-04 15:09:14.192779	2019-12-04 15:09:14.192779
16b1a96e-16eb-11ea-8a37-a3a9ae29af1f	169ea38c-16eb-11ea-8a37-b799503ae436	Clap	094e7d52-866d-4514-8bb7-72c124c4c3ff-instrument-35-audio.wav	0	0.361	120	1102.5	0.6	2019-12-04 15:09:14.208689	2019-12-04 15:09:14.208689
16b3ee7c-16eb-11ea-8a37-1f13dbd92d5b	169ea38c-16eb-11ea-8a37-b799503ae436	Clap 2	281e202c-cb93-49ba-81cc-06c20e218f1e-instrument-35-audio.wav	0.002	0.356	120	1225	0.6	2019-12-04 15:09:14.223542	2019-12-04 15:09:14.223542
16b648e8-16eb-11ea-8a37-dbcd5d82aa39	169ea38c-16eb-11ea-8a37-b799503ae436	Tom 2	2b6e6271-6093-4942-b892-5a92fbe92fd8-instrument-35-audio.wav	0	0.488	120	149.492	0.6	2019-12-04 15:09:14.23893	2019-12-04 15:09:14.23893
16b835ae-16eb-11ea-8a37-afdfba72322e	169ea38c-16eb-11ea-8a37-b799503ae436	Kick Long	04cc3d33-9fe5-4664-a4c9-4a9e7b480bd2-instrument-35-audio.wav	0	0.865	120	57.05	0.6	2019-12-04 15:09:14.251563	2019-12-04 15:09:14.251563
16b9acae-16eb-11ea-8a37-df16f0f4a46e	169ea38c-16eb-11ea-8a37-b799503ae436	Tom High	cbff0b34-7248-4dd7-88d6-5b17eb8a15a2-instrument-35-audio.wav	0	0.2	120	190.909	0.6	2019-12-04 15:09:14.261311	2019-12-04 15:09:14.261311
16bae9ac-16eb-11ea-8a37-ab453bec7c1b	169ea38c-16eb-11ea-8a37-b799503ae436	Tom High 2	66b4998e-7ad9-45ff-abdc-c803267f36e6-instrument-35-audio.wav	0.002	0.411	120	201.37	0.6	2019-12-04 15:09:14.269441	2019-12-04 15:09:14.269441
16bc55da-16eb-11ea-8a37-e7fbb89ce282	169ea38c-16eb-11ea-8a37-b799503ae436	Kick	324b83d8-2993-4a49-83a1-78f3425c3ac4-instrument-35-audio.wav	0	0.702	120	57.495	0.6	2019-12-04 15:09:14.27876	2019-12-04 15:09:14.27876
16be534e-16eb-11ea-8a37-076627260c8f	169ea38c-16eb-11ea-8a37-b799503ae436	Hihat Closed	5a62482a-3d44-493e-95e5-e5b4e5747bd9-instrument-35-audio.wav	0	0.053	120	6300	0.6	2019-12-04 15:09:14.291851	2019-12-04 15:09:14.291851
16c04668-16eb-11ea-8a37-0f13f2262c74	169ea38c-16eb-11ea-8a37-b799503ae436	Cymbal Crash 2	d2ba2873-c970-45de-afc7-f2d405784376-instrument-35-audio.wav	0	2	120	816.667	0.6	2019-12-04 15:09:14.304622	2019-12-04 15:09:14.304622
16c2034a-16eb-11ea-8a37-abb7bbb054d5	169ea38c-16eb-11ea-8a37-b799503ae436	Maracas 2	71282f6f-efdb-4af2-a2f3-c0dc03115853-instrument-35-audio.wav	0.009	0.43	120	11025	0.6	2019-12-04 15:09:14.315998	2019-12-04 15:09:14.315998
16c3a092-16eb-11ea-8a37-138ccb32ff53	169ea38c-16eb-11ea-8a37-b799503ae436	Conga	5c180a6b-9586-4f1d-8df2-631cb63774a8-instrument-35-audio.wav	0	0.26	120	213	0.6	2019-12-04 15:09:14.326564	2019-12-04 15:09:14.326564
16c4d9da-16eb-11ea-8a37-97c8fbb7614b	169ea38c-16eb-11ea-8a37-b799503ae436	Maracas	411aff24-ac6b-4617-a483-303b050ff502-instrument-35-audio.wav	0	0.026	120	190.086	0.6	2019-12-04 15:09:14.334588	2019-12-04 15:09:14.334588
16c6103e-16eb-11ea-8a37-97f2821e4c94	169ea38c-16eb-11ea-8a37-b799503ae436	Snare	03d347ba-e65a-481d-954f-eb8f64460e41-instrument-35-audio.wav	0	0.093	120	177.823	0.6	2019-12-04 15:09:14.342547	2019-12-04 15:09:14.342547
16c74bd4-16eb-11ea-8a37-cb7a9fdec0a5	169ea38c-16eb-11ea-8a37-b799503ae436	Cymbal Crash	03111025-2607-45f6-b48c-a6abb249c4a9-instrument-35-audio.wav	0	2.229	120	109.701	0.6	2019-12-04 15:09:14.350608	2019-12-04 15:09:14.350608
16cc4b66-16eb-11ea-8a37-4b1697a28533	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 3	6c85494e-fc05-46b0-8e98-97c3d756ebc0-instrument-41-audio.wav	0	0.174	121	12000	0.6	2019-12-04 15:09:14.383232	2019-12-04 15:09:14.383232
16ce9c86-16eb-11ea-8a37-c35c78ce12f0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 22	90b1fd35-cb74-4897-811a-578b4f628c9c-instrument-41-audio.wav	0	0.227	121	6000	0.6	2019-12-04 15:09:14.398453	2019-12-04 15:09:14.398453
16d0dd8e-16eb-11ea-8a37-2315defb93c9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 25	06abcac4-6f12-4581-aa6e-d509354175ff-instrument-41-audio.wav	0.002	201	121	106.904	0.6	2019-12-04 15:09:14.413206	2019-12-04 15:09:14.413206
16d2b49c-16eb-11ea-8a37-5bd09f91e5c8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 15	4817ff3c-0bbc-472f-af44-6c91e139e426-instrument-41-audio.wav	0	0.192	121	155.844	0.6	2019-12-04 15:09:14.425264	2019-12-04 15:09:14.425264
16d45eb4-16eb-11ea-8a37-67c9ec216602	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 12	4e5d6a65-5597-457c-94d0-2a0de54d93ee-instrument-41-audio.wav	0	0.233	121	545.455	0.6	2019-12-04 15:09:14.436192	2019-12-04 15:09:14.436192
16d605a2-16eb-11ea-8a37-370a0dbfafb0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 5	22da4ceb-abd4-4d95-95b2-ea3d16c9d22a-instrument-41-audio.wav	0	0.218	121	124.031	0.6	2019-12-04 15:09:14.446994	2019-12-04 15:09:14.446994
16d7a1f0-16eb-11ea-8a37-173fc900381e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 23	1fb23135-597b-4d3f-a808-5bb64494602d-instrument-41-audio.wav	0	0.233	121	545.455	0.6	2019-12-04 15:09:14.457514	2019-12-04 15:09:14.457514
16d9f400-16eb-11ea-8a37-d7c717848a60	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 30	dc4b6e0e-fbd5-4d53-992c-f33598a6edf2-instrument-41-audio.wav	0	0.244	121	4000	0.6	2019-12-04 15:09:14.472771	2019-12-04 15:09:14.472771
16dc81f2-16eb-11ea-8a37-efc951bd428d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 2	dcab4861-71ea-4c8d-8e21-11191c258b9e-instrument-41-audio.wav	0	0.203	121	146.341	0.6	2019-12-04 15:09:14.489422	2019-12-04 15:09:14.489422
16ded5ec-16eb-11ea-8a37-937dc4935cda	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 22	1c671fcf-78e1-49e4-8835-f0b8c6f9d12b-instrument-41-audio.wav	0	0.208	121	6000	0.6	2019-12-04 15:09:14.50477	2019-12-04 15:09:14.50477
16e12126-16eb-11ea-8a37-7faf1faaf2ce	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 13	af2a3a16-0663-4284-a9d7-6394c85c9c7b-instrument-41-audio.wav	0	0.222	121	92.131	0.6	2019-12-04 15:09:14.519777	2019-12-04 15:09:14.519777
16e2ece0-16eb-11ea-8a37-3feaca6d437e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 24	7cabf0f1-21bb-4242-b3f7-9bc31f676f7a-instrument-41-audio.wav	0.003	0.251	121	259.459	0.6	2019-12-04 15:09:14.531568	2019-12-04 15:09:14.531568
16e49ed2-16eb-11ea-8a37-8b0aa900b1a8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Dun Dun Bell	81fda5b3-33e5-48ac-9304-ead26b731275-instrument-28-audio.wav	0.0005	0.25	121	3428.57	0.6	2019-12-04 15:09:14.542674	2019-12-04 15:09:14.542674
16e63d96-16eb-11ea-8a37-4fe6762a27aa	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 4	2966cd70-9351-4d10-95bd-ba0159e0487a-instrument-41-audio.wav	0	0.194	121	12000	0.6	2019-12-04 15:09:14.553301	2019-12-04 15:09:14.553301
16e7db88-16eb-11ea-8a37-8b904fa2944a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 26	7662ad41-fb48-4b6b-bbb9-fbd2c8d6cc53-instrument-41-audio.wav	0	0.197	121	12000	0.6	2019-12-04 15:09:14.563902	2019-12-04 15:09:14.563902
16ea35fe-16eb-11ea-8a37-8358b5abce41	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 6	ae26022f-aa30-4354-843f-d560e8791d65-instrument-41-audio.wav	0	0.253	121	3000	0.6	2019-12-04 15:09:14.579303	2019-12-04 15:09:14.579303
16ecbe64-16eb-11ea-8a37-131c3887a491	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 1	db4da6b4-c9bb-44cb-8337-a7de9889bdf4-instrument-41-audio.wav	0	0.16	121	4800	0.6	2019-12-04 15:09:14.595919	2019-12-04 15:09:14.595919
16ef154c-16eb-11ea-8a37-c7db8b252c64	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 16	48525cd6-778e-48e4-b7e3-a1d3878f0575-instrument-41-audio.wav	0	0.214	121	107.623	0.6	2019-12-04 15:09:14.611219	2019-12-04 15:09:14.611219
16f16a54-16eb-11ea-8a37-fba7a60f8fb4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 12	959c0f2e-513c-47ca-ae48-76b1bd9189a3-instrument-41-audio.wav	0	0.151	121	213.333	0.6	2019-12-04 15:09:14.626526	2019-12-04 15:09:14.626526
16f338c0-16eb-11ea-8a37-aba175a6cacb	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 17	61844405-ac3a-4880-ac15-25424af2a140-instrument-41-audio.wav	0.003	0.169	121	432.432	0.6	2019-12-04 15:09:14.638363	2019-12-04 15:09:14.638363
16f4d694-16eb-11ea-8a37-4f02cfada858	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Powering Down	1b6221ea-7f22-4845-b93f-50e901755c43-instrument-29-audio.wav	0	2	121	4000	0.6	2019-12-04 15:09:14.648943	2019-12-04 15:09:14.648943
16f673fa-16eb-11ea-8a37-5f8243fdcc72	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 26	7339c5c5-78e1-4bbe-b2bd-e0eb7a42d940-instrument-41-audio.wav	0	0.208	121	103.672	0.6	2019-12-04 15:09:14.659558	2019-12-04 15:09:14.659558
16f80706-16eb-11ea-8a37-d73b0b0b519c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 10	cae8c01c-4dca-481a-823b-af333275a9e5-instrument-41-audio.wav	0	0.218	121	115.942	0.6	2019-12-04 15:09:14.669866	2019-12-04 15:09:14.669866
16fa5434-16eb-11ea-8a37-b740160f0966	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 11	250326c0-3d9a-436a-9b35-48c6960e8e90-instrument-41-audio.wav	0	0.151	121	6857.14	0.6	2019-12-04 15:09:14.684937	2019-12-04 15:09:14.684937
16fceb54-16eb-11ea-8a37-37c32493847d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 16	0605618c-f610-4909-89cc-8f94a8ce49c3-instrument-41-audio.wav	0	0.241	121	6000	0.6	2019-12-04 15:09:14.701843	2019-12-04 15:09:14.701843
16ff7658-16eb-11ea-8a37-03fc81a76c8a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 9	9c716e11-5bc0-4862-8b4c-8e6a743de195-instrument-41-audio.wav	0.003	0.228	121	3692.31	0.6	2019-12-04 15:09:14.718562	2019-12-04 15:09:14.718562
17019df2-16eb-11ea-8a37-77f20be440d1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Moog Snare 1	be6cd4fc-9835-4ec3-9628-bbbae5655b69-instrument-29-audio.wav	0	0.5	121	125.326	0.6	2019-12-04 15:09:14.732781	2019-12-04 15:09:14.732781
1702e8ce-16eb-11ea-8a37-6791a4ebb2e1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 18	503d2db2-50c2-4334-9b39-d5eeaf948446-instrument-41-audio.wav	0	0.212	121	32.663	0.6	2019-12-04 15:09:14.741263	2019-12-04 15:09:14.741263
17042d10-16eb-11ea-8a37-c3871e94a9d1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 23	fac476ab-7f8b-41d1-a5c9-e3558db43705-instrument-41-audio.wav	0	0.205	121	119.701	0.6	2019-12-04 15:09:14.749556	2019-12-04 15:09:14.749556
1705573a-16eb-11ea-8a37-5bf2fa79ce0e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 28	c4e099a8-f4dc-4b4a-984b-9648e90802f1-instrument-41-audio.wav	0	0.207	121	92.486	0.6	2019-12-04 15:09:14.75723	2019-12-04 15:09:14.75723
17067750-16eb-11ea-8a37-43824be791f8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 19	1881e57a-3570-4ea9-aa2b-c9602cfba10c-instrument-41-audio.wav	0	0.233	121	181.132	0.6	2019-12-04 15:09:14.764609	2019-12-04 15:09:14.764609
1708688a-16eb-11ea-8a37-c3866755f1a9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 1	37e75a56-abe2-4c97-b4c5-451f57c0ef33-instrument-41-audio.wav	0	0.203	121	147.692	0.6	2019-12-04 15:09:14.777363	2019-12-04 15:09:14.777363
170a5c94-16eb-11ea-8a37-a362dcfd9611	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 17	1cba0fa2-8d99-4360-a060-1342e9168da8-instrument-41-audio.wav	0	0.211	121	9600	0.6	2019-12-04 15:09:14.790162	2019-12-04 15:09:14.790162
170c231c-16eb-11ea-8a37-6fbe620dfdc4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 8	aeb18499-e64e-4efe-bf40-05c60d3bdac0-instrument-41-audio.wav	0.002	0.157	121	6857.14	0.6	2019-12-04 15:09:14.801779	2019-12-04 15:09:14.801779
170e25a4-16eb-11ea-8a37-4be9704d11d1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 5	dbc6e5b0-08a3-4cea-a1ec-490fe88f2ef4-instrument-41-audio.wav	0.002	0.184	121	12000	0.6	2019-12-04 15:09:14.814826	2019-12-04 15:09:14.814826
170fca9e-16eb-11ea-8a37-9f63591bfc6a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 21	4402cd3f-23e5-4819-ac07-562eee6273a3-instrument-41-audio.wav	0	0.16	121	6857.14	0.6	2019-12-04 15:09:14.825523	2019-12-04 15:09:14.825523
171177cc-16eb-11ea-8a37-2bf9e883c3a7	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 29 	3fb128b8-6d86-4391-b11f-3bbf1db2571f-instrument-41-audio.wav	0	0.204	121	93.023	0.6	2019-12-04 15:09:14.836573	2019-12-04 15:09:14.836573
171322e8-16eb-11ea-8a37-7ba2a251c8f0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 6	77f06640-60be-4bf9-8594-e8290fe57887-instrument-41-audio.wav	0.002	0.16	121	4800	0.6	2019-12-04 15:09:14.847507	2019-12-04 15:09:14.847507
1714a35c-16eb-11ea-8a37-476febb2e1c1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 6	a4f218ef-54eb-4370-9cb2-e3532071548c-instrument-41-audio.wav	0	0.223	121	90.566	0.6	2019-12-04 15:09:14.857426	2019-12-04 15:09:14.857426
1716b610-16eb-11ea-8a37-0b6b573a0df9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 2	c56ba0e8-2bf8-4368-bb95-d130c884fb7e-instrument-41-audio.wav	0	0.199	121	6857.14	0.6	2019-12-04 15:09:14.871061	2019-12-04 15:09:14.871061
1718b8fc-16eb-11ea-8a37-c3b1b04e4750	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 2	eee26dc9-3be2-4136-bc2d-6c713d335b74-instrument-41-audio.wav	0	0.193	121	4800	0.6	2019-12-04 15:09:14.884258	2019-12-04 15:09:14.884258
171a707a-16eb-11ea-8a37-3b3b3adcbfb0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 14	8b534f40-794e-4683-a4ed-4eb4eb091516-instrument-41-audio.wav	0	0.181	121	979.592	0.6	2019-12-04 15:09:14.895517	2019-12-04 15:09:14.895517
171c492c-16eb-11ea-8a37-2f2df121741e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 18	631a315c-656c-45b5-90bc-f55022dd6e8e-instrument-41-audio.wav	0.003	0.166	121	12000	0.6	2019-12-04 15:09:14.907552	2019-12-04 15:09:14.907552
171df330-16eb-11ea-8a37-cfe7b347727b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 8	4582c30c-6572-4e69-812c-712ed06656c0-instrument-41-audio.wav	0	0.217	121	79.689	0.6	2019-12-04 15:09:14.918358	2019-12-04 15:09:14.918358
171f8fa6-16eb-11ea-8a37-6bf293c14f95	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 28	ea4ac717-55a9-4c15-b376-cc73bded01a9-instrument-41-audio.wav	0	0.185	121	12000	0.6	2019-12-04 15:09:14.92894	2019-12-04 15:09:14.92894
1721235c-16eb-11ea-8a37-ffee47a7a3b9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 19	00c84fb5-4097-4417-80e1-cf9b973961a8-instrument-41-audio.wav	0	0.165	121	6857.14	0.6	2019-12-04 15:09:14.939335	2019-12-04 15:09:14.939335
17226e88-16eb-11ea-8a37-9b5282c31ef9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 3	1046032b-22d5-4fc8-85b4-48fda751c395-instrument-41-audio.wav	0	0.304	121	623.377	0.6	2019-12-04 15:09:14.947839	2019-12-04 15:09:14.947839
17247804-16eb-11ea-8a37-ffb0c93eb243	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 7	0b5594dc-b9d8-4e1c-88b0-945640ba3086-instrument-41-audio.wav	0	0.193	121	2823.53	0.6	2019-12-04 15:09:14.961228	2019-12-04 15:09:14.961228
17266b64-16eb-11ea-8a37-dbcb074964e6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 11 	85dde3af-9c8d-443f-b70e-af5a8377a265-instrument-41-audio.wav	0	0.211	121	115.108	0.6	2019-12-04 15:09:14.974032	2019-12-04 15:09:14.974032
172830b6-16eb-11ea-8a37-03b48d251458	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 24	02e9ccc3-def9-4c25-8c2a-676862166b80-instrument-41-audio.wav	0.002	0.18	121	4800	0.6	2019-12-04 15:09:14.985575	2019-12-04 15:09:14.985575
1729fdce-16eb-11ea-8a37-9704f6d1b08d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 15	042c9206-1d80-489d-80d7-acb4952801c7-instrument-41-audio.wav	0	0.224	121	134.454	0.6	2019-12-04 15:09:14.99742	2019-12-04 15:09:14.99742
172b5318-16eb-11ea-8a37-97000d91b271	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 1	1b0d2ff8-1ba6-4302-bfd2-475f2792888f-instrument-41-audio.wav	0	0.261	121	3000	0.6	2019-12-04 15:09:15.006113	2019-12-04 15:09:15.006113
172cd300-16eb-11ea-8a37-176d480b9773	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 12	140411f4-21ed-4114-b9d3-b83ba4cd605d-instrument-41-audio.wav	0	0.216	121	101.911	0.6	2019-12-04 15:09:15.015865	2019-12-04 15:09:15.015865
172e51bc-16eb-11ea-8a37-b33b08aab0ce	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 9	a4bb0dc5-3ee8-473b-a91b-8be7ef0f2a06-instrument-41-audio.wav	0	0.16	121	6000	0.6	2019-12-04 15:09:15.025683	2019-12-04 15:09:15.025683
172fb76e-16eb-11ea-8a37-bbd10e0c7ef3	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Dun Dun Da Bell	fad125f5-b8a1-449d-acad-24ac69d74043-instrument-28-audio.wav	0	0.25	121	1600	0.6	2019-12-04 15:09:15.034898	2019-12-04 15:09:15.034898
1731c9b4-16eb-11ea-8a37-d712f55d8acd	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 29	f3d00a5d-132a-45c7-ad14-d3a5d7714754-instrument-41-audio.wav	0	0.244	121	3200	0.6	2019-12-04 15:09:15.048494	2019-12-04 15:09:15.048494
1733c728-16eb-11ea-8a37-d38eb7ce7d14	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 27	9e1e3aae-40ff-44cb-a94e-66ce9c7c436b-instrument-41-audio.wav	0	0.211	121	106.904	0.6	2019-12-04 15:09:15.061544	2019-12-04 15:09:15.061544
17357c44-16eb-11ea-8a37-8f4ee33a5252	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 27	c7fbafd1-2aa3-480e-b0e3-b16189e90e11-instrument-41-audio.wav	0	0.235	121	4000	0.6	2019-12-04 15:09:15.072762	2019-12-04 15:09:15.072762
17373700-16eb-11ea-8a37-0ff869bedf70	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 21	08068837-646b-4b2a-a3ee-f091ed9c5ae7-instrument-41-audio.wav	0	0.217	121	539.326	0.6	2019-12-04 15:09:15.084089	2019-12-04 15:09:15.084089
173850ae-16eb-11ea-8a37-5f4b0cb4a2c6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 20	b6fbe757-5f87-4120-b980-04ff29e21874-instrument-41-audio.wav	0	0.208	121	107.143	0.6	2019-12-04 15:09:15.091302	2019-12-04 15:09:15.091302
1739666a-16eb-11ea-8a37-db6a04e6eb49	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 4	7528ee6d-ec2a-42e4-9098-6ead2e829836-instrument-41-audio.wav	0	0.312	121	489.796	0.6	2019-12-04 15:09:15.098403	2019-12-04 15:09:15.098403
173a7212-16eb-11ea-8a37-0fe3977ac034	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-hat 29	250c412f-8166-4162-b735-5cdac72a6ffb-instrument-41-audio.wav	0	0.173	121	12000	0.6	2019-12-04 15:09:15.105283	2019-12-04 15:09:15.105283
173b8292-16eb-11ea-8a37-a3b2e5056d72	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 10	bfddbe02-57c7-4a2f-a82d-57a26c5e0324-instrument-41-audio.wav	0.002	0.313	121	4000	0.6	2019-12-04 15:09:15.112238	2019-12-04 15:09:15.112238
173d7804-16eb-11ea-8a37-53fbc8de019f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 2	99862afa-7e85-4513-a54f-87daa94bdb4f-instrument-41-audio.wav	0	0.291	121	615.385	0.6	2019-12-04 15:09:15.125079	2019-12-04 15:09:15.125079
173f72bc-16eb-11ea-8a37-778a9a39437f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Rough and Sandy Crash	6f440597-40e8-4d9d-8855-6d889c827df6-instrument-29-audio.wav	0.0002	2	121	1230.77	0.6	2019-12-04 15:09:15.138043	2019-12-04 15:09:15.138043
17412c38-16eb-11ea-8a37-77fa053e75bf	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 22	aec26741-82e2-4e42-a165-ae7156bde742-instrument-41-audio.wav	0.002	0.174	121	6857.14	0.6	2019-12-04 15:09:15.14935	2019-12-04 15:09:15.14935
1742e636-16eb-11ea-8a37-a3cfb96a0dd4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 3	7d2cc6d0-9bd9-48e7-9282-5ea0c29bb427-instrument-41-audio.wav	0.002	0.241	121	4800	0.6	2019-12-04 15:09:15.160671	2019-12-04 15:09:15.160671
17440336-16eb-11ea-8a37-d3f1544ce517	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 30	8699e3b8-0a91-42d7-bac3-ff4a187c2845-instrument-41-audio.wav	0.003	0.178	121	551.724	0.6	2019-12-04 15:09:15.16798	2019-12-04 15:09:15.16798
1745261c-16eb-11ea-8a37-bf91b2cfefe0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 13	3fb72846-001a-424f-8d9f-ff26cc119561-instrument-41-audio.wav	0	0.167	121	6857.14	0.6	2019-12-04 15:09:15.175398	2019-12-04 15:09:15.175398
17464402-16eb-11ea-8a37-2b092870d0e1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 25	c04f53dd-05f2-448a-b52c-fafac8e16821-instrument-41-audio.wav	0	0.177	121	6000	0.6	2019-12-04 15:09:15.182741	2019-12-04 15:09:15.182741
1747593c-16eb-11ea-8a37-cfccd47ce162	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 5	681699f9-a91c-4222-93bd-f6ee5da4adf4-instrument-41-audio.wav	0	0.267	121	91.603	0.6	2019-12-04 15:09:15.189834	2019-12-04 15:09:15.189834
174955e8-16eb-11ea-8a37-3f913847de79	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Sangpan Bell	bac419d8-2391-4b62-b45c-71122f8c2df6-instrument-28-audio.wav	0.0001	0.25	121	615.385	0.6	2019-12-04 15:09:15.202847	2019-12-04 15:09:15.202847
174b66c6-16eb-11ea-8a37-a385e4477c0f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 7	e5c563cd-26da-4513-8f8f-0c980d26baba-instrument-41-audio.wav	0	0.253	121	352.941	0.6	2019-12-04 15:09:15.216377	2019-12-04 15:09:15.216377
174d2344-16eb-11ea-8a37-0b5d87ff7d30	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 14	0b0ffd9d-cfce-4dde-a86c-9d66a79b0713-instrument-41-audio.wav	0	0.271	121	4363.64	0.6	2019-12-04 15:09:15.227791	2019-12-04 15:09:15.227791
174f223e-16eb-11ea-8a37-c37d6dfeff88	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 24	ac9d8ca6-5c82-4956-9886-09915d0ac033-instrument-41-audio.wav	0	0.208	121	105.96	0.6	2019-12-04 15:09:15.240789	2019-12-04 15:09:15.240789
175090c4-16eb-11ea-8a37-eb6d5dd7d84c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 12	786f2937-9963-43d7-83f7-6b5f10fb5e06-instrument-41-audio.wav	0	0.294	121	8000	0.6	2019-12-04 15:09:15.250161	2019-12-04 15:09:15.250161
175212e6-16eb-11ea-8a37-83a6dfcff358	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 9	d84cf238-eb4e-4c96-8b75-958bddf182cf-instrument-41-audio.wav	0	0.218	121	67.989	0.6	2019-12-04 15:09:15.259998	2019-12-04 15:09:15.259998
1753a96c-16eb-11ea-8a37-6b98160e243f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 4	dcf54dc4-8b1f-44d8-bdcb-88f61d2c7bc8-instrument-41-audio.wav	0.002	0.236	121	2823.53	0.6	2019-12-04 15:09:15.270385	2019-12-04 15:09:15.270385
17553d22-16eb-11ea-8a37-9bed9a964f75	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Moog Snare 3	a997bca3-4830-407a-b787-e2a569304a88-instrument-29-audio.wav	0	0.5	121	307.692	0.6	2019-12-04 15:09:15.280738	2019-12-04 15:09:15.280738
1757b2dc-16eb-11ea-8a37-a7a501e0201d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Moog Snare 2	dda386d5-d093-428a-a39c-78496d2d7ff3-instrument-29-audio.wav	0	0.375	121	139.535	0.6	2019-12-04 15:09:15.296867	2019-12-04 15:09:15.296867
175a2b8e-16eb-11ea-8a37-e33ca0f53036	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 20	7e79d46d-c7f3-4dff-a704-55052a9384ff-instrument-41-audio.wav	0	0.18	121	12000	0.6	2019-12-04 15:09:15.313038	2019-12-04 15:09:15.313038
175c5e04-16eb-11ea-8a37-cf9fae79204f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 4	76c48f70-1b35-4f9c-99b8-c795eeb00488-instrument-41-audio.wav	0	0.226	121	79.867	0.6	2019-12-04 15:09:15.327453	2019-12-04 15:09:15.327453
175e99bc-16eb-11ea-8a37-ff9920827e69	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 28	10d47dd8-8832-4dcf-b1f9-312b9af1e03c-instrument-41-audio.wav	0.002	0.215	121	234.146	0.6	2019-12-04 15:09:15.342082	2019-12-04 15:09:15.342082
176032e0-16eb-11ea-8a37-f70c8a3229f7	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 14	7a5312d6-844d-4d9b-97bb-40c15e7294ec-instrument-41-audio.wav	0	0.212	121	108.597	0.6	2019-12-04 15:09:15.352556	2019-12-04 15:09:15.352556
1761c9ca-16eb-11ea-8a37-bbc51a0fda8b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 8	f1ae646f-a217-4475-860c-81f5349b6fd8-instrument-41-audio.wav	0	0.203	121	6000	0.6	2019-12-04 15:09:15.362982	2019-12-04 15:09:15.362982
176355e2-16eb-11ea-8a37-d7e2046f8df5	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 1 	0ca7c617-152f-4a76-83fd-fbfca83d239f-instrument-41-audio.wav	0	0.204	121	92.644	0.6	2019-12-04 15:09:15.373118	2019-12-04 15:09:15.373118
1764f65e-16eb-11ea-8a37-cfd11203ec96	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 25	aada609c-cd8c-4509-aa4f-8482accc280d-instrument-41-audio.wav	0	0.23	121	173.285	0.6	2019-12-04 15:09:15.383766	2019-12-04 15:09:15.383766
176767ea-16eb-11ea-8a37-777a18c3566d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 5	dab989e1-3afc-4a77-8e6d-e2ca8599882e-instrument-41-audio.wav	0.002	0.276	121	117.073	0.6	2019-12-04 15:09:15.39978	2019-12-04 15:09:15.39978
1769bc2a-16eb-11ea-8a37-c3d93eddb619	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 3	73335892-500e-42e2-ad00-6261c80ab41a-instrument-41-audio.wav	0	0.2	121	106.904	0.6	2019-12-04 15:09:15.415118	2019-12-04 15:09:15.415118
176b82ee-16eb-11ea-8a37-f3c94d4ce59d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 13	9ea773e2-450e-464a-a204-e83c80df43ee-instrument-41-audio.wav	0.002	0.304	121	6857.14	0.6	2019-12-04 15:09:15.426814	2019-12-04 15:09:15.426814
176d4066-16eb-11ea-8a37-f333086386f9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 26	3ffdc7b4-5b5e-445a-ab99-bb57aa34071a-instrument-41-audio.wav	0	0.228	121	220.183	0.6	2019-12-04 15:09:15.438218	2019-12-04 15:09:15.438218
176e54ba-16eb-11ea-8a37-27c97cb4f5f1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Clap 6	eaed6811-bd77-4d1f-8da6-cf4f7a44dd65-instrument-41-audio.wav	0	0.295	121	298.137	0.6	2019-12-04 15:09:15.445305	2019-12-04 15:09:15.445305
176f6846-16eb-11ea-8a37-87441a2951b3	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 10	3e71c193-a0e4-42f5-90d0-0218454080ac-instrument-41-audio.wav	0	0.174	121	12000	0.6	2019-12-04 15:09:15.452361	2019-12-04 15:09:15.452361
177077a4-16eb-11ea-8a37-8bbf91abedeb	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Crash 7	6ff38a9c-5bc5-43be-ae83-5e2ceb42abf2-instrument-41-audio.wav	0.091	0.98	121	6300	0.6	2019-12-04 15:09:15.459294	2019-12-04 15:09:15.459294
17719576-16eb-11ea-8a37-bb3ce8aa938f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 7 	4edb7554-3e22-414c-84b5-6192e87269e0-instrument-41-audio.wav	0	0.222	121	80	0.6	2019-12-04 15:09:15.466621	2019-12-04 15:09:15.466621
177390b0-16eb-11ea-8a37-5720dd162498	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 11 	08e1ae69-84c5-4b12-ac6e-9e71ead2ac2d-instrument-41-audio.wav	0.001	0.287	121	224.299	0.6	2019-12-04 15:09:15.479597	2019-12-04 15:09:15.479597
17758d02-16eb-11ea-8a37-3f0478fa5f81	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 21	8de3182d-786f-45e2-bf89-266808fbe246-instrument-41-audio.wav	0	0.202	121	116.223	0.6	2019-12-04 15:09:15.492613	2019-12-04 15:09:15.492613
177746e2-16eb-11ea-8a37-0ba459658a94	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 2	b5e88de7-dbed-4d4c-bb95-9cd932eb4024-instrument-41-audio.wav	0	0.203	121	146.341	0.6	2019-12-04 15:09:15.503908	2019-12-04 15:09:15.503908
17791e0e-16eb-11ea-8a37-8f4c512f8e5c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 23	9406016b-0a60-4377-8fd9-50f33a698c6b-instrument-41-audio.wav	0.002	0.21	121	521.739	0.6	2019-12-04 15:09:15.515975	2019-12-04 15:09:15.515975
177a31c2-16eb-11ea-8a37-f31aca6e9028	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 20	197bcc44-a886-4c42-b1f1-ed606eb9e98f-instrument-41-audio.wav	0	0.204	121	1230.77	0.6	2019-12-04 15:09:15.523062	2019-12-04 15:09:15.523062
177b4bb6-16eb-11ea-8a37-83c1262c1e64	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 18	ff903ce7-36d7-4811-a9f9-22c754b7fa45-instrument-41-audio.wav	0	0.234	121	4000	0.6	2019-12-04 15:09:15.530282	2019-12-04 15:09:15.530282
177c6744-16eb-11ea-8a37-9fd12e16c690	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Tight Acoustic Snare	e1f9f407-41a9-4f71-b175-8ef43d38cbe9-instrument-29-audio.wav	0	0.375	121	3692.31	0.6	2019-12-04 15:09:15.537555	2019-12-04 15:09:15.537555
177d8390-16eb-11ea-8a37-7707411632a7	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 27	72b37477-b0dc-4ccf-8efc-1d569ef58692-instrument-41-audio.wav	0	0.173	121	8000	0.6	2019-12-04 15:09:15.544833	2019-12-04 15:09:15.544833
177f7272-16eb-11ea-8a37-6b041ebbc0e1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Snare 17	006a2eea-9f8d-4f7a-9594-bee83e5fbd4b-instrument-41-audio.wav	0	0.241	121	6857.14	0.6	2019-12-04 15:09:15.557479	2019-12-04 15:09:15.557479
17816bc2-16eb-11ea-8a37-f74d2b35444d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 7	dea07cbc-c686-4030-b791-cb2f6957082e-instrument-41-audio.wav	0	0.171	121	4000	0.6	2019-12-04 15:09:15.570427	2019-12-04 15:09:15.570427
17832fe8-16eb-11ea-8a37-afcab36d93a3	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 15	7b8a6720-3b52-4ccd-a7ff-b4bb2aa241d4-instrument-41-audio.wav	0	0.148	121	480	0.6	2019-12-04 15:09:15.581975	2019-12-04 15:09:15.581975
1784ef22-16eb-11ea-8a37-93ef1140774b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Kick 19	a4a389c5-9645-48df-a054-7d04d59b45a8-instrument-41-audio.wav	0	0.206	121	94.118	0.6	2019-12-04 15:09:15.593456	2019-12-04 15:09:15.593456
17860b6e-16eb-11ea-8a37-1badfc0b9704	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Hi-Hat 16	c8236068-8da4-45d8-9dea-55085a9553fd-instrument-41-audio.wav	0	0.166	121	6857.14	0.6	2019-12-04 15:09:15.600707	2019-12-04 15:09:15.600707
1788cb7e-16eb-11ea-8a37-93b8ed705699	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Open To Closed Hat	979f0b39-c642-4f2d-b31b-f9dd327f6f94-instrument-29-audio.wav	0.0015	0.328	121	4800	0.6	2019-12-04 15:09:15.618728	2019-12-04 15:09:15.618728
178a5cb4-16eb-11ea-8a37-978e20eaa0aa	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Crunchy Snare	c5d6a0cb-e103-417b-b450-77eb355099a3-instrument-29-audio.wav	0.0002	0.375	121	3200	0.6	2019-12-04 15:09:15.629001	2019-12-04 15:09:15.629001
178c5bb8-16eb-11ea-8a37-479a03f5dc0c	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Small Snare	9bf9e365-c11a-4dd6-80a0-b2c2b4fa5d28-instrument-29-audio.wav	0	0.25	121	282.353	0.6	2019-12-04 15:09:15.642064	2019-12-04 15:09:15.642064
178e3834-16eb-11ea-8a37-23531a78fcfc	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Closed Hat 2	effafa95-9756-4119-84b8-4452fb00b160-instrument-29-audio.wav	0.0002	0.188	121	666.667	0.6	2019-12-04 15:09:15.654277	2019-12-04 15:09:15.654277
178ff110-16eb-11ea-8a37-db2e215b492f	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Moog Snare 4	91944422-ddab-48e6-b152-627afa877399-instrument-29-audio.wav	0	0.25	121	137.931	0.6	2019-12-04 15:09:15.665508	2019-12-04 15:09:15.665508
179162ac-16eb-11ea-8a37-eb0a6605bea3	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Industrial Undulating Percussion	a3c983f4-b471-4603-8a94-25207a783056-instrument-29-audio.wav	0	0.625	121	126.649	0.6	2019-12-04 15:09:15.675014	2019-12-04 15:09:15.675014
17927c00-16eb-11ea-8a37-5f081eed7504	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Crash 16	a3706dbd-4518-4a8e-a354-32e12f44bf78-instrument-29-audio.wav	0.012	1.926	121	1225	0.6	2019-12-04 15:09:15.682247	2019-12-04 15:09:15.682247
179395fe-16eb-11ea-8a37-8f3d1b1a4dc9	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Muted Explosive Kick	48a784a4-a36a-41ab-ac21-e8738e6a2c54-instrument-29-audio.wav	0.003	0.375	121	86.799	0.6	2019-12-04 15:09:15.689442	2019-12-04 15:09:15.689442
1794adb8-16eb-11ea-8a37-7f60bd989e82	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Snappy Snare	c9384a2c-a4fc-4b2f-8ea5-50069b4c3988-instrument-29-audio.wav	0.0001	0.375	121	1714.29	0.6	2019-12-04 15:09:15.696617	2019-12-04 15:09:15.696617
179633cc-16eb-11ea-8a37-2f8500efa788	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Snappy Snare 3	7f17ecca-4e1e-4177-bed5-3f5bcf273d65-instrument-29-audio.wav	0.0144	0.375	121	9600	0.6	2019-12-04 15:09:15.706584	2019-12-04 15:09:15.706584
17982d26-16eb-11ea-8a37-6376be08caa7	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Open Industrial Kick	8d42e8e8-1286-4e71-b537-ceea1d925934-instrument-29-audio.wav	0.0035	0.594	121	80.402	0.6	2019-12-04 15:09:15.719527	2019-12-04 15:09:15.719527
179a0290-16eb-11ea-8a37-0bc647ec3e48	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Crash 5	12aef4fb-9f24-4f60-b39c-0388cdcdf1da-instrument-29-audio.wav	0.022	4.157	121	4900	0.6	2019-12-04 15:09:15.731569	2019-12-04 15:09:15.731569
179bbd56-16eb-11ea-8a37-5bd4b4150270	1787297c-16eb-11ea-8a37-6f3014c0a6fc	CLOSED HAT 5	5c32dc94-496d-412d-b4db-4839d905b074-instrument-29-audio.wav	0.0001	0.375	121	5333.33	0.6	2019-12-04 15:09:15.742874	2019-12-04 15:09:15.742874
179d2dc6-16eb-11ea-8a37-935ec99fc3a1	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Closed Hat 3	8722e12a-c1bb-405f-b9da-c90f1c10fed0-instrument-29-audio.wav	0	0.188	121	393.443	0.6	2019-12-04 15:09:15.752296	2019-12-04 15:09:15.752296
179e4300-16eb-11ea-8a37-e357f52e9fd4	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Tom 2	38adc853-2272-496f-b129-5805b9226a21-instrument-29-audio.wav	0	0.375	121	134.078	0.6	2019-12-04 15:09:15.759442	2019-12-04 15:09:15.759442
179f597a-16eb-11ea-8a37-87431d9d615f	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Open Hat 1	886c3d7c-7ad3-4c7d-a694-7e3e76671538-instrument-29-audio.wav	0.0002	0.328	121	4800	0.6	2019-12-04 15:09:15.766519	2019-12-04 15:09:15.766519
17a10428-16eb-11ea-8a37-ebb88f127b99	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Tom 1	203c9a5f-6d89-4072-b1d6-77c36bfe151d-instrument-29-audio.wav	0	0.25	121	167.832	0.6	2019-12-04 15:09:15.777298	2019-12-04 15:09:15.777298
17a33ed2-16eb-11ea-8a37-57e50ce01f0c	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Flare Up Snare	5575ef02-03a6-458c-b0bb-a5c975819b7a-instrument-29-audio.wav	0.0048	0.375	121	8000	0.6	2019-12-04 15:09:15.791919	2019-12-04 15:09:15.791919
17a572ba-16eb-11ea-8a37-dff759f23531	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Closed Hat 4	e84f17a2-34e3-49ee-9c0a-aa71ecef0880-instrument-29-audio.wav	0.0001	0.25	121	5333.33	0.6	2019-12-04 15:09:15.806475	2019-12-04 15:09:15.806475
17a75c38-16eb-11ea-8a37-bb9dc349d98a	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Gated Industrial Kick	ef7b2620-beaa-44b3-a07e-ac0498ab7831-instrument-29-audio.wav	0.0003	0.594	121	86.331	0.6	2019-12-04 15:09:15.819014	2019-12-04 15:09:15.819014
17a91262-16eb-11ea-8a37-ef3527050bff	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Tom 3	f557e49a-abb3-4ccc-87e2-1595924237fa-instrument-29-audio.wav	0	0.375	121	107.383	0.6	2019-12-04 15:09:15.830261	2019-12-04 15:09:15.830261
17aa78b4-16eb-11ea-8a37-9bce805b1155	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Clicky Industrial Kick	2e89ef50-4ded-49b5-9c2c-8c826eb0e49d-instrument-29-audio.wav	0	0.391	121	1920	0.6	2019-12-04 15:09:15.839441	2019-12-04 15:09:15.839441
17ab9636-16eb-11ea-8a37-0f592a76d9a3	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Popcorn Snare	c70e0246-bba7-448c-a45a-3876d9105f8a-instrument-29-audio.wav	0.0002	0.375	121	375	0.6	2019-12-04 15:09:15.84672	2019-12-04 15:09:15.84672
17acb2fa-16eb-11ea-8a37-43a34265fcf8	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Snappy Snare 2	086e9930-f691-45d8-a254-aaf3660f4e4a-instrument-29-audio.wav	0	0.375	121	214.286	0.6	2019-12-04 15:09:15.854015	2019-12-04 15:09:15.854015
17adcc94-16eb-11ea-8a37-c7a2aa079cd2	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Punchy Kick	c9edfab8-eab3-41a3-b58e-eb5d514fb134-instrument-29-audio.wav	0.0001	0.156	121	91.429	0.6	2019-12-04 15:09:15.861225	2019-12-04 15:09:15.861225
17b03f9c-16eb-11ea-8a37-2f6402fb8909	17af4286-16eb-11ea-8a37-7f9963e0dfa2	Clap	d38499b7-cd9c-40b5-b858-69c6b867d614-instrument-25-audio.wav	0.002	0.159	121	595.946	0.6	2019-12-04 15:09:15.877285	2019-12-04 15:09:15.877285
17b4323c-16eb-11ea-8a37-03d379e3e10b	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Kick.Short	00610417-608b-4105-8528-583ed910a0c2-instrument-42-audio.wav	0	0.193	121	10666.7	0.6	2019-12-04 15:09:15.903164	2019-12-04 15:09:15.903164
17b5f040-16eb-11ea-8a37-87b7743c2341	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Kick.Hype.Short	9526f54e-54b9-4590-a5d2-60c897d2dd1c-instrument-42-audio.wav	0.004	0.31	121	10666.7	0.6	2019-12-04 15:09:15.914581	2019-12-04 15:09:15.914581
17b75c64-16eb-11ea-8a37-87dee6c24b2c	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.4	d157a565-4237-4b5e-b54d-0827ea9fa236-instrument-42-audio.wav	0	0.067	121	581.818	0.6	2019-12-04 15:09:15.92391	2019-12-04 15:09:15.92391
17b892c8-16eb-11ea-8a37-ef89e7400133	17b34ca0-16eb-11ea-8a37-6b86e3816409	Shekere.Riser	87c74cb2-ca46-43be-b890-9b1a7a4cc607-instrument-42-audio.wav	0	1.996	121	1116.28	0.6	2019-12-04 15:09:15.931787	2019-12-04 15:09:15.931787
17b9dd0e-16eb-11ea-8a37-1fea83405dd4	17b34ca0-16eb-11ea-8a37-6b86e3816409	Brushy.Snare.Short	6576f0c7-83e0-42ce-97bf-01f5d5194339-instrument-42-audio.wav	0	0.152	121	251.309	0.6	2019-12-04 15:09:15.940258	2019-12-04 15:09:15.940258
17bb1872-16eb-11ea-8a37-6b94466ed28a	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.2	9967e4f9-6690-41da-9cff-589f984be34d-instrument-42-audio.wav	0	0.083	121	627.451	0.6	2019-12-04 15:09:15.948329	2019-12-04 15:09:15.948329
17bcbc0e-16eb-11ea-8a37-ab01e41a42fc	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Tom	561a97ee-cde4-482e-9c1e-589e09ababb9-instrument-42-audio.wav	0	0.174	121	124.352	0.6	2019-12-04 15:09:15.959063	2019-12-04 15:09:15.959063
17bed494-16eb-11ea-8a37-f3ceeb7a542d	17b34ca0-16eb-11ea-8a37-6b86e3816409	Flam.Clap.3	3acc0db1-f258-4698-99cb-ece7851231c9-instrument-42-audio.wav	0	0.238	121	101.48	0.6	2019-12-04 15:09:15.972818	2019-12-04 15:09:15.972818
17c10566-16eb-11ea-8a37-c35d1325da8b	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Tom.2	45909cf6-829d-4860-9299-f5194eaeebf5-instrument-42-audio.wav	0	0.754	121	183.908	0.6	2019-12-04 15:09:15.987087	2019-12-04 15:09:15.987087
17c35168-16eb-11ea-8a37-030c81dc176e	17b34ca0-16eb-11ea-8a37-6b86e3816409	Snare.w/Tambo.Tail	8c643b60-a107-4b88-9fac-554105112236-instrument-42-audio.wav	0	0.325	121	5647.06	0.6	2019-12-04 15:09:16.002116	2019-12-04 15:09:16.002116
17c63cde-16eb-11ea-8a37-cf1da03474aa	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Kick.Hype	5b75b290-4eb2-4fc9-8e8b-fbf618aec882-instrument-42-audio.wav	0	0.31	121	10666.7	0.6	2019-12-04 15:09:16.02123	2019-12-04 15:09:16.02123
17c7dc24-16eb-11ea-8a37-d772101739bb	17b34ca0-16eb-11ea-8a37-6b86e3816409	Shekere.1	8fdee415-877a-4920-94e9-49cf501ceaae-instrument-42-audio.wav	0	0.576	121	2742.86	0.6	2019-12-04 15:09:16.031906	2019-12-04 15:09:16.031906
17c92f84-16eb-11ea-8a37-7fb3480e9790	17b34ca0-16eb-11ea-8a37-6b86e3816409	Brushy.Closed.Hat	548f6c29-b96f-41cb-93be-512ede500ac8-instrument-42-audio.wav	0	0.286	121	8000	0.6	2019-12-04 15:09:16.040691	2019-12-04 15:09:16.040691
17ca6aca-16eb-11ea-8a37-538f4de9cd61	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.1	60585413-bdea-4303-90c0-479ae7ad2eaa-instrument-42-audio.wav	0	0.089	121	780.488	0.6	2019-12-04 15:09:16.048759	2019-12-04 15:09:16.048759
17cc73a6-16eb-11ea-8a37-57ecfc36022c	17b34ca0-16eb-11ea-8a37-6b86e3816409	Flam.Clap.1	5cfa8003-1ee8-4d4f-81e1-5c51f5cbda65-instrument-42-audio.wav	0	0.101	121	979.592	0.6	2019-12-04 15:09:16.062129	2019-12-04 15:09:16.062129
17ce5db0-16eb-11ea-8a37-dbe5fda57766	17b34ca0-16eb-11ea-8a37-6b86e3816409	Brushy.Snare	f50a9ce5-ab94-421e-823e-c4e6b911dd74-instrument-42-audio.wav	0	0.501	121	251.309	0.6	2019-12-04 15:09:16.074679	2019-12-04 15:09:16.074679
17d064b6-16eb-11ea-8a37-9f09e0179b6f	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Kick	6d86fdf8-1c65-41a7-b3fa-571bf05451e3-instrument-42-audio.wav	0.011	0.496	121	10666.7	0.6	2019-12-04 15:09:16.087903	2019-12-04 15:09:16.087903
187fe6ca-16eb-11ea-8a37-7f94c6d498c4	1860788a-16eb-11ea-8a37-87eb83753fe4	Tom B1	ab2e3e91-cf16-4737-923d-77889852ea54-instrument-36-audio.wav	0	1.158	121	148.986	0.6	2019-12-04 15:09:17.238062	2019-12-04 15:09:17.238062
17d29a24-16eb-11ea-8a37-130bfa446871	17b34ca0-16eb-11ea-8a37-6b86e3816409	Shekere.4	ca7878ac-d25b-480f-9abc-286f5eafa867-instrument-42-audio.wav	0	0.271	121	2400	0.6	2019-12-04 15:09:16.102314	2019-12-04 15:09:16.102314
17d44f04-16eb-11ea-8a37-bb03de076008	17b34ca0-16eb-11ea-8a37-6b86e3816409	Snare.w/Tambo.Tail.Short	db928de2-0d88-4bc6-89cf-91e72366d59f-instrument-42-audio.wav	0	0.155	121	6000	0.6	2019-12-04 15:09:16.113414	2019-12-04 15:09:16.113414
17d602fe-16eb-11ea-8a37-a3d42762c3f9	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.6	38910daa-0fa4-4c10-a49d-53560df19b76-instrument-42-audio.wav	0	0.112	121	304.762	0.6	2019-12-04 15:09:16.124655	2019-12-04 15:09:16.124655
17d79470-16eb-11ea-8a37-87bde0ef00a2	17b34ca0-16eb-11ea-8a37-6b86e3816409	Shekere.2	cd1b24a3-2261-4964-b7c4-93ebc7930127-instrument-42-audio.wav	0	0.327	121	2461.54	0.6	2019-12-04 15:09:16.134925	2019-12-04 15:09:16.134925
17d93e9c-16eb-11ea-8a37-8b0783be039e	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.3	63eabc53-9273-468e-8f9a-8396ef172767-instrument-42-audio.wav	0	0.083	121	627.451	0.6	2019-12-04 15:09:16.14583	2019-12-04 15:09:16.14583
17dbc860-16eb-11ea-8a37-5f5cb584fc6c	17b34ca0-16eb-11ea-8a37-6b86e3816409	Flam.Clap.2	67d001b9-7279-4dc0-9800-26b1e086c16a-instrument-42-audio.wav	0	0.088	121	1333.33	0.6	2019-12-04 15:09:16.162453	2019-12-04 15:09:16.162453
17de4306-16eb-11ea-8a37-f33d41d55478	17b34ca0-16eb-11ea-8a37-6b86e3816409	Dun.Dun.Kick.Sub	592b444b-0137-45ed-bf92-c9269f16aad9-instrument-42-audio.wav	0	0.699	121	71.588	0.6	2019-12-04 15:09:16.178675	2019-12-04 15:09:16.178675
17e03d3c-16eb-11ea-8a37-c3394c3f5fa5	17b34ca0-16eb-11ea-8a37-6b86e3816409	Brushy.Open.Hat	5ff42f3d-24cf-405c-9fa8-023198ecab2b-instrument-42-audio.wav	0	0.295	121	4800	0.6	2019-12-04 15:09:16.191774	2019-12-04 15:09:16.191774
17e21e4a-16eb-11ea-8a37-efc901c1178c	17b34ca0-16eb-11ea-8a37-6b86e3816409	Shekere.3	d400fe01-c7ce-4bf2-83f6-70034e77fa83-instrument-42-audio.wav	0	0.238	121	2461.54	0.6	2019-12-04 15:09:16.204079	2019-12-04 15:09:16.204079
17e37952-16eb-11ea-8a37-d39722108c1a	17b34ca0-16eb-11ea-8a37-6b86e3816409	Xylo.Tom.5	a91858d9-8306-4bb9-9285-3c53828738ff-instrument-42-audio.wav	0	0.101	121	415.584	0.6	2019-12-04 15:09:16.212857	2019-12-04 15:09:16.212857
17ea4fc0-16eb-11ea-8a37-3f1406b853f5	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_1	983fc7a1-a1ef-466f-be44-cc1e227ae449-instrument-5-audio.wav	0	0.318	120	565.385	0.6	2019-12-04 15:09:16.257595	2019-12-04 15:09:16.257595
17ed0d8c-16eb-11ea-8a37-af44db6912b1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_7	b51678cb-50a0-4994-980a-62bf126ca445-instrument-5-audio.wav	0.001	0.674	120	531.325	0.6	2019-12-04 15:09:16.275593	2019-12-04 15:09:16.275593
17f20c24-16eb-11ea-8a37-474d050b40ac	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_4	8e17510c-a877-42a6-addc-95ef7d559757-instrument-5-audio.wav	0.001	1.257	120	5512.5	0.6	2019-12-04 15:09:16.308423	2019-12-04 15:09:16.308423
17f3eed6-16eb-11ea-8a37-0b4ab0525ab1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal What 3	489c5976-cbda-4449-a8cf-67d653b77dbf-instrument-5-audio.wav	0.04	0.407	120	370.588	0.6	2019-12-04 15:09:16.320843	2019-12-04 15:09:16.320843
17f51266-16eb-11ea-8a37-c35a3a34d43f	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_3	8494ac91-a1ef-4045-9f1f-3a1b4a53ee3d-instrument-5-audio.wav	0	2.346	120	1378.12	0.6	2019-12-04 15:09:16.328321	2019-12-04 15:09:16.328321
17f62d40-16eb-11ea-8a37-53a3a5fbfe65	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_1	568d1c74-a43e-44fc-ab53-0d1d701f6f0f-instrument-5-audio.wav	0	0.851	120	364.463	0.6	2019-12-04 15:09:16.335566	2019-12-04 15:09:16.335566
17f73d3e-16eb-11ea-8a37-876dc1c8238e	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_9	2d2d76f7-9d76-41c6-9e55-0b94703d487c-instrument-5-audio.wav	0	0.407	120	531.325	0.6	2019-12-04 15:09:16.342547	2019-12-04 15:09:16.342547
17f8553e-16eb-11ea-8a37-77efd3f331c9	17e50f74-16eb-11ea-8a37-e3561e92fad1	Kick 12_339	ccfc6b74-c939-481f-b59d-caced86b2528-instrument-5-audio.wav	0	0.457	120	3675	0.6	2019-12-04 15:09:16.349683	2019-12-04 15:09:16.349683
17fa4308-16eb-11ea-8a37-37db27d657fb	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_7	7fd96254-d9cf-4ad6-9899-dee564543853-instrument-5-audio.wav	0.001	0.653	120	5512.5	0.6	2019-12-04 15:09:16.362376	2019-12-04 15:09:16.362376
17fc274a-16eb-11ea-8a37-bfb7fbf0c548	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_9	96df8da4-5be9-4a0f-a97b-5f8c0d28f161-instrument-5-audio.wav	0	0.432	120	1454.55	0.6	2019-12-04 15:09:16.374773	2019-12-04 15:09:16.374773
17fe5916-16eb-11ea-8a37-2f401c09459b	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_5	c18a2f87-df5f-421a-aa59-89fda817210c-instrument-5-audio.wav	0	3.133	120	189.27	0.6	2019-12-04 15:09:16.388991	2019-12-04 15:09:16.388991
180090b4-16eb-11ea-8a37-fb1b8401733a	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_8	725e8281-c845-4a87-9a37-9117b1e6a830-instrument-5-audio.wav	0.002	0.799	120	355.645	0.6	2019-12-04 15:09:16.403542	2019-12-04 15:09:16.403542
18021e48-16eb-11ea-8a37-939f50e59431	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_2	6ffdef87-909f-4b67-a2f7-fadbb3a76e33-instrument-5-audio.wav	0	0.528	120	257.895	0.6	2019-12-04 15:09:16.413701	2019-12-04 15:09:16.413701
1803b564-16eb-11ea-8a37-a7f2106340c1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_6	83fbed4b-648c-4886-9079-f220fb0dc9fb-instrument-5-audio.wav	0.001	0.659	120	134.451	0.6	2019-12-04 15:09:16.424099	2019-12-04 15:09:16.424099
1805557c-16eb-11ea-8a37-ab970761d266	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal What 2	70d22a2a-a888-460f-9dfa-01bae076adfe-instrument-5-audio.wav	0.027	0.276	120	416.038	0.6	2019-12-04 15:09:16.434725	2019-12-04 15:09:16.434725
18071a56-16eb-11ea-8a37-870a00c5ecaf	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_9	50f516a9-faaa-4091-848d-651d96ecc7be-instrument-5-audio.wav	0	0.751	120	176.4	0.6	2019-12-04 15:09:16.446314	2019-12-04 15:09:16.446314
18095b18-16eb-11ea-8a37-7f96259b023c	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_7	02dde877-01b4-432d-8d22-f1458917154b-instrument-5-audio.wav	0.001	0.502	120	420	0.6	2019-12-04 15:09:16.461228	2019-12-04 15:09:16.461228
180b8b40-16eb-11ea-8a37-17e7f846189f	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal Woah	7ac9d00c-0b24-49ad-8cbb-c586ac0f080f-instrument-5-audio.wav	0.02	0.488	120	604.11	0.6	2019-12-04 15:09:16.475492	2019-12-04 15:09:16.475492
180df9f2-16eb-11ea-8a37-67c5e6ceb956	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_5	f6f79c74-f1e0-459b-9728-46f59bd14ee7-instrument-5-audio.wav	0.001	0.608	120	428.155	0.6	2019-12-04 15:09:16.491363	2019-12-04 15:09:16.491363
181027b8-16eb-11ea-8a37-4fdff362d2c5	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_6	e173c291-60d6-4f9a-a422-d2d8c99bd9b3-instrument-5-audio.wav	0.003	0.425	120	3428.57	0.6	2019-12-04 15:09:16.505772	2019-12-04 15:09:16.505772
181168e4-16eb-11ea-8a37-93bf6ccfd3b3	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_10	b14d6a26-1e35-4f7c-bbfb-6fd262c2d35f-instrument-5-audio.wav	0	1.631	120	1378.12	0.6	2019-12-04 15:09:16.514029	2019-12-04 15:09:16.514029
18129944-16eb-11ea-8a37-e757462dd86d	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_2	2c2d8ba8-911b-4480-a774-c37102c12e90-instrument-5-audio.wav	0.009	2.036	120	1378.12	0.6	2019-12-04 15:09:16.521831	2019-12-04 15:09:16.521831
1813abcc-16eb-11ea-8a37-e363c13561a2	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_10	38c92218-882d-4714-a493-14261e07c4fa-instrument-5-audio.wav	0	0.741	120	302.055	0.6	2019-12-04 15:09:16.528883	2019-12-04 15:09:16.528883
1814b12a-16eb-11ea-8a37-dfd97f3f1d1d	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_8	f1bac880-fede-4c5d-9249-956f5e179d62-instrument-5-audio.wav	0	0.835	120	290.132	0.6	2019-12-04 15:09:16.535586	2019-12-04 15:09:16.535586
18169274-16eb-11ea-8a37-033088a41f2f	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_3	86d61872-a9bf-4b68-b4df-397be09bfe5c-instrument-5-audio.wav	0.007	1.051	120	3428.57	0.6	2019-12-04 15:09:16.547891	2019-12-04 15:09:16.547891
181886ba-16eb-11ea-8a37-87c7385e0083	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_1	21369f18-b2b6-4d8b-bd28-de36f294b67e-instrument-5-audio.wav	0	1.206	120	5512.5	0.6	2019-12-04 15:09:16.560704	2019-12-04 15:09:16.560704
181a45f4-16eb-11ea-8a37-db5faa67a688	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_6	91f5c7de-609d-48fd-a527-c7b132ee2af5-instrument-5-audio.wav	0	2.984	120	1336.36	0.6	2019-12-04 15:09:16.572145	2019-12-04 15:09:16.572145
181c16a4-16eb-11ea-8a37-a752cb66a0c7	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_9	0818bf78-3838-43a5-8665-7f8f2814bfc4-instrument-5-audio.wav	0.003	0.583	120	249.153	0.6	2019-12-04 15:09:16.584023	2019-12-04 15:09:16.584023
181d3f84-16eb-11ea-8a37-03b6f26eb4fc	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_6	01e988c0-3821-4ba2-8223-70643f3c27cf-instrument-5-audio.wav	0	0.736	120	408.333	0.6	2019-12-04 15:09:16.591625	2019-12-04 15:09:16.591625
181e7476-16eb-11ea-8a37-c35eda2de4ff	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal What 1	cccc3d64-9cb9-468d-be42-e1ec29ba65b1-instrument-5-audio.wav	0.058	0.401	120	390.265	0.6	2019-12-04 15:09:16.599492	2019-12-04 15:09:16.599492
181fd1e0-16eb-11ea-8a37-e3a8ea2a1c89	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_1	2f4bf7a2-744e-47cc-b5c2-da0a846cab91-instrument-5-audio.wav	0	1.008	120	1422.58	0.6	2019-12-04 15:09:16.608402	2019-12-04 15:09:16.608402
18216bfe-16eb-11ea-8a37-7fa9bb385443	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_7	de082694-4a02-48a4-92d1-83c2d2b7dd92-instrument-5-audio.wav	0.001	0.6	120	1263.16	0.6	2019-12-04 15:09:16.618873	2019-12-04 15:09:16.618873
1823e942-16eb-11ea-8a37-0b1adf808ef0	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_2	23d5847f-56e6-4b79-99ad-6dfd13b9c5b3-instrument-5-audio.wav	0.001	1.008	120	6300	0.6	2019-12-04 15:09:16.635156	2019-12-04 15:09:16.635156
18265c7c-16eb-11ea-8a37-1fb103690bc0	17e50f74-16eb-11ea-8a37-e3561e92fad1	Kick 28_339	cd42b8a7-c820-43a2-beb1-f5fec4634050-instrument-5-audio.wav	0.024	0.653	120	980	0.6	2019-12-04 15:09:16.651222	2019-12-04 15:09:16.651222
182895dc-16eb-11ea-8a37-c39d11c0cb6e	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_6	ed5b3f4c-a6e3-424b-b8ba-34c317640903-instrument-5-audio.wav	0	1.348	120	432.353	0.6	2019-12-04 15:09:16.665803	2019-12-04 15:09:16.665803
182ac910-16eb-11ea-8a37-33ab3fe15917	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_5	8a536dae-3727-488f-8895-a0b047620a38-instrument-5-audio.wav	0.001	0.537	120	888.889	0.6	2019-12-04 15:09:16.680233	2019-12-04 15:09:16.680233
182c5802-16eb-11ea-8a37-6f25b8020933	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_2	13db8e43-4266-444a-9edd-c5a5cb2442b4-instrument-5-audio.wav	0	1.506	120	182.988	0.6	2019-12-04 15:09:16.690463	2019-12-04 15:09:16.690463
182dec4e-16eb-11ea-8a37-a3ff3312c6b9	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_1	faf2e9c6-6b12-445e-9b2c-93966451ff5e-instrument-5-audio.wav	0	0.318	120	565.385	0.6	2019-12-04 15:09:16.70079	2019-12-04 15:09:16.70079
182f7fa0-16eb-11ea-8a37-df905c96912f	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_5	62536d52-8600-4941-ac04-a72106079610-instrument-5-audio.wav	0.002	0.405	120	1025.58	0.6	2019-12-04 15:09:16.711117	2019-12-04 15:09:16.711117
18311a9a-16eb-11ea-8a37-7f9c48dfd5a1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal Watch Me	649a2969-6b98-4201-89fc-968d6414f578-instrument-5-audio.wav	0.05	0.807	120	1225	0.6	2019-12-04 15:09:16.721558	2019-12-04 15:09:16.721558
18338726-16eb-11ea-8a37-cb22a831d9ef	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_3	3f0dbe3a-d11a-4e9f-a642-befe5747dd01-instrument-5-audio.wav	0	2.567	120	183.75	0.6	2019-12-04 15:09:16.737449	2019-12-04 15:09:16.737449
1835f362-16eb-11ea-8a37-6b23eb216767	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_4	57ff6b97-fedb-4e3f-b963-840ba8fd101b-instrument-5-audio.wav	0.035	2.617	120	416.038	0.6	2019-12-04 15:09:16.753399	2019-12-04 15:09:16.753399
183834e2-16eb-11ea-8a37-9f55b1df0e78	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_3	a448d6b9-4669-4f17-883a-8dd8c5ce0b8e-instrument-5-audio.wav	0	0.915	120	5512.5	0.6	2019-12-04 15:09:16.768159	2019-12-04 15:09:16.768159
183a6686-16eb-11ea-8a37-0765c513b9b2	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_4	2b9af025-2616-4d03-890f-b74df3413abe-instrument-5-audio.wav	0	0.592	120	11025	0.6	2019-12-04 15:09:16.782495	2019-12-04 15:09:16.782495
183bdf70-16eb-11ea-8a37-eb7b029e1978	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_5	70c7404e-1f17-4a32-8f4a-ff28e7d5797c-instrument-5-audio.wav	0	2.734	120	420	0.6	2019-12-04 15:09:16.792283	2019-12-04 15:09:16.792283
183d1962-16eb-11ea-8a37-ef7f98b935a0	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_6	3bdc44e7-e464-4a0f-a080-ab3d529ac9dc-instrument-5-audio.wav	0.001	0.512	120	612.5	0.6	2019-12-04 15:09:16.800356	2019-12-04 15:09:16.800356
183e389c-16eb-11ea-8a37-c3e28efd0d97	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_7	8d7c72dc-92bb-4ffa-82ff-13750c8ddbfc-instrument-5-audio.wav	0	2.264	120	183.75	0.6	2019-12-04 15:09:16.807725	2019-12-04 15:09:16.807725
183f4e8a-16eb-11ea-8a37-936bb73bed80	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_4	f6e912f5-d582-4044-b73b-6e004bb32a15-instrument-5-audio.wav	0	0.6	120	612.5	0.6	2019-12-04 15:09:16.814853	2019-12-04 15:09:16.814853
184144ba-16eb-11ea-8a37-2b4db47b0de8	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_8	7eae03f7-d1aa-42e2-a928-ff6f7b00b25d-instrument-5-audio.wav	0	2.595	120	182.988	0.6	2019-12-04 15:09:16.827706	2019-12-04 15:09:16.827706
184337f2-16eb-11ea-8a37-ab17d38f48ed	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_10	e4a06acb-c375-4e9b-a5ce-153b815fe6cb-instrument-5-audio.wav	0.002	0.307	120	3000	0.6	2019-12-04 15:09:16.840476	2019-12-04 15:09:16.840476
1844faf6-16eb-11ea-8a37-53daf584cf6a	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom L_3	dd32a686-ef3a-43c4-a3e1-13353d067026-instrument-5-audio.wav	0	0.624	120	110.526	0.6	2019-12-04 15:09:16.852044	2019-12-04 15:09:16.852044
1846ac7a-16eb-11ea-8a37-bf7ac439ed3a	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_8	0e5c97c1-ad2a-4cb5-a1f5-10224c7cec3c-instrument-5-audio.wav	0	2.698	120	1633.33	0.6	2019-12-04 15:09:16.863153	2019-12-04 15:09:16.863153
1847c18c-16eb-11ea-8a37-173965c95f24	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_3	c8d1affb-9b7c-4661-bf31-cd80dc2a9ce1-instrument-5-audio.wav	0	0.602	120	588	0.6	2019-12-04 15:09:16.870243	2019-12-04 15:09:16.870243
1848bede-16eb-11ea-8a37-137705e89a72	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_3	710b3011-cb1e-4065-a514-1e6e4fd19bec-instrument-5-audio.wav	0	0.427	120	612.5	0.6	2019-12-04 15:09:16.876732	2019-12-04 15:09:16.876732
1849c2c0-16eb-11ea-8a37-73952411a20d	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal Hoh	5709e633-bd69-407b-b6ba-420395b221de-instrument-5-audio.wav	0.028	0.476	120	689.062	0.6	2019-12-04 15:09:16.883379	2019-12-04 15:09:16.883379
184ad1ec-16eb-11ea-8a37-9bb6cc2f93d9	17e50f74-16eb-11ea-8a37-e3561e92fad1	Snare Q_11	88ba75c5-9727-43a3-9ef0-856abe729f78-instrument-5-audio.wav	0	1.524	120	6300	0.6	2019-12-04 15:09:16.890304	2019-12-04 15:09:16.890304
184cbe12-16eb-11ea-8a37-730ff7a7f78b	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_4	92f61e58-7225-48bb-91f3-b71fcf7aef5a-instrument-5-audio.wav	0	0.623	120	888.889	0.6	2019-12-04 15:09:16.902898	2019-12-04 15:09:16.902898
184ed2ec-16eb-11ea-8a37-d394b5dadd18	17e50f74-16eb-11ea-8a37-e3561e92fad1	Kick 24_339	a0d1938b-9f3d-47b3-a98f-fb0a429e6df7-instrument-5-audio.wav	0.013	0.547	120	88.024	0.6	2019-12-04 15:09:16.916506	2019-12-04 15:09:16.916506
1850c570-16eb-11ea-8a37-afeb47e66e06	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal Oobah	a7779c99-55b0-4067-819d-a8203a157cd6-instrument-5-audio.wav	0	0.904	120	397.297	0.6	2019-12-04 15:09:16.929186	2019-12-04 15:09:16.929186
1852ed5a-16eb-11ea-8a37-03036f8f86d1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_7	2a525acb-dc9a-47f4-b105-89dc3332d78b-instrument-5-audio.wav	0	1.738	120	1764	0.6	2019-12-04 15:09:16.943311	2019-12-04 15:09:16.943311
1854853e-16eb-11ea-8a37-a78b2db1bc43	17e50f74-16eb-11ea-8a37-e3561e92fad1	Vocal Play It	53fc9c8c-2412-4133-b088-9bac349e6794-instrument-5-audio.wav	0.064	0.358	120	116.053	0.6	2019-12-04 15:09:16.953711	2019-12-04 15:09:16.953711
18561250-16eb-11ea-8a37-5722d15e6077	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_5	0e47652d-265b-4c83-8c4f-c14a34fc9689-instrument-5-audio.wav	0	0.466	120	612.5	0.6	2019-12-04 15:09:16.963914	2019-12-04 15:09:16.963914
1857a2d2-16eb-11ea-8a37-3328b0110dc8	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Open F_1	4eb40925-8e37-4801-ba2e-cce991c97093-instrument-5-audio.wav	0	0.969	120	428.155	0.6	2019-12-04 15:09:16.974175	2019-12-04 15:09:16.974175
18590ef6-16eb-11ea-8a37-9b2614355b68	17e50f74-16eb-11ea-8a37-e3561e92fad1	Tom H_4	ee21d28c-6102-4ad7-96a5-49cf5ccaf266-instrument-5-audio.wav	0	2.815	120	186.076	0.6	2019-12-04 15:09:16.983544	2019-12-04 15:09:16.983544
185b12b4-16eb-11ea-8a37-4f8cbe060a3f	17e50f74-16eb-11ea-8a37-e3561e92fad1	Conga M_8	1c5f4752-e790-47a0-b0d9-4eedd54b24a5-instrument-5-audio.wav	0	0.407	120	531.325	0.6	2019-12-04 15:09:16.996799	2019-12-04 15:09:16.996799
185d1096-16eb-11ea-8a37-a7a1a5bedbbc	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hihat Closed A_8	7cbe09b2-5fe6-4d7a-b5fa-2f85624e91f5-instrument-5-audio.wav	0	0.73	120	1200	0.6	2019-12-04 15:09:17.009878	2019-12-04 15:09:17.009878
185ece68-16eb-11ea-8a37-17edc2490da1	17e50f74-16eb-11ea-8a37-e3561e92fad1	Kick 11_339	dfe7c338-dd80-42ee-94da-19bc53489ca7-instrument-5-audio.wav	0	0.569	120	69.014	0.6	2019-12-04 15:09:17.021291	2019-12-04 15:09:17.021291
18618b8a-16eb-11ea-8a37-ff57d3dc6575	1860788a-16eb-11ea-8a37-87eb83753fe4	Kick 0	c353888f-1d25-4b13-ac8e-fec4cdcd10f3-instrument-36-audio.wav	0	0.1	121	153.659	0.6	2019-12-04 15:09:17.039239	2019-12-04 15:09:17.039239
1862ac04-16eb-11ea-8a37-bffcd4df8f89	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Open 1 Half Edge	b4195987-56ed-46c6-836d-aa3c05102a80-instrument-36-audio.wav	0.01	0.59	121	518.824	0.6	2019-12-04 15:09:17.046603	2019-12-04 15:09:17.046603
1863ce2c-16eb-11ea-8a37-5b84e1454278	1860788a-16eb-11ea-8a37-87eb83753fe4	Snare 34	c935b049-2de0-4caf-897d-6cf21763f41c-instrument-36-audio.wav	0	1.372	121	172.266	0.6	2019-12-04 15:09:17.054016	2019-12-04 15:09:17.054016
186500d0-16eb-11ea-8a37-536664e9e62d	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Open 2 Half Edge	ad96a177-2b26-46f6-9aaf-f95a5004480e-instrument-36-audio.wav	0.001	0.455	121	7350	0.6	2019-12-04 15:09:17.061862	2019-12-04 15:09:17.061862
18674426-16eb-11ea-8a37-0731ffffbdd1	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Closed 1 Pedal	af2a8ec3-23b8-49b7-8f03-861ca9edf048-instrument-36-audio.wav	0.02	0.13	121	6300	0.6	2019-12-04 15:09:17.076603	2019-12-04 15:09:17.076603
1869b0ee-16eb-11ea-8a37-b3fe70801e4a	1860788a-16eb-11ea-8a37-87eb83753fe4	Tom B2	83a41117-77b2-406c-824b-88c293e35724-instrument-36-audio.wav	0	1.55	121	136.533	0.6	2019-12-04 15:09:17.092497	2019-12-04 15:09:17.092497
186bde78-16eb-11ea-8a37-efbd7f0724d7	1860788a-16eb-11ea-8a37-87eb83753fe4	Snare 33	82f11927-1d2d-4bb9-9636-cd79c5344232-instrument-36-audio.wav	0	1.289	121	240.984	0.6	2019-12-04 15:09:17.106763	2019-12-04 15:09:17.106763
186e13a0-16eb-11ea-8a37-a7413f71a978	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Open 1 Half	bc144296-7bc8-4993-addd-8bf88381ce49-instrument-36-audio.wav	0.001	0.457	121	331.579	0.6	2019-12-04 15:09:17.121232	2019-12-04 15:09:17.121232
186f9a36-16eb-11ea-8a37-e388c87b5bf8	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Closed 1 Edge	2d93990f-a395-4f47-a646-f4f0e9a8c5aa-instrument-36-audio.wav	0.003	0.204	121	537.805	0.6	2019-12-04 15:09:17.131255	2019-12-04 15:09:17.131255
18711adc-16eb-11ea-8a37-b77b246e5e20	1860788a-16eb-11ea-8a37-87eb83753fe4	Kick 30	4428cae6-c79a-4f91-9cef-b930bbf68533-instrument-36-audio.wav	0	0.473	121	5512.5	0.6	2019-12-04 15:09:17.141089	2019-12-04 15:09:17.141089
18729d94-16eb-11ea-8a37-a3298d30f5d0	1860788a-16eb-11ea-8a37-87eb83753fe4	Kick 70	c359546f-7170-4510-9b31-a58bd3b2fceb-instrument-36-audio.wav	0	0.294	121	79.032	0.6	2019-12-04 15:09:17.150972	2019-12-04 15:09:17.150972
18741732-16eb-11ea-8a37-e3b9f55f8370	1860788a-16eb-11ea-8a37-87eb83753fe4	Tom B3	4a35c285-ed7b-43e7-b37f-32e5441624fb-instrument-36-audio.wav	0	1.858	121	104.255	0.6	2019-12-04 15:09:17.160621	2019-12-04 15:09:17.160621
1876b6d6-16eb-11ea-8a37-dbfef979cf82	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Open 1	975ce349-7f3e-44bb-988b-69c75511962e-instrument-36-audio.wav	0.01	1.39	121	331.579	0.6	2019-12-04 15:09:17.177799	2019-12-04 15:09:17.177799
187926c8-16eb-11ea-8a37-4323ec2db348	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Closed 2	0ca9465e-95f3-4e52-bc7f-6a9176bd7f5a-instrument-36-audio.wav	0	0.149	121	7350	0.6	2019-12-04 15:09:17.193827	2019-12-04 15:09:17.193827
187b56c8-16eb-11ea-8a37-c7a5111d046c	1860788a-16eb-11ea-8a37-87eb83753fe4	Snare 30	8ddc0c7b-7324-4226-8380-f70d53b7be33-instrument-36-audio.wav	0	1.268	121	235.829	0.6	2019-12-04 15:09:17.208162	2019-12-04 15:09:17.208162
187d8c5e-16eb-11ea-8a37-db0dccaf65f4	1860788a-16eb-11ea-8a37-87eb83753fe4	Snare 31	4746ca89-d9f5-4815-a12c-91f4a01e56f4-instrument-36-audio.wav	0	1.834	121	175.697	0.6	2019-12-04 15:09:17.222629	2019-12-04 15:09:17.222629
187e549a-16eb-11ea-8a37-c76ff883a7e2	1860788a-16eb-11ea-8a37-87eb83753fe4	Hihat Closed 1	5cab2c30-f2e2-45c9-a16a-35c90a259d92-instrument-36-audio.wav	0.001	0.172	121	373.729	0.6	2019-12-04 15:09:17.227764	2019-12-04 15:09:17.227764
18816ad6-16eb-11ea-8a37-17120f8a1cc8	1860788a-16eb-11ea-8a37-87eb83753fe4	Snare 34	db961345-3fca-4bed-a297-597a765d535c-instrument-36-audio.wav	0	0.462	121	6300	0.6	2019-12-04 15:09:17.247985	2019-12-04 15:09:17.247985
1882ef00-16eb-11ea-8a37-9b9996443f19	1860788a-16eb-11ea-8a37-87eb83753fe4	Crash 7	f4d71032-0066-442a-a102-c13abdf226f1-instrument-36-audio.wav	0	3.175	121	678.462	0.6	2019-12-04 15:09:17.257916	2019-12-04 15:09:17.257916
18896baa-16eb-11ea-8a37-c7be844d34ad	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 3	cb9f17ef-6206-44a7-85c2-4284b1cbe024-instrument-31-audio.wav	0	0.772	121	57.831	0.6	2019-12-04 15:09:17.300447	2019-12-04 15:09:17.300447
188b9e0c-16eb-11ea-8a37-6fe440d81eec	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 8	5025ecce-8c1c-456b-9934-5927bf3f6b11-instrument-31-audio.wav	0	0.945	121	6000	0.6	2019-12-04 15:09:17.314832	2019-12-04 15:09:17.314832
188d71c8-16eb-11ea-8a37-8ff02f6702df	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 12	5c09ac3a-524f-4b63-8a86-dd4faa983320-instrument-31-audio.wav	0	0.447	121	95.238	0.6	2019-12-04 15:09:17.326819	2019-12-04 15:09:17.326819
188ef548-16eb-11ea-8a37-6f3ab3141f51	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 43	2a8946ae-651c-4af8-a49e-7c4e62e508ee-instrument-31-audio.wav	0	1.259	121	8000	0.6	2019-12-04 15:09:17.336705	2019-12-04 15:09:17.336705
189088ae-16eb-11ea-8a37-fb7450981460	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 9	fcadf35e-d970-4072-8923-c4f94a3c2386-instrument-31-audio.wav	0	0.524	121	125.984	0.6	2019-12-04 15:09:17.347025	2019-12-04 15:09:17.347025
189216a6-16eb-11ea-8a37-bb6a073772c7	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 30	4a2ea867-86ae-47c5-bf9b-ae9ad542187c-instrument-31-audio.wav	0	0.723	121	5333.33	0.6	2019-12-04 15:09:17.357245	2019-12-04 15:09:17.357245
1893cb18-16eb-11ea-8a37-07e64de02777	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 24	545aaa55-07a2-4e00-9a77-07adc564ed8b-instrument-31-audio.wav	0	0.524	121	130.79	0.6	2019-12-04 15:09:17.368479	2019-12-04 15:09:17.368479
1895c008-16eb-11ea-8a37-8f3040ccb8e8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 9	fd66964c-b23b-47d2-ad5b-2ce11ee59d7a-instrument-31-audio.wav	0	0.539	121	2285.71	0.6	2019-12-04 15:09:17.381338	2019-12-04 15:09:17.381338
189799d2-16eb-11ea-8a37-4b4b2e7be86f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 15	71dd026c-3ff9-4abf-ac1b-6c6bb6992688-instrument-31-audio.wav	0	0.474	121	72.289	0.6	2019-12-04 15:09:17.39351	2019-12-04 15:09:17.39351
189958b2-16eb-11ea-8a37-8383c3493df4	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 23	a477e828-9fbe-4827-b601-54413e3dd095-instrument-31-audio.wav	0	0.387	121	74.766	0.6	2019-12-04 15:09:17.404944	2019-12-04 15:09:17.404944
189ac21a-16eb-11ea-8a37-5fb44a763c0f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 2	c00bb383-5220-44d8-a6e4-d52d798a5801-instrument-31-audio.wav	0	1.15	121	6000	0.6	2019-12-04 15:09:17.414178	2019-12-04 15:09:17.414178
189c07a6-16eb-11ea-8a37-479dbe5ba4f6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 5	dc724a2a-c208-4fbc-900f-c0e48d7935da-instrument-31-audio.wav	0	1.098	121	145.897	0.6	2019-12-04 15:09:17.422517	2019-12-04 15:09:17.422517
189d573c-16eb-11ea-8a37-67cc0771415f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 38 	96075be4-0c3f-45b6-936a-f5afce156a06-instrument-31-audio.wav	0	0.542	121	125.654	0.6	2019-12-04 15:09:17.43109	2019-12-04 15:09:17.43109
189ec040-16eb-11ea-8a37-77040511ab2f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 31	6b035b72-ef01-422c-ae2a-33a5c9433754-instrument-31-audio.wav	0	0.687	121	5333.33	0.6	2019-12-04 15:09:17.440284	2019-12-04 15:09:17.440284
18a0ad56-16eb-11ea-8a37-7bdce51885a3	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 27	4bf621f4-84fd-4b9f-aab8-5a5758405422-instrument-31-audio.wav	0	0.447	121	95.238	0.6	2019-12-04 15:09:17.452853	2019-12-04 15:09:17.452853
18a306a0-16eb-11ea-8a37-eba40dfdf0bf	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 28	f2c959fe-9574-4a72-b313-2a1fcdf4dda3-instrument-31-audio.wav	0	0.432	121	72.948	0.6	2019-12-04 15:09:17.468226	2019-12-04 15:09:17.468226
18a54bf4-16eb-11ea-8a37-53c0835e397a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 14	031c2f89-ff98-42e9-8f65-77c8ea901379-instrument-31-audio.wav	0	0.415	121	178.439	0.6	2019-12-04 15:09:17.483089	2019-12-04 15:09:17.483089
18a77d34-16eb-11ea-8a37-73c557a79b6c	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 28	f91482d8-14d9-4ffd-b0bd-035259397cc2-instrument-31-audio.wav	0	0.645	121	2526.32	0.6	2019-12-04 15:09:17.497411	2019-12-04 15:09:17.497411
18a96090-16eb-11ea-8a37-df51a8dde2a2	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 21	a7ec1314-d3ff-4bbe-9884-b050beeb0709-instrument-31-audio.wav	0	0.766	121	97.959	0.6	2019-12-04 15:09:17.509869	2019-12-04 15:09:17.509869
18ab071a-16eb-11ea-8a37-fb7006611ac6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Fluxing Shaker 1	0aee8863-13d1-4e88-877d-5b2d90d780ee-instrument-31-audio.wav	0	0.306	121	1411.77	0.6	2019-12-04 15:09:17.520687	2019-12-04 15:09:17.520687
18ac9fb2-16eb-11ea-8a37-cf621ad8ea06	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 35	22c461ab-99be-4aa7-9982-db3e890696cd-instrument-31-audio.wav	0	0.766	121	94.488	0.6	2019-12-04 15:09:17.531152	2019-12-04 15:09:17.531152
18ae2a8a-16eb-11ea-8a37-6f37797fd9f6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 31	ca39f467-0a37-4f48-999c-34ca8d0dfee7-instrument-31-audio.wav	0	0.416	121	59.553	0.6	2019-12-04 15:09:17.541261	2019-12-04 15:09:17.541261
18afdfba-16eb-11ea-8a37-579a18edbe36	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 3	89614224-5284-4c70-86f5-6aec8edca200-instrument-31-audio.wav	0	1.1	121	6000	0.6	2019-12-04 15:09:17.55245	2019-12-04 15:09:17.55245
18b1854a-16eb-11ea-8a37-57b4d2f1b030	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Fluxing Shaker 2	102fe87b-767e-47a5-9760-32d29cd1cf3f-instrument-31-audio.wav	0	0.363	121	1263.16	0.6	2019-12-04 15:09:17.563202	2019-12-04 15:09:17.563202
18b33250-16eb-11ea-8a37-af9972429936	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 11	e24863e9-9d74-4113-9302-a99a8d88928a-instrument-31-audio.wav	0	0.396	121	100	0.6	2019-12-04 15:09:17.574211	2019-12-04 15:09:17.574211
18b57be6-16eb-11ea-8a37-d3d79e939e06	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 29	2c8b8474-f459-4621-8aee-26a0c492f124-instrument-31-audio.wav	0	0.585	121	5333.33	0.6	2019-12-04 15:09:17.589208	2019-12-04 15:09:17.589208
18b71000-16eb-11ea-8a37-eb83a2d9a261	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 36	021d253b-f0fd-4858-9e51-4ce89318ba83-instrument-31-audio.wav	0	0.678	121	86.799	0.6	2019-12-04 15:09:17.599553	2019-12-04 15:09:17.599553
18b89db2-16eb-11ea-8a37-57e79ab1330b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 23	b932198b-2329-461a-9fd4-73abd928b826-instrument-31-audio.wav	0	0.546	121	9428.57	0.6	2019-12-04 15:09:17.609742	2019-12-04 15:09:17.609742
18ba41da-16eb-11ea-8a37-d35b51233602	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 7	4c2b9e01-68fb-412e-b0c2-d0407efb05e1-instrument-31-audio.wav	0	0.813	121	57.831	0.6	2019-12-04 15:09:17.62047	2019-12-04 15:09:17.62047
18bc1f6e-16eb-11ea-8a37-af9e0152ad7e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 6	a81c1ddb-7911-4f60-a67a-74842c3f7f2c-instrument-31-audio.wav	0	1.157	121	6857.13	0.6	2019-12-04 15:09:17.632706	2019-12-04 15:09:17.632706
18bde362-16eb-11ea-8a37-e7b19f789f4e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 36	e3366e98-1be0-4de7-94f0-e2ad666102f3-instrument-31-audio.wav	0	0.849	121	3000	0.6	2019-12-04 15:09:17.644297	2019-12-04 15:09:17.644297
18bf94dc-16eb-11ea-8a37-934707470d43	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 19	893cfb4b-69b8-4b16-a042-931b5368a045-instrument-31-audio.wav	0	0.418	121	88.725	0.6	2019-12-04 15:09:17.655396	2019-12-04 15:09:17.655396
18c140f2-16eb-11ea-8a37-4f3152e031d1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 37	d756bd4e-af20-4257-8f89-d2e6655bf6d5-instrument-31-audio.wav	0	0.387	121	86.957	0.6	2019-12-04 15:09:17.666349	2019-12-04 15:09:17.666349
18c2de76-16eb-11ea-8a37-8f09fb22b179	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Hi-Hat 1	ab8c8732-1f9e-4df3-863a-6855c4ed5c66-instrument-31-audio.wav	0	0.068	121	16000	0.6	2019-12-04 15:09:17.676942	2019-12-04 15:09:17.676942
18c4810e-16eb-11ea-8a37-bf3cd2348172	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 13	c557059c-3191-443a-ab80-d19f572cc1ce-instrument-31-audio.wav	0	0.432	121	78.049	0.6	2019-12-04 15:09:17.687641	2019-12-04 15:09:17.687641
18c6146a-16eb-11ea-8a37-8f79a9c06eb6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 14	f710d993-30b5-4c3c-9839-c1cbbc6df68f-instrument-31-audio.wav	0.125	0.671	121	143.713	0.6	2019-12-04 15:09:17.697977	2019-12-04 15:09:17.697977
18c7a37a-16eb-11ea-8a37-73c0f962b483	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 33	83abe818-f137-4a36-a909-101be2736d1c-instrument-31-audio.wav	0	0.442	121	60.606	0.6	2019-12-04 15:09:17.708191	2019-12-04 15:09:17.708191
18c9d8a2-16eb-11ea-8a37-ef8f2d2bafa8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 16	9f5911e7-5a31-4d89-9eee-2104b9af0d61-instrument-31-audio.wav	0	0.543	121	6000	0.6	2019-12-04 15:09:17.722649	2019-12-04 15:09:17.722649
18cc3c78-16eb-11ea-8a37-639c0d09c659	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 2	90e24308-fc3f-4931-90e2-2589400e9a20-instrument-31-audio.wav	0	0.527	121	173.285	0.6	2019-12-04 15:09:17.738326	2019-12-04 15:09:17.738326
18ce85dc-16eb-11ea-8a37-a79ad1c2c046	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 35	ec7e1863-cec0-479b-b242-3f6779d62510-instrument-31-audio.wav	0	0.589	121	3200	0.6	2019-12-04 15:09:17.753304	2019-12-04 15:09:17.753304
18d0b028-16eb-11ea-8a37-033cc1e829fa	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 10	949e0b37-4657-4d5a-8622-776017c0cbea-instrument-31-audio.wav	0	0.956	121	149.068	0.6	2019-12-04 15:09:17.767488	2019-12-04 15:09:17.767488
18d2734a-16eb-11ea-8a37-77368cd5f81b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 7	e281a5c1-6abf-4c4b-9fe5-7b039364bb82-instrument-31-audio.wav	0	1.123	121	6000	0.6	2019-12-04 15:09:17.779047	2019-12-04 15:09:17.779047
18d413a8-16eb-11ea-8a37-e3e91040b091	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 26	a1c52a13-e7a4-49bf-854f-8f2368305b3f-instrument-31-audio.wav	0	0.405	121	114.286	0.6	2019-12-04 15:09:17.789713	2019-12-04 15:09:17.789713
18d5a0d8-16eb-11ea-8a37-f3877c969a22	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 13	954655d4-f738-41bc-8b84-9996bf28db9c-instrument-31-audio.wav	0	0.697	121	4000	0.6	2019-12-04 15:09:17.799885	2019-12-04 15:09:17.799885
18d72c64-16eb-11ea-8a37-03d04c29f9c8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 9	8fc44d96-038f-406c-9709-0b6880087c91-instrument-31-audio.wav	0	1.299	121	8000	0.6	2019-12-04 15:09:17.809975	2019-12-04 15:09:17.809975
18d9756e-16eb-11ea-8a37-cba3fa1c49ee	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 21	da2c17a7-1713-4070-a7ba-a5d17207458f-instrument-31-audio.wav	0	0.518	121	2086.96	0.6	2019-12-04 15:09:17.824972	2019-12-04 15:09:17.824972
18dbfb0e-16eb-11ea-8a37-8bb2a19976a0	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 17	b35315e5-1c4f-43f2-afcc-be3c2ab1abbf-instrument-31-audio.wav	0	0.474	121	72.289	0.6	2019-12-04 15:09:17.841426	2019-12-04 15:09:17.841426
18de4846-16eb-11ea-8a37-8fc3f4dc333a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 3	d3ae2e3f-8bb8-4d5a-b3a6-a5e63f3abd3d-instrument-31-audio.wav	0	0.532	121	6000	0.6	2019-12-04 15:09:17.856583	2019-12-04 15:09:17.856583
18e07f4e-16eb-11ea-8a37-ef24cee14319	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 1	24df9e2a-8f23-4d4a-93fb-7d491d090c70-instrument-31-audio.wav	0	1.04	121	5333.33	0.6	2019-12-04 15:09:17.871109	2019-12-04 15:09:17.871109
18e251ca-16eb-11ea-8a37-8713d08e14ce	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 8	452eef7e-e662-4599-9dd5-9a65acd04364-instrument-31-audio.wav	0	0.525	121	2086.96	0.6	2019-12-04 15:09:17.883038	2019-12-04 15:09:17.883038
18e3ef94-16eb-11ea-8a37-23b6d85a4371	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 15	37afd183-9742-40ce-97c8-b8f92ff9ed5e-instrument-31-audio.wav	0	0.529	121	4800	0.6	2019-12-04 15:09:17.893581	2019-12-04 15:09:17.893581
18e5896c-16eb-11ea-8a37-f33cf75aeb3a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 20	29eac327-79af-46d6-bdc9-7c04e9591f66-instrument-31-audio.wav	0	0.512	121	95.05	0.6	2019-12-04 15:09:17.90411	2019-12-04 15:09:17.90411
18e72808-16eb-11ea-8a37-933d76eb95a2	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 29	df0543c8-9a0b-4942-97d5-87c4e7910e46-instrument-31-audio.wav	0	0.415	121	83.189	0.6	2019-12-04 15:09:17.914721	2019-12-04 15:09:17.914721
18e966b8-16eb-11ea-8a37-abf494664a62	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 38	52dbfd5d-3c6f-43d7-9476-065533534726-instrument-31-audio.wav	0	0.85	121	3200	0.6	2019-12-04 15:09:17.929445	2019-12-04 15:09:17.929445
18ebd6b4-16eb-11ea-8a37-2368274ae22d	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 1	900653d0-335d-4861-b615-b2ec1e878150-instrument-31-audio.wav	0	0.542	121	3692.31	0.6	2019-12-04 15:09:17.945394	2019-12-04 15:09:17.945394
18ee1f00-16eb-11ea-8a37-b76675384f8f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 4	582674b4-7768-4d79-9cea-ce2142112cb8-instrument-31-audio.wav	0	0.581	121	6000	0.6	2019-12-04 15:09:17.960379	2019-12-04 15:09:17.960379
18f052f2-16eb-11ea-8a37-e34945ae4066	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 24	8e5b0601-e894-4997-a69d-819a012d1aec-instrument-31-audio.wav	0	0.546	121	3428.57	0.6	2019-12-04 15:09:17.974816	2019-12-04 15:09:17.974816
18f224e2-16eb-11ea-8a37-f3267cbcfb17	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 8	336b3234-55e7-4388-8598-49a1198c3d55-instrument-31-audio.wav	0	0.387	121	109.84	0.6	2019-12-04 15:09:17.986751	2019-12-04 15:09:17.986751
18f3bab4-16eb-11ea-8a37-bbd635879795	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 5	ff18ad0a-73fb-48fc-99cf-fcde25e547eb-instrument-31-audio.wav	0	0.762	121	93.385	0.6	2019-12-04 15:09:17.997152	2019-12-04 15:09:17.997152
18f5543c-16eb-11ea-8a37-737d85107e80	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Crash 9	d5a38675-7468-49b0-8014-05bf4a51aa6d-instrument-31-audio.wav	0.018	2.39	121	857.153	0.6	2019-12-04 15:09:18.007635	2019-12-04 15:09:18.007635
18f6f6fc-16eb-11ea-8a37-1392555a26e5	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 16	3b80e6af-512f-41ac-849e-691b562a2f4c-instrument-31-audio.wav	0	0.416	121	79.077	0.6	2019-12-04 15:09:18.018324	2019-12-04 15:09:18.018324
18f94e8e-16eb-11ea-8a37-8f435f18726a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Tom 4	a5c2ef5d-e593-42ee-a275-a964117539ba-instrument-31-audio.wav	0	1.014	121	141.176	0.6	2019-12-04 15:09:18.033591	2019-12-04 15:09:18.033591
18fbd046-16eb-11ea-8a37-2fd1239d8ee8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 42	6b507b9b-5446-4835-912a-b72f87e520f9-instrument-31-audio.wav	0.003	0.811	121	8000	0.6	2019-12-04 15:09:18.050096	2019-12-04 15:09:18.050096
18fe1194-16eb-11ea-8a37-475aef94fe90	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 44	f6e0c316-68ed-4e6e-a4f9-113817076dfd-instrument-31-audio.wav	0	0.694	121	6000	0.6	2019-12-04 15:09:18.064914	2019-12-04 15:09:18.064914
19003c3a-16eb-11ea-8a37-47f4a17213a3	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Crash 11	e6044e66-1da3-4639-86ad-b797f9ede600-instrument-31-audio.wav	0.081	2.483	121	501.136	0.6	2019-12-04 15:09:18.079082	2019-12-04 15:09:18.079082
190206aa-16eb-11ea-8a37-3f8545cb2bb5	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 7	fe7d0229-0833-47f7-9253-40e2066b3176-instrument-31-audio.wav	0	0.719	121	6000	0.6	2019-12-04 15:09:18.090842	2019-12-04 15:09:18.090842
1903ac08-16eb-11ea-8a37-032a149e24b4	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 18	8fafb486-38fd-4676-aa80-6984beab0cf3-instrument-31-audio.wav	0	0.442	121	77.295	0.6	2019-12-04 15:09:18.101516	2019-12-04 15:09:18.101516
19054f9a-16eb-11ea-8a37-9323b3764e29	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 32	e09a0f7b-113b-4f09-a992-953aacf34248-instrument-31-audio.wav	0	0.418	121	98.765	0.6	2019-12-04 15:09:18.112329	2019-12-04 15:09:18.112329
1906e242-16eb-11ea-8a37-b7eb66a64016	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 22	997c368d-5537-4668-833d-06001bbf8d87-instrument-31-audio.wav	0	0.813	121	60.15	0.6	2019-12-04 15:09:18.122676	2019-12-04 15:09:18.122676
19092e08-16eb-11ea-8a37-6f0c89c3223b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 25	0d957165-32ed-4bc0-b1ec-7e7319f4ae70-instrument-31-audio.wav	0	0.442	121	183.206	0.6	2019-12-04 15:09:18.137667	2019-12-04 15:09:18.137667
190bb72c-16eb-11ea-8a37-af4a5d5df325	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 30	e974711c-0d28-40d7-a5a1-22420b43ae98-instrument-31-audio.wav	0	0.474	121	93.567	0.6	2019-12-04 15:09:18.15431	2019-12-04 15:09:18.15431
190df8b6-16eb-11ea-8a37-d7e15046d868	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 6	70175671-9e0a-4802-a442-cec930df1e13-instrument-31-audio.wav	0	0.678	121	90.226	0.6	2019-12-04 15:09:18.169128	2019-12-04 15:09:18.169128
19102712-16eb-11ea-8a37-1f623e692501	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Kick 2	ab6c63c0-06e2-4bbe-afc7-f38fe4eba838-instrument-31-audio.wav	0	0.38	121	109.091	0.6	2019-12-04 15:09:18.183403	2019-12-04 15:09:18.183403
1911e516-16eb-11ea-8a37-df5235a93f80	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Snare 34	e75783da-652f-470b-ac41-347bcf6c2c80-instrument-31-audio.wav	0	0.773	121	6000	0.6	2019-12-04 15:09:18.194849	2019-12-04 15:09:18.194849
1915c7d0-16eb-11ea-8a37-27ab9787584f	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Clave w/ Reverb	8d02968d-1453-42db-a80d-fbca37f2997b-instrument-27-audio.wav	0	1.75	121	2823.53	0.6	2019-12-04 15:09:18.22031	2019-12-04 15:09:18.22031
19178f5c-16eb-11ea-8a37-67f384c7c69c	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Hi-Hat 1	1c85dcd2-d3c8-4dbb-8d9a-60a41c88f4f9-instrument-27-audio.wav	0	0.068	121	16000	0.6	2019-12-04 15:09:18.231973	2019-12-04 15:09:18.231973
191a0660-16eb-11ea-8a37-0fd92ae346c8	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Spacey Shaker	2b7286b1-fb7f-406e-8b94-9a0d44506860-instrument-27-audio.wav	0	1.75	121	4800	0.6	2019-12-04 15:09:18.248117	2019-12-04 15:09:18.248117
191c7116-16eb-11ea-8a37-bba31bf81301	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Hi-Hat Dry	f4f989e9-fd15-48ca-9795-57bcfa72783d-instrument-27-audio.wav	0.0002	0.5	121	3692.31	0.6	2019-12-04 15:09:18.263951	2019-12-04 15:09:18.263951
191ead00-16eb-11ea-8a37-e761c288dbae	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Knocky Rim Click w/ Short Reverb Tail	3e646e1a-85c0-46b6-947c-a054689c07a2-instrument-27-audio.wav	0.0003	1.25	121	251.309	0.6	2019-12-04 15:09:18.278562	2019-12-04 15:09:18.278562
1920bc30-16eb-11ea-8a37-13298d9cfd01	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Springy Clap	78e1797e-cd64-423d-ba8f-2183edeae8d6-instrument-27-audio.wav	0.0011	2.75	121	623.377	0.6	2019-12-04 15:09:18.292071	2019-12-04 15:09:18.292071
19226116-16eb-11ea-8a37-f353fe41a475	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Crash 2	562c03f4-0f3a-406f-a9b7-2da4c26e2d77-instrument-27-audio.wav	0.007	1.225	121	245	0.6	2019-12-04 15:09:18.302853	2019-12-04 15:09:18.302853
1923f90e-16eb-11ea-8a37-abd3ffd53fd9	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Spacey Clave	3091be9a-37c1-4c2c-bb4e-12d076584838-instrument-27-audio.wav	0	2.375	121	2823.53	0.6	2019-12-04 15:09:18.313296	2019-12-04 15:09:18.313296
1925926e-16eb-11ea-8a37-9fff26502dd5	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Spacey Cowbell Low	81cef961-c5fc-4952-ade8-b7e0fccdd7e0-instrument-27-audio.wav	0	2.5	121	452.83	0.6	2019-12-04 15:09:18.323794	2019-12-04 15:09:18.323794
192755d6-16eb-11ea-8a37-e74a87171cee	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Dry 808 Snare	0b4c697a-bdd4-4f7c-a0c9-91a74f0e493a-instrument-27-audio.wav	0	0.25	121	192	0.6	2019-12-04 15:09:18.335343	2019-12-04 15:09:18.335343
1929e5a8-16eb-11ea-8a37-9f8f9b1d4bf5	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Hi-Hat Open w/ Reverb	0388acb2-a8ea-4e4f-a3b3-907153ba4ec1-instrument-27-audio.wav	0	2.125	121	4800	0.6	2019-12-04 15:09:18.352067	2019-12-04 15:09:18.352067
192c6fc6-16eb-11ea-8a37-ffb9392fa363	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Tambourine	8335ff25-b151-4ef3-a2c9-56dad8f2a2de-instrument-27-audio.wav	0	2.125	121	2823.53	0.6	2019-12-04 15:09:18.368763	2019-12-04 15:09:18.368763
192e51a6-16eb-11ea-8a37-93680c753ede	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Knocky Open Kick	75baff55-6fc4-4370-8d97-d0560de5c9b6-instrument-27-audio.wav	0.004	0.75	121	127.321	0.6	2019-12-04 15:09:18.3812	2019-12-04 15:09:18.3812
192ff470-16eb-11ea-8a37-3bff1208f2ff	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Springy Clap 2: Return of the Springy Clap	a16ab5e9-0544-4430-9d96-acdfe82c8389-instrument-27-audio.wav	0.0005	2	121	8000	0.6	2019-12-04 15:09:18.391942	2019-12-04 15:09:18.391942
19311e72-16eb-11ea-8a37-572d9e632a8b	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Future Shaker	6913764f-e321-48ee-965d-381f9bca9662-instrument-27-audio.wav	0	0.257	121	12000	0.6	2019-12-04 15:09:18.399596	2019-12-04 15:09:18.399596
193237c6-16eb-11ea-8a37-97654ecdbaec	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Spacey Cowbell High	2174c84d-c6f0-4acc-be17-b70f7932e014-instrument-27-audio.wav	0	2.625	121	705.882	0.6	2019-12-04 15:09:18.40678	2019-12-04 15:09:18.40678
1933c686-16eb-11ea-8a37-5f5a07088a3e	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Hi-Hat w/ Reverb	9a8cd7f2-f68c-4425-8233-c6d77ed2cfcb-instrument-27-audio.wav	0.0002	2.5	121	3692.31	0.6	2019-12-04 15:09:18.416845	2019-12-04 15:09:18.416845
19358c78-16eb-11ea-8a37-1b42354e8b99	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Snare w/ Reverb Tail	6cce584f-d2a3-42ac-95e0-03f3656b5c79-instrument-27-audio.wav	0	1	121	2400	0.6	2019-12-04 15:09:18.428488	2019-12-04 15:09:18.428488
193804f8-16eb-11ea-8a37-876c8c4dd6ac	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Rim Click w/ Long Reverb Tail	3d3d1672-ee60-48bd-b7cf-01ce33d040e2-instrument-27-audio.wav	0.0002	2.125	121	400	0.6	2019-12-04 15:09:18.444657	2019-12-04 15:09:18.444657
193cd5d2-16eb-11ea-8a37-e75acb241adb	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Koto	075b432c-3616-4737-a841-033284cf1252-instrument-38-audio.wav	0	1.294	88	132.831	0.6	2019-12-04 15:09:18.476206	2019-12-04 15:09:18.476206
193ee7c8-16eb-11ea-8a37-b7d2f534c79d	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Snare Rim 6	eedf7a0f-64b2-4c71-8ea8-ba0c75425c8e-instrument-38-audio.wav	0	0.358	120	5512.5	0.6	2019-12-04 15:09:18.489782	2019-12-04 15:09:18.489782
194090be-16eb-11ea-8a37-1f578b2ce220	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Kalimba	a825b767-773c-49fe-b1eb-5d62867bc092-instrument-38-audio.wav	0	1.175	88	262.5	0.6	2019-12-04 15:09:18.500678	2019-12-04 15:09:18.500678
19422c94-16eb-11ea-8a37-ff9bb8d06279	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Shamisen	5dcc49f0-fcb4-4f63-942d-d7a0b09aa351-instrument-38-audio.wav	0	1	88	262.5	0.6	2019-12-04 15:09:18.511216	2019-12-04 15:09:18.511216
1943e318-16eb-11ea-8a37-93c1cc0af638	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Kick 92	b6eea389-d360-4604-9b15-0435ba573e2a-instrument-38-audio.wav	0	1.463	120	63.728	0.6	2019-12-04 15:09:18.522445	2019-12-04 15:09:18.522445
1945ba3a-16eb-11ea-8a37-2f68be87c78c	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Kick 93	576f3155-d321-475d-a5b8-494b9fae6f44-instrument-38-audio.wav	0	1.831	120	106.01	0.6	2019-12-04 15:09:18.534511	2019-12-04 15:09:18.534511
194843c2-16eb-11ea-8a37-cf1a26e97532	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Crash 14	4493b949-9bc2-44a2-9d74-c65d5b96587c-instrument-38-audio.wav	0	1.479	121	518.824	0.6	2019-12-04 15:09:18.551116	2019-12-04 15:09:18.551116
194aae78-16eb-11ea-8a37-2b4831ba3056	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Hihat Closed 14	5ab088d9-7302-48f1-bd57-74f6924e61ee-instrument-38-audio.wav	0	0.293	121	620.465	0.6	2019-12-04 15:09:18.566981	2019-12-04 15:09:18.566981
194ce832-16eb-11ea-8a37-937db00b3e75	193a8eee-16eb-11ea-8a37-4f72c68eb48d	D	fb0fe08a-e881-404c-a9dd-532bc7cab45c-instrument-38-audio.wav	0	1.837	88	250.568	0.6	2019-12-04 15:09:18.58148	2019-12-04 15:09:18.58148
194ef9c4-16eb-11ea-8a37-0fd13c0df2f4	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Taiko	8aac83e9-16b2-4840-a6e9-a28b9440d817-instrument-38-audio.wav	0	2.006	88	2205	0.6	2019-12-04 15:09:18.595122	2019-12-04 15:09:18.595122
1950b4d0-16eb-11ea-8a37-97b59218dda7	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Hihat Closed 15	27ef6f44-99a4-4d57-95cf-448bebb702a2-instrument-38-audio.wav	0	0.314	121	205.855	0.6	2019-12-04 15:09:18.606413	2019-12-04 15:09:18.606413
19525984-16eb-11ea-8a37-875defeb8a13	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Shamisen B	20d70530-d30d-43ef-9b07-478ebfe18687-instrument-38-audio.wav	0.005	1.353	88	264.072	0.6	2019-12-04 15:09:18.617215	2019-12-04 15:09:18.617215
19540964-16eb-11ea-8a37-9322edd6fb40	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Shami	8a5b5710-d5a7-48a9-b1b1-02514aedb0f3-instrument-38-audio.wav	0.006	0.999	88	262.5	0.6	2019-12-04 15:09:18.628288	2019-12-04 15:09:18.628288
1955ce48-16eb-11ea-8a37-1b235a13fa27	193a8eee-16eb-11ea-8a37-4f72c68eb48d	C	def6bba3-4fa7-4248-b1cf-2fe875734f03-instrument-38-audio.wav	0	0.805	88	722.951	0.6	2019-12-04 15:09:18.639868	2019-12-04 15:09:18.639868
19584a88-16eb-11ea-8a37-8bff0765e845	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Snare Rim 3	6d19fe2d-9873-4706-bde3-8f10af0db404-instrument-38-audio.wav	0	0.346	120	1002.27	0.6	2019-12-04 15:09:18.65614	2019-12-04 15:09:18.65614
195aaeb8-16eb-11ea-8a37-83b401b01b76	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Snare Rim 2	c20a1f4b-058f-49b9-b982-adb2a6aaefac-instrument-38-audio.wav	0	0.251	120	1050	0.6	2019-12-04 15:09:18.671818	2019-12-04 15:09:18.671818
195cec28-16eb-11ea-8a37-ef6a40720f17	193a8eee-16eb-11ea-8a37-4f72c68eb48d	E	108bc006-8cec-4ba8-84da-75c94a77bc19-instrument-38-audio.wav	0	0.895	88	588	0.6	2019-12-04 15:09:18.686502	2019-12-04 15:09:18.686502
195f0404-16eb-11ea-8a37-1ff266bacace	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Snare Rim 4	f2681dcd-8ba3-4baa-a80a-14cad5dbb8f4-instrument-38-audio.wav	0	0.216	120	304.138	0.6	2019-12-04 15:09:18.700251	2019-12-04 15:09:18.700251
1960ab6a-16eb-11ea-8a37-874d849cca5c	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Kick 86	be679c0a-93ea-451d-bc10-f454673cbc28-instrument-38-audio.wav	0	1.046	120	67.951	0.6	2019-12-04 15:09:18.711067	2019-12-04 15:09:18.711067
19624c0e-16eb-11ea-8a37-bb3cee04e723	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Hihat Open 12	b7f421ab-381a-4983-b732-658374b8ce33-instrument-38-audio.wav	0	0.41	121	155.116	0.6	2019-12-04 15:09:18.721754	2019-12-04 15:09:18.721754
1963c34a-16eb-11ea-8a37-fbe8db72f648	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Kick 87	3badc739-a69a-4bce-8fad-510aaf0f3074-instrument-38-audio.wav	0	1.158	120	64.663	0.6	2019-12-04 15:09:18.731409	2019-12-04 15:09:18.731409
1965395a-16eb-11ea-8a37-170989048423	193a8eee-16eb-11ea-8a37-4f72c68eb48d	F	0e95155d-d5a7-4ec4-a4b8-1830a54589cb-instrument-38-audio.wav	0	0.802	88	773.684	0.6	2019-12-04 15:09:18.741031	2019-12-04 15:09:18.741031
1967c378-16eb-11ea-8a37-c7654faf7926	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Snare Rim 1	34b0ad8c-eb55-4fb7-860e-2b50b5e181b6-instrument-38-audio.wav	0	0.342	120	280.892	0.6	2019-12-04 15:09:18.757477	2019-12-04 15:09:18.757477
196a3cc0-16eb-11ea-8a37-8b1d0b385e0d	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Hihat Open 14	3cc4f146-ba60-4489-b4c1-310069e1c509-instrument-38-audio.wav	0	0.422	121	149.84	0.6	2019-12-04 15:09:18.773749	2019-12-04 15:09:18.773749
196eeb08-16eb-11ea-8a37-a7ccb0849a23	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Snare 7	d79952fc-c6e3-4318-8b73-23d15449df57-instrument-39-audio.wav	0	1.123	121	270.552	0.6	2019-12-04 15:09:18.804462	2019-12-04 15:09:18.804462
19709930-16eb-11ea-8a37-1f5aa4259d3c	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom High D1	dbbe75be-4db1-4fe9-b2cc-c9f9672cd168-instrument-39-audio.wav	0	0.859	121	179.268	0.6	2019-12-04 15:09:18.815435	2019-12-04 15:09:18.815435
19723664-16eb-11ea-8a37-c3fabc2d00c5	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Kick 23	4b94b1e1-c1d1-455d-8d23-3faaf1c89a99-instrument-39-audio.wav	0	0.992	121	52.814	0.6	2019-12-04 15:09:18.826063	2019-12-04 15:09:18.826063
1973d460-16eb-11ea-8a37-773a912a51b8	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Kick 38	7d3f0e48-77b8-4dbd-8f02-813a779b2c67-instrument-39-audio.wav	0	0.774	121	58.8	0.6	2019-12-04 15:09:18.836642	2019-12-04 15:09:18.836642
19767fa8-16eb-11ea-8a37-9ba2e7fa8e99	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Closed (Shaker) 3	7965cf0f-4721-4853-b466-208d193b878a-instrument-39-audio.wav	0.015	0.087	121	6300	0.6	2019-12-04 15:09:18.854133	2019-12-04 15:09:18.854133
197906ce-16eb-11ea-8a37-fbbbf695b9fc	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Open (Tambourine) 5	a579d1f0-6339-4f76-a001-6cb329489dfa-instrument-39-audio.wav	0	0.262	121	2594.12	0.6	2019-12-04 15:09:18.87072	2019-12-04 15:09:18.87072
197b3cc8-16eb-11ea-8a37-d3b98e62981c	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Open (Tambourine) 2	05e5a569-5754-4976-9869-e3188ce046cf-instrument-39-audio.wav	0	0.321	121	6300	0.6	2019-12-04 15:09:18.885209	2019-12-04 15:09:18.885209
197d58b4-16eb-11ea-8a37-6703cc65c5cb	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Kick 32	bb337e3f-310c-4732-8b4c-8b80dedc9504-instrument-39-audio.wav	0	0.753	121	56.394	0.6	2019-12-04 15:09:18.89904	2019-12-04 15:09:18.89904
197ef462-16eb-11ea-8a37-138e9f0909b1	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom High A1	f1798f7d-e93d-47c4-975b-0a81a11dd08a-instrument-39-audio.wav	0	1.065	121	164.552	0.6	2019-12-04 15:09:18.909491	2019-12-04 15:09:18.909491
19809196-16eb-11ea-8a37-b74fe60b38e3	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Closed (Shaker) 5	a6f581cd-7c96-4726-8b22-4337a66d0022-instrument-39-audio.wav	0.015	0.092	121	6300	0.6	2019-12-04 15:09:18.92015	2019-12-04 15:09:18.92015
198216f6-16eb-11ea-8a37-33f5cf989d1e	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom Low D2	83dbc947-ea66-4fbf-9bb5-a86ac0c35a4d-instrument-39-audio.wav	0	0.997	121	96.248	0.6	2019-12-04 15:09:18.930127	2019-12-04 15:09:18.930127
19839a1c-16eb-11ea-8a37-93909955ca5d	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Snare 3	b7402bc0-1ae4-480f-97fb-538de7405d99-instrument-39-audio.wav	0	1.057	121	270.552	0.6	2019-12-04 15:09:18.940036	2019-12-04 15:09:18.940036
19860db0-16eb-11ea-8a37-934ed863b73f	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom High E1	f662ab55-da9e-4a7c-8cc9-9f0bdfb85af6-instrument-39-audio.wav	0	2.049	121	161.538	0.6	2019-12-04 15:09:18.956086	2019-12-04 15:09:18.956086
1988935a-16eb-11ea-8a37-5b8c14d7b83b	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom Low E4	e7ff4972-b1d2-4f23-8334-7f38e65251e4-instrument-39-audio.wav	0	2.194	121	81.818	0.6	2019-12-04 15:09:18.972581	2019-12-04 15:09:18.972581
198ac6d4-16eb-11ea-8a37-0bbc5619c7c4	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Snare 44	42c87a08-09c0-4186-8b8c-7fa588f335a6-instrument-39-audio.wav	0	0.458	121	11025	0.6	2019-12-04 15:09:18.98705	2019-12-04 15:09:18.98705
198ce5ea-16eb-11ea-8a37-37c1f0dff6d3	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Kick 16	88525f80-96f7-4208-833e-e3026dc04a2b-instrument-39-audio.wav	0	0.808	121	59.274	0.6	2019-12-04 15:09:19.000941	2019-12-04 15:09:19.000941
198e92fa-16eb-11ea-8a37-c7b25aeb5cf6	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Closed (Shaker) 4	295d712b-0726-48fb-9238-e29f7a6e3ca0-instrument-39-audio.wav	0.015	0.086	121	7350	0.6	2019-12-04 15:09:19.011878	2019-12-04 15:09:19.011878
1990390c-16eb-11ea-8a37-cfa7d4b23d24	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Tom Low A2	0c205d69-ae55-4b79-ba04-1b7a37877bab-instrument-39-audio.wav	0	1.457	121	111.646	0.6	2019-12-04 15:09:19.022739	2019-12-04 15:09:19.022739
1991bdc2-16eb-11ea-8a37-af60dd7f4b04	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Open (Tambourine) 4	68419cfa-0b82-484a-8a2b-a84348b7fb88-instrument-39-audio.wav	0	0.148	121	4594.12	0.6	2019-12-04 15:09:19.0327	2019-12-04 15:09:19.0327
19934958-16eb-11ea-8a37-637676e23b66	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Open (Tambourine) 1	0e1affdb-ba5b-4107-a0d4-4ef6565d0255-instrument-39-audio.wav	0	0.297	121	6300	0.6	2019-12-04 15:09:19.042812	2019-12-04 15:09:19.042812
1995bc56-16eb-11ea-8a37-3747940a5e3f	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Crash 12	3cb0cdaa-f60d-4c34-9202-795543bf0982-instrument-39-audio.wav	0	1.768	121	4900	0.6	2019-12-04 15:09:19.058876	2019-12-04 15:09:19.058876
19982d9c-16eb-11ea-8a37-13b60279c4f6	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Hihat Closed (Shaker) 1	f7715bfc-ac3e-45f7-9e64-b53406d7376d-instrument-39-audio.wav	0.025	0.1	121	2321.05	0.6	2019-12-04 15:09:19.074874	2019-12-04 15:09:19.074874
199d2d56-16eb-11ea-8a37-534ff7e94cb4	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Tiny Vibrating String	5a34d08c-ae2a-4d41-be0c-599e4f641a48-instrument-40-audio.wav	0	0.395	121	716.418	0.6	2019-12-04 15:09:19.107646	2019-12-04 15:09:19.107646
199ecf12-16eb-11ea-8a37-9b60875f833e	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 2	28d1308d-ac22-4469-af63-616b39a55f7e-instrument-40-audio.wav	0	0.181	121	156.863	0.6	2019-12-04 15:09:19.118328	2019-12-04 15:09:19.118328
19a05b52-16eb-11ea-8a37-8b39b6eed3cc	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Berimbau-ish Hi-Hat	f71746de-a0c8-4c3a-9284-36dd7067a0b1-instrument-40-audio.wav	0	0.209	121	6857.14	0.6	2019-12-04 15:09:19.128486	2019-12-04 15:09:19.128486
19a4fcb6-16eb-11ea-8a37-fff5fca1e56d	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Slammed Phasey Hat 2	6154f36a-b18f-4282-89a8-dd0fbb0adfec-instrument-40-audio.wav	0	0.375	121	2666.67	0.6	2019-12-04 15:09:19.158791	2019-12-04 15:09:19.158791
19a6f93a-16eb-11ea-8a37-9b535bef0ed1	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Clapping Snare Spread	b45e5925-3c6e-4423-a278-e1fb8c52579e-instrument-40-audio.wav	0	0.105	121	641.176	0.6	2019-12-04 15:09:19.171842	2019-12-04 15:09:19.171842
19a9640e-16eb-11ea-8a37-7f57d56a7c77	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Kick 2	649f1db8-ff49-40bb-83f0-29b5bd880c6d-instrument-40-audio.wav	0	0.345	121	6000	0.6	2019-12-04 15:09:19.187657	2019-12-04 15:09:19.187657
19aba9a8-16eb-11ea-8a37-6b72a7ad4309	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Fluxing Shaker 1	a55df999-37fa-414a-9fe2-4db2098ae7de-instrument-40-audio.wav	0	0.306	121	1411.77	0.6	2019-12-04 15:09:19.202568	2019-12-04 15:09:19.202568
19add1ce-16eb-11ea-8a37-275cf9ca883c	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 5	96ebdcac-f6d0-4aad-8b45-293c6c182a07-instrument-40-audio.wav	0	0.236	121	5333.33	0.6	2019-12-04 15:09:19.216684	2019-12-04 15:09:19.216684
19afa580-16eb-11ea-8a37-4391eea88957	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 6	64703edd-ae19-4ffb-84f3-d016d1209fc0-instrument-40-audio.wav	0	0.245	121	5333.33	0.6	2019-12-04 15:09:19.228683	2019-12-04 15:09:19.228683
19b13a76-16eb-11ea-8a37-7b5ef5b92275	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Dirty Sweep	c1da2d42-8504-4eda-95e9-95da8df53cc4-instrument-40-audio.wav	0	0.338	121	207.792	0.6	2019-12-04 15:09:19.239053	2019-12-04 15:09:19.239053
19b2c418-16eb-11ea-8a37-ab6cd6e1301b	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Crash 19	7aac02ba-5ab8-4471-845b-22f250b96e88-instrument-40-audio.wav	0.046	2.887	121	4900	0.6	2019-12-04 15:09:19.249126	2019-12-04 15:09:19.249126
19b45e90-16eb-11ea-8a37-f75052a115ad	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Crash 12	95534bbd-dcd1-4fcc-afc8-429ed3298e61-instrument-40-audio.wav	0.035	5.605	121	4009.09	0.6	2019-12-04 15:09:19.259598	2019-12-04 15:09:19.259598
19b6676c-16eb-11ea-8a37-cff6018583e9	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 1	618972fa-818c-49ab-87c8-f8c73386917a-instrument-40-audio.wav	0	0.134	121	2666.67	0.6	2019-12-04 15:09:19.272933	2019-12-04 15:09:19.272933
19b8f414-16eb-11ea-8a37-df914959fbec	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Reverse Life 1 second	43675ee8-ccbc-476f-ae00-8a9f42fab6bb-instrument-40-audio.wav	0.02	0.283	121	923.077	0.6	2019-12-04 15:09:19.289544	2019-12-04 15:09:19.289544
19bb4e62-16eb-11ea-8a37-eb063558665a	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Slammed Phasey Hat 1	821e6767-6123-440e-b785-d05de10d9ee6-instrument-40-audio.wav	0	0.375	121	6000	0.6	2019-12-04 15:09:19.305065	2019-12-04 15:09:19.305065
19bd8632-16eb-11ea-8a37-bffa003f1a24	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Kick 4	96f9a747-3ec3-4b58-8a90-8fc7bd45ecba-instrument-40-audio.wav	0	0.308	121	76.8	0.6	2019-12-04 15:09:19.319602	2019-12-04 15:09:19.319602
19bf73f2-16eb-11ea-8a37-8bea02e8b5d7	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Clapping Snare Spread 2	58283ebc-53e3-4f33-b01d-57f8c5541e2f-instrument-40-audio.wav	0	0.206	121	237.624	0.6	2019-12-04 15:09:19.332241	2019-12-04 15:09:19.332241
19c10d34-16eb-11ea-8a37-f72b69f674a4	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Kick 3	bda7865e-6158-4fcb-ab76-33c84b15eae3-instrument-40-audio.wav	0	0.36	121	8000	0.6	2019-12-04 15:09:19.342731	2019-12-04 15:09:19.342731
19c29c08-16eb-11ea-8a37-df20d264bb21	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Kick 1	73379128-dfca-4eeb-b8b4-7c111e5f38c4-instrument-40-audio.wav	0	0.147	121	9600	0.6	2019-12-04 15:09:19.35291	2019-12-04 15:09:19.35291
19c43982-16eb-11ea-8a37-4be0f5978c59	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Vibraslap	1bf9238f-dbf4-4e54-b18e-1a5eee2eaeb4-instrument-40-audio.wav	0	1.159	121	2666.67	0.6	2019-12-04 15:09:19.363542	2019-12-04 15:09:19.363542
19c63a48-16eb-11ea-8a37-874f006f49ed	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Mid Tom 3	932664e1-2a18-4816-8509-ed8a4dde5161-instrument-40-audio.wav	0	0.95	121	5333.33	0.6	2019-12-04 15:09:19.376645	2019-12-04 15:09:19.376645
19c8a990-16eb-11ea-8a37-77c6bad60b34	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Short Lazer	a53a0ec5-ce7e-42fc-b014-d83f1460cad4-instrument-40-audio.wav	0	0.197	121	3200	0.6	2019-12-04 15:09:19.392609	2019-12-04 15:09:19.392609
19cafb96-16eb-11ea-8a37-dff8abf718f1	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Hi-Hat 1	855645f7-1c37-4852-820b-e65b9eb2beed-instrument-40-audio.wav	0	0.068	121	16000	0.6	2019-12-04 15:09:19.407757	2019-12-04 15:09:19.407757
19cd364a-16eb-11ea-8a37-3fe7e645df66	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Crashing Cabinet	459f065f-a3aa-4190-8f0e-ffed0cbae468-instrument-40-audio.wav	0.006	1.358	121	2000	0.6	2019-12-04 15:09:19.422406	2019-12-04 15:09:19.422406
19cf21d0-16eb-11ea-8a37-873702ab7d1f	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 4	644ff7da-2674-4644-9dab-f65044b1e662-instrument-40-audio.wav	0	0.122	121	224.299	0.6	2019-12-04 15:09:19.434983	2019-12-04 15:09:19.434983
19d0c134-16eb-11ea-8a37-a331edf613dd	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Peering Insect	ede6468f-2ecf-44e3-9ce9-6749f54e4b23-instrument-40-audio.wav	0	0.116	121	259.459	0.6	2019-12-04 15:09:19.44559	2019-12-04 15:09:19.44559
19d25828-16eb-11ea-8a37-736da361b38f	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Hi Tom	6339d702-184d-449d-8a2a-9422c1c247f1-instrument-40-audio.wav	0	1.286	121	6000	0.6	2019-12-04 15:09:19.456081	2019-12-04 15:09:19.456081
19d3e904-16eb-11ea-8a37-9f0dad3fdc07	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Dead Clave	bfcdb30f-664a-4c2e-ab75-9ba5cf2f703e-instrument-40-audio.wav	0	0.015	121	421.053	0.6	2019-12-04 15:09:19.466295	2019-12-04 15:09:19.466295
19d5e95c-16eb-11ea-8a37-eb978b3c46db	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Hi-Hat Open	dc725dea-5c27-4f16-aba4-a9ba84ed313b-instrument-27-audio.wav	0	0.5	121	4800	0.6	2019-12-04 15:09:19.479451	2019-12-04 15:09:19.479451
19d859bc-16eb-11ea-8a37-1f2f3d8ddfc9	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Mid Tom	ae0e0456-e47e-4d02-9726-5e9736952564-instrument-40-audio.wav	0	1.286	121	6000	0.6	2019-12-04 15:09:19.495434	2019-12-04 15:09:19.495434
19daaaf0-16eb-11ea-8a37-b77584c5cfaa	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Rim Click 1	5ea3562c-3058-4062-862d-29171a1a1cea-instrument-40-audio.wav	0	0.124	121	923.077	0.6	2019-12-04 15:09:19.5106	2019-12-04 15:09:19.5106
19dcd974-16eb-11ea-8a37-7b7dfd1624b3	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Phasing Triangle	e34f439c-5f18-4841-943f-5264b56f90bc-instrument-40-audio.wav	0	1.242	121	369.231	0.6	2019-12-04 15:09:19.524925	2019-12-04 15:09:19.524925
19deb12c-16eb-11ea-8a37-b39a5de469f2	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 3	98899718-561c-41cc-b783-7ffccd081ed9-instrument-40-audio.wav	0.005	0.256	121	241.206	0.6	2019-12-04 15:09:19.536999	2019-12-04 15:09:19.536999
19e050d6-16eb-11ea-8a37-e7da872f755e	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Fluxing Shaker 2	3a4c6376-c4f6-4538-846e-2c6d32b1a3f0-instrument-40-audio.wav	0	0.363	121	1263.16	0.6	2019-12-04 15:09:19.547608	2019-12-04 15:09:19.547608
19e1e45a-16eb-11ea-8a37-ffc74a1e7408	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Electric Wind Sweep	79e64c9a-2163-4eb0-b4c7-16ab5ad821cd-instrument-40-audio.wav	0.2	0.937	121	1000	0.6	2019-12-04 15:09:19.557975	2019-12-04 15:09:19.557975
19e36b2c-16eb-11ea-8a37-9b3521e69465	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Clap 1	03b7667b-4b3f-4649-9671-e6fae61e18f0-instrument-40-audio.wav	0	0.385	121	6857.14	0.6	2019-12-04 15:09:19.56796	2019-12-04 15:09:19.56796
19e567b0-16eb-11ea-8a37-af9f28606085	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Snare 7	95f6d747-cc59-4376-a03f-f15de2d6771d-instrument-40-audio.wav	0	0.407	121	480	0.6	2019-12-04 15:09:19.580974	2019-12-04 15:09:19.580974
19e7d626-16eb-11ea-8a37-33c47dcef27d	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Mid Tom 2	15e73c79-697f-4ac8-bc43-a313f4717714-instrument-40-audio.wav	0	0.789	121	6000	0.6	2019-12-04 15:09:19.596926	2019-12-04 15:09:19.596926
19ed57d6-16eb-11ea-8a37-674c56b39f28	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Tabla	f34dfe75-5239-45d8-9b06-d1b6e4240199-instrument-30-audio.wav	0.0002	0.594	121	77.544	0.6	2019-12-04 15:09:19.632919	2019-12-04 15:09:19.632919
19ef4b04-16eb-11ea-8a37-ff86ca418007	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Kick with Heavy Attack and Heavy Sub	3d21fbf5-94fd-4f24-853a-f449bff74d6a-instrument-30-audio.wav	0.0001	0.875	121	103.448	0.6	2019-12-04 15:09:19.645711	2019-12-04 15:09:19.645711
19f0ffe4-16eb-11ea-8a37-0fcf3caf46f9	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Basketball-like Snare	446caeea-a77e-47d8-a69f-1a44ec1f4f74-instrument-30-audio.wav	0.0002	0.25	121	4800	0.6	2019-12-04 15:09:19.656961	2019-12-04 15:09:19.656961
19f2b686-16eb-11ea-8a37-6bc4b64fb8a8	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Undulating Low Tom/Kick	c23128ff-fe96-4e9b-b356-f1b3cb951a2d-instrument-30-audio.wav	0	0.625	121	269.663	0.6	2019-12-04 15:09:19.668134	2019-12-04 15:09:19.668134
19f47368-16eb-11ea-8a37-0fb19d8234df	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Knocky Muted Tom	95d5369a-71aa-4b2f-be0e-c72044091307-instrument-30-audio.wav	0.0006	0.219	121	193.548	0.6	2019-12-04 15:09:19.679558	2019-12-04 15:09:19.679558
19f6f0a2-16eb-11ea-8a37-0fa3b0fe765b	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Percussive Flam	9bd6fafa-0363-45d5-a17d-05ee8a40095b-instrument-30-audio.wav	0.0075	0.281	121	1263.16	0.6	2019-12-04 15:09:19.695881	2019-12-04 15:09:19.695881
19f9771e-16eb-11ea-8a37-0744d009b542	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Dead Studio Snare	0c460941-c090-4f71-9ff5-a632319cb5c9-instrument-30-audio.wav	0	0.25	121	186.047	0.6	2019-12-04 15:09:19.712477	2019-12-04 15:09:19.712477
19fb7f78-16eb-11ea-8a37-0fd586076f20	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Tight Dead Snare 2	5ff14782-bf9b-4f0d-8529-bba612872b1d-instrument-30-audio.wav	0.0003	0.25	121	84.956	0.6	2019-12-04 15:09:19.725809	2019-12-04 15:09:19.725809
19fdd28c-16eb-11ea-8a37-634ce52786ca	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Electronic Tom w/ Slapback	c9221c0a-7748-4d54-ba67-6edf709fd42b-instrument-30-audio.wav	0.001	0.875	121	3428.57	0.6	2019-12-04 15:09:19.740941	2019-12-04 15:09:19.740941
19ff80c8-16eb-11ea-8a37-2b6ddc251eed	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Electronic Tom w/ Slapback 2	a2aa200b-5f88-47f8-a9f4-7ff5e12156d0-instrument-30-audio.wav	0.009	0.875	121	3428.57	0.6	2019-12-04 15:09:19.752005	2019-12-04 15:09:19.752005
1a011cda-16eb-11ea-8a37-3f5e45f90d2f	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Hi-Hat 2	f19c9101-1ad1-43c9-8fc0-8a18fe116e64-instrument-40-audio.wav	0	0.175	121	16000	0.6	2019-12-04 15:09:19.762563	2019-12-04 15:09:19.762563
1a02a4b0-16eb-11ea-8a37-df7a3301b53f	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Metallic Snare	417cfa8c-f708-44e7-b06f-497dcc56d4a6-instrument-30-audio.wav	0.0001	0.25	121	322.148	0.6	2019-12-04 15:09:19.772598	2019-12-04 15:09:19.772598
1a04455e-16eb-11ea-8a37-d399bca5ce76	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Clap-like Percussion	9acfb60f-9112-4a6c-9697-f5270583c81b-instrument-30-audio.wav	0.0001	0.25	121	8000	0.6	2019-12-04 15:09:19.783238	2019-12-04 15:09:19.783238
1a06cbc6-16eb-11ea-8a37-0bde5ac53b8e	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Digital Percussive Flam	fecb3546-cd26-4ffe-a226-6822a653b9de-instrument-30-audio.wav	0.0004	0.25	121	226.415	0.6	2019-12-04 15:09:19.799814	2019-12-04 15:09:19.799814
1a0942b6-16eb-11ea-8a37-ff37076807a7	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Hi-Hat 1	9a91b6f0-1a14-48c7-933b-5a53c7824e3d-instrument-40-audio.wav	0	0.068	121	16000	0.6	2019-12-04 15:09:19.815945	2019-12-04 15:09:19.815945
1a0b789c-16eb-11ea-8a37-67acb9c83761	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Dubbed Out Clave	20e27f8a-914f-4091-a2df-769069497ae8-instrument-30-audio.wav	0	6.215	121	1777.78	0.6	2019-12-04 15:09:19.830458	2019-12-04 15:09:19.830458
1a0d9f50-16eb-11ea-8a37-f7c230db0ff1	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Hi-Hat 1	adb40492-919f-46ff-808f-83465a6fb5d6-instrument-40-audio.wav	0	0.068	121	16000	0.6	2019-12-04 15:09:19.844505	2019-12-04 15:09:19.844505
1a0f4e68-16eb-11ea-8a37-9f6925841781	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Future Shaker	2c0665c5-2a39-4cd1-8c06-2829d81e94f9-instrument-40-audio.wav	0	0.257	121	12000	0.6	2019-12-04 15:09:19.8556	2019-12-04 15:09:19.8556
1a10e048-16eb-11ea-8a37-5ffb431e8518	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Dubby Fog Horn	26532e58-f9d9-4e99-a916-0d10f83ad9a9-instrument-30-audio.wav	0.1083	9.25	121	121.212	0.6	2019-12-04 15:09:19.865887	2019-12-04 15:09:19.865887
1a1276b0-16eb-11ea-8a37-bf3d5fbd2946	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Electronic Small Snare	b94c3696-ca2a-4d61-b6fe-7108908f4074-instrument-30-audio.wav	0	0.344	121	4800	0.6	2019-12-04 15:09:19.876278	2019-12-04 15:09:19.876278
1a1412c2-16eb-11ea-8a37-7ff61d461243	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Tight Dead Acoustic Snare	ef02250e-6420-45dd-92f2-21e736df1545-instrument-30-audio.wav	0.0003	0.25	121	428.571	0.6	2019-12-04 15:09:19.886824	2019-12-04 15:09:19.886824
1a1689c6-16eb-11ea-8a37-7369800aa6c5	19ea21a6-16eb-11ea-8a37-cb712a6674d9	White Noise Crash	07812c0f-d7f6-425b-8964-53cafabaee53-instrument-30-audio.wav	0	0.594	121	1200	0.6	2019-12-04 15:09:19.902971	2019-12-04 15:09:19.902971
1a190f70-16eb-11ea-8a37-cb72da2cf2de	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Crash 4	97e39c49-3121-421f-b344-63d6825a90d4-instrument-30-audio.wav	0.016	3.003	121	1297.06	0.6	2019-12-04 15:09:19.919517	2019-12-04 15:09:19.919517
1a1b4592-16eb-11ea-8a37-c3ceebf49e08	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Crash 15	0dfc7cb2-3551-44f3-aaca-9942c11e1b69-instrument-30-audio.wav	0.008	0.998	121	6300	0.6	2019-12-04 15:09:19.934017	2019-12-04 15:09:19.934017
\.


--
-- Data for Name: instrument_audio_chord; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.instrument_audio_chord (id, instrument_id, instrument_audio_id, name, "position", created_at, updated_at) FROM stdin;
151228ae-16eb-11ea-8a37-63de24ec24c5	150bc66c-16eb-11ea-8a37-83d91cc4d60b	150ee1ee-16eb-11ea-8a37-2307c778ff2f	C	0	2019-12-04 15:09:11.485544	2019-12-04 15:09:11.485544
15151bea-16eb-11ea-8a37-e7765239b55d	150bc66c-16eb-11ea-8a37-83d91cc4d60b	15133370-16eb-11ea-8a37-8724b57c0e6f	G	0	2019-12-04 15:09:11.505023	2019-12-04 15:09:11.505023
151f23ec-16eb-11ea-8a37-4bc4bf9d3148	151b16ee-16eb-11ea-8a37-7755b75f4dfb	151cdb64-16eb-11ea-8a37-0fbee363ef1c	C	0	2019-12-04 15:09:11.570766	2019-12-04 15:09:11.570766
1524856c-16eb-11ea-8a37-6fd43418db25	15204e7a-16eb-11ea-8a37-7f93cb6b74b4	152244c8-16eb-11ea-8a37-3b1f1d391206	A	0	2019-12-04 15:09:11.605759	2019-12-04 15:09:11.605759
152a2738-16eb-11ea-8a37-1b4d4e78b7df	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	1527e75c-16eb-11ea-8a37-2fdd46928f5a	C	0	2019-12-04 15:09:11.642765	2019-12-04 15:09:11.642765
152c5b0c-16eb-11ea-8a37-4fc82d82a6b1	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	152afb04-16eb-11ea-8a37-97ae873f39b9	C	0	2019-12-04 15:09:11.657421	2019-12-04 15:09:11.657421
\.


--
-- Data for Name: instrument_audio_event; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.instrument_audio_event (id, instrument_id, instrument_audio_id, name, velocity, "position", duration, note, created_at, updated_at) FROM stdin;
151083fa-16eb-11ea-8a37-fb8de415bd47	150bc66c-16eb-11ea-8a37-83d91cc4d60b	150ee1ee-16eb-11ea-8a37-2307c778ff2f	CRASH	1	0	4	C2	2019-12-04 15:09:11.474719	2019-12-04 15:09:11.474719
15142686-16eb-11ea-8a37-0ff9fa682ac3	150bc66c-16eb-11ea-8a37-83d91cc4d60b	15133370-16eb-11ea-8a37-8724b57c0e6f	CRASH	1	0	4	G1	2019-12-04 15:09:11.498768	2019-12-04 15:09:11.498768
151798e8-16eb-11ea-8a37-4f13d8ae1415	15162544-16eb-11ea-8a37-5f8791ecc0c1	1516f172-16eb-11ea-8a37-73aaa398022f	CRASH	1	0	1	C3	2019-12-04 15:09:11.521372	2019-12-04 15:09:11.521372
1518ffbc-16eb-11ea-8a37-2b6dbcca913e	15162544-16eb-11ea-8a37-5f8791ecc0c1	151853c8-16eb-11ea-8a37-bf468ce03e99	CRASH	1	0	1	c4	2019-12-04 15:09:11.530531	2019-12-04 15:09:11.530531
151a669a-16eb-11ea-8a37-436dacd4eb9a	15162544-16eb-11ea-8a37-5f8791ecc0c1	1519b42a-16eb-11ea-8a37-d7660d66fff9	CRASH	1	0	1	c4	2019-12-04 15:09:11.539702	2019-12-04 15:09:11.539702
151e007a-16eb-11ea-8a37-cb0883532734	151b16ee-16eb-11ea-8a37-7755b75f4dfb	151cdb64-16eb-11ea-8a37-0fbee363ef1c	CRASH	1	0	3	C4	2019-12-04 15:09:11.563348	2019-12-04 15:09:11.563348
15233860-16eb-11ea-8a37-d7e263359a6c	15204e7a-16eb-11ea-8a37-7f93cb6b74b4	152244c8-16eb-11ea-8a37-3b1f1d391206	CRASH	1	0	4	A3	2019-12-04 15:09:11.597555	2019-12-04 15:09:11.597555
15291f28-16eb-11ea-8a37-a70c91847da8	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	1527e75c-16eb-11ea-8a37-2fdd46928f5a	CRASH	1	0	4	C5	2019-12-04 15:09:11.636017	2019-12-04 15:09:11.636017
152bb5ee-16eb-11ea-8a37-0fa5cc4cc59c	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	152afb04-16eb-11ea-8a37-97ae873f39b9	CRASH	1	0	2	C5	2019-12-04 15:09:11.653163	2019-12-04 15:09:11.653163
152ea696-16eb-11ea-8a37-77c25c8bc32b	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	152d7e9c-16eb-11ea-8a37-7f5cf33fdf95	CRASH	1	0	1	C4	2019-12-04 15:09:11.672474	2019-12-04 15:09:11.672474
1536e338-16eb-11ea-8a37-7f0e0e450e79	152fbc70-16eb-11ea-8a37-2f91c79f438d	15363cd0-16eb-11ea-8a37-27a31b17dbaf	TOM	1	0	1	x	2019-12-04 15:09:11.726502	2019-12-04 15:09:11.726502
1538204a-16eb-11ea-8a37-cbbfeb35c9a1	152fbc70-16eb-11ea-8a37-2f91c79f438d	15378202-16eb-11ea-8a37-636a1cd2978d	HIHATOPEN	1	0	1	X	2019-12-04 15:09:11.734601	2019-12-04 15:09:11.734601
153a7070-16eb-11ea-8a37-33966aafd9f3	152fbc70-16eb-11ea-8a37-2f91c79f438d	153958f2-16eb-11ea-8a37-2f03c7ade378	SNARE	1	0	1	x	2019-12-04 15:09:11.749764	2019-12-04 15:09:11.749764
153d8eb8-16eb-11ea-8a37-f3388bc734a6	152fbc70-16eb-11ea-8a37-2f91c79f438d	153be676-16eb-11ea-8a37-039732693844	TOM	1	0	1	x	2019-12-04 15:09:11.770071	2019-12-04 15:09:11.770071
15412eba-16eb-11ea-8a37-070a2cb600ea	152fbc70-16eb-11ea-8a37-2f91c79f438d	154018d6-16eb-11ea-8a37-8f2bb6d34a52	HIHATOPEN	1	0	1	x	2019-12-04 15:09:11.79393	2019-12-04 15:09:11.79393
15438854-16eb-11ea-8a37-3b3441d4a149	152fbc70-16eb-11ea-8a37-2f91c79f438d	15423e90-16eb-11ea-8a37-d7faa5b05767	HIHATOPEN	1	0	1	x	2019-12-04 15:09:11.809327	2019-12-04 15:09:11.809327
15452c18-16eb-11ea-8a37-67d4aca5ec09	152fbc70-16eb-11ea-8a37-2f91c79f438d	15448308-16eb-11ea-8a37-27f2caacfef3	HIHATOPEN	1	0	1	x	2019-12-04 15:09:11.82009	2019-12-04 15:09:11.82009
1546dc48-16eb-11ea-8a37-73e838fc6494	152fbc70-16eb-11ea-8a37-2f91c79f438d	154606d8-16eb-11ea-8a37-cf4ff5bbe496	HIHATOPEN	1	0	1	X	2019-12-04 15:09:11.831138	2019-12-04 15:09:11.831138
15485b2c-16eb-11ea-8a37-c7c43048fd0e	152fbc70-16eb-11ea-8a37-2f91c79f438d	1547a7f4-16eb-11ea-8a37-9f3c8105b1e0	HIHATOPEN	1	0	1	X	2019-12-04 15:09:11.84096	2019-12-04 15:09:11.84096
1549b350-16eb-11ea-8a37-8bba056e0f25	152fbc70-16eb-11ea-8a37-2f91c79f438d	15490b26-16eb-11ea-8a37-d70d1b708307	HIHAT	1	0	1	X	2019-12-04 15:09:11.849782	2019-12-04 15:09:11.849782
154b60d8-16eb-11ea-8a37-8370d5c76d93	152fbc70-16eb-11ea-8a37-2f91c79f438d	154a55d0-16eb-11ea-8a37-33b0911d4fb1	KICK	1	0	1	x	2019-12-04 15:09:11.860784	2019-12-04 15:09:11.860784
154d7f1c-16eb-11ea-8a37-87a25aa11519	152fbc70-16eb-11ea-8a37-2f91c79f438d	154c71d0-16eb-11ea-8a37-cbd64f0f6e31	CRASH	1	0	4	x	2019-12-04 15:09:11.874654	2019-12-04 15:09:11.874654
154f806e-16eb-11ea-8a37-4b846ced1d43	152fbc70-16eb-11ea-8a37-2f91c79f438d	154e94a6-16eb-11ea-8a37-0b11b42e8842	SNARE	1	0	1	x	2019-12-04 15:09:11.887806	2019-12-04 15:09:11.887806
155162b2-16eb-11ea-8a37-27ca654a2c87	152fbc70-16eb-11ea-8a37-2f91c79f438d	15507104-16eb-11ea-8a37-af12828a21c7	TOM	1	0	1	x	2019-12-04 15:09:11.900149	2019-12-04 15:09:11.900149
1552e9e8-16eb-11ea-8a37-f33be0b9eaf8	152fbc70-16eb-11ea-8a37-2f91c79f438d	1552474a-16eb-11ea-8a37-cb38ed01cfba	KICK	1	0	1	x	2019-12-04 15:09:11.910172	2019-12-04 15:09:11.910172
155428a8-16eb-11ea-8a37-63173cc69004	152fbc70-16eb-11ea-8a37-2f91c79f438d	15538af6-16eb-11ea-8a37-e367a876ead9	TOM	1	0	1	x	2019-12-04 15:09:11.918326	2019-12-04 15:09:11.918326
1555fcc8-16eb-11ea-8a37-ffedb9e44514	152fbc70-16eb-11ea-8a37-2f91c79f438d	155560d8-16eb-11ea-8a37-b39bb50ef9eb	HIHATOPEN	1	0	1	x	2019-12-04 15:09:11.930317	2019-12-04 15:09:11.930317
15573674-16eb-11ea-8a37-8b9ac78339a7	152fbc70-16eb-11ea-8a37-2f91c79f438d	15569b56-16eb-11ea-8a37-d7215abb3a5e	SNARE	1	0	1	x	2019-12-04 15:09:11.938344	2019-12-04 15:09:11.938344
15594cb6-16eb-11ea-8a37-b7f2142e81ad	152fbc70-16eb-11ea-8a37-2f91c79f438d	15583e8e-16eb-11ea-8a37-8bc75fc43cb2	TOM	1	0	1	x	2019-12-04 15:09:11.95202	2019-12-04 15:09:11.95202
155b5c04-16eb-11ea-8a37-cf7869506173	152fbc70-16eb-11ea-8a37-2f91c79f438d	155a552a-16eb-11ea-8a37-eb3f35c7cb8d	CRASH	1	0	4	x	2019-12-04 15:09:11.965516	2019-12-04 15:09:11.965516
155d32cc-16eb-11ea-8a37-af676720c537	152fbc70-16eb-11ea-8a37-2f91c79f438d	155c47a4-16eb-11ea-8a37-d32a09c8ca9d	HIHATOPEN	1	0	1	X	2019-12-04 15:09:11.977533	2019-12-04 15:09:11.977533
155f0f20-16eb-11ea-8a37-376c4fd0ec9d	152fbc70-16eb-11ea-8a37-2f91c79f438d	155e2164-16eb-11ea-8a37-0f8720e663f1	HIHATOPEN	1	0	1	x	2019-12-04 15:09:11.989755	2019-12-04 15:09:11.989755
1560641a-16eb-11ea-8a37-137da64effb0	152fbc70-16eb-11ea-8a37-2f91c79f438d	155fb448-16eb-11ea-8a37-e34f6dc290a2	TOM	1	0	1	x	2019-12-04 15:09:11.998498	2019-12-04 15:09:11.998498
1561bb30-16eb-11ea-8a37-c77f2b935700	152fbc70-16eb-11ea-8a37-2f91c79f438d	15611450-16eb-11ea-8a37-e7e2ac8abc8c	TOM	1	0	1	x	2019-12-04 15:09:12.007281	2019-12-04 15:09:12.007281
1562f482-16eb-11ea-8a37-0bfd4ddaed0b	152fbc70-16eb-11ea-8a37-2f91c79f438d	15625b44-16eb-11ea-8a37-23e57d34732b	SNARE	1	0	1	x	2019-12-04 15:09:12.015313	2019-12-04 15:09:12.015313
15642e10-16eb-11ea-8a37-3bee9daabdea	152fbc70-16eb-11ea-8a37-2f91c79f438d	156391ee-16eb-11ea-8a37-b712d708e099	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.023309	2019-12-04 15:09:12.023309
156665a4-16eb-11ea-8a37-77da90b6eb57	152fbc70-16eb-11ea-8a37-2f91c79f438d	15654a20-16eb-11ea-8a37-07d72615569e	KICK	1	0	1	x	2019-12-04 15:09:12.037857	2019-12-04 15:09:12.037857
15689be4-16eb-11ea-8a37-f350ee843464	152fbc70-16eb-11ea-8a37-2f91c79f438d	15678812-16eb-11ea-8a37-1bcd8dd6ac89	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.052343	2019-12-04 15:09:12.052343
156a8440-16eb-11ea-8a37-af288c23e651	152fbc70-16eb-11ea-8a37-2f91c79f438d	15698978-16eb-11ea-8a37-d79e71007907	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.064848	2019-12-04 15:09:12.064848
156c5a86-16eb-11ea-8a37-a33152127a7e	152fbc70-16eb-11ea-8a37-2f91c79f438d	156b6db0-16eb-11ea-8a37-8f3fe6d10174	SNARE	1	0	1	x	2019-12-04 15:09:12.076881	2019-12-04 15:09:12.076881
156dbf52-16eb-11ea-8a37-8fe80ef0bfe1	152fbc70-16eb-11ea-8a37-2f91c79f438d	156d0a44-16eb-11ea-8a37-17812fa803d5	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.085998	2019-12-04 15:09:12.085998
156f14ec-16eb-11ea-8a37-830408737c65	152fbc70-16eb-11ea-8a37-2f91c79f438d	156e6e34-16eb-11ea-8a37-47f5ddc9a46e	HIHAT	1	0	1	X	2019-12-04 15:09:12.094768	2019-12-04 15:09:12.094768
15708d90-16eb-11ea-8a37-4bfcd31e03ed	152fbc70-16eb-11ea-8a37-2f91c79f438d	156fb35c-16eb-11ea-8a37-fbf69aef5b16	HIHAT	1	0	1	X	2019-12-04 15:09:12.104298	2019-12-04 15:09:12.104298
1573dcca-16eb-11ea-8a37-8311933cfb99	152fbc70-16eb-11ea-8a37-2f91c79f438d	15726eda-16eb-11ea-8a37-73643cacdb7a	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.125906	2019-12-04 15:09:12.125906
15782992-16eb-11ea-8a37-8bb483f3befd	152fbc70-16eb-11ea-8a37-2f91c79f438d	1576b24c-16eb-11ea-8a37-636d7ca3aeb2	SNARE	1	0	1	x	2019-12-04 15:09:12.154084	2019-12-04 15:09:12.154084
157aba86-16eb-11ea-8a37-9f90b5bc9eea	152fbc70-16eb-11ea-8a37-2f91c79f438d	15797a40-16eb-11ea-8a37-1ba3846d9460	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.170981	2019-12-04 15:09:12.170981
157d2a3c-16eb-11ea-8a37-1fb3653066be	152fbc70-16eb-11ea-8a37-2f91c79f438d	157bf86a-16eb-11ea-8a37-bb60c54ef05b	SNARE	1	0	1	x	2019-12-04 15:09:12.186949	2019-12-04 15:09:12.186949
157f332c-16eb-11ea-8a37-f353af578214	152fbc70-16eb-11ea-8a37-2f91c79f438d	157e3fb2-16eb-11ea-8a37-43bdb3eb766c	SNARE	1	0	1	x	2019-12-04 15:09:12.200291	2019-12-04 15:09:12.200291
15811ab6-16eb-11ea-8a37-fb7ea4abce7e	152fbc70-16eb-11ea-8a37-2f91c79f438d	158025ac-16eb-11ea-8a37-7ff0ee6377bd	CRASH	1	0	4	x	2019-12-04 15:09:12.212699	2019-12-04 15:09:12.212699
1584fc08-16eb-11ea-8a37-677ecbb86dc2	152fbc70-16eb-11ea-8a37-2f91c79f438d	15840ed8-16eb-11ea-8a37-e349062177e3	KICK	1	0	1	x	2019-12-04 15:09:12.238186	2019-12-04 15:09:12.238186
158757dc-16eb-11ea-8a37-d7f0453c3683	152fbc70-16eb-11ea-8a37-2f91c79f438d	1586371c-16eb-11ea-8a37-bbacf86fd3a0	HIHATOPEN	1	0	1	X	2019-12-04 15:09:12.253738	2019-12-04 15:09:12.253738
1589730a-16eb-11ea-8a37-c3edb28e0350	152fbc70-16eb-11ea-8a37-2f91c79f438d	1588694c-16eb-11ea-8a37-f3996bdbad4c	TOM	1	0	1	x	2019-12-04 15:09:12.267561	2019-12-04 15:09:12.267561
158d207c-16eb-11ea-8a37-ef715aebf2a9	158a6738-16eb-11ea-8a37-3706e5d25249	158c39dc-16eb-11ea-8a37-e3725d5c4c41	SNARE	1	0	1	x	2019-12-04 15:09:12.291663	2019-12-04 15:09:12.291663
158e5cc6-16eb-11ea-8a37-4f7c8036e3a3	158a6738-16eb-11ea-8a37-3706e5d25249	158dbfd2-16eb-11ea-8a37-6bc5f72ececd	TOM	1	0	1	x	2019-12-04 15:09:12.299765	2019-12-04 15:09:12.299765
158fa054-16eb-11ea-8a37-ff4c3f54688a	158a6738-16eb-11ea-8a37-3706e5d25249	158efe9c-16eb-11ea-8a37-13014c2f115a	TOM	1	0	1	x	2019-12-04 15:09:12.308037	2019-12-04 15:09:12.308037
1590eb76-16eb-11ea-8a37-9bc2513b8c2e	158a6738-16eb-11ea-8a37-3706e5d25249	159042a2-16eb-11ea-8a37-ebec7a4234be	KICK	1	0	1	x	2019-12-04 15:09:12.316521	2019-12-04 15:09:12.316521
159237ec-16eb-11ea-8a37-cbe6cf8023ed	158a6738-16eb-11ea-8a37-3706e5d25249	159196a2-16eb-11ea-8a37-03b250beb804	CRASH	1	0	4	x	2019-12-04 15:09:12.325038	2019-12-04 15:09:12.325038
1594591e-16eb-11ea-8a37-8bee7eb0bab6	158a6738-16eb-11ea-8a37-3706e5d25249	15934bc8-16eb-11ea-8a37-73c9b3662648	HIHAT	1	0	1	X	2019-12-04 15:09:12.339017	2019-12-04 15:09:12.339017
1596bcb8-16eb-11ea-8a37-7387faef9b28	158a6738-16eb-11ea-8a37-3706e5d25249	15956a98-16eb-11ea-8a37-c39ed5467310	HIHAT	1	0	1	X	2019-12-04 15:09:12.354533	2019-12-04 15:09:12.354533
15993218-16eb-11ea-8a37-37ff967d7b7b	158a6738-16eb-11ea-8a37-3706e5d25249	1597f740-16eb-11ea-8a37-0343a07e973e	TOM	1	0	1	x	2019-12-04 15:09:12.370625	2019-12-04 15:09:12.370625
159bf034-16eb-11ea-8a37-df23cadcfaee	158a6738-16eb-11ea-8a37-3706e5d25249	159a9798-16eb-11ea-8a37-6778357cb367	TOM	1	0	1	x	2019-12-04 15:09:12.388614	2019-12-04 15:09:12.388614
159dc86e-16eb-11ea-8a37-fb641f663f96	158a6738-16eb-11ea-8a37-3706e5d25249	159cde68-16eb-11ea-8a37-dfb4f154dd49	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.400723	2019-12-04 15:09:12.400723
159faa94-16eb-11ea-8a37-8f45a42d6e92	158a6738-16eb-11ea-8a37-3706e5d25249	159ebe68-16eb-11ea-8a37-03c7d0e4ede8	TOM	1	0	1	x	2019-12-04 15:09:12.413051	2019-12-04 15:09:12.413051
15a1862a-16eb-11ea-8a37-0f43eda5bf4b	158a6738-16eb-11ea-8a37-3706e5d25249	15a09f62-16eb-11ea-8a37-e32d9fcb84a4	SNARE	1	0	1	x	2019-12-04 15:09:12.425229	2019-12-04 15:09:12.425229
15a314cc-16eb-11ea-8a37-2f3d2501c8e6	158a6738-16eb-11ea-8a37-3706e5d25249	15a250c8-16eb-11ea-8a37-ebe11f607753	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.435501	2019-12-04 15:09:12.435501
15a57816-16eb-11ea-8a37-c3febf9fef33	158a6738-16eb-11ea-8a37-3706e5d25249	15a445b8-16eb-11ea-8a37-63add7371ead	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.451113	2019-12-04 15:09:12.451113
15a7f050-16eb-11ea-8a37-3b155b4a6e75	158a6738-16eb-11ea-8a37-3706e5d25249	15a6b37a-16eb-11ea-8a37-371c7bf5c306	KICK	1	0	1	x	2019-12-04 15:09:12.467311	2019-12-04 15:09:12.467311
15a9fed6-16eb-11ea-8a37-0f3723dc57a3	158a6738-16eb-11ea-8a37-3706e5d25249	15a90026-16eb-11ea-8a37-0bb1f8fb7aae	HIHAT	1	0	1	X	2019-12-04 15:09:12.480834	2019-12-04 15:09:12.480834
15abe32c-16eb-11ea-8a37-673a59ac58f2	158a6738-16eb-11ea-8a37-3706e5d25249	15aaed46-16eb-11ea-8a37-a3310f2b1faa	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.493267	2019-12-04 15:09:12.493267
15ad22f0-16eb-11ea-8a37-bb85a30af5d8	158a6738-16eb-11ea-8a37-3706e5d25249	15ac7f94-16eb-11ea-8a37-b30bdde5e058	TOM	1	0	1	x	2019-12-04 15:09:12.501435	2019-12-04 15:09:12.501435
15af3f2c-16eb-11ea-8a37-971a10ae8b2f	158a6738-16eb-11ea-8a37-3706e5d25249	15ae6c46-16eb-11ea-8a37-bf97dcf2184f	TOM	1	0	1	x	2019-12-04 15:09:12.515182	2019-12-04 15:09:12.515182
15b0f466-16eb-11ea-8a37-8b7e59b85b2b	158a6738-16eb-11ea-8a37-3706e5d25249	15b01c76-16eb-11ea-8a37-e36b6db5328c	SNARE	1	0	1	x	2019-12-04 15:09:12.526361	2019-12-04 15:09:12.526361
15b33686-16eb-11ea-8a37-eb0f42c2a2ad	158a6738-16eb-11ea-8a37-3706e5d25249	15b1d958-16eb-11ea-8a37-b34aa616e2ff	KICK	1	0	1	x	2019-12-04 15:09:12.541135	2019-12-04 15:09:12.541135
15b5fb46-16eb-11ea-8a37-7316053c702d	158a6738-16eb-11ea-8a37-3706e5d25249	15b4a50c-16eb-11ea-8a37-23d43c4e8e1a	SNARE	1	0	1	x	2019-12-04 15:09:12.559308	2019-12-04 15:09:12.559308
15b87a74-16eb-11ea-8a37-cb238bc7693d	158a6738-16eb-11ea-8a37-3706e5d25249	15b74af0-16eb-11ea-8a37-73d7aa087140	SNARE	1	0	1	x	2019-12-04 15:09:12.57566	2019-12-04 15:09:12.57566
15baed5e-16eb-11ea-8a37-4fd757e5df32	158a6738-16eb-11ea-8a37-3706e5d25249	15b9ab1a-16eb-11ea-8a37-2f47c03fc9f8	CRASH	1	0	4	x	2019-12-04 15:09:12.59172	2019-12-04 15:09:12.59172
15bd08aa-16eb-11ea-8a37-b711eb83a699	158a6738-16eb-11ea-8a37-3706e5d25249	15bc2494-16eb-11ea-8a37-db6fe392b666	SNARE	1	0	1	x	2019-12-04 15:09:12.605452	2019-12-04 15:09:12.605452
15bec622-16eb-11ea-8a37-33c3c656d571	158a6738-16eb-11ea-8a37-3706e5d25249	15bde9e6-16eb-11ea-8a37-1f7977fbb70d	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.616936	2019-12-04 15:09:12.616936
15c0a258-16eb-11ea-8a37-03b81897e0d5	158a6738-16eb-11ea-8a37-3706e5d25249	15bfa966-16eb-11ea-8a37-4f933eb4be7e	SNARE	1	0	1	x	2019-12-04 15:09:12.629115	2019-12-04 15:09:12.629115
15c276c8-16eb-11ea-8a37-7b9f8334050a	158a6738-16eb-11ea-8a37-3706e5d25249	15c19e56-16eb-11ea-8a37-fbc32b45407c	TOM	1	0	1	x	2019-12-04 15:09:12.641118	2019-12-04 15:09:12.641118
15c49c1e-16eb-11ea-8a37-3bf2057f8a40	158a6738-16eb-11ea-8a37-3706e5d25249	15c352f0-16eb-11ea-8a37-0f3aa3ebbf5d	SNARE	1	0	1	x	2019-12-04 15:09:12.655181	2019-12-04 15:09:12.655181
15c74680-16eb-11ea-8a37-e7fb7eefba05	158a6738-16eb-11ea-8a37-3706e5d25249	15c5e768-16eb-11ea-8a37-33eec03fda08	HIHATOPEN	1	0	1	x	2019-12-04 15:09:12.672639	2019-12-04 15:09:12.672639
15c9dfa8-16eb-11ea-8a37-1faeef406024	158a6738-16eb-11ea-8a37-3706e5d25249	15c89238-16eb-11ea-8a37-f700647fffbf	KICK	1	0	1	x	2019-12-04 15:09:12.689582	2019-12-04 15:09:12.689582
15cc4ff4-16eb-11ea-8a37-4bb8a64c6b89	158a6738-16eb-11ea-8a37-3706e5d25249	15cb1d6e-16eb-11ea-8a37-a7a0c1487717	CRASH	1	0	4	x	2019-12-04 15:09:12.705551	2019-12-04 15:09:12.705551
15cfeec0-16eb-11ea-8a37-1b5e8e252861	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15cf3e08-16eb-11ea-8a37-c33fa6144649	TOM	1	0	1	Eb3	2019-12-04 15:09:12.729457	2019-12-04 15:09:12.729457
15d149dc-16eb-11ea-8a37-27a3c67e70ee	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d0a572-16eb-11ea-8a37-b77d3acff86e	HIHATOPEN	1	0	0.5	Eb8	2019-12-04 15:09:12.738349	2019-12-04 15:09:12.738349
15d2818a-16eb-11ea-8a37-9b96ff299eee	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d1e522-16eb-11ea-8a37-4750e297d84b	KICK	1	0	1	Eb2	2019-12-04 15:09:12.746346	2019-12-04 15:09:12.746346
15d432aa-16eb-11ea-8a37-0748cf611906	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d31ce4-16eb-11ea-8a37-0b19574512c9	HIHAT	1	0	0.5	Bb7	2019-12-04 15:09:12.757423	2019-12-04 15:09:12.757423
15d65224-16eb-11ea-8a37-e790787c9666	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d53fce-16eb-11ea-8a37-8b549035857a	HIHAT	1	0	0.5	D4	2019-12-04 15:09:12.771343	2019-12-04 15:09:12.771343
15d849b2-16eb-11ea-8a37-7b4857bd171a	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d7643e-16eb-11ea-8a37-47f203d1021e	HIHAT	1	0	0.5	B7	2019-12-04 15:09:12.784231	2019-12-04 15:09:12.784231
15da1300-16eb-11ea-8a37-2bb3cbc1d513	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15d92e90-16eb-11ea-8a37-7fcd51c6e8bb	HIHATOPEN	1	0	0.5	Eb8	2019-12-04 15:09:12.795953	2019-12-04 15:09:12.795953
15db9144-16eb-11ea-8a37-03ba8d9987ca	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15daf540-16eb-11ea-8a37-ef891c7c3de0	HIHATOPEN	1	0	0.5	Eb8	2019-12-04 15:09:12.80573	2019-12-04 15:09:12.80573
15dcc7e4-16eb-11ea-8a37-f7038aa0fae2	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15dc2ec4-16eb-11ea-8a37-93de29c88f89	TOM	1	0	1	D3	2019-12-04 15:09:12.81369	2019-12-04 15:09:12.81369
15ddf768-16eb-11ea-8a37-ab541574f8a0	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15dd61c2-16eb-11ea-8a37-5f4252464cf5	TOM	1	0	1	Eb3	2019-12-04 15:09:12.821452	2019-12-04 15:09:12.821452
15df1ae4-16eb-11ea-8a37-2778076f2fcd	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15de8c32-16eb-11ea-8a37-bf933a29a6f2	SNARE	1	0	1	E4	2019-12-04 15:09:12.828926	2019-12-04 15:09:12.828926
15e13efa-16eb-11ea-8a37-53d9395b13cf	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15dfae50-16eb-11ea-8a37-cfcfff8fbd5e	CRASH	1	0	4	Eb8	2019-12-04 15:09:12.842928	2019-12-04 15:09:12.842928
15e36888-16eb-11ea-8a37-1bbd9ac26214	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15e24fb6-16eb-11ea-8a37-77148e5000b2	KICK	1	0	1	Bb4	2019-12-04 15:09:12.857075	2019-12-04 15:09:12.857075
15e55d28-16eb-11ea-8a37-975e254109d0	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15e475f2-16eb-11ea-8a37-472002a9619f	TOM	1	0	1	D3	2019-12-04 15:09:12.869931	2019-12-04 15:09:12.869931
15e72f36-16eb-11ea-8a37-13908012ee8a	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15e64a94-16eb-11ea-8a37-3fc3208bdf8a	SNARE	1	0	1	Bb5	2019-12-04 15:09:12.881878	2019-12-04 15:09:12.881878
15e8ba04-16eb-11ea-8a37-9bc5cc712fcc	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15e81cf2-16eb-11ea-8a37-ff3c37e62cdb	TOM	1	0	1	Eb3	2019-12-04 15:09:12.891974	2019-12-04 15:09:12.891974
15e9f306-16eb-11ea-8a37-47f226b6ac8b	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15e95540-16eb-11ea-8a37-8310b1b3b1b3	SNARE	1	0	1	Db4	2019-12-04 15:09:12.899993	2019-12-04 15:09:12.899993
15eb2c30-16eb-11ea-8a37-835a584cb11c	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15ea94be-16eb-11ea-8a37-afd4d8df22f2	SNARE	1	0	1	E3	2019-12-04 15:09:12.908003	2019-12-04 15:09:12.908003
15ec6b22-16eb-11ea-8a37-3f6e925aea6b	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15ebcfe6-16eb-11ea-8a37-672c26cf8c0b	SNARE	1	0	1	C5	2019-12-04 15:09:12.916163	2019-12-04 15:09:12.916163
15ee19fe-16eb-11ea-8a37-5f5c39e74845	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15ed1090-16eb-11ea-8a37-2ffe7d230287	HIHATOPEN	1	0	0.5	Eb8	2019-12-04 15:09:12.9272	2019-12-04 15:09:12.9272
15f036d0-16eb-11ea-8a37-3f97ce95ddf1	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15ef2808-16eb-11ea-8a37-c7126a46d583	HIHAT	1	0	0.5	Ab6	2019-12-04 15:09:12.941041	2019-12-04 15:09:12.941041
15f2312e-16eb-11ea-8a37-a7574b8260f7	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15f1426e-16eb-11ea-8a37-a7db091794e9	HIHAT	1	0	0.5	Ab7	2019-12-04 15:09:12.953986	2019-12-04 15:09:12.953986
15f40706-16eb-11ea-8a37-d326776d27ed	15cd8374-16eb-11ea-8a37-8f22eedc54b2	15f32002-16eb-11ea-8a37-2b9699682645	CRASH	1	0	4	B7	2019-12-04 15:09:12.966034	2019-12-04 15:09:12.966034
15f773d2-16eb-11ea-8a37-e34fe99f1132	15f4f92c-16eb-11ea-8a37-2f529693f38a	15f6d3b4-16eb-11ea-8a37-3b196945f756	HIHATOPEN	1	0	1	G4	2019-12-04 15:09:12.988478	2019-12-04 15:09:12.988478
15f8a068-16eb-11ea-8a37-376ac58cbba0	15f4f92c-16eb-11ea-8a37-2f529693f38a	15f80cc0-16eb-11ea-8a37-f7e122e42b5d	HIHAT	1	0	1	G#5	2019-12-04 15:09:12.996185	2019-12-04 15:09:12.996185
15f9d32a-16eb-11ea-8a37-c77f093e5b96	15f4f92c-16eb-11ea-8a37-2f529693f38a	15f9350a-16eb-11ea-8a37-17cc83e69c3e	KICK	1	0	1	E2	2019-12-04 15:09:13.004008	2019-12-04 15:09:13.004008
15fbe70a-16eb-11ea-8a37-df208aa4434c	15f4f92c-16eb-11ea-8a37-2f529693f38a	15fada54-16eb-11ea-8a37-dff32f945cc6	CRASH	1	0	4	B4	2019-12-04 15:09:13.017641	2019-12-04 15:09:13.017641
15fded2a-16eb-11ea-8a37-3ba377ae7f9c	15f4f92c-16eb-11ea-8a37-2f529693f38a	15fcee34-16eb-11ea-8a37-77b0e480684a	SNARE	1	0	1	A3	2019-12-04 15:09:13.030901	2019-12-04 15:09:13.030901
15ffcb04-16eb-11ea-8a37-1f6559cffcb8	15f4f92c-16eb-11ea-8a37-2f529693f38a	15fedb7c-16eb-11ea-8a37-7f01beb1835a	SNARE	1	0	1	Db4	2019-12-04 15:09:13.043137	2019-12-04 15:09:13.043137
1601a8d4-16eb-11ea-8a37-63a691fee0df	15f4f92c-16eb-11ea-8a37-2f529693f38a	1600be60-16eb-11ea-8a37-1be582427bd7	CRASH	1	0	4	G4	2019-12-04 15:09:13.055356	2019-12-04 15:09:13.055356
1602ecee-16eb-11ea-8a37-530c94f477db	15f4f92c-16eb-11ea-8a37-2f529693f38a	1602496a-16eb-11ea-8a37-9fd1a7179292	KICK	1	0	1	Eb2	2019-12-04 15:09:13.063663	2019-12-04 15:09:13.063663
16042500-16eb-11ea-8a37-fb5b25a76af9	15f4f92c-16eb-11ea-8a37-2f529693f38a	16038dde-16eb-11ea-8a37-3be2bb617d99	SNARE	1	0	1	B7	2019-12-04 15:09:13.071671	2019-12-04 15:09:13.071671
1605420a-16eb-11ea-8a37-63d3b0a977e0	15f4f92c-16eb-11ea-8a37-2f529693f38a	1604b2e0-16eb-11ea-8a37-23631f1c8467	KICK	1	0	1	D2	2019-12-04 15:09:13.078997	2019-12-04 15:09:13.078997
1606a9ba-16eb-11ea-8a37-cfd689766d04	15f4f92c-16eb-11ea-8a37-2f529693f38a	1605d71a-16eb-11ea-8a37-67d880f623f5	KICK	1	0	1	C2	2019-12-04 15:09:13.088035	2019-12-04 15:09:13.088035
16092a6e-16eb-11ea-8a37-5bb62826ddae	15f4f92c-16eb-11ea-8a37-2f529693f38a	1607ea6e-16eb-11ea-8a37-bb1a343cdc3a	SNARE	1	0	1	B7	2019-12-04 15:09:13.104454	2019-12-04 15:09:13.104454
160bae06-16eb-11ea-8a37-232084e58bea	15f4f92c-16eb-11ea-8a37-2f529693f38a	160a7004-16eb-11ea-8a37-47724b9e225b	CRASH	1	0	2	F#6	2019-12-04 15:09:13.12095	2019-12-04 15:09:13.12095
160e39d2-16eb-11ea-8a37-23e1ecb77d52	15f4f92c-16eb-11ea-8a37-2f529693f38a	160cf28e-16eb-11ea-8a37-bf00d4f95b34	HIHATOPEN	1	0	1	B8	2019-12-04 15:09:13.137518	2019-12-04 15:09:13.137518
1610beaa-16eb-11ea-8a37-b31393952311	15f4f92c-16eb-11ea-8a37-2f529693f38a	160f78f6-16eb-11ea-8a37-3f46f247080e	SNARE	1	0	1	E4	2019-12-04 15:09:13.154103	2019-12-04 15:09:13.154103
16127bfa-16eb-11ea-8a37-5f0fc9590497	15f4f92c-16eb-11ea-8a37-2f529693f38a	16119f96-16eb-11ea-8a37-2374ce2bb83a	KICK	1	0	1	A2	2019-12-04 15:09:13.165463	2019-12-04 15:09:13.165463
161433be-16eb-11ea-8a37-5747a4174c8d	15f4f92c-16eb-11ea-8a37-2f529693f38a	16135bec-16eb-11ea-8a37-772f78675e55	KICK	1	0	1	A1	2019-12-04 15:09:13.176801	2019-12-04 15:09:13.176801
1615dffc-16eb-11ea-8a37-8f276b19491d	15f4f92c-16eb-11ea-8a37-2f529693f38a	16150bfe-16eb-11ea-8a37-ef41b3298ca3	HIHAT	1	0	1	F#9	2019-12-04 15:09:13.187767	2019-12-04 15:09:13.187767
161791f8-16eb-11ea-8a37-2751d14061fe	15f4f92c-16eb-11ea-8a37-2f529693f38a	1616b6d4-16eb-11ea-8a37-d7b29d431d11	HIHATOPEN	1	0	1	D9	2019-12-04 15:09:13.198868	2019-12-04 15:09:13.198868
161a1ce8-16eb-11ea-8a37-db47dd9d6211	15f4f92c-16eb-11ea-8a37-2f529693f38a	1618d75c-16eb-11ea-8a37-a7b2b0baf722	KICK	1	0	1	G2	2019-12-04 15:09:13.215519	2019-12-04 15:09:13.215519
161d9878-16eb-11ea-8a37-8b33d2690e8c	15f4f92c-16eb-11ea-8a37-2f529693f38a	161b7f98-16eb-11ea-8a37-3b109d091684	KICK	1	0	1	G2	2019-12-04 15:09:13.238281	2019-12-04 15:09:13.238281
161ff6a4-16eb-11ea-8a37-9b659a6a91f0	15f4f92c-16eb-11ea-8a37-2f529693f38a	161ecd1a-16eb-11ea-8a37-c74ca21d9554	KICK	1	0	1	Bb2	2019-12-04 15:09:13.253852	2019-12-04 15:09:13.253852
1621edec-16eb-11ea-8a37-4384c23b2229	15f4f92c-16eb-11ea-8a37-2f529693f38a	16210698-16eb-11ea-8a37-5f46b002376d	SNARE	1	0	1	B8	2019-12-04 15:09:13.266739	2019-12-04 15:09:13.266739
1623a7b8-16eb-11ea-8a37-3b661a4fddd0	15f4f92c-16eb-11ea-8a37-2f529693f38a	1622cb40-16eb-11ea-8a37-57b5501b3aab	TOM	1	0	1	B2	2019-12-04 15:09:13.278065	2019-12-04 15:09:13.278065
16254aaa-16eb-11ea-8a37-6b08eba74c22	15f4f92c-16eb-11ea-8a37-2f529693f38a	16247c56-16eb-11ea-8a37-5bfffc524466	TOM	1	0	1	F#1	2019-12-04 15:09:13.2888	2019-12-04 15:09:13.2888
1626ef72-16eb-11ea-8a37-1798c2a91275	15f4f92c-16eb-11ea-8a37-2f529693f38a	16261ae8-16eb-11ea-8a37-8bd8ad8ff48a	SNARE	1	0	1	Eb3	2019-12-04 15:09:13.299541	2019-12-04 15:09:13.299541
16294a24-16eb-11ea-8a37-17160a063dd7	15f4f92c-16eb-11ea-8a37-2f529693f38a	1628043e-16eb-11ea-8a37-8bd6d91c4249	SNARE	1	0	1	E3	2019-12-04 15:09:13.314987	2019-12-04 15:09:13.314987
162be464-16eb-11ea-8a37-bbab6f767446	15f4f92c-16eb-11ea-8a37-2f529693f38a	162a96f4-16eb-11ea-8a37-c32f50f5240f	SNARE	1	0	1	E3	2019-12-04 15:09:13.33202	2019-12-04 15:09:13.33202
162e43ee-16eb-11ea-8a37-ffad607014bf	15f4f92c-16eb-11ea-8a37-2f529693f38a	162d1b72-16eb-11ea-8a37-13bc67959774	SNARE	1	0	1	Ab3	2019-12-04 15:09:13.347601	2019-12-04 15:09:13.347601
16309fc2-16eb-11ea-8a37-bf840d6b34db	15f4f92c-16eb-11ea-8a37-2f529693f38a	162f6c2e-16eb-11ea-8a37-e702d5dcab08	KICK	1	0	1	F2	2019-12-04 15:09:13.363007	2019-12-04 15:09:13.363007
163297be-16eb-11ea-8a37-9b71bfd4ed38	15f4f92c-16eb-11ea-8a37-2f529693f38a	1631b27c-16eb-11ea-8a37-43f400097d9a	TOM	1	0	1	A2	2019-12-04 15:09:13.375924	2019-12-04 15:09:13.375924
163471c4-16eb-11ea-8a37-9ff17ec2b172	15f4f92c-16eb-11ea-8a37-2f529693f38a	16339754-16eb-11ea-8a37-27e92bd7db81	SNARE	1	0	1	F3	2019-12-04 15:09:13.388106	2019-12-04 15:09:13.388106
1635da1e-16eb-11ea-8a37-c34e44bdd00d	15f4f92c-16eb-11ea-8a37-2f529693f38a	163534ce-16eb-11ea-8a37-d7e892297c8b	TOM	1	0	1	D6	2019-12-04 15:09:13.397387	2019-12-04 15:09:13.397387
1637124e-16eb-11ea-8a37-7bbc3071c58e	15f4f92c-16eb-11ea-8a37-2f529693f38a	1636799c-16eb-11ea-8a37-77ca1514f090	HIHAT	1	0	1	F#9	2019-12-04 15:09:13.4054	2019-12-04 15:09:13.4054
163c8800-16eb-11ea-8a37-6b413910e8fa	1637e066-16eb-11ea-8a37-c7f42ae039d6	163b6c40-16eb-11ea-8a37-3749a746e87c	KICK	1	0	1	G2	2019-12-04 15:09:13.441154	2019-12-04 15:09:13.441154
163eac48-16eb-11ea-8a37-ab5580669102	1637e066-16eb-11ea-8a37-c7f42ae039d6	163d96d2-16eb-11ea-8a37-cf8ff2161c76	SNARE	1	0	1	C#3	2019-12-04 15:09:13.45519	2019-12-04 15:09:13.45519
16406b64-16eb-11ea-8a37-0b7f86c00462	1637e066-16eb-11ea-8a37-c7f42ae039d6	163fa170-16eb-11ea-8a37-f326c004690e	HIHAT	1	0	1	E8	2019-12-04 15:09:13.466681	2019-12-04 15:09:13.466681
16421c70-16eb-11ea-8a37-43288607cbf7	1637e066-16eb-11ea-8a37-c7f42ae039d6	164142dc-16eb-11ea-8a37-574e08f07300	SNARE	1	0	1	B8	2019-12-04 15:09:13.477668	2019-12-04 15:09:13.477668
1643f432-16eb-11ea-8a37-83ec4fcf38ba	1637e066-16eb-11ea-8a37-c7f42ae039d6	164305fe-16eb-11ea-8a37-936492f9f199	TOM	1	0	1	C#8	2019-12-04 15:09:13.489696	2019-12-04 15:09:13.489696
1645a8d6-16eb-11ea-8a37-3ba96eb2f576	1637e066-16eb-11ea-8a37-c7f42ae039d6	1644dd52-16eb-11ea-8a37-b37e942f3857	KICK	1	0	1	F2	2019-12-04 15:09:13.500976	2019-12-04 15:09:13.500976
16473a20-16eb-11ea-8a37-fb456a436ca4	1637e066-16eb-11ea-8a37-c7f42ae039d6	16465e66-16eb-11ea-8a37-cb8018b1e6d9	TOM	1	0	1	F2	2019-12-04 15:09:13.51126	2019-12-04 15:09:13.51126
16495cba-16eb-11ea-8a37-b7354d824a0c	1637e066-16eb-11ea-8a37-c7f42ae039d6	16484eec-16eb-11ea-8a37-2f2cc6784740	KICK	1	0	1	C2	2019-12-04 15:09:13.525271	2019-12-04 15:09:13.525271
164b7752-16eb-11ea-8a37-5f6e068872f8	1637e066-16eb-11ea-8a37-c7f42ae039d6	164a62d6-16eb-11ea-8a37-2f8d078d8455	TOM	1	0	1	Bb3	2019-12-04 15:09:13.539031	2019-12-04 15:09:13.539031
164d7fd4-16eb-11ea-8a37-332f64409bf9	1637e066-16eb-11ea-8a37-c7f42ae039d6	164c66ee-16eb-11ea-8a37-43474b909f06	KICK	1	0	1	B2	2019-12-04 15:09:13.55229	2019-12-04 15:09:13.55229
164f5e80-16eb-11ea-8a37-8385bb51a6ac	1637e066-16eb-11ea-8a37-c7f42ae039d6	164e846a-16eb-11ea-8a37-9f6407ac6092	KICK	1	0	1	B	2019-12-04 15:09:13.564625	2019-12-04 15:09:13.564625
1650bac8-16eb-11ea-8a37-e33a866352e8	1637e066-16eb-11ea-8a37-c7f42ae039d6	165011f4-16eb-11ea-8a37-87b795c582ae	KICK	1	0	1	B8	2019-12-04 15:09:13.573559	2019-12-04 15:09:13.573559
1652009a-16eb-11ea-8a37-9f83fcba8af7	1637e066-16eb-11ea-8a37-c7f42ae039d6	16515d70-16eb-11ea-8a37-cbb6f1410315	TOM	1	0	1	Eb2	2019-12-04 15:09:13.581905	2019-12-04 15:09:13.581905
16535512-16eb-11ea-8a37-bf2de0f0c3f0	1637e066-16eb-11ea-8a37-c7f42ae039d6	1652abbc-16eb-11ea-8a37-f388a2787123	TOM	1	0	1	E2	2019-12-04 15:09:13.590623	2019-12-04 15:09:13.590623
1654cb9a-16eb-11ea-8a37-c35ac61f7cf5	1637e066-16eb-11ea-8a37-c7f42ae039d6	1653f71a-16eb-11ea-8a37-b7b2bfebe335	TOM	1	0	1	F#4	2019-12-04 15:09:13.60021	2019-12-04 15:09:13.60021
16572570-16eb-11ea-8a37-03f19f43c787	1637e066-16eb-11ea-8a37-c7f42ae039d6	1655d972-16eb-11ea-8a37-0f53a1489e7c	SNARE	1	0	1	Bb7	2019-12-04 15:09:13.615522	2019-12-04 15:09:13.615522
165931ee-16eb-11ea-8a37-67ac48495d8a	1637e066-16eb-11ea-8a37-c7f42ae039d6	16583b5e-16eb-11ea-8a37-e77e136d9512	CRASH	1	0	4	G8	2019-12-04 15:09:13.629069	2019-12-04 15:09:13.629069
165af6a0-16eb-11ea-8a37-d7554bf5c4ce	1637e066-16eb-11ea-8a37-c7f42ae039d6	165a149c-16eb-11ea-8a37-d77f93b10495	SNARE	1	0	1	D6	2019-12-04 15:09:13.640652	2019-12-04 15:09:13.640652
165df1ac-16eb-11ea-8a37-53b854360380	1637e066-16eb-11ea-8a37-c7f42ae039d6	165c0f90-16eb-11ea-8a37-7f7fbe67c77d	TOM	1	0	1	Bb3	2019-12-04 15:09:13.660171	2019-12-04 15:09:13.660171
165f24e6-16eb-11ea-8a37-b7ede2d95a60	1637e066-16eb-11ea-8a37-c7f42ae039d6	165e80ea-16eb-11ea-8a37-0bfb1e61bef8	HIHATOPEN	1	0	1	F#8	2019-12-04 15:09:13.668036	2019-12-04 15:09:13.668036
16605c1c-16eb-11ea-8a37-e31eed2f30ae	1637e066-16eb-11ea-8a37-c7f42ae039d6	165fbd66-16eb-11ea-8a37-37ca11a9734a	CRASH	1	0	4	B7	2019-12-04 15:09:13.675999	2019-12-04 15:09:13.675999
1661c5c0-16eb-11ea-8a37-27309839ba24	1637e066-16eb-11ea-8a37-c7f42ae039d6	16612070-16eb-11ea-8a37-27594286833f	HIHATOPEN	1	0	1	F#9	2019-12-04 15:09:13.685258	2019-12-04 15:09:13.685258
166326ea-16eb-11ea-8a37-e7149a6289b8	1637e066-16eb-11ea-8a37-c7f42ae039d6	166259c2-16eb-11ea-8a37-03b0b8cd5360	SNARE	1	0	1	F#3	2019-12-04 15:09:13.694298	2019-12-04 15:09:13.694298
16652a58-16eb-11ea-8a37-d70e7c3e6fc0	1637e066-16eb-11ea-8a37-c7f42ae039d6	16642b26-16eb-11ea-8a37-cf7307bb521d	KICK	1	0	1	C3	2019-12-04 15:09:13.7075	2019-12-04 15:09:13.7075
1667317c-16eb-11ea-8a37-772e9c6f391d	1637e066-16eb-11ea-8a37-c7f42ae039d6	166639de-16eb-11ea-8a37-331e7c34d001	CRASH	1	0	4	F9	2019-12-04 15:09:13.720787	2019-12-04 15:09:13.720787
1670bdb4-16eb-11ea-8a37-8bc7a45cf9d4	166815c4-16eb-11ea-8a37-634bb3ccef01	166fb446-16eb-11ea-8a37-83f5c556d4bf	HIHATOPEN	1	0	1	x	2019-12-04 15:09:13.783363	2019-12-04 15:09:13.783363
1672ad4a-16eb-11ea-8a37-ab4911e41676	166815c4-16eb-11ea-8a37-634bb3ccef01	1671bc82-16eb-11ea-8a37-3b8c927de119	TOM	0.7	0	0.35	X	2019-12-04 15:09:13.796043	2019-12-04 15:09:13.796043
16746522-16eb-11ea-8a37-4be2800719cc	166815c4-16eb-11ea-8a37-634bb3ccef01	16738846-16eb-11ea-8a37-2f4665b30020	TOM	1	0	1	x	2019-12-04 15:09:13.807316	2019-12-04 15:09:13.807316
1675fc5c-16eb-11ea-8a37-53ae4d567661	166815c4-16eb-11ea-8a37-634bb3ccef01	167541a4-16eb-11ea-8a37-37a42ae57760	KICK	1	0	1	x	2019-12-04 15:09:13.817741	2019-12-04 15:09:13.817741
16771eac-16eb-11ea-8a37-1bcf7decc2c4	166815c4-16eb-11ea-8a37-634bb3ccef01	16768fd2-16eb-11ea-8a37-cb3800cdf2dd	SNARE	1	0	1	x	2019-12-04 15:09:13.825181	2019-12-04 15:09:13.825181
16783ab2-16eb-11ea-8a37-0f0ef828b205	166815c4-16eb-11ea-8a37-634bb3ccef01	1677ae26-16eb-11ea-8a37-f36106242997	HIHATOPEN	1	0	1	X	2019-12-04 15:09:13.832439	2019-12-04 15:09:13.832439
1679510e-16eb-11ea-8a37-7bb9635372db	166815c4-16eb-11ea-8a37-634bb3ccef01	1678c860-16eb-11ea-8a37-47d06217fb9c	KICK	1	0.02	0.5	X	2019-12-04 15:09:13.839576	2019-12-04 15:09:13.839576
167aa22a-16eb-11ea-8a37-5f921874169a	166815c4-16eb-11ea-8a37-634bb3ccef01	1679db88-16eb-11ea-8a37-f7ff8ee3a07e	SNARE	1	0	1	x	2019-12-04 15:09:13.848191	2019-12-04 15:09:13.848191
167ca08e-16eb-11ea-8a37-b30c6b1569f8	166815c4-16eb-11ea-8a37-634bb3ccef01	167ba24c-16eb-11ea-8a37-67140810ac7e	CRASH	1	0	4	x	2019-12-04 15:09:13.861266	2019-12-04 15:09:13.861266
167e8368-16eb-11ea-8a37-d774358672ab	166815c4-16eb-11ea-8a37-634bb3ccef01	167d99f8-16eb-11ea-8a37-ebb6dd898fe9	CRASH	1	0	1	X	2019-12-04 15:09:13.87363	2019-12-04 15:09:13.87363
1680411c-16eb-11ea-8a37-2395f2e0705a	166815c4-16eb-11ea-8a37-634bb3ccef01	167f61e8-16eb-11ea-8a37-fb65f456cd1d	HIHAT	1	0.02	0.1	X	2019-12-04 15:09:13.885037	2019-12-04 15:09:13.885037
1681d054-16eb-11ea-8a37-232d81dd1323	166815c4-16eb-11ea-8a37-634bb3ccef01	16811d30-16eb-11ea-8a37-279e52ce8624	HIHATOPEN	1	0	1	X	2019-12-04 15:09:13.895261	2019-12-04 15:09:13.895261
1682ec0a-16eb-11ea-8a37-dbc8ed5ed6f6	166815c4-16eb-11ea-8a37-634bb3ccef01	16825f24-16eb-11ea-8a37-d7649ee2248f	HIHATOPEN	1	0	1	X	2019-12-04 15:09:13.902532	2019-12-04 15:09:13.902532
16840612-16eb-11ea-8a37-6b6d1431c21b	166815c4-16eb-11ea-8a37-634bb3ccef01	16837a08-16eb-11ea-8a37-efab00e02be8	SNARE	0.6	0	0.014	x	2019-12-04 15:09:13.909747	2019-12-04 15:09:13.909747
16852042-16eb-11ea-8a37-4b021ae2d893	166815c4-16eb-11ea-8a37-634bb3ccef01	168492ee-16eb-11ea-8a37-874a30830408	TOM	0.8	0	0.05	X	2019-12-04 15:09:13.916964	2019-12-04 15:09:13.916964
168676f4-16eb-11ea-8a37-272db2bc43ce	166815c4-16eb-11ea-8a37-634bb3ccef01	1685b052-16eb-11ea-8a37-178d141033de	HIHATOPEN	1	0	1	X	2019-12-04 15:09:13.925734	2019-12-04 15:09:13.925734
16887468-16eb-11ea-8a37-471a451aa4b5	166815c4-16eb-11ea-8a37-634bb3ccef01	16877784-16eb-11ea-8a37-8b8f0451ee3c	KICK	1	0	1	x	2019-12-04 15:09:13.938784	2019-12-04 15:09:13.938784
168a5b70-16eb-11ea-8a37-076989c1b455	166815c4-16eb-11ea-8a37-634bb3ccef01	16897124-16eb-11ea-8a37-cb39f7e26b37	SNARE	1	0	0.091	X	2019-12-04 15:09:13.951253	2019-12-04 15:09:13.951253
168c0cfe-16eb-11ea-8a37-4f30e6bf22e1	166815c4-16eb-11ea-8a37-634bb3ccef01	168b3414-16eb-11ea-8a37-830848b56eba	TOM	1	0	0.3	x	2019-12-04 15:09:13.962359	2019-12-04 15:09:13.962359
168d9f7e-16eb-11ea-8a37-57b844ea9f76	166815c4-16eb-11ea-8a37-634bb3ccef01	168ce5de-16eb-11ea-8a37-cbd1e75b7017	TOM	0.8	0	0.2	X	2019-12-04 15:09:13.972637	2019-12-04 15:09:13.972637
168ec8a4-16eb-11ea-8a37-bf1abaa6e656	166815c4-16eb-11ea-8a37-634bb3ccef01	168e33e4-16eb-11ea-8a37-e3b56cf4ce34	SNARE	0.8	0	0.3	x	2019-12-04 15:09:13.980251	2019-12-04 15:09:13.980251
168fe518-16eb-11ea-8a37-ef4d00ec41f1	166815c4-16eb-11ea-8a37-634bb3ccef01	168f588c-16eb-11ea-8a37-731cf262ac35	HIHATOPEN	1	0	1	X	2019-12-04 15:09:13.987542	2019-12-04 15:09:13.987542
16910164-16eb-11ea-8a37-bf26a68752bc	166815c4-16eb-11ea-8a37-634bb3ccef01	16907348-16eb-11ea-8a37-8bd1e4ce065d	TOM	1	0	0.2	x	2019-12-04 15:09:13.994811	2019-12-04 15:09:13.994811
169255b4-16eb-11ea-8a37-f70b9a794d2d	166815c4-16eb-11ea-8a37-634bb3ccef01	16918f62-16eb-11ea-8a37-6719a136e377	HIHATOPEN	0.8	0.01	0.015	X	2019-12-04 15:09:14.003511	2019-12-04 15:09:14.003511
16945ee0-16eb-11ea-8a37-3b497ba39f74	166815c4-16eb-11ea-8a37-634bb3ccef01	16935b8a-16eb-11ea-8a37-a355e344b3ae	HIHATOPEN	0.5	0	0.59	x	2019-12-04 15:09:14.016845	2019-12-04 15:09:14.016845
16964778-16eb-11ea-8a37-4747c037a2b3	166815c4-16eb-11ea-8a37-634bb3ccef01	16955c6e-16eb-11ea-8a37-97a63970d338	CRASH	1	0	4	x	2019-12-04 15:09:14.029388	2019-12-04 15:09:14.029388
16980798-16eb-11ea-8a37-27116bc5653b	166815c4-16eb-11ea-8a37-634bb3ccef01	169727b0-16eb-11ea-8a37-1f22887960fb	HIHATOPEN	1	0	1	X	2019-12-04 15:09:14.040847	2019-12-04 15:09:14.040847
1699abd4-16eb-11ea-8a37-3778b5c40f56	166815c4-16eb-11ea-8a37-634bb3ccef01	1698e8ca-16eb-11ea-8a37-9f700cc8c6b3	KICK	1	0.03	0.5	X	2019-12-04 15:09:14.051565	2019-12-04 15:09:14.051565
169aed14-16eb-11ea-8a37-cfd6ccc126cb	166815c4-16eb-11ea-8a37-634bb3ccef01	169a51ce-16eb-11ea-8a37-8b94ff7cffcb	TOM	1	0	1	x	2019-12-04 15:09:14.059825	2019-12-04 15:09:14.059825
169c1c48-16eb-11ea-8a37-a315a30be3ec	166815c4-16eb-11ea-8a37-634bb3ccef01	169b886e-16eb-11ea-8a37-97bffa57c894	TOM	1	0	0.2	X	2019-12-04 15:09:14.067581	2019-12-04 15:09:14.067581
169dd10a-16eb-11ea-8a37-03cb40715b9c	166815c4-16eb-11ea-8a37-634bb3ccef01	169d36dc-16eb-11ea-8a37-0fb41e36f4f2	TOM	1	0	1	x	2019-12-04 15:09:14.078748	2019-12-04 15:09:14.078748
16a1b298-16eb-11ea-8a37-5b531fcc666f	169ea38c-16eb-11ea-8a37-b799503ae436	16a0ae66-16eb-11ea-8a37-cf034b98fd70	HIHATOPEN	0.5	0	0.59	x	2019-12-04 15:09:14.104214	2019-12-04 15:09:14.104214
16a38d5c-16eb-11ea-8a37-6b780e2c31de	169ea38c-16eb-11ea-8a37-b799503ae436	16a2a572-16eb-11ea-8a37-db831b623c02	TOM	0.7	0	0.35	X	2019-12-04 15:09:14.116348	2019-12-04 15:09:14.116348
16a5885a-16eb-11ea-8a37-23112840f3b6	169ea38c-16eb-11ea-8a37-b799503ae436	16a48d7e-16eb-11ea-8a37-3bbfdc534b3c	TOM	1	0	0.3	x	2019-12-04 15:09:14.129328	2019-12-04 15:09:14.129328
16a70b30-16eb-11ea-8a37-b33ef039fdb8	169ea38c-16eb-11ea-8a37-b799503ae436	16a659b0-16eb-11ea-8a37-5b1387f09634	TOM	1	0	0.2	x	2019-12-04 15:09:14.139231	2019-12-04 15:09:14.139231
16a86660-16eb-11ea-8a37-5f746151bf88	169ea38c-16eb-11ea-8a37-b799503ae436	16a7bd00-16eb-11ea-8a37-e3aa472ec8f4	SNARE	1	0	1	x	2019-12-04 15:09:14.148121	2019-12-04 15:09:14.148121
16a9fc8c-16eb-11ea-8a37-b3d24d1b5ed5	169ea38c-16eb-11ea-8a37-b799503ae436	16a92d7a-16eb-11ea-8a37-df595bc77f26	SNARE	0.6	0	0.014	x	2019-12-04 15:09:14.158429	2019-12-04 15:09:14.158429
16aba000-16eb-11ea-8a37-53e0fc8745c2	169ea38c-16eb-11ea-8a37-b799503ae436	16aacc02-16eb-11ea-8a37-4fa401877f76	TOM	0.8	0	0.05	X	2019-12-04 15:09:14.169155	2019-12-04 15:09:14.169155
16adf8a0-16eb-11ea-8a37-97c47fb5fbdf	169ea38c-16eb-11ea-8a37-b799503ae436	16acac8e-16eb-11ea-8a37-73e8fbd7d57d	KICK	1	0	1	x	2019-12-04 15:09:14.184466	2019-12-04 15:09:14.184466
16b075da-16eb-11ea-8a37-f39bf5fb1ea9	169ea38c-16eb-11ea-8a37-b799503ae436	16af3c38-16eb-11ea-8a37-238b17b5b05d	KICK	1	0	1	x	2019-12-04 15:09:14.200851	2019-12-04 15:09:14.200851
16b2cbf0-16eb-11ea-8a37-cb27f6674c8c	169ea38c-16eb-11ea-8a37-b799503ae436	16b1a96e-16eb-11ea-8a37-a3a9ae29af1f	SNARE	0.8	0	0.3	x	2019-12-04 15:09:14.216141	2019-12-04 15:09:14.216141
16b52c2e-16eb-11ea-8a37-b7865a9f7f46	169ea38c-16eb-11ea-8a37-b799503ae436	16b3ee7c-16eb-11ea-8a37-1f13dbd92d5b	SNARE	1	0	1	x	2019-12-04 15:09:14.231647	2019-12-04 15:09:14.231647
16b73852-16eb-11ea-8a37-1744cffd4e6e	169ea38c-16eb-11ea-8a37-b799503ae436	16b648e8-16eb-11ea-8a37-dbcd5d82aa39	TOM	1	0	1	x	2019-12-04 15:09:14.245076	2019-12-04 15:09:14.245076
16b9061e-16eb-11ea-8a37-47408e8f1cc1	169ea38c-16eb-11ea-8a37-b799503ae436	16b835ae-16eb-11ea-8a37-afdfba72322e	KICK	1	0.02	0.5	X	2019-12-04 15:09:14.257006	2019-12-04 15:09:14.257006
16ba4bdc-16eb-11ea-8a37-8b257f1bcb99	169ea38c-16eb-11ea-8a37-b799503ae436	16b9acae-16eb-11ea-8a37-df16f0f4a46e	TOM	1	0	0.2	X	2019-12-04 15:09:14.265398	2019-12-04 15:09:14.265398
16bb85e2-16eb-11ea-8a37-2f371654765d	169ea38c-16eb-11ea-8a37-b799503ae436	16bae9ac-16eb-11ea-8a37-ab453bec7c1b	TOM	1	0	1	x	2019-12-04 15:09:14.273409	2019-12-04 15:09:14.273409
16bd5868-16eb-11ea-8a37-8f2ca7a6fa44	169ea38c-16eb-11ea-8a37-b799503ae436	16bc55da-16eb-11ea-8a37-e7fbb89ce282	KICK	1	0.03	0.5	X	2019-12-04 15:09:14.285417	2019-12-04 15:09:14.285417
16bf54b0-16eb-11ea-8a37-5f0c57ef73aa	169ea38c-16eb-11ea-8a37-b799503ae436	16be534e-16eb-11ea-8a37-076627260c8f	HIHAT	1	0.02	0.1	X	2019-12-04 15:09:14.298436	2019-12-04 15:09:14.298436
16c12182-16eb-11ea-8a37-2b1afea274dd	169ea38c-16eb-11ea-8a37-b799503ae436	16c04668-16eb-11ea-8a37-0f13f2262c74	CRASH	1	0	4	x	2019-12-04 15:09:14.310225	2019-12-04 15:09:14.310225
16c2e3b4-16eb-11ea-8a37-eb7f07c55663	169ea38c-16eb-11ea-8a37-b799503ae436	16c2034a-16eb-11ea-8a37-abb7bbb054d5	HIHATOPEN	1	0	1	x	2019-12-04 15:09:14.321753	2019-12-04 15:09:14.321753
16c44038-16eb-11ea-8a37-87a83cee0923	169ea38c-16eb-11ea-8a37-b799503ae436	16c3a092-16eb-11ea-8a37-138ccb32ff53	TOM	0.8	0	0.2	X	2019-12-04 15:09:14.330666	2019-12-04 15:09:14.330666
16c570de-16eb-11ea-8a37-e3c390f4b3a8	169ea38c-16eb-11ea-8a37-b799503ae436	16c4d9da-16eb-11ea-8a37-97c8fbb7614b	HIHATOPEN	0.8	0.01	0.015	X	2019-12-04 15:09:14.33846	2019-12-04 15:09:14.33846
16c6add2-16eb-11ea-8a37-ff73ab845987	169ea38c-16eb-11ea-8a37-b799503ae436	16c6103e-16eb-11ea-8a37-97f2821e4c94	SNARE	1	0	0.091	X	2019-12-04 15:09:14.34657	2019-12-04 15:09:14.34657
16c7f124-16eb-11ea-8a37-8772c75a894f	169ea38c-16eb-11ea-8a37-b799503ae436	16c74bd4-16eb-11ea-8a37-cb7a9fdec0a5	CRASH	1	0	4	x	2019-12-04 15:09:14.354812	2019-12-04 15:09:14.354812
16cd7a68-16eb-11ea-8a37-373b49afde7a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16cc4b66-16eb-11ea-8a37-4b1697a28533	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.391017	2019-12-04 15:09:14.391017
16cfbb16-16eb-11ea-8a37-ebbce4f747ed	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ce9c86-16eb-11ea-8a37-c35c78ce12f0	SNARE	1	0	1	F#8	2019-12-04 15:09:14.40579	2019-12-04 15:09:14.40579
16d1dc34-16eb-11ea-8a37-f79830b0807a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d0dd8e-16eb-11ea-8a37-2315defb93c9	KICK	1	0	1	A2	2019-12-04 15:09:14.419712	2019-12-04 15:09:14.419712
16d38bb0-16eb-11ea-8a37-63b2c0d5c5e2	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d2b49c-16eb-11ea-8a37-5bd09f91e5c8	SNARE	1	0	1	D#3	2019-12-04 15:09:14.430789	2019-12-04 15:09:14.430789
16d52e98-16eb-11ea-8a37-874c99053707	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d45eb4-16eb-11ea-8a37-67c9ec216602	SNARE	1	0	1	C#5	2019-12-04 15:09:14.441444	2019-12-04 15:09:14.441444
16d6d428-16eb-11ea-8a37-8b9d738d5cde	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d605a2-16eb-11ea-8a37-370a0dbfafb0	KICK	1	0	1	B2	2019-12-04 15:09:14.452278	2019-12-04 15:09:14.452278
16d8aef6-16eb-11ea-8a37-8b162ec5935d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d7a1f0-16eb-11ea-8a37-173fc900381e	SNARE	1	0	1	C#5	2019-12-04 15:09:14.464452	2019-12-04 15:09:14.464452
16db35cc-16eb-11ea-8a37-f711224e1b04	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16d9f400-16eb-11ea-8a37-d7c717848a60	SNARE	1	0	1	B7	2019-12-04 15:09:14.481001	2019-12-04 15:09:14.481001
16ddb8f6-16eb-11ea-8a37-e3fe388ee33d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16dc81f2-16eb-11ea-8a37-efc951bd428d	KICK	1	0	1	X	2019-12-04 15:09:14.497418	2019-12-04 15:09:14.497418
16dffe18-16eb-11ea-8a37-bbbeac2a40d8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ded5ec-16eb-11ea-8a37-937dc4935cda	KICK	1	0	1	F#8	2019-12-04 15:09:14.512334	2019-12-04 15:09:14.512334
16e21a04-16eb-11ea-8a37-07f42de56443	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16e12126-16eb-11ea-8a37-7faf1faaf2ce	KICK	1	0	1	F#2	2019-12-04 15:09:14.526135	2019-12-04 15:09:14.526135
16e3c2dc-16eb-11ea-8a37-6fdb5becdcb5	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16e2ece0-16eb-11ea-8a37-3feaca6d437e	SNARE	1	0	1	C4	2019-12-04 15:09:14.537038	2019-12-04 15:09:14.537038
16e56d62-16eb-11ea-8a37-c396bca0b177	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16e49ed2-16eb-11ea-8a37-8b0aa900b1a8	TOM	1	0	1	A7	2019-12-04 15:09:14.547962	2019-12-04 15:09:14.547962
16e70f50-16eb-11ea-8a37-678d9a98c281	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16e63d96-16eb-11ea-8a37-4fe6762a27aa	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.558666	2019-12-04 15:09:14.558666
16e8e76c-16eb-11ea-8a37-1b6a2a4b6ef6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16e7db88-16eb-11ea-8a37-8b904fa2944a	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.570739	2019-12-04 15:09:14.570739
16eb7db0-16eb-11ea-8a37-a39bc440aa04	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ea35fe-16eb-11ea-8a37-8358b5abce41	SNARE	1	0	1	F#7	2019-12-04 15:09:14.587692	2019-12-04 15:09:14.587692
16edf072-16eb-11ea-8a37-37773ce69303	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ecbe64-16eb-11ea-8a37-131c3887a491	HIHAT	1	0	1	D8	2019-12-04 15:09:14.603741	2019-12-04 15:09:14.603741
16f041d8-16eb-11ea-8a37-53f5394b0b18	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ef154c-16eb-11ea-8a37-c7db8b252c64	KICK	1	0	1	A2	2019-12-04 15:09:14.618926	2019-12-04 15:09:14.618926
16f263a0-16eb-11ea-8a37-8f0059615797	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16f16a54-16eb-11ea-8a37-fba7a60f8fb4	HIHAT	1	0	1	G#3	2019-12-04 15:09:14.632914	2019-12-04 15:09:14.632914
16f40656-16eb-11ea-8a37-af0dd3457c34	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16f338c0-16eb-11ea-8a37-aba175a6cacb	HIHAT	1	0	1	A4	2019-12-04 15:09:14.643634	2019-12-04 15:09:14.643634
16f5a664-16eb-11ea-8a37-2f1e23dc3aed	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16f4d694-16eb-11ea-8a37-4f02cfada858	CRASH	1	0	1	B7	2019-12-04 15:09:14.654284	2019-12-04 15:09:14.654284
16f73dc6-16eb-11ea-8a37-bff0149c2475	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16f673fa-16eb-11ea-8a37-5f8243fdcc72	KICK	1	0	1	G#2	2019-12-04 15:09:14.664726	2019-12-04 15:09:14.664726
16f90d90-16eb-11ea-8a37-37e5701339b1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16f80706-16eb-11ea-8a37-d73b0b0b519c	KICK	1	0	1	A#2	2019-12-04 15:09:14.676582	2019-12-04 15:09:14.676582
16fb9416-16eb-11ea-8a37-b31ef86844b4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16fa5434-16eb-11ea-8a37-b740160f0966	HIHAT	1	0	1	A8	2019-12-04 15:09:14.693086	2019-12-04 15:09:14.693086
16fe2c6c-16eb-11ea-8a37-bf1195c0f0c9	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16fceb54-16eb-11ea-8a37-37c32493847d	SNARE	1	0	1	F#8	2019-12-04 15:09:14.710076	2019-12-04 15:09:14.710076
17009b3c-16eb-11ea-8a37-57d880ba3f2a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	16ff7658-16eb-11ea-8a37-03fc81a76c8a	SNARE	1	0	1	A#7	2019-12-04 15:09:14.726134	2019-12-04 15:09:14.726134
17024748-16eb-11ea-8a37-3b25e24578c6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17019df2-16eb-11ea-8a37-77f20be440d1	SNARE	1	0	1	B2	2019-12-04 15:09:14.737139	2019-12-04 15:09:14.737139
17039008-16eb-11ea-8a37-c72fe0039574	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1702e8ce-16eb-11ea-8a37-6791a4ebb2e1	KICK	1	0	1	B1	2019-12-04 15:09:14.745513	2019-12-04 15:09:14.745513
1704c28e-16eb-11ea-8a37-57cded9ef9e2	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17042d10-16eb-11ea-8a37-c3871e94a9d1	KICK	1	0	1	A#2	2019-12-04 15:09:14.753422	2019-12-04 15:09:14.753422
1705e77c-16eb-11ea-8a37-07909704d439	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1705573a-16eb-11ea-8a37-5bf2fa79ce0e	KICK	1	0	1	F#2	2019-12-04 15:09:14.760924	2019-12-04 15:09:14.760924
17077056-16eb-11ea-8a37-9bba0b369d60	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17067750-16eb-11ea-8a37-43824be791f8	SNARE	1	0	1	F#3	2019-12-04 15:09:14.770981	2019-12-04 15:09:14.770981
170964d8-16eb-11ea-8a37-23f70e14ec3a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1708688a-16eb-11ea-8a37-c3866755f1a9	SNARE	1	0	1	D3	2019-12-04 15:09:14.783811	2019-12-04 15:09:14.783811
170b3dda-16eb-11ea-8a37-e356cf0b873a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	170a5c94-16eb-11ea-8a37-a362dcfd9611	KICK	1	0	1	D9	2019-12-04 15:09:14.795929	2019-12-04 15:09:14.795929
170d0796-16eb-11ea-8a37-ab12f28653ac	16c8d008-16eb-11ea-8a37-dbdfe140dd35	170c231c-16eb-11ea-8a37-6fbe620dfdc4	HIHAT	1	0	1	A8	2019-12-04 15:09:14.807652	2019-12-04 15:09:14.807652
170ef416-16eb-11ea-8a37-1fe930169c24	16c8d008-16eb-11ea-8a37-dbdfe140dd35	170e25a4-16eb-11ea-8a37-4be9704d11d1	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.820122	2019-12-04 15:09:14.820122
1710a6f8-16eb-11ea-8a37-4fec96cf7ea8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	170fca9e-16eb-11ea-8a37-9f63591bfc6a	HIHAT	1	0	1	A8	2019-12-04 15:09:14.831242	2019-12-04 15:09:14.831242
17124e9a-16eb-11ea-8a37-3fad2054a5db	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171177cc-16eb-11ea-8a37-2bf9e883c3a7	KICK	1	0	1	F#2	2019-12-04 15:09:14.842064	2019-12-04 15:09:14.842064
1713ef34-16eb-11ea-8a37-43821d8acaf8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171322e8-16eb-11ea-8a37-7ba2a251c8f0	HIHAT	1	0	1	D8	2019-12-04 15:09:14.852741	2019-12-04 15:09:14.852741
1715b152-16eb-11ea-8a37-cfcf02fa35ef	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1714a35c-16eb-11ea-8a37-476febb2e1c1	KICK	1	0	1	F#2	2019-12-04 15:09:14.864382	2019-12-04 15:09:14.864382
1717be0c-16eb-11ea-8a37-b7e02cee0030	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1716b610-16eb-11ea-8a37-0b6b573a0df9	SNARE	1	0	1	A8	2019-12-04 15:09:14.877816	2019-12-04 15:09:14.877816
171991dc-16eb-11ea-8a37-fb0067ad43d1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1718b8fc-16eb-11ea-8a37-c3b1b04e4750	HIHAT	1	0	1	D8	2019-12-04 15:09:14.889815	2019-12-04 15:09:14.889815
171b5490-16eb-11ea-8a37-cb94e0feb468	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171a707a-16eb-11ea-8a37-3b3b3adcbfb0	HIHAT	1	0	1	B5	2019-12-04 15:09:14.901351	2019-12-04 15:09:14.901351
171d1758-16eb-11ea-8a37-33533d6015b5	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171c492c-16eb-11ea-8a37-2f2df121741e	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.912763	2019-12-04 15:09:14.912763
171ec2a6-16eb-11ea-8a37-bf434c665899	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171df330-16eb-11ea-8a37-cfe7b347727b	KICK	1	0	1	D#2	2019-12-04 15:09:14.923701	2019-12-04 15:09:14.923701
1720639a-16eb-11ea-8a37-eb0edbc447a6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	171f8fa6-16eb-11ea-8a37-6bf293c14f95	HIHAT	1	0	1	F#9	2019-12-04 15:09:14.934369	2019-12-04 15:09:14.934369
1721cb54-16eb-11ea-8a37-5ff0de75888e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1721235c-16eb-11ea-8a37-ffee47a7a3b9	HIHAT	1	0	4	X	2019-12-04 15:09:14.943646	2019-12-04 15:09:14.943646
17237576-16eb-11ea-8a37-0b6b7825a274	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17226e88-16eb-11ea-8a37-9b5282c31ef9	SNARE	1	0	1	D#5	2019-12-04 15:09:14.954599	2019-12-04 15:09:14.954599
17257592-16eb-11ea-8a37-ef38af652a19	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17247804-16eb-11ea-8a37-ffb0c93eb243	SNARE	1	0	1	F7	2019-12-04 15:09:14.967738	2019-12-04 15:09:14.967738
17274ed0-16eb-11ea-8a37-fb5cb3249223	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17266b64-16eb-11ea-8a37-dbcb074964e6	KICK	1	0	1	A#2	2019-12-04 15:09:14.97985	2019-12-04 15:09:14.97985
17291648-16eb-11ea-8a37-f7c86b80d15b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	172830b6-16eb-11ea-8a37-03b48d251458	HIHAT	1	0	1	D8	2019-12-04 15:09:14.991496	2019-12-04 15:09:14.991496
172aa3a0-16eb-11ea-8a37-c7984f93f986	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1729fdce-16eb-11ea-8a37-9704f6d1b08d	KICK	1	0	1	C3	2019-12-04 15:09:15.001593	2019-12-04 15:09:15.001593
172c0b00-16eb-11ea-8a37-170b6f4b238c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	172b5318-16eb-11ea-8a37-97000d91b271	SNARE	1	0	1	F#7	2019-12-04 15:09:15.01077	2019-12-04 15:09:15.01077
172d9330-16eb-11ea-8a37-17492e721939	16c8d008-16eb-11ea-8a37-dbdfe140dd35	172cd300-16eb-11ea-8a37-176d480b9773	KICK	1	0	1	G#2	2019-12-04 15:09:15.020817	2019-12-04 15:09:15.020817
172f0b34-16eb-11ea-8a37-07a67a17d528	16c8d008-16eb-11ea-8a37-dbdfe140dd35	172e51bc-16eb-11ea-8a37-b33b08aab0ce	HIHAT	1	0	1	F#8	2019-12-04 15:09:15.030443	2019-12-04 15:09:15.030443
1730bf24-16eb-11ea-8a37-bb5148deb1eb	16c8d008-16eb-11ea-8a37-dbdfe140dd35	172fb76e-16eb-11ea-8a37-bbd10e0c7ef3	TOM	1	0	1	G6	2019-12-04 15:09:15.04165	2019-12-04 15:09:15.04165
1732cc74-16eb-11ea-8a37-4bbab09df563	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1731c9b4-16eb-11ea-8a37-d712f55d8acd	SNARE	1	0	1	G7	2019-12-04 15:09:15.055139	2019-12-04 15:09:15.055139
1734a2e2-16eb-11ea-8a37-73d44cbbbef1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1733c728-16eb-11ea-8a37-d38eb7ce7d14	KICK	1	0	1	A2	2019-12-04 15:09:15.067176	2019-12-04 15:09:15.067176
17365af6-16eb-11ea-8a37-aba73ba35fdd	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17357c44-16eb-11ea-8a37-8f4ee33a5252	SNARE	1	0	1	B7	2019-12-04 15:09:15.078444	2019-12-04 15:09:15.078444
1737c09e-16eb-11ea-8a37-67ec5722e14e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17373700-16eb-11ea-8a37-0ff869bedf70	SNARE	1	0	1	C#5	2019-12-04 15:09:15.087621	2019-12-04 15:09:15.087621
1738dad8-16eb-11ea-8a37-977d813762b6	16c8d008-16eb-11ea-8a37-dbdfe140dd35	173850ae-16eb-11ea-8a37-5f4b0cb4a2c6	KICK	1	0	1	A2	2019-12-04 15:09:15.094858	2019-12-04 15:09:15.094858
1739ee00-16eb-11ea-8a37-3782382a905c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1739666a-16eb-11ea-8a37-db6a04e6eb49	SNARE	1	0	1	B4	2019-12-04 15:09:15.101892	2019-12-04 15:09:15.101892
173af5c0-16eb-11ea-8a37-cb5e4d4431ad	16c8d008-16eb-11ea-8a37-dbdfe140dd35	173a7212-16eb-11ea-8a37-0fe3977ac034	HIHAT	1	0	1	F#9	2019-12-04 15:09:15.108647	2019-12-04 15:09:15.108647
173c7b20-16eb-11ea-8a37-57f3d5cfb86b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	173b8292-16eb-11ea-8a37-a3b2e5056d72	SNARE	1	0	1	B7	2019-12-04 15:09:15.118596	2019-12-04 15:09:15.118596
173e73b2-16eb-11ea-8a37-d3f5f52f22fa	16c8d008-16eb-11ea-8a37-dbdfe140dd35	173d7804-16eb-11ea-8a37-53fbc8de019f	SNARE	1	0	1	D#5	2019-12-04 15:09:15.131525	2019-12-04 15:09:15.131525
17404fd4-16eb-11ea-8a37-cbdc0b175c11	16c8d008-16eb-11ea-8a37-dbdfe140dd35	173f72bc-16eb-11ea-8a37-778a9a39437f	CRASH	1	0	1	Eb6	2019-12-04 15:09:15.143715	2019-12-04 15:09:15.143715
17420522-16eb-11ea-8a37-2f857452f4be	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17412c38-16eb-11ea-8a37-77fa053e75bf	HIHAT	1	0	1	A8	2019-12-04 15:09:15.154902	2019-12-04 15:09:15.154902
17437650-16eb-11ea-8a37-43b2bf399dd0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1742e636-16eb-11ea-8a37-a3cfb96a0dd4	SNARE	1	0	1	D8	2019-12-04 15:09:15.164356	2019-12-04 15:09:15.164356
17449454-16eb-11ea-8a37-8f944b05fa58	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17440336-16eb-11ea-8a37-d3f1544ce517	HIHAT	1	0	1	C#5	2019-12-04 15:09:15.171683	2019-12-04 15:09:15.171683
1745b834-16eb-11ea-8a37-6f8eb406b7d8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1745261c-16eb-11ea-8a37-bf91b2cfefe0	HIHAT	1	0	1	A8	2019-12-04 15:09:15.179146	2019-12-04 15:09:15.179146
1746d070-16eb-11ea-8a37-a7c9b6043a29	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17464402-16eb-11ea-8a37-2b092870d0e1	HIHAT	1	0	1	F#8	2019-12-04 15:09:15.186328	2019-12-04 15:09:15.186328
174852ec-16eb-11ea-8a37-5bcf54f72cc4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1747593c-16eb-11ea-8a37-cfccd47ce162	SNARE	1	0	1	F#2	2019-12-04 15:09:15.196218	2019-12-04 15:09:15.196218
174a575e-16eb-11ea-8a37-cf30a3d6d6a1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	174955e8-16eb-11ea-8a37-3f913847de79	TOM	1	0	1	Eb5	2019-12-04 15:09:15.209439	2019-12-04 15:09:15.209439
174c455a-16eb-11ea-8a37-375e04604a46	16c8d008-16eb-11ea-8a37-dbdfe140dd35	174b66c6-16eb-11ea-8a37-a385e4477c0f	SNARE	1	0	1	F4	2019-12-04 15:09:15.222091	2019-12-04 15:09:15.222091
174e175e-16eb-11ea-8a37-1f9b53d0bad1	16c8d008-16eb-11ea-8a37-dbdfe140dd35	174d2344-16eb-11ea-8a37-0b5d87ff7d30	SNARE	1	0	1	C#8	2019-12-04 15:09:15.233953	2019-12-04 15:09:15.233953
174fd3aa-16eb-11ea-8a37-63dfd27d5c51	16c8d008-16eb-11ea-8a37-dbdfe140dd35	174f223e-16eb-11ea-8a37-c37d6dfeff88	KICK	1	0	1	G#2	2019-12-04 15:09:15.245325	2019-12-04 15:09:15.245325
17514afa-16eb-11ea-8a37-eff0c00faa06	16c8d008-16eb-11ea-8a37-dbdfe140dd35	175090c4-16eb-11ea-8a37-eb6d5dd7d84c	SNARE	1	0	1	B8	2019-12-04 15:09:15.254948	2019-12-04 15:09:15.254948
1752db90-16eb-11ea-8a37-f7d1f8756e18	16c8d008-16eb-11ea-8a37-dbdfe140dd35	175212e6-16eb-11ea-8a37-83a6dfcff358	KICK	1	0	1	C#2	2019-12-04 15:09:15.265147	2019-12-04 15:09:15.265147
175472e8-16eb-11ea-8a37-b3a3881e3135	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1753a96c-16eb-11ea-8a37-6b98160e243f	SNARE	1	0	1	F7	2019-12-04 15:09:15.27557	2019-12-04 15:09:15.27557
175677a0-16eb-11ea-8a37-2bd04678946f	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17553d22-16eb-11ea-8a37-9bed9a964f75	SNARE	1	0	1	Eb4	2019-12-04 15:09:15.288791	2019-12-04 15:09:15.288791
1758ee54-16eb-11ea-8a37-f3a6523b3a91	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1757b2dc-16eb-11ea-8a37-a7a501e0201d	SNARE	1	0	1	C#3	2019-12-04 15:09:15.304938	2019-12-04 15:09:15.304938
175b4640-16eb-11ea-8a37-e7aa55b93625	16c8d008-16eb-11ea-8a37-dbdfe140dd35	175a2b8e-16eb-11ea-8a37-e33ca0f53036	HIHAT	1	0	1	F#9	2019-12-04 15:09:15.320285	2019-12-04 15:09:15.320285
175d782a-16eb-11ea-8a37-bb1f5ac7a21d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	175c5e04-16eb-11ea-8a37-cf9fae79204f	KICK	1	0	1	D#2	2019-12-04 15:09:15.334665	2019-12-04 15:09:15.334665
175f650e-16eb-11ea-8a37-1344c378f01e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	175e99bc-16eb-11ea-8a37-ff9920827e69	SNARE	1	0	1	A#3	2019-12-04 15:09:15.347289	2019-12-04 15:09:15.347289
1760fe00-16eb-11ea-8a37-ef7ce6d94eb8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176032e0-16eb-11ea-8a37-f70c8a3229f7	KICK	1	0	1	A2	2019-12-04 15:09:15.357765	2019-12-04 15:09:15.357765
17629008-16eb-11ea-8a37-3fe4fbff171d	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1761c9ca-16eb-11ea-8a37-bbc51a0fda8b	SNARE	1	0	1	F#8	2019-12-04 15:09:15.368044	2019-12-04 15:09:15.368044
17641d9c-16eb-11ea-8a37-13424912b9ad	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176355e2-16eb-11ea-8a37-d7e2046f8df5	KICK	1	0	1	F#2	2019-12-04 15:09:15.378198	2019-12-04 15:09:15.378198
17662c18-16eb-11ea-8a37-1beea9b2b279	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1764f65e-16eb-11ea-8a37-cfd11203ec96	SNARE	1	0	1	F3	2019-12-04 15:09:15.391711	2019-12-04 15:09:15.391711
1768a3e4-16eb-11ea-8a37-f7469b76eb3a	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176767ea-16eb-11ea-8a37-777a18c3566d	SNARE	1	0	1	A#2	2019-12-04 15:09:15.407872	2019-12-04 15:09:15.407872
176aa45a-16eb-11ea-8a37-43f640ea39d3	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1769bc2a-16eb-11ea-8a37-c3d93eddb619	KICK	1	0	1	A2	2019-12-04 15:09:15.421091	2019-12-04 15:09:15.421091
176c613c-16eb-11ea-8a37-8b58dfbc0de2	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176b82ee-16eb-11ea-8a37-f3c94d4ce59d	SNARE	1	0	1	A8	2019-12-04 15:09:15.43251	2019-12-04 15:09:15.43251
176dcb58-16eb-11ea-8a37-6b9a2d62608e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176d4066-16eb-11ea-8a37-f333086386f9	SNARE	1	0	1	A3	2019-12-04 15:09:15.441793	2019-12-04 15:09:15.441793
176edbf6-16eb-11ea-8a37-d7c75379c2c8	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176e54ba-16eb-11ea-8a37-27c97cb4f5f1	SNARE	1	0	1	D4	2019-12-04 15:09:15.448773	2019-12-04 15:09:15.448773
176fee06-16eb-11ea-8a37-5f4f51c59f8b	16c8d008-16eb-11ea-8a37-dbdfe140dd35	176f6846-16eb-11ea-8a37-87441a2951b3	HIHAT	1	0	1	F#9	2019-12-04 15:09:15.455787	2019-12-04 15:09:15.455787
177105fc-16eb-11ea-8a37-b7551c483e73	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177077a4-16eb-11ea-8a37-8bbf91abedeb	CRASH	1	0	2	F#6	2019-12-04 15:09:15.462932	2019-12-04 15:09:15.462932
17728ff8-16eb-11ea-8a37-ff236e846410	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17719576-16eb-11ea-8a37-bb3ce8aa938f	KICK	1	0	1	D#2	2019-12-04 15:09:15.473027	2019-12-04 15:09:15.473027
17749028-16eb-11ea-8a37-5756fc303c83	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177390b0-16eb-11ea-8a37-5720dd162498	SNARE	1	0	1	A3	2019-12-04 15:09:15.486138	2019-12-04 15:09:15.486138
1776689e-16eb-11ea-8a37-4f4bdb2b1f57	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17758d02-16eb-11ea-8a37-3f0478fa5f81	KICK	1	0	1	A#2	2019-12-04 15:09:15.49824	2019-12-04 15:09:15.49824
177835a2-16eb-11ea-8a37-333c9e64fa16	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177746e2-16eb-11ea-8a37-0ba459658a94	KICK	1	0	1	X	2019-12-04 15:09:15.51002	2019-12-04 15:09:15.51002
1779a63a-16eb-11ea-8a37-3b1596d774a4	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17791e0e-16eb-11ea-8a37-8f4c512f8e5c	HIHAT	1	0	1	C5	2019-12-04 15:09:15.519488	2019-12-04 15:09:15.519488
177abac0-16eb-11ea-8a37-3bbc52d592ee	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177a31c2-16eb-11ea-8a37-f31aca6e9028	SNARE	1	0	1	D#6	2019-12-04 15:09:15.526572	2019-12-04 15:09:15.526572
177bdba8-16eb-11ea-8a37-b716002e88a0	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177b4bb6-16eb-11ea-8a37-83c1262c1e64	SNARE	1	0	1	B7	2019-12-04 15:09:15.533976	2019-12-04 15:09:15.533976
177cf7c2-16eb-11ea-8a37-e3011a288e90	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177c6744-16eb-11ea-8a37-9fd12e16c690	SNARE	1	0	1	Bb7	2019-12-04 15:09:15.541252	2019-12-04 15:09:15.541252
177e7bb0-16eb-11ea-8a37-af250fea884e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177d8390-16eb-11ea-8a37-7707411632a7	HIHAT	1	0	1	B8	2019-12-04 15:09:15.551168	2019-12-04 15:09:15.551168
17807280-16eb-11ea-8a37-e73de060ab86	16c8d008-16eb-11ea-8a37-dbdfe140dd35	177f7272-16eb-11ea-8a37-6b041ebbc0e1	SNARE	1	0	1	A8	2019-12-04 15:09:15.564046	2019-12-04 15:09:15.564046
17824d76-16eb-11ea-8a37-b729b3d8a4d3	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17816bc2-16eb-11ea-8a37-f74d2b35444d	HIHAT	1	0	1	B7	2019-12-04 15:09:15.576211	2019-12-04 15:09:15.576211
17841520-16eb-11ea-8a37-93aee247a654	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17832fe8-16eb-11ea-8a37-afcab36d93a3	HIHAT	1	0	1	B4	2019-12-04 15:09:15.587861	2019-12-04 15:09:15.587861
17857974-16eb-11ea-8a37-9fc1a327e94e	16c8d008-16eb-11ea-8a37-dbdfe140dd35	1784ef22-16eb-11ea-8a37-93ef1140774b	KICK	1	0	1	F#2	2019-12-04 15:09:15.596979	2019-12-04 15:09:15.596979
17869caa-16eb-11ea-8a37-575f4e63e379	16c8d008-16eb-11ea-8a37-dbdfe140dd35	17860b6e-16eb-11ea-8a37-1badfc0b9704	HIHAT	1	0	1	A8	2019-12-04 15:09:15.604414	2019-12-04 15:09:15.604414
17895db4-16eb-11ea-8a37-cb8a2a27ee01	1787297c-16eb-11ea-8a37-6f3014c0a6fc	1788cb7e-16eb-11ea-8a37-93b8ed705699	HIHATOPEN	1	0	1	D8	2019-12-04 15:09:15.622466	2019-12-04 15:09:15.622466
178b5e48-16eb-11ea-8a37-cb0cddea066c	1787297c-16eb-11ea-8a37-6f3014c0a6fc	178a5cb4-16eb-11ea-8a37-978e20eaa0aa	SNARE	1	0	1	G7	2019-12-04 15:09:15.635566	2019-12-04 15:09:15.635566
178d582e-16eb-11ea-8a37-af94e1165862	1787297c-16eb-11ea-8a37-6f3014c0a6fc	178c5bb8-16eb-11ea-8a37-479a03f5dc0c	SNARE	1	0	1	C#4	2019-12-04 15:09:15.648542	2019-12-04 15:09:15.648542
178f13da-16eb-11ea-8a37-ff0c128caed4	1787297c-16eb-11ea-8a37-6f3014c0a6fc	178e3834-16eb-11ea-8a37-23531a78fcfc	HIHAT	1	0	1	E5	2019-12-04 15:09:15.659901	2019-12-04 15:09:15.659901
1790d06c-16eb-11ea-8a37-3be58bea188b	1787297c-16eb-11ea-8a37-6f3014c0a6fc	178ff110-16eb-11ea-8a37-db2e215b492f	SNARE	1	0	1	C#3	2019-12-04 15:09:15.671286	2019-12-04 15:09:15.671286
1791f38e-16eb-11ea-8a37-cf19355a525a	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179162ac-16eb-11ea-8a37-eb0a6605bea3	KICK	1	0	1	B2	2019-12-04 15:09:15.678736	2019-12-04 15:09:15.678736
179308c8-16eb-11ea-8a37-8f9079b2fdad	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17927c00-16eb-11ea-8a37-5f081eed7504	CRASH	1	0	4	D#6	2019-12-04 15:09:15.685843	2019-12-04 15:09:15.685843
1794215e-16eb-11ea-8a37-1f7c644f9497	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179395fe-16eb-11ea-8a37-8f3d1b1a4dc9	KICK	1	0	1	F2	2019-12-04 15:09:15.693015	2019-12-04 15:09:15.693015
17953ae4-16eb-11ea-8a37-1f59295a6259	1787297c-16eb-11ea-8a37-6f3014c0a6fc	1794adb8-16eb-11ea-8a37-7f60bd989e82	SNARE	1	0	1	A6	2019-12-04 15:09:15.700221	2019-12-04 15:09:15.700221
17972fca-16eb-11ea-8a37-c309d83009f9	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179633cc-16eb-11ea-8a37-2f8500efa788	SNARE	1	0	1	D9	2019-12-04 15:09:15.713052	2019-12-04 15:09:15.713052
1799267c-16eb-11ea-8a37-8340c8e3cd2f	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17982d26-16eb-11ea-8a37-6376be08caa7	KICK	1	0	1	E2	2019-12-04 15:09:15.725921	2019-12-04 15:09:15.725921
179ade72-16eb-11ea-8a37-c774dda681d6	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179a0290-16eb-11ea-8a37-0bc647ec3e48	CRASH	1	0	4	D#5	2019-12-04 15:09:15.737207	2019-12-04 15:09:15.737207
179c9a50-16eb-11ea-8a37-832748f76f20	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179bbd56-16eb-11ea-8a37-5bd4b4150270	HIHAT	1	0	1	E8	2019-12-04 15:09:15.748551	2019-12-04 15:09:15.748551
179dbb24-16eb-11ea-8a37-ebf72220cca7	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179d2dc6-16eb-11ea-8a37-935ec99fc3a1	HIHAT	1	0	1	G4	2019-12-04 15:09:15.755949	2019-12-04 15:09:15.755949
179ecb5e-16eb-11ea-8a37-4f125cb7bf99	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179e4300-16eb-11ea-8a37-e357f52e9fd4	TOM	1	0	1	C3	2019-12-04 15:09:15.762924	2019-12-04 15:09:15.762924
17a02ecc-16eb-11ea-8a37-9b7daeea7a4d	1787297c-16eb-11ea-8a37-6f3014c0a6fc	179f597a-16eb-11ea-8a37-87431d9d615f	HIHATOPEN	1	0	1	D8	2019-12-04 15:09:15.7718	2019-12-04 15:09:15.7718
17a1ef96-16eb-11ea-8a37-c751f2f23dce	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17a10428-16eb-11ea-8a37-ebb88f127b99	TOM	1	0	1	E3	2019-12-04 15:09:15.783278	2019-12-04 15:09:15.783278
17a46226-16eb-11ea-8a37-27b25b7edbfd	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17a33ed2-16eb-11ea-8a37-57e50ce01f0c	SNARE	1	0	1	B8	2019-12-04 15:09:15.799464	2019-12-04 15:09:15.799464
17a67552-16eb-11ea-8a37-a3ba4fc27894	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17a572ba-16eb-11ea-8a37-dff759f23531	HIHAT	1	0	1	E8	2019-12-04 15:09:15.813114	2019-12-04 15:09:15.813114
17a839b4-16eb-11ea-8a37-bba0cdb2563a	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17a75c38-16eb-11ea-8a37-bb9dc349d98a	KICK	1	0	1	F2	2019-12-04 15:09:15.824712	2019-12-04 15:09:15.824712
17a9ef7a-16eb-11ea-8a37-37e89e07d476	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17a91262-16eb-11ea-8a37-ef3527050bff	TOM	1	0	1	A2	2019-12-04 15:09:15.835917	2019-12-04 15:09:15.835917
17ab064e-16eb-11ea-8a37-9f5321b6947f	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17aa78b4-16eb-11ea-8a37-9bce805b1155	KICK	1	0	1	B6	2019-12-04 15:09:15.843063	2019-12-04 15:09:15.843063
17ac25b0-16eb-11ea-8a37-5f4a73006f70	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17ab9636-16eb-11ea-8a37-0f592a76d9a3	SNARE	1	0	1	F#4	2019-12-04 15:09:15.850407	2019-12-04 15:09:15.850407
17ad3f36-16eb-11ea-8a37-f713ea439441	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17acb2fa-16eb-11ea-8a37-43a34265fcf8	SNARE	1	0	1	A3	2019-12-04 15:09:15.857584	2019-12-04 15:09:15.857584
17ae4c00-16eb-11ea-8a37-83022076feb6	1787297c-16eb-11ea-8a37-6f3014c0a6fc	17adcc94-16eb-11ea-8a37-c7a2aa079cd2	KICK	1	0	1	F#2	2019-12-04 15:09:15.864522	2019-12-04 15:09:15.864522
17b13f32-16eb-11ea-8a37-df1b02d305ad	17af4286-16eb-11ea-8a37-7f9963e0dfa2	17b03f9c-16eb-11ea-8a37-2f6402fb8909	SNARE	1	0	1	D5	2019-12-04 15:09:15.883826	2019-12-04 15:09:15.883826
17b51080-16eb-11ea-8a37-4f96178f8333	17b34ca0-16eb-11ea-8a37-6b86e3816409	17b4323c-16eb-11ea-8a37-03d379e3e10b	KICK	1	0	1	E9	2019-12-04 15:09:15.908856	2019-12-04 15:09:15.908856
17b6d028-16eb-11ea-8a37-ebffd672db32	17b34ca0-16eb-11ea-8a37-6b86e3816409	17b5f040-16eb-11ea-8a37-87b7743c2341	KICK	1	0	1	E9	2019-12-04 15:09:15.920311	2019-12-04 15:09:15.920311
17b7e850-16eb-11ea-8a37-7ff5bac740dd	17b34ca0-16eb-11ea-8a37-6b86e3816409	17b75c64-16eb-11ea-8a37-87dee6c24b2c	TOMMID	1	0	1	D5	2019-12-04 15:09:15.927493	2019-12-04 15:09:15.927493
17b93872-16eb-11ea-8a37-47e3c3738501	17b34ca0-16eb-11ea-8a37-6b86e3816409	17b892c8-16eb-11ea-8a37-ef89e7400133	CRASH	1	0	4	C#6	2019-12-04 15:09:15.936034	2019-12-04 15:09:15.936034
17ba775a-16eb-11ea-8a37-3363a6fa245b	17b34ca0-16eb-11ea-8a37-6b86e3816409	17b9dd0e-16eb-11ea-8a37-1fea83405dd4	SNARE	1	0	1	B3	2019-12-04 15:09:15.944231	2019-12-04 15:09:15.944231
17bbb390-16eb-11ea-8a37-abbd9a5504a9	17b34ca0-16eb-11ea-8a37-6b86e3816409	17bb1872-16eb-11ea-8a37-6b94466ed28a	TOMHI	1	0	1	Eb5	2019-12-04 15:09:15.952296	2019-12-04 15:09:15.952296
17bdc810-16eb-11ea-8a37-b7b12c98d58e	17b34ca0-16eb-11ea-8a37-6b86e3816409	17bcbc0e-16eb-11ea-8a37-ab01e41a42fc	TOMLOW	1	0	1	B2	2019-12-04 15:09:15.965926	2019-12-04 15:09:15.965926
17bfeeb0-16eb-11ea-8a37-b35b716b2da2	17b34ca0-16eb-11ea-8a37-6b86e3816409	17bed494-16eb-11ea-8a37-f3ceeb7a542d	SNARE	1	0	1	Ab2	2019-12-04 15:09:15.979987	2019-12-04 15:09:15.979987
17c22252-16eb-11ea-8a37-3707a271cf9e	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c10566-16eb-11ea-8a37-c35d1325da8b	TOMMID	1	0	1	F#3	2019-12-04 15:09:15.994382	2019-12-04 15:09:15.994382
17c47854-16eb-11ea-8a37-e7bb01a148f1	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c35168-16eb-11ea-8a37-030c81dc176e	SNARE	1	0	1	F8	2019-12-04 15:09:16.009675	2019-12-04 15:09:16.009675
17c5611a-16eb-11ea-8a37-7ff68744d3a0	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c35168-16eb-11ea-8a37-030c81dc176e	SNARE	1	0	1	F8	2019-12-04 15:09:16.015627	2019-12-04 15:09:16.015627
17c71122-16eb-11ea-8a37-5b0114c2d8f7	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c63cde-16eb-11ea-8a37-cf1da03474aa	KICK	1	0	1	E9	2019-12-04 15:09:16.026651	2019-12-04 15:09:16.026651
17c88aca-16eb-11ea-8a37-437dabe51f81	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c7dc24-16eb-11ea-8a37-d772101739bb	HIHATOPEN	1	0	1	F7	2019-12-04 15:09:16.036398	2019-12-04 15:09:16.036398
17c9ccfa-16eb-11ea-8a37-3b07b1c9699d	17b34ca0-16eb-11ea-8a37-6b86e3816409	17c92f84-16eb-11ea-8a37-7fb3480e9790	HIHATCLOSED	1	0	1	B8	2019-12-04 15:09:16.044705	2019-12-04 15:09:16.044705
17cb7168-16eb-11ea-8a37-676459225ef8	17b34ca0-16eb-11ea-8a37-6b86e3816409	17ca6aca-16eb-11ea-8a37-538f4de9cd61	TOMHI	1	0	1	G5	2019-12-04 15:09:16.055503	2019-12-04 15:09:16.055503
17cd6d38-16eb-11ea-8a37-a359acdd2fa3	17b34ca0-16eb-11ea-8a37-6b86e3816409	17cc73a6-16eb-11ea-8a37-57ecfc36022c	SNARE	1	0	1	B5	2019-12-04 15:09:16.068509	2019-12-04 15:09:16.068509
17cf60fc-16eb-11ea-8a37-9f1efb50eb3b	17b34ca0-16eb-11ea-8a37-6b86e3816409	17ce5db0-16eb-11ea-8a37-dbe5fda57766	SNARE	1	0	1	B3	2019-12-04 15:09:16.081226	2019-12-04 15:09:16.081226
17d17856-16eb-11ea-8a37-e34092b5c4b3	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d064b6-16eb-11ea-8a37-9f09e0179b6f	KICK	1	0	1	E9	2019-12-04 15:09:16.094904	2019-12-04 15:09:16.094904
17d36eb8-16eb-11ea-8a37-dba825451692	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d29a24-16eb-11ea-8a37-130bfa446871	HIHATCLOSED	1	0	1	D7	2019-12-04 15:09:16.107766	2019-12-04 15:09:16.107766
17d52bae-16eb-11ea-8a37-dfcc5b30c126	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d44f04-16eb-11ea-8a37-bb03de076008	SNARE	1	0	1	F#8	2019-12-04 15:09:16.119157	2019-12-04 15:09:16.119157
17d6c81a-16eb-11ea-8a37-9709f8a33543	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d602fe-16eb-11ea-8a37-a3d42762c3f9	TOMMID	1	0	1	D#4	2019-12-04 15:09:16.129699	2019-12-04 15:09:16.129699
17d86422-16eb-11ea-8a37-a3788e322450	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d79470-16eb-11ea-8a37-87bde0ef00a2	HIHATCLOSED	1	0	1	Eb7	2019-12-04 15:09:16.140214	2019-12-04 15:09:16.140214
17da84f0-16eb-11ea-8a37-37d764a15fd2	17b34ca0-16eb-11ea-8a37-6b86e3816409	17d93e9c-16eb-11ea-8a37-8b0783be039e	TOMHI	1	0	1	Eb5	2019-12-04 15:09:16.154182	2019-12-04 15:09:16.154182
17dd022a-16eb-11ea-8a37-d32a656bfcfc	17b34ca0-16eb-11ea-8a37-6b86e3816409	17dbc860-16eb-11ea-8a37-5f5cb584fc6c	SNARE	1	0	1	E6	2019-12-04 15:09:16.17048	2019-12-04 15:09:16.17048
17df40d0-16eb-11ea-8a37-afea3853efa7	17b34ca0-16eb-11ea-8a37-6b86e3816409	17de4306-16eb-11ea-8a37-f33d41d55478	KICK	1	0	1	D2	2019-12-04 15:09:16.185299	2019-12-04 15:09:16.185299
17e12f12-16eb-11ea-8a37-d3f45d25e00e	17b34ca0-16eb-11ea-8a37-6b86e3816409	17e03d3c-16eb-11ea-8a37-c3394c3f5fa5	HIHATOPEN	1	0	1	D8	2019-12-04 15:09:16.197955	2019-12-04 15:09:16.197955
17e2b904-16eb-11ea-8a37-a386989b1761	17b34ca0-16eb-11ea-8a37-6b86e3816409	17e21e4a-16eb-11ea-8a37-efc901c1178c	HIHATCLOSED	1	0	1	Eb7	2019-12-04 15:09:16.208052	2019-12-04 15:09:16.208052
17e44224-16eb-11ea-8a37-83f4e09db62d	17b34ca0-16eb-11ea-8a37-6b86e3816409	17e37952-16eb-11ea-8a37-d39722108c1a	TOMMID	1	0	1	Ab4	2019-12-04 15:09:16.218024	2019-12-04 15:09:16.218024
17ebc238-16eb-11ea-8a37-03a099fff224	17e50f74-16eb-11ea-8a37-e3561e92fad1	17ea4fc0-16eb-11ea-8a37-3f1406b853f5	TOM	1	0	1	X	2019-12-04 15:09:16.267118	2019-12-04 15:09:16.267118
17ee3d92-16eb-11ea-8a37-3b20ac9c7be7	17e50f74-16eb-11ea-8a37-e3561e92fad1	17ed0d8c-16eb-11ea-8a37-af44db6912b1	TOM	1	0	1	X	2019-12-04 15:09:16.283346	2019-12-04 15:09:16.283346
17f30336-16eb-11ea-8a37-6335b1ba087b	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f20c24-16eb-11ea-8a37-474d050b40ac	SNARE	1	0	1	X	2019-12-04 15:09:16.314803	2019-12-04 15:09:16.314803
17f48436-16eb-11ea-8a37-e3144a34180f	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f3eed6-16eb-11ea-8a37-0b4ab0525ab1	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.324682	2019-12-04 15:09:16.324682
17f5a122-16eb-11ea-8a37-bba0d3d3f099	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f51266-16eb-11ea-8a37-c35a3a34d43f	TOM	1	0	1	X	2019-12-04 15:09:16.331981	2019-12-04 15:09:16.331981
17f6b224-16eb-11ea-8a37-ff205b755f8b	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f62d40-16eb-11ea-8a37-53a3a5fbfe65	TOM	1	0	1	X	2019-12-04 15:09:16.338973	2019-12-04 15:09:16.338973
17f7c65a-16eb-11ea-8a37-f7181dcb8738	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f73d3e-16eb-11ea-8a37-876dc1c8238e	TOM	1	0	1	X	2019-12-04 15:09:16.346053	2019-12-04 15:09:16.346053
17f94b92-16eb-11ea-8a37-13625f63ed69	17e50f74-16eb-11ea-8a37-e3561e92fad1	17f8553e-16eb-11ea-8a37-77efd3f331c9	KICK	2	0	1	x	2019-12-04 15:09:16.356024	2019-12-04 15:09:16.356024
17fb361e-16eb-11ea-8a37-33d632fb5bfb	17e50f74-16eb-11ea-8a37-e3561e92fad1	17fa4308-16eb-11ea-8a37-37db27d657fb	SNARE	1	0	1	X	2019-12-04 15:09:16.3686	2019-12-04 15:09:16.3686
17fd377a-16eb-11ea-8a37-e3656b472bda	17e50f74-16eb-11ea-8a37-e3561e92fad1	17fc274a-16eb-11ea-8a37-bfb7fbf0c548	HIHAT	1	0	1	X	2019-12-04 15:09:16.381486	2019-12-04 15:09:16.381486
17ff736e-16eb-11ea-8a37-4384df57baac	17e50f74-16eb-11ea-8a37-e3561e92fad1	17fe5916-16eb-11ea-8a37-2f401c09459b	TOM	1	0	1	X	2019-12-04 15:09:16.396222	2019-12-04 15:09:16.396222
1801538c-16eb-11ea-8a37-bb1d19ffeebc	17e50f74-16eb-11ea-8a37-e3561e92fad1	180090b4-16eb-11ea-8a37-fb1b8401733a	SNARE	1	0	1	X	2019-12-04 15:09:16.408534	2019-12-04 15:09:16.408534
1802e6ac-16eb-11ea-8a37-5339992a1513	17e50f74-16eb-11ea-8a37-e3561e92fad1	18021e48-16eb-11ea-8a37-939f50e59431	TOM	1	0	1	X	2019-12-04 15:09:16.418837	2019-12-04 15:09:16.418837
18047882-16eb-11ea-8a37-c7b336f446b1	17e50f74-16eb-11ea-8a37-e3561e92fad1	1803b564-16eb-11ea-8a37-a7f2106340c1	SNARE	1	0	1	X	2019-12-04 15:09:16.429141	2019-12-04 15:09:16.429141
18063190-16eb-11ea-8a37-3b2c99500164	17e50f74-16eb-11ea-8a37-e3561e92fad1	1805557c-16eb-11ea-8a37-ab970761d266	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.440386	2019-12-04 15:09:16.440386
1808461a-16eb-11ea-8a37-5ba2b34d72a7	17e50f74-16eb-11ea-8a37-e3561e92fad1	18071a56-16eb-11ea-8a37-870a00c5ecaf	TOM	1	0	1	X	2019-12-04 15:09:16.454118	2019-12-04 15:09:16.454118
180a64f4-16eb-11ea-8a37-7be9e19f9866	17e50f74-16eb-11ea-8a37-e3561e92fad1	18095b18-16eb-11ea-8a37-7f96259b023c	TOM	1	0	1	X	2019-12-04 15:09:16.468039	2019-12-04 15:09:16.468039
180cb74a-16eb-11ea-8a37-674a68f5d6a4	17e50f74-16eb-11ea-8a37-e3561e92fad1	180b8b40-16eb-11ea-8a37-17e7f846189f	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.483088	2019-12-04 15:09:16.483088
180f2b06-16eb-11ea-8a37-a78dbc602ee6	17e50f74-16eb-11ea-8a37-e3561e92fad1	180df9f2-16eb-11ea-8a37-67c5e6ceb956	TOM	1	0	1	X	2019-12-04 15:09:16.49926	2019-12-04 15:09:16.49926
1810c7ea-16eb-11ea-8a37-8ffc2069438b	17e50f74-16eb-11ea-8a37-e3561e92fad1	181027b8-16eb-11ea-8a37-4fdff362d2c5	HIHAT	1	0	1	X	2019-12-04 15:09:16.509901	2019-12-04 15:09:16.509901
1812007e-16eb-11ea-8a37-efae678b43df	17e50f74-16eb-11ea-8a37-e3561e92fad1	181168e4-16eb-11ea-8a37-93bf6ccfd3b3	SNARE	1	0	1	X	2019-12-04 15:09:16.517905	2019-12-04 15:09:16.517905
1813235a-16eb-11ea-8a37-7bfcfcbf2295	17e50f74-16eb-11ea-8a37-e3561e92fad1	18129944-16eb-11ea-8a37-e757462dd86d	KICK	1	0	1	X	2019-12-04 15:09:16.525343	2019-12-04 15:09:16.525343
1814322c-16eb-11ea-8a37-db9911ea3305	17e50f74-16eb-11ea-8a37-e3561e92fad1	1813abcc-16eb-11ea-8a37-e363c13561a2	TOM	1	0	1	X	2019-12-04 15:09:16.532323	2019-12-04 15:09:16.532323
1815a08a-16eb-11ea-8a37-4b9843454485	17e50f74-16eb-11ea-8a37-e3561e92fad1	1814b12a-16eb-11ea-8a37-dfd97f3f1d1d	TOM	1	0	1	X	2019-12-04 15:09:16.541706	2019-12-04 15:09:16.541706
18178a12-16eb-11ea-8a37-f37c4beb6ceb	17e50f74-16eb-11ea-8a37-e3561e92fad1	18169274-16eb-11ea-8a37-033088a41f2f	HIHAT	1	0	1	X	2019-12-04 15:09:16.554241	2019-12-04 15:09:16.554241
181967d8-16eb-11ea-8a37-5b6a2683f6e0	17e50f74-16eb-11ea-8a37-e3561e92fad1	181886ba-16eb-11ea-8a37-87c7385e0083	SNARE	1	0	1	X	2019-12-04 15:09:16.566465	2019-12-04 15:09:16.566465
181b28c0-16eb-11ea-8a37-53b720504715	17e50f74-16eb-11ea-8a37-e3561e92fad1	181a45f4-16eb-11ea-8a37-db5faa67a688	TOM	1	0	1	X	2019-12-04 15:09:16.577928	2019-12-04 15:09:16.577928
181ca786-16eb-11ea-8a37-073d4a8e9c83	17e50f74-16eb-11ea-8a37-e3561e92fad1	181c16a4-16eb-11ea-8a37-a752cb66a0c7	SNARE	1	0	1	X	2019-12-04 15:09:16.587726	2019-12-04 15:09:16.587726
181dd764-16eb-11ea-8a37-573605ca9d5f	17e50f74-16eb-11ea-8a37-e3561e92fad1	181d3f84-16eb-11ea-8a37-03b6f26eb4fc	TOM	1	0	1	X	2019-12-04 15:09:16.5955	2019-12-04 15:09:16.5955
181f1822-16eb-11ea-8a37-1b43b675d137	17e50f74-16eb-11ea-8a37-e3561e92fad1	181e7476-16eb-11ea-8a37-c35eda2de4ff	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.603677	2019-12-04 15:09:16.603677
18209c6a-16eb-11ea-8a37-0faab7a17c5f	17e50f74-16eb-11ea-8a37-e3561e92fad1	181fd1e0-16eb-11ea-8a37-e3a8ea2a1c89	TOM	1	0	1	X	2019-12-04 15:09:16.613407	2019-12-04 15:09:16.613407
18229f88-16eb-11ea-8a37-e3f360259918	17e50f74-16eb-11ea-8a37-e3561e92fad1	18216bfe-16eb-11ea-8a37-7fa9bb385443	HIHAT	1	0	1	X	2019-12-04 15:09:16.626729	2019-12-04 15:09:16.626729
18251fba-16eb-11ea-8a37-0f1f525f4bb9	17e50f74-16eb-11ea-8a37-e3561e92fad1	1823e942-16eb-11ea-8a37-0b1adf808ef0	SNARE	1	0	1	X	2019-12-04 15:09:16.643129	2019-12-04 15:09:16.643129
182777ec-16eb-11ea-8a37-67ea913cd903	17e50f74-16eb-11ea-8a37-e3561e92fad1	18265c7c-16eb-11ea-8a37-1fb103690bc0	KICK	2	0	1	x	2019-12-04 15:09:16.658499	2019-12-04 15:09:16.658499
1829adbe-16eb-11ea-8a37-ab9840b4f679	17e50f74-16eb-11ea-8a37-e3561e92fad1	182895dc-16eb-11ea-8a37-c39d11c0cb6e	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.672985	2019-12-04 15:09:16.672985
182b8d82-16eb-11ea-8a37-b3172b3b158f	17e50f74-16eb-11ea-8a37-e3561e92fad1	182ac910-16eb-11ea-8a37-33ab3fe15917	HIHAT	1	0	1	X	2019-12-04 15:09:16.685275	2019-12-04 15:09:16.685275
182d1ab2-16eb-11ea-8a37-67ce2b17144f	17e50f74-16eb-11ea-8a37-e3561e92fad1	182c5802-16eb-11ea-8a37-6f25b8020933	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.69545	2019-12-04 15:09:16.69545
182eb584-16eb-11ea-8a37-0718b589669c	17e50f74-16eb-11ea-8a37-e3561e92fad1	182dec4e-16eb-11ea-8a37-a3ff3312c6b9	TOM	1	0	1	X	2019-12-04 15:09:16.705947	2019-12-04 15:09:16.705947
18304d5e-16eb-11ea-8a37-0bb9f66e7ffd	17e50f74-16eb-11ea-8a37-e3561e92fad1	182f7fa0-16eb-11ea-8a37-df905c96912f	SNARE	1	0	1	X	2019-12-04 15:09:16.716382	2019-12-04 15:09:16.716382
18324fb4-16eb-11ea-8a37-d3300fe4cfdd	17e50f74-16eb-11ea-8a37-e3561e92fad1	18311a9a-16eb-11ea-8a37-7f9c48dfd5a1	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.729483	2019-12-04 15:09:16.729483
1834bd58-16eb-11ea-8a37-43158e17f2ea	17e50f74-16eb-11ea-8a37-e3561e92fad1	18338726-16eb-11ea-8a37-cb22a831d9ef	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.7454	2019-12-04 15:09:16.7454
18370e50-16eb-11ea-8a37-0702a0b37310	17e50f74-16eb-11ea-8a37-e3561e92fad1	1835f362-16eb-11ea-8a37-6b23eb216767	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.760659	2019-12-04 15:09:16.760659
18394832-16eb-11ea-8a37-f7b977f94d59	17e50f74-16eb-11ea-8a37-e3561e92fad1	183834e2-16eb-11ea-8a37-9f55b1df0e78	SNARE	1	0	1	X	2019-12-04 15:09:16.775235	2019-12-04 15:09:16.775235
183b316a-16eb-11ea-8a37-8b5815f361e3	17e50f74-16eb-11ea-8a37-e3561e92fad1	183a6686-16eb-11ea-8a37-0765c513b9b2	TOM	1	0	1	X	2019-12-04 15:09:16.787762	2019-12-04 15:09:16.787762
183c7d54-16eb-11ea-8a37-87c9e422e242	17e50f74-16eb-11ea-8a37-e3561e92fad1	183bdf70-16eb-11ea-8a37-eb7b029e1978	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.796346	2019-12-04 15:09:16.796346
183daa9e-16eb-11ea-8a37-5f6a103c3bb8	17e50f74-16eb-11ea-8a37-e3561e92fad1	183d1962-16eb-11ea-8a37-ef7f98b935a0	TOM	1	0	1	X	2019-12-04 15:09:16.804091	2019-12-04 15:09:16.804091
183ec3ac-16eb-11ea-8a37-d7ba67fea0d7	17e50f74-16eb-11ea-8a37-e3561e92fad1	183e389c-16eb-11ea-8a37-c3e28efd0d97	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.811269	2019-12-04 15:09:16.811269
18404790-16eb-11ea-8a37-b7c54add32ec	17e50f74-16eb-11ea-8a37-e3561e92fad1	183f4e8a-16eb-11ea-8a37-936bb73bed80	TOM	1	0	1	X	2019-12-04 15:09:16.821218	2019-12-04 15:09:16.821218
18423dde-16eb-11ea-8a37-9f2f0dd6009d	17e50f74-16eb-11ea-8a37-e3561e92fad1	184144ba-16eb-11ea-8a37-2b4db47b0de8	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.834078	2019-12-04 15:09:16.834078
18441c44-16eb-11ea-8a37-6b79175bdce1	17e50f74-16eb-11ea-8a37-e3561e92fad1	184337f2-16eb-11ea-8a37-ab17d38f48ed	HIHAT	1	0	1	X	2019-12-04 15:09:16.846308	2019-12-04 15:09:16.846308
1845d368-16eb-11ea-8a37-b3cf4f1a912f	17e50f74-16eb-11ea-8a37-e3561e92fad1	1844faf6-16eb-11ea-8a37-53daf584cf6a	TOM	1	0	1	X	2019-12-04 15:09:16.857575	2019-12-04 15:09:16.857575
1847387a-16eb-11ea-8a37-67958c2ee1de	17e50f74-16eb-11ea-8a37-e3561e92fad1	1846ac7a-16eb-11ea-8a37-bf7ac439ed3a	TOM	1	0	1	X	2019-12-04 15:09:16.866732	2019-12-04 15:09:16.866732
184840d0-16eb-11ea-8a37-773b5813ce35	17e50f74-16eb-11ea-8a37-e3561e92fad1	1847c18c-16eb-11ea-8a37-173965c95f24	TOM	1	0	1	X	2019-12-04 15:09:16.873505	2019-12-04 15:09:16.873505
18493e22-16eb-11ea-8a37-af9fb1960477	17e50f74-16eb-11ea-8a37-e3561e92fad1	1848bede-16eb-11ea-8a37-137705e89a72	TOM	1	0	1	X	2019-12-04 15:09:16.879983	2019-12-04 15:09:16.879983
184a4a92-16eb-11ea-8a37-4b642ffcd9b1	17e50f74-16eb-11ea-8a37-e3561e92fad1	1849c2c0-16eb-11ea-8a37-73952411a20d	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.886852	2019-12-04 15:09:16.886852
184bc28c-16eb-11ea-8a37-e769c6b9f580	17e50f74-16eb-11ea-8a37-e3561e92fad1	184ad1ec-16eb-11ea-8a37-9bb6cc2f93d9	SNARE	1	0	1	X	2019-12-04 15:09:16.896476	2019-12-04 15:09:16.896476
184dc82a-16eb-11ea-8a37-536f5d423e28	17e50f74-16eb-11ea-8a37-e3561e92fad1	184cbe12-16eb-11ea-8a37-730ff7a7f78b	HIHAT	1	0	1	X	2019-12-04 15:09:16.909699	2019-12-04 15:09:16.909699
184fc2a6-16eb-11ea-8a37-6b9a72616b43	17e50f74-16eb-11ea-8a37-e3561e92fad1	184ed2ec-16eb-11ea-8a37-d394b5dadd18	KICK	2	0	1	x	2019-12-04 15:09:16.922635	2019-12-04 15:09:16.922635
1851da5a-16eb-11ea-8a37-bb08aca116ac	17e50f74-16eb-11ea-8a37-e3561e92fad1	1850c570-16eb-11ea-8a37-afeb47e66e06	HIHATOPEN	1	0.02	1	X	2019-12-04 15:09:16.936272	2019-12-04 15:09:16.936272
1853b5d2-16eb-11ea-8a37-cb47b03a9e70	17e50f74-16eb-11ea-8a37-e3561e92fad1	1852ed5a-16eb-11ea-8a37-03036f8f86d1	TOM	1	0	1	X	2019-12-04 15:09:16.948438	2019-12-04 15:09:16.948438
18554cb2-16eb-11ea-8a37-c7f3417e6ad3	17e50f74-16eb-11ea-8a37-e3561e92fad1	1854853e-16eb-11ea-8a37-a78b2db1bc43	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.958864	2019-12-04 15:09:16.958864
1856d690-16eb-11ea-8a37-a35ac71be1e4	17e50f74-16eb-11ea-8a37-e3561e92fad1	18561250-16eb-11ea-8a37-5722d15e6077	TOM	1	0	1	X	2019-12-04 15:09:16.968944	2019-12-04 15:09:16.968944
18586050-16eb-11ea-8a37-ff50febad48d	17e50f74-16eb-11ea-8a37-e3561e92fad1	1857a2d2-16eb-11ea-8a37-3328b0110dc8	HIHATOPEN	1	0	1	X	2019-12-04 15:09:16.979077	2019-12-04 15:09:16.979077
185a0ec8-16eb-11ea-8a37-e336bb5abb8c	17e50f74-16eb-11ea-8a37-e3561e92fad1	18590ef6-16eb-11ea-8a37-9b2614355b68	TOM	1	0	1	X	2019-12-04 15:09:16.990142	2019-12-04 15:09:16.990142
185c1380-16eb-11ea-8a37-fb55d271acde	17e50f74-16eb-11ea-8a37-e3561e92fad1	185b12b4-16eb-11ea-8a37-4f8cbe060a3f	TOM	1	0	1	X	2019-12-04 15:09:17.003378	2019-12-04 15:09:17.003378
185df038-16eb-11ea-8a37-1398c38ddf11	17e50f74-16eb-11ea-8a37-e3561e92fad1	185d1096-16eb-11ea-8a37-a7a1a5bedbbc	HIHAT	1	0	1	X	2019-12-04 15:09:17.015558	2019-12-04 15:09:17.015558
185fa284-16eb-11ea-8a37-abd18c875447	17e50f74-16eb-11ea-8a37-e3561e92fad1	185ece68-16eb-11ea-8a37-17edc2490da1	KICK	2	0	1	x	2019-12-04 15:09:17.026726	2019-12-04 15:09:17.026726
18621802-16eb-11ea-8a37-4f473db09e20	1860788a-16eb-11ea-8a37-87eb83753fe4	18618b8a-16eb-11ea-8a37-ff57d3dc6575	KICK	1	0	1	Eb3	2019-12-04 15:09:17.042829	2019-12-04 15:09:17.042829
18633aa2-16eb-11ea-8a37-0339b1a7b973	1860788a-16eb-11ea-8a37-87eb83753fe4	1862ac04-16eb-11ea-8a37-bffcd4df8f89	HIHATOPEN	1	0	0.5	c5	2019-12-04 15:09:17.050253	2019-12-04 15:09:17.050253
1864609e-16eb-11ea-8a37-c3db46cdb1c8	1860788a-16eb-11ea-8a37-87eb83753fe4	1863ce2c-16eb-11ea-8a37-5b84e1454278	SNARE	1	0	1	f3	2019-12-04 15:09:17.05778	2019-12-04 15:09:17.05778
186612f4-16eb-11ea-8a37-b380254907c7	1860788a-16eb-11ea-8a37-87eb83753fe4	186500d0-16eb-11ea-8a37-536664e9e62d	HIHATOPEN	1	0	0.5	Bb8	2019-12-04 15:09:17.068823	2019-12-04 15:09:17.068823
18687940-16eb-11ea-8a37-2ba8ee078ed7	1860788a-16eb-11ea-8a37-87eb83753fe4	18674426-16eb-11ea-8a37-0731ffffbdd1	HIHAT	1	0	0.5	g8	2019-12-04 15:09:17.08446	2019-12-04 15:09:17.08446
186ac380-16eb-11ea-8a37-bfe3bce42338	1860788a-16eb-11ea-8a37-87eb83753fe4	1869b0ee-16eb-11ea-8a37-b3fe70801e4a	TOM	1	0	1	Db3	2019-12-04 15:09:17.099492	2019-12-04 15:09:17.099492
186cf948-16eb-11ea-8a37-0b10f78e6d44	1860788a-16eb-11ea-8a37-87eb83753fe4	186bde78-16eb-11ea-8a37-efbd7f0724d7	SNARE	1	0	1	B	2019-12-04 15:09:17.11397	2019-12-04 15:09:17.11397
186eda2e-16eb-11ea-8a37-1391134093bb	1860788a-16eb-11ea-8a37-87eb83753fe4	186e13a0-16eb-11ea-8a37-a7413f71a978	HIHATOPEN	1	0	0.5	e4	2019-12-04 15:09:17.126334	2019-12-04 15:09:17.126334
187059bc-16eb-11ea-8a37-0baf6b7c0873	1860788a-16eb-11ea-8a37-87eb83753fe4	186f9a36-16eb-11ea-8a37-e388c87b5bf8	HIHAT	1	0	0.5	C5	2019-12-04 15:09:17.136157	2019-12-04 15:09:17.136157
1871d9d6-16eb-11ea-8a37-0fd08ce3ab5c	1860788a-16eb-11ea-8a37-87eb83753fe4	18711adc-16eb-11ea-8a37-b77b246e5e20	KICK	1	0	1	f8	2019-12-04 15:09:17.145972	2019-12-04 15:09:17.145972
1873581a-16eb-11ea-8a37-5b2235f6cd24	1860788a-16eb-11ea-8a37-87eb83753fe4	18729d94-16eb-11ea-8a37-a3298d30f5d0	KICK	1	0	1	Eb2	2019-12-04 15:09:17.155748	2019-12-04 15:09:17.155748
18756786-16eb-11ea-8a37-f32cfa87c520	1860788a-16eb-11ea-8a37-87eb83753fe4	18741732-16eb-11ea-8a37-e3b9f55f8370	TOM	1	0	1	Ab2	2019-12-04 15:09:17.169221	2019-12-04 15:09:17.169221
1877ef7e-16eb-11ea-8a37-3f7f7375f2eb	1860788a-16eb-11ea-8a37-87eb83753fe4	1876b6d6-16eb-11ea-8a37-dbfef979cf82	HIHATOPEN	1	0	1	e4	2019-12-04 15:09:17.185839	2019-12-04 15:09:17.185839
187a3af4-16eb-11ea-8a37-8be267c105a7	1860788a-16eb-11ea-8a37-87eb83753fe4	187926c8-16eb-11ea-8a37-4323ec2db348	HIHAT	1	0	0.5	Bb8	2019-12-04 15:09:17.200896	2019-12-04 15:09:17.200896
187c6e78-16eb-11ea-8a37-a3ce5f2f0ae0	1860788a-16eb-11ea-8a37-87eb83753fe4	187b56c8-16eb-11ea-8a37-c7a5111d046c	SNARE	1	0	1	Bb3	2019-12-04 15:09:17.215314	2019-12-04 15:09:17.215314
187f1bd2-16eb-11ea-8a37-779992dc8865	1860788a-16eb-11ea-8a37-87eb83753fe4	187e549a-16eb-11ea-8a37-c76ff883a7e2	HIHAT	1	0	0.5	Gb4	2019-12-04 15:09:17.232859	2019-12-04 15:09:17.232859
1880a83a-16eb-11ea-8a37-17d82c508620	1860788a-16eb-11ea-8a37-87eb83753fe4	187fe6ca-16eb-11ea-8a37-7f94c6d498c4	TOM	1	0	1	D3	2019-12-04 15:09:17.24302	2019-12-04 15:09:17.24302
18822cd2-16eb-11ea-8a37-5fb3711448c8	1860788a-16eb-11ea-8a37-87eb83753fe4	18816ad6-16eb-11ea-8a37-17120f8a1cc8	SNARE	1	0	1	g8	2019-12-04 15:09:17.252959	2019-12-04 15:09:17.252959
1883b20a-16eb-11ea-8a37-6747bff6c860	1860788a-16eb-11ea-8a37-87eb83753fe4	1882ef00-16eb-11ea-8a37-9b9996443f19	CRASH	1	0	4	E5	2019-12-04 15:09:17.262927	2019-12-04 15:09:17.262927
188a7fa4-16eb-11ea-8a37-1be6abff565f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18896baa-16eb-11ea-8a37-c7be844d34ad	KICK	1	0	1	Bb1	2019-12-04 15:09:17.307499	2019-12-04 15:09:17.307499
188caffe-16eb-11ea-8a37-a30536ad3764	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	188b9e0c-16eb-11ea-8a37-6fe440d81eec	TOM	1	0	1	F#8	2019-12-04 15:09:17.32184	2019-12-04 15:09:17.32184
188e33e2-16eb-11ea-8a37-cfe5e155bfc7	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	188d71c8-16eb-11ea-8a37-8ff02f6702df	KICK	1	0	1	G2	2019-12-04 15:09:17.331788	2019-12-04 15:09:17.331788
188fbcd0-16eb-11ea-8a37-cf4aac047b5b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	188ef548-16eb-11ea-8a37-6f3ab3141f51	SNARE	1	0	1	B8	2019-12-04 15:09:17.341821	2019-12-04 15:09:17.341821
189155e0-16eb-11ea-8a37-9b66d468f1c8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189088ae-16eb-11ea-8a37-fb7450981460	KICK	1	0	1	B2	2019-12-04 15:09:17.352295	2019-12-04 15:09:17.352295
1892c100-16eb-11ea-8a37-f798c4815c58	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189216a6-16eb-11ea-8a37-bb6a073772c7	SNARE	1	0	1	E8	2019-12-04 15:09:17.361594	2019-12-04 15:09:17.361594
1894c7ac-16eb-11ea-8a37-1b2c719e3390	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	1893cb18-16eb-11ea-8a37-07e64de02777	KICK	1	0	1	C3	2019-12-04 15:09:17.374972	2019-12-04 15:09:17.374972
1896b698-16eb-11ea-8a37-2376bd96a9d9	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	1895c008-16eb-11ea-8a37-8f3040ccb8e8	SNARE	1	0	1	D7	2019-12-04 15:09:17.387687	2019-12-04 15:09:17.387687
18987a00-16eb-11ea-8a37-17f758cddbc9	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189799d2-16eb-11ea-8a37-4b4b2e7be86f	KICK	1	0	1	D2	2019-12-04 15:09:17.399238	2019-12-04 15:09:17.399238
189a2ce2-16eb-11ea-8a37-9375a212adcb	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189958b2-16eb-11ea-8a37-8383c3493df4	KICK	1	0	1	D2	2019-12-04 15:09:17.410377	2019-12-04 15:09:17.410377
189b6620-16eb-11ea-8a37-6be946557e8e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189ac21a-16eb-11ea-8a37-5fb44a763c0f	TOM	1	0	1	F#8	2019-12-04 15:09:17.418385	2019-12-04 15:09:17.418385
189caefe-16eb-11ea-8a37-037966f6e825	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189c07a6-16eb-11ea-8a37-479dbe5ba4f6	TOM	1	0	1	D3	2019-12-04 15:09:17.426793	2019-12-04 15:09:17.426793
189e0768-16eb-11ea-8a37-d799d8cbec8c	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189d573c-16eb-11ea-8a37-67cc0771415f	KICK	1	0	1	B2	2019-12-04 15:09:17.435563	2019-12-04 15:09:17.435563
189f7e2c-16eb-11ea-8a37-4335da3697a8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	189ec040-16eb-11ea-8a37-77040511ab2f	SNARE	1	0	1	E8	2019-12-04 15:09:17.445075	2019-12-04 15:09:17.445075
18a1d69a-16eb-11ea-8a37-73ee10711cd1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18a0ad56-16eb-11ea-8a37-7bdce51885a3	KICK	1	0	1	G2	2019-12-04 15:09:17.460472	2019-12-04 15:09:17.460472
18a431ce-16eb-11ea-8a37-f36175e99b13	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18a306a0-16eb-11ea-8a37-eba40dfdf0bf	KICK	1	0	1	D2	2019-12-04 15:09:17.475886	2019-12-04 15:09:17.475886
18a664c6-16eb-11ea-8a37-dfced045839e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18a54bf4-16eb-11ea-8a37-53c0835e397a	KICK	1	0	1	F3	2019-12-04 15:09:17.490288	2019-12-04 15:09:17.490288
18a8907a-16eb-11ea-8a37-e30a1354052f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18a77d34-16eb-11ea-8a37-73c557a79b6c	SNARE	1	0	1	D#7	2019-12-04 15:09:17.504532	2019-12-04 15:09:17.504532
18aa3812-16eb-11ea-8a37-37ffac7e42c1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18a96090-16eb-11ea-8a37-df51a8dde2a2	KICK	1	0	1	G2	2019-12-04 15:09:17.515346	2019-12-04 15:09:17.515346
18abd186-16eb-11ea-8a37-4bbf9cbdc876	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ab071a-16eb-11ea-8a37-fb7006611ac6	TOM	1	0	1	F6	2019-12-04 15:09:17.525879	2019-12-04 15:09:17.525879
18ad635c-16eb-11ea-8a37-3318eb41f634	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ac9fb2-16eb-11ea-8a37-cf621ad8ea06	KICK	1	0	1	F#2	2019-12-04 15:09:17.536159	2019-12-04 15:09:17.536159
18af0324-16eb-11ea-8a37-076a4b58a463	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ae2a8a-16eb-11ea-8a37-6f37797fd9f6	KICK	1	0	1	A#1	2019-12-04 15:09:17.546745	2019-12-04 15:09:17.546745
18b0b0e8-16eb-11ea-8a37-0b2105ea8e1f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18afdfba-16eb-11ea-8a37-579a18edbe36	TOM	1	0	1	F#8	2019-12-04 15:09:17.557803	2019-12-04 15:09:17.557803
18b25a7e-16eb-11ea-8a37-737b57b405dc	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18b1854a-16eb-11ea-8a37-57b4d2f1b030	TOM	1	0	1	D#6	2019-12-04 15:09:17.568663	2019-12-04 15:09:17.568663
18b4ab3a-16eb-11ea-8a37-0732b158751d	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18b33250-16eb-11ea-8a37-af9972429936	KICK	1	0	1	G2	2019-12-04 15:09:17.58382	2019-12-04 15:09:17.58382
18b64724-16eb-11ea-8a37-a3baba6741be	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18b57be6-16eb-11ea-8a37-d3d79e939e06	SNARE	1	0	1	E8	2019-12-04 15:09:17.59442	2019-12-04 15:09:17.59442
18b7d65c-16eb-11ea-8a37-a357077d5bec	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18b71000-16eb-11ea-8a37-eb83a2d9a261	KICK	1	0	1	F2	2019-12-04 15:09:17.604632	2019-12-04 15:09:17.604632
18b974da-16eb-11ea-8a37-2f3e9afda47e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18b89db2-16eb-11ea-8a37-57e79ab1330b	SNARE	1	0	1	A7	2019-12-04 15:09:17.615206	2019-12-04 15:09:17.615206
18bb2a0a-16eb-11ea-8a37-2ff15e62f05e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ba41da-16eb-11ea-8a37-d35b51233602	KICK	1	0	1	A#1	2019-12-04 15:09:17.626429	2019-12-04 15:09:17.626429
18bd001e-16eb-11ea-8a37-ab9ede2f17e5	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18bc1f6e-16eb-11ea-8a37-af9e0152ad7e	TOM	1	0	1	A8	2019-12-04 15:09:17.638464	2019-12-04 15:09:17.638464
18bebb66-16eb-11ea-8a37-13f861b673f3	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18bde362-16eb-11ea-8a37-e7b19f789f4e	SNARE	1	0	1	F#7	2019-12-04 15:09:17.649826	2019-12-04 15:09:17.649826
18c06650-16eb-11ea-8a37-67c43b25a7e1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18bf94dc-16eb-11ea-8a37-934707470d43	KICK	1	0	1	F2	2019-12-04 15:09:17.660761	2019-12-04 15:09:17.660761
18c21090-16eb-11ea-8a37-ef5041136ee2	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c140f2-16eb-11ea-8a37-4f3152e031d1	KICK	1	0	1	F2	2019-12-04 15:09:17.671675	2019-12-04 15:09:17.671675
18c3b08a-16eb-11ea-8a37-bb252a12e5c6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c2de76-16eb-11ea-8a37-8f09fb22b179	HIHAT	1	0	1	B9	2019-12-04 15:09:17.682296	2019-12-04 15:09:17.682296
18c5467a-16eb-11ea-8a37-a77dafb900a3	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c4810e-16eb-11ea-8a37-bf3cd2348172	KICK	1	0	1	D#2	2019-12-04 15:09:17.692715	2019-12-04 15:09:17.692715
18c6dc56-16eb-11ea-8a37-3f7e42c14a60	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c6146a-16eb-11ea-8a37-8f79a9c06eb6	SNARE	1	0	1	D3	2019-12-04 15:09:17.703088	2019-12-04 15:09:17.703088
18c89eb0-16eb-11ea-8a37-d34dc59673eb	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c7a37a-16eb-11ea-8a37-73c0f962b483	KICK	1	0	1	B1	2019-12-04 15:09:17.714617	2019-12-04 15:09:17.714617
18cb0a4c-16eb-11ea-8a37-33e879b64458	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18c9d8a2-16eb-11ea-8a37-ef8f2d2bafa8	SNARE	1	0	1	F#8	2019-12-04 15:09:17.730491	2019-12-04 15:09:17.730491
18cd6972-16eb-11ea-8a37-2349d94480c6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18cc3c78-16eb-11ea-8a37-639c0d09c659	SNARE	1	0	1	F3	2019-12-04 15:09:17.746022	2019-12-04 15:09:17.746022
18cf98f0-16eb-11ea-8a37-f7f68b5a9c7c	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ce85dc-16eb-11ea-8a37-a79ad1c2c046	SNARE	1	0	1	G7	2019-12-04 15:09:17.760355	2019-12-04 15:09:17.760355
18d19f2e-16eb-11ea-8a37-4f87950eb21f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d0b028-16eb-11ea-8a37-033cc1e829fa	TOM	1	0	1	D3	2019-12-04 15:09:17.773568	2019-12-04 15:09:17.773568
18d3468a-16eb-11ea-8a37-4789bd3a7568	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d2734a-16eb-11ea-8a37-77368cd5f81b	TOM	1	0	1	F#8	2019-12-04 15:09:17.784459	2019-12-04 15:09:17.784459
18d4db26-16eb-11ea-8a37-07ae909b749d	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d413a8-16eb-11ea-8a37-e3e91040b091	KICK	1	0	1	A#2	2019-12-04 15:09:17.794821	2019-12-04 15:09:17.794821
18d66374-16eb-11ea-8a37-6f35f9b81469	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d5a0d8-16eb-11ea-8a37-f3877c969a22	SNARE	1	0	1	B7	2019-12-04 15:09:17.804866	2019-12-04 15:09:17.804866
18d833ac-16eb-11ea-8a37-1f80ef7e35e8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d72c64-16eb-11ea-8a37-03d04c29f9c8	TOM	1	0	1	B8	2019-12-04 15:09:17.816703	2019-12-04 15:09:17.816703
18dab546-16eb-11ea-8a37-639b070326c1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18d9756e-16eb-11ea-8a37-cba3fa1c49ee	SNARE	1	0	1	C7	2019-12-04 15:09:17.833158	2019-12-04 15:09:17.833158
18dd274a-16eb-11ea-8a37-1b420f107972	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18dbfb0e-16eb-11ea-8a37-8bb2a19976a0	KICK	1	0	1	D2	2019-12-04 15:09:17.849182	2019-12-04 15:09:17.849182
18df6456-16eb-11ea-8a37-afd5a534040b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18de4846-16eb-11ea-8a37-8fc3f4dc333a	SNARE	1	0	1	F#8	2019-12-04 15:09:17.863873	2019-12-04 15:09:17.863873
18e1749e-16eb-11ea-8a37-6f01b6c92107	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e07f4e-16eb-11ea-8a37-ef24cee14319	TOM	1	0	1	E8	2019-12-04 15:09:17.877389	2019-12-04 15:09:17.877389
18e32014-16eb-11ea-8a37-b7d79222457f	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e251ca-16eb-11ea-8a37-8713d08e14ce	SNARE	1	0	1	C7	2019-12-04 15:09:17.888337	2019-12-04 15:09:17.888337
18e4b6e0-16eb-11ea-8a37-17b0d2bb8ec2	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e3ef94-16eb-11ea-8a37-23b6d85a4371	SNARE	1	0	1	D8	2019-12-04 15:09:17.898753	2019-12-04 15:09:17.898753
18e64f8c-16eb-11ea-8a37-13dbedf5d912	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e5896c-16eb-11ea-8a37-f33cf75aeb3a	KICK	1	0	1	F#2	2019-12-04 15:09:17.909178	2019-12-04 15:09:17.909178
18e82708-16eb-11ea-8a37-079baadc1523	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e72808-16eb-11ea-8a37-933d76eb95a2	KICK	1	0	1	E2	2019-12-04 15:09:17.921267	2019-12-04 15:09:17.921267
18ea95c4-16eb-11ea-8a37-3f85e008379b	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18e966b8-16eb-11ea-8a37-abf494664a62	SNARE	1	0	1	G7	2019-12-04 15:09:17.937222	2019-12-04 15:09:17.937222
18ed0322-16eb-11ea-8a37-2b795f8090c5	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ebd6b4-16eb-11ea-8a37-2368274ae22d	SNARE	1	0	1	A#7	2019-12-04 15:09:17.9531	2019-12-04 15:09:17.9531
18ef3796-16eb-11ea-8a37-a75a71d7f3bc	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18ee1f00-16eb-11ea-8a37-b76675384f8f	SNARE	1	0	1	F#8	2019-12-04 15:09:17.967578	2019-12-04 15:09:17.967578
18f14978-16eb-11ea-8a37-432c1a3c2d27	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f052f2-16eb-11ea-8a37-e34945ae4066	SNARE	1	0	1	A7	2019-12-04 15:09:17.981134	2019-12-04 15:09:17.981134
18f2f0ac-16eb-11ea-8a37-eb6e7208120a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f224e2-16eb-11ea-8a37-f3267cbcfb17	KICK	1	0	1	A2	2019-12-04 15:09:17.991978	2019-12-04 15:09:17.991978
18f4896c-16eb-11ea-8a37-cf813cccc02e	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f3bab4-16eb-11ea-8a37-bbd635879795	KICK	1	0	1	F#2	2019-12-04 15:09:18.002435	2019-12-04 15:09:18.002435
18f6247a-16eb-11ea-8a37-ebd7f82b1c7d	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f5543c-16eb-11ea-8a37-737d85107e80	CRASH	1	0	4	A5	2019-12-04 15:09:18.012914	2019-12-04 15:09:18.012914
18f801fa-16eb-11ea-8a37-eb8f127fadd6	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f6f6fc-16eb-11ea-8a37-1392555a26e5	KICK	1	0	1	D#2	2019-12-04 15:09:18.025188	2019-12-04 15:09:18.025188
18fa8b82-16eb-11ea-8a37-7fa63a5bc0c1	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18f94e8e-16eb-11ea-8a37-8f435f18726a	TOM	1	0	1	C#3	2019-12-04 15:09:18.041806	2019-12-04 15:09:18.041806
18fcf41c-16eb-11ea-8a37-afdb980141f0	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18fbd046-16eb-11ea-8a37-2fd1239d8ee8	SNARE	1	0	1	E8	2019-12-04 15:09:18.057578	2019-12-04 15:09:18.057578
18ff2638-16eb-11ea-8a37-5b94fcdf61c8	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	18fe1194-16eb-11ea-8a37-475aef94fe90	SNARE	1	0	1	F#8	2019-12-04 15:09:18.071986	2019-12-04 15:09:18.071986
19013068-16eb-11ea-8a37-cfea4168fb99	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	19003c3a-16eb-11ea-8a37-47f4a17213a3	CRASH	1	0	4	B4	2019-12-04 15:09:18.085364	2019-12-04 15:09:18.085364
1902d3c8-16eb-11ea-8a37-f71ce235871a	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	190206aa-16eb-11ea-8a37-3f8545cb2bb5	SNARE	1	0	1	F#8	2019-12-04 15:09:18.096098	2019-12-04 15:09:18.096098
190479a8-16eb-11ea-8a37-936b7b4204cf	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	1903ac08-16eb-11ea-8a37-032a149e24b4	KICK	1	0	1	D#2	2019-12-04 15:09:18.10688	2019-12-04 15:09:18.10688
190617fe-16eb-11ea-8a37-1b815ebf0636	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	19054f9a-16eb-11ea-8a37-9323b3764e29	KICK	1	0	1	G2	2019-12-04 15:09:18.117428	2019-12-04 15:09:18.117428
1907e444-16eb-11ea-8a37-735dc0ca2dec	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	1906e242-16eb-11ea-8a37-b7eb66a64016	KICK	1	0	1	B1	2019-12-04 15:09:18.129286	2019-12-04 15:09:18.129286
190a7614-16eb-11ea-8a37-738b804366e0	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	19092e08-16eb-11ea-8a37-6f0c89c3223b	KICK	1	0	1	F#3	2019-12-04 15:09:18.146103	2019-12-04 15:09:18.146103
190ce264-16eb-11ea-8a37-abe0cc6e5b31	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	190bb72c-16eb-11ea-8a37-af4a5d5df325	KICK	1	0	1	F#2	2019-12-04 15:09:18.162009	2019-12-04 15:09:18.162009
190f111a-16eb-11ea-8a37-df9289f458c0	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	190df8b6-16eb-11ea-8a37-d7e15046d868	KICK	1	0	1	F#2	2019-12-04 15:09:18.176308	2019-12-04 15:09:18.176308
19111622-16eb-11ea-8a37-cb4356fe568d	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	19102712-16eb-11ea-8a37-1f623e692501	KICK	1	0	1	A2	2019-12-04 15:09:18.189471	2019-12-04 15:09:18.189471
1912b4e6-16eb-11ea-8a37-e37c12d00fe9	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	1911e516-16eb-11ea-8a37-df5235a93f80	SNARE	1	0	1	F#8	2019-12-04 15:09:18.200103	2019-12-04 15:09:18.200103
19168990-16eb-11ea-8a37-3f32f65eac29	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1915c7d0-16eb-11ea-8a37-27ab9787584f	TOM	1	0	1	F7	2019-12-04 15:09:18.225273	2019-12-04 15:09:18.225273
1918c6b0-16eb-11ea-8a37-0312d6bfa6e4	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	19178f5c-16eb-11ea-8a37-67f384c7c69c	HIHAT	1	0	1	B9	2019-12-04 15:09:18.239929	2019-12-04 15:09:18.239929
191b461a-16eb-11ea-8a37-bb6938ff84b2	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	191a0660-16eb-11ea-8a37-0fd92ae346c8	HIHATOPEN	1	0	1	D8	2019-12-04 15:09:18.256309	2019-12-04 15:09:18.256309
191d82cc-16eb-11ea-8a37-e38606de22ab	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	191c7116-16eb-11ea-8a37-bba31bf81301	HIHATOPEN	1	0	1	Bb7	2019-12-04 15:09:18.270943	2019-12-04 15:09:18.270943
191fc2da-16eb-11ea-8a37-9fe01f558440	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	191ead00-16eb-11ea-8a37-e761c288dbae	SNARE	1	0	1	B3	2019-12-04 15:09:18.285694	2019-12-04 15:09:18.285694
19218886-16eb-11ea-8a37-4f7961c97a68	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1920bc30-16eb-11ea-8a37-13298d9cfd01	SNARE	1	0	1	Eb5	2019-12-04 15:09:18.297322	2019-12-04 15:09:18.297322
19232ef2-16eb-11ea-8a37-f706d07bad5c	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	19226116-16eb-11ea-8a37-f353fe41a475	CRASH	1	0	4	B3	2019-12-04 15:09:18.308103	2019-12-04 15:09:18.308103
1924c7e4-16eb-11ea-8a37-abae5188a1e2	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1923f90e-16eb-11ea-8a37-abd3ffd53fd9	TOM	1	0	1	F7	2019-12-04 15:09:18.318597	2019-12-04 15:09:18.318597
192655aa-16eb-11ea-8a37-f39c19112c00	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1925926e-16eb-11ea-8a37-9fff26502dd5	TOM	1	0	1	A4	2019-12-04 15:09:18.328799	2019-12-04 15:09:18.328799
19289234-16eb-11ea-8a37-57da0361386b	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	192755d6-16eb-11ea-8a37-e74a87171cee	SNARE	1	0	1	G3	2019-12-04 15:09:18.343372	2019-12-04 15:09:18.343372
192b3552-16eb-11ea-8a37-db27f16fa6e3	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1929e5a8-16eb-11ea-8a37-9f8f9b1d4bf5	CRASH	1	0	1	D8	2019-12-04 15:09:18.360655	2019-12-04 15:09:18.360655
192d6156-16eb-11ea-8a37-dbef23924b3f	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	192c6fc6-16eb-11ea-8a37-ffb9392fa363	TOM	1	0	1	F7	2019-12-04 15:09:18.375029	2019-12-04 15:09:18.375029
192f3454-16eb-11ea-8a37-1304990b056d	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	192e51a6-16eb-11ea-8a37-93680c753ede	KICK	1	0	1	C3	2019-12-04 15:09:18.387023	2019-12-04 15:09:18.387023
19308cfa-16eb-11ea-8a37-6f0f6aa8e4c6	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	192ff470-16eb-11ea-8a37-3bff1208f2ff	SNARE	1	0	1	B8	2019-12-04 15:09:18.395833	2019-12-04 15:09:18.395833
1931acb6-16eb-11ea-8a37-d3dd9704b35d	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	19311e72-16eb-11ea-8a37-572d9e632a8b	TOM	1	0	1	F#9	2019-12-04 15:09:18.403229	2019-12-04 15:09:18.403229
1932f788-16eb-11ea-8a37-47ff4e25f84e	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	193237c6-16eb-11ea-8a37-97654ecdbaec	TOM	1	0	1	F5	2019-12-04 15:09:18.41156	2019-12-04 15:09:18.41156
19348ddc-16eb-11ea-8a37-f347768d7de0	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	1933c686-16eb-11ea-8a37-5f5a07088a3e	CRASH	1	0	1	Bb7	2019-12-04 15:09:18.421969	2019-12-04 15:09:18.421969
1936c502-16eb-11ea-8a37-1b962c6bd8c0	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	19358c78-16eb-11ea-8a37-1b42354e8b99	SNARE	1	0	1	D7	2019-12-04 15:09:18.436484	2019-12-04 15:09:18.436484
193955ce-16eb-11ea-8a37-0bcb4e7736a2	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	193804f8-16eb-11ea-8a37-876c8c4dd6ac	SNARE	1	0	1	G4	2019-12-04 15:09:18.453252	2019-12-04 15:09:18.453252
193df214-16eb-11ea-8a37-f3d4ca14e855	193a8eee-16eb-11ea-8a37-4f72c68eb48d	193cd5d2-16eb-11ea-8a37-e75acb241adb	CRASH	1	0	1	C3	2019-12-04 15:09:18.483489	2019-12-04 15:09:18.483489
193fba18-16eb-11ea-8a37-d33da1971fe8	193a8eee-16eb-11ea-8a37-4f72c68eb48d	193ee7c8-16eb-11ea-8a37-b7d2f534c79d	SNARE	1	0	1	F8	2019-12-04 15:09:18.495186	2019-12-04 15:09:18.495186
19415eae-16eb-11ea-8a37-ebcfd75b4915	193a8eee-16eb-11ea-8a37-4f72c68eb48d	194090be-16eb-11ea-8a37-1f578b2ce220	CRASH	1	0	2	C4	2019-12-04 15:09:18.505953	2019-12-04 15:09:18.505953
1943034e-16eb-11ea-8a37-139fb92ecd51	193a8eee-16eb-11ea-8a37-4f72c68eb48d	19422c94-16eb-11ea-8a37-ff9bb8d06279	CRASH	1	0	1	C4	2019-12-04 15:09:18.516708	2019-12-04 15:09:18.516708
1944a9c4-16eb-11ea-8a37-978797e93bb0	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1943e318-16eb-11ea-8a37-93c1cc0af638	KICK	1	0	1	C2	2019-12-04 15:09:18.527535	2019-12-04 15:09:18.527535
1946ff30-16eb-11ea-8a37-03ea1faa9192	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1945ba3a-16eb-11ea-8a37-2f68be87c78c	KICK	1	0	1	Ab2	2019-12-04 15:09:18.542817	2019-12-04 15:09:18.542817
19497ce2-16eb-11ea-8a37-cf7d9b23003f	193a8eee-16eb-11ea-8a37-4f72c68eb48d	194843c2-16eb-11ea-8a37-cf1a26e97532	CRASH	1	0	4	C5	2019-12-04 15:09:18.559132	2019-12-04 15:09:18.559132
194bc6be-16eb-11ea-8a37-b7758c398340	193a8eee-16eb-11ea-8a37-4f72c68eb48d	194aae78-16eb-11ea-8a37-2b4831ba3056	HIHAT	1	0	0.5	Eb5	2019-12-04 15:09:18.574131	2019-12-04 15:09:18.574131
194e01fe-16eb-11ea-8a37-976d89a65383	193a8eee-16eb-11ea-8a37-4f72c68eb48d	194ce832-16eb-11ea-8a37-937db00b3e75	TOM	1	0	2	B3	2019-12-04 15:09:18.588771	2019-12-04 15:09:18.588771
194fd3f8-16eb-11ea-8a37-3b596d6b9ca6	193a8eee-16eb-11ea-8a37-4f72c68eb48d	194ef9c4-16eb-11ea-8a37-0fd13c0df2f4	KICK	1	0	2	Db3	2019-12-04 15:09:18.600707	2019-12-04 15:09:18.600707
19518716-16eb-11ea-8a37-8b471305f5b0	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1950b4d0-16eb-11ea-8a37-97b59218dda7	HIHAT	1	0	0.5	Ab3	2019-12-04 15:09:18.611817	2019-12-04 15:09:18.611817
195338cc-16eb-11ea-8a37-cf5c95402514	193a8eee-16eb-11ea-8a37-4f72c68eb48d	19525984-16eb-11ea-8a37-875defeb8a13	CRASH	1	0	1	c4	2019-12-04 15:09:18.622915	2019-12-04 15:09:18.622915
1954c7b4-16eb-11ea-8a37-bb8fc1a7709f	193a8eee-16eb-11ea-8a37-4f72c68eb48d	19540964-16eb-11ea-8a37-9322edd6fb40	CRASH	1	0	1	c4	2019-12-04 15:09:18.633142	2019-12-04 15:09:18.633142
19570a10-16eb-11ea-8a37-c7605d692e92	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1955ce48-16eb-11ea-8a37-1b235a13fa27	TOM	1	0	1	Gb5	2019-12-04 15:09:18.647955	2019-12-04 15:09:18.647955
195982f4-16eb-11ea-8a37-7b0eece1a087	193a8eee-16eb-11ea-8a37-4f72c68eb48d	19584a88-16eb-11ea-8a37-8bff0765e845	SNARE	1	0	1	B5	2019-12-04 15:09:18.664154	2019-12-04 15:09:18.664154
195bc4b0-16eb-11ea-8a37-9788e56e2e2b	193a8eee-16eb-11ea-8a37-4f72c68eb48d	195aaeb8-16eb-11ea-8a37-83b401b01b76	SNARE	1	0	1	C6	2019-12-04 15:09:18.678943	2019-12-04 15:09:18.678943
195e032e-16eb-11ea-8a37-27079797ae93	193a8eee-16eb-11ea-8a37-4f72c68eb48d	195cec28-16eb-11ea-8a37-ef6a40720f17	TOM	1	0	1	D5	2019-12-04 15:09:18.693553	2019-12-04 15:09:18.693553
195fd49c-16eb-11ea-8a37-3b9541a25541	193a8eee-16eb-11ea-8a37-4f72c68eb48d	195f0404-16eb-11ea-8a37-1ff266bacace	SNARE	1	0	1	Eb4	2019-12-04 15:09:18.705521	2019-12-04 15:09:18.705521
1961840e-16eb-11ea-8a37-23acd822dc36	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1960ab6a-16eb-11ea-8a37-874d849cca5c	KICK	1	0	1	Db2	2019-12-04 15:09:18.71661	2019-12-04 15:09:18.71661
196316de-16eb-11ea-8a37-a7e3e1de9873	193a8eee-16eb-11ea-8a37-4f72c68eb48d	19624c0e-16eb-11ea-8a37-bb3cee04e723	HIHATOPEN	1	0	0.5	Eb3	2019-12-04 15:09:18.726919	2019-12-04 15:09:18.726919
19646156-16eb-11ea-8a37-77e5de26f387	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1963c34a-16eb-11ea-8a37-fbe8db72f648	KICK	1	0	1	C2	2019-12-04 15:09:18.73548	2019-12-04 15:09:18.73548
196674fa-16eb-11ea-8a37-4301a23bc4d4	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1965395a-16eb-11ea-8a37-170989048423	TOM	1	0	1	G5	2019-12-04 15:09:18.748957	2019-12-04 15:09:18.748957
196904d6-16eb-11ea-8a37-d7a1f5775322	193a8eee-16eb-11ea-8a37-4f72c68eb48d	1967c378-16eb-11ea-8a37-c7654faf7926	SNARE	1	0	1	Db4	2019-12-04 15:09:18.765793	2019-12-04 15:09:18.765793
196c2cba-16eb-11ea-8a37-67b66b1e3303	193a8eee-16eb-11ea-8a37-4f72c68eb48d	196a3cc0-16eb-11ea-8a37-8b1d0b385e0d	HIHATOPEN	1	0	0.5	D3	2019-12-04 15:09:18.786464	2019-12-04 15:09:18.786464
196fc1fe-16eb-11ea-8a37-f7a6aec60e90	196d485c-16eb-11ea-8a37-3b9fc50a2c86	196eeb08-16eb-11ea-8a37-a7ccb0849a23	SNARE	1	0	1	Db4	2019-12-04 15:09:18.809973	2019-12-04 15:09:18.809973
1971640a-16eb-11ea-8a37-8f2acfcd2a2a	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19709930-16eb-11ea-8a37-1f5aa4259d3c	TOM	1	0	1	F3	2019-12-04 15:09:18.820675	2019-12-04 15:09:18.820675
1972febe-16eb-11ea-8a37-1b5106545568	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19723664-16eb-11ea-8a37-c3fabc2d00c5	KICK	1	0	1	Ab1	2019-12-04 15:09:18.831198	2019-12-04 15:09:18.831198
19752158-16eb-11ea-8a37-f37e40a839c5	196d485c-16eb-11ea-8a37-3b9fc50a2c86	1973d460-16eb-11ea-8a37-773a912a51b8	KICK	1	0	1	Bb1	2019-12-04 15:09:18.845159	2019-12-04 15:09:18.845159
1977c296-16eb-11ea-8a37-bfc7eff9a9fc	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19767fa8-16eb-11ea-8a37-9ba2e7fa8e99	HIHAT	1	0	0.5	G8	2019-12-04 15:09:18.862407	2019-12-04 15:09:18.862407
197a2112-16eb-11ea-8a37-e32ee540421e	196d485c-16eb-11ea-8a37-3b9fc50a2c86	197906ce-16eb-11ea-8a37-fbbbf695b9fc	HIHATOPEN	1	0	0.5	E7	2019-12-04 15:09:18.877939	2019-12-04 15:09:18.877939
197c4b4a-16eb-11ea-8a37-53c2f8686e99	196d485c-16eb-11ea-8a37-3b9fc50a2c86	197b3cc8-16eb-11ea-8a37-d3b98e62981c	HIHATOPEN	1	0	0.5	G8	2019-12-04 15:09:18.892145	2019-12-04 15:09:18.892145
197e241a-16eb-11ea-8a37-2f9edf4f67e0	196d485c-16eb-11ea-8a37-3b9fc50a2c86	197d58b4-16eb-11ea-8a37-6703cc65c5cb	KICK	1	0	1	A1	2019-12-04 15:09:18.904226	2019-12-04 15:09:18.904226
197fc23e-16eb-11ea-8a37-af7c151433da	196d485c-16eb-11ea-8a37-3b9fc50a2c86	197ef462-16eb-11ea-8a37-138e9f0909b1	TOM	1	0	1	E3	2019-12-04 15:09:18.914839	2019-12-04 15:09:18.914839
19814ffa-16eb-11ea-8a37-2b74f059fd88	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19809196-16eb-11ea-8a37-b74fe60b38e3	HIHAT	1	0	0.5	G8	2019-12-04 15:09:18.925037	2019-12-04 15:09:18.925037
1982d938-16eb-11ea-8a37-6bee34da105f	196d485c-16eb-11ea-8a37-3b9fc50a2c86	198216f6-16eb-11ea-8a37-33f5cf989d1e	TOM	1	0	1	G2	2019-12-04 15:09:18.935089	2019-12-04 15:09:18.935089
1984cc66-16eb-11ea-8a37-2bb333ccef58	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19839a1c-16eb-11ea-8a37-93909955ca5d	SNARE	1	0	1	Db44	2019-12-04 15:09:18.94787	2019-12-04 15:09:18.94787
198748f6-16eb-11ea-8a37-cf6dc7ab1e4e	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19860db0-16eb-11ea-8a37-934ed863b73f	TOM	1	0	1	E3	2019-12-04 15:09:18.964133	2019-12-04 15:09:18.964133
1989aa60-16eb-11ea-8a37-17d4b5cbf20a	196d485c-16eb-11ea-8a37-3b9fc50a2c86	1988935a-16eb-11ea-8a37-5b8c14d7b83b	TOM	1	0	1	e2	2019-12-04 15:09:18.979759	2019-12-04 15:09:18.979759
198bd538-16eb-11ea-8a37-2b59b2b6c67d	196d485c-16eb-11ea-8a37-3b9fc50a2c86	198ac6d4-16eb-11ea-8a37-0bbc5619c7c4	SNARE	1	0	1	f9	2019-12-04 15:09:18.993982	2019-12-04 15:09:18.993982
198dbbb4-16eb-11ea-8a37-47e23af31b63	196d485c-16eb-11ea-8a37-3b9fc50a2c86	198ce5ea-16eb-11ea-8a37-37c1f0dff6d3	KICK	1	0	1	Bb1	2019-12-04 15:09:19.006433	2019-12-04 15:09:19.006433
198f689c-16eb-11ea-8a37-dfa6759ced03	196d485c-16eb-11ea-8a37-3b9fc50a2c86	198e92fa-16eb-11ea-8a37-c7b25aeb5cf6	HIHAT	1	0	0.5	Bb8	2019-12-04 15:09:19.01739	2019-12-04 15:09:19.01739
1990f8ba-16eb-11ea-8a37-773053024553	196d485c-16eb-11ea-8a37-3b9fc50a2c86	1990390c-16eb-11ea-8a37-cfa7d4b23d24	TOM	1	0	1	A2	2019-12-04 15:09:19.027657	2019-12-04 15:09:19.027657
19927fe6-16eb-11ea-8a37-af80b25b1420	196d485c-16eb-11ea-8a37-3b9fc50a2c86	1991bdc2-16eb-11ea-8a37-af60dd7f4b04	HIHATOPEN	1	0	0.5	e7	2019-12-04 15:09:19.037586	2019-12-04 15:09:19.037586
19948192-16eb-11ea-8a37-57c46eb1676d	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19934958-16eb-11ea-8a37-637676e23b66	HIHATOPEN	1	0	0.5	g8	2019-12-04 15:09:19.050793	2019-12-04 15:09:19.050793
1996f260-16eb-11ea-8a37-6b166fe97728	196d485c-16eb-11ea-8a37-3b9fc50a2c86	1995bc56-16eb-11ea-8a37-3747940a5e3f	CRASH	1	0	1	Eb8	2019-12-04 15:09:19.066808	2019-12-04 15:09:19.066808
19994542-16eb-11ea-8a37-0f00d0e763e7	196d485c-16eb-11ea-8a37-3b9fc50a2c86	19982d9c-16eb-11ea-8a37-13b60279c4f6	HIHAT	1	0	0.5	G8	2019-12-04 15:09:19.082044	2019-12-04 15:09:19.082044
199df6f0-16eb-11ea-8a37-6f72ea8b2506	199a5e8c-16eb-11ea-8a37-0f841ec0351d	199d2d56-16eb-11ea-8a37-534ff7e94cb4	TOM	1	0	1	F5	2019-12-04 15:09:19.112786	2019-12-04 15:09:19.112786
199f95a0-16eb-11ea-8a37-cb5982dbeccc	199a5e8c-16eb-11ea-8a37-0f841ec0351d	199ecf12-16eb-11ea-8a37-9b60875f833e	SNARE	1	0	1	Eb3	2019-12-04 15:09:19.123424	2019-12-04 15:09:19.123424
19a12640-16eb-11ea-8a37-f3f440e1a94c	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19a05b52-16eb-11ea-8a37-8b39b6eed3cc	HIHATOPEN	1	0	1	A8	2019-12-04 15:09:19.133573	2019-12-04 15:09:19.133573
19a5c60a-16eb-11ea-8a37-8facadf57d30	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19a4fcb6-16eb-11ea-8a37-fff5fca1e56d	HIHATOPEN	1	0	1	E6	2019-12-04 15:09:19.163966	2019-12-04 15:09:19.163966
19a82cba-16eb-11ea-8a37-5bd095cd6f7c	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19a6f93a-16eb-11ea-8a37-9b535bef0ed1	SNARE	1	0	1	A#5	2019-12-04 15:09:19.179719	2019-12-04 15:09:19.179719
19aa969e-16eb-11ea-8a37-e353d70b6cf8	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19a9640e-16eb-11ea-8a37-7f57d56a7c77	KICK	1	0	1	F#8	2019-12-04 15:09:19.19554	2019-12-04 15:09:19.19554
19acc018-16eb-11ea-8a37-6be546252c7f	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19aba9a8-16eb-11ea-8a37-6b72a7ad4309	TOM	1	0	1	F6	2019-12-04 15:09:19.209696	2019-12-04 15:09:19.209696
19aedb28-16eb-11ea-8a37-e70be5117858	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19add1ce-16eb-11ea-8a37-275cf9ca883c	SNARE	1	0	1	E8	2019-12-04 15:09:19.223503	2019-12-04 15:09:19.223503
19b06d6c-16eb-11ea-8a37-1306ae3ccc72	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19afa580-16eb-11ea-8a37-4391eea88957	SNARE	1	0	1	E8	2019-12-04 15:09:19.233796	2019-12-04 15:09:19.233796
19b200b4-16eb-11ea-8a37-97791ac7ed22	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19b13a76-16eb-11ea-8a37-7b5ef5b92275	TOM	1	0	1	G#3	2019-12-04 15:09:19.244115	2019-12-04 15:09:19.244115
19b39744-16eb-11ea-8a37-d7d7cec8bfbe	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19b2c418-16eb-11ea-8a37-ab6cd6e1301b	CRASH	1	0	4	D#8	2019-12-04 15:09:19.25451	2019-12-04 15:09:19.25451
19b523e8-16eb-11ea-8a37-4f9b73548241	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19b45e90-16eb-11ea-8a37-f75052a115ad	CRASH	1	0	4	B7	2019-12-04 15:09:19.26468	2019-12-04 15:09:19.26468
19b7a672-16eb-11ea-8a37-17acd5a9826a	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19b6676c-16eb-11ea-8a37-cff6018583e9	SNARE	1	0	1	E7	2019-12-04 15:09:19.281112	2019-12-04 15:09:19.281112
19ba331a-16eb-11ea-8a37-17946d0f883b	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19b8f414-16eb-11ea-8a37-df914959fbec	TOM	1	0	1	A#5	2019-12-04 15:09:19.297823	2019-12-04 15:09:19.297823
19bc70c6-16eb-11ea-8a37-d75db7467944	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19bb4e62-16eb-11ea-8a37-eb063558665a	HIHATOPEN	1	0	1	F#8	2019-12-04 15:09:19.312498	2019-12-04 15:09:19.312498
19be9b12-16eb-11ea-8a37-679843431540	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19bd8632-16eb-11ea-8a37-bffa003f1a24	KICK	1	0	1	D#2	2019-12-04 15:09:19.326695	2019-12-04 15:09:19.326695
19c04084-16eb-11ea-8a37-1be15412e432	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19bf73f2-16eb-11ea-8a37-8bea02e8b5d7	SNARE	1	0	1	A#3	2019-12-04 15:09:19.337435	2019-12-04 15:09:19.337435
19c1d46c-16eb-11ea-8a37-7758d59de534	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19c10d34-16eb-11ea-8a37-f72b69f674a4	KICK	1	0	1	B8	2019-12-04 15:09:19.347835	2019-12-04 15:09:19.347835
19c3720e-16eb-11ea-8a37-9769126b821b	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19c29c08-16eb-11ea-8a37-df20d264bb21	KICK	1	0	1	D9	2019-12-04 15:09:19.358413	2019-12-04 15:09:19.358413
19c4fee4-16eb-11ea-8a37-ab0387c54435	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19c43982-16eb-11ea-8a37-4be0f5978c59	CRASH	1	0	1	E7	2019-12-04 15:09:19.368589	2019-12-04 15:09:19.368589
19c77426-16eb-11ea-8a37-53597ddac2a1	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19c63a48-16eb-11ea-8a37-874f006f49ed	TOM	1	0	1	E8	2019-12-04 15:09:19.384662	2019-12-04 15:09:19.384662
19c9e332-16eb-11ea-8a37-27a2f8787e8f	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19c8a990-16eb-11ea-8a37-77c6bad60b34	TOM	1	0	1	G7	2019-12-04 15:09:19.400634	2019-12-04 15:09:19.400634
19cc15da-16eb-11ea-8a37-671e6c1681c9	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19cafb96-16eb-11ea-8a37-dff8abf718f1	HIHAT	1	0	1	B9	2019-12-04 15:09:19.415027	2019-12-04 15:09:19.415027
19ce4ae4-16eb-11ea-8a37-3bef2d501d19	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19cd364a-16eb-11ea-8a37-3fe7e645df66	CRASH	1	0	1	B6	2019-12-04 15:09:19.429438	2019-12-04 15:09:19.429438
19cff150-16eb-11ea-8a37-7f58c9018839	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19cf21d0-16eb-11ea-8a37-873702ab7d1f	SNARE	1	0	1	A3	2019-12-04 15:09:19.44032	2019-12-04 15:09:19.44032
19d18fb0-16eb-11ea-8a37-770ecd49d3e9	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19d0c134-16eb-11ea-8a37-a331edf613dd	TOM	1	0	1	C4	2019-12-04 15:09:19.450932	2019-12-04 15:09:19.450932
19d31be6-16eb-11ea-8a37-e36c25bf044e	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19d25828-16eb-11ea-8a37-736da361b38f	TOM	1	0	1	F#8	2019-12-04 15:09:19.461098	2019-12-04 15:09:19.461098
19d4aaf6-16eb-11ea-8a37-a7ab4677a2bb	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19d3e904-16eb-11ea-8a37-9f0dad3fdc07	TOM	1	0	1	Ab4	2019-12-04 15:09:19.471313	2019-12-04 15:09:19.471313
19d72164-16eb-11ea-8a37-ebd8e10c070f	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19d5e95c-16eb-11ea-8a37-eb978b3c46db	HIHATOPEN	1	0	1	X	2019-12-04 15:09:19.487445	2019-12-04 15:09:19.487445
19d990a2-16eb-11ea-8a37-532ee5abf691	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19d859bc-16eb-11ea-8a37-1f2f3d8ddfc9	TOM	1	0	1	F#8	2019-12-04 15:09:19.503385	2019-12-04 15:09:19.503385
19dbc55c-16eb-11ea-8a37-53149e48367c	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19daaaf0-16eb-11ea-8a37-b77584c5cfaa	SNARE	1	0	1	Bb5	2019-12-04 15:09:19.517854	2019-12-04 15:09:19.517854
19dde418-16eb-11ea-8a37-83087afac8da	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19dcd974-16eb-11ea-8a37-7b7dfd1624b3	CRASH	1	0	1	F#4	2019-12-04 15:09:19.531751	2019-12-04 15:09:19.531751
19df7df0-16eb-11ea-8a37-dbb2207ce4f3	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19deb12c-16eb-11ea-8a37-b39a5de469f2	SNARE	1	0	1	B3	2019-12-04 15:09:19.54224	2019-12-04 15:09:19.54224
19e117e6-16eb-11ea-8a37-9fbab99b04ab	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19e050d6-16eb-11ea-8a37-e7da872f755e	TOM	1	0	1	D#6	2019-12-04 15:09:19.552739	2019-12-04 15:09:19.552739
19e2a584-16eb-11ea-8a37-2ffa87c21b79	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19e1e45a-16eb-11ea-8a37-ffc74a1e7408	CRASH	1	0	1	B5	2019-12-04 15:09:19.562923	2019-12-04 15:09:19.562923
19e42d46-16eb-11ea-8a37-b3cb69970cae	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19e36b2c-16eb-11ea-8a37-9b3521e69465	SNARE	1	0	1	X	2019-12-04 15:09:19.572939	2019-12-04 15:09:19.572939
19e69de2-16eb-11ea-8a37-63ebf8a8f668	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19e567b0-16eb-11ea-8a37-af9f28606085	SNARE	1	0	1	B4	2019-12-04 15:09:19.588921	2019-12-04 15:09:19.588921
19e90c30-16eb-11ea-8a37-4fb6c799cbf4	199a5e8c-16eb-11ea-8a37-0f841ec0351d	19e7d626-16eb-11ea-8a37-33c47dcef27d	TOM	1	0	1	F#8	2019-12-04 15:09:19.604859	2019-12-04 15:09:19.604859
19ee532a-16eb-11ea-8a37-a775451ac730	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19ed57d6-16eb-11ea-8a37-674c56b39f28	TOM	1	0	1	Eb2	2019-12-04 15:09:19.639369	2019-12-04 15:09:19.639369
19f02704-16eb-11ea-8a37-87f86d41d1ed	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19ef4b04-16eb-11ea-8a37-ff86ca418007	KICK	1	0	1	Ab2	2019-12-04 15:09:19.651357	2019-12-04 15:09:19.651357
19f1d536-16eb-11ea-8a37-dff42bcf8bef	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19f0ffe4-16eb-11ea-8a37-0fcf3caf46f9	SNARE	1	0	1	D8	2019-12-04 15:09:19.662414	2019-12-04 15:09:19.662414
19f3986c-16eb-11ea-8a37-1f7225f8665b	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19f2b686-16eb-11ea-8a37-6bc4b64fb8a8	KICK	1	0	1	Db4	2019-12-04 15:09:19.673937	2019-12-04 15:09:19.673937
19f5af1c-16eb-11ea-8a37-ab1a7482e6c4	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19f47368-16eb-11ea-8a37-0fb19d8234df	TOM	1	0	1	X	2019-12-04 15:09:19.687636	2019-12-04 15:09:19.687636
19f845f6-16eb-11ea-8a37-93989c75ef97	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19f6f0a2-16eb-11ea-8a37-0fa3b0fe765b	TOM	1	0	1	Eb6	2019-12-04 15:09:19.704563	2019-12-04 15:09:19.704563
19fa71a0-16eb-11ea-8a37-afab7c146986	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19f9771e-16eb-11ea-8a37-0744d009b542	SNARE	1	0	1	X	2019-12-04 15:09:19.718898	2019-12-04 15:09:19.718898
19fc9ebc-16eb-11ea-8a37-97c092227058	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19fb7f78-16eb-11ea-8a37-0fd586076f20	SNARE	1	0	1	F2	2019-12-04 15:09:19.733046	2019-12-04 15:09:19.733046
19fea982-16eb-11ea-8a37-b7c4a1c30484	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19fdd28c-16eb-11ea-8a37-634ce52786ca	TOM	1	0	1	A7	2019-12-04 15:09:19.746488	2019-12-04 15:09:19.746488
1a004b66-16eb-11ea-8a37-4b16583cb4fc	19ea21a6-16eb-11ea-8a37-cb712a6674d9	19ff80c8-16eb-11ea-8a37-2b6ddc251eed	TOM	1	0	1	A7	2019-12-04 15:09:19.75721	2019-12-04 15:09:19.75721
1a01e110-16eb-11ea-8a37-f301b5eb27ee	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a011cda-16eb-11ea-8a37-3f5e45f90d2f	HIHATOPEN	1	0	1	B9	2019-12-04 15:09:19.767565	2019-12-04 15:09:19.767565
1a0366ca-16eb-11ea-8a37-4f5fa63c70bc	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a02a4b0-16eb-11ea-8a37-df7a3301b53f	SNARE	1	0	1	E4	2019-12-04 15:09:19.777499	2019-12-04 15:09:19.777499
1a0587fc-16eb-11ea-8a37-972123f4e7e9	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a04455e-16eb-11ea-8a37-d399bca5ce76	SNARE	1	0	1	B8	2019-12-04 15:09:19.791509	2019-12-04 15:09:19.791509
1a0801b2-16eb-11ea-8a37-db9f2c412d13	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a06cbc6-16eb-11ea-8a37-0bde5ac53b8e	TOM	1	0	1	A3	2019-12-04 15:09:19.80776	2019-12-04 15:09:19.80776
1a0a5ab6-16eb-11ea-8a37-b7dc1eed80c1	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a0942b6-16eb-11ea-8a37-ff37076807a7	HIHAT	1	0	1	B9	2019-12-04 15:09:19.823141	2019-12-04 15:09:19.823141
1a0c8c82-16eb-11ea-8a37-bbffa8392cc8	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a0b789c-16eb-11ea-8a37-67acb9c83761	TOM	1	0	1	A6	2019-12-04 15:09:19.837462	2019-12-04 15:09:19.837462
1a0e7eca-16eb-11ea-8a37-a340e49714a6	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a0d9f50-16eb-11ea-8a37-f7c230db0ff1	HIHAT	1	0	1	B9	2019-12-04 15:09:19.850278	2019-12-04 15:09:19.850278
1a101640-16eb-11ea-8a37-c7614be33795	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a0f4e68-16eb-11ea-8a37-9f6925841781	HIHAT	1	0	1	F#9	2019-12-04 15:09:19.860719	2019-12-04 15:09:19.860719
1a11a83e-16eb-11ea-8a37-d72b99d5fb0e	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a10e048-16eb-11ea-8a37-5ffb431e8518	CRASH	1	0	1	B2	2019-12-04 15:09:19.871007	2019-12-04 15:09:19.871007
1a133d2a-16eb-11ea-8a37-8fc485655052	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a1276b0-16eb-11ea-8a37-bf3d5fbd2946	SNARE	1	0	1	D8	2019-12-04 15:09:19.881359	2019-12-04 15:09:19.881359
1a154822-16eb-11ea-8a37-cb7fbeef47fe	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a1412c2-16eb-11ea-8a37-7ff61d461243	SNARE	1	0	1	X	2019-12-04 15:09:19.894752	2019-12-04 15:09:19.894752
1a17cf48-16eb-11ea-8a37-6b33745e260d	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a1689c6-16eb-11ea-8a37-7369800aa6c5	CRASH	1	0	1	D6	2019-12-04 15:09:19.911284	2019-12-04 15:09:19.911284
1a1a2522-16eb-11ea-8a37-4f2b7d422580	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a190f70-16eb-11ea-8a37-cb72da2cf2de	CRASH	1	0	4	E6	2019-12-04 15:09:19.926622	2019-12-04 15:09:19.926622
1a1c578e-16eb-11ea-8a37-83aa5752ea2f	19ea21a6-16eb-11ea-8a37-cb712a6674d9	1a1b4592-16eb-11ea-8a37-c3ceebf49e08	CRASH	1	0	4	g8	2019-12-04 15:09:19.941034	2019-12-04 15:09:19.941034
\.


--
-- Data for Name: instrument_meme; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.instrument_meme (id, instrument_id, name, created_at, updated_at) FROM stdin;
150d4e42-16eb-11ea-8a37-9f13ba8058d9	150bc66c-16eb-11ea-8a37-83d91cc4d60b	Earth	2019-12-04 15:09:11.453652	2019-12-04 15:09:11.453652
151bbb9e-16eb-11ea-8a37-8b3aa9761ebd	151b16ee-16eb-11ea-8a37-7755b75f4dfb	Water	2019-12-04 15:09:11.548434	2019-12-04 15:09:11.548434
1521449c-16eb-11ea-8a37-cfb026c17202	15204e7a-16eb-11ea-8a37-7f93cb6b74b4	Water	2019-12-04 15:09:11.584737	2019-12-04 15:09:11.584737
1526b94a-16eb-11ea-8a37-07e614c471df	1525acd0-16eb-11ea-8a37-cfc6f82ffb5d	Wind	2019-12-04 15:09:11.620191	2019-12-04 15:09:11.620191
1530ca34-16eb-11ea-8a37-eb06351d3b05	152fbc70-16eb-11ea-8a37-2f91c79f438d	Classic	2019-12-04 15:09:11.686459	2019-12-04 15:09:11.686459
1531b340-16eb-11ea-8a37-6bbcb0189865	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hard	2019-12-04 15:09:11.69248	2019-12-04 15:09:11.69248
153295a8-16eb-11ea-8a37-d726f78dc5b3	152fbc70-16eb-11ea-8a37-2f91c79f438d	Hot	2019-12-04 15:09:11.698282	2019-12-04 15:09:11.698282
15336ea6-16eb-11ea-8a37-cbc193f29176	152fbc70-16eb-11ea-8a37-2f91c79f438d	Deep	2019-12-04 15:09:11.703827	2019-12-04 15:09:11.703827
15345fc8-16eb-11ea-8a37-b34083d1a4bf	152fbc70-16eb-11ea-8a37-2f91c79f438d	Progressive	2019-12-04 15:09:11.709981	2019-12-04 15:09:11.709981
1534fc3a-16eb-11ea-8a37-c326886891f1	152fbc70-16eb-11ea-8a37-2f91c79f438d	Easy	2019-12-04 15:09:11.714011	2019-12-04 15:09:11.714011
153598de-16eb-11ea-8a37-ff1ee0964e29	152fbc70-16eb-11ea-8a37-2f91c79f438d	Tropical	2019-12-04 15:09:11.718046	2019-12-04 15:09:11.718046
158b4e5a-16eb-11ea-8a37-379055f90765	158a6738-16eb-11ea-8a37-3706e5d25249	Earth	2019-12-04 15:09:12.279739	2019-12-04 15:09:12.279739
15ce75ae-16eb-11ea-8a37-a3a4ddb2f2fa	15cd8374-16eb-11ea-8a37-8f22eedc54b2	Earth	2019-12-04 15:09:12.719722	2019-12-04 15:09:12.719722
15f58fcc-16eb-11ea-8a37-a3d8b3d4359c	15f4f92c-16eb-11ea-8a37-2f529693f38a	Large	2019-12-04 15:09:12.976084	2019-12-04 15:09:12.976084
15f62d1a-16eb-11ea-8a37-33872fa57ef4	15f4f92c-16eb-11ea-8a37-2f529693f38a	Earth	2019-12-04 15:09:12.980101	2019-12-04 15:09:12.980101
163913d2-16eb-11ea-8a37-a37e7e13c7e1	1637e066-16eb-11ea-8a37-c7f42ae039d6	Small	2019-12-04 15:09:13.418547	2019-12-04 15:09:13.418547
163a49aa-16eb-11ea-8a37-3756d2794d01	1637e066-16eb-11ea-8a37-c7f42ae039d6	Earth	2019-12-04 15:09:13.426416	2019-12-04 15:09:13.426416
1668fef8-16eb-11ea-8a37-832e0cfa76f0	166815c4-16eb-11ea-8a37-634bb3ccef01	Tech	2019-12-04 15:09:13.732571	2019-12-04 15:09:13.732571
1669d94a-16eb-11ea-8a37-1fb86e53240d	166815c4-16eb-11ea-8a37-634bb3ccef01	Electro	2019-12-04 15:09:13.738202	2019-12-04 15:09:13.738202
166a9286-16eb-11ea-8a37-cf5d83d037e0	166815c4-16eb-11ea-8a37-634bb3ccef01	Deep	2019-12-04 15:09:13.742917	2019-12-04 15:09:13.742917
166be29e-16eb-11ea-8a37-57f58dde51d3	166815c4-16eb-11ea-8a37-634bb3ccef01	Cool	2019-12-04 15:09:13.751546	2019-12-04 15:09:13.751546
166c6a66-16eb-11ea-8a37-534bb510557e	166815c4-16eb-11ea-8a37-634bb3ccef01	Classic	2019-12-04 15:09:13.755026	2019-12-04 15:09:13.755026
166cff6c-16eb-11ea-8a37-576996824eda	166815c4-16eb-11ea-8a37-634bb3ccef01	Hard	2019-12-04 15:09:13.758859	2019-12-04 15:09:13.758859
166d8478-16eb-11ea-8a37-5f5c8424781f	166815c4-16eb-11ea-8a37-634bb3ccef01	Progressive	2019-12-04 15:09:13.762246	2019-12-04 15:09:13.762246
166e123a-16eb-11ea-8a37-5351d9d2dd7f	166815c4-16eb-11ea-8a37-634bb3ccef01	Acid	2019-12-04 15:09:13.765874	2019-12-04 15:09:13.765874
169fa606-16eb-11ea-8a37-f7b7574b6a0d	169ea38c-16eb-11ea-8a37-b799503ae436	Fire	2019-12-04 15:09:14.090777	2019-12-04 15:09:14.090777
16c9ea06-16eb-11ea-8a37-0b07371f4fa7	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Fire	2019-12-04 15:09:14.367735	2019-12-04 15:09:14.367735
16cb0c24-16eb-11ea-8a37-d754da32c05c	16c8d008-16eb-11ea-8a37-dbdfe140dd35	Large	2019-12-04 15:09:14.37511	2019-12-04 15:09:14.37511
1787b252-16eb-11ea-8a37-3305aa06439b	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Fire	2019-12-04 15:09:15.61152	2019-12-04 15:09:15.61152
17883a9c-16eb-11ea-8a37-3f4fa168fe5a	1787297c-16eb-11ea-8a37-6f3014c0a6fc	Small	2019-12-04 15:09:15.615023	2019-12-04 15:09:15.615023
17e5c702-16eb-11ea-8a37-1b3a177009af	17e50f74-16eb-11ea-8a37-e3561e92fad1	Cool	2019-12-04 15:09:16.227992	2019-12-04 15:09:16.227992
17e680b6-16eb-11ea-8a37-43fd42fd3e77	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hot	2019-12-04 15:09:16.232708	2019-12-04 15:09:16.232708
17e73bf0-16eb-11ea-8a37-3b862f035a9a	17e50f74-16eb-11ea-8a37-e3561e92fad1	Classic	2019-12-04 15:09:16.23746	2019-12-04 15:09:16.23746
17e7f3ce-16eb-11ea-8a37-bb9155ec92cf	17e50f74-16eb-11ea-8a37-e3561e92fad1	Deep	2019-12-04 15:09:16.242254	2019-12-04 15:09:16.242254
17e918ee-16eb-11ea-8a37-ebed0210b735	17e50f74-16eb-11ea-8a37-e3561e92fad1	Hard	2019-12-04 15:09:16.249704	2019-12-04 15:09:16.249704
1860ff62-16eb-11ea-8a37-bf93f7e0e669	1860788a-16eb-11ea-8a37-87eb83753fe4	Water	2019-12-04 15:09:17.035658	2019-12-04 15:09:17.035658
1887325e-16eb-11ea-8a37-ab76039b8a28	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Large	2019-12-04 15:09:17.285874	2019-12-04 15:09:17.285874
1888503a-16eb-11ea-8a37-e77abeb6bc57	18860e06-16eb-11ea-8a37-1fe3e47ff5a8	Water	2019-12-04 15:09:17.293198	2019-12-04 15:09:17.293198
19144cb6-16eb-11ea-8a37-bb582c474a9f	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Water	2019-12-04 15:09:18.210576	2019-12-04 15:09:18.210576
19150520-16eb-11ea-8a37-abcf39311815	19138e3e-16eb-11ea-8a37-0b2895a9ceb9	Small	2019-12-04 15:09:18.215338	2019-12-04 15:09:18.215338
193bb1ac-16eb-11ea-8a37-6f0a6f583680	193a8eee-16eb-11ea-8a37-4f72c68eb48d	Wind	2019-12-04 15:09:18.468708	2019-12-04 15:09:18.468708
196e0f12-16eb-11ea-8a37-9b82675c21fc	196d485c-16eb-11ea-8a37-3b9fc50a2c86	Wind	2019-12-04 15:09:18.798863	2019-12-04 15:09:18.798863
199b68ae-16eb-11ea-8a37-231d908b573a	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Wind	2019-12-04 15:09:19.096067	2019-12-04 15:09:19.096067
199c6470-16eb-11ea-8a37-93f21e9b7630	199a5e8c-16eb-11ea-8a37-0f841ec0351d	Large	2019-12-04 15:09:19.102517	2019-12-04 15:09:19.102517
19eb3654-16eb-11ea-8a37-7b148d9f70a1	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Wind	2019-12-04 15:09:19.619049	2019-12-04 15:09:19.619049
19ec3df6-16eb-11ea-8a37-37751278cd16	19ea21a6-16eb-11ea-8a37-cb712a6674d9	Small	2019-12-04 15:09:19.625786	2019-12-04 15:09:19.625786
\.


--
-- Data for Name: program; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program (id, user_id, library_id, state, key, tempo, type, name, density, created_at, updated_at) FROM stdin;
1a21695e-16eb-11ea-8a37-471123a2fa62	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Published	G minor	130	Macro	Deep, from Cool to Hot	0	2019-12-04 15:09:19.973666	2019-12-04 15:09:19.973666
1a2b79da-16eb-11ea-8a37-83af2bc21c26	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Published	C	130	Macro	Deep, from Hot to Cool	0	2019-12-04 15:09:20.039874	2019-12-04 15:09:20.039874
1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Ebm	130	Macro	Earth to Fire	0	2019-12-04 15:09:20.112953	2019-12-04 15:09:20.112953
1a40808c-16eb-11ea-8a37-cb54f3323275	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Gm	130	Macro	Earth to Water	0	2019-12-04 15:09:20.177583	2019-12-04 15:09:20.177583
1a46a2be-16eb-11ea-8a37-7396524c6a27	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Cm	130	Macro	Earth to Wind	0	2019-12-04 15:09:20.218163	2019-12-04 15:09:20.218163
1a4c0f74-16eb-11ea-8a37-c7d65a03364a	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	G	130	Macro	Fire to Earth	0	2019-12-04 15:09:20.253834	2019-12-04 15:09:20.253834
1a533b1e-16eb-11ea-8a37-1b89f02a00e8	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	E	130	Macro	Fire to Water	0	2019-12-04 15:09:20.300614	2019-12-04 15:09:20.300614
1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	G	130	Macro	Fire to Wind	0	2019-12-04 15:09:20.375079	2019-12-04 15:09:20.375079
1a696574-16eb-11ea-8a37-0b820d50edf4	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	G	130	Macro	Water to Earth	0	2019-12-04 15:09:20.445845	2019-12-04 15:09:20.445845
1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Macro	Water to Fire	0	2019-12-04 15:09:20.516138	2019-12-04 15:09:20.516138
1a7f128e-16eb-11ea-8a37-f7bc27184026	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	G	130	Macro	Water to Wind	0	2019-12-04 15:09:20.588046	2019-12-04 15:09:20.588046
1a88b7da-16eb-11ea-8a37-6b20c565ae15	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Ebm	130	Macro	Wind to Earth	0	2019-12-04 15:09:20.651251	2019-12-04 15:09:20.651251
1a93d8ea-16eb-11ea-8a37-07702a221e45	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Bm	130	Macro	Wind to Fire	0	2019-12-04 15:09:20.724194	2019-12-04 15:09:20.724194
1a9a8ff0-16eb-11ea-8a37-5736573db704	14796768-16eb-11ea-8a37-330f05571303	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Ebm	130	Macro	Wind to Water	0	2019-12-04 15:09:20.768212	2019-12-04 15:09:20.768212
1aa1ad62-16eb-11ea-8a37-e3635cda90ac	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F	130	Main	Earth 3	0.6	2019-12-04 15:09:20.814841	2019-12-04 15:09:20.814841
1ad8543e-16eb-11ea-8a37-d3089a6baf4d	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Main	Earth Earth	0.6	2019-12-04 15:09:21.173135	2019-12-04 15:09:21.173135
1b048734-16eb-11ea-8a37-eb0f9b6b1f89	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Bb	130	Main	Earth First	0.6	2019-12-04 15:09:21.462791	2019-12-04 15:09:21.462791
1b561f0e-16eb-11ea-8a37-2373d7d5daa1	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Bb-	130	Main	Earth Knyght	0.6	2019-12-04 15:09:21.997399	2019-12-04 15:09:21.997399
1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Db	130	Main	Earth Mert	0.6	2019-12-04 15:09:22.257869	2019-12-04 15:09:22.257869
1ba99e54-16eb-11ea-8a37-0753aaf26025	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	D	130	Main	Earth Rudy	0.6	2019-12-04 15:09:22.544544	2019-12-04 15:09:22.544544
1bd515ac-16eb-11ea-8a37-2711b44f5abc	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F#	130	Main	Earth'm	0.6	2019-12-04 15:09:22.829544	2019-12-04 15:09:22.829544
1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Db	130	Main	Earthen Satay	0.6	2019-12-04 15:09:23.161123	2019-12-04 15:09:23.161123
1c46f5aa-16eb-11ea-8a37-d3b0641778a1	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	E-	130	Main	Fire Babes	0.6	2019-12-04 15:09:23.57576	2019-12-04 15:09:23.57576
1c9163a6-16eb-11ea-8a37-f39bdf338693	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Main	Fire Camp	0.6	2019-12-04 15:09:24.063529	2019-12-04 15:09:24.063529
1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C#-	130	Main	Fire Fire	0.6	2019-12-04 15:09:24.358748	2019-12-04 15:09:24.358748
1cd6c720-16eb-11ea-8a37-772e7139de8e	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Ab	130	Main	Fire NBD	0.6	2019-12-04 15:09:24.518405	2019-12-04 15:09:24.518405
1d054da2-16eb-11ea-8a37-e76bae68ab4e	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Eb-	130	Main	Fire Pal	0.6	2019-12-04 15:09:24.823175	2019-12-04 15:09:24.823175
1d44afe2-16eb-11ea-8a37-abee7f9bcb41	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C-	130	Main	Fire Tom Perez	0.6	2019-12-04 15:09:25.238565	2019-12-04 15:09:25.238565
1d725d2a-16eb-11ea-8a37-7bccb481c597	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	A-	130	Main	Fired	0.6	2019-12-04 15:09:25.537923	2019-12-04 15:09:25.537923
1da04118-16eb-11ea-8a37-3f1dce9d6424	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F#-	130	Main	Fireggio	0.6	2019-12-04 15:09:25.838811	2019-12-04 15:09:25.838811
1ddd768c-16eb-11ea-8a37-ab599777e83d	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Published	C	130	Main	I'll House You	0.55	2019-12-04 15:09:26.239804	2019-12-04 15:09:26.239804
1df7d432-16eb-11ea-8a37-97c25b2a6298	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	B-	130	Main	Water Bun	0.6	2019-12-04 15:09:26.412713	2019-12-04 15:09:26.412713
1e1d5928-16eb-11ea-8a37-9751a208273e	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	E-	130	Main	Water Galq	0.6	2019-12-04 15:09:26.658467	2019-12-04 15:09:26.658467
1e5b5f98-16eb-11ea-8a37-df0dc125933d	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F	130	Main	Water Me Up	0.6	2019-12-04 15:09:27.064988	2019-12-04 15:09:27.064988
1e9a52e8-16eb-11ea-8a37-8357d918bfda	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	A-	130	Main	Water Probe	0.6	2019-12-04 15:09:27.477447	2019-12-04 15:09:27.477447
1ed3893c-16eb-11ea-8a37-53c677a170ca	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F#-	130	Main	Water Rotcher	0.6	2019-12-04 15:09:27.852616	2019-12-04 15:09:27.852616
1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C#	130	Main	Water Water	0.6	2019-12-04 15:09:28.170323	2019-12-04 15:09:28.170323
1f27ae54-16eb-11ea-8a37-638aed0c1ccf	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C#-	130	Main	Water Wibs	0.6	2019-12-04 15:09:28.403917	2019-12-04 15:09:28.403917
1f55b3f8-16eb-11ea-8a37-b30fd772ba12	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Main	Waternity	0.6	2019-12-04 15:09:28.70546	2019-12-04 15:09:28.70546
1f729be4-16eb-11ea-8a37-f7402b31f897	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F-	130	Main	Wind 88	0.6	2019-12-04 15:09:28.894984	2019-12-04 15:09:28.894984
1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Eb	130	Main	Wind Bagz	0.6	2019-12-04 15:09:29.212013	2019-12-04 15:09:29.212013
1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F	130	Main	Wind Mole	0.6	2019-12-04 15:09:29.669195	2019-12-04 15:09:29.669195
20203966-16eb-11ea-8a37-1f6f4f9c48ae	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	D-	130	Main	Wind Terb	0.6	2019-12-04 15:09:30.032778	2019-12-04 15:09:30.032778
20630ebc-16eb-11ea-8a37-af1c14cc01bc	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F	130	Main	Wind Wind	0.6	2019-12-04 15:09:30.470774	2019-12-04 15:09:30.470774
2078ee76-16eb-11ea-8a37-b7162aa1ef0f	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Main	Wind X	0.6	2019-12-04 15:09:30.61412	2019-12-04 15:09:30.61412
208ccf18-16eb-11ea-8a37-cfe47cc0feee	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	Eb-	130	Main	Windu Kush	0.6	2019-12-04 15:09:30.744401	2019-12-04 15:09:30.744401
20ba8084-16eb-11ea-8a37-cb38a312de67	14c688fe-16eb-11ea-8a37-a798275d637c	1509102a-16eb-11ea-8a37-4764c2a771db	Published	F	130	Main	Windy Baby Hey	0.6	2019-12-04 15:09:31.043843	2019-12-04 15:09:31.043843
20d07cc2-16eb-11ea-8a37-c32a94270435	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Rhythm	2-Step Prototype (Break)	0	2019-12-04 15:09:31.187937	2019-12-04 15:09:31.187937
215f31b0-16eb-11ea-8a37-4359224b0012	14802d14-16eb-11ea-8a37-ff75275e34c2	1509102a-16eb-11ea-8a37-4764c2a771db	Published	C	130	Rhythm	2-Step Prototype (Steady)	0	2019-12-04 15:09:32.123195	2019-12-04 15:09:32.123195
2298444a-16eb-11ea-8a37-5389fe5c6d7c	14796768-16eb-11ea-8a37-330f05571303	15085f36-16eb-11ea-8a37-57a336f886a8	Published	C	130	Rhythm	2-Step Shuffle Beat	0	2019-12-04 15:09:34.174938	2019-12-04 15:09:34.174938
\.


--
-- Data for Name: program_meme; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_meme (id, name, program_id, created_at, updated_at) FROM stdin;
1a23058e-16eb-11ea-8a37-cfa78ec7bede	Deep	1a21695e-16eb-11ea-8a37-471123a2fa62	2019-12-04 15:09:19.984546	2019-12-04 15:09:19.984546
1a2cc3e4-16eb-11ea-8a37-af1f186e4fb8	Deep	1a2b79da-16eb-11ea-8a37-83af2bc21c26	2019-12-04 15:09:20.048404	2019-12-04 15:09:20.048404
1aa27efe-16eb-11ea-8a37-87bd66811cbb	Earth	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	2019-12-04 15:09:20.819972	2019-12-04 15:09:20.819972
1ad96ef0-16eb-11ea-8a37-0f64503a5b82	Earth	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	2019-12-04 15:09:21.180004	2019-12-04 15:09:21.180004
1b051618-16eb-11ea-8a37-076a3db07728	Earth	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	2019-12-04 15:09:21.466374	2019-12-04 15:09:21.466374
1b5737f4-16eb-11ea-8a37-531250fed8ff	Earth	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	2019-12-04 15:09:22.004507	2019-12-04 15:09:22.004507
1b7f1620-16eb-11ea-8a37-1320c0b85fa5	Earth	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	2019-12-04 15:09:22.2658	2019-12-04 15:09:22.2658
1baa64ba-16eb-11ea-8a37-8b3d91b250e4	Earth	1ba99e54-16eb-11ea-8a37-0753aaf26025	2019-12-04 15:09:22.54952	2019-12-04 15:09:22.54952
1bd61718-16eb-11ea-8a37-6f9123602964	Earth	1bd515ac-16eb-11ea-8a37-2711b44f5abc	2019-12-04 15:09:22.83614	2019-12-04 15:09:22.83614
1c08705a-16eb-11ea-8a37-c70f0fb49d28	Earth	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	2019-12-04 15:09:23.165934	2019-12-04 15:09:23.165934
1c47b2b0-16eb-11ea-8a37-776609438fb1	Fire	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	2019-12-04 15:09:23.5806	2019-12-04 15:09:23.5806
1c928aec-16eb-11ea-8a37-cf1e2fccf0be	Fire	1c9163a6-16eb-11ea-8a37-f39bdf338693	2019-12-04 15:09:24.071094	2019-12-04 15:09:24.071094
1cbef320-16eb-11ea-8a37-5b45cb857b68	Fire	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	2019-12-04 15:09:24.362276	2019-12-04 15:09:24.362276
1cd74bdc-16eb-11ea-8a37-bb87a8f4f903	Fire	1cd6c720-16eb-11ea-8a37-772e7139de8e	2019-12-04 15:09:24.521824	2019-12-04 15:09:24.521824
1d066f70-16eb-11ea-8a37-63975ad9666e	Fire	1d054da2-16eb-11ea-8a37-e76bae68ab4e	2019-12-04 15:09:24.830619	2019-12-04 15:09:24.830619
1d47bb24-16eb-11ea-8a37-bf16f34f876a	Fire	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	2019-12-04 15:09:25.25859	2019-12-04 15:09:25.25859
1d736f9e-16eb-11ea-8a37-7f18146b3cac	Fire	1d725d2a-16eb-11ea-8a37-7bccb481c597	2019-12-04 15:09:25.544969	2019-12-04 15:09:25.544969
1da0c4b2-16eb-11ea-8a37-53213caed3bc	Fire	1da04118-16eb-11ea-8a37-3f1dce9d6424	2019-12-04 15:09:25.842177	2019-12-04 15:09:25.842177
1dde39f0-16eb-11ea-8a37-c72dc076ce43	Deep	1ddd768c-16eb-11ea-8a37-ab599777e83d	2019-12-04 15:09:26.244808	2019-12-04 15:09:26.244808
1ddef9c6-16eb-11ea-8a37-1f97531a0819	Hard	1ddd768c-16eb-11ea-8a37-ab599777e83d	2019-12-04 15:09:26.249666	2019-12-04 15:09:26.249666
1ddfc5d6-16eb-11ea-8a37-1fb042c344e2	Classic	1ddd768c-16eb-11ea-8a37-ab599777e83d	2019-12-04 15:09:26.254889	2019-12-04 15:09:26.254889
1df860b4-16eb-11ea-8a37-634443a54b99	Water	1df7d432-16eb-11ea-8a37-97c25b2a6298	2019-12-04 15:09:26.416343	2019-12-04 15:09:26.416343
1e1e689a-16eb-11ea-8a37-9f138d819a78	Water	1e1d5928-16eb-11ea-8a37-9751a208273e	2019-12-04 15:09:26.665413	2019-12-04 15:09:26.665413
1e5c21bc-16eb-11ea-8a37-e77f49366187	Water	1e5b5f98-16eb-11ea-8a37-df0dc125933d	2019-12-04 15:09:27.069966	2019-12-04 15:09:27.069966
1e9b0de6-16eb-11ea-8a37-9bfc1d211488	Water	1e9a52e8-16eb-11ea-8a37-8357d918bfda	2019-12-04 15:09:27.482291	2019-12-04 15:09:27.482291
1ed47522-16eb-11ea-8a37-7f42c0c77119	Water	1ed3893c-16eb-11ea-8a37-53c677a170ca	2019-12-04 15:09:27.858676	2019-12-04 15:09:27.858676
1f04bebc-16eb-11ea-8a37-0348fca8fdc8	Water	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	2019-12-04 15:09:28.175002	2019-12-04 15:09:28.175002
1f28d02c-16eb-11ea-8a37-e39971fc1bcd	Water	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	2019-12-04 15:09:28.41136	2019-12-04 15:09:28.41136
1f56e2aa-16eb-11ea-8a37-9fae89797991	Water	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	2019-12-04 15:09:28.71329	2019-12-04 15:09:28.71329
1f73bd80-16eb-11ea-8a37-9bec95a351d9	Wind	1f729be4-16eb-11ea-8a37-f7402b31f897	2019-12-04 15:09:28.902425	2019-12-04 15:09:28.902425
1fa4031e-16eb-11ea-8a37-437730688e2e	Wind	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	2019-12-04 15:09:29.218778	2019-12-04 15:09:29.218778
1fe99640-16eb-11ea-8a37-7b114fa3b7fc	Wind	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	2019-12-04 15:09:29.674842	2019-12-04 15:09:29.674842
20213ec4-16eb-11ea-8a37-2f021d9a9ae8	Wind	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2019-12-04 15:09:30.039475	2019-12-04 15:09:30.039475
20641618-16eb-11ea-8a37-eb7ebf8776dc	Wind	20630ebc-16eb-11ea-8a37-af1c14cc01bc	2019-12-04 15:09:30.47747	2019-12-04 15:09:30.47747
20799f24-16eb-11ea-8a37-e345025bdf46	Wind	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	2019-12-04 15:09:30.6187	2019-12-04 15:09:30.6187
208df67c-16eb-11ea-8a37-9bd46d627955	Wind	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2019-12-04 15:09:30.751977	2019-12-04 15:09:30.751977
20bbb36e-16eb-11ea-8a37-bbbd28b9857e	Wind	20ba8084-16eb-11ea-8a37-cb38a312de67	2019-12-04 15:09:31.051709	2019-12-04 15:09:31.051709
20d137ac-16eb-11ea-8a37-2738fa6f0b3e	Fire	20d07cc2-16eb-11ea-8a37-c32a94270435	2019-12-04 15:09:31.192692	2019-12-04 15:09:31.192692
20d1f2d2-16eb-11ea-8a37-ff93d37fe185	Earth	20d07cc2-16eb-11ea-8a37-c32a94270435	2019-12-04 15:09:31.197438	2019-12-04 15:09:31.197438
20d2a7fe-16eb-11ea-8a37-77955e92c38a	Wind	20d07cc2-16eb-11ea-8a37-c32a94270435	2019-12-04 15:09:31.20217	2019-12-04 15:09:31.20217
20d362e8-16eb-11ea-8a37-6790f5571069	Break	20d07cc2-16eb-11ea-8a37-c32a94270435	2019-12-04 15:09:31.20695	2019-12-04 15:09:31.20695
20d410bc-16eb-11ea-8a37-d7a9a9155311	Water	20d07cc2-16eb-11ea-8a37-c32a94270435	2019-12-04 15:09:31.211419	2019-12-04 15:09:31.211419
215fe182-16eb-11ea-8a37-67aa014456b1	Fire	215f31b0-16eb-11ea-8a37-4359224b0012	2019-12-04 15:09:32.127716	2019-12-04 15:09:32.127716
21608ccc-16eb-11ea-8a37-27a36eb6f936	Steady	215f31b0-16eb-11ea-8a37-4359224b0012	2019-12-04 15:09:32.132097	2019-12-04 15:09:32.132097
216138ca-16eb-11ea-8a37-ef7729a7a186	Wind	215f31b0-16eb-11ea-8a37-4359224b0012	2019-12-04 15:09:32.136498	2019-12-04 15:09:32.136498
21625980-16eb-11ea-8a37-4f36e2077755	Water	215f31b0-16eb-11ea-8a37-4359224b0012	2019-12-04 15:09:32.143889	2019-12-04 15:09:32.143889
21637acc-16eb-11ea-8a37-eb874d2bbd14	Earth	215f31b0-16eb-11ea-8a37-4359224b0012	2019-12-04 15:09:32.151295	2019-12-04 15:09:32.151295
2298fc3c-16eb-11ea-8a37-cb6a11e588f5	Electro	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.179669	2019-12-04 15:09:34.179669
2299ac68-16eb-11ea-8a37-93662cd3c5b6	Tropical	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.184185	2019-12-04 15:09:34.184185
229a5a82-16eb-11ea-8a37-6b872e4c354d	Progressive	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.188626	2019-12-04 15:09:34.188626
229b0cfc-16eb-11ea-8a37-a355ecb3b541	Cool	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.193219	2019-12-04 15:09:34.193219
229bc25a-16eb-11ea-8a37-0bdbf06c0869	Easy	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.197864	2019-12-04 15:09:34.197864
229c7448-16eb-11ea-8a37-1b6a552f3e34	Hot	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.202405	2019-12-04 15:09:34.202405
229d945e-16eb-11ea-8a37-43dc6b99094a	Tech	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.209757	2019-12-04 15:09:34.209757
229eb938-16eb-11ea-8a37-eb2d10fb023d	Acid	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.217276	2019-12-04 15:09:34.217276
229feefc-16eb-11ea-8a37-b320c5af6881	Classic	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.22514	2019-12-04 15:09:34.22514
22a11d86-16eb-11ea-8a37-cb89d0829dbb	Hard	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.232927	2019-12-04 15:09:34.232927
22a2354a-16eb-11ea-8a37-1fe8bd58ef78	Deep	2298444a-16eb-11ea-8a37-5389fe5c6d7c	2019-12-04 15:09:34.240041	2019-12-04 15:09:34.240041
\.


--
-- Data for Name: program_sequence; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence (id, program_id, name, key, density, total, tempo, created_at, updated_at) FROM stdin;
1a244886-16eb-11ea-8a37-cf3c3c9d96ac	1a21695e-16eb-11ea-8a37-471123a2fa62	from Cool	G minor	0.5	0	130	2019-12-04 15:09:19.992835	2019-12-04 15:09:19.992835
1a24fbf0-16eb-11ea-8a37-2fdf600a9aee	1a21695e-16eb-11ea-8a37-471123a2fa62	to Hot	C	0.7	0	130	2019-12-04 15:09:19.997671	2019-12-04 15:09:19.997671
1a2e2068-16eb-11ea-8a37-ef0533ef5fba	1a2b79da-16eb-11ea-8a37-83af2bc21c26	to Cool	Bb Minor	0.5	0	130	2019-12-04 15:09:20.057204	2019-12-04 15:09:20.057204
1a2f4d80-16eb-11ea-8a37-73f889d7c09c	1a2b79da-16eb-11ea-8a37-83af2bc21c26	from Hot	C	0.7	0	130	2019-12-04 15:09:20.065002	2019-12-04 15:09:20.065002
1a37a458-16eb-11ea-8a37-2f73f5c0b0d4	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	Passion Volcano	Ebm	0.6	0	130	2019-12-04 15:09:20.119627	2019-12-04 15:09:20.119627
1a3889ae-16eb-11ea-8a37-4784548d9418	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	Exploding	B	0.6	0	130	2019-12-04 15:09:20.125695	2019-12-04 15:09:20.125695
1a41c172-16eb-11ea-8a37-0b6e3d341033	1a40808c-16eb-11ea-8a37-cb54f3323275	Arrival	F	0.6	0	130	2019-12-04 15:09:20.186084	2019-12-04 15:09:20.186084
1a42def4-16eb-11ea-8a37-c704ce65d26d	1a40808c-16eb-11ea-8a37-cb54f3323275	Castaway	C minor	0.6	0	130	2019-12-04 15:09:20.193307	2019-12-04 15:09:20.193307
1a473e36-16eb-11ea-8a37-f7494c6a1982	1a46a2be-16eb-11ea-8a37-7396524c6a27	Air	D	0.6	0	130	2019-12-04 15:09:20.222282	2019-12-04 15:09:20.222282
1a47d4e0-16eb-11ea-8a37-c3b03f4d9d7e	1a46a2be-16eb-11ea-8a37-7396524c6a27	Ground	C minor	0.6	0	130	2019-12-04 15:09:20.226137	2019-12-04 15:09:20.226137
1a4d24d6-16eb-11ea-8a37-d3e61fbdb319	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	Aspiration	G	0.6	0	130	2019-12-04 15:09:20.26097	2019-12-04 15:09:20.26097
1a4e05fe-16eb-11ea-8a37-d3de7a11c4c1	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	Defeat	Am	0.6	0	130	2019-12-04 15:09:20.266722	2019-12-04 15:09:20.266722
1a540dc8-16eb-11ea-8a37-df75efe2d46b	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	Glory	F	0.6	0	130	2019-12-04 15:09:20.306141	2019-12-04 15:09:20.306141
1a54e360-16eb-11ea-8a37-77478a5e7c51	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	Volcanic Island	E	0.6	0	130	2019-12-04 15:09:20.311553	2019-12-04 15:09:20.311553
1a55ae9e-16eb-11ea-8a37-cbab1330bce7	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	Sex on the Beach	Am	0.6	0	130	2019-12-04 15:09:20.316811	2019-12-04 15:09:20.316811
1a60e872-16eb-11ea-8a37-77304e7348ed	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	Dreams	E	0.6	0	130	2019-12-04 15:09:20.390287	2019-12-04 15:09:20.390287
1a6224da-16eb-11ea-8a37-bb3e2ad1b14f	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	Smoke in the Air	G	0.6	0	130	2019-12-04 15:09:20.398444	2019-12-04 15:09:20.398444
1a633992-16eb-11ea-8a37-c304a696b32a	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	Waking	Am	0.6	0	130	2019-12-04 15:09:20.405475	2019-12-04 15:09:20.405475
1a6aae0c-16eb-11ea-8a37-33f00d137784	1a696574-16eb-11ea-8a37-0b820d50edf4	Irrigation	G	0.6	0	130	2019-12-04 15:09:20.454434	2019-12-04 15:09:20.454434
1a6bc9d6-16eb-11ea-8a37-83874d8d8429	1a696574-16eb-11ea-8a37-0b820d50edf4	Growth	Am	0.6	0	130	2019-12-04 15:09:20.461758	2019-12-04 15:09:20.461758
1a6ce3f2-16eb-11ea-8a37-77384ce769c9	1a696574-16eb-11ea-8a37-0b820d50edf4	Nourishment	C	0.6	0	130	2019-12-04 15:09:20.468999	2019-12-04 15:09:20.468999
1a74ee6c-16eb-11ea-8a37-4375e532e42c	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	Engine	Dm	0.6	0	130	2019-12-04 15:09:20.521533	2019-12-04 15:09:20.521533
1a75b6f8-16eb-11ea-8a37-f34ecd483181	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	Hydrant	C	0.6	0	130	2019-12-04 15:09:20.526753	2019-12-04 15:09:20.526753
1a767b60-16eb-11ea-8a37-d35abf13115a	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	Steam	C	0.6	0	130	2019-12-04 15:09:20.531781	2019-12-04 15:09:20.531781
1a80267e-16eb-11ea-8a37-9357cb6613d9	1a7f128e-16eb-11ea-8a37-f7bc27184026	Dew	Am	0.6	0	130	2019-12-04 15:09:20.595134	2019-12-04 15:09:20.595134
1a813848-16eb-11ea-8a37-df2d624fcf27	1a7f128e-16eb-11ea-8a37-f7bc27184026	Fog	C	0.6	0	130	2019-12-04 15:09:20.602142	2019-12-04 15:09:20.602142
1a82062e-16eb-11ea-8a37-afb00f07ff0e	1a7f128e-16eb-11ea-8a37-f7bc27184026	Rain	G	0.6	0	130	2019-12-04 15:09:20.607419	2019-12-04 15:09:20.607419
1a89ff8c-16eb-11ea-8a37-bb2f916072d2	1a88b7da-16eb-11ea-8a37-6b20c565ae15	Rolling Stone	D	0.6	0	130	2019-12-04 15:09:20.659646	2019-12-04 15:09:20.659646
1a8b3f78-16eb-11ea-8a37-0f347035832a	1a88b7da-16eb-11ea-8a37-6b20c565ae15	Freedom	Bm	0.6	0	130	2019-12-04 15:09:20.667828	2019-12-04 15:09:20.667828
1a8c80f4-16eb-11ea-8a37-a394291e2629	1a88b7da-16eb-11ea-8a37-6b20c565ae15	Open Road Tumbleweed	Ebm	0.6	0	130	2019-12-04 15:09:20.676069	2019-12-04 15:09:20.676069
1a949dde-16eb-11ea-8a37-a3001ec1e7d1	1a93d8ea-16eb-11ea-8a37-07702a221e45	Wilderness	A	0.6	0	130	2019-12-04 15:09:20.729268	2019-12-04 15:09:20.729268
1a956958-16eb-11ea-8a37-77271a6399c6	1a93d8ea-16eb-11ea-8a37-07702a221e45	Stoke the Flames	Bm	0.6	0	130	2019-12-04 15:09:20.734465	2019-12-04 15:09:20.734465
1a9bc9c4-16eb-11ea-8a37-f7a7f3a858cc	1a9a8ff0-16eb-11ea-8a37-5736573db704	Afloat	A	0.6	0	130	2019-12-04 15:09:20.776207	2019-12-04 15:09:20.776207
1a9ce444-16eb-11ea-8a37-17b842802167	1a9a8ff0-16eb-11ea-8a37-5736573db704	Asink	A	0.6	0	130	2019-12-04 15:09:20.783465	2019-12-04 15:09:20.783465
1aa3537e-16eb-11ea-8a37-3f78668e99c6	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	I	F	0.6	16	130	2019-12-04 15:09:20.825585	2019-12-04 15:09:20.825585
1aa41bec-16eb-11ea-8a37-cb001de521d8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	A	F	0.6	32	130	2019-12-04 15:09:20.830796	2019-12-04 15:09:20.830796
1aa4e7de-16eb-11ea-8a37-6fc52690cb46	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	0	F	0.6	16	130	2019-12-04 15:09:20.836008	2019-12-04 15:09:20.836008
1ada479e-16eb-11ea-8a37-335205636a25	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	A	C	0.6	32	130	2019-12-04 15:09:21.18579	2019-12-04 15:09:21.18579
1b05a1c8-16eb-11ea-8a37-b33d735b96f3	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	Chorus	Bb	0.6	32	130	2019-12-04 15:09:21.470037	2019-12-04 15:09:21.470037
1b06277e-16eb-11ea-8a37-dff953bf0d2f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	Interlude Big	Bb	0.6	8	130	2019-12-04 15:09:21.473474	2019-12-04 15:09:21.473474
1b06acf8-16eb-11ea-8a37-bb222eefaad5	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	Interlude Small	Bb	0.6	8	130	2019-12-04 15:09:21.476889	2019-12-04 15:09:21.476889
1b07add8-16eb-11ea-8a37-23837b49d45a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	Verse	Bb	0.6	16	130	2019-12-04 15:09:21.483451	2019-12-04 15:09:21.483451
1b585878-16eb-11ea-8a37-177d78dceb2a	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	I	Bb-	0.6	32	130	2019-12-04 15:09:22.011912	2019-12-04 15:09:22.011912
1b596eac-16eb-11ea-8a37-b38fc0bda9d3	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	II	Bb-	0.6	48	130	2019-12-04 15:09:22.019081	2019-12-04 15:09:22.019081
1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	A	Bb-	0.6	64	130	2019-12-04 15:09:22.024321	2019-12-04 15:09:22.024321
1b8050bc-16eb-11ea-8a37-d7fc249aba5c	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	0	Db	0.6	16	130	2019-12-04 15:09:22.273935	2019-12-04 15:09:22.273935
1b818d6a-16eb-11ea-8a37-8ba20207b4c3	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	A	Db	0.6	32	130	2019-12-04 15:09:22.28204	2019-12-04 15:09:22.28204
1bab5320-16eb-11ea-8a37-8b16dec1d61d	1ba99e54-16eb-11ea-8a37-0753aaf26025	C.	D	0.6	48	130	2019-12-04 15:09:22.555795	2019-12-04 15:09:22.555795
1bac8c36-16eb-11ea-8a37-7fcc71be05b7	1ba99e54-16eb-11ea-8a37-0753aaf26025	B	D	0.6	32	130	2019-12-04 15:09:22.563823	2019-12-04 15:09:22.563823
1badc402-16eb-11ea-8a37-1bc388cfea8d	1ba99e54-16eb-11ea-8a37-0753aaf26025	C	D	0.6	32	130	2019-12-04 15:09:22.571771	2019-12-04 15:09:22.571771
1baefbc4-16eb-11ea-8a37-d75c5e8bc803	1ba99e54-16eb-11ea-8a37-0753aaf26025	A	D	0.6	32	130	2019-12-04 15:09:22.579754	2019-12-04 15:09:22.579754
1bd71c76-16eb-11ea-8a37-735907092e35	1bd515ac-16eb-11ea-8a37-2711b44f5abc	A	F#	0.6	32	130	2019-12-04 15:09:22.842849	2019-12-04 15:09:22.842849
1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	1bd515ac-16eb-11ea-8a37-2711b44f5abc	B	F#	0.6	32	130	2019-12-04 15:09:22.849228	2019-12-04 15:09:22.849228
1c0936a2-16eb-11ea-8a37-8364cbc8c053	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	B	Db	0.6	32	130	2019-12-04 15:09:23.171083	2019-12-04 15:09:23.171083
1c09f8bc-16eb-11ea-8a37-cf52ab961f92	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	A	Db	0.6	16	130	2019-12-04 15:09:23.176064	2019-12-04 15:09:23.176064
1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	C	Db	0.6	16	130	2019-12-04 15:09:23.180998	2019-12-04 15:09:23.180998
1c48797a-16eb-11ea-8a37-a3a556866028	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	Verse	E-	0.6	16	130	2019-12-04 15:09:23.585686	2019-12-04 15:09:23.585686
1c493f18-16eb-11ea-8a37-8f6cbc29c491	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	I	E-	0.6	16	130	2019-12-04 15:09:23.590764	2019-12-04 15:09:23.590764
1c4a03bc-16eb-11ea-8a37-bb738df95e32	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	Bridge	E-	0.6	32	130	2019-12-04 15:09:23.595798	2019-12-04 15:09:23.595798
1c4b349e-16eb-11ea-8a37-dbff775ad0b6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	II	E-	0.6	24	130	2019-12-04 15:09:23.603553	2019-12-04 15:09:23.603553
1c4c7156-16eb-11ea-8a37-6bae7a457ff7	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	Prechorus	E-	0.6	32	130	2019-12-04 15:09:23.611633	2019-12-04 15:09:23.611633
1c4daec2-16eb-11ea-8a37-5f66632a9cce	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	Chorus	E-	0.6	16	130	2019-12-04 15:09:23.619789	2019-12-04 15:09:23.619789
1c93b138-16eb-11ea-8a37-7329e2a7875a	1c9163a6-16eb-11ea-8a37-f39bdf338693	A	C	0.6	16	130	2019-12-04 15:09:24.078617	2019-12-04 15:09:24.078617
1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	1c9163a6-16eb-11ea-8a37-f39bdf338693	B	C	0.6	32	130	2019-12-04 15:09:24.086199	2019-12-04 15:09:24.086199
1cbf7fac-16eb-11ea-8a37-4f301c22d062	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	A	C#-	0.6	32	130	2019-12-04 15:09:24.365852	2019-12-04 15:09:24.365852
1cd7d1d8-16eb-11ea-8a37-171c57af8178	1cd6c720-16eb-11ea-8a37-772e7139de8e	A	Ab	0.6	16	130	2019-12-04 15:09:24.525261	2019-12-04 15:09:24.525261
1cd8d7a4-16eb-11ea-8a37-0f8c441e8cf1	1cd6c720-16eb-11ea-8a37-772e7139de8e	0	Ab	0.6	16	130	2019-12-04 15:09:24.531942	2019-12-04 15:09:24.531942
1cd9d9ec-16eb-11ea-8a37-574c05744ae9	1cd6c720-16eb-11ea-8a37-772e7139de8e	00	Ab	0.6	24	130	2019-12-04 15:09:24.538572	2019-12-04 15:09:24.538572
1cdae328-16eb-11ea-8a37-bbdd268629d3	1cd6c720-16eb-11ea-8a37-772e7139de8e	000	Ab	0.6	32	130	2019-12-04 15:09:24.545362	2019-12-04 15:09:24.545362
1d078568-16eb-11ea-8a37-67a5a8ed19ba	1d054da2-16eb-11ea-8a37-e76bae68ab4e	0	Eb-	0.6	16	130	2019-12-04 15:09:24.837728	2019-12-04 15:09:24.837728
1d089be2-16eb-11ea-8a37-4fc8b9f51686	1d054da2-16eb-11ea-8a37-e76bae68ab4e	B	Eb-	0.6	32	130	2019-12-04 15:09:24.844813	2019-12-04 15:09:24.844813
1d09b5a4-16eb-11ea-8a37-83859494d2b8	1d054da2-16eb-11ea-8a37-e76bae68ab4e	A	Eb-	0.6	16	130	2019-12-04 15:09:24.852035	2019-12-04 15:09:24.852035
1d48abce-16eb-11ea-8a37-bb1acedee3d5	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	B	C-	0.6	16	130	2019-12-04 15:09:25.264795	2019-12-04 15:09:25.264795
1d493fd0-16eb-11ea-8a37-c3d403a460cb	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	A	C-	0.6	32	130	2019-12-04 15:09:25.268589	2019-12-04 15:09:25.268589
1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	1d725d2a-16eb-11ea-8a37-7bccb481c597	NC	A-	0.6	16	130	2019-12-04 15:09:25.550363	2019-12-04 15:09:25.550363
1d75115a-16eb-11ea-8a37-0f72ac0c0642	1d725d2a-16eb-11ea-8a37-7bccb481c597	A	A-	0.6	32	130	2019-12-04 15:09:25.555668	2019-12-04 15:09:25.555668
1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	1d725d2a-16eb-11ea-8a37-7bccb481c597	0	A-	0.6	16	130	2019-12-04 15:09:25.560703	2019-12-04 15:09:25.560703
1da152ce-16eb-11ea-8a37-9fc5142d4a34	1da04118-16eb-11ea-8a37-3f1dce9d6424	A	F#-	0.6	16	130	2019-12-04 15:09:25.845811	2019-12-04 15:09:25.845811
1da1e7c0-16eb-11ea-8a37-532dcab2368f	1da04118-16eb-11ea-8a37-3f1dce9d6424	F#-	F#-	0.6	32	130	2019-12-04 15:09:25.849594	2019-12-04 15:09:25.849594
1da26f60-16eb-11ea-8a37-2bc557f8bc59	1da04118-16eb-11ea-8a37-3f1dce9d6424	0	F#-	0.6	32	130	2019-12-04 15:09:25.853116	2019-12-04 15:09:25.853116
1da2f0fc-16eb-11ea-8a37-2bcc13b87204	1da04118-16eb-11ea-8a37-3f1dce9d6424	F#5	F#-	0.6	32	130	2019-12-04 15:09:25.856447	2019-12-04 15:09:25.856447
1de11102-16eb-11ea-8a37-57f184fd0e32	1ddd768c-16eb-11ea-8a37-ab599777e83d	Breakdown A	G minor	0.6	16	130	2019-12-04 15:09:26.263403	2019-12-04 15:09:26.263403
1de24f86-16eb-11ea-8a37-cb7cafc70798	1ddd768c-16eb-11ea-8a37-ab599777e83d	Drop	C	0.4	32	130	2019-12-04 15:09:26.271563	2019-12-04 15:09:26.271563
1de39a08-16eb-11ea-8a37-738d22dbcff6	1ddd768c-16eb-11ea-8a37-ab599777e83d	Breakdown B	G minor	0.8	16	130	2019-12-04 15:09:26.279976	2019-12-04 15:09:26.279976
1df8eed0-16eb-11ea-8a37-e36af6c4759b	1df7d432-16eb-11ea-8a37-97c25b2a6298	A	B-	0.6	32	130	2019-12-04 15:09:26.419961	2019-12-04 15:09:26.419961
1df9790e-16eb-11ea-8a37-ef7004e09057	1df7d432-16eb-11ea-8a37-97c25b2a6298	0	B-	0.6	16	130	2019-12-04 15:09:26.423508	2019-12-04 15:09:26.423508
1e1f3a86-16eb-11ea-8a37-b381af4def76	1e1d5928-16eb-11ea-8a37-9751a208273e	B	E-	0.6	12	130	2019-12-04 15:09:26.670786	2019-12-04 15:09:26.670786
1e200588-16eb-11ea-8a37-831127ae524a	1e1d5928-16eb-11ea-8a37-9751a208273e	A	E-	0.6	12	130	2019-12-04 15:09:26.675992	2019-12-04 15:09:26.675992
1e20cc20-16eb-11ea-8a37-c753e73531cf	1e1d5928-16eb-11ea-8a37-9751a208273e	X	E-	0.6	16	130	2019-12-04 15:09:26.681101	2019-12-04 15:09:26.681101
1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	1e5b5f98-16eb-11ea-8a37-df0dc125933d	B	F	0.6	32	130	2019-12-04 15:09:27.074934	2019-12-04 15:09:27.074934
1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	1e5b5f98-16eb-11ea-8a37-df0dc125933d	C	F	0.6	8	130	2019-12-04 15:09:27.080048	2019-12-04 15:09:27.080048
1e5e6e4a-16eb-11ea-8a37-d360931995ab	1e5b5f98-16eb-11ea-8a37-df0dc125933d	A	F	0.6	16	130	2019-12-04 15:09:27.085026	2019-12-04 15:09:27.085026
1e9c5250-16eb-11ea-8a37-5f16ec2708bb	1e9a52e8-16eb-11ea-8a37-8357d918bfda	A	A-	0.6	16	130	2019-12-04 15:09:27.490564	2019-12-04 15:09:27.490564
1e9d86de-16eb-11ea-8a37-93f2df4c3e77	1e9a52e8-16eb-11ea-8a37-8357d918bfda	0	A-	0.6	16	130	2019-12-04 15:09:27.498503	2019-12-04 15:09:27.498503
1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	1e9a52e8-16eb-11ea-8a37-8357d918bfda	B	A-	0.6	16	130	2019-12-04 15:09:27.506626	2019-12-04 15:09:27.506626
1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	1ed3893c-16eb-11ea-8a37-53c677a170ca	I	F#-	0.6	16	130	2019-12-04 15:09:27.864972	2019-12-04 15:09:27.864972
1ed6499c-16eb-11ea-8a37-6fee705e3702	1ed3893c-16eb-11ea-8a37-53c677a170ca	A	F#-	0.6	16	130	2019-12-04 15:09:27.870648	2019-12-04 15:09:27.870648
1ed725a6-16eb-11ea-8a37-6bc976ac0efb	1ed3893c-16eb-11ea-8a37-53c677a170ca	0	F#-	0.6	64	130	2019-12-04 15:09:27.876301	2019-12-04 15:09:27.876301
1f057e2e-16eb-11ea-8a37-9735e522beba	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	A	C#	0.6	32	130	2019-12-04 15:09:28.179882	2019-12-04 15:09:28.179882
1f29fede-16eb-11ea-8a37-73b7c0d29f05	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	A	C#-	0.6	16	130	2019-12-04 15:09:28.419084	2019-12-04 15:09:28.419084
1f2e3a12-16eb-11ea-8a37-abfe012fa045	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	B	C#-	0.6	16	130	2019-12-04 15:09:28.446788	2019-12-04 15:09:28.446788
1f581580-16eb-11ea-8a37-7f9a9d48a442	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	A	C	0.6	32	130	2019-12-04 15:09:28.721129	2019-12-04 15:09:28.721129
1f74e8e0-16eb-11ea-8a37-1777ac953c6b	1f729be4-16eb-11ea-8a37-f7402b31f897	0	F-	0.6	16	130	2019-12-04 15:09:28.910076	2019-12-04 15:09:28.910076
1f75fc3a-16eb-11ea-8a37-7b0486545750	1f729be4-16eb-11ea-8a37-f7402b31f897	A	F-	0.6	32	130	2019-12-04 15:09:28.917118	2019-12-04 15:09:28.917118
1f770fda-16eb-11ea-8a37-e7fcf1bf9286	1f729be4-16eb-11ea-8a37-f7402b31f897	00	F-	0.6	24	130	2019-12-04 15:09:28.924181	2019-12-04 15:09:28.924181
1f7820b4-16eb-11ea-8a37-d775fb8e679a	1f729be4-16eb-11ea-8a37-f7402b31f897	000	F-	0.6	32	130	2019-12-04 15:09:28.931168	2019-12-04 15:09:28.931168
1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	A	Eb	0.6	32	130	2019-12-04 15:09:29.225499	2019-12-04 15:09:29.225499
1fa5c910-16eb-11ea-8a37-371d2c81de12	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	I	Eb	0.6	16	130	2019-12-04 15:09:29.230396	2019-12-04 15:09:29.230396
1fa68b34-16eb-11ea-8a37-038ef86f9c46	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	II	Eb	0.6	32	130	2019-12-04 15:09:29.235348	2019-12-04 15:09:29.235348
1fa75050-16eb-11ea-8a37-87b444d34878	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	B	Eb	0.6	32	130	2019-12-04 15:09:29.2404	2019-12-04 15:09:29.2404
1feaa38c-16eb-11ea-8a37-57d2cdb26466	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	A	F	0.6	16	130	2019-12-04 15:09:29.681502	2019-12-04 15:09:29.681502
1feb788e-16eb-11ea-8a37-9b619cc86924	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	B	F	0.6	16	130	2019-12-04 15:09:29.687044	2019-12-04 15:09:29.687044
20225cd2-16eb-11ea-8a37-bfcb30311269	20203966-16eb-11ea-8a37-1f6f4f9c48ae	II	D-	0.6	32	130	2019-12-04 15:09:30.04676	2019-12-04 15:09:30.04676
20237a86-16eb-11ea-8a37-0f1bd8573b8e	20203966-16eb-11ea-8a37-1f6f4f9c48ae	A	D-	0.6	16	130	2019-12-04 15:09:30.054095	2019-12-04 15:09:30.054095
202437c8-16eb-11ea-8a37-63e1971d8460	20203966-16eb-11ea-8a37-1f6f4f9c48ae	B	D-	0.6	32	130	2019-12-04 15:09:30.058966	2019-12-04 15:09:30.058966
2024f7ee-16eb-11ea-8a37-bb1b3908b21a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	I	D-	0.6	16	130	2019-12-04 15:09:30.063877	2019-12-04 15:09:30.063877
2025c138-16eb-11ea-8a37-bbfaf9205991	20203966-16eb-11ea-8a37-1f6f4f9c48ae	IIII	D-	0.6	64	130	2019-12-04 15:09:30.069023	2019-12-04 15:09:30.069023
20267dd0-16eb-11ea-8a37-9b8a85645ffc	20203966-16eb-11ea-8a37-1f6f4f9c48ae	III	D-	0.6	48	130	2019-12-04 15:09:30.07387	2019-12-04 15:09:30.07387
20652a3a-16eb-11ea-8a37-3b369a1a1bdb	20630ebc-16eb-11ea-8a37-af1c14cc01bc	A	F	0.6	64	130	2019-12-04 15:09:30.484544	2019-12-04 15:09:30.484544
207a5716-16eb-11ea-8a37-675479e03b84	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	A	C	0.6	32	130	2019-12-04 15:09:30.623375	2019-12-04 15:09:30.623375
208f2682-16eb-11ea-8a37-ff75635a4416	208ccf18-16eb-11ea-8a37-cfe47cc0feee	A	Eb-	0.6	32	130	2019-12-04 15:09:30.759769	2019-12-04 15:09:30.759769
2090403a-16eb-11ea-8a37-e3907a35d9fe	208ccf18-16eb-11ea-8a37-cfe47cc0feee	I	Eb-	0.6	8	130	2019-12-04 15:09:30.766902	2019-12-04 15:09:30.766902
20bcc786-16eb-11ea-8a37-93afc61219c2	20ba8084-16eb-11ea-8a37-cb38a312de67	A	F	0.6	64	130	2019-12-04 15:09:31.058741	2019-12-04 15:09:31.058741
20e32188-16eb-11ea-8a37-df5e09e4df96	20d07cc2-16eb-11ea-8a37-c32a94270435	Beat	C	0	16	130	2019-12-04 15:09:31.310117	2019-12-04 15:09:31.310117
216e00be-16eb-11ea-8a37-73b18b937c1a	215f31b0-16eb-11ea-8a37-4359224b0012	Beat	C	0	16	130	2019-12-04 15:09:32.220249	2019-12-04 15:09:32.220249
22af0bb2-16eb-11ea-8a37-c3cc17fd4302	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Beat	C	0	16	130	2019-12-04 15:09:34.32435	2019-12-04 15:09:34.32435
\.


--
-- Data for Name: program_sequence_binding; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence_binding (id, program_id, program_sequence_id, "offset", created_at, updated_at) FROM stdin;
1a25f55a-16eb-11ea-8a37-b7d63bb64393	1a21695e-16eb-11ea-8a37-471123a2fa62	1a24fbf0-16eb-11ea-8a37-2fdf600a9aee	1	2019-12-04 15:09:20.003898	2019-12-04 15:09:20.003898
1a269c76-16eb-11ea-8a37-53fabc410ad8	1a21695e-16eb-11ea-8a37-471123a2fa62	1a244886-16eb-11ea-8a37-cf3c3c9d96ac	0	2019-12-04 15:09:20.008352	2019-12-04 15:09:20.008352
1a307e62-16eb-11ea-8a37-37010a35a7b7	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a2f4d80-16eb-11ea-8a37-73f889d7c09c	0	2019-12-04 15:09:20.072844	2019-12-04 15:09:20.072844
1a31b192-16eb-11ea-8a37-f71bb9862140	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a2e2068-16eb-11ea-8a37-ef0533ef5fba	1	2019-12-04 15:09:20.080691	2019-12-04 15:09:20.080691
1a396798-16eb-11ea-8a37-0790714b7955	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a3889ae-16eb-11ea-8a37-4784548d9418	1	2019-12-04 15:09:20.131169	2019-12-04 15:09:20.131169
1a3a4de8-16eb-11ea-8a37-2f48cf13837c	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a37a458-16eb-11ea-8a37-2f73f5c0b0d4	0	2019-12-04 15:09:20.13728	2019-12-04 15:09:20.13728
1a3b9a9a-16eb-11ea-8a37-0f1de4dd940d	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a37a458-16eb-11ea-8a37-2f73f5c0b0d4	2	2019-12-04 15:09:20.14578	2019-12-04 15:09:20.14578
1a43fb4a-16eb-11ea-8a37-4fe4560a3bfd	1a40808c-16eb-11ea-8a37-cb54f3323275	1a42def4-16eb-11ea-8a37-c704ce65d26d	0	2019-12-04 15:09:20.200793	2019-12-04 15:09:20.200793
1a44bca6-16eb-11ea-8a37-fbfc3b17d736	1a40808c-16eb-11ea-8a37-cb54f3323275	1a41c172-16eb-11ea-8a37-0b6e3d341033	1	2019-12-04 15:09:20.205791	2019-12-04 15:09:20.205791
1a4868c4-16eb-11ea-8a37-9bd34d01a9b0	1a46a2be-16eb-11ea-8a37-7396524c6a27	1a47d4e0-16eb-11ea-8a37-c3b03f4d9d7e	0	2019-12-04 15:09:20.229933	2019-12-04 15:09:20.229933
1a48fc44-16eb-11ea-8a37-9384ed519968	1a46a2be-16eb-11ea-8a37-7396524c6a27	1a473e36-16eb-11ea-8a37-f7494c6a1982	1	2019-12-04 15:09:20.233724	2019-12-04 15:09:20.233724
1a4ef8a6-16eb-11ea-8a37-27b761ff24b4	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	1a4e05fe-16eb-11ea-8a37-d3de7a11c4c1	1	2019-12-04 15:09:20.27293	2019-12-04 15:09:20.27293
1a4fe8ba-16eb-11ea-8a37-eb1eefebea79	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	1a4d24d6-16eb-11ea-8a37-d3e61fbdb319	0	2019-12-04 15:09:20.279001	2019-12-04 15:09:20.279001
1a567734-16eb-11ea-8a37-572dee279e73	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a540dc8-16eb-11ea-8a37-df75efe2d46b	2	2019-12-04 15:09:20.321951	2019-12-04 15:09:20.321951
1a573746-16eb-11ea-8a37-b7156bfdf7be	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a54e360-16eb-11ea-8a37-77478a5e7c51	0	2019-12-04 15:09:20.326879	2019-12-04 15:09:20.326879
1a5899f6-16eb-11ea-8a37-57ba96eca107	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a55ae9e-16eb-11ea-8a37-cbab1330bce7	1	2019-12-04 15:09:20.335927	2019-12-04 15:09:20.335927
1a6405e8-16eb-11ea-8a37-3f0608242834	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a633992-16eb-11ea-8a37-c304a696b32a	2	2019-12-04 15:09:20.410791	2019-12-04 15:09:20.410791
1a64c956-16eb-11ea-8a37-e3d3d4053237	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a60e872-16eb-11ea-8a37-77304e7348ed	1	2019-12-04 15:09:20.415808	2019-12-04 15:09:20.415808
1a658b3e-16eb-11ea-8a37-73219a619460	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a6224da-16eb-11ea-8a37-bb3e2ad1b14f	0	2019-12-04 15:09:20.420779	2019-12-04 15:09:20.420779
1a6df422-16eb-11ea-8a37-6bcb1ca3c327	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6aae0c-16eb-11ea-8a37-33f00d137784	0	2019-12-04 15:09:20.47597	2019-12-04 15:09:20.47597
1a6ee436-16eb-11ea-8a37-43682d35bf40	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6ce3f2-16eb-11ea-8a37-77384ce769c9	1	2019-12-04 15:09:20.48211	2019-12-04 15:09:20.48211
1a6fd77e-16eb-11ea-8a37-1f7cb6f94684	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6bc9d6-16eb-11ea-8a37-83874d8d8429	2	2019-12-04 15:09:20.488332	2019-12-04 15:09:20.488332
1a773d7a-16eb-11ea-8a37-ef8d16931cd7	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a74ee6c-16eb-11ea-8a37-4375e532e42c	1	2019-12-04 15:09:20.536742	2019-12-04 15:09:20.536742
1a77ff30-16eb-11ea-8a37-1b2369a14bee	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a767b60-16eb-11ea-8a37-d35abf13115a	2	2019-12-04 15:09:20.541708	2019-12-04 15:09:20.541708
1a793cb0-16eb-11ea-8a37-f39b42c63d29	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a75b6f8-16eb-11ea-8a37-f34ecd483181	0	2019-12-04 15:09:20.549817	2019-12-04 15:09:20.549817
1a82cfe6-16eb-11ea-8a37-7b62d23c3bba	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a82062e-16eb-11ea-8a37-afb00f07ff0e	0	2019-12-04 15:09:20.612566	2019-12-04 15:09:20.612566
1a83994e-16eb-11ea-8a37-df81dcee2373	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a813848-16eb-11ea-8a37-df2d624fcf27	1	2019-12-04 15:09:20.617721	2019-12-04 15:09:20.617721
1a845b36-16eb-11ea-8a37-0393d3c1ed26	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a80267e-16eb-11ea-8a37-9357cb6613d9	2	2019-12-04 15:09:20.6227	2019-12-04 15:09:20.6227
1a8d94da-16eb-11ea-8a37-7f8ae8ebfe29	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8c80f4-16eb-11ea-8a37-a394291e2629	0	2019-12-04 15:09:20.68313	2019-12-04 15:09:20.68313
1a8eadac-16eb-11ea-8a37-0340a79d32cc	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8b3f78-16eb-11ea-8a37-0f347035832a	2	2019-12-04 15:09:20.690341	2019-12-04 15:09:20.690341
1a8fb8aa-16eb-11ea-8a37-334554c680fa	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a89ff8c-16eb-11ea-8a37-bb2f916072d2	1	2019-12-04 15:09:20.697197	2019-12-04 15:09:20.697197
1a9629e2-16eb-11ea-8a37-93cb31e58acc	1a93d8ea-16eb-11ea-8a37-07702a221e45	1a956958-16eb-11ea-8a37-77271a6399c6	0	2019-12-04 15:09:20.739403	2019-12-04 15:09:20.739403
1a96ebb6-16eb-11ea-8a37-5b995f453e28	1a93d8ea-16eb-11ea-8a37-07702a221e45	1a949dde-16eb-11ea-8a37-a3001ec1e7d1	1	2019-12-04 15:09:20.744349	2019-12-04 15:09:20.744349
1a9df7b2-16eb-11ea-8a37-5ba2da38ab38	1a9a8ff0-16eb-11ea-8a37-5736573db704	1a9ce444-16eb-11ea-8a37-17b842802167	1	2019-12-04 15:09:20.790547	2019-12-04 15:09:20.790547
1a9f0134-16eb-11ea-8a37-df55db49535f	1a9a8ff0-16eb-11ea-8a37-5736573db704	1a9bc9c4-16eb-11ea-8a37-f7a7f3a858cc	0	2019-12-04 15:09:20.797351	2019-12-04 15:09:20.797351
1ab4a17e-16eb-11ea-8a37-cba18c0a69d1	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	7	2019-12-04 15:09:20.939188	2019-12-04 15:09:20.939188
1ab5383c-16eb-11ea-8a37-2f6fb18d68f4	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	1	2019-12-04 15:09:20.943047	2019-12-04 15:09:20.943047
1ab5cf86-16eb-11ea-8a37-d7b2ae72d46c	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	0	2019-12-04 15:09:20.946918	2019-12-04 15:09:20.946918
1ab66978-16eb-11ea-8a37-e70e5f0677b2	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	3	2019-12-04 15:09:20.950862	2019-12-04 15:09:20.950862
1ab7743a-16eb-11ea-8a37-0f484f6620ef	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	9	2019-12-04 15:09:20.957692	2019-12-04 15:09:20.957692
1ab879ca-16eb-11ea-8a37-4b5c8c7c4ce7	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	13	2019-12-04 15:09:20.964372	2019-12-04 15:09:20.964372
1ab97c44-16eb-11ea-8a37-877488de2572	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	17	2019-12-04 15:09:20.970984	2019-12-04 15:09:20.970984
1aba83c8-16eb-11ea-8a37-2fadaaecb1ac	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	15	2019-12-04 15:09:20.977723	2019-12-04 15:09:20.977723
1abb62c0-16eb-11ea-8a37-73e479b6d052	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	16	2019-12-04 15:09:20.983443	2019-12-04 15:09:20.983443
1abc41fe-16eb-11ea-8a37-2b7d171858d8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	10	2019-12-04 15:09:20.989179	2019-12-04 15:09:20.989179
1abd11b0-16eb-11ea-8a37-b3900bb779f5	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	11	2019-12-04 15:09:20.994497	2019-12-04 15:09:20.994497
1abdeeaa-16eb-11ea-8a37-4b0d9e1ec39e	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	6	2019-12-04 15:09:21.000121	2019-12-04 15:09:21.000121
1abe7bea-16eb-11ea-8a37-6b4048e5e6b8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	5	2019-12-04 15:09:21.003767	2019-12-04 15:09:21.003767
1abf083a-16eb-11ea-8a37-eb5ea8282bad	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	12	2019-12-04 15:09:21.007368	2019-12-04 15:09:21.007368
1abfb10e-16eb-11ea-8a37-13aa815f6383	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	19	2019-12-04 15:09:21.011604	2019-12-04 15:09:21.011604
1ac0556e-16eb-11ea-8a37-9f13df6146f4	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	8	2019-12-04 15:09:21.015845	2019-12-04 15:09:21.015845
1ac0f4c4-16eb-11ea-8a37-f7376e57c359	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	4	2019-12-04 15:09:21.019927	2019-12-04 15:09:21.019927
1ac18eb6-16eb-11ea-8a37-ef6a5f262d06	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	2	2019-12-04 15:09:21.02388	2019-12-04 15:09:21.02388
1ac22808-16eb-11ea-8a37-172fc094430a	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	14	2019-12-04 15:09:21.027807	2019-12-04 15:09:21.027807
1ac2c196-16eb-11ea-8a37-131789756456	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	20	2019-12-04 15:09:21.031732	2019-12-04 15:09:21.031732
1ac3cc76-16eb-11ea-8a37-ebd64d67f749	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	18	2019-12-04 15:09:21.038544	2019-12-04 15:09:21.038544
1ae4121a-16eb-11ea-8a37-f3a6153ac0ca	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	12	2019-12-04 15:09:21.249923	2019-12-04 15:09:21.249923
1ae54d56-16eb-11ea-8a37-1bd034f05dd0	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	15	2019-12-04 15:09:21.258047	2019-12-04 15:09:21.258047
1ae65980-16eb-11ea-8a37-cb960e3aa413	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	3	2019-12-04 15:09:21.264927	2019-12-04 15:09:21.264927
1ae76a32-16eb-11ea-8a37-9f138123ab43	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	0	2019-12-04 15:09:21.271894	2019-12-04 15:09:21.271894
1ae8772e-16eb-11ea-8a37-43b85affb9d5	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	7	2019-12-04 15:09:21.278758	2019-12-04 15:09:21.278758
1ae98e16-16eb-11ea-8a37-3b733ba500bb	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	9	2019-12-04 15:09:21.285895	2019-12-04 15:09:21.285895
1aea5936-16eb-11ea-8a37-af3b59c88e86	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	13	2019-12-04 15:09:21.291108	2019-12-04 15:09:21.291108
1aeb2172-16eb-11ea-8a37-2fa7dd21be88	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	14	2019-12-04 15:09:21.29624	2019-12-04 15:09:21.29624
1aebea3a-16eb-11ea-8a37-8b62a5fc3883	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	4	2019-12-04 15:09:21.30137	2019-12-04 15:09:21.30137
1aecb55a-16eb-11ea-8a37-b7df151b84a0	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	8	2019-12-04 15:09:21.306566	2019-12-04 15:09:21.306566
1aed70da-16eb-11ea-8a37-abcf95acf1bd	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	16	2019-12-04 15:09:21.311413	2019-12-04 15:09:21.311413
1aee0f2c-16eb-11ea-8a37-ffed1cbdf8b0	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	2	2019-12-04 15:09:21.315522	2019-12-04 15:09:21.315522
1aeea6c6-16eb-11ea-8a37-571d54bd01c0	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	11	2019-12-04 15:09:21.319395	2019-12-04 15:09:21.319395
1aef3dac-16eb-11ea-8a37-2371d7ca823f	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	5	2019-12-04 15:09:21.323259	2019-12-04 15:09:21.323259
1af03db0-16eb-11ea-8a37-e783dcce7715	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	10	2019-12-04 15:09:21.329838	2019-12-04 15:09:21.329838
1af14084-16eb-11ea-8a37-7bb8fed32c0b	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	6	2019-12-04 15:09:21.336447	2019-12-04 15:09:21.336447
1af23ce6-16eb-11ea-8a37-2732c0f2021c	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	1	2019-12-04 15:09:21.342924	2019-12-04 15:09:21.342924
1b180f70-16eb-11ea-8a37-7be1c9e32339	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	2	2019-12-04 15:09:21.590678	2019-12-04 15:09:21.590678
1b194016-16eb-11ea-8a37-9b43115c8fa3	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	17	2019-12-04 15:09:21.598496	2019-12-04 15:09:21.598496
1b1a49e8-16eb-11ea-8a37-277d3ef68f63	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	14	2019-12-04 15:09:21.60529	2019-12-04 15:09:21.60529
1b1b6260-16eb-11ea-8a37-f320c0145642	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	5	2019-12-04 15:09:21.612463	2019-12-04 15:09:21.612463
1b1c6e3a-16eb-11ea-8a37-67c4c11f2f21	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	21	2019-12-04 15:09:21.619328	2019-12-04 15:09:21.619328
1b1d7776-16eb-11ea-8a37-13478f906f6c	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	0	2019-12-04 15:09:21.626131	2019-12-04 15:09:21.626131
1b1e3a6c-16eb-11ea-8a37-fbfc0dce8abc	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	12	2019-12-04 15:09:21.631133	2019-12-04 15:09:21.631133
1b1f0104-16eb-11ea-8a37-47b05b789873	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	22	2019-12-04 15:09:21.636202	2019-12-04 15:09:21.636202
1b1fc558-16eb-11ea-8a37-570413a4514a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	13	2019-12-04 15:09:21.641233	2019-12-04 15:09:21.641233
1b209834-16eb-11ea-8a37-9bed6958be5e	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	7	2019-12-04 15:09:21.646627	2019-12-04 15:09:21.646627
1b2156ac-16eb-11ea-8a37-3faf90dc6d39	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	19	2019-12-04 15:09:21.651504	2019-12-04 15:09:21.651504
1b221204-16eb-11ea-8a37-530ba2e2d980	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	16	2019-12-04 15:09:21.656307	2019-12-04 15:09:21.656307
1b22caaa-16eb-11ea-8a37-f39553a62b23	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	9	2019-12-04 15:09:21.661037	2019-12-04 15:09:21.661037
1b2387c4-16eb-11ea-8a37-2f69b75d28bd	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	6	2019-12-04 15:09:21.665851	2019-12-04 15:09:21.665851
1b24b73e-16eb-11ea-8a37-9ff8d8f64eeb	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	10	2019-12-04 15:09:21.673574	2019-12-04 15:09:21.673574
1b25ec8a-16eb-11ea-8a37-ab66344820c8	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	3	2019-12-04 15:09:21.681497	2019-12-04 15:09:21.681497
1b271e16-16eb-11ea-8a37-6b836026a1ff	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	8	2019-12-04 15:09:21.689378	2019-12-04 15:09:21.689378
1b284e44-16eb-11ea-8a37-0bd9b1761ced	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	1	2019-12-04 15:09:21.697173	2019-12-04 15:09:21.697173
1b295b5e-16eb-11ea-8a37-6bd0701685f2	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	18	2019-12-04 15:09:21.704041	2019-12-04 15:09:21.704041
1b2a6ef4-16eb-11ea-8a37-e7bc2323267c	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	20	2019-12-04 15:09:21.71111	2019-12-04 15:09:21.71111
1b2b7eca-16eb-11ea-8a37-23879aa3fc84	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	25	2019-12-04 15:09:21.718059	2019-12-04 15:09:21.718059
1b2c8766-16eb-11ea-8a37-13d96e69c7a8	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	4	2019-12-04 15:09:21.724844	2019-12-04 15:09:21.724844
1b2d4f66-16eb-11ea-8a37-67dc41e717ef	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	24	2019-12-04 15:09:21.729966	2019-12-04 15:09:21.729966
1b2e1626-16eb-11ea-8a37-b31f781e9321	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	11	2019-12-04 15:09:21.735049	2019-12-04 15:09:21.735049
1b2eda84-16eb-11ea-8a37-f7d6e881492c	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	15	2019-12-04 15:09:21.740031	2019-12-04 15:09:21.740031
1b2f9f3c-16eb-11ea-8a37-b3eee5e721d5	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	23	2019-12-04 15:09:21.74511	2019-12-04 15:09:21.74511
1b669866-16eb-11ea-8a37-0b28f94f73f6	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b585878-16eb-11ea-8a37-177d78dceb2a	6	2019-12-04 15:09:22.105386	2019-12-04 15:09:22.105386
1b67ad8c-16eb-11ea-8a37-234f34b92f8c	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	7	2019-12-04 15:09:22.112463	2019-12-04 15:09:22.112463
1b68bae2-16eb-11ea-8a37-4b3627e3f173	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	10	2019-12-04 15:09:22.119366	2019-12-04 15:09:22.119366
1b697f0e-16eb-11ea-8a37-dfcc7953d535	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b585878-16eb-11ea-8a37-177d78dceb2a	5	2019-12-04 15:09:22.124402	2019-12-04 15:09:22.124402
1b6a429a-16eb-11ea-8a37-f3d903a7117e	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b596eac-16eb-11ea-8a37-b38fc0bda9d3	5	2019-12-04 15:09:22.129406	2019-12-04 15:09:22.129406
1b6b0da6-16eb-11ea-8a37-2b0abc4000f0	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	8	2019-12-04 15:09:22.1346	2019-12-04 15:09:22.1346
1b6bcf70-16eb-11ea-8a37-efd8e77bf6b2	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	3	2019-12-04 15:09:22.13957	2019-12-04 15:09:22.13957
1b6c8b2c-16eb-11ea-8a37-7f1dea456dc0	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	2	2019-12-04 15:09:22.144367	2019-12-04 15:09:22.144367
1b6d539a-16eb-11ea-8a37-03e22bf46941	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	1	2019-12-04 15:09:22.149434	2019-12-04 15:09:22.149434
1b6e13ca-16eb-11ea-8a37-7f12da28d2f6	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	9	2019-12-04 15:09:22.154412	2019-12-04 15:09:22.154412
1b6ede0e-16eb-11ea-8a37-ef292e9ed97e	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	4	2019-12-04 15:09:22.159598	2019-12-04 15:09:22.159598
1b700a9a-16eb-11ea-8a37-dfd186cf9700	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b585878-16eb-11ea-8a37-177d78dceb2a	0	2019-12-04 15:09:22.167294	2019-12-04 15:09:22.167294
1b713b54-16eb-11ea-8a37-23611c020dbc	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b596eac-16eb-11ea-8a37-b38fc0bda9d3	6	2019-12-04 15:09:22.175097	2019-12-04 15:09:22.175097
1b8d1982-16eb-11ea-8a37-eb17e8c64fb0	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	14	2019-12-04 15:09:22.35773	2019-12-04 15:09:22.35773
1b8e4a46-16eb-11ea-8a37-4305e51f5978	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	8	2019-12-04 15:09:22.36544	2019-12-04 15:09:22.36544
1b8f7c9a-16eb-11ea-8a37-ef293079a7ae	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	3	2019-12-04 15:09:22.373329	2019-12-04 15:09:22.373329
1b90aee4-16eb-11ea-8a37-bf606cc2e348	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	5	2019-12-04 15:09:22.381211	2019-12-04 15:09:22.381211
1b91e250-16eb-11ea-8a37-1b0e9e0e5b1d	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	9	2019-12-04 15:09:22.389081	2019-12-04 15:09:22.389081
1b92f460-16eb-11ea-8a37-ab292dbc563f	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	6	2019-12-04 15:09:22.396107	2019-12-04 15:09:22.396107
1b94054e-16eb-11ea-8a37-c7ef24b8319b	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	2	2019-12-04 15:09:22.40308	2019-12-04 15:09:22.40308
1b950a84-16eb-11ea-8a37-57cb6bc2d8df	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	7	2019-12-04 15:09:22.409757	2019-12-04 15:09:22.409757
1b9613c0-16eb-11ea-8a37-2b04bb9ef5da	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	10	2019-12-04 15:09:22.416519	2019-12-04 15:09:22.416519
1b96dad0-16eb-11ea-8a37-6f699d13238b	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	4	2019-12-04 15:09:22.421566	2019-12-04 15:09:22.421566
1b97a172-16eb-11ea-8a37-bf47014d47bd	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	1	2019-12-04 15:09:22.426752	2019-12-04 15:09:22.426752
1b986350-16eb-11ea-8a37-8bae19646e05	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	0	2019-12-04 15:09:22.431712	2019-12-04 15:09:22.431712
1b992240-16eb-11ea-8a37-e3d8bc29dc70	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	12	2019-12-04 15:09:22.436593	2019-12-04 15:09:22.436593
1b99e41e-16eb-11ea-8a37-87cf8123e56d	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	11	2019-12-04 15:09:22.441487	2019-12-04 15:09:22.441487
1b9aa372-16eb-11ea-8a37-4fcf2ae20b65	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	13	2019-12-04 15:09:22.446455	2019-12-04 15:09:22.446455
1bbe53c6-16eb-11ea-8a37-17c37f6e1da7	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bab5320-16eb-11ea-8a37-8b16dec1d61d	11	2019-12-04 15:09:22.680296	2019-12-04 15:09:22.680296
1bbf9150-16eb-11ea-8a37-efe4af66dd94	1ba99e54-16eb-11ea-8a37-0753aaf26025	1badc402-16eb-11ea-8a37-1bc388cfea8d	11	2019-12-04 15:09:22.688423	2019-12-04 15:09:22.688423
1bc0a4fa-16eb-11ea-8a37-b3534cffdb6e	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	9	2019-12-04 15:09:22.695483	2019-12-04 15:09:22.695483
1bc1bf0c-16eb-11ea-8a37-6bdea743bc38	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	2	2019-12-04 15:09:22.702711	2019-12-04 15:09:22.702711
1bc2c1b8-16eb-11ea-8a37-f318ca5494b8	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	7	2019-12-04 15:09:22.709411	2019-12-04 15:09:22.709411
1bc3b172-16eb-11ea-8a37-279aebbea38c	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	8	2019-12-04 15:09:22.715525	2019-12-04 15:09:22.715525
1bc45d48-16eb-11ea-8a37-bb06e7ad65e9	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	1	2019-12-04 15:09:22.719984	2019-12-04 15:09:22.719984
1bc4fb86-16eb-11ea-8a37-5bee4810c1c4	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	10	2019-12-04 15:09:22.724053	2019-12-04 15:09:22.724053
1bc590a0-16eb-11ea-8a37-4f25cffc2324	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bab5320-16eb-11ea-8a37-8b16dec1d61d	12	2019-12-04 15:09:22.727882	2019-12-04 15:09:22.727882
1bc6220e-16eb-11ea-8a37-cf0e0d8a44de	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	5	2019-12-04 15:09:22.731582	2019-12-04 15:09:22.731582
1bc6b2f0-16eb-11ea-8a37-1f3a5f6cd81c	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	0	2019-12-04 15:09:22.735309	2019-12-04 15:09:22.735309
1bc739fa-16eb-11ea-8a37-9f28c16bc732	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	3	2019-12-04 15:09:22.738791	2019-12-04 15:09:22.738791
1bc7c46a-16eb-11ea-8a37-8b1e3f19a48e	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	6	2019-12-04 15:09:22.74232	2019-12-04 15:09:22.74232
1bc85038-16eb-11ea-8a37-3fa61e5eeda7	1ba99e54-16eb-11ea-8a37-0753aaf26025	1badc402-16eb-11ea-8a37-1bc388cfea8d	12	2019-12-04 15:09:22.745892	2019-12-04 15:09:22.745892
1bc9528a-16eb-11ea-8a37-ef88cfa10450	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	4	2019-12-04 15:09:22.752502	2019-12-04 15:09:22.752502
1be9ab66-16eb-11ea-8a37-67a36cf5e259	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	10	2019-12-04 15:09:22.96453	2019-12-04 15:09:22.96453
1bea390a-16eb-11ea-8a37-bf58147c033b	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	13	2019-12-04 15:09:22.968149	2019-12-04 15:09:22.968149
1beaed1e-16eb-11ea-8a37-0f281acc942a	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	4	2019-12-04 15:09:22.972625	2019-12-04 15:09:22.972625
1bebab96-16eb-11ea-8a37-739e66a07c40	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	9	2019-12-04 15:09:22.977436	2019-12-04 15:09:22.977436
1bec6c3e-16eb-11ea-8a37-5ba2fd3fcba1	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	6	2019-12-04 15:09:22.982428	2019-12-04 15:09:22.982428
1bed9ce4-16eb-11ea-8a37-9700b27e012d	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	8	2019-12-04 15:09:22.990211	2019-12-04 15:09:22.990211
1beed258-16eb-11ea-8a37-037517d7ae94	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	11	2019-12-04 15:09:22.998149	2019-12-04 15:09:22.998149
1bf00aba-16eb-11ea-8a37-7b1e16e3dcf3	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	2	2019-12-04 15:09:23.006114	2019-12-04 15:09:23.006114
1bf13cdc-16eb-11ea-8a37-4b0266806625	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	14	2019-12-04 15:09:23.013958	2019-12-04 15:09:23.013958
1bf24cd0-16eb-11ea-8a37-b3d435ffcb8a	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	7	2019-12-04 15:09:23.020922	2019-12-04 15:09:23.020922
1bf35c4c-16eb-11ea-8a37-0b32f580f704	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	15	2019-12-04 15:09:23.027886	2019-12-04 15:09:23.027886
1bf4642a-16eb-11ea-8a37-2b3ce7f84ad3	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	5	2019-12-04 15:09:23.034642	2019-12-04 15:09:23.034642
1bf574a0-16eb-11ea-8a37-a7f01f63238f	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	0	2019-12-04 15:09:23.041541	2019-12-04 15:09:23.041541
1bf63e26-16eb-11ea-8a37-e3a18631f37e	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	3	2019-12-04 15:09:23.046762	2019-12-04 15:09:23.046762
1bf70252-16eb-11ea-8a37-67e17e865f28	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	1	2019-12-04 15:09:23.051755	2019-12-04 15:09:23.051755
1bf7c520-16eb-11ea-8a37-db7109418137	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	12	2019-12-04 15:09:23.056814	2019-12-04 15:09:23.056814
1c19eb28-16eb-11ea-8a37-7b6bd001ec0a	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	0	2019-12-04 15:09:23.280546	2019-12-04 15:09:23.280546
1c1b2024-16eb-11ea-8a37-774a6944f301	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	2	2019-12-04 15:09:23.288484	2019-12-04 15:09:23.288484
1c1c564c-16eb-11ea-8a37-c39aca9b8a32	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	9	2019-12-04 15:09:23.296423	2019-12-04 15:09:23.296423
1c1d8800-16eb-11ea-8a37-5b34a86d6094	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	10	2019-12-04 15:09:23.304244	2019-12-04 15:09:23.304244
1c1eaec4-16eb-11ea-8a37-2399e1617176	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	20	2019-12-04 15:09:23.311848	2019-12-04 15:09:23.311848
1c1fa536-16eb-11ea-8a37-a3be8d636d43	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	1	2019-12-04 15:09:23.318176	2019-12-04 15:09:23.318176
1c209202-16eb-11ea-8a37-a3ae4ec4decb	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	11	2019-12-04 15:09:23.324259	2019-12-04 15:09:23.324259
1c2175a0-16eb-11ea-8a37-97eff6662125	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	21	2019-12-04 15:09:23.330101	2019-12-04 15:09:23.330101
1c227022-16eb-11ea-8a37-6ba3b97b78cc	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	3	2019-12-04 15:09:23.336412	2019-12-04 15:09:23.336412
1c233462-16eb-11ea-8a37-af67f85743f8	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	16	2019-12-04 15:09:23.341414	2019-12-04 15:09:23.341414
1c23ff6e-16eb-11ea-8a37-d7ae50344926	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	18	2019-12-04 15:09:23.346632	2019-12-04 15:09:23.346632
1c24c4ee-16eb-11ea-8a37-a3f98b7073f2	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	7	2019-12-04 15:09:23.351678	2019-12-04 15:09:23.351678
1c258ece-16eb-11ea-8a37-9bf5aef9d0c3	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	8	2019-12-04 15:09:23.356837	2019-12-04 15:09:23.356837
1c264fda-16eb-11ea-8a37-2babd531541f	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	15	2019-12-04 15:09:23.36181	2019-12-04 15:09:23.36181
1c270cc2-16eb-11ea-8a37-97f129852503	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	17	2019-12-04 15:09:23.366634	2019-12-04 15:09:23.366634
1c27cf36-16eb-11ea-8a37-731e59b275ee	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	19	2019-12-04 15:09:23.371626	2019-12-04 15:09:23.371626
1c288d36-16eb-11ea-8a37-5b075c66afb4	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	14	2019-12-04 15:09:23.376489	2019-12-04 15:09:23.376489
1c29bf80-16eb-11ea-8a37-e3c9a08d38f7	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	5	2019-12-04 15:09:23.384291	2019-12-04 15:09:23.384291
1c2af5da-16eb-11ea-8a37-dbc0bfa84a54	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	6	2019-12-04 15:09:23.392254	2019-12-04 15:09:23.392254
1c2c30bc-16eb-11ea-8a37-c37c68a937e9	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	12	2019-12-04 15:09:23.400308	2019-12-04 15:09:23.400308
1c2d6270-16eb-11ea-8a37-e37f1e7829d0	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	13	2019-12-04 15:09:23.408136	2019-12-04 15:09:23.408136
1c2e707a-16eb-11ea-8a37-df3839ca895d	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	4	2019-12-04 15:09:23.415043	2019-12-04 15:09:23.415043
1c5fb2e8-16eb-11ea-8a37-07b6c5b4fc8b	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	21	2019-12-04 15:09:23.737888	2019-12-04 15:09:23.737888
1c60775a-16eb-11ea-8a37-fba5ccdbc3f6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	22	2019-12-04 15:09:23.742941	2019-12-04 15:09:23.742941
1c613b86-16eb-11ea-8a37-d3655b4669e2	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	7	2019-12-04 15:09:23.747949	2019-12-04 15:09:23.747949
1c61fd5a-16eb-11ea-8a37-873826264779	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	13	2019-12-04 15:09:23.752925	2019-12-04 15:09:23.752925
1c62bec0-16eb-11ea-8a37-878604a624fa	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	5	2019-12-04 15:09:23.757876	2019-12-04 15:09:23.757876
1c637b44-16eb-11ea-8a37-033ff1235648	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	18	2019-12-04 15:09:23.762711	2019-12-04 15:09:23.762711
1c643a8e-16eb-11ea-8a37-db96e4d95b94	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	14	2019-12-04 15:09:23.767563	2019-12-04 15:09:23.767563
1c64f96a-16eb-11ea-8a37-2fe6eb1327d6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	21	2019-12-04 15:09:23.77249	2019-12-04 15:09:23.77249
1c666908-16eb-11ea-8a37-c719c60e982f	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	20	2019-12-04 15:09:23.781869	2019-12-04 15:09:23.781869
1c679ada-16eb-11ea-8a37-138817ff7047	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	3	2019-12-04 15:09:23.789726	2019-12-04 15:09:23.789726
1c68c482-16eb-11ea-8a37-27f41ffb3882	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	8	2019-12-04 15:09:23.797352	2019-12-04 15:09:23.797352
1c69efb0-16eb-11ea-8a37-3be96fb27388	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	19	2019-12-04 15:09:23.804982	2019-12-04 15:09:23.804982
1c6b0f76-16eb-11ea-8a37-3b08fa2d3df7	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	6	2019-12-04 15:09:23.812352	2019-12-04 15:09:23.812352
1c6c26b8-16eb-11ea-8a37-3bef69bfe42f	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	4	2019-12-04 15:09:23.819505	2019-12-04 15:09:23.819505
1c6d3be8-16eb-11ea-8a37-7f52584fdc08	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	22	2019-12-04 15:09:23.826604	2019-12-04 15:09:23.826604
1c6e49fc-16eb-11ea-8a37-63d776ac9ad6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	12	2019-12-04 15:09:23.833429	2019-12-04 15:09:23.833429
1c6efd8e-16eb-11ea-8a37-43d72317cc71	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	1	2019-12-04 15:09:23.838165	2019-12-04 15:09:23.838165
1c6f9c26-16eb-11ea-8a37-9348495fb664	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	20	2019-12-04 15:09:23.842264	2019-12-04 15:09:23.842264
1c703514-16eb-11ea-8a37-6fe980d06cfa	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	9	2019-12-04 15:09:23.846182	2019-12-04 15:09:23.846182
1c70c628-16eb-11ea-8a37-93be9f9bb708	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	0	2019-12-04 15:09:23.849916	2019-12-04 15:09:23.849916
1c715192-16eb-11ea-8a37-cfead091eff5	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	9	2019-12-04 15:09:23.853489	2019-12-04 15:09:23.853489
1c71dd2e-16eb-11ea-8a37-172f4134edf4	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	11	2019-12-04 15:09:23.85706	2019-12-04 15:09:23.85706
1c7260aa-16eb-11ea-8a37-23f13576609b	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	1	2019-12-04 15:09:23.860434	2019-12-04 15:09:23.860434
1c72e4da-16eb-11ea-8a37-d76ea3f5ec03	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	10	2019-12-04 15:09:23.863827	2019-12-04 15:09:23.863827
1c73db6a-16eb-11ea-8a37-b3c941225317	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	0	2019-12-04 15:09:23.87013	2019-12-04 15:09:23.87013
1c74d696-16eb-11ea-8a37-f33d7f614d0d	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	15	2019-12-04 15:09:23.876561	2019-12-04 15:09:23.876561
1c75ceac-16eb-11ea-8a37-6b3a79a95c2f	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	17	2019-12-04 15:09:23.882894	2019-12-04 15:09:23.882894
1c76c852-16eb-11ea-8a37-b733d4a48ec1	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	2	2019-12-04 15:09:23.8893	2019-12-04 15:09:23.8893
1c77a4fc-16eb-11ea-8a37-0728354f3a0a	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	16	2019-12-04 15:09:23.894955	2019-12-04 15:09:23.894955
1c9e3db0-16eb-11ea-8a37-8faf5ac78492	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	1	2019-12-04 15:09:24.147756	2019-12-04 15:09:24.147756
1c9f543e-16eb-11ea-8a37-b3eb502aeb9b	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	17	2019-12-04 15:09:24.154977	2019-12-04 15:09:24.154977
1ca05dd4-16eb-11ea-8a37-5bec5493f9e4	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	7	2019-12-04 15:09:24.161796	2019-12-04 15:09:24.161796
1ca15e3c-16eb-11ea-8a37-377466d50e3e	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	8	2019-12-04 15:09:24.168364	2019-12-04 15:09:24.168364
1ca2388e-16eb-11ea-8a37-9b27765824d2	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	11	2019-12-04 15:09:24.17395	2019-12-04 15:09:24.17395
1ca313c6-16eb-11ea-8a37-9f5c4d06d574	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	19	2019-12-04 15:09:24.179579	2019-12-04 15:09:24.179579
1ca3ee4a-16eb-11ea-8a37-1f1348543f6b	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	15	2019-12-04 15:09:24.185178	2019-12-04 15:09:24.185178
1ca4be92-16eb-11ea-8a37-9f44e4ec9384	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	16	2019-12-04 15:09:24.190511	2019-12-04 15:09:24.190511
1ca54c40-16eb-11ea-8a37-27bb1d0f3031	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	18	2019-12-04 15:09:24.194142	2019-12-04 15:09:24.194142
1ca5da2a-16eb-11ea-8a37-b34add8eb606	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	6	2019-12-04 15:09:24.197775	2019-12-04 15:09:24.197775
1ca665a8-16eb-11ea-8a37-97338587a2e9	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	12	2019-12-04 15:09:24.201347	2019-12-04 15:09:24.201347
1ca6ed20-16eb-11ea-8a37-5b2e28784777	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	14	2019-12-04 15:09:24.204815	2019-12-04 15:09:24.204815
1ca77466-16eb-11ea-8a37-3f2034ecbca6	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	0	2019-12-04 15:09:24.208276	2019-12-04 15:09:24.208276
1ca7fcec-16eb-11ea-8a37-9b33df3cb7e5	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	2	2019-12-04 15:09:24.211751	2019-12-04 15:09:24.211751
1ca88072-16eb-11ea-8a37-77eff27930ae	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	13	2019-12-04 15:09:24.215142	2019-12-04 15:09:24.215142
1ca9084e-16eb-11ea-8a37-7f45fd758f13	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	9	2019-12-04 15:09:24.218599	2019-12-04 15:09:24.218599
1ca9ffa6-16eb-11ea-8a37-abcfeed563b5	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	4	2019-12-04 15:09:24.224945	2019-12-04 15:09:24.224945
1caaf6c2-16eb-11ea-8a37-271c961220a0	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	10	2019-12-04 15:09:24.231284	2019-12-04 15:09:24.231284
1cabee4c-16eb-11ea-8a37-cbec4d3c0828	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	21	2019-12-04 15:09:24.237583	2019-12-04 15:09:24.237583
1cace9aa-16eb-11ea-8a37-1fcc8d6fbfa5	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	3	2019-12-04 15:09:24.244031	2019-12-04 15:09:24.244031
1cadc456-16eb-11ea-8a37-471cdc4ed885	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	5	2019-12-04 15:09:24.249634	2019-12-04 15:09:24.249634
1cae9ea8-16eb-11ea-8a37-0f92c816e239	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	20	2019-12-04 15:09:24.255227	2019-12-04 15:09:24.255227
1cc89358-16eb-11ea-8a37-b38dc3d8af69	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	7	2019-12-04 15:09:24.425343	2019-12-04 15:09:24.425343
1cc92e08-16eb-11ea-8a37-2f9f2214690f	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	0	2019-12-04 15:09:24.429275	2019-12-04 15:09:24.429275
1cc9c3e0-16eb-11ea-8a37-2bd4f14bc936	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	4	2019-12-04 15:09:24.433112	2019-12-04 15:09:24.433112
1cca544a-16eb-11ea-8a37-67ae3d67afb1	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	9	2019-12-04 15:09:24.436831	2019-12-04 15:09:24.436831
1ccae5d6-16eb-11ea-8a37-8f07b78f3e1d	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	3	2019-12-04 15:09:24.440557	2019-12-04 15:09:24.440557
1ccb70e6-16eb-11ea-8a37-6f517093c2cb	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	8	2019-12-04 15:09:24.444132	2019-12-04 15:09:24.444132
1ccbfcbe-16eb-11ea-8a37-13c21cd14224	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	2	2019-12-04 15:09:24.44769	2019-12-04 15:09:24.44769
1ccd0014-16eb-11ea-8a37-eb4beb0ad258	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	5	2019-12-04 15:09:24.454329	2019-12-04 15:09:24.454329
1cce0932-16eb-11ea-8a37-9f29cfbc8dae	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	6	2019-12-04 15:09:24.461112	2019-12-04 15:09:24.461112
1ccf12fa-16eb-11ea-8a37-cbd3dcd7f284	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	1	2019-12-04 15:09:24.46792	2019-12-04 15:09:24.46792
1ce109ce-16eb-11ea-8a37-435e5448fc85	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	7	2019-12-04 15:09:24.58566	2019-12-04 15:09:24.58566
1ce1a0fa-16eb-11ea-8a37-bbc6e905e01e	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	15	2019-12-04 15:09:24.589529	2019-12-04 15:09:24.589529
1ce237d6-16eb-11ea-8a37-775845d6551f	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd8d7a4-16eb-11ea-8a37-0f8c441e8cf1	0	2019-12-04 15:09:24.593397	2019-12-04 15:09:24.593397
1ce2cb06-16eb-11ea-8a37-835b3d375204	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	5	2019-12-04 15:09:24.597155	2019-12-04 15:09:24.597155
1ce35ea4-16eb-11ea-8a37-23af26542a93	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	13	2019-12-04 15:09:24.600917	2019-12-04 15:09:24.600917
1ce3fa4e-16eb-11ea-8a37-333441e80888	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	4	2019-12-04 15:09:24.604881	2019-12-04 15:09:24.604881
1ce51c9e-16eb-11ea-8a37-1fc785e01ea0	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	6	2019-12-04 15:09:24.612273	2019-12-04 15:09:24.612273
1ce64d58-16eb-11ea-8a37-734a3116c912	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd9d9ec-16eb-11ea-8a37-574c05744ae9	0	2019-12-04 15:09:24.620038	2019-12-04 15:09:24.620038
1ce77aca-16eb-11ea-8a37-cb1a20351cc0	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd9d9ec-16eb-11ea-8a37-574c05744ae9	1	2019-12-04 15:09:24.627763	2019-12-04 15:09:24.627763
1ce8a030-16eb-11ea-8a37-e3425dc3d5cf	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cdae328-16eb-11ea-8a37-bbdd268629d3	11	2019-12-04 15:09:24.635276	2019-12-04 15:09:24.635276
1ce9b02e-16eb-11ea-8a37-efc1e2648008	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	8	2019-12-04 15:09:24.642239	2019-12-04 15:09:24.642239
1ceabeec-16eb-11ea-8a37-cb766a66f751	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cdae328-16eb-11ea-8a37-bbdd268629d3	0	2019-12-04 15:09:24.649176	2019-12-04 15:09:24.649176
1cebcc88-16eb-11ea-8a37-e72ae72b7ed1	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cdae328-16eb-11ea-8a37-bbdd268629d3	1	2019-12-04 15:09:24.656068	2019-12-04 15:09:24.656068
1cecd84e-16eb-11ea-8a37-032e4ae43a1f	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	9	2019-12-04 15:09:24.662925	2019-12-04 15:09:24.662925
1ced9d1a-16eb-11ea-8a37-83ed1cafa135	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd8d7a4-16eb-11ea-8a37-0f8c441e8cf1	1	2019-12-04 15:09:24.667966	2019-12-04 15:09:24.667966
1cee6362-16eb-11ea-8a37-37b83a7d133a	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	3	2019-12-04 15:09:24.673032	2019-12-04 15:09:24.673032
1cef2e1e-16eb-11ea-8a37-7f9c8f67bd1d	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cdae328-16eb-11ea-8a37-bbdd268629d3	10	2019-12-04 15:09:24.678183	2019-12-04 15:09:24.678183
1cefff42-16eb-11ea-8a37-dfba22039c67	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	2	2019-12-04 15:09:24.683553	2019-12-04 15:09:24.683553
1cf0be1e-16eb-11ea-8a37-63fc7d9337a5	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	14	2019-12-04 15:09:24.688472	2019-12-04 15:09:24.688472
1cf17728-16eb-11ea-8a37-4311ec823f21	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	12	2019-12-04 15:09:24.693215	2019-12-04 15:09:24.693215
1d157a7e-16eb-11ea-8a37-5bc2f0980669	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	6	2019-12-04 15:09:24.929198	2019-12-04 15:09:24.929198
1d1683b0-16eb-11ea-8a37-2fb1b926f457	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	13	2019-12-04 15:09:24.936009	2019-12-04 15:09:24.936009
1d178bca-16eb-11ea-8a37-975a57142986	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	9	2019-12-04 15:09:24.942745	2019-12-04 15:09:24.942745
1d18a190-16eb-11ea-8a37-f33950955920	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	5	2019-12-04 15:09:24.949817	2019-12-04 15:09:24.949817
1d19ad88-16eb-11ea-8a37-5bb1d87a518f	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	20	2019-12-04 15:09:24.956744	2019-12-04 15:09:24.956744
1d1a6dcc-16eb-11ea-8a37-23dd9e1cc072	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	7	2019-12-04 15:09:24.961657	2019-12-04 15:09:24.961657
1d1b39a0-16eb-11ea-8a37-bfd31e2c3820	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	2	2019-12-04 15:09:24.966852	2019-12-04 15:09:24.966852
1d1bfcdc-16eb-11ea-8a37-236b85c98b26	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	12	2019-12-04 15:09:24.971875	2019-12-04 15:09:24.971875
1d1cb5aa-16eb-11ea-8a37-db5dabbe73d0	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	17	2019-12-04 15:09:24.976612	2019-12-04 15:09:24.976612
1d1d7bc0-16eb-11ea-8a37-673dae1799f0	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	1	2019-12-04 15:09:24.981593	2019-12-04 15:09:24.981593
1d1e3858-16eb-11ea-8a37-b790a36bbbb7	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	11	2019-12-04 15:09:24.986503	2019-12-04 15:09:24.986503
1d1ef55e-16eb-11ea-8a37-2b2ec7cda994	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	0	2019-12-04 15:09:24.991334	2019-12-04 15:09:24.991334
1d1fb818-16eb-11ea-8a37-5bae274e1b9d	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	16	2019-12-04 15:09:24.996326	2019-12-04 15:09:24.996326
1d20e74c-16eb-11ea-8a37-a7c427e6ade3	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	24	2019-12-04 15:09:25.004078	2019-12-04 15:09:25.004078
1d221db0-16eb-11ea-8a37-efda45e9e3c1	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	14	2019-12-04 15:09:25.011983	2019-12-04 15:09:25.011983
1d235720-16eb-11ea-8a37-cb89c941ec21	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	19	2019-12-04 15:09:25.020045	2019-12-04 15:09:25.020045
1d248186-16eb-11ea-8a37-3f4314364003	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	8	2019-12-04 15:09:25.027703	2019-12-04 15:09:25.027703
1d2595a8-16eb-11ea-8a37-076e3fd6b1f0	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	22	2019-12-04 15:09:25.034728	2019-12-04 15:09:25.034728
1d26a5d8-16eb-11ea-8a37-4742d5dbf679	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	18	2019-12-04 15:09:25.041723	2019-12-04 15:09:25.041723
1d27b040-16eb-11ea-8a37-7f42163ee895	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	23	2019-12-04 15:09:25.048524	2019-12-04 15:09:25.048524
1d28bd32-16eb-11ea-8a37-5349b8b092ac	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	3	2019-12-04 15:09:25.055437	2019-12-04 15:09:25.055437
1d2979a2-16eb-11ea-8a37-73852ef80c77	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	4	2019-12-04 15:09:25.06025	2019-12-04 15:09:25.06025
1d2a3cb6-16eb-11ea-8a37-3fbf85a55f20	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	15	2019-12-04 15:09:25.065269	2019-12-04 15:09:25.065269
1d2b0ef2-16eb-11ea-8a37-1b333b8ce088	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	21	2019-12-04 15:09:25.070614	2019-12-04 15:09:25.070614
1d2bcfe0-16eb-11ea-8a37-c3856815661d	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	10	2019-12-04 15:09:25.075583	2019-12-04 15:09:25.075583
1d507f52-16eb-11ea-8a37-0faae9856a7d	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	2	2019-12-04 15:09:25.315958	2019-12-04 15:09:25.315958
1d51a8b4-16eb-11ea-8a37-3ba1ab1a8166	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	6	2019-12-04 15:09:25.323582	2019-12-04 15:09:25.323582
1d52b61e-16eb-11ea-8a37-7b99a4c0af37	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	7	2019-12-04 15:09:25.330503	2019-12-04 15:09:25.330503
1d53c0b8-16eb-11ea-8a37-2f98183ac38f	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	13	2019-12-04 15:09:25.337316	2019-12-04 15:09:25.337316
1d54c51c-16eb-11ea-8a37-9b425fbe6c77	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	10	2019-12-04 15:09:25.343997	2019-12-04 15:09:25.343997
1d55d326-16eb-11ea-8a37-c78892d10ce8	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	5	2019-12-04 15:09:25.350893	2019-12-04 15:09:25.350893
1d56a1fc-16eb-11ea-8a37-177789b4ae0a	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	8	2019-12-04 15:09:25.356184	2019-12-04 15:09:25.356184
1d575f98-16eb-11ea-8a37-df66608b9ad2	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	0	2019-12-04 15:09:25.361071	2019-12-04 15:09:25.361071
1d58234c-16eb-11ea-8a37-37b65bedfa44	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	16	2019-12-04 15:09:25.366072	2019-12-04 15:09:25.366072
1d58dbac-16eb-11ea-8a37-a71a0789637e	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	9	2019-12-04 15:09:25.370811	2019-12-04 15:09:25.370811
1d599164-16eb-11ea-8a37-7fb17ed58efa	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	12	2019-12-04 15:09:25.375431	2019-12-04 15:09:25.375431
1d5a48e8-16eb-11ea-8a37-2bfbdf2b15e0	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	17	2019-12-04 15:09:25.380116	2019-12-04 15:09:25.380116
1d5b0558-16eb-11ea-8a37-5b98ca6e0a16	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	15	2019-12-04 15:09:25.38495	2019-12-04 15:09:25.38495
1d5bcc22-16eb-11ea-8a37-47f9de0571d9	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	4	2019-12-04 15:09:25.390007	2019-12-04 15:09:25.390007
1d5cff02-16eb-11ea-8a37-73061a85317c	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	1	2019-12-04 15:09:25.397874	2019-12-04 15:09:25.397874
1d5e38a4-16eb-11ea-8a37-a7fef6954c84	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	11	2019-12-04 15:09:25.405895	2019-12-04 15:09:25.405895
1d5f73ea-16eb-11ea-8a37-8f5db88aea40	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	3	2019-12-04 15:09:25.413992	2019-12-04 15:09:25.413992
1d60aa08-16eb-11ea-8a37-4fc976d20df7	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	14	2019-12-04 15:09:25.421882	2019-12-04 15:09:25.421882
1d8171c0-16eb-11ea-8a37-a709dba143ff	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	10	2019-12-04 15:09:25.636735	2019-12-04 15:09:25.636735
1d828966-16eb-11ea-8a37-a7d29dc5e148	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	8	2019-12-04 15:09:25.643868	2019-12-04 15:09:25.643868
1d835238-16eb-11ea-8a37-23a2a3de0fc3	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	9	2019-12-04 15:09:25.649072	2019-12-04 15:09:25.649072
1d841a1a-16eb-11ea-8a37-c357889c8ede	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	2	2019-12-04 15:09:25.654189	2019-12-04 15:09:25.654189
1d84d928-16eb-11ea-8a37-8f57230c1140	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	15	2019-12-04 15:09:25.659069	2019-12-04 15:09:25.659069
1d859d18-16eb-11ea-8a37-8b9bf481889a	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	0	2019-12-04 15:09:25.664096	2019-12-04 15:09:25.664096
1d865438-16eb-11ea-8a37-5788b652fed4	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	11	2019-12-04 15:09:25.668792	2019-12-04 15:09:25.668792
1d8716ac-16eb-11ea-8a37-1bf66558c3c0	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	14	2019-12-04 15:09:25.673712	2019-12-04 15:09:25.673712
1d87e06e-16eb-11ea-8a37-43e370112c58	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	16	2019-12-04 15:09:25.678913	2019-12-04 15:09:25.678913
1d88a6ac-16eb-11ea-8a37-03d396089124	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	12	2019-12-04 15:09:25.683994	2019-12-04 15:09:25.683994
1d89d8e2-16eb-11ea-8a37-e3700bbed2bb	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	3	2019-12-04 15:09:25.691827	2019-12-04 15:09:25.691827
1d8b10fe-16eb-11ea-8a37-bb6f72445e05	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	5	2019-12-04 15:09:25.699808	2019-12-04 15:09:25.699808
1d8c4514-16eb-11ea-8a37-a7a0bf62579d	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	4	2019-12-04 15:09:25.70767	2019-12-04 15:09:25.70767
1d8d715a-16eb-11ea-8a37-df7e6d58d5e4	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	13	2019-12-04 15:09:25.715391	2019-12-04 15:09:25.715391
1d8e86ee-16eb-11ea-8a37-c7f8be11d666	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	1	2019-12-04 15:09:25.722517	2019-12-04 15:09:25.722517
1d8f97e6-16eb-11ea-8a37-67df10146684	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	7	2019-12-04 15:09:25.729456	2019-12-04 15:09:25.729456
1d90a7da-16eb-11ea-8a37-1fc591e1ffb4	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	6	2019-12-04 15:09:25.736452	2019-12-04 15:09:25.736452
1daea7ee-16eb-11ea-8a37-1bcd0a3f8f87	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	15	2019-12-04 15:09:25.933045	2019-12-04 15:09:25.933045
1daf72aa-16eb-11ea-8a37-23a902b6b33c	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	16	2019-12-04 15:09:25.93825	2019-12-04 15:09:25.93825
1db03172-16eb-11ea-8a37-539b2197ce23	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	17	2019-12-04 15:09:25.943151	2019-12-04 15:09:25.943151
1db0f2c4-16eb-11ea-8a37-7b46097f193b	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da1e7c0-16eb-11ea-8a37-532dcab2368f	1	2019-12-04 15:09:25.948058	2019-12-04 15:09:25.948058
1db1b394-16eb-11ea-8a37-7ba101fb983e	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da2f0fc-16eb-11ea-8a37-2bcc13b87204	1	2019-12-04 15:09:25.953035	2019-12-04 15:09:25.953035
1db26f32-16eb-11ea-8a37-cffbaf3ab414	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	12	2019-12-04 15:09:25.957832	2019-12-04 15:09:25.957832
1db324fe-16eb-11ea-8a37-37d28504944a	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	4	2019-12-04 15:09:25.962519	2019-12-04 15:09:25.962519
1db45022-16eb-11ea-8a37-af2cac25ecf9	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da26f60-16eb-11ea-8a37-2bc557f8bc59	0	2019-12-04 15:09:25.970141	2019-12-04 15:09:25.970141
1db58136-16eb-11ea-8a37-f3afa2449751	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da1e7c0-16eb-11ea-8a37-532dcab2368f	11	2019-12-04 15:09:25.97794	2019-12-04 15:09:25.97794
1db6b75e-16eb-11ea-8a37-b7571784101b	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	3	2019-12-04 15:09:25.985902	2019-12-04 15:09:25.985902
1db7e0d4-16eb-11ea-8a37-4bfb7b94c921	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da2f0fc-16eb-11ea-8a37-2bcc13b87204	10	2019-12-04 15:09:25.993452	2019-12-04 15:09:25.993452
1db8f050-16eb-11ea-8a37-ff82cac831a9	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	5	2019-12-04 15:09:26.000463	2019-12-04 15:09:26.000463
1dba02ec-16eb-11ea-8a37-d71acaf81dc8	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	8	2019-12-04 15:09:26.007496	2019-12-04 15:09:26.007496
1dbb0d2c-16eb-11ea-8a37-1f400253c5b5	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	9	2019-12-04 15:09:26.01428	2019-12-04 15:09:26.01428
1dbc1d2a-16eb-11ea-8a37-2bfddb351163	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	14	2019-12-04 15:09:26.021273	2019-12-04 15:09:26.021273
1dbcdfbc-16eb-11ea-8a37-9340ee89431f	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da1e7c0-16eb-11ea-8a37-532dcab2368f	10	2019-12-04 15:09:26.026276	2019-12-04 15:09:26.026276
1dbd9fd8-16eb-11ea-8a37-6b962a8fbcb3	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	6	2019-12-04 15:09:26.031198	2019-12-04 15:09:26.031198
1dbe642c-16eb-11ea-8a37-4f00b50af80c	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	7	2019-12-04 15:09:26.036186	2019-12-04 15:09:26.036186
1dbf268c-16eb-11ea-8a37-87efd0a31778	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da2f0fc-16eb-11ea-8a37-2bcc13b87204	11	2019-12-04 15:09:26.04119	2019-12-04 15:09:26.04119
1dbfe68a-16eb-11ea-8a37-1bb9dae12f05	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da26f60-16eb-11ea-8a37-2bc557f8bc59	11	2019-12-04 15:09:26.046093	2019-12-04 15:09:26.046093
1dc0a55c-16eb-11ea-8a37-9fb92d33f0ce	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da26f60-16eb-11ea-8a37-2bc557f8bc59	1	2019-12-04 15:09:26.050969	2019-12-04 15:09:26.050969
1dc15d62-16eb-11ea-8a37-1366c6a0f310	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	18	2019-12-04 15:09:26.055696	2019-12-04 15:09:26.055696
1dc2173e-16eb-11ea-8a37-dfe223292b44	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	19	2019-12-04 15:09:26.06044	2019-12-04 15:09:26.06044
1dc34852-16eb-11ea-8a37-0fc90d56cc1a	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	13	2019-12-04 15:09:26.068262	2019-12-04 15:09:26.068262
1dc477c2-16eb-11ea-8a37-a39522d2ae59	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	2	2019-12-04 15:09:26.076015	2019-12-04 15:09:26.076015
1dc5ab7e-16eb-11ea-8a37-8335a3c125aa	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da26f60-16eb-11ea-8a37-2bc557f8bc59	10	2019-12-04 15:09:26.083864	2019-12-04 15:09:26.083864
1df18866-16eb-11ea-8a37-77e48ab03550	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	0	2019-12-04 15:09:26.371338	2019-12-04 15:09:26.371338
1df2b84e-16eb-11ea-8a37-c30acf9de20b	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de11102-16eb-11ea-8a37-57f184fd0e32	1	2019-12-04 15:09:26.379115	2019-12-04 15:09:26.379115
1df3cdba-16eb-11ea-8a37-b7f7e334b2af	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de39a08-16eb-11ea-8a37-738d22dbcff6	2	2019-12-04 15:09:26.386228	2019-12-04 15:09:26.386228
1dfe2f8a-16eb-11ea-8a37-a395d5f0a96d	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	12	2019-12-04 15:09:26.454264	2019-12-04 15:09:26.454264
1dff767e-16eb-11ea-8a37-c35908a4587d	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	3	2019-12-04 15:09:26.462645	2019-12-04 15:09:26.462645
1e0089c4-16eb-11ea-8a37-5f48ce58191e	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	13	2019-12-04 15:09:26.469551	2019-12-04 15:09:26.469551
1e01a5de-16eb-11ea-8a37-bbc90c4e111f	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	14	2019-12-04 15:09:26.476953	2019-12-04 15:09:26.476953
1e02babe-16eb-11ea-8a37-d3827652bc3e	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	1	2019-12-04 15:09:26.484037	2019-12-04 15:09:26.484037
1e03c68e-16eb-11ea-8a37-2f8389fc2b09	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df9790e-16eb-11ea-8a37-ef7004e09057	10	2019-12-04 15:09:26.490927	2019-12-04 15:09:26.490927
1e0484ca-16eb-11ea-8a37-0727b88d4878	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	5	2019-12-04 15:09:26.495809	2019-12-04 15:09:26.495809
1e05466c-16eb-11ea-8a37-639b34567888	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	4	2019-12-04 15:09:26.500751	2019-12-04 15:09:26.500751
1e060854-16eb-11ea-8a37-23ddd010d2f2	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df9790e-16eb-11ea-8a37-ef7004e09057	8	2019-12-04 15:09:26.505691	2019-12-04 15:09:26.505691
1e06cdf2-16eb-11ea-8a37-d7017ade4a11	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	17	2019-12-04 15:09:26.510774	2019-12-04 15:09:26.510774
1e078cd8-16eb-11ea-8a37-3bc6bb9305a9	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	0	2019-12-04 15:09:26.515648	2019-12-04 15:09:26.515648
1e086126-16eb-11ea-8a37-979e710a87e9	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	2	2019-12-04 15:09:26.521077	2019-12-04 15:09:26.521077
1e09192c-16eb-11ea-8a37-5beadf0a0486	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	6	2019-12-04 15:09:26.525791	2019-12-04 15:09:26.525791
1e09d498-16eb-11ea-8a37-27cb4c60a892	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df9790e-16eb-11ea-8a37-ef7004e09057	9	2019-12-04 15:09:26.530594	2019-12-04 15:09:26.530594
1e0aff58-16eb-11ea-8a37-8b5183444f41	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	15	2019-12-04 15:09:26.53822	2019-12-04 15:09:26.53822
1e0c1faa-16eb-11ea-8a37-ff90522dea76	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df9790e-16eb-11ea-8a37-ef7004e09057	11	2019-12-04 15:09:26.54566	2019-12-04 15:09:26.54566
1e0d2cd8-16eb-11ea-8a37-5f249b64dfd5	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	16	2019-12-04 15:09:26.552591	2019-12-04 15:09:26.552591
1e0e2a66-16eb-11ea-8a37-9325f721bab8	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	7	2019-12-04 15:09:26.559116	2019-12-04 15:09:26.559116
1e28a9a4-16eb-11ea-8a37-53fe5fe4723b	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	3	2019-12-04 15:09:26.732599	2019-12-04 15:09:26.732599
1e29c118-16eb-11ea-8a37-b7877564126c	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	25	2019-12-04 15:09:26.73977	2019-12-04 15:09:26.73977
1e2ad562-16eb-11ea-8a37-e390a6194206	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	2	2019-12-04 15:09:26.746829	2019-12-04 15:09:26.746829
1e2bf212-16eb-11ea-8a37-bb003cfe8bf6	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	1	2019-12-04 15:09:26.754153	2019-12-04 15:09:26.754153
1e2cf9c8-16eb-11ea-8a37-23c50f6808fd	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	16	2019-12-04 15:09:26.760916	2019-12-04 15:09:26.760916
1e2dbd9a-16eb-11ea-8a37-9b6c1039d730	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	4	2019-12-04 15:09:26.765909	2019-12-04 15:09:26.765909
1e2e92ec-16eb-11ea-8a37-8bd684446653	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	9	2019-12-04 15:09:26.771328	2019-12-04 15:09:26.771328
1e2f60dc-16eb-11ea-8a37-77024465b4a4	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	18	2019-12-04 15:09:26.776665	2019-12-04 15:09:26.776665
1e302e36-16eb-11ea-8a37-2f4e9926e629	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	11	2019-12-04 15:09:26.781857	2019-12-04 15:09:26.781857
1e30ef6a-16eb-11ea-8a37-375bcef2a568	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	19	2019-12-04 15:09:26.786831	2019-12-04 15:09:26.786831
1e31b8a0-16eb-11ea-8a37-071b46c8bae0	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	13	2019-12-04 15:09:26.791985	2019-12-04 15:09:26.791985
1e32765a-16eb-11ea-8a37-b7b85b744677	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	24	2019-12-04 15:09:26.796858	2019-12-04 15:09:26.796858
1e3326e0-16eb-11ea-8a37-c32c5f4b7dc2	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	15	2019-12-04 15:09:26.801393	2019-12-04 15:09:26.801393
1e344b92-16eb-11ea-8a37-af056d253c1a	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	10	2019-12-04 15:09:26.808892	2019-12-04 15:09:26.808892
1e35756c-16eb-11ea-8a37-8b6f3b749587	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	17	2019-12-04 15:09:26.816485	2019-12-04 15:09:26.816485
1e36afae-16eb-11ea-8a37-4b4de5c7be48	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	8	2019-12-04 15:09:26.824541	2019-12-04 15:09:26.824541
1e37df5a-16eb-11ea-8a37-df80900f0a80	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	20	2019-12-04 15:09:26.832282	2019-12-04 15:09:26.832282
1e38ebd4-16eb-11ea-8a37-371ae8ee0534	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	22	2019-12-04 15:09:26.839221	2019-12-04 15:09:26.839221
1e39f614-16eb-11ea-8a37-77ea81130825	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	26	2019-12-04 15:09:26.846007	2019-12-04 15:09:26.846007
1e3b03a6-16eb-11ea-8a37-9375fa73f188	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	14	2019-12-04 15:09:26.852902	2019-12-04 15:09:26.852902
1e3c0e04-16eb-11ea-8a37-2f81ac41526e	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	6	2019-12-04 15:09:26.859731	2019-12-04 15:09:26.859731
1e3cc6f0-16eb-11ea-8a37-ab68575fe2d2	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	5	2019-12-04 15:09:26.864476	2019-12-04 15:09:26.864476
1e3d9800-16eb-11ea-8a37-7b9ddc986351	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	7	2019-12-04 15:09:26.869795	2019-12-04 15:09:26.869795
1e3e59d4-16eb-11ea-8a37-83db85049a87	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	12	2019-12-04 15:09:26.874767	2019-12-04 15:09:26.874767
1e3f17f2-16eb-11ea-8a37-7bb60b0b22f4	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	0	2019-12-04 15:09:26.87962	2019-12-04 15:09:26.87962
1e3fdb92-16eb-11ea-8a37-0361d36a2a01	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	23	2019-12-04 15:09:26.88465	2019-12-04 15:09:26.88465
1e40ad10-16eb-11ea-8a37-1bc309c06654	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	21	2019-12-04 15:09:26.890004	2019-12-04 15:09:26.890004
1e6b3756-16eb-11ea-8a37-679350fbe556	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	24	2019-12-04 15:09:27.168832	2019-12-04 15:09:27.168832
1e6bf970-16eb-11ea-8a37-177ccdbe56fb	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	23	2019-12-04 15:09:27.173795	2019-12-04 15:09:27.173795
1e6cb4be-16eb-11ea-8a37-4b418caa85c8	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	25	2019-12-04 15:09:27.178541	2019-12-04 15:09:27.178541
1e6d7200-16eb-11ea-8a37-fbd43f0c0014	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	9	2019-12-04 15:09:27.183412	2019-12-04 15:09:27.183412
1e6e2f92-16eb-11ea-8a37-8fd00c4a4025	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	3	2019-12-04 15:09:27.188214	2019-12-04 15:09:27.188214
1e6ef166-16eb-11ea-8a37-07fc9cf009f5	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	6	2019-12-04 15:09:27.193202	2019-12-04 15:09:27.193202
1e7025b8-16eb-11ea-8a37-6f6cf539067e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	0	2019-12-04 15:09:27.201103	2019-12-04 15:09:27.201103
1e715a78-16eb-11ea-8a37-370e377c28c0	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	1	2019-12-04 15:09:27.209021	2019-12-04 15:09:27.209021
1e728e98-16eb-11ea-8a37-af34b8edcae2	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	13	2019-12-04 15:09:27.216871	2019-12-04 15:09:27.216871
1e73bb56-16eb-11ea-8a37-434e7462ee79	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	10	2019-12-04 15:09:27.224614	2019-12-04 15:09:27.224614
1e74c640-16eb-11ea-8a37-af6a16b0d628	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	7	2019-12-04 15:09:27.231471	2019-12-04 15:09:27.231471
1e75defe-16eb-11ea-8a37-bb2e568a8f8d	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	19	2019-12-04 15:09:27.238611	2019-12-04 15:09:27.238611
1e76f776-16eb-11ea-8a37-af1e030b160e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	14	2019-12-04 15:09:27.245809	2019-12-04 15:09:27.245809
1e7814da-16eb-11ea-8a37-ff7c4bfae7ed	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	12	2019-12-04 15:09:27.253063	2019-12-04 15:09:27.253063
1e78dad2-16eb-11ea-8a37-03a1b3e2abf0	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	8	2019-12-04 15:09:27.258206	2019-12-04 15:09:27.258206
1e79962a-16eb-11ea-8a37-1f297458604b	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	2	2019-12-04 15:09:27.263001	2019-12-04 15:09:27.263001
1e7a5a56-16eb-11ea-8a37-5b9ab8cfff42	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	18	2019-12-04 15:09:27.26795	2019-12-04 15:09:27.26795
1e7b23a0-16eb-11ea-8a37-1ffbc79e0145	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	15	2019-12-04 15:09:27.273124	2019-12-04 15:09:27.273124
1e7bedc6-16eb-11ea-8a37-e3b504eb15a8	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	21	2019-12-04 15:09:27.278326	2019-12-04 15:09:27.278326
1e7cab58-16eb-11ea-8a37-5bd5918c1c78	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	5	2019-12-04 15:09:27.283125	2019-12-04 15:09:27.283125
1e7d7006-16eb-11ea-8a37-273729c15742	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	20	2019-12-04 15:09:27.288223	2019-12-04 15:09:27.288223
1e7e2bd6-16eb-11ea-8a37-f3f389c24292	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	11	2019-12-04 15:09:27.293062	2019-12-04 15:09:27.293062
1e7f5fba-16eb-11ea-8a37-27f4c942de94	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	16	2019-12-04 15:09:27.300897	2019-12-04 15:09:27.300897
1e808c14-16eb-11ea-8a37-d738719d5b07	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	17	2019-12-04 15:09:27.308585	2019-12-04 15:09:27.308585
1e81c386-16eb-11ea-8a37-a3ac1f7dfea4	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	4	2019-12-04 15:09:27.316518	2019-12-04 15:09:27.316518
1e82f120-16eb-11ea-8a37-8b3be1cde652	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	22	2019-12-04 15:09:27.324312	2019-12-04 15:09:27.324312
1ea8d03e-16eb-11ea-8a37-bf89f7a0ae25	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	7	2019-12-04 15:09:27.572582	2019-12-04 15:09:27.572582
1ea96396-16eb-11ea-8a37-67b7f258af92	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	19	2019-12-04 15:09:27.576369	2019-12-04 15:09:27.576369
1ea9f86a-16eb-11ea-8a37-339f5dd3a5b9	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	0	2019-12-04 15:09:27.580151	2019-12-04 15:09:27.580151
1eab0638-16eb-11ea-8a37-6b8e9582a1d6	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	8	2019-12-04 15:09:27.587063	2019-12-04 15:09:27.587063
1eac0ba0-16eb-11ea-8a37-f7678d8894fe	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	23	2019-12-04 15:09:27.593761	2019-12-04 15:09:27.593761
1ead15ea-16eb-11ea-8a37-8b72eed5efed	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	25	2019-12-04 15:09:27.600532	2019-12-04 15:09:27.600532
1eae1de6-16eb-11ea-8a37-f7b9101ddf59	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	4	2019-12-04 15:09:27.607325	2019-12-04 15:09:27.607325
1eaf0224-16eb-11ea-8a37-b7a76a795c43	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	6	2019-12-04 15:09:27.613179	2019-12-04 15:09:27.613179
1eafe928-16eb-11ea-8a37-e3d342dec08e	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	13	2019-12-04 15:09:27.619071	2019-12-04 15:09:27.619071
1eb0e8fa-16eb-11ea-8a37-773ae55c5975	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	14	2019-12-04 15:09:27.62552	2019-12-04 15:09:27.62552
1eb1ebce-16eb-11ea-8a37-cf63bb5d3b1f	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	22	2019-12-04 15:09:27.632198	2019-12-04 15:09:27.632198
1eb2a4c4-16eb-11ea-8a37-730259c8ecfb	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	5	2019-12-04 15:09:27.636898	2019-12-04 15:09:27.636898
1eb360ee-16eb-11ea-8a37-7b82b5a48608	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	11	2019-12-04 15:09:27.641738	2019-12-04 15:09:27.641738
1eb42132-16eb-11ea-8a37-739542a583f3	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	12	2019-12-04 15:09:27.646658	2019-12-04 15:09:27.646658
1eb4db5e-16eb-11ea-8a37-fbc270e46e8f	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	10	2019-12-04 15:09:27.651412	2019-12-04 15:09:27.651412
1eb593b4-16eb-11ea-8a37-f7af189b4d91	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	18	2019-12-04 15:09:27.656152	2019-12-04 15:09:27.656152
1eb648a4-16eb-11ea-8a37-579cf5197fe8	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	1	2019-12-04 15:09:27.660792	2019-12-04 15:09:27.660792
1eb6fa74-16eb-11ea-8a37-efd8ff4145d8	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	3	2019-12-04 15:09:27.665346	2019-12-04 15:09:27.665346
1eb7b630-16eb-11ea-8a37-b38e09fd5e71	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	15	2019-12-04 15:09:27.67014	2019-12-04 15:09:27.67014
1eb8dcae-16eb-11ea-8a37-ffd60335b85a	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	2	2019-12-04 15:09:27.677662	2019-12-04 15:09:27.677662
1eba06c4-16eb-11ea-8a37-afb8a0e36c4c	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	17	2019-12-04 15:09:27.685302	2019-12-04 15:09:27.685302
1ebb3198-16eb-11ea-8a37-9b37937c5c6a	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	16	2019-12-04 15:09:27.692977	2019-12-04 15:09:27.692977
1ebc5398-16eb-11ea-8a37-6f484880886d	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	21	2019-12-04 15:09:27.700405	2019-12-04 15:09:27.700405
1ebd59b4-16eb-11ea-8a37-7ff71b398230	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	9	2019-12-04 15:09:27.707111	2019-12-04 15:09:27.707111
1ebe6656-16eb-11ea-8a37-afe9db69880b	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	20	2019-12-04 15:09:27.713972	2019-12-04 15:09:27.713972
1ebf6cae-16eb-11ea-8a37-733355d0dc87	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	24	2019-12-04 15:09:27.720699	2019-12-04 15:09:27.720699
1edb93a2-16eb-11ea-8a37-77e1fee77e2a	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	7	2019-12-04 15:09:27.90531	2019-12-04 15:09:27.90531
1edc199e-16eb-11ea-8a37-2b22bcb2a6fc	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	3	2019-12-04 15:09:27.908747	2019-12-04 15:09:27.908747
1edca1a2-16eb-11ea-8a37-7b5f9a72e113	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	6	2019-12-04 15:09:27.912214	2019-12-04 15:09:27.912214
1edd3054-16eb-11ea-8a37-9b6e23517ba5	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	8	2019-12-04 15:09:27.915862	2019-12-04 15:09:27.915862
1ede3076-16eb-11ea-8a37-a789ad2d62bc	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	17	2019-12-04 15:09:27.922405	2019-12-04 15:09:27.922405
1edf41dc-16eb-11ea-8a37-33229f1a4517	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	9	2019-12-04 15:09:27.929347	2019-12-04 15:09:27.929347
1ee068e6-16eb-11ea-8a37-c7d32dae35f7	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	19	2019-12-04 15:09:27.936869	2019-12-04 15:09:27.936869
1ee18a96-16eb-11ea-8a37-3bdb5690b745	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	2	2019-12-04 15:09:27.94426	2019-12-04 15:09:27.94426
1ee2a0a2-16eb-11ea-8a37-6bef06a966f0	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	15	2019-12-04 15:09:27.951375	2019-12-04 15:09:27.951375
1ee3b1ea-16eb-11ea-8a37-8387f2d428a7	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	11	2019-12-04 15:09:27.95837	2019-12-04 15:09:27.95837
1ee4cba2-16eb-11ea-8a37-e3f15ff125c6	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	20	2019-12-04 15:09:27.965493	2019-12-04 15:09:27.965493
1ee5e8d4-16eb-11ea-8a37-1bdaea2c3ecf	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	16	2019-12-04 15:09:27.972829	2019-12-04 15:09:27.972829
1ee6b796-16eb-11ea-8a37-4bd6be17ecbd	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	10	2019-12-04 15:09:27.97817	2019-12-04 15:09:27.97817
1ee77e2e-16eb-11ea-8a37-1f47685877b0	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	5	2019-12-04 15:09:27.983248	2019-12-04 15:09:27.983248
1ee83e4a-16eb-11ea-8a37-b3ca46c90912	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed725a6-16eb-11ea-8a37-6bc976ac0efb	13	2019-12-04 15:09:27.988195	2019-12-04 15:09:27.988195
1ee8fc5e-16eb-11ea-8a37-bbe249439dc7	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	21	2019-12-04 15:09:27.993068	2019-12-04 15:09:27.993068
1ee9b9aa-16eb-11ea-8a37-fb20af0374e6	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	1	2019-12-04 15:09:27.997906	2019-12-04 15:09:27.997906
1eea72b4-16eb-11ea-8a37-f7303dfcf7a3	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	0	2019-12-04 15:09:28.00264	2019-12-04 15:09:28.00264
1eeb2e5c-16eb-11ea-8a37-670ac77fc224	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	4	2019-12-04 15:09:28.007412	2019-12-04 15:09:28.007412
1eebe4dc-16eb-11ea-8a37-93bcccadc7fc	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	12	2019-12-04 15:09:28.012092	2019-12-04 15:09:28.012092
1eed17da-16eb-11ea-8a37-6bb693c62f16	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	18	2019-12-04 15:09:28.019943	2019-12-04 15:09:28.019943
1eee4470-16eb-11ea-8a37-9f5f3c2ed64f	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	14	2019-12-04 15:09:28.027679	2019-12-04 15:09:28.027679
1f0ea896-16eb-11ea-8a37-7ff79c2b0fb7	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	2	2019-12-04 15:09:28.239942	2019-12-04 15:09:28.239942
1f0fb9a2-16eb-11ea-8a37-37f1216c352c	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	5	2019-12-04 15:09:28.246943	2019-12-04 15:09:28.246943
1f10cca2-16eb-11ea-8a37-3ba99e1cc17b	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	4	2019-12-04 15:09:28.253973	2019-12-04 15:09:28.253973
1f11da34-16eb-11ea-8a37-5f8497e984e1	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	1	2019-12-04 15:09:28.260875	2019-12-04 15:09:28.260875
1f1293a2-16eb-11ea-8a37-63ca9ab39390	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	11	2019-12-04 15:09:28.26567	2019-12-04 15:09:28.26567
1f135148-16eb-11ea-8a37-5b74e7d6303a	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	12	2019-12-04 15:09:28.270499	2019-12-04 15:09:28.270499
1f140bc4-16eb-11ea-8a37-0f106e05a528	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	13	2019-12-04 15:09:28.275267	2019-12-04 15:09:28.275267
1f14cabe-16eb-11ea-8a37-53350695c48c	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	3	2019-12-04 15:09:28.280151	2019-12-04 15:09:28.280151
1f158666-16eb-11ea-8a37-530be1c24e57	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	10	2019-12-04 15:09:28.284931	2019-12-04 15:09:28.284931
1f164ed4-16eb-11ea-8a37-1f16466df947	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	7	2019-12-04 15:09:28.290079	2019-12-04 15:09:28.290079
1f1709d2-16eb-11ea-8a37-bf080f835eca	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	9	2019-12-04 15:09:28.294889	2019-12-04 15:09:28.294889
1f17bbc0-16eb-11ea-8a37-bb893aa401aa	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	6	2019-12-04 15:09:28.299435	2019-12-04 15:09:28.299435
1f18ebf8-16eb-11ea-8a37-7f5e9ec15d09	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	8	2019-12-04 15:09:28.307204	2019-12-04 15:09:28.307204
1f1a2130-16eb-11ea-8a37-b7ded8febbf6	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	0	2019-12-04 15:09:28.315085	2019-12-04 15:09:28.315085
1f33e214-16eb-11ea-8a37-b38f08b0aa5c	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	0	2019-12-04 15:09:28.483911	2019-12-04 15:09:28.483911
1f3498b2-16eb-11ea-8a37-33fd7856753f	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	18	2019-12-04 15:09:28.488603	2019-12-04 15:09:28.488603
1f354c6c-16eb-11ea-8a37-fb7415de9118	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	11	2019-12-04 15:09:28.49321	2019-12-04 15:09:28.49321
1f35fd42-16eb-11ea-8a37-13d0495f7945	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	12	2019-12-04 15:09:28.497738	2019-12-04 15:09:28.497738
1f36b9da-16eb-11ea-8a37-ffb2bb0375d2	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	3	2019-12-04 15:09:28.502558	2019-12-04 15:09:28.502558
1f3774ce-16eb-11ea-8a37-a74bfd0b0ef1	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	16	2019-12-04 15:09:28.507348	2019-12-04 15:09:28.507348
1f382acc-16eb-11ea-8a37-834e33057c98	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	14	2019-12-04 15:09:28.511972	2019-12-04 15:09:28.511972
1f394c4a-16eb-11ea-8a37-23f82081f66b	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	8	2019-12-04 15:09:28.519404	2019-12-04 15:09:28.519404
1f3a6fe4-16eb-11ea-8a37-c3ee700ea735	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	1	2019-12-04 15:09:28.526882	2019-12-04 15:09:28.526882
1f3ba49a-16eb-11ea-8a37-db457059fefd	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	10	2019-12-04 15:09:28.534769	2019-12-04 15:09:28.534769
1f3cd568-16eb-11ea-8a37-bb8dc93fc68b	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	15	2019-12-04 15:09:28.542569	2019-12-04 15:09:28.542569
1f3dee3a-16eb-11ea-8a37-438f4acbb695	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	19	2019-12-04 15:09:28.549687	2019-12-04 15:09:28.549687
1f3f0284-16eb-11ea-8a37-37b914c7859f	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	17	2019-12-04 15:09:28.556842	2019-12-04 15:09:28.556842
1f3ffa7c-16eb-11ea-8a37-c326d923f86d	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	4	2019-12-04 15:09:28.563248	2019-12-04 15:09:28.563248
1f40e798-16eb-11ea-8a37-dbdb9a813486	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	2	2019-12-04 15:09:28.569352	2019-12-04 15:09:28.569352
1f417b22-16eb-11ea-8a37-9b921318e4eb	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	7	2019-12-04 15:09:28.573136	2019-12-04 15:09:28.573136
1f420b14-16eb-11ea-8a37-87294f3a2c7b	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	5	2019-12-04 15:09:28.576798	2019-12-04 15:09:28.576798
1f4299da-16eb-11ea-8a37-2333950d14b5	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	6	2019-12-04 15:09:28.580472	2019-12-04 15:09:28.580472
1f432774-16eb-11ea-8a37-8b2914129ee4	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	9	2019-12-04 15:09:28.584095	2019-12-04 15:09:28.584095
1f43abd6-16eb-11ea-8a37-23fed4aeaf0b	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	13	2019-12-04 15:09:28.587507	2019-12-04 15:09:28.587507
1f5d3074-16eb-11ea-8a37-13637334e18c	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	8	2019-12-04 15:09:28.754627	2019-12-04 15:09:28.754627
1f5deece-16eb-11ea-8a37-bb8c253489f9	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	5	2019-12-04 15:09:28.759491	2019-12-04 15:09:28.759491
1f5eb390-16eb-11ea-8a37-a328d9a41224	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	11	2019-12-04 15:09:28.764509	2019-12-04 15:09:28.764509
1f5f82b6-16eb-11ea-8a37-87dfd69a63b9	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	7	2019-12-04 15:09:28.769764	2019-12-04 15:09:28.769764
1f604d18-16eb-11ea-8a37-6ff338b3fa1d	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	2	2019-12-04 15:09:28.774935	2019-12-04 15:09:28.774935
1f612c42-16eb-11ea-8a37-3705be20618a	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	6	2019-12-04 15:09:28.780693	2019-12-04 15:09:28.780693
1f61e646-16eb-11ea-8a37-d75e30eeeff0	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	9	2019-12-04 15:09:28.785476	2019-12-04 15:09:28.785476
1f63079c-16eb-11ea-8a37-bb6f9db78c2d	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	4	2019-12-04 15:09:28.792894	2019-12-04 15:09:28.792894
1f643d56-16eb-11ea-8a37-6f15cda6e746	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	10	2019-12-04 15:09:28.800765	2019-12-04 15:09:28.800765
1f657be4-16eb-11ea-8a37-d7a6f6a3c5c3	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	0	2019-12-04 15:09:28.80897	2019-12-04 15:09:28.80897
1f66aa14-16eb-11ea-8a37-d3322615a704	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	3	2019-12-04 15:09:28.816705	2019-12-04 15:09:28.816705
1f67afa4-16eb-11ea-8a37-bbc8a5ab19d9	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	1	2019-12-04 15:09:28.823425	2019-12-04 15:09:28.823425
1f7ee99e-16eb-11ea-8a37-d3680a3301f0	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	1	2019-12-04 15:09:28.975633	2019-12-04 15:09:28.975633
1f801184-16eb-11ea-8a37-73d47a59343e	1f729be4-16eb-11ea-8a37-f7402b31f897	1f770fda-16eb-11ea-8a37-e7fcf1bf9286	0	2019-12-04 15:09:28.983167	2019-12-04 15:09:28.983167
1f813dc0-16eb-11ea-8a37-4b2bc0feb89e	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	4	2019-12-04 15:09:28.990883	2019-12-04 15:09:28.990883
1f826452-16eb-11ea-8a37-2b6a82c4e2e2	1f729be4-16eb-11ea-8a37-f7402b31f897	1f74e8e0-16eb-11ea-8a37-1777ac953c6b	8	2019-12-04 15:09:28.998426	2019-12-04 15:09:28.998426
1f839c5a-16eb-11ea-8a37-435fd0bcdf5c	1f729be4-16eb-11ea-8a37-f7402b31f897	1f7820b4-16eb-11ea-8a37-d775fb8e679a	8	2019-12-04 15:09:29.006395	2019-12-04 15:09:29.006395
1f84b6a8-16eb-11ea-8a37-979fb94399e0	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	9	2019-12-04 15:09:29.013534	2019-12-04 15:09:29.013534
1f85d952-16eb-11ea-8a37-5394760f3a6a	1f729be4-16eb-11ea-8a37-f7402b31f897	1f770fda-16eb-11ea-8a37-e7fcf1bf9286	8	2019-12-04 15:09:29.021045	2019-12-04 15:09:29.021045
1f86eb58-16eb-11ea-8a37-e3282303b2bf	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	10	2019-12-04 15:09:29.028093	2019-12-04 15:09:29.028093
1f87f340-16eb-11ea-8a37-379a2c834678	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	11	2019-12-04 15:09:29.034849	2019-12-04 15:09:29.034849
1f88abaa-16eb-11ea-8a37-eb3a286425ad	1f729be4-16eb-11ea-8a37-f7402b31f897	1f74e8e0-16eb-11ea-8a37-1777ac953c6b	7	2019-12-04 15:09:29.039579	2019-12-04 15:09:29.039579
1f896dce-16eb-11ea-8a37-6be5f99e56cf	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	6	2019-12-04 15:09:29.044517	2019-12-04 15:09:29.044517
1f8a271e-16eb-11ea-8a37-67ffd9b9b8fb	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	5	2019-12-04 15:09:29.049251	2019-12-04 15:09:29.049251
1f8aeca8-16eb-11ea-8a37-6b26604849a3	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	2	2019-12-04 15:09:29.054302	2019-12-04 15:09:29.054302
1f8ba86e-16eb-11ea-8a37-83579833a727	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	12	2019-12-04 15:09:29.059133	2019-12-04 15:09:29.059133
1f8c5c32-16eb-11ea-8a37-9fa076ccb419	1f729be4-16eb-11ea-8a37-f7402b31f897	1f770fda-16eb-11ea-8a37-e7fcf1bf9286	7	2019-12-04 15:09:29.063755	2019-12-04 15:09:29.063755
1f8d165e-16eb-11ea-8a37-d77fe94ad423	1f729be4-16eb-11ea-8a37-f7402b31f897	1f74e8e0-16eb-11ea-8a37-1777ac953c6b	0	2019-12-04 15:09:29.068477	2019-12-04 15:09:29.068477
1f8dcb8a-16eb-11ea-8a37-977deb409bac	1f729be4-16eb-11ea-8a37-f7402b31f897	1f7820b4-16eb-11ea-8a37-d775fb8e679a	7	2019-12-04 15:09:29.073175	2019-12-04 15:09:29.073175
1f8eff82-16eb-11ea-8a37-a3afeb34b4ba	1f729be4-16eb-11ea-8a37-f7402b31f897	1f7820b4-16eb-11ea-8a37-d775fb8e679a	0	2019-12-04 15:09:29.081023	2019-12-04 15:09:29.081023
1f903186-16eb-11ea-8a37-0fc916c95d29	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	3	2019-12-04 15:09:29.088857	2019-12-04 15:09:29.088857
1fb6f71c-16eb-11ea-8a37-fb56dbe5c3a7	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	2	2019-12-04 15:09:29.342952	2019-12-04 15:09:29.342952
1fb7ab08-16eb-11ea-8a37-e3633b98105f	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	18	2019-12-04 15:09:29.347578	2019-12-04 15:09:29.347578
1fb86f5c-16eb-11ea-8a37-5f7fcdc768dd	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	23	2019-12-04 15:09:29.352589	2019-12-04 15:09:29.352589
1fb9296a-16eb-11ea-8a37-fb416240d2f7	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	16	2019-12-04 15:09:29.357371	2019-12-04 15:09:29.357371
1fb9e404-16eb-11ea-8a37-0bb2e3c0d8ca	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	18	2019-12-04 15:09:29.362153	2019-12-04 15:09:29.362153
1fbb0b40-16eb-11ea-8a37-a396ee7c73bc	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	19	2019-12-04 15:09:29.369676	2019-12-04 15:09:29.369676
1fbc3e70-16eb-11ea-8a37-c307172732de	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	8	2019-12-04 15:09:29.377423	2019-12-04 15:09:29.377423
1fbd7614-16eb-11ea-8a37-f397f8946ece	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	13	2019-12-04 15:09:29.385431	2019-12-04 15:09:29.385431
1fbea412-16eb-11ea-8a37-cfc67a461eb9	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	17	2019-12-04 15:09:29.393265	2019-12-04 15:09:29.393265
1fbfbd70-16eb-11ea-8a37-bb861c8e7267	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	20	2019-12-04 15:09:29.400417	2019-12-04 15:09:29.400417
1fc0d994-16eb-11ea-8a37-77d7d1b1d7f4	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	5	2019-12-04 15:09:29.40773	2019-12-04 15:09:29.40773
1fc1eac8-16eb-11ea-8a37-8bf51ff6c3e0	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	1	2019-12-04 15:09:29.414709	2019-12-04 15:09:29.414709
1fc2f4f4-16eb-11ea-8a37-43e74cad2e96	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	6	2019-12-04 15:09:29.421448	2019-12-04 15:09:29.421448
1fc3aac0-16eb-11ea-8a37-9772d94b2df2	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	22	2019-12-04 15:09:29.426218	2019-12-04 15:09:29.426218
1fc45a74-16eb-11ea-8a37-7338ada27422	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	9	2019-12-04 15:09:29.430723	2019-12-04 15:09:29.430723
1fc516da-16eb-11ea-8a37-83667d953757	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	7	2019-12-04 15:09:29.435467	2019-12-04 15:09:29.435467
1fc5d6d8-16eb-11ea-8a37-670bc09a0926	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	12	2019-12-04 15:09:29.440431	2019-12-04 15:09:29.440431
1fc69078-16eb-11ea-8a37-17617186e06e	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	11	2019-12-04 15:09:29.445125	2019-12-04 15:09:29.445125
1fc753aa-16eb-11ea-8a37-cfee37d79c0c	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	21	2019-12-04 15:09:29.45014	2019-12-04 15:09:29.45014
1fc8188a-16eb-11ea-8a37-bf1fbae866e7	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	0	2019-12-04 15:09:29.455231	2019-12-04 15:09:29.455231
1fc8ce56-16eb-11ea-8a37-9f20c69ab0c6	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	1	2019-12-04 15:09:29.459902	2019-12-04 15:09:29.459902
1fc9f402-16eb-11ea-8a37-03c3b207ef9a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	14	2019-12-04 15:09:29.467403	2019-12-04 15:09:29.467403
1fcb2732-16eb-11ea-8a37-cfb770dfdb2a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	0	2019-12-04 15:09:29.47521	2019-12-04 15:09:29.47521
1fcc61c4-16eb-11ea-8a37-b323822c9cbe	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	15	2019-12-04 15:09:29.483264	2019-12-04 15:09:29.483264
1fcd951c-16eb-11ea-8a37-577540c97a7b	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	4	2019-12-04 15:09:29.491158	2019-12-04 15:09:29.491158
1fcea376-16eb-11ea-8a37-5312f79197da	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	10	2019-12-04 15:09:29.498095	2019-12-04 15:09:29.498095
1fcfb022-16eb-11ea-8a37-139566f629e7	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	17	2019-12-04 15:09:29.504969	2019-12-04 15:09:29.504969
1fd0c8ea-16eb-11ea-8a37-cb3020d826d3	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	16	2019-12-04 15:09:29.512095	2019-12-04 15:09:29.512095
1fd1dc8a-16eb-11ea-8a37-f7d6a6476c2f	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	3	2019-12-04 15:09:29.519224	2019-12-04 15:09:29.519224
1fef6a2a-16eb-11ea-8a37-f3650aae285d	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	10	2019-12-04 15:09:29.712917	2019-12-04 15:09:29.712917
1ff02ee2-16eb-11ea-8a37-df1d0f44643d	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	4	2019-12-04 15:09:29.717942	2019-12-04 15:09:29.717942
1ff0ea58-16eb-11ea-8a37-2b0da36793f5	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	23	2019-12-04 15:09:29.722747	2019-12-04 15:09:29.722747
1ff20af0-16eb-11ea-8a37-af5a045d3aef	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	24	2019-12-04 15:09:29.730128	2019-12-04 15:09:29.730128
1ff326ec-16eb-11ea-8a37-67a783512f46	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	22	2019-12-04 15:09:29.737415	2019-12-04 15:09:29.737415
1ff447d4-16eb-11ea-8a37-2f96016eb8bd	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	7	2019-12-04 15:09:29.744794	2019-12-04 15:09:29.744794
1ff56218-16eb-11ea-8a37-f33c2bbc0ea0	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	2	2019-12-04 15:09:29.752013	2019-12-04 15:09:29.752013
1ff661cc-16eb-11ea-8a37-2f774f06a3dd	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	8	2019-12-04 15:09:29.75859	2019-12-04 15:09:29.75859
1ff761bc-16eb-11ea-8a37-77dd5530125a	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	19	2019-12-04 15:09:29.765147	2019-12-04 15:09:29.765147
1ff94d74-16eb-11ea-8a37-d30a78647159	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	9	2019-12-04 15:09:29.777665	2019-12-04 15:09:29.777665
1ffa5372-16eb-11ea-8a37-9324a005e6a0	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	25	2019-12-04 15:09:29.784402	2019-12-04 15:09:29.784402
1ffb0d4e-16eb-11ea-8a37-037640923cde	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	6	2019-12-04 15:09:29.789201	2019-12-04 15:09:29.789201
1ffbcbb2-16eb-11ea-8a37-7312cb6f8f9e	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	21	2019-12-04 15:09:29.794072	2019-12-04 15:09:29.794072
1ffc86b0-16eb-11ea-8a37-2ff6057fab78	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	14	2019-12-04 15:09:29.798848	2019-12-04 15:09:29.798848
1ffd3de4-16eb-11ea-8a37-13abfb167177	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	16	2019-12-04 15:09:29.803541	2019-12-04 15:09:29.803541
1ffdf392-16eb-11ea-8a37-4ba116dad690	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	17	2019-12-04 15:09:29.808206	2019-12-04 15:09:29.808206
1ffea9e0-16eb-11ea-8a37-9b80b7538fc1	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	11	2019-12-04 15:09:29.812871	2019-12-04 15:09:29.812871
1fff5f84-16eb-11ea-8a37-eb778000f383	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	5	2019-12-04 15:09:29.817447	2019-12-04 15:09:29.817447
2000137a-16eb-11ea-8a37-5f5cc6241f59	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	15	2019-12-04 15:09:29.822127	2019-12-04 15:09:29.822127
2000d418-16eb-11ea-8a37-2f1660c7010c	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	18	2019-12-04 15:09:29.827053	2019-12-04 15:09:29.827053
200199ca-16eb-11ea-8a37-9b2aac82f465	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	3	2019-12-04 15:09:29.832116	2019-12-04 15:09:29.832116
20025ef0-16eb-11ea-8a37-871697acc723	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	0	2019-12-04 15:09:29.837097	2019-12-04 15:09:29.837097
20032a6a-16eb-11ea-8a37-f7fad83a0f3b	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	12	2019-12-04 15:09:29.842368	2019-12-04 15:09:29.842368
2003ed06-16eb-11ea-8a37-73bb7336c326	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	1	2019-12-04 15:09:29.847325	2019-12-04 15:09:29.847325
2005593e-16eb-11ea-8a37-ebb7c5b259a9	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	13	2019-12-04 15:09:29.856615	2019-12-04 15:09:29.856615
20063854-16eb-11ea-8a37-47fbeecaf125	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	4	2019-12-04 15:09:29.862387	2019-12-04 15:09:29.862387
200737c2-16eb-11ea-8a37-2fd0f1471b53	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	20	2019-12-04 15:09:29.868917	2019-12-04 15:09:29.868917
20324fc0-16eb-11ea-8a37-1fad73a2e1d3	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	5	2019-12-04 15:09:30.151388	2019-12-04 15:09:30.151388
2032f060-16eb-11ea-8a37-07d5350d35d3	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	16	2019-12-04 15:09:30.155537	2019-12-04 15:09:30.155537
20338840-16eb-11ea-8a37-c3f8d1055c02	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	12	2019-12-04 15:09:30.159447	2019-12-04 15:09:30.159447
20341d14-16eb-11ea-8a37-03e3576a589a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	11	2019-12-04 15:09:30.163253	2019-12-04 15:09:30.163253
2034af22-16eb-11ea-8a37-d7d6751e9438	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20225cd2-16eb-11ea-8a37-bfcb30311269	14	2019-12-04 15:09:30.166995	2019-12-04 15:09:30.166995
203537a8-16eb-11ea-8a37-0b7a4699e184	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	4	2019-12-04 15:09:30.170506	2019-12-04 15:09:30.170506
2035bdea-16eb-11ea-8a37-d7492deaa959	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2024f7ee-16eb-11ea-8a37-bb1b3908b21a	0	2019-12-04 15:09:30.173923	2019-12-04 15:09:30.173923
20364242-16eb-11ea-8a37-171c11d98981	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2024f7ee-16eb-11ea-8a37-bb1b3908b21a	14	2019-12-04 15:09:30.177323	2019-12-04 15:09:30.177323
2036c9e2-16eb-11ea-8a37-1b58c221a79a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20225cd2-16eb-11ea-8a37-bfcb30311269	13	2019-12-04 15:09:30.180782	2019-12-04 15:09:30.180782
2037c02c-16eb-11ea-8a37-4f38ed7a4eab	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	7	2019-12-04 15:09:30.187096	2019-12-04 15:09:30.187096
2038b8ba-16eb-11ea-8a37-93ea2d921216	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	18	2019-12-04 15:09:30.193442	2019-12-04 15:09:30.193442
2039b292-16eb-11ea-8a37-872a73344b2c	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	19	2019-12-04 15:09:30.199833	2019-12-04 15:09:30.199833
203aa6b6-16eb-11ea-8a37-47f99332392e	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20267dd0-16eb-11ea-8a37-9b8a85645ffc	13	2019-12-04 15:09:30.206102	2019-12-04 15:09:30.206102
203b82c0-16eb-11ea-8a37-43ad06841760	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	3	2019-12-04 15:09:30.211728	2019-12-04 15:09:30.211728
203c5cf4-16eb-11ea-8a37-b74f62c8f0cd	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	8	2019-12-04 15:09:30.217348	2019-12-04 15:09:30.217348
203d3232-16eb-11ea-8a37-67195a4f528b	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	20	2019-12-04 15:09:30.222815	2019-12-04 15:09:30.222815
203e0b1c-16eb-11ea-8a37-6bc7e2fb27b5	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	2	2019-12-04 15:09:30.228371	2019-12-04 15:09:30.228371
203eb666-16eb-11ea-8a37-37a1c8ed65c2	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	15	2019-12-04 15:09:30.232617	2019-12-04 15:09:30.232617
203f6fd4-16eb-11ea-8a37-8b8cf09e1a5d	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20267dd0-16eb-11ea-8a37-9b8a85645ffc	14	2019-12-04 15:09:30.237371	2019-12-04 15:09:30.237371
20402f50-16eb-11ea-8a37-7fb857f87054	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20225cd2-16eb-11ea-8a37-bfcb30311269	0	2019-12-04 15:09:30.242277	2019-12-04 15:09:30.242277
2040e90e-16eb-11ea-8a37-0713366dd0cb	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	9	2019-12-04 15:09:30.247027	2019-12-04 15:09:30.247027
20419d90-16eb-11ea-8a37-5fcc2a1b4d63	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	17	2019-12-04 15:09:30.251649	2019-12-04 15:09:30.251649
20425654-16eb-11ea-8a37-c7e903250cee	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	1	2019-12-04 15:09:30.256381	2019-12-04 15:09:30.256381
20430c5c-16eb-11ea-8a37-eb7accacd942	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2025c138-16eb-11ea-8a37-bbfaf9205991	21	2019-12-04 15:09:30.260982	2019-12-04 15:09:30.260982
2043cd9a-16eb-11ea-8a37-53ddec0559ee	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2024f7ee-16eb-11ea-8a37-bb1b3908b21a	13	2019-12-04 15:09:30.26595	2019-12-04 15:09:30.26595
20450052-16eb-11ea-8a37-ab676aae841e	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20267dd0-16eb-11ea-8a37-9b8a85645ffc	0	2019-12-04 15:09:30.273811	2019-12-04 15:09:30.273811
20461b18-16eb-11ea-8a37-d73eeadcd195	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	10	2019-12-04 15:09:30.281131	2019-12-04 15:09:30.281131
20472800-16eb-11ea-8a37-2f3a99b8a2bf	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	6	2019-12-04 15:09:30.288022	2019-12-04 15:09:30.288022
20482bd8-16eb-11ea-8a37-9f227cd5ca7a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2025c138-16eb-11ea-8a37-bbfaf9205991	13	2019-12-04 15:09:30.294696	2019-12-04 15:09:30.294696
2049031e-16eb-11ea-8a37-f36debba5d79	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2025c138-16eb-11ea-8a37-bbfaf9205991	0	2019-12-04 15:09:30.300218	2019-12-04 15:09:30.300218
206a4f2e-16eb-11ea-8a37-0f7a8361785d	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	5	2019-12-04 15:09:30.518315	2019-12-04 15:09:30.518315
206afdf2-16eb-11ea-8a37-cbc30fb64c15	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	1	2019-12-04 15:09:30.522815	2019-12-04 15:09:30.522815
206bb63e-16eb-11ea-8a37-7fc5cdb2b32f	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	3	2019-12-04 15:09:30.527516	2019-12-04 15:09:30.527516
206c66ce-16eb-11ea-8a37-ef12141e9dcc	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	4	2019-12-04 15:09:30.532046	2019-12-04 15:09:30.532046
206d1a7e-16eb-11ea-8a37-7f5bb3bc8d4d	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	0	2019-12-04 15:09:30.536637	2019-12-04 15:09:30.536637
206e44d0-16eb-11ea-8a37-47fc9f7c57bf	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	2	2019-12-04 15:09:30.544269	2019-12-04 15:09:30.544269
206f72b0-16eb-11ea-8a37-8ff96ee011a9	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	7	2019-12-04 15:09:30.551979	2019-12-04 15:09:30.551979
20709a14-16eb-11ea-8a37-9f82002a0ac9	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	6	2019-12-04 15:09:30.559569	2019-12-04 15:09:30.559569
207bc4c0-16eb-11ea-8a37-2fbfa435fa6f	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	2	2019-12-04 15:09:30.632743	2019-12-04 15:09:30.632743
207cebf2-16eb-11ea-8a37-0f2d936d9e84	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	3	2019-12-04 15:09:30.640288	2019-12-04 15:09:30.640288
207e143c-16eb-11ea-8a37-e75d5fb4b19b	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	4	2019-12-04 15:09:30.647883	2019-12-04 15:09:30.647883
207f4050-16eb-11ea-8a37-2767984dd5ee	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	7	2019-12-04 15:09:30.655572	2019-12-04 15:09:30.655572
20807164-16eb-11ea-8a37-bf2673973efc	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	6	2019-12-04 15:09:30.663372	2019-12-04 15:09:30.663372
208183d8-16eb-11ea-8a37-1f983e10a156	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	5	2019-12-04 15:09:30.670408	2019-12-04 15:09:30.670408
208286f2-16eb-11ea-8a37-6f9859722662	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	0	2019-12-04 15:09:30.677025	2019-12-04 15:09:30.677025
2083992a-16eb-11ea-8a37-b79143afe011	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	1	2019-12-04 15:09:30.684057	2019-12-04 15:09:30.684057
20849cc6-16eb-11ea-8a37-6b5d67702bf7	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	8	2019-12-04 15:09:30.69068	2019-12-04 15:09:30.69068
2097201c-16eb-11ea-8a37-9f7d47d97f1e	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	4	2019-12-04 15:09:30.812033	2019-12-04 15:09:30.812033
2097dd0e-16eb-11ea-8a37-274497e47430	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	3	2019-12-04 15:09:30.816844	2019-12-04 15:09:30.816844
20989b22-16eb-11ea-8a37-ef27f1d921d4	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	12	2019-12-04 15:09:30.821707	2019-12-04 15:09:30.821707
20995404-16eb-11ea-8a37-536731d04b07	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	18	2019-12-04 15:09:30.826474	2019-12-04 15:09:30.826474
209a8496-16eb-11ea-8a37-630a0c8b6de8	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	15	2019-12-04 15:09:30.83426	2019-12-04 15:09:30.83426
209bb0b4-16eb-11ea-8a37-370c48366b4a	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	16	2019-12-04 15:09:30.841949	2019-12-04 15:09:30.841949
209cdd86-16eb-11ea-8a37-835b02d8d9c2	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	7	2019-12-04 15:09:30.849547	2019-12-04 15:09:30.849547
209e09ae-16eb-11ea-8a37-674fc92d4d0f	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	10	2019-12-04 15:09:30.857329	2019-12-04 15:09:30.857329
209f1a1a-16eb-11ea-8a37-7b13aab7a46a	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	0	2019-12-04 15:09:30.864283	2019-12-04 15:09:30.864283
20a02202-16eb-11ea-8a37-63fc3d9a1bdf	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	14	2019-12-04 15:09:30.871033	2019-12-04 15:09:30.871033
20a1262a-16eb-11ea-8a37-b7e95157d68b	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	5	2019-12-04 15:09:30.877692	2019-12-04 15:09:30.877692
20a22f48-16eb-11ea-8a37-5f7a686fadf0	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	8	2019-12-04 15:09:30.88448	2019-12-04 15:09:30.88448
20a2f450-16eb-11ea-8a37-43c1cb4d848a	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	2	2019-12-04 15:09:30.889486	2019-12-04 15:09:30.889486
20a3b7fa-16eb-11ea-8a37-8f117560a828	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	6	2019-12-04 15:09:30.894504	2019-12-04 15:09:30.894504
20a47942-16eb-11ea-8a37-3b54fc0bc4b5	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	11	2019-12-04 15:09:30.899468	2019-12-04 15:09:30.899468
20a53bf2-16eb-11ea-8a37-8f0cf3a96866	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	9	2019-12-04 15:09:30.904441	2019-12-04 15:09:30.904441
20a5f650-16eb-11ea-8a37-7f8bc3401ccf	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	13	2019-12-04 15:09:30.909232	2019-12-04 15:09:30.909232
20a6b3c4-16eb-11ea-8a37-e7c8146e44d8	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	17	2019-12-04 15:09:30.914066	2019-12-04 15:09:30.914066
20a772be-16eb-11ea-8a37-6f61be4806a4	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	1	2019-12-04 15:09:30.918992	2019-12-04 15:09:30.918992
20c170e2-16eb-11ea-8a37-7bfac432f22a	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	0	2019-12-04 15:09:31.089362	2019-12-04 15:09:31.089362
20c23b76-16eb-11ea-8a37-57f1ab9ee910	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	1	2019-12-04 15:09:31.094541	2019-12-04 15:09:31.094541
20c2f5b6-16eb-11ea-8a37-5ffd3a08d1c2	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	7	2019-12-04 15:09:31.0993	2019-12-04 15:09:31.0993
20c3af2e-16eb-11ea-8a37-53d28125615c	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	5	2019-12-04 15:09:31.104054	2019-12-04 15:09:31.104054
20c46a90-16eb-11ea-8a37-7387767e0f7c	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	3	2019-12-04 15:09:31.108853	2019-12-04 15:09:31.108853
20c52a66-16eb-11ea-8a37-67581f6554cc	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	6	2019-12-04 15:09:31.113693	2019-12-04 15:09:31.113693
20c5f0ea-16eb-11ea-8a37-97b4bb999637	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	2	2019-12-04 15:09:31.11884	2019-12-04 15:09:31.11884
20c71cea-16eb-11ea-8a37-b7f83bddce84	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	4	2019-12-04 15:09:31.126495	2019-12-04 15:09:31.126495
20e3e3b6-16eb-11ea-8a37-3b2c8ae95c0c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	0	2019-12-04 15:09:31.315104	2019-12-04 15:09:31.315104
216eab9a-16eb-11ea-8a37-9fa3eab43fba	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	0	2019-12-04 15:09:32.224635	2019-12-04 15:09:32.224635
22b006de-16eb-11ea-8a37-8fb3bd003d9a	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	0	2019-12-04 15:09:34.330784	2019-12-04 15:09:34.330784
\.


--
-- Data for Name: program_sequence_binding_meme; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence_binding_meme (id, program_id, program_sequence_binding_id, name, created_at, updated_at) FROM stdin;
1a278b72-16eb-11ea-8a37-53c38b807368	1a21695e-16eb-11ea-8a37-471123a2fa62	1a25f55a-16eb-11ea-8a37-b7d63bb64393	Hot	2019-12-04 15:09:20.014288	2019-12-04 15:09:20.014288
1a283c5c-16eb-11ea-8a37-17606ce7cf1e	1a21695e-16eb-11ea-8a37-471123a2fa62	1a269c76-16eb-11ea-8a37-53fabc410ad8	Cool	2019-12-04 15:09:20.018957	2019-12-04 15:09:20.018957
1a28d5ea-16eb-11ea-8a37-87d7d1437a4f	1a21695e-16eb-11ea-8a37-471123a2fa62	1a25f55a-16eb-11ea-8a37-b7d63bb64393	Easy	2019-12-04 15:09:20.022931	2019-12-04 15:09:20.022931
1a2a1798-16eb-11ea-8a37-2bfb48071a19	1a21695e-16eb-11ea-8a37-471123a2fa62	1a269c76-16eb-11ea-8a37-53fabc410ad8	Hard	2019-12-04 15:09:20.030886	2019-12-04 15:09:20.030886
1a32e58a-16eb-11ea-8a37-0712e6759893	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a307e62-16eb-11ea-8a37-37010a35a7b7	Hot	2019-12-04 15:09:20.08855	2019-12-04 15:09:20.08855
1a33cebe-16eb-11ea-8a37-b32c8e65c6e6	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a307e62-16eb-11ea-8a37-37010a35a7b7	Tropical	2019-12-04 15:09:20.094707	2019-12-04 15:09:20.094707
1a34b20c-16eb-11ea-8a37-7b013a9a50d1	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a31b192-16eb-11ea-8a37-f71bb9862140	Cool	2019-12-04 15:09:20.100498	2019-12-04 15:09:20.100498
1a3593ac-16eb-11ea-8a37-cb2061dc6a84	1a2b79da-16eb-11ea-8a37-83af2bc21c26	1a31b192-16eb-11ea-8a37-f71bb9862140	Electro	2019-12-04 15:09:20.106293	2019-12-04 15:09:20.106293
1a3cd8e2-16eb-11ea-8a37-1b7367e00629	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a3a4de8-16eb-11ea-8a37-2f48cf13837c	Earth	2019-12-04 15:09:20.153939	2019-12-04 15:09:20.153939
1a3e100e-16eb-11ea-8a37-4b8eb99d0fd7	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a396798-16eb-11ea-8a37-0790714b7955	Fire	2019-12-04 15:09:20.161937	2019-12-04 15:09:20.161937
1a3f46cc-16eb-11ea-8a37-eb499110b2cb	1a36a1ca-16eb-11ea-8a37-536b94a6f3ff	1a3b9a9a-16eb-11ea-8a37-0f1de4dd940d	Fire	2019-12-04 15:09:20.169961	2019-12-04 15:09:20.169961
1a455a58-16eb-11ea-8a37-cf90b6d33289	1a40808c-16eb-11ea-8a37-cb54f3323275	1a43fb4a-16eb-11ea-8a37-4fe4560a3bfd	Earth	2019-12-04 15:09:20.209899	2019-12-04 15:09:20.209899
1a45f6e8-16eb-11ea-8a37-0bb943262de8	1a40808c-16eb-11ea-8a37-cb54f3323275	1a44bca6-16eb-11ea-8a37-fbfc3b17d736	Water	2019-12-04 15:09:20.213868	2019-12-04 15:09:20.213868
1a49fb62-16eb-11ea-8a37-2fa58499ef0f	1a46a2be-16eb-11ea-8a37-7396524c6a27	1a4868c4-16eb-11ea-8a37-9bd34d01a9b0	Earth	2019-12-04 15:09:20.240257	2019-12-04 15:09:20.240257
1a4afe18-16eb-11ea-8a37-0b403a0fa851	1a46a2be-16eb-11ea-8a37-7396524c6a27	1a48fc44-16eb-11ea-8a37-9384ed519968	Wind	2019-12-04 15:09:20.246877	2019-12-04 15:09:20.246877
1a5170a4-16eb-11ea-8a37-df05b9c0f704	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	1a4ef8a6-16eb-11ea-8a37-27b761ff24b4	Earth	2019-12-04 15:09:20.288995	2019-12-04 15:09:20.288995
1a525776-16eb-11ea-8a37-43efd982eead	1a4c0f74-16eb-11ea-8a37-c7d65a03364a	1a4fe8ba-16eb-11ea-8a37-eb1eefebea79	Fire	2019-12-04 15:09:20.294914	2019-12-04 15:09:20.294914
1a59e64e-16eb-11ea-8a37-578af025eaea	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a5899f6-16eb-11ea-8a37-57ba96eca107	Fire	2019-12-04 15:09:20.344435	2019-12-04 15:09:20.344435
1a5b1a14-16eb-11ea-8a37-dfc5d695e1a5	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a567734-16eb-11ea-8a37-572dee279e73	Water	2019-12-04 15:09:20.35233	2019-12-04 15:09:20.35233
1a5c4592-16eb-11ea-8a37-8b6fcb5f40cb	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a573746-16eb-11ea-8a37-b7156bfdf7be	Fire	2019-12-04 15:09:20.360017	2019-12-04 15:09:20.360017
1a5d7250-16eb-11ea-8a37-1f7af3c396be	1a533b1e-16eb-11ea-8a37-1b89f02a00e8	1a5899f6-16eb-11ea-8a37-57ba96eca107	Water	2019-12-04 15:09:20.367714	2019-12-04 15:09:20.367714
1a664b82-16eb-11ea-8a37-0713700abbd3	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a658b3e-16eb-11ea-8a37-73219a619460	Fire	2019-12-04 15:09:20.425694	2019-12-04 15:09:20.425694
1a670b94-16eb-11ea-8a37-1f726403c414	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a64c956-16eb-11ea-8a37-e3d3d4053237	Fire	2019-12-04 15:09:20.43061	2019-12-04 15:09:20.43061
1a67cdc2-16eb-11ea-8a37-7b868d746474	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a64c956-16eb-11ea-8a37-e3d3d4053237	Wind	2019-12-04 15:09:20.435555	2019-12-04 15:09:20.435555
1a688b90-16eb-11ea-8a37-474d9aedf874	1a5e97e8-16eb-11ea-8a37-1327bf2f94a0	1a6405e8-16eb-11ea-8a37-3f0608242834	Wind	2019-12-04 15:09:20.440427	2019-12-04 15:09:20.440427
1a70bd56-16eb-11ea-8a37-9b92019f1978	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6ee436-16eb-11ea-8a37-43682d35bf40	Earth	2019-12-04 15:09:20.4942	2019-12-04 15:09:20.4942
1a71b6fc-16eb-11ea-8a37-7bc0c5e264db	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6fd77e-16eb-11ea-8a37-1f7cb6f94684	Earth	2019-12-04 15:09:20.500566	2019-12-04 15:09:20.500566
1a7279f2-16eb-11ea-8a37-63d9902d44af	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6df422-16eb-11ea-8a37-6bcb1ca3c327	Water	2019-12-04 15:09:20.505471	2019-12-04 15:09:20.505471
1a7343be-16eb-11ea-8a37-2bcf543e4835	1a696574-16eb-11ea-8a37-0b820d50edf4	1a6ee436-16eb-11ea-8a37-43682d35bf40	Water	2019-12-04 15:09:20.510674	2019-12-04 15:09:20.510674
1a7a77c4-16eb-11ea-8a37-771bff6cd5ad	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a773d7a-16eb-11ea-8a37-ef8d16931cd7	Fire	2019-12-04 15:09:20.557896	2019-12-04 15:09:20.557896
1a7baac2-16eb-11ea-8a37-ef9d6716f18c	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a793cb0-16eb-11ea-8a37-f39b42c63d29	Water	2019-12-04 15:09:20.565761	2019-12-04 15:09:20.565761
1a7cdd0c-16eb-11ea-8a37-73e5d30f5d24	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a773d7a-16eb-11ea-8a37-ef8d16931cd7	Water	2019-12-04 15:09:20.573529	2019-12-04 15:09:20.573529
1a7dedc8-16eb-11ea-8a37-f31b7e19b70d	1a741e1a-16eb-11ea-8a37-bfcc21e2cd33	1a77ff30-16eb-11ea-8a37-1b2369a14bee	Fire	2019-12-04 15:09:20.580557	2019-12-04 15:09:20.580557
1a8516ca-16eb-11ea-8a37-77e72fffa8c7	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a845b36-16eb-11ea-8a37-0393d3c1ed26	Wind	2019-12-04 15:09:20.627499	2019-12-04 15:09:20.627499
1a85de3e-16eb-11ea-8a37-8722d8063cc4	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a83994e-16eb-11ea-8a37-df81dcee2373	Water	2019-12-04 15:09:20.632564	2019-12-04 15:09:20.632564
1a86a080-16eb-11ea-8a37-6b35a2b92570	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a83994e-16eb-11ea-8a37-df81dcee2373	Wind	2019-12-04 15:09:20.637528	2019-12-04 15:09:20.637528
1a876308-16eb-11ea-8a37-0f67adc4f41f	1a7f128e-16eb-11ea-8a37-f7bc27184026	1a82cfe6-16eb-11ea-8a37-7b62d23c3bba	Water	2019-12-04 15:09:20.642571	2019-12-04 15:09:20.642571
1a90bfc0-16eb-11ea-8a37-d3f85e8f4d02	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8eadac-16eb-11ea-8a37-0340a79d32cc	Earth	2019-12-04 15:09:20.703922	2019-12-04 15:09:20.703922
1a917eba-16eb-11ea-8a37-4f334d5289fa	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8fb8aa-16eb-11ea-8a37-334554c680fa	Wind	2019-12-04 15:09:20.708806	2019-12-04 15:09:20.708806
1a92426e-16eb-11ea-8a37-bf1b246f1ede	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8d94da-16eb-11ea-8a37-7f8ae8ebfe29	Wind	2019-12-04 15:09:20.713814	2019-12-04 15:09:20.713814
1a9308d4-16eb-11ea-8a37-df9859e90b33	1a88b7da-16eb-11ea-8a37-6b20c565ae15	1a8fb8aa-16eb-11ea-8a37-334554c680fa	Earth	2019-12-04 15:09:20.718889	2019-12-04 15:09:20.718889
1a981eaa-16eb-11ea-8a37-5fea9cec84fa	1a93d8ea-16eb-11ea-8a37-07702a221e45	1a96ebb6-16eb-11ea-8a37-5b995f453e28	Fire	2019-12-04 15:09:20.752197	2019-12-04 15:09:20.752197
1a994d98-16eb-11ea-8a37-0b5839313c13	1a93d8ea-16eb-11ea-8a37-07702a221e45	1a9629e2-16eb-11ea-8a37-93cb31e58acc	Wind	2019-12-04 15:09:20.75998	2019-12-04 15:09:20.75998
1aa00b06-16eb-11ea-8a37-f347a8b5753b	1a9a8ff0-16eb-11ea-8a37-5736573db704	1a9f0134-16eb-11ea-8a37-df55db49535f	Wind	2019-12-04 15:09:20.804145	2019-12-04 15:09:20.804145
1aa0cd34-16eb-11ea-8a37-5f367f6ff47c	1a9a8ff0-16eb-11ea-8a37-5736573db704	1a9df7b2-16eb-11ea-8a37-5ba2da38ab38	Water	2019-12-04 15:09:20.809116	2019-12-04 15:09:20.809116
1ac4e26e-16eb-11ea-8a37-fb9693a61353	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abdeeaa-16eb-11ea-8a37-4b0d9e1ec39e	Steady	2019-12-04 15:09:21.045644	2019-12-04 15:09:21.045644
1ac60e82-16eb-11ea-8a37-6301d3f2bd73	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab5383c-16eb-11ea-8a37-2f6fb18d68f4	Steady	2019-12-04 15:09:21.053313	2019-12-04 15:09:21.053313
1ac74b76-16eb-11ea-8a37-b79fd5a5f270	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abb62c0-16eb-11ea-8a37-73e479b6d052	Break	2019-12-04 15:09:21.061398	2019-12-04 15:09:21.061398
1ac85c32-16eb-11ea-8a37-d7167b295464	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abf083a-16eb-11ea-8a37-eb5ea8282bad	Steady	2019-12-04 15:09:21.068363	2019-12-04 15:09:21.068363
1ac96bfe-16eb-11ea-8a37-07f490c0e4e8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab5cf86-16eb-11ea-8a37-d7b2ae72d46c	Steady	2019-12-04 15:09:21.075327	2019-12-04 15:09:21.075327
1aca7cba-16eb-11ea-8a37-6b4c03ef7695	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab66978-16eb-11ea-8a37-e70e5f0677b2	Break	2019-12-04 15:09:21.082295	2019-12-04 15:09:21.082295
1acb8844-16eb-11ea-8a37-832b71291b64	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac0556e-16eb-11ea-8a37-9f13df6146f4	Steady	2019-12-04 15:09:21.089104	2019-12-04 15:09:21.089104
1acc5486-16eb-11ea-8a37-bfd1a11d72fe	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab879ca-16eb-11ea-8a37-4b5c8c7c4ce7	Steady	2019-12-04 15:09:21.094392	2019-12-04 15:09:21.094392
1acd1bbe-16eb-11ea-8a37-ab231d3f863c	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abd11b0-16eb-11ea-8a37-b3900bb779f5	Break	2019-12-04 15:09:21.099488	2019-12-04 15:09:21.099488
1acddf5e-16eb-11ea-8a37-e36b6fbf9ca9	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac2c196-16eb-11ea-8a37-131789756456	Break	2019-12-04 15:09:21.104499	2019-12-04 15:09:21.104499
1acea1dc-16eb-11ea-8a37-d3057f80b7f4	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abe7bea-16eb-11ea-8a37-6b4048e5e6b8	Steady	2019-12-04 15:09:21.109422	2019-12-04 15:09:21.109422
1acf66a8-16eb-11ea-8a37-63858e2bb615	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab97c44-16eb-11ea-8a37-877488de2572	Steady	2019-12-04 15:09:21.114497	2019-12-04 15:09:21.114497
1ad021e2-16eb-11ea-8a37-8f48760e9a4d	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac18eb6-16eb-11ea-8a37-ef6a5f262d06	Steady	2019-12-04 15:09:21.119356	2019-12-04 15:09:21.119356
1ad0c2f0-16eb-11ea-8a37-3bb00bd96f20	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aba83c8-16eb-11ea-8a37-2fadaaecb1ac	Steady	2019-12-04 15:09:21.123489	2019-12-04 15:09:21.123489
1ad15b70-16eb-11ea-8a37-83c8c245a1d8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab7743a-16eb-11ea-8a37-0f484f6620ef	Steady	2019-12-04 15:09:21.127421	2019-12-04 15:09:21.127421
1ad25ff2-16eb-11ea-8a37-9b5f36fe6f50	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abfb10e-16eb-11ea-8a37-13aa815f6383	Steady	2019-12-04 15:09:21.134104	2019-12-04 15:09:21.134104
1ad360f0-16eb-11ea-8a37-07094805fab5	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac22808-16eb-11ea-8a37-172fc094430a	Steady	2019-12-04 15:09:21.140692	2019-12-04 15:09:21.140692
1ad45f32-16eb-11ea-8a37-5ff874d314c3	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac0f4c4-16eb-11ea-8a37-f7376e57c359	Steady	2019-12-04 15:09:21.147182	2019-12-04 15:09:21.147182
1ad565f8-16eb-11ea-8a37-83d747266226	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ac3cc76-16eb-11ea-8a37-ebd64d67f749	Steady	2019-12-04 15:09:21.153935	2019-12-04 15:09:21.153935
1ad644c8-16eb-11ea-8a37-d736fe6ad9d8	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1ab4a17e-16eb-11ea-8a37-cba18c0a69d1	Break	2019-12-04 15:09:21.159659	2019-12-04 15:09:21.159659
1ad71f56-16eb-11ea-8a37-43d8029b5928	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1abc41fe-16eb-11ea-8a37-2b7d171858d8	Steady	2019-12-04 15:09:21.165257	2019-12-04 15:09:21.165257
1af339ca-16eb-11ea-8a37-73587320f450	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae76a32-16eb-11ea-8a37-9f138123ab43	Steady	2019-12-04 15:09:21.349369	2019-12-04 15:09:21.349369
1af41142-16eb-11ea-8a37-ab0c30b731d7	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae8772e-16eb-11ea-8a37-43b85affb9d5	Wind	2019-12-04 15:09:21.354897	2019-12-04 15:09:21.354897
1af4eae0-16eb-11ea-8a37-fbed89fbc0ec	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae54d56-16eb-11ea-8a37-1bd034f05dd0	Wind	2019-12-04 15:09:21.360495	2019-12-04 15:09:21.360495
1af5c226-16eb-11ea-8a37-b341faa6a89e	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1af03db0-16eb-11ea-8a37-e783dcce7715	Steady	2019-12-04 15:09:21.365998	2019-12-04 15:09:21.365998
1af69278-16eb-11ea-8a37-db743d41fd7d	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae65980-16eb-11ea-8a37-cb960e3aa413	Break	2019-12-04 15:09:21.371342	2019-12-04 15:09:21.371342
1af72418-16eb-11ea-8a37-2b88d83d8b55	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aeb2172-16eb-11ea-8a37-2fa7dd21be88	Break	2019-12-04 15:09:21.375052	2019-12-04 15:09:21.375052
1af7b1b2-16eb-11ea-8a37-2bda9782b430	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aeea6c6-16eb-11ea-8a37-571d54bd01c0	Break	2019-12-04 15:09:21.378691	2019-12-04 15:09:21.378691
1af83e70-16eb-11ea-8a37-b344a8dc0a80	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aecb55a-16eb-11ea-8a37-b7df151b84a0	Steady	2019-12-04 15:09:21.382275	2019-12-04 15:09:21.382275
1af8ccf0-16eb-11ea-8a37-9b17f672d303	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae4121a-16eb-11ea-8a37-f3a6153ac0ca	Steady	2019-12-04 15:09:21.385939	2019-12-04 15:09:21.385939
1af95526-16eb-11ea-8a37-5f7ebb8b0490	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aea5936-16eb-11ea-8a37-af3b59c88e86	Fire	2019-12-04 15:09:21.389441	2019-12-04 15:09:21.389441
1af9db36-16eb-11ea-8a37-b3b9e63ad1b1	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae65980-16eb-11ea-8a37-cb960e3aa413	Water	2019-12-04 15:09:21.392865	2019-12-04 15:09:21.392865
1afa6286-16eb-11ea-8a37-93e49391b478	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aef3dac-16eb-11ea-8a37-2371d7ca823f	Steady	2019-12-04 15:09:21.396322	2019-12-04 15:09:21.396322
1afae8e6-16eb-11ea-8a37-3b79272b02eb	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae98e16-16eb-11ea-8a37-3b733ba500bb	Steady	2019-12-04 15:09:21.399778	2019-12-04 15:09:21.399778
1afbe2fa-16eb-11ea-8a37-7b1b1f0df298	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae4121a-16eb-11ea-8a37-f3a6153ac0ca	Fire	2019-12-04 15:09:21.406162	2019-12-04 15:09:21.406162
1afce42a-16eb-11ea-8a37-97c0b0e1447e	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aeb2172-16eb-11ea-8a37-2fa7dd21be88	Water	2019-12-04 15:09:21.412742	2019-12-04 15:09:21.412742
1afde0fa-16eb-11ea-8a37-4fd1704f1bda	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1af23ce6-16eb-11ea-8a37-2732c0f2021c	Steady	2019-12-04 15:09:21.419216	2019-12-04 15:09:21.419216
1afee41e-16eb-11ea-8a37-8b1afd3ee68d	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1af14084-16eb-11ea-8a37-7bb8fed32c0b	Steady	2019-12-04 15:09:21.425842	2019-12-04 15:09:21.425842
1affbcea-16eb-11ea-8a37-efcf09f9d5f7	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aea5936-16eb-11ea-8a37-af3b59c88e86	Steady	2019-12-04 15:09:21.431398	2019-12-04 15:09:21.431398
1b009b6a-16eb-11ea-8a37-c77f2b9dd78b	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aee0f2c-16eb-11ea-8a37-ffed1cbdf8b0	Steady	2019-12-04 15:09:21.437099	2019-12-04 15:09:21.437099
1b016fcc-16eb-11ea-8a37-4fe539e2607f	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae8772e-16eb-11ea-8a37-43b85affb9d5	Break	2019-12-04 15:09:21.442519	2019-12-04 15:09:21.442519
1b024262-16eb-11ea-8a37-cbedfb9dc1df	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aed70da-16eb-11ea-8a37-abcf95acf1bd	Break	2019-12-04 15:09:21.447931	2019-12-04 15:09:21.447931
1b02d1fa-16eb-11ea-8a37-e3e3aac43104	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ae54d56-16eb-11ea-8a37-1bd034f05dd0	Break	2019-12-04 15:09:21.451616	2019-12-04 15:09:21.451616
1b035e9a-16eb-11ea-8a37-2739c40ea056	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aed70da-16eb-11ea-8a37-abcf95acf1bd	Fire	2019-12-04 15:09:21.455225	2019-12-04 15:09:21.455225
1b03ed6a-16eb-11ea-8a37-2bed51964a3e	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1aebea3a-16eb-11ea-8a37-8b62a5fc3883	Steady	2019-12-04 15:09:21.458852	2019-12-04 15:09:21.458852
1b305ed6-16eb-11ea-8a37-4378c9da3821	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2c8766-16eb-11ea-8a37-13d96e69c7a8	Steady	2019-12-04 15:09:21.750018	2019-12-04 15:09:21.750018
1b311d80-16eb-11ea-8a37-1b0e88d9da1f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2156ac-16eb-11ea-8a37-3faf90dc6d39	Large	2019-12-04 15:09:21.754893	2019-12-04 15:09:21.754893
1b31db3a-16eb-11ea-8a37-17231bd64c6a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b22caaa-16eb-11ea-8a37-f39553a62b23	Large	2019-12-04 15:09:21.759766	2019-12-04 15:09:21.759766
1b329598-16eb-11ea-8a37-6b85cc2beb6a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b221204-16eb-11ea-8a37-530ba2e2d980	Steady	2019-12-04 15:09:21.764537	2019-12-04 15:09:21.764537
1b33c33c-16eb-11ea-8a37-ab6c36bead02	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1d7776-16eb-11ea-8a37-13478f906f6c	Small	2019-12-04 15:09:21.772241	2019-12-04 15:09:21.772241
1b34f428-16eb-11ea-8a37-673ecb1e2bd4	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1c6e3a-16eb-11ea-8a37-67c4c11f2f21	Large	2019-12-04 15:09:21.780043	2019-12-04 15:09:21.780043
1b36215e-16eb-11ea-8a37-77ee1be2951f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b295b5e-16eb-11ea-8a37-6bd0701685f2	Break	2019-12-04 15:09:21.787766	2019-12-04 15:09:21.787766
1b374da4-16eb-11ea-8a37-176293b5d525	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b284e44-16eb-11ea-8a37-0bd9b1761ced	Break	2019-12-04 15:09:21.795462	2019-12-04 15:09:21.795462
1b385b90-16eb-11ea-8a37-3f129a04f33e	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2387c4-16eb-11ea-8a37-2f69b75d28bd	Steady	2019-12-04 15:09:21.802364	2019-12-04 15:09:21.802364
1b3968d2-16eb-11ea-8a37-438169721665	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2b7eca-16eb-11ea-8a37-23879aa3fc84	Small	2019-12-04 15:09:21.809263	2019-12-04 15:09:21.809263
1b3a763c-16eb-11ea-8a37-7ffc2021b516	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2f9f3c-16eb-11ea-8a37-b3eee5e721d5	Break	2019-12-04 15:09:21.8161	2019-12-04 15:09:21.8161
1b3b7ece-16eb-11ea-8a37-83877744897b	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1f0104-16eb-11ea-8a37-47b05b789873	Break	2019-12-04 15:09:21.822933	2019-12-04 15:09:21.822933
1b3c4778-16eb-11ea-8a37-af54bfca6f99	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b209834-16eb-11ea-8a37-9bed6958be5e	Steady	2019-12-04 15:09:21.828071	2019-12-04 15:09:21.828071
1b3d0ef6-16eb-11ea-8a37-b3fb969b354f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1e3a6c-16eb-11ea-8a37-fbfc0dce8abc	Steady	2019-12-04 15:09:21.833163	2019-12-04 15:09:21.833163
1b3dd7d2-16eb-11ea-8a37-f343732eb9b8	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2156ac-16eb-11ea-8a37-3faf90dc6d39	Break	2019-12-04 15:09:21.838315	2019-12-04 15:09:21.838315
1b3e9460-16eb-11ea-8a37-7f96dba7c9d3	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1d7776-16eb-11ea-8a37-13478f906f6c	Break	2019-12-04 15:09:21.843145	2019-12-04 15:09:21.843145
1b3f4bb2-16eb-11ea-8a37-dbdb409d4ccb	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1c6e3a-16eb-11ea-8a37-67c4c11f2f21	Break	2019-12-04 15:09:21.847833	2019-12-04 15:09:21.847833
1b4006a6-16eb-11ea-8a37-b75acdad7f27	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b22caaa-16eb-11ea-8a37-f39553a62b23	Break	2019-12-04 15:09:21.852623	2019-12-04 15:09:21.852623
1b40bbd2-16eb-11ea-8a37-8b7512c8559c	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2d4f66-16eb-11ea-8a37-67dc41e717ef	Break	2019-12-04 15:09:21.857265	2019-12-04 15:09:21.857265
1b417bb2-16eb-11ea-8a37-5792203f7d2a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b295b5e-16eb-11ea-8a37-6bd0701685f2	Large	2019-12-04 15:09:21.862176	2019-12-04 15:09:21.862176
1b42a730-16eb-11ea-8a37-ef688d88434b	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1fc558-16eb-11ea-8a37-570413a4514a	Steady	2019-12-04 15:09:21.869839	2019-12-04 15:09:21.869839
1b43d614-16eb-11ea-8a37-f398bcaad318	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2d4f66-16eb-11ea-8a37-67dc41e717ef	Small	2019-12-04 15:09:21.877543	2019-12-04 15:09:21.877543
1b450318-16eb-11ea-8a37-67fa66ecf7c1	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b24b73e-16eb-11ea-8a37-9ff8d8f64eeb	Small	2019-12-04 15:09:21.885297	2019-12-04 15:09:21.885297
1b4631ac-16eb-11ea-8a37-cf0ec45b240a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b25ec8a-16eb-11ea-8a37-ab66344820c8	Steady	2019-12-04 15:09:21.893048	2019-12-04 15:09:21.893048
1b4738ea-16eb-11ea-8a37-f70fa74ae33f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2eda84-16eb-11ea-8a37-f7d6e881492c	Steady	2019-12-04 15:09:21.899786	2019-12-04 15:09:21.899786
1b4843fc-16eb-11ea-8a37-6bb77aa20c59	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2a6ef4-16eb-11ea-8a37-e7bc2323267c	Large	2019-12-04 15:09:21.906622	2019-12-04 15:09:21.906622
1b4947a2-16eb-11ea-8a37-eff4829e6b93	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1a49e8-16eb-11ea-8a37-277d3ef68f63	Steady	2019-12-04 15:09:21.913265	2019-12-04 15:09:21.913265
1b4a4ddc-16eb-11ea-8a37-8f3297bc4e7b	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b284e44-16eb-11ea-8a37-0bd9b1761ced	Small	2019-12-04 15:09:21.919963	2019-12-04 15:09:21.919963
1b4b0ad8-16eb-11ea-8a37-cf61c4bc3209	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2e1626-16eb-11ea-8a37-b31f781e9321	Break	2019-12-04 15:09:21.924809	2019-12-04 15:09:21.924809
1b4bc8c4-16eb-11ea-8a37-03f1d5fb488a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2a6ef4-16eb-11ea-8a37-e7bc2323267c	Break	2019-12-04 15:09:21.929642	2019-12-04 15:09:21.929642
1b4c8624-16eb-11ea-8a37-7ff3b4389e87	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1f0104-16eb-11ea-8a37-47b05b789873	Small	2019-12-04 15:09:21.934522	2019-12-04 15:09:21.934522
1b4d40b4-16eb-11ea-8a37-b7f2f57512f4	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b24b73e-16eb-11ea-8a37-9ff8d8f64eeb	Break	2019-12-04 15:09:21.939298	2019-12-04 15:09:21.939298
1b4dfbda-16eb-11ea-8a37-cb9f222af669	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b180f70-16eb-11ea-8a37-7be1c9e32339	Steady	2019-12-04 15:09:21.944091	2019-12-04 15:09:21.944091
1b4eb804-16eb-11ea-8a37-8f511bdf2432	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b1b6260-16eb-11ea-8a37-f320c0145642	Steady	2019-12-04 15:09:21.948896	2019-12-04 15:09:21.948896
1b4f717c-16eb-11ea-8a37-5724d61efc2f	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b271e16-16eb-11ea-8a37-6b836026a1ff	Break	2019-12-04 15:09:21.953578	2019-12-04 15:09:21.953578
1b502e5a-16eb-11ea-8a37-97eed6f4e577	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b194016-16eb-11ea-8a37-9b43115c8fa3	Steady	2019-12-04 15:09:21.95849	2019-12-04 15:09:21.95849
1b5158f2-16eb-11ea-8a37-27fe0791f72e	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2f9f3c-16eb-11ea-8a37-b3eee5e721d5	Small	2019-12-04 15:09:21.966133	2019-12-04 15:09:21.966133
1b529276-16eb-11ea-8a37-f7f28ea1ea95	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2b7eca-16eb-11ea-8a37-23879aa3fc84	Break	2019-12-04 15:09:21.974153	2019-12-04 15:09:21.974153
1b53d0fa-16eb-11ea-8a37-9325ae176c26	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b2e1626-16eb-11ea-8a37-b31f781e9321	Small	2019-12-04 15:09:21.982288	2019-12-04 15:09:21.982288
1b5501f0-16eb-11ea-8a37-a73674fe2891	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b271e16-16eb-11ea-8a37-6b836026a1ff	Large	2019-12-04 15:09:21.990103	2019-12-04 15:09:21.990103
1b726dda-16eb-11ea-8a37-870796fd03f9	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b713b54-16eb-11ea-8a37-23611c020dbc	Break	2019-12-04 15:09:22.182932	2019-12-04 15:09:22.182932
1b739c32-16eb-11ea-8a37-1f7802692564	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6ede0e-16eb-11ea-8a37-ef292e9ed97e	Steady	2019-12-04 15:09:22.190679	2019-12-04 15:09:22.190679
1b74a262-16eb-11ea-8a37-570b252808db	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6bcf70-16eb-11ea-8a37-efd8e77bf6b2	Steady	2019-12-04 15:09:22.197401	2019-12-04 15:09:22.197401
1b75b1f2-16eb-11ea-8a37-03308bc39531	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6d539a-16eb-11ea-8a37-03e22bf46941	Steady	2019-12-04 15:09:22.204339	2019-12-04 15:09:22.204339
1b76b89a-16eb-11ea-8a37-934ed3b7b5d1	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b669866-16eb-11ea-8a37-0b28f94f73f6	Steady	2019-12-04 15:09:22.211068	2019-12-04 15:09:22.211068
1b77c4d8-16eb-11ea-8a37-33187768d02e	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6b0da6-16eb-11ea-8a37-2b0abc4000f0	Steady	2019-12-04 15:09:22.217933	2019-12-04 15:09:22.217933
1b788ac6-16eb-11ea-8a37-bf77a459f414	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b67ad8c-16eb-11ea-8a37-234f34b92f8c	Steady	2019-12-04 15:09:22.223009	2019-12-04 15:09:22.223009
1b794f88-16eb-11ea-8a37-8b8bec232e03	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b68bae2-16eb-11ea-8a37-4b3627e3f173	Break	2019-12-04 15:09:22.228041	2019-12-04 15:09:22.228041
1b7a0ea0-16eb-11ea-8a37-83850fc818cd	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6c8b2c-16eb-11ea-8a37-7f1dea456dc0	Steady	2019-12-04 15:09:22.232888	2019-12-04 15:09:22.232888
1b7ad0c4-16eb-11ea-8a37-bf015fdd7707	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6a429a-16eb-11ea-8a37-f3d903a7117e	Break	2019-12-04 15:09:22.237902	2019-12-04 15:09:22.237902
1b7b9216-16eb-11ea-8a37-4b4d6d8ad0ca	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b700a9a-16eb-11ea-8a37-dfd186cf9700	Steady	2019-12-04 15:09:22.24285	2019-12-04 15:09:22.24285
1b7c53c2-16eb-11ea-8a37-6777b14133d8	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b6e13ca-16eb-11ea-8a37-7f12da28d2f6	Steady	2019-12-04 15:09:22.247807	2019-12-04 15:09:22.247807
1b7d0e52-16eb-11ea-8a37-dbed3a9a7b38	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b697f0e-16eb-11ea-8a37-dfcc7953d535	Steady	2019-12-04 15:09:22.252588	2019-12-04 15:09:22.252588
1b9b5f10-16eb-11ea-8a37-c3655ed46322	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8e4a46-16eb-11ea-8a37-4305e51f5978	Steady	2019-12-04 15:09:22.45126	2019-12-04 15:09:22.45126
1b9c19c8-16eb-11ea-8a37-77bfacc30eb3	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b986350-16eb-11ea-8a37-8bae19646e05	Steady	2019-12-04 15:09:22.456045	2019-12-04 15:09:22.456045
1b9d43e8-16eb-11ea-8a37-bb6c48fa57ce	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8d1982-16eb-11ea-8a37-eb17e8c64fb0	Break	2019-12-04 15:09:22.463679	2019-12-04 15:09:22.463679
1b9e70c4-16eb-11ea-8a37-fb4ae49f3445	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b9613c0-16eb-11ea-8a37-2b04bb9ef5da	Steady	2019-12-04 15:09:22.471368	2019-12-04 15:09:22.471368
1b9f9efe-16eb-11ea-8a37-c732d48cecd2	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b94054e-16eb-11ea-8a37-c7ef24b8319b	Steady	2019-12-04 15:09:22.479105	2019-12-04 15:09:22.479105
1ba0ce50-16eb-11ea-8a37-9bacab651f80	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b9aa372-16eb-11ea-8a37-4fcf2ae20b65	Steady	2019-12-04 15:09:22.486873	2019-12-04 15:09:22.486873
1ba1e268-16eb-11ea-8a37-5736a33871f1	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b99e41e-16eb-11ea-8a37-87cf8123e56d	Break	2019-12-04 15:09:22.493948	2019-12-04 15:09:22.493948
1ba2f6f8-16eb-11ea-8a37-438c46f8dc25	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b97a172-16eb-11ea-8a37-bf47014d47bd	Steady	2019-12-04 15:09:22.501016	2019-12-04 15:09:22.501016
1ba3fc92-16eb-11ea-8a37-8f252b57e5e2	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b950a84-16eb-11ea-8a37-57cb6bc2d8df	Break	2019-12-04 15:09:22.507723	2019-12-04 15:09:22.507723
1ba503b2-16eb-11ea-8a37-4b7ea02158e7	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b96dad0-16eb-11ea-8a37-6f699d13238b	Steady	2019-12-04 15:09:22.514453	2019-12-04 15:09:22.514453
1ba5c720-16eb-11ea-8a37-eb964fec577f	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b91e250-16eb-11ea-8a37-1b0e9e0e5b1d	Steady	2019-12-04 15:09:22.519459	2019-12-04 15:09:22.519459
1ba68606-16eb-11ea-8a37-e7e39346ebea	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b90aee4-16eb-11ea-8a37-bf606cc2e348	Steady	2019-12-04 15:09:22.524355	2019-12-04 15:09:22.524355
1ba7460e-16eb-11ea-8a37-bfa05f3c09a2	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b992240-16eb-11ea-8a37-e3d8bc29dc70	Steady	2019-12-04 15:09:22.529244	2019-12-04 15:09:22.529244
1ba80f26-16eb-11ea-8a37-8303d94a6c08	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8f7c9a-16eb-11ea-8a37-ef293079a7ae	Break	2019-12-04 15:09:22.534394	2019-12-04 15:09:22.534394
1ba8cb28-16eb-11ea-8a37-ebf23ddb1656	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b92f460-16eb-11ea-8a37-ab292dbc563f	Steady	2019-12-04 15:09:22.539231	2019-12-04 15:09:22.539231
1bca5496-16eb-11ea-8a37-177c4f155339	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc85038-16eb-11ea-8a37-3fa61e5eeda7	Steady	2019-12-04 15:09:22.759105	2019-12-04 15:09:22.759105
1bcb5468-16eb-11ea-8a37-ef7f8a587371	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc1bf0c-16eb-11ea-8a37-6bdea743bc38	Steady	2019-12-04 15:09:22.765641	2019-12-04 15:09:22.765641
1bcc53c2-16eb-11ea-8a37-bfd62b48ce8a	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc45d48-16eb-11ea-8a37-bb06e7ad65e9	Steady	2019-12-04 15:09:22.772195	2019-12-04 15:09:22.772195
1bcd2e14-16eb-11ea-8a37-a3fd4760c250	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc6220e-16eb-11ea-8a37-cf0e0d8a44de	Steady	2019-12-04 15:09:22.777777	2019-12-04 15:09:22.777777
1bce13d8-16eb-11ea-8a37-23cb24cc6618	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc590a0-16eb-11ea-8a37-4f25cffc2324	Break	2019-12-04 15:09:22.783649	2019-12-04 15:09:22.783649
1bcee83a-16eb-11ea-8a37-2f31e5a12d6a	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc739fa-16eb-11ea-8a37-9f28c16bc732	Steady	2019-12-04 15:09:22.789086	2019-12-04 15:09:22.789086
1bcfb76a-16eb-11ea-8a37-7f99e9a19681	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc7c46a-16eb-11ea-8a37-8b1e3f19a48e	Steady	2019-12-04 15:09:22.794416	2019-12-04 15:09:22.794416
1bd048a6-16eb-11ea-8a37-cf70c03a78aa	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc3b172-16eb-11ea-8a37-279aebbea38c	Steady	2019-12-04 15:09:22.79813	2019-12-04 15:09:22.79813
1bd0d866-16eb-11ea-8a37-cfc0d0a8468f	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc4fb86-16eb-11ea-8a37-5bee4810c1c4	Steady	2019-12-04 15:09:22.801802	2019-12-04 15:09:22.801802
1bd16394-16eb-11ea-8a37-0beff64cda8d	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc0a4fa-16eb-11ea-8a37-b3534cffdb6e	Steady	2019-12-04 15:09:22.805378	2019-12-04 15:09:22.805378
1bd1efda-16eb-11ea-8a37-8bc7b55766a4	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc2c1b8-16eb-11ea-8a37-f318ca5494b8	Break	2019-12-04 15:09:22.808958	2019-12-04 15:09:22.808958
1bd27a36-16eb-11ea-8a37-031808233f27	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc9528a-16eb-11ea-8a37-ef88cfa10450	Steady	2019-12-04 15:09:22.812494	2019-12-04 15:09:22.812494
1bd3008c-16eb-11ea-8a37-3f8e67223036	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bbf9150-16eb-11ea-8a37-efe4af66dd94	Steady	2019-12-04 15:09:22.815942	2019-12-04 15:09:22.815942
1bd38796-16eb-11ea-8a37-c7a25c8a3c94	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bc6b2f0-16eb-11ea-8a37-1f3a5f6cd81c	Steady	2019-12-04 15:09:22.819385	2019-12-04 15:09:22.819385
1bd413c8-16eb-11ea-8a37-cbd7cfeb16cc	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bbe53c6-16eb-11ea-8a37-17c37f6e1da7	Break	2019-12-04 15:09:22.822989	2019-12-04 15:09:22.822989
1bf88460-16eb-11ea-8a37-cff5b30c5482	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf00aba-16eb-11ea-8a37-7b1e16e3dcf3	Steady	2019-12-04 15:09:23.061659	2019-12-04 15:09:23.061659
1bf9429c-16eb-11ea-8a37-7b725f6381d3	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf35c4c-16eb-11ea-8a37-0b32f580f704	Break	2019-12-04 15:09:23.066571	2019-12-04 15:09:23.066571
1bfa0290-16eb-11ea-8a37-b397548dd6b7	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf13cdc-16eb-11ea-8a37-4b0266806625	Steady	2019-12-04 15:09:23.071461	2019-12-04 15:09:23.071461
1bfabdac-16eb-11ea-8a37-1f9f8cab5bdc	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf4642a-16eb-11ea-8a37-2b3ce7f84ad3	Break	2019-12-04 15:09:23.076251	2019-12-04 15:09:23.076251
1bfb7fee-16eb-11ea-8a37-67b92e57ca6e	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf574a0-16eb-11ea-8a37-a7f01f63238f	Steady	2019-12-04 15:09:23.081229	2019-12-04 15:09:23.081229
1bfcb7d8-16eb-11ea-8a37-1ba430d4a225	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1beed258-16eb-11ea-8a37-037517d7ae94	Steady	2019-12-04 15:09:23.089209	2019-12-04 15:09:23.089209
1bfdf288-16eb-11ea-8a37-b7ec224c458f	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1beaed1e-16eb-11ea-8a37-0f281acc942a	Steady	2019-12-04 15:09:23.097271	2019-12-04 15:09:23.097271
1bff27ac-16eb-11ea-8a37-b76954c58703	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf7c520-16eb-11ea-8a37-db7109418137	Steady	2019-12-04 15:09:23.10518	2019-12-04 15:09:23.10518
1c005992-16eb-11ea-8a37-07f448f35e32	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf63e26-16eb-11ea-8a37-e3a18631f37e	Steady	2019-12-04 15:09:23.112991	2019-12-04 15:09:23.112991
1c016bde-16eb-11ea-8a37-e3c8381e364d	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bebab96-16eb-11ea-8a37-739e66a07c40	Break	2019-12-04 15:09:23.120014	2019-12-04 15:09:23.120014
1c027a88-16eb-11ea-8a37-ef6d6f193744	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf24cd0-16eb-11ea-8a37-b3d435ffcb8a	Steady	2019-12-04 15:09:23.126963	2019-12-04 15:09:23.126963
1c038856-16eb-11ea-8a37-5743fa40cad5	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bed9ce4-16eb-11ea-8a37-9700b27e012d	Steady	2019-12-04 15:09:23.133855	2019-12-04 15:09:23.133855
1c049a52-16eb-11ea-8a37-577cb2d32a7d	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bf70252-16eb-11ea-8a37-67e17e865f28	Steady	2019-12-04 15:09:23.140894	2019-12-04 15:09:23.140894
1c055dde-16eb-11ea-8a37-2f8e8d25befa	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bea390a-16eb-11ea-8a37-bf58147c033b	Steady	2019-12-04 15:09:23.145899	2019-12-04 15:09:23.145899
1c062534-16eb-11ea-8a37-a704e69afaf5	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bec6c3e-16eb-11ea-8a37-5ba2fd3fcba1	Steady	2019-12-04 15:09:23.150984	2019-12-04 15:09:23.150984
1c06e348-16eb-11ea-8a37-f31f39839679	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1be9ab66-16eb-11ea-8a37-67a36cf5e259	Steady	2019-12-04 15:09:23.155856	2019-12-04 15:09:23.155856
1c2f8316-16eb-11ea-8a37-432f51b0a9f3	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c2e707a-16eb-11ea-8a37-df3839ca895d	Steady	2019-12-04 15:09:23.422089	2019-12-04 15:09:23.422089
1c308662-16eb-11ea-8a37-f758e857b00a	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c270cc2-16eb-11ea-8a37-97f129852503	Steady	2019-12-04 15:09:23.428736	2019-12-04 15:09:23.428736
1c318364-16eb-11ea-8a37-17e73a2f36a0	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c1fa536-16eb-11ea-8a37-a3be8d636d43	Steady	2019-12-04 15:09:23.435219	2019-12-04 15:09:23.435219
1c3241aa-16eb-11ea-8a37-cbdfe903edf7	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c1d8800-16eb-11ea-8a37-5b34a86d6094	Steady	2019-12-04 15:09:23.440086	2019-12-04 15:09:23.440086
1c330568-16eb-11ea-8a37-37aac16fb03d	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c2175a0-16eb-11ea-8a37-97eff6662125	Break	2019-12-04 15:09:23.445074	2019-12-04 15:09:23.445074
1c33d2d6-16eb-11ea-8a37-67bcbdaa7fee	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c1eaec4-16eb-11ea-8a37-2399e1617176	Steady	2019-12-04 15:09:23.450357	2019-12-04 15:09:23.450357
1c348cf8-16eb-11ea-8a37-db610dbcdd6d	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c288d36-16eb-11ea-8a37-5b075c66afb4	Steady	2019-12-04 15:09:23.455133	2019-12-04 15:09:23.455133
1c3543d2-16eb-11ea-8a37-8338f37ca928	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c23ff6e-16eb-11ea-8a37-d7ae50344926	Break	2019-12-04 15:09:23.459811	2019-12-04 15:09:23.459811
1c35fdcc-16eb-11ea-8a37-1f8eafd58d20	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c258ece-16eb-11ea-8a37-9bf5aef9d0c3	Steady	2019-12-04 15:09:23.464571	2019-12-04 15:09:23.464571
1c36b866-16eb-11ea-8a37-fb415da61163	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c209202-16eb-11ea-8a37-a3ae4ec4decb	Break	2019-12-04 15:09:23.469342	2019-12-04 15:09:23.469342
1c3787c8-16eb-11ea-8a37-4ff06f68d27a	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c2c30bc-16eb-11ea-8a37-c37c68a937e9	Steady	2019-12-04 15:09:23.474619	2019-12-04 15:09:23.474619
1c38bc1a-16eb-11ea-8a37-bfb41868718a	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c2d6270-16eb-11ea-8a37-e37f1e7829d0	Steady	2019-12-04 15:09:23.482533	2019-12-04 15:09:23.482533
1c39f3f0-16eb-11ea-8a37-777d7c39bfe2	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c264fda-16eb-11ea-8a37-2babd531541f	Steady	2019-12-04 15:09:23.490521	2019-12-04 15:09:23.490521
1c3b2464-16eb-11ea-8a37-af3d6f8b65ab	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c29bf80-16eb-11ea-8a37-e3c9a08d38f7	Steady	2019-12-04 15:09:23.498334	2019-12-04 15:09:23.498334
1c3fa0b6-16eb-11ea-8a37-63a76322e2a1	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c27cf36-16eb-11ea-8a37-731e59b275ee	Steady	2019-12-04 15:09:23.527672	2019-12-04 15:09:23.527672
1c40b3b6-16eb-11ea-8a37-e3bd132c0296	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c233462-16eb-11ea-8a37-af67f85743f8	Steady	2019-12-04 15:09:23.534766	2019-12-04 15:09:23.534766
1c41c0d0-16eb-11ea-8a37-cf28577e2a3c	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c1c564c-16eb-11ea-8a37-c39aca9b8a32	Steady	2019-12-04 15:09:23.541661	2019-12-04 15:09:23.541661
1c42cd0e-16eb-11ea-8a37-6b73743d8e70	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c2af5da-16eb-11ea-8a37-dbc0bfa84a54	Steady	2019-12-04 15:09:23.548516	2019-12-04 15:09:23.548516
1c43d5e6-16eb-11ea-8a37-9300c2ca0d05	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c24c4ee-16eb-11ea-8a37-a3f98b7073f2	Steady	2019-12-04 15:09:23.5553	2019-12-04 15:09:23.5553
1c449706-16eb-11ea-8a37-37b331263146	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c19eb28-16eb-11ea-8a37-7b6bd001ec0a	Steady	2019-12-04 15:09:23.56026	2019-12-04 15:09:23.56026
1c45556a-16eb-11ea-8a37-33e8024a3ac3	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c1b2024-16eb-11ea-8a37-774a6944f301	Steady	2019-12-04 15:09:23.565133	2019-12-04 15:09:23.565133
1c461c5c-16eb-11ea-8a37-472e7d1a2aee	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c227022-16eb-11ea-8a37-6ba3b97b78cc	Steady	2019-12-04 15:09:23.57022	2019-12-04 15:09:23.57022
1c788282-16eb-11ea-8a37-7bdb749b7428	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c68c482-16eb-11ea-8a37-27f41ffb3882	Steady	2019-12-04 15:09:23.900611	2019-12-04 15:09:23.900611
1c7959f0-16eb-11ea-8a37-c3f8b54952d7	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c5fb2e8-16eb-11ea-8a37-07b6c5b4fc8b	Steady	2019-12-04 15:09:23.906154	2019-12-04 15:09:23.906154
1c7a2e52-16eb-11ea-8a37-9b3225f1a3e3	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c679ada-16eb-11ea-8a37-138817ff7047	Steady	2019-12-04 15:09:23.911581	2019-12-04 15:09:23.911581
1c7abdf4-16eb-11ea-8a37-538d3aed05b6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6e49fc-16eb-11ea-8a37-63d776ac9ad6	Steady	2019-12-04 15:09:23.915258	2019-12-04 15:09:23.915258
1c7b4f4e-16eb-11ea-8a37-03e82c807123	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c60775a-16eb-11ea-8a37-fba5ccdbc3f6	Break	2019-12-04 15:09:23.918985	2019-12-04 15:09:23.918985
1c7be008-16eb-11ea-8a37-671b15713f6c	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c70c628-16eb-11ea-8a37-93be9f9bb708	Steady	2019-12-04 15:09:23.922702	2019-12-04 15:09:23.922702
1c7c6474-16eb-11ea-8a37-e34fd24184fb	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6efd8e-16eb-11ea-8a37-43d72317cc71	Break	2019-12-04 15:09:23.926082	2019-12-04 15:09:23.926082
1c7ce250-16eb-11ea-8a37-e7529dd92ff1	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c715192-16eb-11ea-8a37-cfead091eff5	Break	2019-12-04 15:09:23.929314	2019-12-04 15:09:23.929314
1c7d5ff0-16eb-11ea-8a37-bfc89e8f3730	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c75ceac-16eb-11ea-8a37-6b3a79a95c2f	Steady	2019-12-04 15:09:23.932505	2019-12-04 15:09:23.932505
1c7e075c-16eb-11ea-8a37-9f13f0b0f111	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c61fd5a-16eb-11ea-8a37-873826264779	Steady	2019-12-04 15:09:23.936688	2019-12-04 15:09:23.936688
1c7ec7b4-16eb-11ea-8a37-cb21ff924f22	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c666908-16eb-11ea-8a37-c719c60e982f	Break	2019-12-04 15:09:23.941518	2019-12-04 15:09:23.941518
1c7ff7ec-16eb-11ea-8a37-db67f56a332b	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c72e4da-16eb-11ea-8a37-d76ea3f5ec03	Steady	2019-12-04 15:09:23.949345	2019-12-04 15:09:23.949345
1c812e14-16eb-11ea-8a37-875f4472b899	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6f9c26-16eb-11ea-8a37-9348495fb664	Break	2019-12-04 15:09:23.957314	2019-12-04 15:09:23.957314
1c825d7a-16eb-11ea-8a37-77d0f81dc5b8	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c7260aa-16eb-11ea-8a37-23f13576609b	Break	2019-12-04 15:09:23.96509	2019-12-04 15:09:23.96509
1c8389de-16eb-11ea-8a37-db1e87b91e06	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6c26b8-16eb-11ea-8a37-3bef69bfe42f	Steady	2019-12-04 15:09:23.972771	2019-12-04 15:09:23.972771
1c84969e-16eb-11ea-8a37-bf83bf107bcd	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c74d696-16eb-11ea-8a37-f33d7f614d0d	Break	2019-12-04 15:09:23.97966	2019-12-04 15:09:23.97966
1c85a5a2-16eb-11ea-8a37-ab3c43f87376	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c71dd2e-16eb-11ea-8a37-172f4134edf4	Steady	2019-12-04 15:09:23.986597	2019-12-04 15:09:23.986597
1c86af2e-16eb-11ea-8a37-475a36e6e8c8	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c73db6a-16eb-11ea-8a37-b3c941225317	Steady	2019-12-04 15:09:23.993393	2019-12-04 15:09:23.993393
1c87bc48-16eb-11ea-8a37-ab7642893ea9	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c76c852-16eb-11ea-8a37-b733d4a48ec1	Steady	2019-12-04 15:09:24.000279	2019-12-04 15:09:24.000279
1c888100-16eb-11ea-8a37-db47165461f0	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c613b86-16eb-11ea-8a37-d3655b4669e2	Steady	2019-12-04 15:09:24.005296	2019-12-04 15:09:24.005296
1c894d24-16eb-11ea-8a37-6b88f4a992d9	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c643a8e-16eb-11ea-8a37-db96e4d95b94	Steady	2019-12-04 15:09:24.01056	2019-12-04 15:09:24.01056
1c8a1308-16eb-11ea-8a37-e7b7eb61a4fa	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c64f96a-16eb-11ea-8a37-2fe6eb1327d6	Steady	2019-12-04 15:09:24.015571	2019-12-04 15:09:24.015571
1c8ad7ac-16eb-11ea-8a37-db7dd37fb746	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c69efb0-16eb-11ea-8a37-3be96fb27388	Steady	2019-12-04 15:09:24.020625	2019-12-04 15:09:24.020625
1c8b8e22-16eb-11ea-8a37-ef3c6f15d3c9	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6d3be8-16eb-11ea-8a37-7f52584fdc08	Break	2019-12-04 15:09:24.025324	2019-12-04 15:09:24.025324
1c8c4ce0-16eb-11ea-8a37-7fd1c257ecb0	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c6b0f76-16eb-11ea-8a37-3b08fa2d3df7	Steady	2019-12-04 15:09:24.030202	2019-12-04 15:09:24.030202
1c8d0748-16eb-11ea-8a37-23ec9d824c14	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c637b44-16eb-11ea-8a37-033ff1235648	Steady	2019-12-04 15:09:24.034983	2019-12-04 15:09:24.034983
1c8dc728-16eb-11ea-8a37-5b4358631743	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c62bec0-16eb-11ea-8a37-878604a624fa	Steady	2019-12-04 15:09:24.039872	2019-12-04 15:09:24.039872
1c8ef436-16eb-11ea-8a37-abaab5e04be8	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c77a4fc-16eb-11ea-8a37-0728354f3a0a	Steady	2019-12-04 15:09:24.047557	2019-12-04 15:09:24.047557
1c902522-16eb-11ea-8a37-c74070394f8e	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c703514-16eb-11ea-8a37-6fe980d06cfa	Break	2019-12-04 15:09:24.055383	2019-12-04 15:09:24.055383
1caf7058-16eb-11ea-8a37-53bef83a22b5	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca2388e-16eb-11ea-8a37-9b27765824d2	Steady	2019-12-04 15:09:24.2606	2019-12-04 15:09:24.2606
1cb03fe2-16eb-11ea-8a37-93d52d2c0089	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca05dd4-16eb-11ea-8a37-5bec5493f9e4	Steady	2019-12-04 15:09:24.265931	2019-12-04 15:09:24.265931
1cb0c962-16eb-11ea-8a37-7b103ac0718b	1c9163a6-16eb-11ea-8a37-f39bdf338693	1cace9aa-16eb-11ea-8a37-1fcc8d6fbfa5	Break	2019-12-04 15:09:24.269419	2019-12-04 15:09:24.269419
1cb1562a-16eb-11ea-8a37-970ebea591de	1c9163a6-16eb-11ea-8a37-f39bdf338693	1cae9ea8-16eb-11ea-8a37-0f92c816e239	Steady	2019-12-04 15:09:24.273038	2019-12-04 15:09:24.273038
1cb1dd66-16eb-11ea-8a37-bbf7d0e65efa	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca3ee4a-16eb-11ea-8a37-1f1348543f6b	Steady	2019-12-04 15:09:24.276518	2019-12-04 15:09:24.276518
1cb26498-16eb-11ea-8a37-87f51aae0456	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca9ffa6-16eb-11ea-8a37-abcfeed563b5	Steady	2019-12-04 15:09:24.279967	2019-12-04 15:09:24.279967
1cb2e5ee-16eb-11ea-8a37-9bbd25df095e	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca665a8-16eb-11ea-8a37-97338587a2e9	Steady	2019-12-04 15:09:24.283288	2019-12-04 15:09:24.283288
1cb363f2-16eb-11ea-8a37-77f70cba5b0a	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca77466-16eb-11ea-8a37-3f2034ecbca6	Steady	2019-12-04 15:09:24.286521	2019-12-04 15:09:24.286521
1cb3e1b0-16eb-11ea-8a37-9fd213694583	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca313c6-16eb-11ea-8a37-9f5c4d06d574	Steady	2019-12-04 15:09:24.289743	2019-12-04 15:09:24.289743
1cb46086-16eb-11ea-8a37-8bd7693fa54b	1c9163a6-16eb-11ea-8a37-f39bdf338693	1cabee4c-16eb-11ea-8a37-cbec4d3c0828	Break	2019-12-04 15:09:24.29299	2019-12-04 15:09:24.29299
1cb55220-16eb-11ea-8a37-ebbe285111b9	1c9163a6-16eb-11ea-8a37-f39bdf338693	1cadc456-16eb-11ea-8a37-471cdc4ed885	Steady	2019-12-04 15:09:24.29915	2019-12-04 15:09:24.29915
1cb64e28-16eb-11ea-8a37-83da931dea21	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca9084e-16eb-11ea-8a37-7f45fd758f13	Break	2019-12-04 15:09:24.305569	2019-12-04 15:09:24.305569
1cb74530-16eb-11ea-8a37-532d20af8f1c	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca7fcec-16eb-11ea-8a37-9b33df3cb7e5	Steady	2019-12-04 15:09:24.311931	2019-12-04 15:09:24.311931
1cb837ce-16eb-11ea-8a37-c37fa0b3af9a	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca88072-16eb-11ea-8a37-77eff27930ae	Steady	2019-12-04 15:09:24.318133	2019-12-04 15:09:24.318133
1cb90eba-16eb-11ea-8a37-77a64a626d5f	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c9f543e-16eb-11ea-8a37-b3eb502aeb9b	Break	2019-12-04 15:09:24.323646	2019-12-04 15:09:24.323646
1cb9e772-16eb-11ea-8a37-f3ac5b78da54	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca15e3c-16eb-11ea-8a37-377466d50e3e	Steady	2019-12-04 15:09:24.329187	2019-12-04 15:09:24.329187
1cbabc74-16eb-11ea-8a37-73585ac5f196	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca4be92-16eb-11ea-8a37-9f44e4ec9384	Steady	2019-12-04 15:09:24.334634	2019-12-04 15:09:24.334634
1cbb9428-16eb-11ea-8a37-fbfd700c7525	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca5da2a-16eb-11ea-8a37-b34add8eb606	Steady	2019-12-04 15:09:24.340154	2019-12-04 15:09:24.340154
1cbc27bc-16eb-11ea-8a37-f72d5a6b0d2d	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c9e3db0-16eb-11ea-8a37-8faf5ac78492	Steady	2019-12-04 15:09:24.343908	2019-12-04 15:09:24.343908
1cbcbde4-16eb-11ea-8a37-a7f2f4a49e00	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca54c40-16eb-11ea-8a37-27bb1d0f3031	Steady	2019-12-04 15:09:24.34778	2019-12-04 15:09:24.34778
1cbd4ea8-16eb-11ea-8a37-03178a843beb	1c9163a6-16eb-11ea-8a37-f39bdf338693	1caaf6c2-16eb-11ea-8a37-271c961220a0	Steady	2019-12-04 15:09:24.351482	2019-12-04 15:09:24.351482
1cbddb84-16eb-11ea-8a37-23d1006b8f9f	1c9163a6-16eb-11ea-8a37-f39bdf338693	1ca6ed20-16eb-11ea-8a37-5b2e28784777	Steady	2019-12-04 15:09:24.355112	2019-12-04 15:09:24.355112
1cd015ce-16eb-11ea-8a37-17a7510723d4	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1ccb70e6-16eb-11ea-8a37-6f517093c2cb	Steady	2019-12-04 15:09:24.474552	2019-12-04 15:09:24.474552
1cd0f1ec-16eb-11ea-8a37-0fe3b7cb9b06	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1ccae5d6-16eb-11ea-8a37-8f07b78f3e1d	Steady	2019-12-04 15:09:24.48017	2019-12-04 15:09:24.48017
1cd1ccf2-16eb-11ea-8a37-177a621d77bd	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cca544a-16eb-11ea-8a37-67ae3d67afb1	Break	2019-12-04 15:09:24.485807	2019-12-04 15:09:24.485807
1cd2a014-16eb-11ea-8a37-e7c86c1689dd	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1ccf12fa-16eb-11ea-8a37-cbd3dcd7f284	Steady	2019-12-04 15:09:24.491213	2019-12-04 15:09:24.491213
1cd372e6-16eb-11ea-8a37-df1ffebeb4a6	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cc92e08-16eb-11ea-8a37-2f9f2214690f	Steady	2019-12-04 15:09:24.496611	2019-12-04 15:09:24.496611
1cd3feb4-16eb-11ea-8a37-b742ab0ff532	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cc9c3e0-16eb-11ea-8a37-2bd4f14bc936	Steady	2019-12-04 15:09:24.500155	2019-12-04 15:09:24.500155
1cd49108-16eb-11ea-8a37-e752fea6abff	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cc89358-16eb-11ea-8a37-b38dc3d8af69	Steady	2019-12-04 15:09:24.503909	2019-12-04 15:09:24.503909
1cd5279e-16eb-11ea-8a37-ab2bf6f5c6a5	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1ccd0014-16eb-11ea-8a37-eb4beb0ad258	Break	2019-12-04 15:09:24.507768	2019-12-04 15:09:24.507768
1cd5b312-16eb-11ea-8a37-e38ee21caef9	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cce0932-16eb-11ea-8a37-9f29cfbc8dae	Steady	2019-12-04 15:09:24.511319	2019-12-04 15:09:24.511319
1cd63b84-16eb-11ea-8a37-97000382b18f	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1ccbfcbe-16eb-11ea-8a37-13c21cd14224	Steady	2019-12-04 15:09:24.514836	2019-12-04 15:09:24.514836
1cf23672-16eb-11ea-8a37-c7b2cf896c8c	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cef2e1e-16eb-11ea-8a37-7f9c8f67bd1d	Steady	2019-12-04 15:09:24.698103	2019-12-04 15:09:24.698103
1cf2f436-16eb-11ea-8a37-bb9e7514a360	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce237d6-16eb-11ea-8a37-775845d6551f	Steady	2019-12-04 15:09:24.702966	2019-12-04 15:09:24.702966
1cf422de-16eb-11ea-8a37-e7c721eb2fb2	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce64d58-16eb-11ea-8a37-734a3116c912	Steady	2019-12-04 15:09:24.710674	2019-12-04 15:09:24.710674
1cf557da-16eb-11ea-8a37-f7e9472d7c74	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cf17728-16eb-11ea-8a37-4311ec823f21	Steady	2019-12-04 15:09:24.718589	2019-12-04 15:09:24.718589
1cf68a10-16eb-11ea-8a37-fb4643aa2126	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce2cb06-16eb-11ea-8a37-835b3d375204	Steady	2019-12-04 15:09:24.72646	2019-12-04 15:09:24.72646
1cf7b318-16eb-11ea-8a37-938d3ec6ce28	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce109ce-16eb-11ea-8a37-435e5448fc85	Steady	2019-12-04 15:09:24.734058	2019-12-04 15:09:24.734058
1cf8c10e-16eb-11ea-8a37-e700b5975ec9	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce8a030-16eb-11ea-8a37-e3425dc3d5cf	Steady	2019-12-04 15:09:24.740974	2019-12-04 15:09:24.740974
1cf9ccca-16eb-11ea-8a37-0f4ab5c65321	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce35ea4-16eb-11ea-8a37-23af26542a93	Steady	2019-12-04 15:09:24.747824	2019-12-04 15:09:24.747824
1cfad214-16eb-11ea-8a37-fb811b8ed7a9	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce51c9e-16eb-11ea-8a37-1fc785e01ea0	Steady	2019-12-04 15:09:24.754502	2019-12-04 15:09:24.754502
1cfbd8b2-16eb-11ea-8a37-2ff0a8a0b762	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce1a0fa-16eb-11ea-8a37-bbc6e905e01e	Break	2019-12-04 15:09:24.761232	2019-12-04 15:09:24.761232
1cfc9da6-16eb-11ea-8a37-678d0d7c1613	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce9b02e-16eb-11ea-8a37-efc1e2648008	Steady	2019-12-04 15:09:24.766238	2019-12-04 15:09:24.766238
1cfd5dcc-16eb-11ea-8a37-0f564431ee90	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cf0be1e-16eb-11ea-8a37-63fc7d9337a5	Steady	2019-12-04 15:09:24.771178	2019-12-04 15:09:24.771178
1cfe18de-16eb-11ea-8a37-e3232a245b43	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cebcc88-16eb-11ea-8a37-e72ae72b7ed1	Steady	2019-12-04 15:09:24.775978	2019-12-04 15:09:24.775978
1cfed0a8-16eb-11ea-8a37-cf51fa455e7a	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ceabeec-16eb-11ea-8a37-cb766a66f751	Steady	2019-12-04 15:09:24.780679	2019-12-04 15:09:24.780679
1cff8c96-16eb-11ea-8a37-ab556f0cd39a	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cecd84e-16eb-11ea-8a37-032e4ae43a1f	Break	2019-12-04 15:09:24.78543	2019-12-04 15:09:24.78543
1d004708-16eb-11ea-8a37-e310a92a2372	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ced9d1a-16eb-11ea-8a37-83ed1cafa135	Break	2019-12-04 15:09:24.790261	2019-12-04 15:09:24.790261
1d00f324-16eb-11ea-8a37-679080641278	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cefff42-16eb-11ea-8a37-dfba22039c67	Steady	2019-12-04 15:09:24.794699	2019-12-04 15:09:24.794699
1d01a53a-16eb-11ea-8a37-13e8afca462b	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cee6362-16eb-11ea-8a37-37b83a7d133a	Steady	2019-12-04 15:09:24.799246	2019-12-04 15:09:24.799246
1d02cb0e-16eb-11ea-8a37-dba18030cb62	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce77aca-16eb-11ea-8a37-cb1a20351cc0	Steady	2019-12-04 15:09:24.806738	2019-12-04 15:09:24.806738
1d03ff56-16eb-11ea-8a37-e3be2e0771c8	1cd6c720-16eb-11ea-8a37-772e7139de8e	1ce3fa4e-16eb-11ea-8a37-333441e80888	Steady	2019-12-04 15:09:24.814629	2019-12-04 15:09:24.814629
1d2c963c-16eb-11ea-8a37-bf6e49df6bfd	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d26a5d8-16eb-11ea-8a37-4742d5dbf679	Break	2019-12-04 15:09:25.080645	2019-12-04 15:09:25.080645
1d2d54c8-16eb-11ea-8a37-d3f2a8459a03	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d27b040-16eb-11ea-8a37-7f42163ee895	Steady	2019-12-04 15:09:25.085443	2019-12-04 15:09:25.085443
1d2e143a-16eb-11ea-8a37-f73c2e839caf	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1bfcdc-16eb-11ea-8a37-236b85c98b26	Steady	2019-12-04 15:09:25.090424	2019-12-04 15:09:25.090424
1d2ec9e8-16eb-11ea-8a37-73fbc67c7e83	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d20e74c-16eb-11ea-8a37-a7c427e6ade3	Break	2019-12-04 15:09:25.095077	2019-12-04 15:09:25.095077
1d2ff296-16eb-11ea-8a37-27804037ac6d	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1ef55e-16eb-11ea-8a37-2b2ec7cda994	Steady	2019-12-04 15:09:25.102664	2019-12-04 15:09:25.102664
1d3122d8-16eb-11ea-8a37-eb65cce46411	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d2bcfe0-16eb-11ea-8a37-c3856815661d	Steady	2019-12-04 15:09:25.110435	2019-12-04 15:09:25.110435
1d325d4c-16eb-11ea-8a37-9700166dcef5	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d221db0-16eb-11ea-8a37-efda45e9e3c1	Break	2019-12-04 15:09:25.118482	2019-12-04 15:09:25.118482
1d338b04-16eb-11ea-8a37-df3b798e2949	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1d7bc0-16eb-11ea-8a37-673dae1799f0	Steady	2019-12-04 15:09:25.126258	2019-12-04 15:09:25.126258
1d3493be-16eb-11ea-8a37-038b89edeb40	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d235720-16eb-11ea-8a37-cb89c941ec21	Steady	2019-12-04 15:09:25.133035	2019-12-04 15:09:25.133035
1d359ef8-16eb-11ea-8a37-5b34d24f47fe	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d178bca-16eb-11ea-8a37-975a57142986	Steady	2019-12-04 15:09:25.139855	2019-12-04 15:09:25.139855
1d36b978-16eb-11ea-8a37-dfa79849e3f7	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1fb818-16eb-11ea-8a37-5bae274e1b9d	Steady	2019-12-04 15:09:25.147045	2019-12-04 15:09:25.147045
1d37d7d6-16eb-11ea-8a37-6313f7a8dd08	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1e3858-16eb-11ea-8a37-b790a36bbbb7	Break	2019-12-04 15:09:25.154405	2019-12-04 15:09:25.154405
1d389496-16eb-11ea-8a37-976347aebc67	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1683b0-16eb-11ea-8a37-2fb1b926f457	Steady	2019-12-04 15:09:25.159261	2019-12-04 15:09:25.159261
1d3952f0-16eb-11ea-8a37-7758e91f8ea4	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d2a3cb6-16eb-11ea-8a37-3fbf85a55f20	Steady	2019-12-04 15:09:25.164138	2019-12-04 15:09:25.164138
1d3a0d58-16eb-11ea-8a37-2f11919600dc	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d2595a8-16eb-11ea-8a37-076e3fd6b1f0	Steady	2019-12-04 15:09:25.1689	2019-12-04 15:09:25.1689
1d3aca18-16eb-11ea-8a37-3714bf79863e	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d248186-16eb-11ea-8a37-3f4314364003	Steady	2019-12-04 15:09:25.173738	2019-12-04 15:09:25.173738
1d3b9056-16eb-11ea-8a37-b39c4896358f	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d2979a2-16eb-11ea-8a37-73852ef80c77	Steady	2019-12-04 15:09:25.178807	2019-12-04 15:09:25.178807
1d3c4c44-16eb-11ea-8a37-5bde2263a032	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d19ad88-16eb-11ea-8a37-5bb1d87a518f	Steady	2019-12-04 15:09:25.183634	2019-12-04 15:09:25.183634
1d3d04d6-16eb-11ea-8a37-8b043fdb3464	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1cb5aa-16eb-11ea-8a37-db5dabbe73d0	Steady	2019-12-04 15:09:25.188362	2019-12-04 15:09:25.188362
1d3dbdf4-16eb-11ea-8a37-eb3ff691ab41	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d28bd32-16eb-11ea-8a37-5349b8b092ac	Break	2019-12-04 15:09:25.193102	2019-12-04 15:09:25.193102
1d3eea3a-16eb-11ea-8a37-8f4fa2ddb174	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d2b0ef2-16eb-11ea-8a37-1b333b8ce088	Steady	2019-12-04 15:09:25.200754	2019-12-04 15:09:25.200754
1d402044-16eb-11ea-8a37-9b79a90679d3	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d18a190-16eb-11ea-8a37-f33950955920	Steady	2019-12-04 15:09:25.2087	2019-12-04 15:09:25.2087
1d415446-16eb-11ea-8a37-773aebbabdfe	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1b39a0-16eb-11ea-8a37-bfd31e2c3820	Steady	2019-12-04 15:09:25.216584	2019-12-04 15:09:25.216584
1d428050-16eb-11ea-8a37-077f81d3d93f	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d157a7e-16eb-11ea-8a37-5bc2f0980669	Steady	2019-12-04 15:09:25.224264	2019-12-04 15:09:25.224264
1d438c48-16eb-11ea-8a37-cffb3290f724	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d1a6dcc-16eb-11ea-8a37-23dd9e1cc072	Steady	2019-12-04 15:09:25.231137	2019-12-04 15:09:25.231137
1d61b6f0-16eb-11ea-8a37-0fe44aadabe5	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d58234c-16eb-11ea-8a37-37b65bedfa44	Steady	2019-12-04 15:09:25.428785	2019-12-04 15:09:25.428785
1d62c2a2-16eb-11ea-8a37-af20a56a9036	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d575f98-16eb-11ea-8a37-df66608b9ad2	Steady	2019-12-04 15:09:25.43568	2019-12-04 15:09:25.43568
1d63cabc-16eb-11ea-8a37-b3fa56e0dc97	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d60aa08-16eb-11ea-8a37-4fc976d20df7	Steady	2019-12-04 15:09:25.442434	2019-12-04 15:09:25.442434
1d64e19a-16eb-11ea-8a37-27987edc8cc8	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d52b61e-16eb-11ea-8a37-7b99a4c0af37	Break	2019-12-04 15:09:25.449473	2019-12-04 15:09:25.449473
1d65ae04-16eb-11ea-8a37-c7de5129ce28	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d599164-16eb-11ea-8a37-7fb17ed58efa	Steady	2019-12-04 15:09:25.454773	2019-12-04 15:09:25.454773
1d667a3c-16eb-11ea-8a37-efaca19343d4	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d55d326-16eb-11ea-8a37-c78892d10ce8	Steady	2019-12-04 15:09:25.460025	2019-12-04 15:09:25.460025
1d67331e-16eb-11ea-8a37-5f956430b7b3	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d507f52-16eb-11ea-8a37-0faae9856a7d	Steady	2019-12-04 15:09:25.464788	2019-12-04 15:09:25.464788
1d67f132-16eb-11ea-8a37-dbe9ee143f96	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d53c0b8-16eb-11ea-8a37-2f98183ac38f	Steady	2019-12-04 15:09:25.469552	2019-12-04 15:09:25.469552
1d68b5cc-16eb-11ea-8a37-235270aad58a	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d51a8b4-16eb-11ea-8a37-3ba1ab1a8166	Steady	2019-12-04 15:09:25.474662	2019-12-04 15:09:25.474662
1d6978b8-16eb-11ea-8a37-078c16a19742	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5cff02-16eb-11ea-8a37-73061a85317c	Steady	2019-12-04 15:09:25.479633	2019-12-04 15:09:25.479633
1d6a3e92-16eb-11ea-8a37-a75fe17ec8e9	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5b0558-16eb-11ea-8a37-5b98ca6e0a16	Steady	2019-12-04 15:09:25.484707	2019-12-04 15:09:25.484707
1d6b0f34-16eb-11ea-8a37-f7da5958989d	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5f73ea-16eb-11ea-8a37-8f5db88aea40	Steady	2019-12-04 15:09:25.490055	2019-12-04 15:09:25.490055
1d6c2d74-16eb-11ea-8a37-577c034514e9	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d54c51c-16eb-11ea-8a37-9b425fbe6c77	Steady	2019-12-04 15:09:25.49745	2019-12-04 15:09:25.49745
1d6d4916-16eb-11ea-8a37-ffbc05dc10e8	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5e38a4-16eb-11ea-8a37-a7fef6954c84	Steady	2019-12-04 15:09:25.504726	2019-12-04 15:09:25.504726
1d6e54d2-16eb-11ea-8a37-6b9eccafb1ea	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5bcc22-16eb-11ea-8a37-47f9de0571d9	Steady	2019-12-04 15:09:25.511582	2019-12-04 15:09:25.511582
1d6f56de-16eb-11ea-8a37-43aac4f7d4e7	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d58dbac-16eb-11ea-8a37-a71a0789637e	Steady	2019-12-04 15:09:25.518199	2019-12-04 15:09:25.518199
1d703720-16eb-11ea-8a37-639e51f29b51	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d5a48e8-16eb-11ea-8a37-2bfbdf2b15e0	Break	2019-12-04 15:09:25.523976	2019-12-04 15:09:25.523976
1d713d5a-16eb-11ea-8a37-fbe04713652b	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d56a1fc-16eb-11ea-8a37-177789b4ae0a	Steady	2019-12-04 15:09:25.530588	2019-12-04 15:09:25.530588
1d91b166-16eb-11ea-8a37-230f6304a845	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d859d18-16eb-11ea-8a37-8b9bf481889a	Steady	2019-12-04 15:09:25.743259	2019-12-04 15:09:25.743259
1d927178-16eb-11ea-8a37-23e16f79553f	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d87e06e-16eb-11ea-8a37-43e370112c58	Break	2019-12-04 15:09:25.748165	2019-12-04 15:09:25.748165
1d933446-16eb-11ea-8a37-3fa923dff339	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d88a6ac-16eb-11ea-8a37-03d396089124	Steady	2019-12-04 15:09:25.753174	2019-12-04 15:09:25.753174
1d93fbf6-16eb-11ea-8a37-63b48c91420b	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8e86ee-16eb-11ea-8a37-c7f8be11d666	Steady	2019-12-04 15:09:25.758252	2019-12-04 15:09:25.758252
1d94bea6-16eb-11ea-8a37-6f139a2db13e	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8171c0-16eb-11ea-8a37-a709dba143ff	Break	2019-12-04 15:09:25.763278	2019-12-04 15:09:25.763278
1d9587f0-16eb-11ea-8a37-07309383c6c9	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8716ac-16eb-11ea-8a37-1bf66558c3c0	Steady	2019-12-04 15:09:25.768382	2019-12-04 15:09:25.768382
1d963c86-16eb-11ea-8a37-3fa4531ce109	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d90a7da-16eb-11ea-8a37-1fc591e1ffb4	Break	2019-12-04 15:09:25.773042	2019-12-04 15:09:25.773042
1d970a6c-16eb-11ea-8a37-8b6138bd3c88	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8b10fe-16eb-11ea-8a37-bb6f72445e05	Steady	2019-12-04 15:09:25.77824	2019-12-04 15:09:25.77824
1d97cf56-16eb-11ea-8a37-3f0cf78caf24	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d84d928-16eb-11ea-8a37-8f57230c1140	Steady	2019-12-04 15:09:25.783299	2019-12-04 15:09:25.783299
1d990178-16eb-11ea-8a37-3b514f853fac	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d89d8e2-16eb-11ea-8a37-e3700bbed2bb	Steady	2019-12-04 15:09:25.79111	2019-12-04 15:09:25.79111
1d9a3372-16eb-11ea-8a37-9bef30938f9f	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8c4514-16eb-11ea-8a37-a7a0bf62579d	Steady	2019-12-04 15:09:25.799024	2019-12-04 15:09:25.799024
1d9b4712-16eb-11ea-8a37-176d9389759c	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d841a1a-16eb-11ea-8a37-c357889c8ede	Steady	2019-12-04 15:09:25.806108	2019-12-04 15:09:25.806108
1d9c4b58-16eb-11ea-8a37-1bfab76e1a4a	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d865438-16eb-11ea-8a37-5788b652fed4	Steady	2019-12-04 15:09:25.812804	2019-12-04 15:09:25.812804
1d9d2de8-16eb-11ea-8a37-3fc8f189831a	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8f97e6-16eb-11ea-8a37-67df10146684	Steady	2019-12-04 15:09:25.818603	2019-12-04 15:09:25.818603
1d9e09a2-16eb-11ea-8a37-ab2985b0a1dc	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d828966-16eb-11ea-8a37-a7d29dc5e148	Steady	2019-12-04 15:09:25.824264	2019-12-04 15:09:25.824264
1d9edefe-16eb-11ea-8a37-bbc13859721b	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d835238-16eb-11ea-8a37-23a2a3de0fc3	Steady	2019-12-04 15:09:25.829728	2019-12-04 15:09:25.829728
1d9fb644-16eb-11ea-8a37-8f77119d1bc5	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d8d715a-16eb-11ea-8a37-df7e6d58d5e4	Steady	2019-12-04 15:09:25.835223	2019-12-04 15:09:25.835223
1dc6d6de-16eb-11ea-8a37-cbcb568ae8cf	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbfe68a-16eb-11ea-8a37-1bb9dae12f05	Steady	2019-12-04 15:09:26.091493	2019-12-04 15:09:26.091493
1dc7e074-16eb-11ea-8a37-3b0347023bc2	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc34852-16eb-11ea-8a37-0fc90d56cc1a	Steady	2019-12-04 15:09:26.098369	2019-12-04 15:09:26.098369
1dc8e5a0-16eb-11ea-8a37-a3fedc73a614	1da04118-16eb-11ea-8a37-3f1dce9d6424	1daf72aa-16eb-11ea-8a37-23a902b6b33c	Steady	2019-12-04 15:09:26.105049	2019-12-04 15:09:26.105049
1dc9edba-16eb-11ea-8a37-878650afe17a	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db58136-16eb-11ea-8a37-f3afa2449751	Steady	2019-12-04 15:09:26.111789	2019-12-04 15:09:26.111789
1dcafb1a-16eb-11ea-8a37-87a49325abca	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db6b75e-16eb-11ea-8a37-b7571784101b	Steady	2019-12-04 15:09:26.118682	2019-12-04 15:09:26.118682
1dcbb122-16eb-11ea-8a37-0feb39ad82d7	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db7e0d4-16eb-11ea-8a37-4bfb7b94c921	Steady	2019-12-04 15:09:26.12338	2019-12-04 15:09:26.12338
1dcc6874-16eb-11ea-8a37-43327c5e2d8b	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db45022-16eb-11ea-8a37-af2cac25ecf9	Steady	2019-12-04 15:09:26.128079	2019-12-04 15:09:26.128079
1dcd20e8-16eb-11ea-8a37-37d86b0cea0a	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbb0d2c-16eb-11ea-8a37-1f400253c5b5	Break	2019-12-04 15:09:26.132784	2019-12-04 15:09:26.132784
1dcddbf0-16eb-11ea-8a37-2fdc1d6d5f43	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db324fe-16eb-11ea-8a37-37d28504944a	Steady	2019-12-04 15:09:26.13752	2019-12-04 15:09:26.13752
1dce9702-16eb-11ea-8a37-b38cf96b2f57	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbf268c-16eb-11ea-8a37-87efd0a31778	Steady	2019-12-04 15:09:26.142365	2019-12-04 15:09:26.142365
1dcf552a-16eb-11ea-8a37-37cf44b9650b	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc5ab7e-16eb-11ea-8a37-8335a3c125aa	Steady	2019-12-04 15:09:26.14721	2019-12-04 15:09:26.14721
1dd010fa-16eb-11ea-8a37-47f0fed78ca8	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dba02ec-16eb-11ea-8a37-d71acaf81dc8	Steady	2019-12-04 15:09:26.152033	2019-12-04 15:09:26.152033
1dd0cbe4-16eb-11ea-8a37-03db1acd9698	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc2173e-16eb-11ea-8a37-dfe223292b44	Break	2019-12-04 15:09:26.156825	2019-12-04 15:09:26.156825
1dd1f0dc-16eb-11ea-8a37-d336258f5a63	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc0a55c-16eb-11ea-8a37-9fb92d33f0ce	Steady	2019-12-04 15:09:26.164316	2019-12-04 15:09:26.164316
1dd317f0-16eb-11ea-8a37-d36069a890df	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db1b394-16eb-11ea-8a37-7ba101fb983e	Steady	2019-12-04 15:09:26.171863	2019-12-04 15:09:26.171863
1dd443a0-16eb-11ea-8a37-27906b53cb14	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db8f050-16eb-11ea-8a37-ff82cac831a9	Steady	2019-12-04 15:09:26.179541	2019-12-04 15:09:26.179541
1dd56e06-16eb-11ea-8a37-334573617712	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbe642c-16eb-11ea-8a37-4f00b50af80c	Steady	2019-12-04 15:09:26.187181	2019-12-04 15:09:26.187181
1dd679d6-16eb-11ea-8a37-c364c3d34f0c	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db03172-16eb-11ea-8a37-539b2197ce23	Steady	2019-12-04 15:09:26.194046	2019-12-04 15:09:26.194046
1dd78858-16eb-11ea-8a37-0f1f090bd19f	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db26f32-16eb-11ea-8a37-cffbaf3ab414	Break	2019-12-04 15:09:26.200924	2019-12-04 15:09:26.200924
1dd8996e-16eb-11ea-8a37-03eb3871f440	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbd9fd8-16eb-11ea-8a37-6b962a8fbcb3	Steady	2019-12-04 15:09:26.20793	2019-12-04 15:09:26.20793
1dd9a85e-16eb-11ea-8a37-37dd70266ae2	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc15d62-16eb-11ea-8a37-1366c6a0f310	Steady	2019-12-04 15:09:26.214879	2019-12-04 15:09:26.214879
1dda6ae6-16eb-11ea-8a37-e7c6513df882	1da04118-16eb-11ea-8a37-3f1dce9d6424	1daea7ee-16eb-11ea-8a37-1bcd0a3f8f87	Steady	2019-12-04 15:09:26.219862	2019-12-04 15:09:26.219862
1ddb2b48-16eb-11ea-8a37-73e50473cf5e	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dc477c2-16eb-11ea-8a37-a39522d2ae59	Break	2019-12-04 15:09:26.224809	2019-12-04 15:09:26.224809
1ddbe95c-16eb-11ea-8a37-23c654e984da	1da04118-16eb-11ea-8a37-3f1dce9d6424	1db0f2c4-16eb-11ea-8a37-7b46097f193b	Steady	2019-12-04 15:09:26.229576	2019-12-04 15:09:26.229576
1ddcaae0-16eb-11ea-8a37-5b121a37f572	1da04118-16eb-11ea-8a37-3f1dce9d6424	1dbc1d2a-16eb-11ea-8a37-2bfddb351163	Steady	2019-12-04 15:09:26.234621	2019-12-04 15:09:26.234621
1df4cc92-16eb-11ea-8a37-5f63b3266160	1ddd768c-16eb-11ea-8a37-ab599777e83d	1df18866-16eb-11ea-8a37-77e48ab03550	Steady	2019-12-04 15:09:26.392815	2019-12-04 15:09:26.392815
1df5bc4c-16eb-11ea-8a37-e776f1c20510	1ddd768c-16eb-11ea-8a37-ab599777e83d	1df2b84e-16eb-11ea-8a37-c30acf9de20b	Steady	2019-12-04 15:09:26.398963	2019-12-04 15:09:26.398963
1df6a3d2-16eb-11ea-8a37-0b64a4ffa262	1ddd768c-16eb-11ea-8a37-ab599777e83d	1df2b84e-16eb-11ea-8a37-c30acf9de20b	Steady	2019-12-04 15:09:26.404894	2019-12-04 15:09:26.404894
1df735b8-16eb-11ea-8a37-27f2133a25f5	1ddd768c-16eb-11ea-8a37-ab599777e83d	1df3cdba-16eb-11ea-8a37-b7f7e334b2af	Hard	2019-12-04 15:09:26.40866	2019-12-04 15:09:26.40866
1e0f0436-16eb-11ea-8a37-fb3a0c578c1f	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0484ca-16eb-11ea-8a37-0727b88d4878	Steady	2019-12-04 15:09:26.5647	2019-12-04 15:09:26.5647
1e0fd906-16eb-11ea-8a37-1f4c1791c600	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e078cd8-16eb-11ea-8a37-3bc6bb9305a9	Steady	2019-12-04 15:09:26.570143	2019-12-04 15:09:26.570143
1e10b344-16eb-11ea-8a37-bf771787f162	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e05466c-16eb-11ea-8a37-639b34567888	Steady	2019-12-04 15:09:26.575722	2019-12-04 15:09:26.575722
1e118cd8-16eb-11ea-8a37-e73526713ad7	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0c1faa-16eb-11ea-8a37-ff90522dea76	Break	2019-12-04 15:09:26.5813	2019-12-04 15:09:26.5813
1e1212fc-16eb-11ea-8a37-c71a5e1b1751	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e060854-16eb-11ea-8a37-23ddd010d2f2	Steady	2019-12-04 15:09:26.584751	2019-12-04 15:09:26.584751
1e129984-16eb-11ea-8a37-3743d17b19b5	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e086126-16eb-11ea-8a37-979e710a87e9	Steady	2019-12-04 15:09:26.5882	2019-12-04 15:09:26.5882
1e131e5e-16eb-11ea-8a37-9bc70c03c5db	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0d2cd8-16eb-11ea-8a37-5f249b64dfd5	Steady	2019-12-04 15:09:26.591607	2019-12-04 15:09:26.591607
1e13a1e4-16eb-11ea-8a37-2b0c6896d5ad	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e09192c-16eb-11ea-8a37-5beadf0a0486	Steady	2019-12-04 15:09:26.594976	2019-12-04 15:09:26.594976
1e1423a8-16eb-11ea-8a37-dbe560017d04	1df7d432-16eb-11ea-8a37-97c25b2a6298	1dfe2f8a-16eb-11ea-8a37-a395d5f0a96d	Steady	2019-12-04 15:09:26.598285	2019-12-04 15:09:26.598285
1e14aad0-16eb-11ea-8a37-6350f8c42d9d	1df7d432-16eb-11ea-8a37-97c25b2a6298	1dff767e-16eb-11ea-8a37-c35908a4587d	Steady	2019-12-04 15:09:26.601742	2019-12-04 15:09:26.601742
1e152e9c-16eb-11ea-8a37-936f1011b942	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e09d498-16eb-11ea-8a37-27cb4c60a892	Steady	2019-12-04 15:09:26.605137	2019-12-04 15:09:26.605137
1e15abe2-16eb-11ea-8a37-efb4b1f36802	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0aff58-16eb-11ea-8a37-8b5183444f41	Steady	2019-12-04 15:09:26.608344	2019-12-04 15:09:26.608344
1e16b15e-16eb-11ea-8a37-670a1d835907	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e03c68e-16eb-11ea-8a37-2f8389fc2b09	Steady	2019-12-04 15:09:26.614938	2019-12-04 15:09:26.614938
1e17cd0a-16eb-11ea-8a37-2763915e9da3	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e01a5de-16eb-11ea-8a37-bbc90c4e111f	Steady	2019-12-04 15:09:26.622183	2019-12-04 15:09:26.622183
1e18f446-16eb-11ea-8a37-7fbbd22e3030	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e06cdf2-16eb-11ea-8a37-d7017ade4a11	Break	2019-12-04 15:09:26.629693	2019-12-04 15:09:26.629693
1e1a1e20-16eb-11ea-8a37-9ff1dd6ee7db	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0e2a66-16eb-11ea-8a37-9325f721bab8	Break	2019-12-04 15:09:26.637256	2019-12-04 15:09:26.637256
1e1b2e5a-16eb-11ea-8a37-3f42ef8d3f2b	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e02babe-16eb-11ea-8a37-d3827652bc3e	Steady	2019-12-04 15:09:26.644275	2019-12-04 15:09:26.644275
1e1c3a20-16eb-11ea-8a37-c310b2444619	1df7d432-16eb-11ea-8a37-97c25b2a6298	1e0089c4-16eb-11ea-8a37-5f48ce58191e	Steady	2019-12-04 15:09:26.651148	2019-12-04 15:09:26.651148
1e4152d8-16eb-11ea-8a37-93b21bdc878e	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2e92ec-16eb-11ea-8a37-8bd684446653	Steady	2019-12-04 15:09:26.894329	2019-12-04 15:09:26.894329
1e41ed60-16eb-11ea-8a37-b3f1955894b5	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3b03a6-16eb-11ea-8a37-9375fa73f188	Steady	2019-12-04 15:09:26.89831	2019-12-04 15:09:26.89831
1e42ef76-16eb-11ea-8a37-f744976f622c	1e1d5928-16eb-11ea-8a37-9751a208273e	1e29c118-16eb-11ea-8a37-b7877564126c	Steady	2019-12-04 15:09:26.904936	2019-12-04 15:09:26.904936
1e43ecb4-16eb-11ea-8a37-83b4ea643baf	1e1d5928-16eb-11ea-8a37-9751a208273e	1e39f614-16eb-11ea-8a37-77ea81130825	Break	2019-12-04 15:09:26.911409	2019-12-04 15:09:26.911409
1e451c56-16eb-11ea-8a37-7f9f1850f824	1e1d5928-16eb-11ea-8a37-9751a208273e	1e344b92-16eb-11ea-8a37-af056d253c1a	Steady	2019-12-04 15:09:26.919017	2019-12-04 15:09:26.919017
1e464f4a-16eb-11ea-8a37-9b36f548807d	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2ad562-16eb-11ea-8a37-e390a6194206	Steady	2019-12-04 15:09:26.926932	2019-12-04 15:09:26.926932
1e47639e-16eb-11ea-8a37-5f4661ccb06f	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2bf212-16eb-11ea-8a37-bb003cfe8bf6	Steady	2019-12-04 15:09:26.933962	2019-12-04 15:09:26.933962
1e487b6c-16eb-11ea-8a37-130dd2370781	1e1d5928-16eb-11ea-8a37-9751a208273e	1e302e36-16eb-11ea-8a37-2f4e9926e629	Steady	2019-12-04 15:09:26.941142	2019-12-04 15:09:26.941142
1e499a92-16eb-11ea-8a37-2fe71202d529	1e1d5928-16eb-11ea-8a37-9751a208273e	1e32765a-16eb-11ea-8a37-b7b85b744677	Steady	2019-12-04 15:09:26.948483	2019-12-04 15:09:26.948483
1e4ab8fa-16eb-11ea-8a37-7ff8aa628abc	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2f60dc-16eb-11ea-8a37-77024465b4a4	Steady	2019-12-04 15:09:26.955808	2019-12-04 15:09:26.955808
1e4b7722-16eb-11ea-8a37-673767a3051a	1e1d5928-16eb-11ea-8a37-9751a208273e	1e38ebd4-16eb-11ea-8a37-371ae8ee0534	Steady	2019-12-04 15:09:26.960751	2019-12-04 15:09:26.960751
1e4c3dce-16eb-11ea-8a37-cfa2fcdde53f	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3326e0-16eb-11ea-8a37-c32c5f4b7dc2	Steady	2019-12-04 15:09:26.965761	2019-12-04 15:09:26.965761
1e4d027c-16eb-11ea-8a37-ff0874776ebe	1e1d5928-16eb-11ea-8a37-9751a208273e	1e36afae-16eb-11ea-8a37-4b4de5c7be48	Steady	2019-12-04 15:09:26.970847	2019-12-04 15:09:26.970847
1e4dc090-16eb-11ea-8a37-779fc54b2e8e	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3f17f2-16eb-11ea-8a37-7bb60b0b22f4	Steady	2019-12-04 15:09:26.975722	2019-12-04 15:09:26.975722
1e4e82aa-16eb-11ea-8a37-6b150ccaeeab	1e1d5928-16eb-11ea-8a37-9751a208273e	1e40ad10-16eb-11ea-8a37-1bc309c06654	Steady	2019-12-04 15:09:26.98063	2019-12-04 15:09:26.98063
1e4f473a-16eb-11ea-8a37-fba15e234811	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2dbd9a-16eb-11ea-8a37-9b6c1039d730	Steady	2019-12-04 15:09:26.985698	2019-12-04 15:09:26.985698
1e5004fe-16eb-11ea-8a37-cf844372702a	1e1d5928-16eb-11ea-8a37-9751a208273e	1e37df5a-16eb-11ea-8a37-df80900f0a80	Steady	2019-12-04 15:09:26.990556	2019-12-04 15:09:26.990556
1e50c330-16eb-11ea-8a37-0bb34a0b542b	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3cc6f0-16eb-11ea-8a37-ab68575fe2d2	Steady	2019-12-04 15:09:26.995408	2019-12-04 15:09:26.995408
1e51f25a-16eb-11ea-8a37-eb3e948ddba0	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3e59d4-16eb-11ea-8a37-83db85049a87	Steady	2019-12-04 15:09:27.003189	2019-12-04 15:09:27.003189
1e53279c-16eb-11ea-8a37-73cc565e61e2	1e1d5928-16eb-11ea-8a37-9751a208273e	1e31b8a0-16eb-11ea-8a37-071b46c8bae0	Break	2019-12-04 15:09:27.011081	2019-12-04 15:09:27.011081
1e54659e-16eb-11ea-8a37-9b647b01e847	1e1d5928-16eb-11ea-8a37-9751a208273e	1e2cf9c8-16eb-11ea-8a37-23c50f6808fd	Steady	2019-12-04 15:09:27.019229	2019-12-04 15:09:27.019229
1e55945a-16eb-11ea-8a37-775e9859fa26	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3c0e04-16eb-11ea-8a37-2f81ac41526e	Steady	2019-12-04 15:09:27.026996	2019-12-04 15:09:27.026996
1e56a430-16eb-11ea-8a37-3b0a60b45257	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3d9800-16eb-11ea-8a37-7b9ddc986351	Break	2019-12-04 15:09:27.033965	2019-12-04 15:09:27.033965
1e57b0a0-16eb-11ea-8a37-6f523b494faa	1e1d5928-16eb-11ea-8a37-9751a208273e	1e30ef6a-16eb-11ea-8a37-375bcef2a568	Break	2019-12-04 15:09:27.040848	2019-12-04 15:09:27.040848
1e58bfa4-16eb-11ea-8a37-d7881b02d320	1e1d5928-16eb-11ea-8a37-9751a208273e	1e28a9a4-16eb-11ea-8a37-53fe5fe4723b	Steady	2019-12-04 15:09:27.047766	2019-12-04 15:09:27.047766
1e59d3da-16eb-11ea-8a37-17a1d742f915	1e1d5928-16eb-11ea-8a37-9751a208273e	1e3fdb92-16eb-11ea-8a37-0361d36a2a01	Steady	2019-12-04 15:09:27.054824	2019-12-04 15:09:27.054824
1e5a945a-16eb-11ea-8a37-9b38e99a8f8e	1e1d5928-16eb-11ea-8a37-9751a208273e	1e35756c-16eb-11ea-8a37-8b6f3b749587	Steady	2019-12-04 15:09:27.059789	2019-12-04 15:09:27.059789
1e83f908-16eb-11ea-8a37-738226c28512	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7025b8-16eb-11ea-8a37-6f6cf539067e	Steady	2019-12-04 15:09:27.331077	2019-12-04 15:09:27.331077
1e850f0a-16eb-11ea-8a37-13718df1b89b	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6bf970-16eb-11ea-8a37-177ccdbe56fb	Break	2019-12-04 15:09:27.33815	2019-12-04 15:09:27.33815
1e86203e-16eb-11ea-8a37-b76212298c1d	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e75defe-16eb-11ea-8a37-bb2e568a8f8d	Break	2019-12-04 15:09:27.345113	2019-12-04 15:09:27.345113
1e873122-16eb-11ea-8a37-737d2213f934	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e82f120-16eb-11ea-8a37-8b3be1cde652	Break	2019-12-04 15:09:27.352173	2019-12-04 15:09:27.352173
1e87e7f2-16eb-11ea-8a37-2707f0304cbb	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e715a78-16eb-11ea-8a37-370e377c28c0	Steady	2019-12-04 15:09:27.356864	2019-12-04 15:09:27.356864
1e88a674-16eb-11ea-8a37-8b66dc2fa340	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7f5fba-16eb-11ea-8a37-27f4c942de94	Steady	2019-12-04 15:09:27.36174	2019-12-04 15:09:27.36174
1e896500-16eb-11ea-8a37-4b65f1637ae0	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e808c14-16eb-11ea-8a37-d738719d5b07	Steady	2019-12-04 15:09:27.366603	2019-12-04 15:09:27.366603
1e8a21f2-16eb-11ea-8a37-8f8ed36ee5d4	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6e2f92-16eb-11ea-8a37-8fd00c4a4025	Steady	2019-12-04 15:09:27.371444	2019-12-04 15:09:27.371444
1e8ad80e-16eb-11ea-8a37-0b23e4449e7e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e73bb56-16eb-11ea-8a37-434e7462ee79	Steady	2019-12-04 15:09:27.376115	2019-12-04 15:09:27.376115
1e8b92a8-16eb-11ea-8a37-4f02e37ea2e2	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7e2bd6-16eb-11ea-8a37-f3f389c24292	Steady	2019-12-04 15:09:27.38087	2019-12-04 15:09:27.38087
1e8c50b2-16eb-11ea-8a37-f33d7cbbc6b5	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6ef166-16eb-11ea-8a37-07fc9cf009f5	Steady	2019-12-04 15:09:27.38575	2019-12-04 15:09:27.38575
1e8d037c-16eb-11ea-8a37-5fdf0c51890c	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7bedc6-16eb-11ea-8a37-e3b504eb15a8	Break	2019-12-04 15:09:27.390337	2019-12-04 15:09:27.390337
1e8e2d1a-16eb-11ea-8a37-2b6845b695ee	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6cb4be-16eb-11ea-8a37-4b418caa85c8	Break	2019-12-04 15:09:27.397925	2019-12-04 15:09:27.397925
1e8f5582-16eb-11ea-8a37-2b24cedc4713	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6b3756-16eb-11ea-8a37-679350fbe556	Break	2019-12-04 15:09:27.405461	2019-12-04 15:09:27.405461
1e908128-16eb-11ea-8a37-138b07b3e174	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7d7006-16eb-11ea-8a37-273729c15742	Break	2019-12-04 15:09:27.413183	2019-12-04 15:09:27.413183
1e91aaf8-16eb-11ea-8a37-bbc9b88a8409	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7814da-16eb-11ea-8a37-ff7c4bfae7ed	Steady	2019-12-04 15:09:27.420821	2019-12-04 15:09:27.420821
1e92b1dc-16eb-11ea-8a37-b748f245e23d	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e728e98-16eb-11ea-8a37-af34b8edcae2	Steady	2019-12-04 15:09:27.427549	2019-12-04 15:09:27.427549
1e93b8a2-16eb-11ea-8a37-9b12be9a48fe	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e78dad2-16eb-11ea-8a37-03a1b3e2abf0	Steady	2019-12-04 15:09:27.434232	2019-12-04 15:09:27.434232
1e94b1e4-16eb-11ea-8a37-c3ef6a7c7c10	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7b23a0-16eb-11ea-8a37-1ffbc79e0145	Steady	2019-12-04 15:09:27.44072	2019-12-04 15:09:27.44072
1e95a680-16eb-11ea-8a37-6bdeba5649f5	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e81c386-16eb-11ea-8a37-a3ac1f7dfea4	Steady	2019-12-04 15:09:27.446971	2019-12-04 15:09:27.446971
1e96521a-16eb-11ea-8a37-2b490d462710	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e74c640-16eb-11ea-8a37-af6a16b0d628	Steady	2019-12-04 15:09:27.45133	2019-12-04 15:09:27.45133
1e96f60c-16eb-11ea-8a37-37aa8505c10e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e6d7200-16eb-11ea-8a37-fbd43f0c0014	Break	2019-12-04 15:09:27.455586	2019-12-04 15:09:27.455586
1e978cd4-16eb-11ea-8a37-f31a533f4df2	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7a5a56-16eb-11ea-8a37-5b9ab8cfff42	Break	2019-12-04 15:09:27.45945	2019-12-04 15:09:27.45945
1e98213a-16eb-11ea-8a37-8ff7645a7d47	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e79962a-16eb-11ea-8a37-1f297458604b	Steady	2019-12-04 15:09:27.463272	2019-12-04 15:09:27.463272
1e98cd60-16eb-11ea-8a37-b32bac304f5e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e7cab58-16eb-11ea-8a37-5bd5918c1c78	Steady	2019-12-04 15:09:27.467576	2019-12-04 15:09:27.467576
1e9988b8-16eb-11ea-8a37-5bc80d8e7cde	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e76f776-16eb-11ea-8a37-af1e030b160e	Steady	2019-12-04 15:09:27.472361	2019-12-04 15:09:27.472361
1ec0731a-16eb-11ea-8a37-0bca84b8da0f	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ea8d03e-16eb-11ea-8a37-bf89f7a0ae25	Steady	2019-12-04 15:09:27.727419	2019-12-04 15:09:27.727419
1ec12850-16eb-11ea-8a37-3b9a8a6f755a	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eafe928-16eb-11ea-8a37-e3d342dec08e	Steady	2019-12-04 15:09:27.732055	2019-12-04 15:09:27.732055
1ec1e5ec-16eb-11ea-8a37-9b15ded36cd0	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb0e8fa-16eb-11ea-8a37-773ae55c5975	Steady	2019-12-04 15:09:27.736904	2019-12-04 15:09:27.736904
1ec2a0b8-16eb-11ea-8a37-f79681eeaf09	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb648a4-16eb-11ea-8a37-579cf5197fe8	Steady	2019-12-04 15:09:27.741671	2019-12-04 15:09:27.741671
1ec35f12-16eb-11ea-8a37-0f05957d95e2	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ebd59b4-16eb-11ea-8a37-7ff71b398230	Break	2019-12-04 15:09:27.746547	2019-12-04 15:09:27.746547
1ec41830-16eb-11ea-8a37-7bb7d3989931	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ead15ea-16eb-11ea-8a37-8b72eed5efed	Break	2019-12-04 15:09:27.751283	2019-12-04 15:09:27.751283
1ec4d31a-16eb-11ea-8a37-b3aa7128c11b	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ebf6cae-16eb-11ea-8a37-733355d0dc87	Steady	2019-12-04 15:09:27.756008	2019-12-04 15:09:27.756008
1ec57e78-16eb-11ea-8a37-5388669dd120	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb8dcae-16eb-11ea-8a37-ffd60335b85a	Steady	2019-12-04 15:09:27.760503	2019-12-04 15:09:27.760503
1ec61b1c-16eb-11ea-8a37-4340f76a0fc1	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ea9f86a-16eb-11ea-8a37-339f5dd3a5b9	Steady	2019-12-04 15:09:27.764561	2019-12-04 15:09:27.764561
1ec718aa-16eb-11ea-8a37-5b8ef717a75b	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ebb3198-16eb-11ea-8a37-9b37937c5c6a	Steady	2019-12-04 15:09:27.771051	2019-12-04 15:09:27.771051
1ec81976-16eb-11ea-8a37-2fc83a56a958	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb593b4-16eb-11ea-8a37-f7af189b4d91	Steady	2019-12-04 15:09:27.777594	2019-12-04 15:09:27.777594
1ec91650-16eb-11ea-8a37-438b954fae2c	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb360ee-16eb-11ea-8a37-7b82b5a48608	Steady	2019-12-04 15:09:27.784112	2019-12-04 15:09:27.784112
1eca0d4e-16eb-11ea-8a37-ef3a1e72d4d4	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ebc5398-16eb-11ea-8a37-6f484880886d	Steady	2019-12-04 15:09:27.790427	2019-12-04 15:09:27.790427
1ecae4ee-16eb-11ea-8a37-87730b55f0b7	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb7b630-16eb-11ea-8a37-b38e09fd5e71	Steady	2019-12-04 15:09:27.79596	2019-12-04 15:09:27.79596
1ecbbd60-16eb-11ea-8a37-4bcd6ae74057	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eab0638-16eb-11ea-8a37-6b8e9582a1d6	Steady	2019-12-04 15:09:27.801484	2019-12-04 15:09:27.801484
1ecc9c62-16eb-11ea-8a37-8739fee2b28c	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb1ebce-16eb-11ea-8a37-cf63bb5d3b1f	Steady	2019-12-04 15:09:27.807212	2019-12-04 15:09:27.807212
1ecd76e6-16eb-11ea-8a37-d7928bd3b573	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eae1de6-16eb-11ea-8a37-f7b9101ddf59	Steady	2019-12-04 15:09:27.812806	2019-12-04 15:09:27.812806
1ecdfdbe-16eb-11ea-8a37-cfcfb73d357f	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ebe6656-16eb-11ea-8a37-afe9db69880b	Steady	2019-12-04 15:09:27.816269	2019-12-04 15:09:27.816269
1ece8f2c-16eb-11ea-8a37-c3b4c071f479	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1ea96396-16eb-11ea-8a37-67b7f258af92	Steady	2019-12-04 15:09:27.819972	2019-12-04 15:09:27.819972
1ecf126c-16eb-11ea-8a37-4fa044309fd1	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eac0ba0-16eb-11ea-8a37-f7678d8894fe	Steady	2019-12-04 15:09:27.823345	2019-12-04 15:09:27.823345
1ecf9926-16eb-11ea-8a37-b71086fa1381	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb42132-16eb-11ea-8a37-739542a583f3	Steady	2019-12-04 15:09:27.826805	2019-12-04 15:09:27.826805
1ed01b3a-16eb-11ea-8a37-97eb5e895d6c	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eba06c4-16eb-11ea-8a37-afb8a0e36c4c	Break	2019-12-04 15:09:27.830117	2019-12-04 15:09:27.830117
1ed09db2-16eb-11ea-8a37-9bbe9b7b0117	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb2a4c4-16eb-11ea-8a37-730259c8ecfb	Steady	2019-12-04 15:09:27.83347	2019-12-04 15:09:27.83347
1ed121d8-16eb-11ea-8a37-975517fb8f89	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb4db5e-16eb-11ea-8a37-fbc270e46e8f	Steady	2019-12-04 15:09:27.83685	2019-12-04 15:09:27.83685
1ed19e7e-16eb-11ea-8a37-dbbf7a499915	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eb6fa74-16eb-11ea-8a37-efd8ff4145d8	Steady	2019-12-04 15:09:27.840051	2019-12-04 15:09:27.840051
1ed29176-16eb-11ea-8a37-6b910fd87dbd	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1eaf0224-16eb-11ea-8a37-b7a76a795c43	Steady	2019-12-04 15:09:27.846269	2019-12-04 15:09:27.846269
1eef7016-16eb-11ea-8a37-539ecac1fc82	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee5e8d4-16eb-11ea-8a37-1bdaea2c3ecf	Steady	2019-12-04 15:09:28.035314	2019-12-04 15:09:28.035314
1ef09a72-16eb-11ea-8a37-9f3bdc70d113	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee83e4a-16eb-11ea-8a37-b3ca46c90912	Steady	2019-12-04 15:09:28.042966	2019-12-04 15:09:28.042966
1ef1af5c-16eb-11ea-8a37-0fe094f9cb95	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee4cba2-16eb-11ea-8a37-e3f15ff125c6	Steady	2019-12-04 15:09:28.050051	2019-12-04 15:09:28.050051
1ef2c162-16eb-11ea-8a37-fbbc48724251	1ed3893c-16eb-11ea-8a37-53c677a170ca	1edd3054-16eb-11ea-8a37-9b6e23517ba5	Steady	2019-12-04 15:09:28.057076	2019-12-04 15:09:28.057076
1ef3c544-16eb-11ea-8a37-534c4d9c9cbc	1ed3893c-16eb-11ea-8a37-53c677a170ca	1eebe4dc-16eb-11ea-8a37-93bcccadc7fc	Break	2019-12-04 15:09:28.063762	2019-12-04 15:09:28.063762
1ef4d0f6-16eb-11ea-8a37-ab42aec32318	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee068e6-16eb-11ea-8a37-c7d32dae35f7	Steady	2019-12-04 15:09:28.070575	2019-12-04 15:09:28.070575
1ef588d4-16eb-11ea-8a37-f375a2063062	1ed3893c-16eb-11ea-8a37-53c677a170ca	1eee4470-16eb-11ea-8a37-9f5f3c2ed64f	Steady	2019-12-04 15:09:28.075319	2019-12-04 15:09:28.075319
1ef646fc-16eb-11ea-8a37-0fe9dbd400fa	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee9b9aa-16eb-11ea-8a37-fb20af0374e6	Steady	2019-12-04 15:09:28.080155	2019-12-04 15:09:28.080155
1ef700ba-16eb-11ea-8a37-1bd1049f4230	1ed3893c-16eb-11ea-8a37-53c677a170ca	1eed17da-16eb-11ea-8a37-6bb693c62f16	Steady	2019-12-04 15:09:28.084934	2019-12-04 15:09:28.084934
1ef7ccc0-16eb-11ea-8a37-d327da03b7f9	1ed3893c-16eb-11ea-8a37-53c677a170ca	1edc199e-16eb-11ea-8a37-2b22bcb2a6fc	Steady	2019-12-04 15:09:28.090166	2019-12-04 15:09:28.090166
1ef882f0-16eb-11ea-8a37-13e97b75e030	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee3b1ea-16eb-11ea-8a37-8387f2d428a7	Steady	2019-12-04 15:09:28.094837	2019-12-04 15:09:28.094837
1ef93024-16eb-11ea-8a37-2ba80b829461	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee18a96-16eb-11ea-8a37-3bdb5690b745	Steady	2019-12-04 15:09:28.099277	2019-12-04 15:09:28.099277
1ef9e1b8-16eb-11ea-8a37-f7de47041745	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee6b796-16eb-11ea-8a37-4bd6be17ecbd	Steady	2019-12-04 15:09:28.103806	2019-12-04 15:09:28.103806
1efa964e-16eb-11ea-8a37-1b03ed8d289d	1ed3893c-16eb-11ea-8a37-53c677a170ca	1eeb2e5c-16eb-11ea-8a37-670ac77fc224	Steady	2019-12-04 15:09:28.108433	2019-12-04 15:09:28.108433
1efbba92-16eb-11ea-8a37-276b784c26c2	1ed3893c-16eb-11ea-8a37-53c677a170ca	1edca1a2-16eb-11ea-8a37-7b5f9a72e113	Steady	2019-12-04 15:09:28.115882	2019-12-04 15:09:28.115882
1efcdf62-16eb-11ea-8a37-4b02d22aa0e2	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee2a0a2-16eb-11ea-8a37-6bef06a966f0	Break	2019-12-04 15:09:28.123409	2019-12-04 15:09:28.123409
1efe018a-16eb-11ea-8a37-57f63162772b	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ede3076-16eb-11ea-8a37-a789ad2d62bc	Steady	2019-12-04 15:09:28.130839	2019-12-04 15:09:28.130839
1eff257e-16eb-11ea-8a37-37413b5b5cfe	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee77e2e-16eb-11ea-8a37-1f47685877b0	Steady	2019-12-04 15:09:28.138306	2019-12-04 15:09:28.138306
1f002be0-16eb-11ea-8a37-ebf3d6841629	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ee8fc5e-16eb-11ea-8a37-bbe249439dc7	Break	2019-12-04 15:09:28.145022	2019-12-04 15:09:28.145022
1f012e50-16eb-11ea-8a37-63639f37321b	1ed3893c-16eb-11ea-8a37-53c677a170ca	1edf41dc-16eb-11ea-8a37-33229f1a4517	Steady	2019-12-04 15:09:28.151643	2019-12-04 15:09:28.151643
1f0235fc-16eb-11ea-8a37-8fa5be691ce2	1ed3893c-16eb-11ea-8a37-53c677a170ca	1edb93a2-16eb-11ea-8a37-77e1fee77e2a	Steady	2019-12-04 15:09:28.158389	2019-12-04 15:09:28.158389
1f033b3c-16eb-11ea-8a37-1721bb8f2b72	1ed3893c-16eb-11ea-8a37-53c677a170ca	1eea72b4-16eb-11ea-8a37-f7303dfcf7a3	Steady	2019-12-04 15:09:28.165078	2019-12-04 15:09:28.165078
1f1b529e-16eb-11ea-8a37-db320aeecd9b	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f18ebf8-16eb-11ea-8a37-7f5e9ec15d09	Steady	2019-12-04 15:09:28.322914	2019-12-04 15:09:28.322914
1f1c7ef8-16eb-11ea-8a37-0705924c3b74	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f135148-16eb-11ea-8a37-5b74e7d6303a	Steady	2019-12-04 15:09:28.330635	2019-12-04 15:09:28.330635
1f1d9144-16eb-11ea-8a37-2f84ec7e7dad	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f140bc4-16eb-11ea-8a37-0f106e05a528	Break	2019-12-04 15:09:28.337527	2019-12-04 15:09:28.337527
1f1e9d1e-16eb-11ea-8a37-ef1c14fda44e	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f0fb9a2-16eb-11ea-8a37-37f1216c352c	Steady	2019-12-04 15:09:28.344497	2019-12-04 15:09:28.344497
1f1faefc-16eb-11ea-8a37-1706a7524314	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f1293a2-16eb-11ea-8a37-63ca9ab39390	Steady	2019-12-04 15:09:28.3515	2019-12-04 15:09:28.3515
1f20bd88-16eb-11ea-8a37-0f727d1d0f34	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f164ed4-16eb-11ea-8a37-1f16466df947	Break	2019-12-04 15:09:28.358403	2019-12-04 15:09:28.358403
1f216e7c-16eb-11ea-8a37-036968d02aee	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f11da34-16eb-11ea-8a37-5f8497e984e1	Steady	2019-12-04 15:09:28.363026	2019-12-04 15:09:28.363026
1f2217aa-16eb-11ea-8a37-2b67fb715ad8	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f1709d2-16eb-11ea-8a37-bf080f835eca	Steady	2019-12-04 15:09:28.367367	2019-12-04 15:09:28.367367
1f22d2a8-16eb-11ea-8a37-a75a59176e3c	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f10cca2-16eb-11ea-8a37-3ba99e1cc17b	Steady	2019-12-04 15:09:28.372101	2019-12-04 15:09:28.372101
1f238c84-16eb-11ea-8a37-cbaac3caf776	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f158666-16eb-11ea-8a37-530be1c24e57	Steady	2019-12-04 15:09:28.376875	2019-12-04 15:09:28.376875
1f244782-16eb-11ea-8a37-cf64ee468b0f	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f17bbc0-16eb-11ea-8a37-bb893aa401aa	Steady	2019-12-04 15:09:28.38158	2019-12-04 15:09:28.38158
1f25067c-16eb-11ea-8a37-6b69ec276544	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f14cabe-16eb-11ea-8a37-53350695c48c	Steady	2019-12-04 15:09:28.386527	2019-12-04 15:09:28.386527
1f25c4ea-16eb-11ea-8a37-777ec187afe4	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f1a2130-16eb-11ea-8a37-b7ded8febbf6	Steady	2019-12-04 15:09:28.391408	2019-12-04 15:09:28.391408
1f267a70-16eb-11ea-8a37-1735ec4a6780	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f0ea896-16eb-11ea-8a37-7ff79c2b0fb7	Steady	2019-12-04 15:09:28.396075	2019-12-04 15:09:28.396075
1f4430e2-16eb-11ea-8a37-27de9619ce59	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f33e214-16eb-11ea-8a37-b38f08b0aa5c	Steady	2019-12-04 15:09:28.590914	2019-12-04 15:09:28.590914
1f44b530-16eb-11ea-8a37-038e89e1720a	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3498b2-16eb-11ea-8a37-33fd7856753f	Steady	2019-12-04 15:09:28.59431	2019-12-04 15:09:28.59431
1f4538d4-16eb-11ea-8a37-431410089c7c	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3f0284-16eb-11ea-8a37-37b914c7859f	Steady	2019-12-04 15:09:28.597664	2019-12-04 15:09:28.597664
1f462bfe-16eb-11ea-8a37-772a64ad6808	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f4299da-16eb-11ea-8a37-2333950d14b5	Steady	2019-12-04 15:09:28.603886	2019-12-04 15:09:28.603886
1f471f82-16eb-11ea-8a37-17c4e061911a	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3dee3a-16eb-11ea-8a37-438f4acbb695	Break	2019-12-04 15:09:28.610106	2019-12-04 15:09:28.610106
1f483462-16eb-11ea-8a37-f7953f9ff9a0	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3a6fe4-16eb-11ea-8a37-c3ee700ea735	Steady	2019-12-04 15:09:28.617134	2019-12-04 15:09:28.617134
1f49450a-16eb-11ea-8a37-73bf6c34633b	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3ffa7c-16eb-11ea-8a37-c326d923f86d	Steady	2019-12-04 15:09:28.624147	2019-12-04 15:09:28.624147
1f4a4522-16eb-11ea-8a37-4b39884c28a7	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3ba49a-16eb-11ea-8a37-db457059fefd	Steady	2019-12-04 15:09:28.630636	2019-12-04 15:09:28.630636
1f4b56ce-16eb-11ea-8a37-e39218b0c21a	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f420b14-16eb-11ea-8a37-87294f3a2c7b	Steady	2019-12-04 15:09:28.637548	2019-12-04 15:09:28.637548
1f4c63c0-16eb-11ea-8a37-9ff3e3239b54	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f43abd6-16eb-11ea-8a37-23fed4aeaf0b	Steady	2019-12-04 15:09:28.644444	2019-12-04 15:09:28.644444
1f4d6f22-16eb-11ea-8a37-b325f3c2a229	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3774ce-16eb-11ea-8a37-a74bfd0b0ef1	Steady	2019-12-04 15:09:28.651313	2019-12-04 15:09:28.651313
1f4e23ea-16eb-11ea-8a37-13e6a86e6580	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f40e798-16eb-11ea-8a37-dbdb9a813486	Steady	2019-12-04 15:09:28.656003	2019-12-04 15:09:28.656003
1f4ee50a-16eb-11ea-8a37-0b468a7d7787	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f354c6c-16eb-11ea-8a37-fb7415de9118	Break	2019-12-04 15:09:28.66093	2019-12-04 15:09:28.66093
1f4f9e78-16eb-11ea-8a37-834d9bd7962c	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f3cd568-16eb-11ea-8a37-bb8dc93fc68b	Break	2019-12-04 15:09:28.6657	2019-12-04 15:09:28.6657
1f505d9a-16eb-11ea-8a37-5731673fd1d8	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f36b9da-16eb-11ea-8a37-ffb2bb0375d2	Steady	2019-12-04 15:09:28.670559	2019-12-04 15:09:28.670559
1f5115f0-16eb-11ea-8a37-076b605b25a1	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f417b22-16eb-11ea-8a37-9b921318e4eb	Steady	2019-12-04 15:09:28.675233	2019-12-04 15:09:28.675233
1f51d3e6-16eb-11ea-8a37-275b60afa1c3	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f382acc-16eb-11ea-8a37-834e33057c98	Steady	2019-12-04 15:09:28.68015	2019-12-04 15:09:28.68015
1f528f66-16eb-11ea-8a37-c39e2373f2ce	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f394c4a-16eb-11ea-8a37-23f82081f66b	Steady	2019-12-04 15:09:28.684896	2019-12-04 15:09:28.684896
1f534f5a-16eb-11ea-8a37-87609175cc80	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f432774-16eb-11ea-8a37-8b2914129ee4	Steady	2019-12-04 15:09:28.689878	2019-12-04 15:09:28.689878
1f546ea8-16eb-11ea-8a37-bf2ca0c7a8cf	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f35fd42-16eb-11ea-8a37-13d0495f7945	Steady	2019-12-04 15:09:28.697223	2019-12-04 15:09:28.697223
1f68b5c0-16eb-11ea-8a37-8f87033f9f68	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f66aa14-16eb-11ea-8a37-d3322615a704	Steady	2019-12-04 15:09:28.83013	2019-12-04 15:09:28.83013
1f69b7e0-16eb-11ea-8a37-4fca14bcc596	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f5eb390-16eb-11ea-8a37-a328d9a41224	Break	2019-12-04 15:09:28.83674	2019-12-04 15:09:28.83674
1f6abcb2-16eb-11ea-8a37-f797e38f679f	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f643d56-16eb-11ea-8a37-6f15cda6e746	Steady	2019-12-04 15:09:28.843418	2019-12-04 15:09:28.843418
1f6b7472-16eb-11ea-8a37-370ade787e3e	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f604d18-16eb-11ea-8a37-6ff338b3fa1d	Steady	2019-12-04 15:09:28.848111	2019-12-04 15:09:28.848111
1f6c294e-16eb-11ea-8a37-df5de4591b55	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f5deece-16eb-11ea-8a37-bb8c253489f9	Steady	2019-12-04 15:09:28.852748	2019-12-04 15:09:28.852748
1f6cd9b6-16eb-11ea-8a37-275062730480	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f612c42-16eb-11ea-8a37-3705be20618a	Steady	2019-12-04 15:09:28.857283	2019-12-04 15:09:28.857283
1f6d8adc-16eb-11ea-8a37-af5f2dacacec	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f67afa4-16eb-11ea-8a37-bbc8a5ab19d9	Steady	2019-12-04 15:09:28.861821	2019-12-04 15:09:28.861821
1f6e38c4-16eb-11ea-8a37-97a4bb89c636	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f5d3074-16eb-11ea-8a37-13637334e18c	Steady	2019-12-04 15:09:28.866255	2019-12-04 15:09:28.866255
1f6ee9fe-16eb-11ea-8a37-43a1228da4ab	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f5f82b6-16eb-11ea-8a37-87dfd69a63b9	Steady	2019-12-04 15:09:28.87081	2019-12-04 15:09:28.87081
1f6f9746-16eb-11ea-8a37-0fe304a79976	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f657be4-16eb-11ea-8a37-d7a6f6a3c5c3	Steady	2019-12-04 15:09:28.875246	2019-12-04 15:09:28.875246
1f704696-16eb-11ea-8a37-07b96f9b9b34	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f63079c-16eb-11ea-8a37-bb6f9db78c2d	Steady	2019-12-04 15:09:28.879719	2019-12-04 15:09:28.879719
1f7166ac-16eb-11ea-8a37-2f54821a4381	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f61e646-16eb-11ea-8a37-d75e30eeeff0	Steady	2019-12-04 15:09:28.887089	2019-12-04 15:09:28.887089
1f915872-16eb-11ea-8a37-6f45352b856e	1f729be4-16eb-11ea-8a37-f7402b31f897	1f88abaa-16eb-11ea-8a37-eb3a286425ad	Steady	2019-12-04 15:09:29.096418	2019-12-04 15:09:29.096418
1f9281c0-16eb-11ea-8a37-774e0d6ac6dc	1f729be4-16eb-11ea-8a37-f7402b31f897	1f896dce-16eb-11ea-8a37-6be5f99e56cf	Steady	2019-12-04 15:09:29.104017	2019-12-04 15:09:29.104017
1f93959c-16eb-11ea-8a37-9b2cbc9c2bd4	1f729be4-16eb-11ea-8a37-f7402b31f897	1f84b6a8-16eb-11ea-8a37-979fb94399e0	Steady	2019-12-04 15:09:29.111056	2019-12-04 15:09:29.111056
1f94a928-16eb-11ea-8a37-97aed5fe0bfc	1f729be4-16eb-11ea-8a37-f7402b31f897	1f813dc0-16eb-11ea-8a37-4b2bc0feb89e	Steady	2019-12-04 15:09:29.118121	2019-12-04 15:09:29.118121
1f95b480-16eb-11ea-8a37-57b14d03ab5c	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8aeca8-16eb-11ea-8a37-6b26604849a3	Steady	2019-12-04 15:09:29.124989	2019-12-04 15:09:29.124989
1f96bca4-16eb-11ea-8a37-d776fb5c4d61	1f729be4-16eb-11ea-8a37-f7402b31f897	1f7ee99e-16eb-11ea-8a37-d3680a3301f0	Steady	2019-12-04 15:09:29.131779	2019-12-04 15:09:29.131779
1f977356-16eb-11ea-8a37-e363b30a048d	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8ba86e-16eb-11ea-8a37-83579833a727	Break	2019-12-04 15:09:29.136431	2019-12-04 15:09:29.136431
1f983232-16eb-11ea-8a37-df478ee42a5d	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8d165e-16eb-11ea-8a37-d77fe94ad423	Break	2019-12-04 15:09:29.141338	2019-12-04 15:09:29.141338
1f98eac4-16eb-11ea-8a37-ab79f9aa3084	1f729be4-16eb-11ea-8a37-f7402b31f897	1f801184-16eb-11ea-8a37-73d47a59343e	Steady	2019-12-04 15:09:29.146044	2019-12-04 15:09:29.146044
1f99a108-16eb-11ea-8a37-6708e4922113	1f729be4-16eb-11ea-8a37-f7402b31f897	1f826452-16eb-11ea-8a37-2b6a82c4e2e2	Break	2019-12-04 15:09:29.150719	2019-12-04 15:09:29.150719
1f9a5094-16eb-11ea-8a37-bfc51f2a5db8	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8eff82-16eb-11ea-8a37-a3afeb34b4ba	Steady	2019-12-04 15:09:29.155229	2019-12-04 15:09:29.155229
1f9b0214-16eb-11ea-8a37-fb9886b659ba	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8a271e-16eb-11ea-8a37-67ffd9b9b8fb	Steady	2019-12-04 15:09:29.159775	2019-12-04 15:09:29.159775
1f9bb38a-16eb-11ea-8a37-eb38deab1879	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8c5c32-16eb-11ea-8a37-9fa076ccb419	Steady	2019-12-04 15:09:29.164317	2019-12-04 15:09:29.164317
1f9c64c4-16eb-11ea-8a37-1339e6dece8d	1f729be4-16eb-11ea-8a37-f7402b31f897	1f839c5a-16eb-11ea-8a37-435fd0bcdf5c	Steady	2019-12-04 15:09:29.168852	2019-12-04 15:09:29.168852
1f9d7efe-16eb-11ea-8a37-dfcdacdada7e	1f729be4-16eb-11ea-8a37-f7402b31f897	1f87f340-16eb-11ea-8a37-379a2c834678	Steady	2019-12-04 15:09:29.176078	2019-12-04 15:09:29.176078
1f9ea004-16eb-11ea-8a37-277e052ceb05	1f729be4-16eb-11ea-8a37-f7402b31f897	1f8dcb8a-16eb-11ea-8a37-977deb409bac	Steady	2019-12-04 15:09:29.183459	2019-12-04 15:09:29.183459
1f9fc056-16eb-11ea-8a37-f3cf35278f2e	1f729be4-16eb-11ea-8a37-f7402b31f897	1f903186-16eb-11ea-8a37-0fc916c95d29	Steady	2019-12-04 15:09:29.190855	2019-12-04 15:09:29.190855
1fa0df5e-16eb-11ea-8a37-3bdcb69e180b	1f729be4-16eb-11ea-8a37-f7402b31f897	1f85d952-16eb-11ea-8a37-5394760f3a6a	Steady	2019-12-04 15:09:29.198208	2019-12-04 15:09:29.198208
1fa1e4d0-16eb-11ea-8a37-2b384fab2644	1f729be4-16eb-11ea-8a37-f7402b31f897	1f86eb58-16eb-11ea-8a37-e3282303b2bf	Steady	2019-12-04 15:09:29.204891	2019-12-04 15:09:29.204891
1fd290da-16eb-11ea-8a37-dbc67bb08303	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fcd951c-16eb-11ea-8a37-577540c97a7b	Steady	2019-12-04 15:09:29.523851	2019-12-04 15:09:29.523851
1fd349ee-16eb-11ea-8a37-fff4888cc23a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fb9e404-16eb-11ea-8a37-0bb2e3c0d8ca	Steady	2019-12-04 15:09:29.52859	2019-12-04 15:09:29.52859
1fd402bc-16eb-11ea-8a37-838083b25c9a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc753aa-16eb-11ea-8a37-cfee37d79c0c	Steady	2019-12-04 15:09:29.533297	2019-12-04 15:09:29.533297
1fd4c29c-16eb-11ea-8a37-5f037a6a5b40	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fbd7614-16eb-11ea-8a37-f397f8946ece	Steady	2019-12-04 15:09:29.538233	2019-12-04 15:09:29.538233
1fd574da-16eb-11ea-8a37-37acc26b6384	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc3aac0-16eb-11ea-8a37-9772d94b2df2	Steady	2019-12-04 15:09:29.542805	2019-12-04 15:09:29.542805
1fd624fc-16eb-11ea-8a37-17464af2c6e4	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fd1dc8a-16eb-11ea-8a37-f7d6a6476c2f	Steady	2019-12-04 15:09:29.547314	2019-12-04 15:09:29.547314
1fd6c402-16eb-11ea-8a37-47b5af9be8a3	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fbb0b40-16eb-11ea-8a37-a396ee7c73bc	Break	2019-12-04 15:09:29.551437	2019-12-04 15:09:29.551437
1fd755a2-16eb-11ea-8a37-8bd3e367de4f	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fbc3e70-16eb-11ea-8a37-c307172732de	Steady	2019-12-04 15:09:29.555199	2019-12-04 15:09:29.555199
1fd84a2a-16eb-11ea-8a37-f318305c3d0f	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fb9296a-16eb-11ea-8a37-fb416240d2f7	Steady	2019-12-04 15:09:29.561481	2019-12-04 15:09:29.561481
1fd94876-16eb-11ea-8a37-f7f674f45374	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fb7ab08-16eb-11ea-8a37-e3633b98105f	Steady	2019-12-04 15:09:29.567995	2019-12-04 15:09:29.567995
1fda57f2-16eb-11ea-8a37-9fc88cfa130a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc516da-16eb-11ea-8a37-83667d953757	Steady	2019-12-04 15:09:29.574891	2019-12-04 15:09:29.574891
1fdb6f02-16eb-11ea-8a37-73cd941dc191	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc8ce56-16eb-11ea-8a37-9f20c69ab0c6	Steady	2019-12-04 15:09:29.58201	2019-12-04 15:09:29.58201
1fdc6d08-16eb-11ea-8a37-3bbba96fb3cc	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc69078-16eb-11ea-8a37-17617186e06e	Steady	2019-12-04 15:09:29.588533	2019-12-04 15:09:29.588533
1fdd5e7a-16eb-11ea-8a37-4bc9be3ac9c6	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc5d6d8-16eb-11ea-8a37-670bc09a0926	Steady	2019-12-04 15:09:29.594703	2019-12-04 15:09:29.594703
1fde5230-16eb-11ea-8a37-2747c9afce0a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fcb2732-16eb-11ea-8a37-cfb770dfdb2a	Steady	2019-12-04 15:09:29.600936	2019-12-04 15:09:29.600936
1fdf3db2-16eb-11ea-8a37-abe1e3ffa438	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc1eac8-16eb-11ea-8a37-8bf51ff6c3e0	Steady	2019-12-04 15:09:29.606987	2019-12-04 15:09:29.606987
1fdfc35e-16eb-11ea-8a37-cf0bfb5f4cb9	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fcfb022-16eb-11ea-8a37-139566f629e7	Steady	2019-12-04 15:09:29.610451	2019-12-04 15:09:29.610451
1fe0577e-16eb-11ea-8a37-efb99eb8a9e3	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc9f402-16eb-11ea-8a37-03c3b207ef9a	Steady	2019-12-04 15:09:29.614232	2019-12-04 15:09:29.614232
1fe0dca8-16eb-11ea-8a37-af7dcaca3fdb	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fb6f71c-16eb-11ea-8a37-fb56dbe5c3a7	Steady	2019-12-04 15:09:29.617646	2019-12-04 15:09:29.617646
1fe161be-16eb-11ea-8a37-eba2f15d4a6d	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc8188a-16eb-11ea-8a37-bf1fbae866e7	Steady	2019-12-04 15:09:29.621073	2019-12-04 15:09:29.621073
1fe1e1de-16eb-11ea-8a37-b75ef12ca6b0	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fcea376-16eb-11ea-8a37-5312f79197da	Steady	2019-12-04 15:09:29.624364	2019-12-04 15:09:29.624364
1fe2642e-16eb-11ea-8a37-c3947e95d0b6	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fb86f5c-16eb-11ea-8a37-5f7fcdc768dd	Break	2019-12-04 15:09:29.62768	2019-12-04 15:09:29.62768
1fe2e0a2-16eb-11ea-8a37-03e0c1f91824	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fbfbd70-16eb-11ea-8a37-bb861c8e7267	Steady	2019-12-04 15:09:29.63089	2019-12-04 15:09:29.63089
1fe35cd0-16eb-11ea-8a37-afcfafb2d741	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fbea412-16eb-11ea-8a37-cfc67a461eb9	Break	2019-12-04 15:09:29.634075	2019-12-04 15:09:29.634075
1fe44384-16eb-11ea-8a37-9fbb59d824c2	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fcc61c4-16eb-11ea-8a37-b323822c9cbe	Steady	2019-12-04 15:09:29.639976	2019-12-04 15:09:29.639976
1fe530c8-16eb-11ea-8a37-5fb8b3972015	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc0d994-16eb-11ea-8a37-77d7d1b1d7f4	Steady	2019-12-04 15:09:29.646015	2019-12-04 15:09:29.646015
1fe6242e-16eb-11ea-8a37-2fc3597988c6	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc2f4f4-16eb-11ea-8a37-43e74cad2e96	Steady	2019-12-04 15:09:29.65226	2019-12-04 15:09:29.65226
1fe70cfe-16eb-11ea-8a37-f7167022969c	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fd0c8ea-16eb-11ea-8a37-cb3020d826d3	Steady	2019-12-04 15:09:29.658248	2019-12-04 15:09:29.658248
1fe7dd46-16eb-11ea-8a37-5f18ae52d703	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fc45a74-16eb-11ea-8a37-7338ada27422	Steady	2019-12-04 15:09:29.663573	2019-12-04 15:09:29.663573
200839e2-16eb-11ea-8a37-ef61b5cc1a77	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffea9e0-16eb-11ea-8a37-9b80b7538fc1	Steady	2019-12-04 15:09:29.875516	2019-12-04 15:09:29.875516
200929ba-16eb-11ea-8a37-57eb5612c997	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffc86b0-16eb-11ea-8a37-2ff6057fab78	Steady	2019-12-04 15:09:29.881665	2019-12-04 15:09:29.881665
2009ed46-16eb-11ea-8a37-4faa5815611f	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1fff5f84-16eb-11ea-8a37-eb778000f383	Steady	2019-12-04 15:09:29.886657	2019-12-04 15:09:29.886657
200aa5b0-16eb-11ea-8a37-e384f66a6a47	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffa5372-16eb-11ea-8a37-9324a005e6a0	Break	2019-12-04 15:09:29.891395	2019-12-04 15:09:29.891395
200b5bae-16eb-11ea-8a37-5bc1d6ade19a	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff761bc-16eb-11ea-8a37-77dd5530125a	Steady	2019-12-04 15:09:29.896063	2019-12-04 15:09:29.896063
200c13e6-16eb-11ea-8a37-03235d16b093	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1fef6a2a-16eb-11ea-8a37-f3650aae285d	Steady	2019-12-04 15:09:29.90077	2019-12-04 15:09:29.90077
200cc1ba-16eb-11ea-8a37-f3d96e5920fb	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff20af0-16eb-11ea-8a37-af5a045d3aef	Steady	2019-12-04 15:09:29.905224	2019-12-04 15:09:29.905224
200df0a8-16eb-11ea-8a37-df5ed2b9597e	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffdf392-16eb-11ea-8a37-4ba116dad690	Break	2019-12-04 15:09:29.912902	2019-12-04 15:09:29.912902
200f1f78-16eb-11ea-8a37-f75e59d0da3a	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff326ec-16eb-11ea-8a37-67a783512f46	Steady	2019-12-04 15:09:29.920674	2019-12-04 15:09:29.920674
2010434e-16eb-11ea-8a37-571f087aebff	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff56218-16eb-11ea-8a37-f33c2bbc0ea0	Steady	2019-12-04 15:09:29.928173	2019-12-04 15:09:29.928173
20114b7c-16eb-11ea-8a37-6f34c5cbca5e	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffbcbb2-16eb-11ea-8a37-7312cb6f8f9e	Steady	2019-12-04 15:09:29.935025	2019-12-04 15:09:29.935025
20122b78-16eb-11ea-8a37-47f1c949cfc0	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	2005593e-16eb-11ea-8a37-ebb7c5b259a9	Steady	2019-12-04 15:09:29.940785	2019-12-04 15:09:29.940785
20130e4e-16eb-11ea-8a37-5f42822b7c3d	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	200199ca-16eb-11ea-8a37-9b2aac82f465	Steady	2019-12-04 15:09:29.946612	2019-12-04 15:09:29.946612
2013ec1a-16eb-11ea-8a37-d3da12ce00d4	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff0ea58-16eb-11ea-8a37-2b0da36793f5	Steady	2019-12-04 15:09:29.952295	2019-12-04 15:09:29.952295
2014bf5a-16eb-11ea-8a37-23dc6f53a6b7	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffb0d4e-16eb-11ea-8a37-037640923cde	Steady	2019-12-04 15:09:29.9577	2019-12-04 15:09:29.9577
20156ba8-16eb-11ea-8a37-b315622af074	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff02ee2-16eb-11ea-8a37-df1d0f44643d	Steady	2019-12-04 15:09:29.962014	2019-12-04 15:09:29.962014
20162c1e-16eb-11ea-8a37-7fab6a10a40d	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	20063854-16eb-11ea-8a37-47fbeecaf125	Steady	2019-12-04 15:09:29.966909	2019-12-04 15:09:29.966909
2016e5be-16eb-11ea-8a37-472006704f37	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	20025ef0-16eb-11ea-8a37-871697acc723	Steady	2019-12-04 15:09:29.971678	2019-12-04 15:09:29.971678
20179cca-16eb-11ea-8a37-23bf3cb0e8c0	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	2000137a-16eb-11ea-8a37-5f5cc6241f59	Steady	2019-12-04 15:09:29.976368	2019-12-04 15:09:29.976368
201852d2-16eb-11ea-8a37-03e4fcdd5490	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	20032a6a-16eb-11ea-8a37-f7fad83a0f3b	Steady	2019-12-04 15:09:29.981	2019-12-04 15:09:29.981
20190574-16eb-11ea-8a37-cbd57fed95e0	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff661cc-16eb-11ea-8a37-2f774f06a3dd	Steady	2019-12-04 15:09:29.985576	2019-12-04 15:09:29.985576
2019c50e-16eb-11ea-8a37-33da702e45ad	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff94d74-16eb-11ea-8a37-d30a78647159	Steady	2019-12-04 15:09:29.9905	2019-12-04 15:09:29.9905
201a7d96-16eb-11ea-8a37-a7627b4c4c80	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	2000d418-16eb-11ea-8a37-2f1660c7010c	Steady	2019-12-04 15:09:29.99521	2019-12-04 15:09:29.99521
201ba914-16eb-11ea-8a37-43e34127cacb	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ffd3de4-16eb-11ea-8a37-13abfb167177	Steady	2019-12-04 15:09:30.002884	2019-12-04 15:09:30.002884
201cd848-16eb-11ea-8a37-df95b676c54e	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1ff447d4-16eb-11ea-8a37-2f96016eb8bd	Break	2019-12-04 15:09:30.010635	2019-12-04 15:09:30.010635
201e0178-16eb-11ea-8a37-9316fb05ea17	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	200737c2-16eb-11ea-8a37-2fd0f1471b53	Steady	2019-12-04 15:09:30.018217	2019-12-04 15:09:30.018217
201f25d0-16eb-11ea-8a37-f39f9a813571	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	2003ed06-16eb-11ea-8a37-73bb7336c326	Steady	2019-12-04 15:09:30.02575	2019-12-04 15:09:30.02575
2049dcee-16eb-11ea-8a37-e345db91a639	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203c5cf4-16eb-11ea-8a37-b74f62c8f0cd	Break	2019-12-04 15:09:30.30581	2019-12-04 15:09:30.30581
204ab0f6-16eb-11ea-8a37-4bc1e71992c1	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2032f060-16eb-11ea-8a37-07d5350d35d3	Steady	2019-12-04 15:09:30.311233	2019-12-04 15:09:30.311233
204b8c4c-16eb-11ea-8a37-47ff06650da4	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203f6fd4-16eb-11ea-8a37-8b8cf09e1a5d	Steady	2019-12-04 15:09:30.316864	2019-12-04 15:09:30.316864
204c1bd0-16eb-11ea-8a37-4b3f08691176	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20450052-16eb-11ea-8a37-ab676aae841e	Steady	2019-12-04 15:09:30.320548	2019-12-04 15:09:30.320548
204ca5f0-16eb-11ea-8a37-37d9b4dbfe20	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20461b18-16eb-11ea-8a37-d73eeadcd195	Steady	2019-12-04 15:09:30.324084	2019-12-04 15:09:30.324084
204d3a7e-16eb-11ea-8a37-afa1645b1c25	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2035bdea-16eb-11ea-8a37-d7492deaa959	Break	2019-12-04 15:09:30.327884	2019-12-04 15:09:30.327884
204dbf4e-16eb-11ea-8a37-973e4e01ea6d	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203d3232-16eb-11ea-8a37-67195a4f528b	Steady	2019-12-04 15:09:30.331277	2019-12-04 15:09:30.331277
204e42a2-16eb-11ea-8a37-33093b723b1e	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2034af22-16eb-11ea-8a37-d7d6751e9438	Steady	2019-12-04 15:09:30.334634	2019-12-04 15:09:30.334634
204ec2a4-16eb-11ea-8a37-73cf403c6fee	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20341d14-16eb-11ea-8a37-03e3576a589a	Steady	2019-12-04 15:09:30.337918	2019-12-04 15:09:30.337918
204f3fcc-16eb-11ea-8a37-1fbeada759f5	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2040e90e-16eb-11ea-8a37-0713366dd0cb	Steady	2019-12-04 15:09:30.341125	2019-12-04 15:09:30.341125
204fbf2e-16eb-11ea-8a37-939b023466cb	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20324fc0-16eb-11ea-8a37-1fad73a2e1d3	Steady	2019-12-04 15:09:30.344375	2019-12-04 15:09:30.344375
2050df58-16eb-11ea-8a37-9b34a7b8a7fc	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203537a8-16eb-11ea-8a37-0b7a4699e184	Steady	2019-12-04 15:09:30.351616	2019-12-04 15:09:30.351616
20520702-16eb-11ea-8a37-db209dcb617a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20338840-16eb-11ea-8a37-c3f8d1055c02	Steady	2019-12-04 15:09:30.359206	2019-12-04 15:09:30.359206
205332b2-16eb-11ea-8a37-531d12feb50c	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2039b292-16eb-11ea-8a37-872a73344b2c	Steady	2019-12-04 15:09:30.36688	2019-12-04 15:09:30.36688
20545714-16eb-11ea-8a37-33d033faa2ca	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20472800-16eb-11ea-8a37-2f3a99b8a2bf	Steady	2019-12-04 15:09:30.374364	2019-12-04 15:09:30.374364
20556384-16eb-11ea-8a37-675c6231cbf5	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2038b8ba-16eb-11ea-8a37-93ea2d921216	Steady	2019-12-04 15:09:30.381233	2019-12-04 15:09:30.381233
20566e00-16eb-11ea-8a37-17b6854b1cc6	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20402f50-16eb-11ea-8a37-7fb857f87054	Steady	2019-12-04 15:09:30.388049	2019-12-04 15:09:30.388049
2057723c-16eb-11ea-8a37-63fe1cbe5b0d	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2043cd9a-16eb-11ea-8a37-53ddec0559ee	Break	2019-12-04 15:09:30.394694	2019-12-04 15:09:30.394694
20587f1a-16eb-11ea-8a37-8b19f878f54f	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20482bd8-16eb-11ea-8a37-9f227cd5ca7a	Steady	2019-12-04 15:09:30.401527	2019-12-04 15:09:30.401527
20593fea-16eb-11ea-8a37-ebc37a53a462	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203eb666-16eb-11ea-8a37-37a1c8ed65c2	Steady	2019-12-04 15:09:30.406535	2019-12-04 15:09:30.406535
2059fc82-16eb-11ea-8a37-33a94d101bfa	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203aa6b6-16eb-11ea-8a37-47f99332392e	Steady	2019-12-04 15:09:30.411345	2019-12-04 15:09:30.411345
205abeba-16eb-11ea-8a37-4bb8a7194d0b	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2049031e-16eb-11ea-8a37-f36debba5d79	Steady	2019-12-04 15:09:30.416271	2019-12-04 15:09:30.416271
205b7d46-16eb-11ea-8a37-2f469f541f34	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203e0b1c-16eb-11ea-8a37-6bc7e2fb27b5	Steady	2019-12-04 15:09:30.421212	2019-12-04 15:09:30.421212
205c37a4-16eb-11ea-8a37-436701c74004	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20430c5c-16eb-11ea-8a37-eb7accacd942	Break	2019-12-04 15:09:30.425991	2019-12-04 15:09:30.425991
205ce820-16eb-11ea-8a37-03ad3da490af	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2037c02c-16eb-11ea-8a37-4f38ed7a4eab	Steady	2019-12-04 15:09:30.430513	2019-12-04 15:09:30.430513
205d94a0-16eb-11ea-8a37-6b0a77e4119d	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20425654-16eb-11ea-8a37-c7e903250cee	Steady	2019-12-04 15:09:30.434932	2019-12-04 15:09:30.434932
205e444a-16eb-11ea-8a37-334b4686921b	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20419d90-16eb-11ea-8a37-5fcc2a1b4d63	Steady	2019-12-04 15:09:30.43942	2019-12-04 15:09:30.43942
205f7518-16eb-11ea-8a37-7b7b82ef269e	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20364242-16eb-11ea-8a37-171c11d98981	Break	2019-12-04 15:09:30.447203	2019-12-04 15:09:30.447203
2060a4d8-16eb-11ea-8a37-df546c9dac70	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2036c9e2-16eb-11ea-8a37-1b58c221a79a	Steady	2019-12-04 15:09:30.454961	2019-12-04 15:09:30.454961
2061ce62-16eb-11ea-8a37-a7c1dfab865c	20203966-16eb-11ea-8a37-1f6f4f9c48ae	203b82c0-16eb-11ea-8a37-43ad06841760	Steady	2019-12-04 15:09:30.462591	2019-12-04 15:09:30.462591
2071c182-16eb-11ea-8a37-4facd4b9cf25	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206f72b0-16eb-11ea-8a37-8ff96ee011a9	Break	2019-12-04 15:09:30.567126	2019-12-04 15:09:30.567126
2072cab4-16eb-11ea-8a37-fbf4428892e0	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206e44d0-16eb-11ea-8a37-47fc9f7c57bf	Steady	2019-12-04 15:09:30.573905	2019-12-04 15:09:30.573905
2073d792-16eb-11ea-8a37-b31ffaf23948	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20709a14-16eb-11ea-8a37-9f82002a0ac9	Steady	2019-12-04 15:09:30.580759	2019-12-04 15:09:30.580759
2074dc82-16eb-11ea-8a37-7fdc659e58cf	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206afdf2-16eb-11ea-8a37-cbc30fb64c15	Steady	2019-12-04 15:09:30.587443	2019-12-04 15:09:30.587443
2075e65e-16eb-11ea-8a37-670bcd8eba38	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206d1a7e-16eb-11ea-8a37-7f5bb3bc8d4d	Steady	2019-12-04 15:09:30.594297	2019-12-04 15:09:30.594297
2076a026-16eb-11ea-8a37-9bead8d95d10	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206c66ce-16eb-11ea-8a37-ef12141e9dcc	Steady	2019-12-04 15:09:30.599045	2019-12-04 15:09:30.599045
20775d36-16eb-11ea-8a37-3f81fd529463	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206a4f2e-16eb-11ea-8a37-0f7a8361785d	Steady	2019-12-04 15:09:30.60388	2019-12-04 15:09:30.60388
207819e2-16eb-11ea-8a37-53b372259d1e	20630ebc-16eb-11ea-8a37-af1c14cc01bc	206bb63e-16eb-11ea-8a37-7fc5cdb2b32f	Break	2019-12-04 15:09:30.608709	2019-12-04 15:09:30.608709
20855cd8-16eb-11ea-8a37-0bc22ea8d3f3	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207f4050-16eb-11ea-8a37-2767984dd5ee	Steady	2019-12-04 15:09:30.695623	2019-12-04 15:09:30.695623
2086203c-16eb-11ea-8a37-8707b19691d6	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	208183d8-16eb-11ea-8a37-1f983e10a156	Steady	2019-12-04 15:09:30.700596	2019-12-04 15:09:30.700596
2086e13e-16eb-11ea-8a37-bbe8996184b4	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207bc4c0-16eb-11ea-8a37-2fbfa435fa6f	Steady	2019-12-04 15:09:30.705487	2019-12-04 15:09:30.705487
20879fac-16eb-11ea-8a37-e3281057fe83	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207e143c-16eb-11ea-8a37-e75d5fb4b19b	Steady	2019-12-04 15:09:30.710443	2019-12-04 15:09:30.710443
2088535c-16eb-11ea-8a37-571e60889fae	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	208286f2-16eb-11ea-8a37-6f9859722662	Steady	2019-12-04 15:09:30.715049	2019-12-04 15:09:30.715049
208905cc-16eb-11ea-8a37-77f3638a12e8	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	2083992a-16eb-11ea-8a37-b79143afe011	Steady	2019-12-04 15:09:30.719612	2019-12-04 15:09:30.719612
2089b88c-16eb-11ea-8a37-f3a9ffe21724	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207cebf2-16eb-11ea-8a37-0f2d936d9e84	Steady	2019-12-04 15:09:30.724191	2019-12-04 15:09:30.724191
208a6ba6-16eb-11ea-8a37-03e61c77254e	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	20807164-16eb-11ea-8a37-bf2673973efc	Steady	2019-12-04 15:09:30.728778	2019-12-04 15:09:30.728778
208b94f4-16eb-11ea-8a37-abfe1c8b481b	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	20849cc6-16eb-11ea-8a37-6b5d67702bf7	Break	2019-12-04 15:09:30.736383	2019-12-04 15:09:30.736383
20a82b50-16eb-11ea-8a37-6fece8c8cbc5	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2097201c-16eb-11ea-8a37-9f7d47d97f1e	Steady	2019-12-04 15:09:30.923729	2019-12-04 15:09:30.923729
20a958c2-16eb-11ea-8a37-6330bd0ef384	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2097dd0e-16eb-11ea-8a37-274497e47430	Steady	2019-12-04 15:09:30.931424	2019-12-04 15:09:30.931424
20aa883c-16eb-11ea-8a37-978986bf1ed9	208ccf18-16eb-11ea-8a37-cfe47cc0feee	209f1a1a-16eb-11ea-8a37-7b13aab7a46a	Steady	2019-12-04 15:09:30.939187	2019-12-04 15:09:30.939187
20abbea0-16eb-11ea-8a37-9b301c51ed62	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a772be-16eb-11ea-8a37-6f61be4806a4	Steady	2019-12-04 15:09:30.947111	2019-12-04 15:09:30.947111
20acf5ae-16eb-11ea-8a37-afcc1c439b9a	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a5f650-16eb-11ea-8a37-7f8bc3401ccf	Steady	2019-12-04 15:09:30.955064	2019-12-04 15:09:30.955064
20ae02dc-16eb-11ea-8a37-4384240209e9	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a47942-16eb-11ea-8a37-3b54fc0bc4b5	Steady	2019-12-04 15:09:30.96201	2019-12-04 15:09:30.96201
20af0aba-16eb-11ea-8a37-cb35b71598c1	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a1262a-16eb-11ea-8a37-b7e95157d68b	Steady	2019-12-04 15:09:30.96876	2019-12-04 15:09:30.96876
20b009c4-16eb-11ea-8a37-af3b566cadab	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a02202-16eb-11ea-8a37-63fc3d9a1bdf	Steady	2019-12-04 15:09:30.975295	2019-12-04 15:09:30.975295
20b10a36-16eb-11ea-8a37-efad34ec3486	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20989b22-16eb-11ea-8a37-ef27f1d921d4	Steady	2019-12-04 15:09:30.981834	2019-12-04 15:09:30.981834
20b1ca2a-16eb-11ea-8a37-db9935567b98	208ccf18-16eb-11ea-8a37-cfe47cc0feee	209a8496-16eb-11ea-8a37-630a0c8b6de8	Steady	2019-12-04 15:09:30.986779	2019-12-04 15:09:30.986779
20b28c58-16eb-11ea-8a37-53c51532e8c4	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a3b7fa-16eb-11ea-8a37-8f117560a828	Steady	2019-12-04 15:09:30.991733	2019-12-04 15:09:30.991733
20b34382-16eb-11ea-8a37-5f53fe5d7141	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a6b3c4-16eb-11ea-8a37-e7c8146e44d8	Steady	2019-12-04 15:09:30.996445	2019-12-04 15:09:30.996445
20b3fb24-16eb-11ea-8a37-4771fa1032ce	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20995404-16eb-11ea-8a37-536731d04b07	Break	2019-12-04 15:09:31.00115	2019-12-04 15:09:31.00115
20b4b942-16eb-11ea-8a37-b7502549e3d3	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a2f450-16eb-11ea-8a37-43c1cb4d848a	Steady	2019-12-04 15:09:31.006011	2019-12-04 15:09:31.006011
20b57062-16eb-11ea-8a37-77fcb83a558b	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a53bf2-16eb-11ea-8a37-8f0cf3a96866	Break	2019-12-04 15:09:31.010706	2019-12-04 15:09:31.010706
20b629d0-16eb-11ea-8a37-97cf03ccaa6d	208ccf18-16eb-11ea-8a37-cfe47cc0feee	20a22f48-16eb-11ea-8a37-5f7a686fadf0	Steady	2019-12-04 15:09:31.015405	2019-12-04 15:09:31.015405
20b6eb68-16eb-11ea-8a37-c3aa81e3da08	208ccf18-16eb-11ea-8a37-cfe47cc0feee	209e09ae-16eb-11ea-8a37-674fc92d4d0f	Steady	2019-12-04 15:09:31.020344	2019-12-04 15:09:31.020344
20b816fa-16eb-11ea-8a37-bb4e19e89e5d	208ccf18-16eb-11ea-8a37-cfe47cc0feee	209bb0b4-16eb-11ea-8a37-370c48366b4a	Steady	2019-12-04 15:09:31.028061	2019-12-04 15:09:31.028061
20b94228-16eb-11ea-8a37-9f68feaf4889	208ccf18-16eb-11ea-8a37-cfe47cc0feee	209cdd86-16eb-11ea-8a37-835b02d8d9c2	Steady	2019-12-04 15:09:31.035723	2019-12-04 15:09:31.035723
20c852ea-16eb-11ea-8a37-dfabfae33ac7	20ba8084-16eb-11ea-8a37-cb38a312de67	20c52a66-16eb-11ea-8a37-67581f6554cc	Steady	2019-12-04 15:09:31.134458	2019-12-04 15:09:31.134458
20c985ac-16eb-11ea-8a37-c74510e7d96f	20ba8084-16eb-11ea-8a37-cb38a312de67	20c170e2-16eb-11ea-8a37-7bfac432f22a	Steady	2019-12-04 15:09:31.142311	2019-12-04 15:09:31.142311
20cab936-16eb-11ea-8a37-cbc75f59c449	20ba8084-16eb-11ea-8a37-cb38a312de67	20c3af2e-16eb-11ea-8a37-53d28125615c	Steady	2019-12-04 15:09:31.150146	2019-12-04 15:09:31.150146
20cbcd76-16eb-11ea-8a37-a348204588a2	20ba8084-16eb-11ea-8a37-cb38a312de67	20c46a90-16eb-11ea-8a37-7387767e0f7c	Break	2019-12-04 15:09:31.157232	2019-12-04 15:09:31.157232
20cce076-16eb-11ea-8a37-8729e0acc83c	20ba8084-16eb-11ea-8a37-cb38a312de67	20c71cea-16eb-11ea-8a37-b7f83bddce84	Steady	2019-12-04 15:09:31.164293	2019-12-04 15:09:31.164293
20cddff8-16eb-11ea-8a37-d793edaa429b	20ba8084-16eb-11ea-8a37-cb38a312de67	20c2f5b6-16eb-11ea-8a37-5ffd3a08d1c2	Break	2019-12-04 15:09:31.170829	2019-12-04 15:09:31.170829
20cedee4-16eb-11ea-8a37-cb3bb2b2996c	20ba8084-16eb-11ea-8a37-cb38a312de67	20c5f0ea-16eb-11ea-8a37-97b4bb999637	Steady	2019-12-04 15:09:31.177352	2019-12-04 15:09:31.177352
20cfa540-16eb-11ea-8a37-77c34a4b2b5d	20ba8084-16eb-11ea-8a37-cb38a312de67	20c23b76-16eb-11ea-8a37-57f1ab9ee910	Steady	2019-12-04 15:09:31.182403	2019-12-04 15:09:31.182403
\.


--
-- Data for Name: program_sequence_chord; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence_chord (id, program_id, program_sequence_id, name, "position", created_at, updated_at) FROM stdin;
1aa69aa2-16eb-11ea-8a37-9fa74045ba2e	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa4e7de-16eb-11ea-8a37-6fc52690cb46	Gsus4/A	0	2019-12-04 15:09:20.846571	2019-12-04 15:09:20.846571
1aa7aa8c-16eb-11ea-8a37-9f50d766c588	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Bbmaj7add9	19.5	2019-12-04 15:09:20.853871	2019-12-04 15:09:20.853871
1aa8f91e-16eb-11ea-8a37-9b5945827326	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	G-7	1.5	2019-12-04 15:09:20.862443	2019-12-04 15:09:20.862443
1aaa4878-16eb-11ea-8a37-bb77790d958f	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	Fsus2/A	8	2019-12-04 15:09:20.871018	2019-12-04 15:09:20.871018
1aab9926-16eb-11ea-8a37-9bc1e33fd847	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Fadd9/D	11.5	2019-12-04 15:09:20.8796	2019-12-04 15:09:20.8796
1aace4c0-16eb-11ea-8a37-e75c3686e156	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	C/D	24	2019-12-04 15:09:20.888248	2019-12-04 15:09:20.888248
1aae05f8-16eb-11ea-8a37-57f151a99622	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	G-7/C	25.5	2019-12-04 15:09:20.895669	2019-12-04 15:09:20.895669
1aaf23fc-16eb-11ea-8a37-4fe27c30ca22	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	G-7	16	2019-12-04 15:09:20.902975	2019-12-04 15:09:20.902975
1ab04f16-16eb-11ea-8a37-d798f00e1c76	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Fmaj7add9	0	2019-12-04 15:09:20.910649	2019-12-04 15:09:20.910649
1ab16d10-16eb-11ea-8a37-fb7e51762c41	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	Bbmaj7add9	9.5	2019-12-04 15:09:20.918068	2019-12-04 15:09:20.918068
1ab21a9e-16eb-11ea-8a37-7ba2295d34da	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Fadd4/G	25.5	2019-12-04 15:09:20.922607	2019-12-04 15:09:20.922607
1ab2bfa8-16eb-11ea-8a37-f7b08a151fdb	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa3537e-16eb-11ea-8a37-3f78668e99c6	D-7add9	0	2019-12-04 15:09:20.926857	2019-12-04 15:09:20.926857
1ab364ee-16eb-11ea-8a37-d3aca8c58b86	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Gsus4/A	3.5	2019-12-04 15:09:20.931078	2019-12-04 15:09:20.931078
1ab4073c-16eb-11ea-8a37-93162e696118	1aa1ad62-16eb-11ea-8a37-e3635cda90ac	1aa41bec-16eb-11ea-8a37-cb001de521d8	Cmaj6	7.5	2019-12-04 15:09:20.935231	2019-12-04 15:09:20.935231
1adb125a-16eb-11ea-8a37-4f7da40b7d7f	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	A-7	4	2019-12-04 15:09:21.190995	2019-12-04 15:09:21.190995
1adc6be6-16eb-11ea-8a37-af215593fafa	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	E-7	8	2019-12-04 15:09:21.19982	2019-12-04 15:09:21.19982
1add51b4-16eb-11ea-8a37-ab5cbae00c67	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	Fmaj6	12	2019-12-04 15:09:21.205708	2019-12-04 15:09:21.205708
1ade1798-16eb-11ea-8a37-97b15f799139	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	C	16	2019-12-04 15:09:21.210795	2019-12-04 15:09:21.210795
1adedc0a-16eb-11ea-8a37-b732220efa6d	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	D-7	24	2019-12-04 15:09:21.215818	2019-12-04 15:09:21.215818
1adfa1b2-16eb-11ea-8a37-df6537dcadaf	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	A-7	20	2019-12-04 15:09:21.220887	2019-12-04 15:09:21.220887
1ae065ca-16eb-11ea-8a37-3b414cb1935d	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	F/G	29.5	2019-12-04 15:09:21.225893	2019-12-04 15:09:21.225893
1ae19cc4-16eb-11ea-8a37-4bab5283bff2	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	Fmaj6	27.5	2019-12-04 15:09:21.233857	2019-12-04 15:09:21.233857
1ae2d472-16eb-11ea-8a37-573ded3f6d32	1ad8543e-16eb-11ea-8a37-d3089a6baf4d	1ada479e-16eb-11ea-8a37-335205636a25	C	0	2019-12-04 15:09:21.241839	2019-12-04 15:09:21.241839
1b08af8a-16eb-11ea-8a37-6f60fe2bc4a4	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	Eb	8	2019-12-04 15:09:21.49007	2019-12-04 15:09:21.49007
1b09adf4-16eb-11ea-8a37-33c113855d9c	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	G-	4	2019-12-04 15:09:21.496588	2019-12-04 15:09:21.496588
1b0aa308-16eb-11ea-8a37-43c5816bda67	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	Eb	24	2019-12-04 15:09:21.50286	2019-12-04 15:09:21.50286
1b0b7c24-16eb-11ea-8a37-e72a2aa0457b	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	Fsus4	1.5	2019-12-04 15:09:21.508416	2019-12-04 15:09:21.508416
1b0c53ec-16eb-11ea-8a37-7bac69d0acae	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	C-	16	2019-12-04 15:09:21.513916	2019-12-04 15:09:21.513916
1b0d2b1e-16eb-11ea-8a37-f7b3dc13ef33	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	G-	20	2019-12-04 15:09:21.519432	2019-12-04 15:09:21.519432
1b0e2dfc-16eb-11ea-8a37-e7afe97626d2	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	F	0	2019-12-04 15:09:21.525942	2019-12-04 15:09:21.525942
1b0ef5fc-16eb-11ea-8a37-cf4edd9e58cc	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	Fsus4	1.5	2019-12-04 15:09:21.531068	2019-12-04 15:09:21.531068
1b0fbd7a-16eb-11ea-8a37-cb240578eb60	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	Bb	16	2019-12-04 15:09:21.536165	2019-12-04 15:09:21.536165
1b10871e-16eb-11ea-8a37-33409a48d823	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	G-	20	2019-12-04 15:09:21.541314	2019-12-04 15:09:21.541314
1b115266-16eb-11ea-8a37-b358d4f4e1f0	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	D-	4	2019-12-04 15:09:21.546519	2019-12-04 15:09:21.546519
1b121606-16eb-11ea-8a37-ff27d4b44812	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	Eb	24	2019-12-04 15:09:21.551543	2019-12-04 15:09:21.551543
1b12d79e-16eb-11ea-8a37-cf5dcfb6ac6a	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06acf8-16eb-11ea-8a37-bb222eefaad5	D-	0	2019-12-04 15:09:21.556483	2019-12-04 15:09:21.556483
1b139508-16eb-11ea-8a37-a7873f22d42e	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b06277e-16eb-11ea-8a37-dff953bf0d2f	D-	0	2019-12-04 15:09:21.561347	2019-12-04 15:09:21.561347
1b145ccc-16eb-11ea-8a37-4370694d65e8	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	Eb	8	2019-12-04 15:09:21.566425	2019-12-04 15:09:21.566425
1b159a1a-16eb-11ea-8a37-c7aa8e6ead84	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b05a1c8-16eb-11ea-8a37-b33d735b96f3	Bb	12	2019-12-04 15:09:21.574575	2019-12-04 15:09:21.574575
1b16d77c-16eb-11ea-8a37-03c2db238018	1b048734-16eb-11ea-8a37-eb0f9b6b1f89	1b07add8-16eb-11ea-8a37-23837b49d45a	Bb	0	2019-12-04 15:09:21.582638	2019-12-04 15:09:21.582638
1b5afc04-16eb-11ea-8a37-ebb2620e2b02	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Bb-	32	2019-12-04 15:09:22.029287	2019-12-04 15:09:22.029287
1b5bc81e-16eb-11ea-8a37-370cea456e6e	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Abmaj6/9	8	2019-12-04 15:09:22.034495	2019-12-04 15:09:22.034495
1b5c8d9e-16eb-11ea-8a37-17e8e939c0e8	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	F	60	2019-12-04 15:09:22.039549	2019-12-04 15:09:22.039549
1b5d4ffe-16eb-11ea-8a37-07e3ea3fb04c	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Gbmaj7	16	2019-12-04 15:09:22.04454	2019-12-04 15:09:22.04454
1b5e18c6-16eb-11ea-8a37-6ba64699066a	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Db	24	2019-12-04 15:09:22.049656	2019-12-04 15:09:22.049656
1b5ede78-16eb-11ea-8a37-578bc1e46ec6	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b596eac-16eb-11ea-8a37-b38fc0bda9d3	Bb-	0	2019-12-04 15:09:22.054752	2019-12-04 15:09:22.054752
1b5fa100-16eb-11ea-8a37-9f4020557e6d	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Abmaj6/9	40	2019-12-04 15:09:22.0597	2019-12-04 15:09:22.0597
1b60d002-16eb-11ea-8a37-1be6403786d1	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Bb-	0	2019-12-04 15:09:22.06749	2019-12-04 15:09:22.06749
1b620184-16eb-11ea-8a37-df8be9807845	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Gbmaj7	48	2019-12-04 15:09:22.075312	2019-12-04 15:09:22.075312
1b633c34-16eb-11ea-8a37-1f737f6cb3a1	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b585878-16eb-11ea-8a37-177d78dceb2a	Bb-	0	2019-12-04 15:09:22.0833	2019-12-04 15:09:22.0833
1b647464-16eb-11ea-8a37-0336d9ad3c0b	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Eb-	28	2019-12-04 15:09:22.091353	2019-12-04 15:09:22.091353
1b6588fe-16eb-11ea-8a37-97dd8e294dac	1b561f0e-16eb-11ea-8a37-2373d7d5daa1	1b5a3a62-16eb-11ea-8a37-9b4fd9d6832b	Fsus4	56	2019-12-04 15:09:22.098434	2019-12-04 15:09:22.098434
1b82c0c2-16eb-11ea-8a37-1bd052ba305a	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Dbsus2/F	3.5	2019-12-04 15:09:22.289911	2019-12-04 15:09:22.289911
1b83cf26-16eb-11ea-8a37-63ac6388584b	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Dbsus2/F	19.5	2019-12-04 15:09:22.296805	2019-12-04 15:09:22.296805
1b84e532-16eb-11ea-8a37-ef16db6636a2	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Dbadd9	27.5	2019-12-04 15:09:22.303956	2019-12-04 15:09:22.303956
1b85f1b6-16eb-11ea-8a37-f7e217d75372	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	Gb/Ab	4	2019-12-04 15:09:22.310823	2019-12-04 15:09:22.310823
1b86ffac-16eb-11ea-8a37-5f536a06b4ea	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Eb-7add11	7.5	2019-12-04 15:09:22.317733	2019-12-04 15:09:22.317733
1b87ce3c-16eb-11ea-8a37-232d1283a383	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Gbmaj7/Ab	23.5	2019-12-04 15:09:22.323038	2019-12-04 15:09:22.323038
1b8890a6-16eb-11ea-8a37-8b24a34cefcb	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Gbmaj7	0	2019-12-04 15:09:22.327995	2019-12-04 15:09:22.327995
1b89564e-16eb-11ea-8a37-d7a891b74a3c	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	G7#11	29.5	2019-12-04 15:09:22.333063	2019-12-04 15:09:22.333063
1b8a1d54-16eb-11ea-8a37-8be7e4bb3d7e	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Gbmaj7	16	2019-12-04 15:09:22.33816	2019-12-04 15:09:22.33816
1b8ad9f6-16eb-11ea-8a37-5fd3c3a73981	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	Gbadd9/Db	1.5	2019-12-04 15:09:22.342989	2019-12-04 15:09:22.342989
1b8b9968-16eb-11ea-8a37-8f9063116f2b	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b818d6a-16eb-11ea-8a37-8ba20207b4c3	Bb-7add11	11.5	2019-12-04 15:09:22.347888	2019-12-04 15:09:22.347888
1b8c5826-16eb-11ea-8a37-23480ecbb32b	1b7ddd46-16eb-11ea-8a37-e7aece5a6e4f	1b8050bc-16eb-11ea-8a37-d7fc249aba5c	Gbadd9	0	2019-12-04 15:09:22.352772	2019-12-04 15:09:22.352772
1bb02ce2-16eb-11ea-8a37-d7faeb2a06e5	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	D	16	2019-12-04 15:09:22.587577	2019-12-04 15:09:22.587577
1bb13d44-16eb-11ea-8a37-bb8e450af15e	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	B-	16	2019-12-04 15:09:22.594555	2019-12-04 15:09:22.594555
1bb252c4-16eb-11ea-8a37-93f8113cd7be	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	F#-	3.5	2019-12-04 15:09:22.601583	2019-12-04 15:09:22.601583
1bb36362-16eb-11ea-8a37-c387568fbd36	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	Gmaj7/A	29.5	2019-12-04 15:09:22.608653	2019-12-04 15:09:22.608653
1bb474d2-16eb-11ea-8a37-57f06cc73db4	1ba99e54-16eb-11ea-8a37-0753aaf26025	1badc402-16eb-11ea-8a37-1bc388cfea8d	F#-	0	2019-12-04 15:09:22.61565	2019-12-04 15:09:22.61565
1bb53e4e-16eb-11ea-8a37-37a0095cf3a2	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	G	7.5	2019-12-04 15:09:22.620812	2019-12-04 15:09:22.620812
1bb605b8-16eb-11ea-8a37-8bb773518f38	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	G	28	2019-12-04 15:09:22.625921	2019-12-04 15:09:22.625921
1bb6ceb2-16eb-11ea-8a37-0383009a2b0c	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	E-7	13.5	2019-12-04 15:09:22.631031	2019-12-04 15:09:22.631031
1bb792e8-16eb-11ea-8a37-0f322e2e9c4c	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	G	12	2019-12-04 15:09:22.636089	2019-12-04 15:09:22.636089
1bb85264-16eb-11ea-8a37-2fa2f41c349f	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	E-	4	2019-12-04 15:09:22.640982	2019-12-04 15:09:22.640982
1bb91794-16eb-11ea-8a37-afe82a90eddf	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	E-	20	2019-12-04 15:09:22.646016	2019-12-04 15:09:22.646016
1bb9e778-16eb-11ea-8a37-03019b1f4e0a	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	F#-	19.5	2019-12-04 15:09:22.651352	2019-12-04 15:09:22.651352
1bbaa7da-16eb-11ea-8a37-9397660cd57b	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	G	23.5	2019-12-04 15:09:22.656272	2019-12-04 15:09:22.656272
1bbbd8c6-16eb-11ea-8a37-1f6744cd7bb7	1ba99e54-16eb-11ea-8a37-0753aaf26025	1bac8c36-16eb-11ea-8a37-7fcc71be05b7	B-	0	2019-12-04 15:09:22.664062	2019-12-04 15:09:22.664062
1bbd170e-16eb-11ea-8a37-abc80d252052	1ba99e54-16eb-11ea-8a37-0753aaf26025	1baefbc4-16eb-11ea-8a37-d75c5e8bc803	D	0	2019-12-04 15:09:22.672179	2019-12-04 15:09:22.672179
1bd8f2da-16eb-11ea-8a37-03a41a05dc43	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	Bsus2/D#	3.5	2019-12-04 15:09:22.854885	2019-12-04 15:09:22.854885
1bd9ce08-16eb-11ea-8a37-a316a610cf6f	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#/C#	7.5	2019-12-04 15:09:22.860514	2019-12-04 15:09:22.860514
1bda9e32-16eb-11ea-8a37-0f7b2f594094	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#/C#	23.5	2019-12-04 15:09:22.865863	2019-12-04 15:09:22.865863
1bdb72e4-16eb-11ea-8a37-6b538f17b81f	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#	31.5	2019-12-04 15:09:22.871289	2019-12-04 15:09:22.871289
1bdc051a-16eb-11ea-8a37-bbb6a4e51818	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	F#	31.5	2019-12-04 15:09:22.87502	2019-12-04 15:09:22.87502
1bdc999e-16eb-11ea-8a37-a786747a75d9	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#add9	0	2019-12-04 15:09:22.87883	2019-12-04 15:09:22.87883
1bdd2d50-16eb-11ea-8a37-5f10a401977a	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#	0	2019-12-04 15:09:22.882616	2019-12-04 15:09:22.882616
1bddbd6a-16eb-11ea-8a37-1b3eb2e8ad4d	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#add9	15.5	2019-12-04 15:09:22.886327	2019-12-04 15:09:22.886327
1bde471c-16eb-11ea-8a37-37c61c8e7c13	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	G#-7	11.5	2019-12-04 15:09:22.889864	2019-12-04 15:09:22.889864
1bdecdae-16eb-11ea-8a37-7f9d5fa8a2cb	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	C#add4/B	29.5	2019-12-04 15:09:22.893308	2019-12-04 15:09:22.893308
1bdf5846-16eb-11ea-8a37-f776ec77a7fa	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	F#/A#	23.5	2019-12-04 15:09:22.896833	2019-12-04 15:09:22.896833
1bdfe770-16eb-11ea-8a37-83b36a3ac29d	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	D#-7	0	2019-12-04 15:09:22.900495	2019-12-04 15:09:22.900495
1be0e67a-16eb-11ea-8a37-c37bf5db7230	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	C#add4	29.5	2019-12-04 15:09:22.907025	2019-12-04 15:09:22.907025
1be1ea48-16eb-11ea-8a37-2bcdfc100607	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	Bsus2/D#	19.5	2019-12-04 15:09:22.913673	2019-12-04 15:09:22.913673
1be2e89e-16eb-11ea-8a37-c3415b4d4c1a	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	D#-7	31.5	2019-12-04 15:09:22.920204	2019-12-04 15:09:22.920204
1be3def2-16eb-11ea-8a37-83c5079b3604	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#add9	31.5	2019-12-04 15:09:22.926519	2019-12-04 15:09:22.926519
1be4baf2-16eb-11ea-8a37-7745447be1aa	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	Bsus2/D#	3.5	2019-12-04 15:09:22.932128	2019-12-04 15:09:22.932128
1be5a4da-16eb-11ea-8a37-df5eaedd2317	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#sus2/A#	27.5	2019-12-04 15:09:22.938111	2019-12-04 15:09:22.938111
1be68760-16eb-11ea-8a37-17c44ba51c42	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	Bmaj7add9	29.5	2019-12-04 15:09:22.943942	2019-12-04 15:09:22.943942
1be75fb4-16eb-11ea-8a37-8f303f2d83ae	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	D#-7	7.5	2019-12-04 15:09:22.94947	2019-12-04 15:09:22.94947
1be7f870-16eb-11ea-8a37-eb41fe2ff0cd	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	F#	15.5	2019-12-04 15:09:22.953393	2019-12-04 15:09:22.953393
1be88db2-16eb-11ea-8a37-6f546d1d6a47	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd71c76-16eb-11ea-8a37-735907092e35	D#-7	13.5	2019-12-04 15:09:22.957216	2019-12-04 15:09:22.957216
1be91d0e-16eb-11ea-8a37-03a01379aa59	1bd515ac-16eb-11ea-8a37-2711b44f5abc	1bd8157c-16eb-11ea-8a37-6b1aaf82a53a	Bsus2/G#	19.5	2019-12-04 15:09:22.960883	2019-12-04 15:09:22.960883
1c0bf216-16eb-11ea-8a37-6bd9997019b7	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	F-7	0	2019-12-04 15:09:23.188984	2019-12-04 15:09:23.188984
1c0d2d84-16eb-11ea-8a37-7b3b87513449	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Db/F	14	2019-12-04 15:09:23.197075	2019-12-04 15:09:23.197075
1c0e61ea-16eb-11ea-8a37-9f33d9e877ad	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	Ab7sus4	12	2019-12-04 15:09:23.204928	2019-12-04 15:09:23.204928
1c0f9d94-16eb-11ea-8a37-3fd2242b0fe5	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	Db	8	2019-12-04 15:09:23.213027	2019-12-04 15:09:23.213027
1c10aea0-16eb-11ea-8a37-cf7c8abbace6	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0aba18-16eb-11ea-8a37-8b57e5f1f7a7	Gbmaj6/9	8	2019-12-04 15:09:23.220065	2019-12-04 15:09:23.220065
1c11c1dc-16eb-11ea-8a37-d7cbd5d1cab1	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Gb	0	2019-12-04 15:09:23.227116	2019-12-04 15:09:23.227116
1c12c866-16eb-11ea-8a37-bf09ae9816a4	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Eb-	24	2019-12-04 15:09:23.233838	2019-12-04 15:09:23.233838
1c13deea-16eb-11ea-8a37-83e1a53c85d8	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Bb-	6	2019-12-04 15:09:23.240968	2019-12-04 15:09:23.240968
1c14a85c-16eb-11ea-8a37-6f143420ec06	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Ab	20	2019-12-04 15:09:23.246126	2019-12-04 15:09:23.246126
1c156b84-16eb-11ea-8a37-6f82721c7088	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Gb	16	2019-12-04 15:09:23.251066	2019-12-04 15:09:23.251066
1c16329e-16eb-11ea-8a37-13aab6786dc4	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Bb-	22	2019-12-04 15:09:23.256217	2019-12-04 15:09:23.256217
1c16f03a-16eb-11ea-8a37-6bb7ed2bb625	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Ab7sus4	28	2019-12-04 15:09:23.261072	2019-12-04 15:09:23.261072
1c17ad68-16eb-11ea-8a37-d770412ed6cd	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c09f8bc-16eb-11ea-8a37-cf52ab961f92	Bb-	0	2019-12-04 15:09:23.265915	2019-12-04 15:09:23.265915
1c186bb8-16eb-11ea-8a37-03f9075fa744	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Eb-	8	2019-12-04 15:09:23.270786	2019-12-04 15:09:23.270786
1c192940-16eb-11ea-8a37-073d3c6a0d65	1c07b16a-16eb-11ea-8a37-6bbfe3f0404e	1c0936a2-16eb-11ea-8a37-8364cbc8c053	Ab	4	2019-12-04 15:09:23.275645	2019-12-04 15:09:23.275645
1c4ee1f2-16eb-11ea-8a37-0bb90ca2dcfa	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	C/D	24	2019-12-04 15:09:23.627645	2019-12-04 15:09:23.627645
1c4ffb28-16eb-11ea-8a37-ff0627d3cfcc	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	F	16	2019-12-04 15:09:23.634881	2019-12-04 15:09:23.634881
1c5116a2-16eb-11ea-8a37-a371e37360dc	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c493f18-16eb-11ea-8a37-8f6cbc29c491	E-	0	2019-12-04 15:09:23.642111	2019-12-04 15:09:23.642111
1c522948-16eb-11ea-8a37-5b0e587c5af9	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	G	8	2019-12-04 15:09:23.649147	2019-12-04 15:09:23.649147
1c53406c-16eb-11ea-8a37-8b462c34dc9e	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	D-	16	2019-12-04 15:09:23.656302	2019-12-04 15:09:23.656302
1c53fb06-16eb-11ea-8a37-1398dfac8c81	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	A	12	2019-12-04 15:09:23.661146	2019-12-04 15:09:23.661146
1c54a5f6-16eb-11ea-8a37-fbe846c79f6e	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	Bsus4	4	2019-12-04 15:09:23.665502	2019-12-04 15:09:23.665502
1c55460a-16eb-11ea-8a37-e78a56433908	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	F	0	2019-12-04 15:09:23.669652	2019-12-04 15:09:23.669652
1c55da48-16eb-11ea-8a37-9b879c73cd1a	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	C	8	2019-12-04 15:09:23.673485	2019-12-04 15:09:23.673485
1c5669fe-16eb-11ea-8a37-1f5b19c359a6	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	G	12	2019-12-04 15:09:23.677147	2019-12-04 15:09:23.677147
1c56f4dc-16eb-11ea-8a37-ff0d35b89cc4	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	A-	8	2019-12-04 15:09:23.680716	2019-12-04 15:09:23.680716
1c578866-16eb-11ea-8a37-1f48563dad51	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	E-	0	2019-12-04 15:09:23.684486	2019-12-04 15:09:23.684486
1c581038-16eb-11ea-8a37-db7f94556867	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	A-	8	2019-12-04 15:09:23.687974	2019-12-04 15:09:23.687974
1c59074a-16eb-11ea-8a37-5b1429313a86	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c48797a-16eb-11ea-8a37-a3a556866028	E-	0	2019-12-04 15:09:23.694297	2019-12-04 15:09:23.694297
1c5a06f4-16eb-11ea-8a37-57a0059c0a64	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	G	12	2019-12-04 15:09:23.700836	2019-12-04 15:09:23.700836
1c5afd48-16eb-11ea-8a37-3325c5090e6b	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4a03bc-16eb-11ea-8a37-bb738df95e32	C/G	24	2019-12-04 15:09:23.70716	2019-12-04 15:09:23.70716
1c5bf27a-16eb-11ea-8a37-77fb38b2522d	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	D	14	2019-12-04 15:09:23.713437	2019-12-04 15:09:23.713437
1c5ccd3a-16eb-11ea-8a37-4b18da7a89b0	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4c7156-16eb-11ea-8a37-6bae7a457ff7	A-	0	2019-12-04 15:09:23.71899	2019-12-04 15:09:23.71899
1c5da4da-16eb-11ea-8a37-c7aecc0270ac	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4b349e-16eb-11ea-8a37-dbff775ad0b6	E-	0	2019-12-04 15:09:23.724549	2019-12-04 15:09:23.724549
1c5ea556-16eb-11ea-8a37-4fd03048eb09	1c46f5aa-16eb-11ea-8a37-d3b0641778a1	1c4daec2-16eb-11ea-8a37-5f66632a9cce	C	4	2019-12-04 15:09:23.730991	2019-12-04 15:09:23.730991
1c95eeb2-16eb-11ea-8a37-2fa1463383a6	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	Fmaj7	11.5	2019-12-04 15:09:24.093318	2019-12-04 15:09:24.093318
1c96f8f2-16eb-11ea-8a37-87e93ac137cd	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Dbmaj7	16	2019-12-04 15:09:24.100142	2019-12-04 15:09:24.100142
1c97b878-16eb-11ea-8a37-2fe2fe485f3b	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	Cmaj7	0	2019-12-04 15:09:24.105057	2019-12-04 15:09:24.105057
1c98824e-16eb-11ea-8a37-971a2fa70603	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	Emaj7	3.5	2019-12-04 15:09:24.11019	2019-12-04 15:09:24.11019
1c9945a8-16eb-11ea-8a37-6f857ce87ff6	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Fmaj7	24	2019-12-04 15:09:24.115199	2019-12-04 15:09:24.115199
1c9a0aa6-16eb-11ea-8a37-cb933c709de9	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c93b138-16eb-11ea-8a37-7329e2a7875a	Abmaj7	7.5	2019-12-04 15:09:24.120252	2019-12-04 15:09:24.120252
1c9acba8-16eb-11ea-8a37-efe2bde9fcc2	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Amaj7	3.5	2019-12-04 15:09:24.125202	2019-12-04 15:09:24.125202
1c9b90ce-16eb-11ea-8a37-2f25453cc6aa	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Amaj7	19.5	2019-12-04 15:09:24.130243	2019-12-04 15:09:24.130243
1c9c4adc-16eb-11ea-8a37-f3682fcc25af	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Dbmaj7	0	2019-12-04 15:09:24.135011	2019-12-04 15:09:24.135011
1c9d0bc0-16eb-11ea-8a37-fb1f4e9c7c9a	1c9163a6-16eb-11ea-8a37-f39bdf338693	1c94d95a-16eb-11ea-8a37-8bb0cb8d50bc	Fmaj7	8	2019-12-04 15:09:24.139913	2019-12-04 15:09:24.139913
1cc00c10-16eb-11ea-8a37-07b3b9af462c	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	C#-	0	2019-12-04 15:09:24.369421	2019-12-04 15:09:24.369421
1cc10994-16eb-11ea-8a37-272c2db24f32	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	Emaj7/G#	16	2019-12-04 15:09:24.375906	2019-12-04 15:09:24.375906
1cc2083a-16eb-11ea-8a37-1fc8824add8e	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	C#-7/B	8	2019-12-04 15:09:24.382443	2019-12-04 15:09:24.382443
1cc30730-16eb-11ea-8a37-6fce6047ab5c	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	Emaj7add9	3.5	2019-12-04 15:09:24.388964	2019-12-04 15:09:24.388964
1cc400f4-16eb-11ea-8a37-a79e49cc5d5b	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	F#-6	5.5	2019-12-04 15:09:24.395358	2019-12-04 15:09:24.395358
1cc4dd80-16eb-11ea-8a37-3f993a2cdf53	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	E/A	17.5	2019-12-04 15:09:24.401008	2019-12-04 15:09:24.401008
1cc5b2a0-16eb-11ea-8a37-9f1e4427ce56	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	E/B	19.5	2019-12-04 15:09:24.406491	2019-12-04 15:09:24.406491
1cc68a4a-16eb-11ea-8a37-bbf9ea56037a	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	C#sus4/D	1.5	2019-12-04 15:09:24.411972	2019-12-04 15:09:24.411972
1cc76820-16eb-11ea-8a37-43ec3bb1a5c2	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	Bmaj6	21.5	2019-12-04 15:09:24.417661	2019-12-04 15:09:24.417661
1cc7fd08-16eb-11ea-8a37-f3a00124615b	1cbe69aa-16eb-11ea-8a37-ef5eb37dc525	1cbf7fac-16eb-11ea-8a37-4f301c22d062	Badd4/C#	24	2019-12-04 15:09:24.42149	2019-12-04 15:09:24.42149
1cdbdb52-16eb-11ea-8a37-cba400cead62	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	Abmaj7	0	2019-12-04 15:09:24.551719	2019-12-04 15:09:24.551719
1cdcbcd4-16eb-11ea-8a37-dbdb12afbc84	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd8d7a4-16eb-11ea-8a37-0f8c441e8cf1	Dbmaj7	0	2019-12-04 15:09:24.557489	2019-12-04 15:09:24.557489
1cdd9a82-16eb-11ea-8a37-5f8b0b4b973f	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cdae328-16eb-11ea-8a37-bbdd268629d3	Dbmaj7	0	2019-12-04 15:09:24.563176	2019-12-04 15:09:24.563176
1cde7506-16eb-11ea-8a37-838da8dfe3f4	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd9d9ec-16eb-11ea-8a37-574c05744ae9	Dbmaj7	0	2019-12-04 15:09:24.568764	2019-12-04 15:09:24.568764
1cdf5674-16eb-11ea-8a37-b3c9f3081a1e	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	Amaj7	12.5	2019-12-04 15:09:24.574513	2019-12-04 15:09:24.574513
1cdfe7ba-16eb-11ea-8a37-fba620aa98ea	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	Emaj7	8	2019-12-04 15:09:24.578226	2019-12-04 15:09:24.578226
1ce074a0-16eb-11ea-8a37-e784c6be6e66	1cd6c720-16eb-11ea-8a37-772e7139de8e	1cd7d1d8-16eb-11ea-8a37-171c57af8178	Bmaj7	4.5	2019-12-04 15:09:24.581849	2019-12-04 15:09:24.581849
1d0ac7fa-16eb-11ea-8a37-0b26f8cc2e70	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	Emaj7add9	25.5	2019-12-04 15:09:24.859099	2019-12-04 15:09:24.859099
1d0b864a-16eb-11ea-8a37-d70b1ad6262d	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	Gbmaj6	5.5	2019-12-04 15:09:24.863991	2019-12-04 15:09:24.863991
1d0c456c-16eb-11ea-8a37-2b2149bf202f	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	Emaj7	9.75	2019-12-04 15:09:24.868885	2019-12-04 15:09:24.868885
1d0d04de-16eb-11ea-8a37-138268c1743b	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d078568-16eb-11ea-8a37-67a5a8ed19ba	Eb5	0	2019-12-04 15:09:24.873768	2019-12-04 15:09:24.873768
1d0dc7f2-16eb-11ea-8a37-3368eb0ad67c	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	G#-7	8	2019-12-04 15:09:24.878765	2019-12-04 15:09:24.878765
1d0e92a4-16eb-11ea-8a37-fb1197cb13e9	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	C#/B	17.75	2019-12-04 15:09:24.883953	2019-12-04 15:09:24.883953
1d0f4f0a-16eb-11ea-8a37-f35ecca14bb9	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	Eb-7	0	2019-12-04 15:09:24.888783	2019-12-04 15:09:24.888783
1d101110-16eb-11ea-8a37-979378c946fe	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d09b5a4-16eb-11ea-8a37-83859494d2b8	Eb-7	8	2019-12-04 15:09:24.893739	2019-12-04 15:09:24.893739
1d10cb64-16eb-11ea-8a37-6bc4e6926e11	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	C#/B	1.75	2019-12-04 15:09:24.898532	2019-12-04 15:09:24.898532
1d11f732-16eb-11ea-8a37-836511e58d26	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	Bmaj7	0	2019-12-04 15:09:24.906204	2019-12-04 15:09:24.906204
1d13233c-16eb-11ea-8a37-833234f3afe2	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	Bmaj7	16	2019-12-04 15:09:24.913851	2019-12-04 15:09:24.913851
1d145590-16eb-11ea-8a37-17aff7bd8b5f	1d054da2-16eb-11ea-8a37-e76bae68ab4e	1d089be2-16eb-11ea-8a37-4fc8b9f51686	F#add9/A#	24	2019-12-04 15:09:24.921699	2019-12-04 15:09:24.921699
1d49d6b6-16eb-11ea-8a37-e722e8603a99	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	Db	4	2019-12-04 15:09:25.272479	2019-12-04 15:09:25.272479
1d4a64c8-16eb-11ea-8a37-a36cd47cf084	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	B	4	2019-12-04 15:09:25.276124	2019-12-04 15:09:25.276124
1d4ae8f8-16eb-11ea-8a37-33eb980e6cba	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	E-	29.5	2019-12-04 15:09:25.279513	2019-12-04 15:09:25.279513
1d4b6e68-16eb-11ea-8a37-cbe1c68e69ad	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	C-	16	2019-12-04 15:09:25.282938	2019-12-04 15:09:25.282938
1d4bf3ce-16eb-11ea-8a37-a34f119dfc4b	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	C-	0	2019-12-04 15:09:25.286341	2019-12-04 15:09:25.286341
1d4c7f24-16eb-11ea-8a37-bf9fc214d6f2	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	Eb-	8	2019-12-04 15:09:25.28992	2019-12-04 15:09:25.28992
1d4d048a-16eb-11ea-8a37-075f0d3d6ea8	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	Bb-	12	2019-12-04 15:09:25.293326	2019-12-04 15:09:25.293326
1d4e1f1e-16eb-11ea-8a37-6326532b1cc0	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d493fd0-16eb-11ea-8a37-c3d403a460cb	Db	20	2019-12-04 15:09:25.30041	2019-12-04 15:09:25.30041
1d4f4e84-16eb-11ea-8a37-2fbee4ed464b	1d44afe2-16eb-11ea-8a37-abee7f9bcb41	1d48abce-16eb-11ea-8a37-bb1acedee3d5	Ab-	0	2019-12-04 15:09:25.308162	2019-12-04 15:09:25.308162
1d76976e-16eb-11ea-8a37-e30d3b156418	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	A-7	31.5	2019-12-04 15:09:25.565566	2019-12-04 15:09:25.565566
1d775622-16eb-11ea-8a37-23e6818ee1e3	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	E-7	19.5	2019-12-04 15:09:25.570516	2019-12-04 15:09:25.570516
1d78115c-16eb-11ea-8a37-fb1d8f58995a	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	C#dim7	28.5	2019-12-04 15:09:25.575338	2019-12-04 15:09:25.575338
1d78ccc8-16eb-11ea-8a37-5320f5d2c7dc	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	D-7add9	29.5	2019-12-04 15:09:25.580099	2019-12-04 15:09:25.580099
1d798ece-16eb-11ea-8a37-43346351f71b	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	A-7	0	2019-12-04 15:09:25.585071	2019-12-04 15:09:25.585071
1d7ab858-16eb-11ea-8a37-67a1340ef4e9	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	Eb-7	7.5	2019-12-04 15:09:25.592724	2019-12-04 15:09:25.592724
1d7beb4c-16eb-11ea-8a37-4f33fa59d71d	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75d5ae-16eb-11ea-8a37-9bb78c9c4f3c	A-7add9	0	2019-12-04 15:09:25.600574	2019-12-04 15:09:25.600574
1d7d1468-16eb-11ea-8a37-cf99aa8c9c35	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	A-7	16	2019-12-04 15:09:25.608185	2019-12-04 15:09:25.608185
1d7e3ef6-16eb-11ea-8a37-63dc38680c8c	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	F#-7	3.5	2019-12-04 15:09:25.615787	2019-12-04 15:09:25.615787
1d7f53e0-16eb-11ea-8a37-33b7002ffbf9	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d75115a-16eb-11ea-8a37-0f72ac0c0642	Fmaj7add9	23.5	2019-12-04 15:09:25.622878	2019-12-04 15:09:25.622878
1d806578-16eb-11ea-8a37-8b6b8e00f843	1d725d2a-16eb-11ea-8a37-7bccb481c597	1d7443e2-16eb-11ea-8a37-e7839cdf7dbb	NC	0	2019-12-04 15:09:25.629872	2019-12-04 15:09:25.629872
1da3770c-16eb-11ea-8a37-7732bf881909	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	B-7	11.5	2019-12-04 15:09:25.859855	2019-12-04 15:09:25.859855
1da3fd80-16eb-11ea-8a37-6feb3b21cc1c	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da26f60-16eb-11ea-8a37-2bc557f8bc59	NC	0	2019-12-04 15:09:25.8633	2019-12-04 15:09:25.8633
1da52098-16eb-11ea-8a37-bb500cbbe564	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da1e7c0-16eb-11ea-8a37-532dcab2368f	F#-	0	2019-12-04 15:09:25.87055	2019-12-04 15:09:25.87055
1da6675a-16eb-11ea-8a37-6bca201e8805	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	D	10.5	2019-12-04 15:09:25.878952	2019-12-04 15:09:25.878952
1da7a0fc-16eb-11ea-8a37-d7a7b0ab4d49	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da2f0fc-16eb-11ea-8a37-2bcc13b87204	F#5	0	2019-12-04 15:09:25.886945	2019-12-04 15:09:25.886945
1da8d2f6-16eb-11ea-8a37-2fdd16b9f6eb	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	F#-	0	2019-12-04 15:09:25.894849	2019-12-04 15:09:25.894849
1da9e5b0-16eb-11ea-8a37-2b3aaec1a8e3	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	F#-	7.5	2019-12-04 15:09:25.901852	2019-12-04 15:09:25.901852
1daaef46-16eb-11ea-8a37-f77f541358bf	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	B-7	3.5	2019-12-04 15:09:25.908684	2019-12-04 15:09:25.908684
1dac078c-16eb-11ea-8a37-6b81d3bcf141	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	Gmaj7	2.5	2019-12-04 15:09:25.915834	2019-12-04 15:09:25.915834
1dad1d02-16eb-11ea-8a37-87fafdade05d	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	C#-7	6.5	2019-12-04 15:09:25.922892	2019-12-04 15:09:25.922892
1dade782-16eb-11ea-8a37-637f5d9bf96e	1da04118-16eb-11ea-8a37-3f1dce9d6424	1da152ce-16eb-11ea-8a37-9fc5142d4a34	Eadd9	14.5	2019-12-04 15:09:25.928154	2019-12-04 15:09:25.928154
1de4d652-16eb-11ea-8a37-27da05d762f4	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	F7	12	2019-12-04 15:09:26.288068	2019-12-04 15:09:26.288068
1de5e902-16eb-11ea-8a37-f7aaa21b5c03	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	Cm7	8	2019-12-04 15:09:26.2952	2019-12-04 15:09:26.2952
1de6e1cc-16eb-11ea-8a37-83b11b4ff841	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de39a08-16eb-11ea-8a37-738d22dbcff6	E minor 7	0	2019-12-04 15:09:26.301566	2019-12-04 15:09:26.301566
1de7ca06-16eb-11ea-8a37-67609031d0d0	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de39a08-16eb-11ea-8a37-738d22dbcff6	D minor 7	8	2019-12-04 15:09:26.307578	2019-12-04 15:09:26.307578
1de8b222-16eb-11ea-8a37-8b01cf74e64b	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	Bb major 7	16	2019-12-04 15:09:26.31349	2019-12-04 15:09:26.31349
1de949da-16eb-11ea-8a37-03daf0097b47	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de11102-16eb-11ea-8a37-57f184fd0e32	D	0	2019-12-04 15:09:26.317429	2019-12-04 15:09:26.317429
1de9daf8-16eb-11ea-8a37-97ac9ff69bd5	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de39a08-16eb-11ea-8a37-738d22dbcff6	Eb minor 7	4	2019-12-04 15:09:26.321151	2019-12-04 15:09:26.321151
1dea696e-16eb-11ea-8a37-fb044e279506	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	Eb7	28	2019-12-04 15:09:26.324821	2019-12-04 15:09:26.324821
1deaf46a-16eb-11ea-8a37-8bf41620e9ec	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de39a08-16eb-11ea-8a37-738d22dbcff6	Db minor 7	12	2019-12-04 15:09:26.32839	2019-12-04 15:09:26.32839
1deba2fc-16eb-11ea-8a37-17788fe0d749	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de11102-16eb-11ea-8a37-57f184fd0e32	F7	12	2019-12-04 15:09:26.33272	2019-12-04 15:09:26.33272
1dec6dfe-16eb-11ea-8a37-6becd1472edf	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	C major 7	0	2019-12-04 15:09:26.337868	2019-12-04 15:09:26.337868
1ded372a-16eb-11ea-8a37-77f4d57beff2	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	Ab major 7	30	2019-12-04 15:09:26.343004	2019-12-04 15:09:26.343004
1dee0d80-16eb-11ea-8a37-af0e6e7546c0	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de11102-16eb-11ea-8a37-57f184fd0e32	G	4	2019-12-04 15:09:26.348484	2019-12-04 15:09:26.348484
1def3408-16eb-11ea-8a37-432f74fad327	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de24f86-16eb-11ea-8a37-cb7cafc70798	Bb m7	24	2019-12-04 15:09:26.356123	2019-12-04 15:09:26.356123
1df05342-16eb-11ea-8a37-3b69c4dc9666	1ddd768c-16eb-11ea-8a37-ab599777e83d	1de11102-16eb-11ea-8a37-57f184fd0e32	C	8	2019-12-04 15:09:26.363482	2019-12-04 15:09:26.363482
1df9fdd4-16eb-11ea-8a37-63972360521c	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	Gmaj7	16	2019-12-04 15:09:26.426906	2019-12-04 15:09:26.426906
1dfa88b2-16eb-11ea-8a37-c7aaa2dbce35	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	B-7	0	2019-12-04 15:09:26.430458	2019-12-04 15:09:26.430458
1dfb1412-16eb-11ea-8a37-53a7383f4acb	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df9790e-16eb-11ea-8a37-ef7004e09057	B-	0	2019-12-04 15:09:26.43402	2019-12-04 15:09:26.43402
1dfc0df4-16eb-11ea-8a37-ff6897d42092	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	E-7	8	2019-12-04 15:09:26.440421	2019-12-04 15:09:26.440421
1dfd0cfe-16eb-11ea-8a37-c7c998dccbe4	1df7d432-16eb-11ea-8a37-97c25b2a6298	1df8eed0-16eb-11ea-8a37-e36af6c4759b	Cmaj7	24	2019-12-04 15:09:26.44695	2019-12-04 15:09:26.44695
1e219524-16eb-11ea-8a37-471f056e4e18	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	Fmaj7	4	2019-12-04 15:09:26.686226	2019-12-04 15:09:26.686226
1e2243de-16eb-11ea-8a37-d3d49f71afa1	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	E-7	0	2019-12-04 15:09:26.690755	2019-12-04 15:09:26.690755
1e22e1d6-16eb-11ea-8a37-b38c9e83c256	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	Cmaj7/E	4	2019-12-04 15:09:26.69483	2019-12-04 15:09:26.69483
1e2380e6-16eb-11ea-8a37-ebe189a30727	1e1d5928-16eb-11ea-8a37-9751a208273e	1e200588-16eb-11ea-8a37-831127ae524a	A-7	8	2019-12-04 15:09:26.698889	2019-12-04 15:09:26.698889
1e242bea-16eb-11ea-8a37-03cab26921db	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	Dmaj6	0	2019-12-04 15:09:26.703259	2019-12-04 15:09:26.703259
1e254016-16eb-11ea-8a37-338671ed4533	1e1d5928-16eb-11ea-8a37-9751a208273e	1e1f3a86-16eb-11ea-8a37-b381af4def76	Cmaj7add9	8	2019-12-04 15:09:26.710332	2019-12-04 15:09:26.710332
1e265d02-16eb-11ea-8a37-53aeacf9a795	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	C/G	8	2019-12-04 15:09:26.717562	2019-12-04 15:09:26.717562
1e277ee4-16eb-11ea-8a37-9ff072bf338b	1e1d5928-16eb-11ea-8a37-9751a208273e	1e20cc20-16eb-11ea-8a37-c753e73531cf	D/G	0	2019-12-04 15:09:26.725025	2019-12-04 15:09:26.725025
1e5f2efc-16eb-11ea-8a37-3f0bdaa04f5a	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	Fmaj7	0	2019-12-04 15:09:27.089954	2019-12-04 15:09:27.089954
1e5feab8-16eb-11ea-8a37-3b1e334634ea	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	Gbmaj7	11.5	2019-12-04 15:09:27.094777	2019-12-04 15:09:27.094777
1e6117d0-16eb-11ea-8a37-3f4f4c0ae96f	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Gbmaj7	20	2019-12-04 15:09:27.102469	2019-12-04 15:09:27.102469
1e624d30-16eb-11ea-8a37-b3c6736c8ff7	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Bb-7	0	2019-12-04 15:09:27.110398	2019-12-04 15:09:27.110398
1e6382cc-16eb-11ea-8a37-87ea6564e849	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	Fmaj7	0	2019-12-04 15:09:27.118302	2019-12-04 15:09:27.118302
1e64af44-16eb-11ea-8a37-fb92253de7cb	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	Bb-7	7.5	2019-12-04 15:09:27.126021	2019-12-04 15:09:27.126021
1e65b7fe-16eb-11ea-8a37-23a068db876e	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Bb-7	16	2019-12-04 15:09:27.132798	2019-12-04 15:09:27.132798
1e66beba-16eb-11ea-8a37-832077b1ce70	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Gbmaj7/Ab	28	2019-12-04 15:09:27.13952	2019-12-04 15:09:27.13952
1e67d20a-16eb-11ea-8a37-1f0b07fb03b1	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Gbmaj7	4	2019-12-04 15:09:27.146546	2019-12-04 15:09:27.146546
1e68e352-16eb-11ea-8a37-3b2d33bc451c	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5dad84-16eb-11ea-8a37-2f2d34ea5c22	Dbmaj7	3.5	2019-12-04 15:09:27.153491	2019-12-04 15:09:27.153491
1e69b5ac-16eb-11ea-8a37-dbeb22a65069	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5e6e4a-16eb-11ea-8a37-d360931995ab	Ebmaj7	4	2019-12-04 15:09:27.158922	2019-12-04 15:09:27.158922
1e6a7a50-16eb-11ea-8a37-c734b0b88c48	1e5b5f98-16eb-11ea-8a37-df0dc125933d	1e5ce43a-16eb-11ea-8a37-cf5b0da3deae	Eb-7	12	2019-12-04 15:09:27.163998	2019-12-04 15:09:27.163998
1e9ff43c-16eb-11ea-8a37-7fe2271c1163	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	Fmaj6/G	11	2019-12-04 15:09:27.514419	2019-12-04 15:09:27.514419
1ea10f5c-16eb-11ea-8a37-8b788ac91d7d	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	Bbmaj7	3	2019-12-04 15:09:27.521539	2019-12-04 15:09:27.521539
1ea234a4-16eb-11ea-8a37-d3b668688cd4	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	Gmaj6	14	2019-12-04 15:09:27.529175	2019-12-04 15:09:27.529175
1ea34880-16eb-11ea-8a37-1b7cfdf32080	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	Fmaj7	14	2019-12-04 15:09:27.536235	2019-12-04 15:09:27.536235
1ea45892-16eb-11ea-8a37-f3392a95cc4e	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9d86de-16eb-11ea-8a37-93f2df4c3e77	E-7/A	0	2019-12-04 15:09:27.543222	2019-12-04 15:09:27.543222
1ea5207e-16eb-11ea-8a37-f35218615d2f	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	Esus4/F	3	2019-12-04 15:09:27.548339	2019-12-04 15:09:27.548339
1ea5ec34-16eb-11ea-8a37-071c4e94c909	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	Csus2/E	8	2019-12-04 15:09:27.553435	2019-12-04 15:09:27.553435
1ea6b614-16eb-11ea-8a37-6bdf77b06bfc	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	A-7	0	2019-12-04 15:09:27.558714	2019-12-04 15:09:27.558714
1ea7812a-16eb-11ea-8a37-ef04df4118a6	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9ec44a-16eb-11ea-8a37-9f8116cfafbd	Esus4	0	2019-12-04 15:09:27.563848	2019-12-04 15:09:27.563848
1ea83048-16eb-11ea-8a37-43846ab39c6e	1e9a52e8-16eb-11ea-8a37-8357d918bfda	1e9c5250-16eb-11ea-8a37-5f16ec2708bb	Fmaj7	11	2019-12-04 15:09:27.568417	2019-12-04 15:09:27.568417
1ed801ce-16eb-11ea-8a37-1b77ac80dd1c	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	Aadd9/F#	4	2019-12-04 15:09:27.881915	2019-12-04 15:09:27.881915
1ed8de3c-16eb-11ea-8a37-5fa30c8aa35a	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed725a6-16eb-11ea-8a37-6bc976ac0efb	NC	0	2019-12-04 15:09:27.88758	2019-12-04 15:09:27.88758
1ed968a2-16eb-11ea-8a37-c7c15947c877	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	Dmaj7	0	2019-12-04 15:09:27.891122	2019-12-04 15:09:27.891122
1ed9f998-16eb-11ea-8a37-3f0c7f5a82d6	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	F/Bb	8	2019-12-04 15:09:27.89483	2019-12-04 15:09:27.89483
1eda867e-16eb-11ea-8a37-e7417cda108f	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed56afe-16eb-11ea-8a37-3b2d3cff89c7	F#5	0	2019-12-04 15:09:27.898436	2019-12-04 15:09:27.898436
1edb1026-16eb-11ea-8a37-ff7b014fa28d	1ed3893c-16eb-11ea-8a37-53c677a170ca	1ed6499c-16eb-11ea-8a37-6fee705e3702	G/C	12	2019-12-04 15:09:27.901953	2019-12-04 15:09:27.901953
1f063990-16eb-11ea-8a37-03c26b70417d	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	C#maj7	0	2019-12-04 15:09:28.184691	2019-12-04 15:09:28.184691
1f06f48e-16eb-11ea-8a37-f3ad9747e09d	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	Emaj7add9	9.5	2019-12-04 15:09:28.189436	2019-12-04 15:09:28.189436
1f07b3f6-16eb-11ea-8a37-dbc34b7afbc9	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	G#-7	8	2019-12-04 15:09:28.194388	2019-12-04 15:09:28.194388
1f086d32-16eb-11ea-8a37-a3a8684dcff3	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	F#-7add9	1.5	2019-12-04 15:09:28.199113	2019-12-04 15:09:28.199113
1f091ed0-16eb-11ea-8a37-5742339937e5	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	Amaj7	17.5	2019-12-04 15:09:28.203684	2019-12-04 15:09:28.203684
1f0a46a2-16eb-11ea-8a37-1f7a01a8a1a7	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	C#maj7	16	2019-12-04 15:09:28.211216	2019-12-04 15:09:28.211216
1f0b7ce8-16eb-11ea-8a37-133710e2245b	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	G#-7	24	2019-12-04 15:09:28.219139	2019-12-04 15:09:28.219139
1f0cb072-16eb-11ea-8a37-0f34d3bdc7b6	1f0408aa-16eb-11ea-8a37-7b1a7c680b6b	1f057e2e-16eb-11ea-8a37-9735e522beba	Dmaj7add13	25.5	2019-12-04 15:09:28.22703	2019-12-04 15:09:28.22703
1f2f4e02-16eb-11ea-8a37-dfbe8c874f27	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	C#-7	0	2019-12-04 15:09:28.453901	2019-12-04 15:09:28.453901
1f305a68-16eb-11ea-8a37-0ba39ca88afc	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	Amaj7/E	3.75	2019-12-04 15:09:28.460779	2019-12-04 15:09:28.460779
1f315e0e-16eb-11ea-8a37-8b9a2cec3664	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f29fede-16eb-11ea-8a37-73b7c0d29f05	D#-7	14.5	2019-12-04 15:09:28.467435	2019-12-04 15:09:28.467435
1f32663c-16eb-11ea-8a37-bbc6ba5e6047	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	G#-	0	2019-12-04 15:09:28.474204	2019-12-04 15:09:28.474204
1f332374-16eb-11ea-8a37-af56050fcd0a	1f27ae54-16eb-11ea-8a37-638aed0c1ccf	1f2e3a12-16eb-11ea-8a37-abfe012fa045	Bmaj6	11.75	2019-12-04 15:09:28.47903	2019-12-04 15:09:28.47903
1f5922fe-16eb-11ea-8a37-536a70a0e43b	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	D-/C	16	2019-12-04 15:09:28.72805	2019-12-04 15:09:28.72805
1f5a3f72-16eb-11ea-8a37-a3855110ea6d	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	C	0	2019-12-04 15:09:28.735328	2019-12-04 15:09:28.735328
1f5b5768-16eb-11ea-8a37-9f2cb3c073f2	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	F/C	8	2019-12-04 15:09:28.742481	2019-12-04 15:09:28.742481
1f5c713e-16eb-11ea-8a37-1bf1d077b652	1f55b3f8-16eb-11ea-8a37-b30fd772ba12	1f581580-16eb-11ea-8a37-7f9a9d48a442	F/C	24	2019-12-04 15:09:28.749584	2019-12-04 15:09:28.749584
1f792a36-16eb-11ea-8a37-83c494703844	1f729be4-16eb-11ea-8a37-f7402b31f897	1f74e8e0-16eb-11ea-8a37-1777ac953c6b	F-7	0	2019-12-04 15:09:28.937954	2019-12-04 15:09:28.937954
1f79eac0-16eb-11ea-8a37-1f3f75e1dd90	1f729be4-16eb-11ea-8a37-f7402b31f897	1f770fda-16eb-11ea-8a37-e7fcf1bf9286	F-7	0	2019-12-04 15:09:28.942892	2019-12-04 15:09:28.942892
1f7aa276-16eb-11ea-8a37-e78e84b81fca	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	G-7	3.5	2019-12-04 15:09:28.947594	2019-12-04 15:09:28.947594
1f7b5f40-16eb-11ea-8a37-bfbe84aa2ee4	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	Bb-7	8	2019-12-04 15:09:28.952416	2019-12-04 15:09:28.952416
1f7c1796-16eb-11ea-8a37-872798db6eb4	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	F-7	16	2019-12-04 15:09:28.957156	2019-12-04 15:09:28.957156
1f7cc920-16eb-11ea-8a37-539e482f5826	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	F-	0	2019-12-04 15:09:28.961695	2019-12-04 15:09:28.961695
1f7d83ba-16eb-11ea-8a37-9fc8f5e07449	1f729be4-16eb-11ea-8a37-f7402b31f897	1f75fc3a-16eb-11ea-8a37-7b0486545750	Emaj7	11.5	2019-12-04 15:09:28.966487	2019-12-04 15:09:28.966487
1f7e3508-16eb-11ea-8a37-dbabc95b3789	1f729be4-16eb-11ea-8a37-f7402b31f897	1f7820b4-16eb-11ea-8a37-d775fb8e679a	F-7	0	2019-12-04 15:09:28.97103	2019-12-04 15:09:28.97103
1fa811de-16eb-11ea-8a37-67dcfc566c40	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	Abmaj7	29.5	2019-12-04 15:09:29.245354	2019-12-04 15:09:29.245354
1fa8cf34-16eb-11ea-8a37-df8d89bf2850	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	Bb7sus4	24	2019-12-04 15:09:29.250208	2019-12-04 15:09:29.250208
1fa9850a-16eb-11ea-8a37-035cebd8b5d0	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	G-7/C	13.5	2019-12-04 15:09:29.254869	2019-12-04 15:09:29.254869
1faa3d10-16eb-11ea-8a37-b3e53a96f8cd	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	Abmaj7/Bb	16	2019-12-04 15:09:29.259587	2019-12-04 15:09:29.259587
1fab00d8-16eb-11ea-8a37-131ad7a8892a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	F-7	8	2019-12-04 15:09:29.264599	2019-12-04 15:09:29.264599
1fac2346-16eb-11ea-8a37-efbfea8a955a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	Ebmaj7	0	2019-12-04 15:09:29.272028	2019-12-04 15:09:29.272028
1fad4b9a-16eb-11ea-8a37-3f9b412f1f7a	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	G-7/C	29.5	2019-12-04 15:09:29.279603	2019-12-04 15:09:29.279603
1fae7290-16eb-11ea-8a37-e798bd293ccf	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	G-7	24	2019-12-04 15:09:29.287146	2019-12-04 15:09:29.287146
1fafa0d4-16eb-11ea-8a37-173f89e58888	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	G-7/C	13.5	2019-12-04 15:09:29.294889	2019-12-04 15:09:29.294889
1fb0b122-16eb-11ea-8a37-7b272df04032	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa5c910-16eb-11ea-8a37-371d2c81de12	Abmaj7/Bb	0	2019-12-04 15:09:29.301839	2019-12-04 15:09:29.301839
1fb1c896-16eb-11ea-8a37-27b50dccf2b8	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	Abmaj7	0	2019-12-04 15:09:29.308981	2019-12-04 15:09:29.308981
1fb2dce0-16eb-11ea-8a37-a7bfce8b64f7	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	Ebmaj7	16	2019-12-04 15:09:29.316051	2019-12-04 15:09:29.316051
1fb3ea90-16eb-11ea-8a37-37476b9304bb	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa75050-16eb-11ea-8a37-87b444d34878	C-	16	2019-12-04 15:09:29.322987	2019-12-04 15:09:29.322987
1fb4aa70-16eb-11ea-8a37-5b4ad382c686	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	F-7	27.5	2019-12-04 15:09:29.327896	2019-12-04 15:09:29.327896
1fb56852-16eb-11ea-8a37-530ec0bf76ae	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa50c14-16eb-11ea-8a37-8f071f3f3a6a	G-7	8	2019-12-04 15:09:29.332744	2019-12-04 15:09:29.332744
1fb63084-16eb-11ea-8a37-93fdd1b03570	1fa2fc08-16eb-11ea-8a37-8f1da5e6fd60	1fa68b34-16eb-11ea-8a37-038ef86f9c46	Abmaj7/Bb	0	2019-12-04 15:09:29.337802	2019-12-04 15:09:29.337802
1fec4ab6-16eb-11ea-8a37-77ec9598470b	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	Fsus4add3	0	2019-12-04 15:09:29.692393	2019-12-04 15:09:29.692393
1fed184c-16eb-11ea-8a37-c7add4daf4ea	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	Fsus4/Gb	8	2019-12-04 15:09:29.697699	2019-12-04 15:09:29.697699
1fede54c-16eb-11ea-8a37-7f113112aeab	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feaa38c-16eb-11ea-8a37-57d2cdb26466	C7sus4	8	2019-12-04 15:09:29.702944	2019-12-04 15:09:29.702944
1feeac84-16eb-11ea-8a37-030579f50334	1fe8b9fa-16eb-11ea-8a37-8f9c75beb6ff	1feb788e-16eb-11ea-8a37-9b619cc86924	Ebmaj6/9	0	2019-12-04 15:09:29.708051	2019-12-04 15:09:29.708051
20273c16-16eb-11ea-8a37-d3fbf6da6e35	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2025c138-16eb-11ea-8a37-bbfaf9205991	NC	0	2019-12-04 15:09:30.078744	2019-12-04 15:09:30.078744
2027f944-16eb-11ea-8a37-f3425034b2a2	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20267dd0-16eb-11ea-8a37-9b8a85645ffc	NC	0	2019-12-04 15:09:30.083562	2019-12-04 15:09:30.083562
2028ad12-16eb-11ea-8a37-57f697556def	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	D-/C	0	2019-12-04 15:09:30.088177	2019-12-04 15:09:30.088177
20295f0a-16eb-11ea-8a37-c7ddea9776ab	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	D-/F	16	2019-12-04 15:09:30.092734	2019-12-04 15:09:30.092734
202a84c0-16eb-11ea-8a37-0718c1153bbe	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20225cd2-16eb-11ea-8a37-bfcb30311269	NC	0	2019-12-04 15:09:30.100277	2019-12-04 15:09:30.100277
202bb0c0-16eb-11ea-8a37-8b64416233c8	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	Bbmaj7	8	2019-12-04 15:09:30.10796	2019-12-04 15:09:30.10796
202cdc02-16eb-11ea-8a37-77c279915310	20203966-16eb-11ea-8a37-1f6f4f9c48ae	202437c8-16eb-11ea-8a37-63e1971d8460	D-/G	24	2019-12-04 15:09:30.115575	2019-12-04 15:09:30.115575
202e06ae-16eb-11ea-8a37-4715a4e536d8	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	D-/G	3	2019-12-04 15:09:30.123233	2019-12-04 15:09:30.123233
202f1cb0-16eb-11ea-8a37-bfe42d03ba2d	20203966-16eb-11ea-8a37-1f6f4f9c48ae	2024f7ee-16eb-11ea-8a37-bb1b3908b21a	NC	0	2019-12-04 15:09:30.130302	2019-12-04 15:09:30.130302
20303366-16eb-11ea-8a37-bb645a7de89a	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	D-/F	11	2019-12-04 15:09:30.137399	2019-12-04 15:09:30.137399
203151f6-16eb-11ea-8a37-ffd536064779	20203966-16eb-11ea-8a37-1f6f4f9c48ae	20237a86-16eb-11ea-8a37-0f1bd8573b8e	D-	0	2019-12-04 15:09:30.144804	2019-12-04 15:09:30.144804
206636a0-16eb-11ea-8a37-fb7ce97299eb	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	F5/D	16	2019-12-04 15:09:30.491438	2019-12-04 15:09:30.491438
206743ec-16eb-11ea-8a37-6fc45d6447e3	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	C7sus4	60	2019-12-04 15:09:30.498378	2019-12-04 15:09:30.498378
206804d0-16eb-11ea-8a37-f7ee0caee516	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	F5	0	2019-12-04 15:09:30.503294	2019-12-04 15:09:30.503294
2068c596-16eb-11ea-8a37-ab852bcc7266	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	F5/Db	32	2019-12-04 15:09:30.508253	2019-12-04 15:09:30.508253
206985bc-16eb-11ea-8a37-8bbc6b058158	20630ebc-16eb-11ea-8a37-af1c14cc01bc	20652a3a-16eb-11ea-8a37-3b369a1a1bdb	Abmaj6	48	2019-12-04 15:09:30.513152	2019-12-04 15:09:30.513152
207b11a6-16eb-11ea-8a37-6b0199324e79	2078ee76-16eb-11ea-8a37-b7162aa1ef0f	207a5716-16eb-11ea-8a37-675479e03b84	NC	0	2019-12-04 15:09:30.628151	2019-12-04 15:09:30.628151
20915736-16eb-11ea-8a37-bf051b516e7c	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	Bmaj7	0	2019-12-04 15:09:30.774112	2019-12-04 15:09:30.774112
20925b86-16eb-11ea-8a37-b3e4ae99801a	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	Gb/Bb	8	2019-12-04 15:09:30.780776	2019-12-04 15:09:30.780776
209361de-16eb-11ea-8a37-a7cb0235ef13	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	Ab-7	28	2019-12-04 15:09:30.787498	2019-12-04 15:09:30.787498
20941dae-16eb-11ea-8a37-632d74208f7b	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	Gbsus4/Db	28	2019-12-04 15:09:30.792315	2019-12-04 15:09:30.792315
2094d852-16eb-11ea-8a37-03b067473d08	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	Gb/Ab	16	2019-12-04 15:09:30.797091	2019-12-04 15:09:30.797091
2095a2b4-16eb-11ea-8a37-bb8db2ed7980	208ccf18-16eb-11ea-8a37-cfe47cc0feee	208f2682-16eb-11ea-8a37-ff75635a4416	Eb-7	0	2019-12-04 15:09:30.802261	2019-12-04 15:09:30.802261
209662d0-16eb-11ea-8a37-3b1cbb7752e3	208ccf18-16eb-11ea-8a37-cfe47cc0feee	2090403a-16eb-11ea-8a37-e3907a35d9fe	Ab-7	0	2019-12-04 15:09:30.807189	2019-12-04 15:09:30.807189
20bdd6a8-16eb-11ea-8a37-6b8abd2e6a8c	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	Csus4	0	2019-12-04 15:09:31.065708	2019-12-04 15:09:31.065708
20bee3c2-16eb-11ea-8a37-bb9eb7c55516	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	Csus4/Bb	32	2019-12-04 15:09:31.072632	2019-12-04 15:09:31.072632
20bfe7fe-16eb-11ea-8a37-8fe64e8703fd	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	Csus4/D	16	2019-12-04 15:09:31.079266	2019-12-04 15:09:31.079266
20c0b012-16eb-11ea-8a37-a35f53f591aa	20ba8084-16eb-11ea-8a37-cb38a312de67	20bcc786-16eb-11ea-8a37-93afc61219c2	Csus4/A	48	2019-12-04 15:09:31.084406	2019-12-04 15:09:31.084406
\.


--
-- Data for Name: program_voice; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_voice (id, program_id, type, name, created_at, updated_at) FROM stdin;
20d856c2-16eb-11ea-8a37-2fd6619fce2a	20d07cc2-16eb-11ea-8a37-c32a94270435	Percussive	Extra	2019-12-04 15:09:31.23904	2019-12-04 15:09:31.23904
20d987c2-16eb-11ea-8a37-032944d7a9c6	20d07cc2-16eb-11ea-8a37-c32a94270435	Percussive	Kick/Snare B	2019-12-04 15:09:31.247133	2019-12-04 15:09:31.247133
20daa580-16eb-11ea-8a37-e30ce507d974	20d07cc2-16eb-11ea-8a37-c32a94270435	Percussive	Kick/Snare A	2019-12-04 15:09:31.254458	2019-12-04 15:09:31.254458
20dbbce0-16eb-11ea-8a37-db74fc12222b	20d07cc2-16eb-11ea-8a37-c32a94270435	Percussive	Locomotion	2019-12-04 15:09:31.261543	2019-12-04 15:09:31.261543
2164b0f4-16eb-11ea-8a37-5786ce3b6f25	215f31b0-16eb-11ea-8a37-4359224b0012	Percussive	Kick/Snare A	2019-12-04 15:09:32.15896	2019-12-04 15:09:32.15896
2165e71c-16eb-11ea-8a37-d30b988f0dd2	215f31b0-16eb-11ea-8a37-4359224b0012	Percussive	Kick/Snare B	2019-12-04 15:09:32.167076	2019-12-04 15:09:32.167076
2166f922-16eb-11ea-8a37-d38e96aaead0	215f31b0-16eb-11ea-8a37-4359224b0012	Percussive	Extra	2019-12-04 15:09:32.174096	2019-12-04 15:09:32.174096
2168075e-16eb-11ea-8a37-67d1e2c88db5	215f31b0-16eb-11ea-8a37-4359224b0012	Percussive	Locomotion	2019-12-04 15:09:32.181016	2019-12-04 15:09:32.181016
22a35ac4-16eb-11ea-8a37-5bef952c6386	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Toms+Congas+Misc	2019-12-04 15:09:34.247393	2019-12-04 15:09:34.247393
22a460a4-16eb-11ea-8a37-330dcac758d5	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Kick+Snare	2019-12-04 15:09:34.25429	2019-12-04 15:09:34.25429
22a54ad2-16eb-11ea-8a37-b327c1475968	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	2x4 Stomp	2019-12-04 15:09:34.26037	2019-12-04 15:09:34.26037
22a5ea00-16eb-11ea-8a37-a3f05f374e8d	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Locomotion	2019-12-04 15:09:34.264477	2019-12-04 15:09:34.264477
22a696f8-16eb-11ea-8a37-0ff33069a589	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Clave	2019-12-04 15:09:34.26885	2019-12-04 15:09:34.26885
22a738e2-16eb-11ea-8a37-fb625a56c56e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Vocal Echo	2019-12-04 15:09:34.273054	2019-12-04 15:09:34.273054
22a7cbb8-16eb-11ea-8a37-07d0892c91a8	2298444a-16eb-11ea-8a37-5389fe5c6d7c	Percussive	Vocal	2019-12-04 15:09:34.276807	2019-12-04 15:09:34.276807
\.


--
-- Data for Name: program_sequence_pattern; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence_pattern (id, program_id, program_sequence_id, program_voice_id, name, type, total, created_at, updated_at) FROM stdin;
20e5c3fc-16eb-11ea-8a37-4b948480cf9e	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Loop D	Loop	4	2019-12-04 15:09:31.326764	2019-12-04 15:09:31.326764
20e6e296-16eb-11ea-8a37-5f3c8b4fd66f	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Intro A	Intro	4	2019-12-04 15:09:31.33445	2019-12-04 15:09:31.33445
20e7a97e-16eb-11ea-8a37-f39deaa401c6	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Loop D	Loop	4	2019-12-04 15:09:31.339684	2019-12-04 15:09:31.339684
20e858d8-16eb-11ea-8a37-6ba5e84091b8	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Loop B	Loop	4	2019-12-04 15:09:31.344245	2019-12-04 15:09:31.344245
20e8fe00-16eb-11ea-8a37-af6130c9793a	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Loop B	Loop	4	2019-12-04 15:09:31.348488	2019-12-04 15:09:31.348488
20ea0bf6-16eb-11ea-8a37-1ff79c9f1212	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Loop A	Loop	4	2019-12-04 15:09:31.355508	2019-12-04 15:09:31.355508
20eb0ff6-16eb-11ea-8a37-130df4d87c41	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Loop D	Loop	4	2019-12-04 15:09:31.362218	2019-12-04 15:09:31.362218
20ec10f4-16eb-11ea-8a37-139689e9e2d8	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Intro A	Intro	4	2019-12-04 15:09:31.368765	2019-12-04 15:09:31.368765
20ed1be8-16eb-11ea-8a37-63448f16025c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Outro A	Outro	4	2019-12-04 15:09:31.375609	2019-12-04 15:09:31.375609
20edfa0e-16eb-11ea-8a37-fb8f6fabdd3e	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Outro A	Outro	4	2019-12-04 15:09:31.381262	2019-12-04 15:09:31.381262
20eedfa0-16eb-11ea-8a37-1be3dbbf9b73	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Loop C	Loop	4	2019-12-04 15:09:31.387198	2019-12-04 15:09:31.387198
20efe2ba-16eb-11ea-8a37-eb0c96cc1b02	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Loop A	Loop	4	2019-12-04 15:09:31.393711	2019-12-04 15:09:31.393711
20f0f3c6-16eb-11ea-8a37-e3415de3061a	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Loop B	Loop	4	2019-12-04 15:09:31.400688	2019-12-04 15:09:31.400688
20f1bea0-16eb-11ea-8a37-9b198d8d29aa	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Loop B	Loop	4	2019-12-04 15:09:31.405907	2019-12-04 15:09:31.405907
20f28768-16eb-11ea-8a37-f3b18771729a	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Loop D	Loop	4	2019-12-04 15:09:31.411059	2019-12-04 15:09:31.411059
20f4609c-16eb-11ea-8a37-c31d934999e7	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Loop C	Loop	4	2019-12-04 15:09:31.423127	2019-12-04 15:09:31.423127
20f54f2a-16eb-11ea-8a37-57071e4e224c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d987c2-16eb-11ea-8a37-032944d7a9c6	Intro A	Intro	4	2019-12-04 15:09:31.429243	2019-12-04 15:09:31.429243
20f623a0-16eb-11ea-8a37-5f1bd9ddd2d6	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Intro A	Intro	4	2019-12-04 15:09:31.434682	2019-12-04 15:09:31.434682
20f6ef60-16eb-11ea-8a37-ff1a281df670	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Loop C	Loop	4	2019-12-04 15:09:31.439902	2019-12-04 15:09:31.439902
20f7a982-16eb-11ea-8a37-ebe75eba03d9	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20d856c2-16eb-11ea-8a37-2fd6619fce2a	Loop A	Loop	4	2019-12-04 15:09:31.444737	2019-12-04 15:09:31.444737
20f85346-16eb-11ea-8a37-c3139a966c54	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Loop A	Loop	4	2019-12-04 15:09:31.449086	2019-12-04 15:09:31.449086
20f96736-16eb-11ea-8a37-fb20f76632a0	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Loop C	Loop	4	2019-12-04 15:09:31.456181	2019-12-04 15:09:31.456181
20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20dbbce0-16eb-11ea-8a37-db74fc12222b	Outro A	Outro	4	2019-12-04 15:09:31.46302	2019-12-04 15:09:31.46302
20fb8df4-16eb-11ea-8a37-13278229c54f	20d07cc2-16eb-11ea-8a37-c32a94270435	20e32188-16eb-11ea-8a37-df5e09e4df96	20daa580-16eb-11ea-8a37-e30ce507d974	Outro A	Outro	4	2019-12-04 15:09:31.470248	2019-12-04 15:09:31.470248
216f636e-16eb-11ea-8a37-efb2861fa9ac	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro D	Outro	4	2019-12-04 15:09:32.229333	2019-12-04 15:09:32.229333
2170254c-16eb-11ea-8a37-d7aecbb0fd8e	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro B	Outro	4	2019-12-04 15:09:32.23429	2019-12-04 15:09:32.23429
217153d6-16eb-11ea-8a37-27b78303b05d	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro C	Outro	4	2019-12-04 15:09:32.242042	2019-12-04 15:09:32.242042
217286de-16eb-11ea-8a37-e3ea47c2d55d	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A	Loop	4	2019-12-04 15:09:32.249882	2019-12-04 15:09:32.249882
2173bbe4-16eb-11ea-8a37-7b12391bf544	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro D	Outro	4	2019-12-04 15:09:32.257811	2019-12-04 15:09:32.257811
2174edde-16eb-11ea-8a37-fbcd3b7da5d3	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro A	Outro	4	2019-12-04 15:09:32.265582	2019-12-04 15:09:32.265582
2175fcc4-16eb-11ea-8a37-97b9f24d2605	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro A	Outro	4	2019-12-04 15:09:32.27258	2019-12-04 15:09:32.27258
21770e0c-16eb-11ea-8a37-b38953e07c93	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro C	Outro	4	2019-12-04 15:09:32.279565	2019-12-04 15:09:32.279565
217820da-16eb-11ea-8a37-bb9a492f179a	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro A	Outro	4	2019-12-04 15:09:32.286586	2019-12-04 15:09:32.286586
217929e4-16eb-11ea-8a37-8f8ef2bfd1d1	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A	Loop	4	2019-12-04 15:09:32.293394	2019-12-04 15:09:32.293394
2179f3ce-16eb-11ea-8a37-873a57a2db90	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro D	Outro	4	2019-12-04 15:09:32.298568	2019-12-04 15:09:32.298568
217ac65a-16eb-11ea-8a37-ebfe8130d36d	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (+kick on 3-and)	Loop	4	2019-12-04 15:09:32.303914	2019-12-04 15:09:32.303914
217b8de2-16eb-11ea-8a37-734b175d3f21	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro F	Outro	4	2019-12-04 15:09:32.309065	2019-12-04 15:09:32.309065
217c574a-16eb-11ea-8a37-2b8fb2a9fcb9	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Intro A	Intro	4	2019-12-04 15:09:32.314214	2019-12-04 15:09:32.314214
217d1aae-16eb-11ea-8a37-d3f6c2194848	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (tom on 4-and)	Loop	4	2019-12-04 15:09:32.319214	2019-12-04 15:09:32.319214
217dd764-16eb-11ea-8a37-17d702c822ca	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (+kick on 3-and)	Loop	4	2019-12-04 15:09:32.324055	2019-12-04 15:09:32.324055
217e9bb8-16eb-11ea-8a37-e34d2f292865	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (tom on 1-and)	Loop	4	2019-12-04 15:09:32.329083	2019-12-04 15:09:32.329083
217f69c6-16eb-11ea-8a37-737080a79993	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro F	Outro	4	2019-12-04 15:09:32.334348	2019-12-04 15:09:32.334348
21809ecc-16eb-11ea-8a37-ab31a867b7bd	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (tom on 3-and)	Loop	4	2019-12-04 15:09:32.342274	2019-12-04 15:09:32.342274
2181d864-16eb-11ea-8a37-6f9d74f03af5	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro F	Outro	4	2019-12-04 15:09:32.350275	2019-12-04 15:09:32.350275
21830df6-16eb-11ea-8a37-ff5e1ea7db94	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (tom on 1-and)	Loop	4	2019-12-04 15:09:32.358219	2019-12-04 15:09:32.358219
2184428e-16eb-11ea-8a37-abeefd8633e3	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro E	Outro	4	2019-12-04 15:09:32.366079	2019-12-04 15:09:32.366079
2185507a-16eb-11ea-8a37-4ff0a4514475	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (tom on 2-and)	Loop	4	2019-12-04 15:09:32.37303	2019-12-04 15:09:32.37303
21866708-16eb-11ea-8a37-c7e908c0cc30	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro C	Outro	4	2019-12-04 15:09:32.380143	2019-12-04 15:09:32.380143
2187751c-16eb-11ea-8a37-bbbec7888e87	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A	Loop	4	2019-12-04 15:09:32.387059	2019-12-04 15:09:32.387059
218880ba-16eb-11ea-8a37-275b65167db3	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro A	Outro	4	2019-12-04 15:09:32.393925	2019-12-04 15:09:32.393925
21894914-16eb-11ea-8a37-47f4eab16b4e	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (tom on 1-and)	Loop	4	2019-12-04 15:09:32.399006	2019-12-04 15:09:32.399006
218a12ea-16eb-11ea-8a37-63c4fe33be15	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (+snare on 3-and)	Loop	4	2019-12-04 15:09:32.404213	2019-12-04 15:09:32.404213
218adacc-16eb-11ea-8a37-7b33d10acf33	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro E	Outro	4	2019-12-04 15:09:32.409335	2019-12-04 15:09:32.409335
218ba59c-16eb-11ea-8a37-8b121df9ecb5	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro B	Outro	4	2019-12-04 15:09:32.414515	2019-12-04 15:09:32.414515
218c66ee-16eb-11ea-8a37-bbc4864e93e0	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro C	Outro	4	2019-12-04 15:09:32.419467	2019-12-04 15:09:32.419467
218d2804-16eb-11ea-8a37-bb55e643b16d	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (+snare on 3-and)	Loop	4	2019-12-04 15:09:32.424423	2019-12-04 15:09:32.424423
218de320-16eb-11ea-8a37-7354b435f9f9	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (tom on 3-and)	Loop	4	2019-12-04 15:09:32.429211	2019-12-04 15:09:32.429211
218eab0c-16eb-11ea-8a37-733add36209d	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (tom on 4-and)	Loop	4	2019-12-04 15:09:32.434324	2019-12-04 15:09:32.434324
218fe076-16eb-11ea-8a37-fb45e02080f3	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A	Loop	4	2019-12-04 15:09:32.442201	2019-12-04 15:09:32.442201
219121ac-16eb-11ea-8a37-8758a971c637	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (tom on 4-and)	Loop	4	2019-12-04 15:09:32.450405	2019-12-04 15:09:32.450405
21925f54-16eb-11ea-8a37-637f6976a474	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Outro B	Outro	4	2019-12-04 15:09:32.458602	2019-12-04 15:09:32.458602
21939810-16eb-11ea-8a37-cf509506f5dc	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro D	Outro	4	2019-12-04 15:09:32.466608	2019-12-04 15:09:32.466608
2194ab7e-16eb-11ea-8a37-8b6084d79d60	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (tom on 1-and)	Loop	4	2019-12-04 15:09:32.473593	2019-12-04 15:09:32.473593
2195c34c-16eb-11ea-8a37-b7e6dfa9ca3b	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro E	Outro	4	2019-12-04 15:09:32.480814	2019-12-04 15:09:32.480814
2196de6c-16eb-11ea-8a37-eb5cb1f9fcdf	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (tom on 3-and)	Loop	4	2019-12-04 15:09:32.488041	2019-12-04 15:09:32.488041
2197f950-16eb-11ea-8a37-1f9fd340842b	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Intro A	Intro	4	2019-12-04 15:09:32.495309	2019-12-04 15:09:32.495309
2198c6aa-16eb-11ea-8a37-3745c6affcca	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Outro B	Outro	4	2019-12-04 15:09:32.500554	2019-12-04 15:09:32.500554
21999120-16eb-11ea-8a37-0705b6016cda	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (tom on 2-and)	Loop	4	2019-12-04 15:09:32.505733	2019-12-04 15:09:32.505733
219a5916-16eb-11ea-8a37-7f67f09d94bd	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (tom on 2-and)	Loop	4	2019-12-04 15:09:32.510845	2019-12-04 15:09:32.510845
219b2486-16eb-11ea-8a37-335a13e3f780	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (+kick on 3-and)	Loop	4	2019-12-04 15:09:32.516078	2019-12-04 15:09:32.516078
219be6d2-16eb-11ea-8a37-fb21b007d62e	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Outro F	Outro	4	2019-12-04 15:09:32.521056	2019-12-04 15:09:32.521056
219cacac-16eb-11ea-8a37-e723ebadadc5	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (tom on 3-and)	Loop	4	2019-12-04 15:09:32.526128	2019-12-04 15:09:32.526128
219d6e94-16eb-11ea-8a37-bf854a31f308	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Loop A (+snare on 3-and)	Loop	4	2019-12-04 15:09:32.531093	2019-12-04 15:09:32.531093
219e2ea6-16eb-11ea-8a37-7b7d53675b93	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Loop A (tom on 2-and)	Loop	4	2019-12-04 15:09:32.536006	2019-12-04 15:09:32.536006
219f6762-16eb-11ea-8a37-036670eedde6	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Loop A (+snare on 3-and)	Loop	4	2019-12-04 15:09:32.543993	2019-12-04 15:09:32.543993
21a0a096-16eb-11ea-8a37-cb73502da9e4	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2168075e-16eb-11ea-8a37-67d1e2c88db5	Outro E	Outro	4	2019-12-04 15:09:32.551992	2019-12-04 15:09:32.551992
21a1ecee-16eb-11ea-8a37-23b49f24b6f6	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2166f922-16eb-11ea-8a37-d38e96aaead0	Intro A	Intro	4	2019-12-04 15:09:32.56049	2019-12-04 15:09:32.56049
21a32992-16eb-11ea-8a37-c710430d8ccb	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (+kick on 3-and)	Loop	4	2019-12-04 15:09:32.568593	2019-12-04 15:09:32.568593
21a43cc4-16eb-11ea-8a37-17d100189582	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2165e71c-16eb-11ea-8a37-d30b988f0dd2	Intro A	Intro	4	2019-12-04 15:09:32.57566	2019-12-04 15:09:32.57566
21a54f9c-16eb-11ea-8a37-4b319fb6be1c	215f31b0-16eb-11ea-8a37-4359224b0012	216e00be-16eb-11ea-8a37-73b18b937c1a	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	Loop A (tom on 4-and)	Loop	4	2019-12-04 15:09:32.582719	2019-12-04 15:09:32.582719
22b0e234-16eb-11ea-8a37-f7e2f90bb13a	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a460a4-16eb-11ea-8a37-330dcac758d5	drop d beet	Loop	4	2019-12-04 15:09:34.33639	2019-12-04 15:09:34.33639
22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a5ea00-16eb-11ea-8a37-a3f05f374e8d	drop d beet	Loop	4	2019-12-04 15:09:34.342138	2019-12-04 15:09:34.342138
22b2a7cc-16eb-11ea-8a37-4f413992d080	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a7cbb8-16eb-11ea-8a37-07d0892c91a8	drop d beet	Loop	4	2019-12-04 15:09:34.347996	2019-12-04 15:09:34.347996
22b3852a-16eb-11ea-8a37-ab76ef4eae00	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a35ac4-16eb-11ea-8a37-5bef952c6386	drop d beet	Loop	4	2019-12-04 15:09:34.353668	2019-12-04 15:09:34.353668
22b413b4-16eb-11ea-8a37-b7c19756ee69	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a738e2-16eb-11ea-8a37-fb625a56c56e	drop d beet	Loop	4	2019-12-04 15:09:34.357333	2019-12-04 15:09:34.357333
22b4a31a-16eb-11ea-8a37-e77838c0a187	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a696f8-16eb-11ea-8a37-0ff33069a589	drop d beet	Loop	4	2019-12-04 15:09:34.360969	2019-12-04 15:09:34.360969
22b53320-16eb-11ea-8a37-9f79413757cf	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22af0bb2-16eb-11ea-8a37-c3cc17fd4302	22a54ad2-16eb-11ea-8a37-b327c1475968	drop d beet	Loop	4	2019-12-04 15:09:34.364683	2019-12-04 15:09:34.364683
\.


--
-- Data for Name: program_voice_track; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_voice_track (id, program_id, program_voice_id, name, created_at, updated_at) FROM stdin;
20dd3c78-16eb-11ea-8a37-63a8cb662822	20d07cc2-16eb-11ea-8a37-c32a94270435	20d987c2-16eb-11ea-8a37-032944d7a9c6	SNARE	2019-12-04 15:09:31.27128	2019-12-04 15:09:31.27128
20de4a50-16eb-11ea-8a37-af906b2cf85d	20d07cc2-16eb-11ea-8a37-c32a94270435	20dbbce0-16eb-11ea-8a37-db74fc12222b	HIHATOPEN	2019-12-04 15:09:31.278311	2019-12-04 15:09:31.278311
20df434c-16eb-11ea-8a37-6303da4a8227	20d07cc2-16eb-11ea-8a37-c32a94270435	20d856c2-16eb-11ea-8a37-2fd6619fce2a	TOM	2019-12-04 15:09:31.284705	2019-12-04 15:09:31.284705
20e0528c-16eb-11ea-8a37-0b339fe59fad	20d07cc2-16eb-11ea-8a37-c32a94270435	20daa580-16eb-11ea-8a37-e30ce507d974	KICK	2019-12-04 15:09:31.291478	2019-12-04 15:09:31.291478
20e1740a-16eb-11ea-8a37-e7330ee09af0	20d07cc2-16eb-11ea-8a37-c32a94270435	20dbbce0-16eb-11ea-8a37-db74fc12222b	HIHAT	2019-12-04 15:09:31.298907	2019-12-04 15:09:31.298907
20e249fc-16eb-11ea-8a37-0f0bd01aadb7	20d07cc2-16eb-11ea-8a37-c32a94270435	20d856c2-16eb-11ea-8a37-2fd6619fce2a	CRASH	2019-12-04 15:09:31.30452	2019-12-04 15:09:31.30452
21692bfc-16eb-11ea-8a37-97b3fc27408a	215f31b0-16eb-11ea-8a37-4359224b0012	2165e71c-16eb-11ea-8a37-d30b988f0dd2	SNARE	2019-12-04 15:09:32.188502	2019-12-04 15:09:32.188502
216a302e-16eb-11ea-8a37-939e7143d52d	215f31b0-16eb-11ea-8a37-4359224b0012	2166f922-16eb-11ea-8a37-d38e96aaead0	CRASH	2019-12-04 15:09:32.195174	2019-12-04 15:09:32.195174
216b065c-16eb-11ea-8a37-d3740e001fd2	215f31b0-16eb-11ea-8a37-4359224b0012	2168075e-16eb-11ea-8a37-67d1e2c88db5	HIHAT	2019-12-04 15:09:32.200644	2019-12-04 15:09:32.200644
216bcf10-16eb-11ea-8a37-37c6be6647c3	215f31b0-16eb-11ea-8a37-4359224b0012	2166f922-16eb-11ea-8a37-d38e96aaead0	TOM	2019-12-04 15:09:32.205757	2019-12-04 15:09:32.205757
216c8c98-16eb-11ea-8a37-8b624f6028b1	215f31b0-16eb-11ea-8a37-4359224b0012	2168075e-16eb-11ea-8a37-67d1e2c88db5	HIHATOPEN	2019-12-04 15:09:32.210726	2019-12-04 15:09:32.210726
216d44b2-16eb-11ea-8a37-836e4aac26d3	215f31b0-16eb-11ea-8a37-4359224b0012	2164b0f4-16eb-11ea-8a37-5786ce3b6f25	KICK	2019-12-04 15:09:32.215447	2019-12-04 15:09:32.215447
22a87f40-16eb-11ea-8a37-a7c0938722dd	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a696f8-16eb-11ea-8a37-0ff33069a589	TOM	2019-12-04 15:09:34.281313	2019-12-04 15:09:34.281313
22a9249a-16eb-11ea-8a37-cb18a38e61fb	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a460a4-16eb-11ea-8a37-330dcac758d5	SNARE	2019-12-04 15:09:34.285553	2019-12-04 15:09:34.285553
22a9ba2c-16eb-11ea-8a37-43395c4fb79b	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a460a4-16eb-11ea-8a37-330dcac758d5	KICK	2019-12-04 15:09:34.289463	2019-12-04 15:09:34.289463
22abf54e-16eb-11ea-8a37-7783533f3483	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a5ea00-16eb-11ea-8a37-a3f05f374e8d	HIHAT	2019-12-04 15:09:34.304094	2019-12-04 15:09:34.304094
22ad0880-16eb-11ea-8a37-9755071eaf39	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a5ea00-16eb-11ea-8a37-a3f05f374e8d	HIHATOPEN	2019-12-04 15:09:34.311147	2019-12-04 15:09:34.311147
22ae0be0-16eb-11ea-8a37-9b5f1dc97d09	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22a35ac4-16eb-11ea-8a37-5bef952c6386	CRASH	2019-12-04 15:09:34.317789	2019-12-04 15:09:34.317789
\.


--
-- Data for Name: program_sequence_pattern_event; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.program_sequence_pattern_event (id, program_id, program_sequence_pattern_id, program_voice_track_id, velocity, "position", duration, note, created_at, updated_at) FROM stdin;
20fd7452-16eb-11ea-8a37-a31487a7a82a	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:31.48224	2019-12-04 15:09:31.48224
20feb8e4-16eb-11ea-8a37-bb3efdb111a4	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.33	3.25	0.25	X	2019-12-04 15:09:31.490802	2019-12-04 15:09:31.490802
20ffcae0-16eb-11ea-8a37-3f07eaaacfd3	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:31.497858	2019-12-04 15:09:31.497858
2100d5a2-16eb-11ea-8a37-e36311e9681b	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	G12	2019-12-04 15:09:31.504682	2019-12-04 15:09:31.504682
2101d84e-16eb-11ea-8a37-ffe51cdbd93e	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	X	2019-12-04 15:09:31.51128	2019-12-04 15:09:31.51128
2102a148-16eb-11ea-8a37-5712e982f72b	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:31.516539	2019-12-04 15:09:31.516539
2103629a-16eb-11ea-8a37-dbf9b23914c9	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	G12	2019-12-04 15:09:31.521466	2019-12-04 15:09:31.521466
21041bae-16eb-11ea-8a37-a714e3d9fe5c	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:31.526256	2019-12-04 15:09:31.526256
2104e7b4-16eb-11ea-8a37-5b3979f4f57a	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	G12	2019-12-04 15:09:31.531472	2019-12-04 15:09:31.531472
210596dc-16eb-11ea-8a37-87ac076b8ebe	20d07cc2-16eb-11ea-8a37-c32a94270435	20f4609c-16eb-11ea-8a37-c31d934999e7	20df434c-16eb-11ea-8a37-6303da4a8227	0.1	2.5	1.5	X	2019-12-04 15:09:31.535949	2019-12-04 15:09:31.535949
2106430c-16eb-11ea-8a37-ab2e89ab10d5	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:31.540439	2019-12-04 15:09:31.540439
2106ebae-16eb-11ea-8a37-a77964c3288b	20d07cc2-16eb-11ea-8a37-c32a94270435	20edfa0e-16eb-11ea-8a37-fb8f6fabdd3e	20dd3c78-16eb-11ea-8a37-63a8cb662822	0.1	2.75	0.25	X	2019-12-04 15:09:31.544743	2019-12-04 15:09:31.544743
210798d8-16eb-11ea-8a37-37e1a99eabea	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:31.549171	2019-12-04 15:09:31.549171
2108bbf0-16eb-11ea-8a37-db506fe4edca	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:31.556628	2019-12-04 15:09:31.556628
2109e516-16eb-11ea-8a37-0b656c532ea9	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:31.56418	2019-12-04 15:09:31.56418
210c1c6e-16eb-11ea-8a37-1b80dc6c6d8a	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.75	0.25	X	2019-12-04 15:09:31.578682	2019-12-04 15:09:31.578682
210d7a50-16eb-11ea-8a37-d7b2ca9d253a	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:31.587659	2019-12-04 15:09:31.587659
210e9354-16eb-11ea-8a37-7f17b9361e4e	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:31.594867	2019-12-04 15:09:31.594867
210fae38-16eb-11ea-8a37-df7da58f67c5	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:31.602105	2019-12-04 15:09:31.602105
2110bf30-16eb-11ea-8a37-93688b8e76ee	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:31.609098	2019-12-04 15:09:31.609098
2111d2d0-16eb-11ea-8a37-bfcfe42a40fe	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:31.616123	2019-12-04 15:09:31.616123
21129d5a-16eb-11ea-8a37-93019f114c5a	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.75	0.25	X	2019-12-04 15:09:31.62133	2019-12-04 15:09:31.62133
21136d98-16eb-11ea-8a37-4f25ddd7d035	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:31.626659	2019-12-04 15:09:31.626659
2114364c-16eb-11ea-8a37-d3c37a370fd6	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.75	0.25	X	2019-12-04 15:09:31.631799	2019-12-04 15:09:31.631799
211503f6-16eb-11ea-8a37-ebbd575239a5	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1.75	0.25	X	2019-12-04 15:09:31.637055	2019-12-04 15:09:31.637055
2115c70a-16eb-11ea-8a37-3fe115931b3f	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.75	0.25	X	2019-12-04 15:09:31.642061	2019-12-04 15:09:31.642061
21168d5c-16eb-11ea-8a37-bbe6a77acadb	20d07cc2-16eb-11ea-8a37-c32a94270435	20fb8df4-16eb-11ea-8a37-13278229c54f	20e0528c-16eb-11ea-8a37-0b339fe59fad	0.5	3.5	0.5	X	2019-12-04 15:09:31.647135	2019-12-04 15:09:31.647135
21174ada-16eb-11ea-8a37-6b7bfc7ccc18	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	X	2019-12-04 15:09:31.65199	2019-12-04 15:09:31.65199
21180cae-16eb-11ea-8a37-2b09b5913919	20d07cc2-16eb-11ea-8a37-c32a94270435	20f4609c-16eb-11ea-8a37-c31d934999e7	20df434c-16eb-11ea-8a37-6303da4a8227	0.33	1.75	0.75	X	2019-12-04 15:09:31.65695	2019-12-04 15:09:31.65695
21194466-16eb-11ea-8a37-87effce3cb2f	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.75	0.25	X	2019-12-04 15:09:31.664918	2019-12-04 15:09:31.664918
211a7c50-16eb-11ea-8a37-abc810741888	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.75	0.25	X	2019-12-04 15:09:31.672897	2019-12-04 15:09:31.672897
211bb912-16eb-11ea-8a37-9f306e43abdd	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:31.681004	2019-12-04 15:09:31.681004
211cf6e2-16eb-11ea-8a37-774833d66f44	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:31.689184	2019-12-04 15:09:31.689184
211de44e-16eb-11ea-8a37-2b3e5ea48fec	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:31.69532	2019-12-04 15:09:31.69532
211ecd6e-16eb-11ea-8a37-736084b43487	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:31.701297	2019-12-04 15:09:31.701297
211fa982-16eb-11ea-8a37-0f3a8eb1380c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.25	0.25	G12	2019-12-04 15:09:31.706947	2019-12-04 15:09:31.706947
2120844c-16eb-11ea-8a37-1fef5351c698	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:31.712544	2019-12-04 15:09:31.712544
212116dc-16eb-11ea-8a37-e76ab9b6b3be	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.33	3.25	0.25	X	2019-12-04 15:09:31.716294	2019-12-04 15:09:31.716294
2121a6e2-16eb-11ea-8a37-ef6316504aff	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:31.72	2019-12-04 15:09:31.72
21223314-16eb-11ea-8a37-276538c4eebd	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:31.723595	2019-12-04 15:09:31.723595
2122bd48-16eb-11ea-8a37-47aed50e902d	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:31.727136	2019-12-04 15:09:31.727136
2123456a-16eb-11ea-8a37-27dfc74f277c	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:31.730601	2019-12-04 15:09:31.730601
2123d106-16eb-11ea-8a37-a3dab7dbf45a	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:31.734184	2019-12-04 15:09:31.734184
212457c0-16eb-11ea-8a37-a76d9ded8c8f	20d07cc2-16eb-11ea-8a37-c32a94270435	20edfa0e-16eb-11ea-8a37-fb8f6fabdd3e	20dd3c78-16eb-11ea-8a37-63a8cb662822	0.62	3	1	X	2019-12-04 15:09:31.737642	2019-12-04 15:09:31.737642
2124dcf4-16eb-11ea-8a37-dbe7504b2539	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	X	2019-12-04 15:09:31.741051	2019-12-04 15:09:31.741051
2125e338-16eb-11ea-8a37-1b582fc0bc5d	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.25	0.25	G12	2019-12-04 15:09:31.747731	2019-12-04 15:09:31.747731
2126feda-16eb-11ea-8a37-332194705717	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:31.754974	2019-12-04 15:09:31.754974
212810ea-16eb-11ea-8a37-e3e6eea8ba7a	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:31.762025	2019-12-04 15:09:31.762025
21291a1c-16eb-11ea-8a37-9f5f7a1b2fed	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:31.76881	2019-12-04 15:09:31.76881
212a0148-16eb-11ea-8a37-e3ba7cbcfa66	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.75	0.25	X	2019-12-04 15:09:31.774729	2019-12-04 15:09:31.774729
212af24c-16eb-11ea-8a37-4b683deda0cd	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:31.7809	2019-12-04 15:09:31.7809
212bd75c-16eb-11ea-8a37-eb10fd79783d	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.75	0.25	X	2019-12-04 15:09:31.786746	2019-12-04 15:09:31.786746
212cc964-16eb-11ea-8a37-c3497446935c	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:31.79293	2019-12-04 15:09:31.79293
212d8c46-16eb-11ea-8a37-874829481bc7	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	E12	2019-12-04 15:09:31.79785	2019-12-04 15:09:31.79785
212e56a8-16eb-11ea-8a37-47ca94f8b6c0	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.75	0.25	X	2019-12-04 15:09:31.803043	2019-12-04 15:09:31.803043
212f1e4e-16eb-11ea-8a37-f35aae14e49c	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:31.808107	2019-12-04 15:09:31.808107
212fe568-16eb-11ea-8a37-eb90e3696f01	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.75	0.25	X	2019-12-04 15:09:31.813233	2019-12-04 15:09:31.813233
2130acaa-16eb-11ea-8a37-938045e15ac6	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:31.818331	2019-12-04 15:09:31.818331
21317072-16eb-11ea-8a37-c3f0142280f9	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.25	0.25	G12	2019-12-04 15:09:31.82335	2019-12-04 15:09:31.82335
21322fe4-16eb-11ea-8a37-1b0c64cfad87	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:31.828254	2019-12-04 15:09:31.828254
2132f438-16eb-11ea-8a37-3f4c21eae487	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3.75	0.25	X	2019-12-04 15:09:31.833219	2019-12-04 15:09:31.833219
21342f38-16eb-11ea-8a37-bf123dffe2d1	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:31.84133	2019-12-04 15:09:31.84133
213582fc-16eb-11ea-8a37-03c25f01685d	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.25	0.25	G12	2019-12-04 15:09:31.849945	2019-12-04 15:09:31.849945
2136c05e-16eb-11ea-8a37-23c252cfe786	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:31.858148	2019-12-04 15:09:31.858148
2138023e-16eb-11ea-8a37-2fdbc632476b	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:31.866378	2019-12-04 15:09:31.866378
2139144e-16eb-11ea-8a37-ab2f4ad7b6d2	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2.75	0.25	X	2019-12-04 15:09:31.873392	2019-12-04 15:09:31.873392
213a3018-16eb-11ea-8a37-7b8d08f36f39	20d07cc2-16eb-11ea-8a37-c32a94270435	20f28768-16eb-11ea-8a37-f3b18771729a	20e249fc-16eb-11ea-8a37-0f0bd01aadb7	0.62	0	4	X	2019-12-04 15:09:31.880671	2019-12-04 15:09:31.880671
213b41f6-16eb-11ea-8a37-af65853167b0	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.75	0.25	X	2019-12-04 15:09:31.887687	2019-12-04 15:09:31.887687
213c512c-16eb-11ea-8a37-33db8ce66e2a	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:31.894641	2019-12-04 15:09:31.894641
213d1b3e-16eb-11ea-8a37-ff75dbbcdfdf	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	G12	2019-12-04 15:09:31.899802	2019-12-04 15:09:31.899802
213de8ca-16eb-11ea-8a37-7fdabafbcf2e	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:31.905047	2019-12-04 15:09:31.905047
213ed852-16eb-11ea-8a37-9b35c43307d5	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:31.911111	2019-12-04 15:09:31.911111
213fbbf0-16eb-11ea-8a37-cfaace84145c	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:31.916947	2019-12-04 15:09:31.916947
2140a1dc-16eb-11ea-8a37-7f69ebffc1fa	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:31.922856	2019-12-04 15:09:31.922856
21415d2a-16eb-11ea-8a37-a33e74016cd8	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:31.927748	2019-12-04 15:09:31.927748
2141f6a4-16eb-11ea-8a37-c718dbfafecb	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:31.931732	2019-12-04 15:09:31.931732
214291b8-16eb-11ea-8a37-bb2d798d5183	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:31.935693	2019-12-04 15:09:31.935693
21439e8c-16eb-11ea-8a37-8341100f2345	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:31.942578	2019-12-04 15:09:31.942578
2144e6c0-16eb-11ea-8a37-f7466f83a9a7	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:31.950826	2019-12-04 15:09:31.950826
21462882-16eb-11ea-8a37-075ad4f85f5b	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:31.959099	2019-12-04 15:09:31.959099
21476332-16eb-11ea-8a37-d3c3f82e9aa4	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:31.967186	2019-12-04 15:09:31.967186
21487b64-16eb-11ea-8a37-abb682751035	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:31.974364	2019-12-04 15:09:31.974364
2149933c-16eb-11ea-8a37-f7ba252c061c	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	X	2019-12-04 15:09:31.981444	2019-12-04 15:09:31.981444
214aa43e-16eb-11ea-8a37-a7c67db4a046	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:31.988513	2019-12-04 15:09:31.988513
214bae88-16eb-11ea-8a37-9b3f4d25a7e5	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:31.995336	2019-12-04 15:09:31.995336
214c7ac0-16eb-11ea-8a37-7fe2db061d01	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	2.5	0.5	X	2019-12-04 15:09:32.000561	2019-12-04 15:09:32.000561
214d42ca-16eb-11ea-8a37-c37ad1e4a7eb	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	1	0.25	X	2019-12-04 15:09:32.005679	2019-12-04 15:09:32.005679
214e0b4c-16eb-11ea-8a37-27b0ce1bd6c7	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	3.5	0.5	X	2019-12-04 15:09:32.010799	2019-12-04 15:09:32.010799
214ee422-16eb-11ea-8a37-afcce179e34a	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	2	0.25	X	2019-12-04 15:09:32.016271	2019-12-04 15:09:32.016271
214fb136-16eb-11ea-8a37-4b96f12104c2	20d07cc2-16eb-11ea-8a37-c32a94270435	20e8fe00-16eb-11ea-8a37-af6130c9793a	20df434c-16eb-11ea-8a37-6303da4a8227	0.1	1.5	2.5	X	2019-12-04 15:09:32.021539	2019-12-04 15:09:32.021539
21507800-16eb-11ea-8a37-e37bfeb17884	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	3	0.25	X	2019-12-04 15:09:32.026708	2019-12-04 15:09:32.026708
21513b96-16eb-11ea-8a37-97c9ab1fd75d	20d07cc2-16eb-11ea-8a37-c32a94270435	20f85346-16eb-11ea-8a37-c3139a966c54	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.25	0.25	E8	2019-12-04 15:09:32.031719	2019-12-04 15:09:32.031719
215200d0-16eb-11ea-8a37-77da9aefd734	20d07cc2-16eb-11ea-8a37-c32a94270435	20f623a0-16eb-11ea-8a37-5f1bd9ddd2d6	20e249fc-16eb-11ea-8a37-0f0bd01aadb7	0.62	0	4	X	2019-12-04 15:09:32.036758	2019-12-04 15:09:32.036758
21533608-16eb-11ea-8a37-3bf26d55e2e0	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.25	0.25	G12	2019-12-04 15:09:32.044661	2019-12-04 15:09:32.044661
215474fa-16eb-11ea-8a37-5f9d5767f4d3	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.75	0.25	X	2019-12-04 15:09:32.052795	2019-12-04 15:09:32.052795
2155ac4e-16eb-11ea-8a37-f3f5398d4000	20d07cc2-16eb-11ea-8a37-c32a94270435	20f6ef60-16eb-11ea-8a37-ff1a281df670	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0.75	0.25	X	2019-12-04 15:09:32.060811	2019-12-04 15:09:32.060811
2156dd30-16eb-11ea-8a37-0b3e2c4693e4	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.05	0	0.25	X	2019-12-04 15:09:32.068602	2019-12-04 15:09:32.068602
2157e946-16eb-11ea-8a37-636fcc7b151a	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	G12	2019-12-04 15:09:32.07548	2019-12-04 15:09:32.07548
21590cfe-16eb-11ea-8a37-37aad43816f1	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	0.25	0.25	X	2019-12-04 15:09:32.082874	2019-12-04 15:09:32.082874
215a233c-16eb-11ea-8a37-2fdbdf460454	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	3.75	0.25	X	2019-12-04 15:09:32.090057	2019-12-04 15:09:32.090057
215b311e-16eb-11ea-8a37-333c5b0af7de	20d07cc2-16eb-11ea-8a37-c32a94270435	20ec10f4-16eb-11ea-8a37-139689e9e2d8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	1.75	0.25	X	2019-12-04 15:09:32.09698	2019-12-04 15:09:32.09698
215bffd6-16eb-11ea-8a37-ebe120878c75	20d07cc2-16eb-11ea-8a37-c32a94270435	20e8fe00-16eb-11ea-8a37-af6130c9793a	20df434c-16eb-11ea-8a37-6303da4a8227	0.33	0.75	0.75	X	2019-12-04 15:09:32.102262	2019-12-04 15:09:32.102262
215cc9d4-16eb-11ea-8a37-9779f030105a	20d07cc2-16eb-11ea-8a37-c32a94270435	20eb0ff6-16eb-11ea-8a37-130df4d87c41	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	0.5	0.5	X	2019-12-04 15:09:32.107441	2019-12-04 15:09:32.107441
215d9a3a-16eb-11ea-8a37-47df44599d7d	20d07cc2-16eb-11ea-8a37-c32a94270435	20fa711c-16eb-11ea-8a37-5fbf76de2d5c	20de4a50-16eb-11ea-8a37-af906b2cf85d	0.2	1.5	0.5	X	2019-12-04 15:09:32.112743	2019-12-04 15:09:32.112743
215e669a-16eb-11ea-8a37-9fd114a4d6e9	20d07cc2-16eb-11ea-8a37-c32a94270435	20e858d8-16eb-11ea-8a37-6ba5e84091b8	20e1740a-16eb-11ea-8a37-e7330ee09af0	0.1	2.75	0.25	X	2019-12-04 15:09:32.118001	2019-12-04 15:09:32.118001
21a6494c-16eb-11ea-8a37-67fc629e6549	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:32.589173	2019-12-04 15:09:32.589173
21a72f4c-16eb-11ea-8a37-a73cf23dedbf	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:32.595072	2019-12-04 15:09:32.595072
21a7d96a-16eb-11ea-8a37-7b447df86cac	215f31b0-16eb-11ea-8a37-4359224b0012	218fe076-16eb-11ea-8a37-fb45e02080f3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	2.25	1.75	X	2019-12-04 15:09:32.599413	2019-12-04 15:09:32.599413
21a8811c-16eb-11ea-8a37-eb2e69ff92f3	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:32.603688	2019-12-04 15:09:32.603688
21a92342-16eb-11ea-8a37-8f0d4167fc8d	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.607872	2019-12-04 15:09:32.607872
21a9bf96-16eb-11ea-8a37-9fd53967747e	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:32.611876	2019-12-04 15:09:32.611876
21aa588e-16eb-11ea-8a37-9b37cd027863	215f31b0-16eb-11ea-8a37-4359224b0012	217929e4-16eb-11ea-8a37-8f8ef2bfd1d1	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:32.615811	2019-12-04 15:09:32.615811
21aaf50a-16eb-11ea-8a37-57d605f3a101	215f31b0-16eb-11ea-8a37-4359224b0012	21866708-16eb-11ea-8a37-c7e908c0cc30	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.05	3.5	0.5	X	2019-12-04 15:09:32.619799	2019-12-04 15:09:32.619799
21ab85ba-16eb-11ea-8a37-03d4936a2ff7	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:32.623518	2019-12-04 15:09:32.623518
21ac12d2-16eb-11ea-8a37-bf685d6fad3b	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:32.627141	2019-12-04 15:09:32.627141
21ad1cfe-16eb-11ea-8a37-076a543443ee	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:32.633936	2019-12-04 15:09:32.633936
21ae228e-16eb-11ea-8a37-ab701255ebe8	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:32.640647	2019-12-04 15:09:32.640647
21af2c38-16eb-11ea-8a37-c3857c788ab3	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:32.647428	2019-12-04 15:09:32.647428
21b0528e-16eb-11ea-8a37-9fc9b964a54d	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:32.654882	2019-12-04 15:09:32.654882
21b1452c-16eb-11ea-8a37-83bacafcd21c	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.661148	2019-12-04 15:09:32.661148
21b3bf50-16eb-11ea-8a37-ff7daac47617	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:32.677402	2019-12-04 15:09:32.677402
21b4a9ec-16eb-11ea-8a37-2fd0877139fb	215f31b0-16eb-11ea-8a37-4359224b0012	21a32992-16eb-11ea-8a37-c710430d8ccb	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	1.75	0.5	X	2019-12-04 15:09:32.683412	2019-12-04 15:09:32.683412
21b58d26-16eb-11ea-8a37-5729d09dfc52	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.689262	2019-12-04 15:09:32.689262
21b62768-16eb-11ea-8a37-03f8ba9c5630	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:32.693214	2019-12-04 15:09:32.693214
21b6be30-16eb-11ea-8a37-b3776b6e5def	215f31b0-16eb-11ea-8a37-4359224b0012	217c574a-16eb-11ea-8a37-2b8fb2a9fcb9	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	1.75	2.25	X	2019-12-04 15:09:32.697073	2019-12-04 15:09:32.697073
21b7562e-16eb-11ea-8a37-bbf7aa60a417	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.700958	2019-12-04 15:09:32.700958
21b7ef8a-16eb-11ea-8a37-3b0fe55b8b71	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:32.704878	2019-12-04 15:09:32.704878
21b889a4-16eb-11ea-8a37-afe8603d4039	215f31b0-16eb-11ea-8a37-4359224b0012	21939810-16eb-11ea-8a37-cf509506f5dc	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.33	3.5	0.5	X	2019-12-04 15:09:32.708816	2019-12-04 15:09:32.708816
21b93840-16eb-11ea-8a37-a77b282233ac	215f31b0-16eb-11ea-8a37-4359224b0012	218adacc-16eb-11ea-8a37-7b33d10acf33	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	1.75	X	2019-12-04 15:09:32.713211	2019-12-04 15:09:32.713211
21b9f71c-16eb-11ea-8a37-4342933ceded	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.718094	2019-12-04 15:09:32.718094
21babecc-16eb-11ea-8a37-1307d4730d53	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:32.723201	2019-12-04 15:09:32.723201
21bbf45e-16eb-11ea-8a37-dfe4d073f36d	215f31b0-16eb-11ea-8a37-4359224b0012	2194ab7e-16eb-11ea-8a37-8b6084d79d60	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:32.731128	2019-12-04 15:09:32.731128
21bd2eb4-16eb-11ea-8a37-839a3210b78a	215f31b0-16eb-11ea-8a37-4359224b0012	21999120-16eb-11ea-8a37-0705b6016cda	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	2	1.25	X	2019-12-04 15:09:32.739156	2019-12-04 15:09:32.739156
21be8426-16eb-11ea-8a37-6f0cc68bde14	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:32.747723	2019-12-04 15:09:32.747723
21bfce8a-16eb-11ea-8a37-7bd87003fec2	215f31b0-16eb-11ea-8a37-4359224b0012	218fe076-16eb-11ea-8a37-fb45e02080f3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	1.75	X	2019-12-04 15:09:32.756343	2019-12-04 15:09:32.756343
21c0de60-16eb-11ea-8a37-23a4d8218ce2	215f31b0-16eb-11ea-8a37-4359224b0012	2181d864-16eb-11ea-8a37-6f9d74f03af5	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:32.763331	2019-12-04 15:09:32.763331
21c1fc00-16eb-11ea-8a37-db1f09f047b4	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:32.770622	2019-12-04 15:09:32.770622
21c3244a-16eb-11ea-8a37-c7592edab1dc	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:32.778168	2019-12-04 15:09:32.778168
21c442e4-16eb-11ea-8a37-6b280e924e05	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.785442	2019-12-04 15:09:32.785442
21c511ec-16eb-11ea-8a37-d3472ec0f2f3	215f31b0-16eb-11ea-8a37-4359224b0012	21939810-16eb-11ea-8a37-cf509506f5dc	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	0.25	1.5	X	2019-12-04 15:09:32.790849	2019-12-04 15:09:32.790849
21c5d870-16eb-11ea-8a37-c72ba20f1148	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:32.795936	2019-12-04 15:09:32.795936
21c6a214-16eb-11ea-8a37-0f8e75f955e0	215f31b0-16eb-11ea-8a37-4359224b0012	217b8de2-16eb-11ea-8a37-734b175d3f21	216a302e-16eb-11ea-8a37-939e7143d52d	0.2046	3	1	X	2019-12-04 15:09:32.801088	2019-12-04 15:09:32.801088
21c76cd0-16eb-11ea-8a37-4bf90f338435	215f31b0-16eb-11ea-8a37-4359224b0012	2194ab7e-16eb-11ea-8a37-8b6084d79d60	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:32.806285	2019-12-04 15:09:32.806285
21c83f34-16eb-11ea-8a37-370df32099f2	215f31b0-16eb-11ea-8a37-4359224b0012	218d2804-16eb-11ea-8a37-bb55e643b16d	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	3.5	X	2019-12-04 15:09:32.811666	2019-12-04 15:09:32.811666
21c90d7e-16eb-11ea-8a37-dfd7b0bfc4db	215f31b0-16eb-11ea-8a37-4359224b0012	217ac65a-16eb-11ea-8a37-ebfe8130d36d	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:32.816958	2019-12-04 15:09:32.816958
21c9d6c8-16eb-11ea-8a37-2776526529ab	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:32.82212	2019-12-04 15:09:32.82212
21ca9ca2-16eb-11ea-8a37-4f952b99c758	215f31b0-16eb-11ea-8a37-4359224b0012	2173bbe4-16eb-11ea-8a37-7b12391bf544	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	1.75	X	2019-12-04 15:09:32.827184	2019-12-04 15:09:32.827184
21cbd31a-16eb-11ea-8a37-f7ab2d495ae6	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:32.835125	2019-12-04 15:09:32.835125
21cd0b2c-16eb-11ea-8a37-4b51038094f6	215f31b0-16eb-11ea-8a37-4359224b0012	219b2486-16eb-11ea-8a37-335a13e3f780	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	3.25	0.75	X	2019-12-04 15:09:32.843093	2019-12-04 15:09:32.843093
21ce57a2-16eb-11ea-8a37-cf61172a143c	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:32.851567	2019-12-04 15:09:32.851567
21cf9b80-16eb-11ea-8a37-2381756939ad	215f31b0-16eb-11ea-8a37-4359224b0012	218fe076-16eb-11ea-8a37-fb45e02080f3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	1.75	0.5	X	2019-12-04 15:09:32.859914	2019-12-04 15:09:32.859914
21d0bb3c-16eb-11ea-8a37-dbfda38b7a53	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:32.867258	2019-12-04 15:09:32.867258
21d1c2ca-16eb-11ea-8a37-1bb85399ac5d	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.874066	2019-12-04 15:09:32.874066
21d2a7ee-16eb-11ea-8a37-8f978aaa3526	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:32.879988	2019-12-04 15:09:32.879988
21d38452-16eb-11ea-8a37-b7e5d3c4e1b0	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:32.885647	2019-12-04 15:09:32.885647
21d419f8-16eb-11ea-8a37-cb187ecb480d	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:32.889493	2019-12-04 15:09:32.889493
21d4ad82-16eb-11ea-8a37-0707e00077a6	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:32.893267	2019-12-04 15:09:32.893267
21d541a2-16eb-11ea-8a37-efd2e91a084a	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:32.897067	2019-12-04 15:09:32.897067
21d5d36a-16eb-11ea-8a37-232d16301fe0	215f31b0-16eb-11ea-8a37-4359224b0012	2195c34c-16eb-11ea-8a37-b7e6dfa9ca3b	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	3.75	0.25	X	2019-12-04 15:09:32.900802	2019-12-04 15:09:32.900802
21d6615e-16eb-11ea-8a37-9fb3fc79f6db	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:32.904441	2019-12-04 15:09:32.904441
21d6ec64-16eb-11ea-8a37-9b3fec7b2775	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:32.908002	2019-12-04 15:09:32.908002
21d7a366-16eb-11ea-8a37-6fc978baf123	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.912541	2019-12-04 15:09:32.912541
21d86850-16eb-11ea-8a37-8f917ee8cf7b	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.91752	2019-12-04 15:09:32.91752
21d9a116-16eb-11ea-8a37-bb1ebe82169c	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:32.925529	2019-12-04 15:09:32.925529
21dadc52-16eb-11ea-8a37-cf4c5518f08b	215f31b0-16eb-11ea-8a37-4359224b0012	2195c34c-16eb-11ea-8a37-b7e6dfa9ca3b	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	3.5	0.25	X	2019-12-04 15:09:32.933597	2019-12-04 15:09:32.933597
21dc125c-16eb-11ea-8a37-8fbdd79e1b02	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:32.941513	2019-12-04 15:09:32.941513
21dd4a0a-16eb-11ea-8a37-9b003e98afde	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:32.949514	2019-12-04 15:09:32.949514
21de5b5c-16eb-11ea-8a37-b3ceac4115bd	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.956582	2019-12-04 15:09:32.956582
21df6a7e-16eb-11ea-8a37-837e8bf58b14	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.963526	2019-12-04 15:09:32.963526
21e073ce-16eb-11ea-8a37-ef1724ea4210	215f31b0-16eb-11ea-8a37-4359224b0012	21809ecc-16eb-11ea-8a37-ab31a867b7bd	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	1.75	2.25	X	2019-12-04 15:09:32.970306	2019-12-04 15:09:32.970306
21e17e7c-16eb-11ea-8a37-23aee9bb6c2e	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:32.977117	2019-12-04 15:09:32.977117
21e2525c-16eb-11ea-8a37-7f72f1a71f7e	215f31b0-16eb-11ea-8a37-4359224b0012	2196de6c-16eb-11ea-8a37-eb5cb1f9fcdf	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.33	2.5	1.5	X	2019-12-04 15:09:32.982563	2019-12-04 15:09:32.982563
21e31caa-16eb-11ea-8a37-2bd52e44bac7	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:32.987747	2019-12-04 15:09:32.987747
21e3e3b0-16eb-11ea-8a37-4321ee04d176	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:32.992845	2019-12-04 15:09:32.992845
21e4ac96-16eb-11ea-8a37-879060965c27	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:32.997986	2019-12-04 15:09:32.997986
21e56f82-16eb-11ea-8a37-6b16cd1b35d6	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.002958	2019-12-04 15:09:33.002958
21e632d2-16eb-11ea-8a37-b367b09bfcf1	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.007973	2019-12-04 15:09:33.007973
21e6f4f6-16eb-11ea-8a37-a3122e703493	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.012937	2019-12-04 15:09:33.012937
21e7cbce-16eb-11ea-8a37-5b608c26f44f	215f31b0-16eb-11ea-8a37-4359224b0012	21a54f9c-16eb-11ea-8a37-4b319fb6be1c	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	1.75	X	2019-12-04 15:09:33.018398	2019-12-04 15:09:33.018398
21e906ce-16eb-11ea-8a37-f349d4a80644	215f31b0-16eb-11ea-8a37-4359224b0012	21a32992-16eb-11ea-8a37-c710430d8ccb	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	1.25	X	2019-12-04 15:09:33.026507	2019-12-04 15:09:33.026507
21ea3f44-16eb-11ea-8a37-17fa62bfa044	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:33.034483	2019-12-04 15:09:33.034483
21eb760c-16eb-11ea-8a37-032664defabd	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.042461	2019-12-04 15:09:33.042461
21ecb346-16eb-11ea-8a37-938edce7ecb7	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:33.050559	2019-12-04 15:09:33.050559
21edc664-16eb-11ea-8a37-a7bda3ed98f6	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.057555	2019-12-04 15:09:33.057555
21eeddf6-16eb-11ea-8a37-5f32951e2e7e	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	X	2019-12-04 15:09:33.064787	2019-12-04 15:09:33.064787
21efe908-16eb-11ea-8a37-ebfb1a45e870	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.071616	2019-12-04 15:09:33.071616
21f0f348-16eb-11ea-8a37-ef60974ccd25	215f31b0-16eb-11ea-8a37-4359224b0012	216f636e-16eb-11ea-8a37-efb2861fa9ac	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.33	1.5	2.5	X	2019-12-04 15:09:33.07843	2019-12-04 15:09:33.07843
21f1bf12-16eb-11ea-8a37-8773624fddf1	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.083647	2019-12-04 15:09:33.083647
21f2860e-16eb-11ea-8a37-97aad41b6f40	215f31b0-16eb-11ea-8a37-4359224b0012	2198c6aa-16eb-11ea-8a37-3745c6affcca	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.05	2.5	1.5	X	2019-12-04 15:09:33.08875	2019-12-04 15:09:33.08875
21f34a1c-16eb-11ea-8a37-fb05abc3cd92	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.093752	2019-12-04 15:09:33.093752
21f4130c-16eb-11ea-8a37-2f7663f310ac	215f31b0-16eb-11ea-8a37-4359224b0012	21a43cc4-16eb-11ea-8a37-17d100189582	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.098861	2019-12-04 15:09:33.098861
21f4da08-16eb-11ea-8a37-334c64383d1b	215f31b0-16eb-11ea-8a37-4359224b0012	21a1ecee-16eb-11ea-8a37-23b49f24b6f6	216a302e-16eb-11ea-8a37-939e7143d52d	0.62	0	4	X	2019-12-04 15:09:33.103969	2019-12-04 15:09:33.103969
21f59d62-16eb-11ea-8a37-630a451bdda4	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:33.109009	2019-12-04 15:09:33.109009
21f66558-16eb-11ea-8a37-03ee318b8867	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:33.114111	2019-12-04 15:09:33.114111
21f72e3e-16eb-11ea-8a37-6f2ed2b31c0a	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.119247	2019-12-04 15:09:33.119247
21f865ec-16eb-11ea-8a37-5b66c7b5e4fc	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.127245	2019-12-04 15:09:33.127245
21f9a218-16eb-11ea-8a37-3bf7929ba3c6	215f31b0-16eb-11ea-8a37-4359224b0012	21a43cc4-16eb-11ea-8a37-17d100189582	21692bfc-16eb-11ea-8a37-97b3fc27408a	1	3	1	X	2019-12-04 15:09:33.135344	2019-12-04 15:09:33.135344
21fad872-16eb-11ea-8a37-ef8cb52bd1dc	215f31b0-16eb-11ea-8a37-4359224b0012	217e9bb8-16eb-11ea-8a37-e34d2f292865	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	1.75	2.25	X	2019-12-04 15:09:33.143288	2019-12-04 15:09:33.143288
21fc161a-16eb-11ea-8a37-9f70eb2d16de	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:33.15139	2019-12-04 15:09:33.15139
21fd2dca-16eb-11ea-8a37-5f2050fa1468	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:33.158579	2019-12-04 15:09:33.158579
21fe4552-16eb-11ea-8a37-57d565ee0404	215f31b0-16eb-11ea-8a37-4359224b0012	217820da-16eb-11ea-8a37-bb9a492f179a	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	1.75	X	2019-12-04 15:09:33.165692	2019-12-04 15:09:33.165692
21ff574e-16eb-11ea-8a37-834fb183161d	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.17275	2019-12-04 15:09:33.17275
22006a1c-16eb-11ea-8a37-5f57935ffff6	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.179768	2019-12-04 15:09:33.179768
2201369a-16eb-11ea-8a37-7f59242b6609	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.18501	2019-12-04 15:09:33.18501
220207dc-16eb-11ea-8a37-6f4924fde678	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.190357	2019-12-04 15:09:33.190357
2202d608-16eb-11ea-8a37-3f3f20b16d63	215f31b0-16eb-11ea-8a37-4359224b0012	219e2ea6-16eb-11ea-8a37-7b7d53675b93	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.33	1.5	2.5	X	2019-12-04 15:09:33.195623	2019-12-04 15:09:33.195623
22039c32-16eb-11ea-8a37-afed3e425c0e	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:33.200721	2019-12-04 15:09:33.200721
22046054-16eb-11ea-8a37-dfadf18d4057	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.205742	2019-12-04 15:09:33.205742
22052728-16eb-11ea-8a37-eb3969764984	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:33.210824	2019-12-04 15:09:33.210824
2205d8bc-16eb-11ea-8a37-2fa5140b4623	215f31b0-16eb-11ea-8a37-4359224b0012	2184428e-16eb-11ea-8a37-abeefd8633e3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.33	3.5	0.5	X	2019-12-04 15:09:33.215432	2019-12-04 15:09:33.215432
22068082-16eb-11ea-8a37-03b4a29e603e	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:33.219751	2019-12-04 15:09:33.219751
22078ce8-16eb-11ea-8a37-af3a94295d2c	215f31b0-16eb-11ea-8a37-4359224b0012	219a5916-16eb-11ea-8a37-7f67f09d94bd	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.226647	2019-12-04 15:09:33.226647
22089962-16eb-11ea-8a37-e7aca185c9e7	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.233525	2019-12-04 15:09:33.233525
2209a668-16eb-11ea-8a37-8bdd254400d0	215f31b0-16eb-11ea-8a37-4359224b0012	21770e0c-16eb-11ea-8a37-b38953e07c93	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	1.25	X	2019-12-04 15:09:33.240431	2019-12-04 15:09:33.240431
220aad60-16eb-11ea-8a37-cb79568efc9f	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.247158	2019-12-04 15:09:33.247158
220b93ba-16eb-11ea-8a37-77d08cbce79f	215f31b0-16eb-11ea-8a37-4359224b0012	219f6762-16eb-11ea-8a37-036670eedde6	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.1	2.5	0.5	X	2019-12-04 15:09:33.253056	2019-12-04 15:09:33.253056
220c985a-16eb-11ea-8a37-4b37a4a5c0e1	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:33.259604	2019-12-04 15:09:33.259604
220daede-16eb-11ea-8a37-0f435eb5d852	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.266744	2019-12-04 15:09:33.266744
220ec0a8-16eb-11ea-8a37-6f5ec1c90e28	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:33.273727	2019-12-04 15:09:33.273727
220f90a0-16eb-11ea-8a37-0f3c0beb665b	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.279065	2019-12-04 15:09:33.279065
22105e2c-16eb-11ea-8a37-030470bc74d3	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.284318	2019-12-04 15:09:33.284318
22112898-16eb-11ea-8a37-0788edc15d78	215f31b0-16eb-11ea-8a37-4359224b0012	2173bbe4-16eb-11ea-8a37-7b12391bf544	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.28944	2019-12-04 15:09:33.28944
2211f2e6-16eb-11ea-8a37-032b2fbbdb4d	215f31b0-16eb-11ea-8a37-4359224b0012	21925f54-16eb-11ea-8a37-637f6976a474	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.294683	2019-12-04 15:09:33.294683
2212bc58-16eb-11ea-8a37-13016ece092d	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.299842	2019-12-04 15:09:33.299842
22137fa8-16eb-11ea-8a37-4b380c5a71c1	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:33.304843	2019-12-04 15:09:33.304843
221440fa-16eb-11ea-8a37-9356eaddee1c	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:33.309797	2019-12-04 15:09:33.309797
22150490-16eb-11ea-8a37-3f9b72132948	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:33.314794	2019-12-04 15:09:33.314794
2216389c-16eb-11ea-8a37-fb1b04a39e4a	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.322681	2019-12-04 15:09:33.322681
22177432-16eb-11ea-8a37-67773abc332b	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.330762	2019-12-04 15:09:33.330762
2218ac12-16eb-11ea-8a37-d702db4f6aed	215f31b0-16eb-11ea-8a37-4359224b0012	2198c6aa-16eb-11ea-8a37-3745c6affcca	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	1.75	0.75	X	2019-12-04 15:09:33.338747	2019-12-04 15:09:33.338747
2219e28a-16eb-11ea-8a37-a3de590b9d0d	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.346688	2019-12-04 15:09:33.346688
221af49a-16eb-11ea-8a37-1feed8b9575d	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:33.353699	2019-12-04 15:09:33.353699
221c0574-16eb-11ea-8a37-1bba4b545110	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.360697	2019-12-04 15:09:33.360697
221d1270-16eb-11ea-8a37-cb73e3fe83fd	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:33.367584	2019-12-04 15:09:33.367584
221e2bc4-16eb-11ea-8a37-63ed28c9297b	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:33.374784	2019-12-04 15:09:33.374784
221ef4dc-16eb-11ea-8a37-a773d0990a7a	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:33.379932	2019-12-04 15:09:33.379932
221fbd04-16eb-11ea-8a37-c791d50ef68d	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.385042	2019-12-04 15:09:33.385042
222087de-16eb-11ea-8a37-9b2b54e51223	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.390253	2019-12-04 15:09:33.390253
22214d40-16eb-11ea-8a37-9303216149f2	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.395304	2019-12-04 15:09:33.395304
22221036-16eb-11ea-8a37-6751689bd96e	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.400293	2019-12-04 15:09:33.400293
2222cf3a-16eb-11ea-8a37-17efe74174f5	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.405186	2019-12-04 15:09:33.405186
22239370-16eb-11ea-8a37-8f3485aadd0b	215f31b0-16eb-11ea-8a37-4359224b0012	219a5916-16eb-11ea-8a37-7f67f09d94bd	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.410207	2019-12-04 15:09:33.410207
222458d2-16eb-11ea-8a37-f7b2c4df7c29	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:33.415254	2019-12-04 15:09:33.415254
22259116-16eb-11ea-8a37-63e987dc65e6	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:33.423246	2019-12-04 15:09:33.423246
2226c928-16eb-11ea-8a37-8f5e223d285c	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:33.431253	2019-12-04 15:09:33.431253
22280130-16eb-11ea-8a37-f395d8261046	215f31b0-16eb-11ea-8a37-4359224b0012	218eab0c-16eb-11ea-8a37-733add36209d	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.439237	2019-12-04 15:09:33.439237
2229369a-16eb-11ea-8a37-7fcef690d182	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:33.447156	2019-12-04 15:09:33.447156
222a4968-16eb-11ea-8a37-db6d27acb3e3	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:33.454187	2019-12-04 15:09:33.454187
222b5b46-16eb-11ea-8a37-1bf40fe8d67e	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.461208	2019-12-04 15:09:33.461208
222c69f0-16eb-11ea-8a37-4f4b8ccea5d1	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.468118	2019-12-04 15:09:33.468118
222d7656-16eb-11ea-8a37-e7f0a5e53f67	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.474986	2019-12-04 15:09:33.474986
222e3ff0-16eb-11ea-8a37-ff5c9dad8ac3	215f31b0-16eb-11ea-8a37-4359224b0012	21866708-16eb-11ea-8a37-c7e908c0cc30	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	2.75	0.75	X	2019-12-04 15:09:33.480136	2019-12-04 15:09:33.480136
222f0c50-16eb-11ea-8a37-7fff32aea1df	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:33.485393	2019-12-04 15:09:33.485393
222fd3b0-16eb-11ea-8a37-cbd53f8a55c6	215f31b0-16eb-11ea-8a37-4359224b0012	21770e0c-16eb-11ea-8a37-b38953e07c93	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	2.25	1.75	X	2019-12-04 15:09:33.490496	2019-12-04 15:09:33.490496
223096ba-16eb-11ea-8a37-63f9f4ac2a9d	215f31b0-16eb-11ea-8a37-4359224b0012	218adacc-16eb-11ea-8a37-7b33d10acf33	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.495486	2019-12-04 15:09:33.495486
22314e02-16eb-11ea-8a37-4b55ded8f776	215f31b0-16eb-11ea-8a37-4359224b0012	219be6d2-16eb-11ea-8a37-fb21b007d62e	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	2	X	2019-12-04 15:09:33.500221	2019-12-04 15:09:33.500221
2231f686-16eb-11ea-8a37-03261898e61c	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.50457	2019-12-04 15:09:33.50457
22329a00-16eb-11ea-8a37-777e373e59f5	215f31b0-16eb-11ea-8a37-4359224b0012	218de320-16eb-11ea-8a37-7354b435f9f9	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.508774	2019-12-04 15:09:33.508774
22333942-16eb-11ea-8a37-3bb1bba4455a	215f31b0-16eb-11ea-8a37-4359224b0012	21925f54-16eb-11ea-8a37-637f6976a474	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	0.5	X	2019-12-04 15:09:33.512846	2019-12-04 15:09:33.512846
22344f1c-16eb-11ea-8a37-ff40038ad644	215f31b0-16eb-11ea-8a37-4359224b0012	219f6762-16eb-11ea-8a37-036670eedde6	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	1.5	X	2019-12-04 15:09:33.519951	2019-12-04 15:09:33.519951
223569ce-16eb-11ea-8a37-8729bb70f21a	215f31b0-16eb-11ea-8a37-4359224b0012	219be6d2-16eb-11ea-8a37-fb21b007d62e	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.1	3.5	0.5	X	2019-12-04 15:09:33.527201	2019-12-04 15:09:33.527201
22367742-16eb-11ea-8a37-6762a1a8f769	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:33.534098	2019-12-04 15:09:33.534098
223791b8-16eb-11ea-8a37-f78c21ae548d	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.54131	2019-12-04 15:09:33.54131
22389a86-16eb-11ea-8a37-c3688b614199	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.548054	2019-12-04 15:09:33.548054
2239a82c-16eb-11ea-8a37-e3b40d29b3b6	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.554926	2019-12-04 15:09:33.554926
223ab834-16eb-11ea-8a37-63682dabb9e1	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.561895	2019-12-04 15:09:33.561895
223bc846-16eb-11ea-8a37-5b3b398dca6f	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:33.568858	2019-12-04 15:09:33.568858
223c9bb8-16eb-11ea-8a37-af38f7990b3b	215f31b0-16eb-11ea-8a37-4359224b0012	218c66ee-16eb-11ea-8a37-bbc4864e93e0	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.574262	2019-12-04 15:09:33.574262
223d6a70-16eb-11ea-8a37-27b8a99b2378	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.579536	2019-12-04 15:09:33.579536
223e33ce-16eb-11ea-8a37-5f6253f46702	215f31b0-16eb-11ea-8a37-4359224b0012	21999120-16eb-11ea-8a37-0705b6016cda	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	3.25	0.75	X	2019-12-04 15:09:33.584702	2019-12-04 15:09:33.584702
223ef9a8-16eb-11ea-8a37-97917187d890	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:33.589781	2019-12-04 15:09:33.589781
223fc3ba-16eb-11ea-8a37-0f94816e1485	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0	1	0.25	E12	2019-12-04 15:09:33.594894	2019-12-04 15:09:33.594894
22409b96-16eb-11ea-8a37-1b26268ac1b9	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:33.600417	2019-12-04 15:09:33.600417
22415338-16eb-11ea-8a37-9b52aab6dc64	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.60521	2019-12-04 15:09:33.60521
2241fe32-16eb-11ea-8a37-774a645eb239	215f31b0-16eb-11ea-8a37-4359224b0012	2184428e-16eb-11ea-8a37-abeefd8633e3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	2	X	2019-12-04 15:09:33.609637	2019-12-04 15:09:33.609637
224319ca-16eb-11ea-8a37-d741cd7e5589	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:33.616887	2019-12-04 15:09:33.616887
22443030-16eb-11ea-8a37-37997231b09e	215f31b0-16eb-11ea-8a37-4359224b0012	219f6762-16eb-11ea-8a37-036670eedde6	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.62403	2019-12-04 15:09:33.62403
22454222-16eb-11ea-8a37-a77247c92d79	215f31b0-16eb-11ea-8a37-4359224b0012	217ac65a-16eb-11ea-8a37-ebfe8130d36d	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.631037	2019-12-04 15:09:33.631037
22465dc4-16eb-11ea-8a37-3f91330b0470	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.638291	2019-12-04 15:09:33.638291
22475bc0-16eb-11ea-8a37-f7adcbec6b84	215f31b0-16eb-11ea-8a37-4359224b0012	217820da-16eb-11ea-8a37-bb9a492f179a	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.1	2.75	0.25	X	2019-12-04 15:09:33.64478	2019-12-04 15:09:33.64478
22486330-16eb-11ea-8a37-83af8dfe9719	215f31b0-16eb-11ea-8a37-4359224b0012	2174edde-16eb-11ea-8a37-fbcd3b7da5d3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.5	0.5	1.5	X	2019-12-04 15:09:33.651482	2019-12-04 15:09:33.651482
22497716-16eb-11ea-8a37-1b6af0c0794c	215f31b0-16eb-11ea-8a37-4359224b0012	21925f54-16eb-11ea-8a37-637f6976a474	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	0.5	X	2019-12-04 15:09:33.658527	2019-12-04 15:09:33.658527
224a8a48-16eb-11ea-8a37-33b81faf2f4a	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.665459	2019-12-04 15:09:33.665459
224b555e-16eb-11ea-8a37-1b02974d7c29	215f31b0-16eb-11ea-8a37-4359224b0012	21770e0c-16eb-11ea-8a37-b38953e07c93	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	1.75	0.5	X	2019-12-04 15:09:33.670764	2019-12-04 15:09:33.670764
224c227c-16eb-11ea-8a37-e3640ce9b1ad	215f31b0-16eb-11ea-8a37-4359224b0012	2173bbe4-16eb-11ea-8a37-7b12391bf544	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.1	2.75	0.25	X	2019-12-04 15:09:33.675968	2019-12-04 15:09:33.675968
224ceb3a-16eb-11ea-8a37-8f9329a68fbe	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.681159	2019-12-04 15:09:33.681159
224db722-16eb-11ea-8a37-274527659f29	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.686384	2019-12-04 15:09:33.686384
224e7982-16eb-11ea-8a37-cf02b2f035ac	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:33.691356	2019-12-04 15:09:33.691356
224f3d2c-16eb-11ea-8a37-9ba5edfb7ea6	215f31b0-16eb-11ea-8a37-4359224b0012	21925f54-16eb-11ea-8a37-637f6976a474	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.2	3.5	0.5	X	2019-12-04 15:09:33.696369	2019-12-04 15:09:33.696369
224fff3c-16eb-11ea-8a37-aff987f79c25	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.701334	2019-12-04 15:09:33.701334
2250c854-16eb-11ea-8a37-73e28589d8a5	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.706486	2019-12-04 15:09:33.706486
22520124-16eb-11ea-8a37-9f109c620760	215f31b0-16eb-11ea-8a37-4359224b0012	2174edde-16eb-11ea-8a37-fbcd3b7da5d3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	2	1.5	X	2019-12-04 15:09:33.714482	2019-12-04 15:09:33.714482
225345b6-16eb-11ea-8a37-f3ba1d9b9d8b	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.7228	2019-12-04 15:09:33.7228
22547bde-16eb-11ea-8a37-b7ff067658c2	215f31b0-16eb-11ea-8a37-4359224b0012	218c66ee-16eb-11ea-8a37-bbc4864e93e0	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.730744	2019-12-04 15:09:33.730744
2255b13e-16eb-11ea-8a37-ef0c9de501fa	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.738653	2019-12-04 15:09:33.738653
2256c614-16eb-11ea-8a37-23aad6b19abe	215f31b0-16eb-11ea-8a37-4359224b0012	218eab0c-16eb-11ea-8a37-733add36209d	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.745737	2019-12-04 15:09:33.745737
2257e29c-16eb-11ea-8a37-c336c6f3d9f2	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.753028	2019-12-04 15:09:33.753028
2258f4de-16eb-11ea-8a37-5333fcaa155d	215f31b0-16eb-11ea-8a37-4359224b0012	217d1aae-16eb-11ea-8a37-d3f6c2194848	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.760053	2019-12-04 15:09:33.760053
225a04c8-16eb-11ea-8a37-f741d001e710	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:33.767005	2019-12-04 15:09:33.767005
225ac566-16eb-11ea-8a37-a3a339477b42	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.771953	2019-12-04 15:09:33.771953
225b8f5a-16eb-11ea-8a37-7be6c0067796	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:33.777102	2019-12-04 15:09:33.777102
225ca30e-16eb-11ea-8a37-4b768c007980	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.784155	2019-12-04 15:09:33.784155
225d608c-16eb-11ea-8a37-ab0af86febbd	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:33.789011	2019-12-04 15:09:33.789011
225e2332-16eb-11ea-8a37-db428aade725	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.793999	2019-12-04 15:09:33.793999
225ee466-16eb-11ea-8a37-570cf02a3f27	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.75	0.5	X	2019-12-04 15:09:33.79894	2019-12-04 15:09:33.79894
225fa2a2-16eb-11ea-8a37-fbf82db2d781	215f31b0-16eb-11ea-8a37-4359224b0012	217820da-16eb-11ea-8a37-bb9a492f179a	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	3	1	X	2019-12-04 15:09:33.803814	2019-12-04 15:09:33.803814
2260dd3e-16eb-11ea-8a37-377a03964a56	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.811855	2019-12-04 15:09:33.811855
22621686-16eb-11ea-8a37-23a7782a78b9	215f31b0-16eb-11ea-8a37-4359224b0012	2181d864-16eb-11ea-8a37-6f9d74f03af5	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:33.819858	2019-12-04 15:09:33.819858
22634a7e-16eb-11ea-8a37-7f1b8d11e797	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:33.827769	2019-12-04 15:09:33.827769
226477aa-16eb-11ea-8a37-77c0a40eae87	215f31b0-16eb-11ea-8a37-4359224b0012	21939810-16eb-11ea-8a37-cf509506f5dc	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	1.75	1.75	X	2019-12-04 15:09:33.835479	2019-12-04 15:09:33.835479
22658b04-16eb-11ea-8a37-db03c7dcb5c5	215f31b0-16eb-11ea-8a37-4359224b0012	2195c34c-16eb-11ea-8a37-b7e6dfa9ca3b	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	3	0.25	X	2019-12-04 15:09:33.842526	2019-12-04 15:09:33.842526
22669ef4-16eb-11ea-8a37-bbc935c78c5e	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	1.75	0.5	X	2019-12-04 15:09:33.849518	2019-12-04 15:09:33.849518
2267afba-16eb-11ea-8a37-d7d11602ed25	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:33.856574	2019-12-04 15:09:33.856574
2268bc48-16eb-11ea-8a37-778e801cb489	215f31b0-16eb-11ea-8a37-4359224b0012	2195c34c-16eb-11ea-8a37-b7e6dfa9ca3b	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.1	3.25	0.25	X	2019-12-04 15:09:33.863463	2019-12-04 15:09:33.863463
22698326-16eb-11ea-8a37-8bf2cbdefbbf	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.868556	2019-12-04 15:09:33.868556
226a4be4-16eb-11ea-8a37-4b2d6471824b	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:33.87369	2019-12-04 15:09:33.87369
226b1484-16eb-11ea-8a37-af97f42ff9ba	215f31b0-16eb-11ea-8a37-4359224b0012	2197f950-16eb-11ea-8a37-1f9fd340842b	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.878827	2019-12-04 15:09:33.878827
226be184-16eb-11ea-8a37-23f5372ee15b	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.884057	2019-12-04 15:09:33.884057
226ca51a-16eb-11ea-8a37-236451f808d0	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.889067	2019-12-04 15:09:33.889067
226d686a-16eb-11ea-8a37-27d88399c2c0	215f31b0-16eb-11ea-8a37-4359224b0012	21a32992-16eb-11ea-8a37-c710430d8ccb	216d44b2-16eb-11ea-8a37-836e4aac26d3	0	2.25	1.75	X	2019-12-04 15:09:33.894076	2019-12-04 15:09:33.894076
226e2dea-16eb-11ea-8a37-7712f24bdd04	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.5	X	2019-12-04 15:09:33.899129	2019-12-04 15:09:33.899129
226eee74-16eb-11ea-8a37-ffa82ede072a	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	0.25	0.25	G12	2019-12-04 15:09:33.904066	2019-12-04 15:09:33.904066
227021b8-16eb-11ea-8a37-0b26c7dbbade	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:33.911923	2019-12-04 15:09:33.911923
22715772-16eb-11ea-8a37-27a5564da361	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	2.75	0.5	X	2019-12-04 15:09:33.919851	2019-12-04 15:09:33.919851
22728c78-16eb-11ea-8a37-cff385cc3b9d	215f31b0-16eb-11ea-8a37-4359224b0012	21830df6-16eb-11ea-8a37-ff5e1ea7db94	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.33	0.5	3.5	X	2019-12-04 15:09:33.927775	2019-12-04 15:09:33.927775
2273bdaa-16eb-11ea-8a37-1f8f52775e15	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:33.935587	2019-12-04 15:09:33.935587
2274d2da-16eb-11ea-8a37-4b34cb9e4a53	215f31b0-16eb-11ea-8a37-4359224b0012	219d6e94-16eb-11ea-8a37-bf854a31f308	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:33.94268	2019-12-04 15:09:33.94268
2275e9d6-16eb-11ea-8a37-8f48dbc67daa	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.949803	2019-12-04 15:09:33.949803
2276faa6-16eb-11ea-8a37-4fd5dfd1e66f	215f31b0-16eb-11ea-8a37-4359224b0012	217153d6-16eb-11ea-8a37-27b78303b05d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:33.956807	2019-12-04 15:09:33.956807
227809be-16eb-11ea-8a37-138bcb514112	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	0.75	0.25	X	2019-12-04 15:09:33.963752	2019-12-04 15:09:33.963752
2278d11e-16eb-11ea-8a37-7b8086a7fbe6	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:33.968854	2019-12-04 15:09:33.968854
22799a36-16eb-11ea-8a37-ff2348eb9860	215f31b0-16eb-11ea-8a37-4359224b0012	219be6d2-16eb-11ea-8a37-fb21b007d62e	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.05	2.5	1	X	2019-12-04 15:09:33.974002	2019-12-04 15:09:33.974002
227a645c-16eb-11ea-8a37-d3bc2ae90046	215f31b0-16eb-11ea-8a37-4359224b0012	217c574a-16eb-11ea-8a37-2b8fb2a9fcb9	216d44b2-16eb-11ea-8a37-836e4aac26d3	1	0	1.75	X	2019-12-04 15:09:33.979172	2019-12-04 15:09:33.979172
227b2de2-16eb-11ea-8a37-9b52c17bd96b	215f31b0-16eb-11ea-8a37-4359224b0012	216f636e-16eb-11ea-8a37-efb2861fa9ac	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.66	0.75	0.75	X	2019-12-04 15:09:33.984334	2019-12-04 15:09:33.984334
227bee3a-16eb-11ea-8a37-53fcf5d4afd8	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	3.5	0.25	X	2019-12-04 15:09:33.989262	2019-12-04 15:09:33.989262
227cb46e-16eb-11ea-8a37-7bb70a498d19	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:33.994331	2019-12-04 15:09:33.994331
227d730e-16eb-11ea-8a37-db12f59324bb	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:33.999173	2019-12-04 15:09:33.999173
227e2f10-16eb-11ea-8a37-03f99856b7a8	215f31b0-16eb-11ea-8a37-4359224b0012	21809ecc-16eb-11ea-8a37-ab31a867b7bd	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	1.75	X	2019-12-04 15:09:34.004026	2019-12-04 15:09:34.004026
227f6114-16eb-11ea-8a37-3becc031c2d8	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:34.011834	2019-12-04 15:09:34.011834
22809b7e-16eb-11ea-8a37-5fcddbb08bee	215f31b0-16eb-11ea-8a37-4359224b0012	21894914-16eb-11ea-8a37-47f4eab16b4e	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.75	0.5	X	2019-12-04 15:09:34.01985	2019-12-04 15:09:34.01985
2281ccb0-16eb-11ea-8a37-1371e9d0ff55	215f31b0-16eb-11ea-8a37-4359224b0012	217dd764-16eb-11ea-8a37-17d702c822ca	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:34.027708	2019-12-04 15:09:34.027708
2282fca2-16eb-11ea-8a37-9f17568c1c8a	215f31b0-16eb-11ea-8a37-4359224b0012	21a54f9c-16eb-11ea-8a37-4b319fb6be1c	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.01	1.75	2.25	X	2019-12-04 15:09:34.035489	2019-12-04 15:09:34.035489
22840c3c-16eb-11ea-8a37-33714e22cffb	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:34.042445	2019-12-04 15:09:34.042445
228525fe-16eb-11ea-8a37-13edee00f87a	215f31b0-16eb-11ea-8a37-4359224b0012	217286de-16eb-11ea-8a37-e3ea47c2d55d	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.25	0.25	G12	2019-12-04 15:09:34.04953	2019-12-04 15:09:34.04953
22863cf0-16eb-11ea-8a37-d708956f32ac	215f31b0-16eb-11ea-8a37-4359224b0012	219121ac-16eb-11ea-8a37-8758a971c637	216bcf10-16eb-11ea-8a37-37c6be6647c3	0.33	3.5	0.5	X	2019-12-04 15:09:34.056774	2019-12-04 15:09:34.056774
22874366-16eb-11ea-8a37-ab5532f6dbc2	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	2.25	0.25	E8	2019-12-04 15:09:34.06352	2019-12-04 15:09:34.06352
228817b4-16eb-11ea-8a37-c3207b6555f4	215f31b0-16eb-11ea-8a37-4359224b0012	21999120-16eb-11ea-8a37-0705b6016cda	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	2	X	2019-12-04 15:09:34.068876	2019-12-04 15:09:34.068876
2288e7ac-16eb-11ea-8a37-8bc68e8ecee3	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	1.25	0.25	G12	2019-12-04 15:09:34.074263	2019-12-04 15:09:34.074263
2289b470-16eb-11ea-8a37-9fb2de8a330c	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216b065c-16eb-11ea-8a37-d3740e001fd2	0.1	3.75	0.25	X	2019-12-04 15:09:34.079507	2019-12-04 15:09:34.079507
228a784c-16eb-11ea-8a37-87ca071ffe29	215f31b0-16eb-11ea-8a37-4359224b0012	217929e4-16eb-11ea-8a37-8f8ef2bfd1d1	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:34.084531	2019-12-04 15:09:34.084531
228b3bc4-16eb-11ea-8a37-13e51e9f7d7c	215f31b0-16eb-11ea-8a37-4359224b0012	218adacc-16eb-11ea-8a37-7b33d10acf33	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.1	2.75	0.25	X	2019-12-04 15:09:34.089491	2019-12-04 15:09:34.089491
228c0298-16eb-11ea-8a37-ab1ff071369d	215f31b0-16eb-11ea-8a37-4359224b0012	2185507a-16eb-11ea-8a37-4ff0a4514475	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	0.5	0.25	X	2019-12-04 15:09:34.094637	2019-12-04 15:09:34.094637
228cc3cc-16eb-11ea-8a37-d77932bc1a89	215f31b0-16eb-11ea-8a37-4359224b0012	21a0a096-16eb-11ea-8a37-cb73502da9e4	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:34.099538	2019-12-04 15:09:34.099538
228d858c-16eb-11ea-8a37-2348bb7e5273	215f31b0-16eb-11ea-8a37-4359224b0012	2184428e-16eb-11ea-8a37-abeefd8633e3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	2	1.5	X	2019-12-04 15:09:34.104534	2019-12-04 15:09:34.104534
228eb4d4-16eb-11ea-8a37-93ee1cd42bde	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:34.112272	2019-12-04 15:09:34.112272
228ff164-16eb-11ea-8a37-b346b35ed1a6	215f31b0-16eb-11ea-8a37-4359224b0012	2175fcc4-16eb-11ea-8a37-97b9f24d2605	216b065c-16eb-11ea-8a37-d3740e001fd2	0.33	3.25	0.25	X	2019-12-04 15:09:34.120369	2019-12-04 15:09:34.120369
22912322-16eb-11ea-8a37-1f6093fee749	215f31b0-16eb-11ea-8a37-4359224b0012	2174edde-16eb-11ea-8a37-fbcd3b7da5d3	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.1	3.5	0.5	X	2019-12-04 15:09:34.128231	2019-12-04 15:09:34.128231
229254f4-16eb-11ea-8a37-735ea1098ba2	215f31b0-16eb-11ea-8a37-4359224b0012	2179f3ce-16eb-11ea-8a37-873a57a2db90	216b065c-16eb-11ea-8a37-d3740e001fd2	0.05	3.75	0.25	X	2019-12-04 15:09:34.136046	2019-12-04 15:09:34.136046
22936c04-16eb-11ea-8a37-db337f88ad80	215f31b0-16eb-11ea-8a37-4359224b0012	217f69c6-16eb-11ea-8a37-737080a79993	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:34.143198	2019-12-04 15:09:34.143198
22947f18-16eb-11ea-8a37-1fd5e47e319f	215f31b0-16eb-11ea-8a37-4359224b0012	2170254c-16eb-11ea-8a37-d7aecbb0fd8e	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	2.5	0.25	X	2019-12-04 15:09:34.150217	2019-12-04 15:09:34.150217
22958d5e-16eb-11ea-8a37-4b28659036d4	215f31b0-16eb-11ea-8a37-4359224b0012	219cacac-16eb-11ea-8a37-e723ebadadc5	216c8c98-16eb-11ea-8a37-8b624f6028b1	0.2	1.5	0.25	X	2019-12-04 15:09:34.15716	2019-12-04 15:09:34.15716
2296ab58-16eb-11ea-8a37-1b415a520176	215f31b0-16eb-11ea-8a37-4359224b0012	218de320-16eb-11ea-8a37-7354b435f9f9	21692bfc-16eb-11ea-8a37-97b3fc27408a	0.62	1	2	X	2019-12-04 15:09:34.164485	2019-12-04 15:09:34.164485
2297742a-16eb-11ea-8a37-57f199eab9a5	215f31b0-16eb-11ea-8a37-4359224b0012	217e9bb8-16eb-11ea-8a37-e34d2f292865	216d44b2-16eb-11ea-8a37-836e4aac26d3	0.62	0	1.75	X	2019-12-04 15:09:34.169562	2019-12-04 15:09:34.169562
22b5d424-16eb-11ea-8a37-c77528772afe	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.1	0.25	0.2	G12	2019-12-04 15:09:34.368757	2019-12-04 15:09:34.368757
22b662ea-16eb-11ea-8a37-c396374ddb3c	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.2	2	0.25	E12	2019-12-04 15:09:34.372455	2019-12-04 15:09:34.372455
22b6ef9e-16eb-11ea-8a37-0fe2d122655e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.2	1.5	0.5	Bb8	2019-12-04 15:09:34.376055	2019-12-04 15:09:34.376055
22b78846-16eb-11ea-8a37-6f8366d227e5	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.2	2.5	0.5	Bb8	2019-12-04 15:09:34.379917	2019-12-04 15:09:34.379917
22b81ba8-16eb-11ea-8a37-73319011d02e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.12	1.75	0.2	D12	2019-12-04 15:09:34.383713	2019-12-04 15:09:34.383713
22b91bc0-16eb-11ea-8a37-1bd521f9eb3b	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b4a31a-16eb-11ea-8a37-e77838c0a187	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.05	1	0.5	G4	2019-12-04 15:09:34.390286	2019-12-04 15:09:34.390286
22ba18fe-16eb-11ea-8a37-a324491034e5	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b53320-16eb-11ea-8a37-9f79413757cf	22a9ba2c-16eb-11ea-8a37-43395c4fb79b	0.62	0	1	C2	2019-12-04 15:09:34.396774	2019-12-04 15:09:34.396774
22bb14a2-16eb-11ea-8a37-3b585d28952b	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b3852a-16eb-11ea-8a37-ab76ef4eae00	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.1	3.5	0.5	G3	2019-12-04 15:09:34.403212	2019-12-04 15:09:34.403212
22bc0de4-16eb-11ea-8a37-07141809d3c6	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b4a31a-16eb-11ea-8a37-e77838c0a187	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.1	3.5	1	G4	2019-12-04 15:09:34.409579	2019-12-04 15:09:34.409579
22bcea20-16eb-11ea-8a37-d75e5568c4d6	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22ad0880-16eb-11ea-8a37-9755071eaf39	0.2	1.5	0.25	E8	2019-12-04 15:09:34.415235	2019-12-04 15:09:34.415235
22bdc6e8-16eb-11ea-8a37-a3e64e6236a9	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.2	0.5	0.5	Bb8	2019-12-04 15:09:34.420874	2019-12-04 15:09:34.420874
22be991a-16eb-11ea-8a37-f3cb38b6c265	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22ad0880-16eb-11ea-8a37-9755071eaf39	0.2	2.5	0.25	G12	2019-12-04 15:09:34.426267	2019-12-04 15:09:34.426267
22bf6d90-16eb-11ea-8a37-c3c2565ace3e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.16	1	0.25	E12	2019-12-04 15:09:34.43171	2019-12-04 15:09:34.43171
22bffc2e-16eb-11ea-8a37-83aa18e48b57	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b0e234-16eb-11ea-8a37-f7e2f90bb13a	22a9ba2c-16eb-11ea-8a37-43395c4fb79b	0.3	2.5	0.5	C2	2019-12-04 15:09:34.435342	2019-12-04 15:09:34.435342
22c087b6-16eb-11ea-8a37-2f78a5dfeb8a	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b0e234-16eb-11ea-8a37-f7e2f90bb13a	22a9ba2c-16eb-11ea-8a37-43395c4fb79b	0.2	2.25	0.2	F#2	2019-12-04 15:09:34.43894	2019-12-04 15:09:34.43894
22c1153c-16eb-11ea-8a37-5b8c7dab6827	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b3852a-16eb-11ea-8a37-ab76ef4eae00	22ae0be0-16eb-11ea-8a37-9b5f1dc97d09	0.031	2	1	F5	2019-12-04 15:09:34.442561	2019-12-04 15:09:34.442561
22c1a0e2-16eb-11ea-8a37-9bdca878bffa	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.1	3.25	0.2	G12	2019-12-04 15:09:34.446138	2019-12-04 15:09:34.446138
22c22ab2-16eb-11ea-8a37-673d7071357d	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b0e234-16eb-11ea-8a37-f7e2f90bb13a	22a9249a-16eb-11ea-8a37-cb18a38e61fb	0.62	1	1	G8	2019-12-04 15:09:34.449655	2019-12-04 15:09:34.449655
22c2b72a-16eb-11ea-8a37-6fa7e5012d2e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b4a31a-16eb-11ea-8a37-e77838c0a187	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.05	2	0.8	G4	2019-12-04 15:09:34.453257	2019-12-04 15:09:34.453257
22c33c5e-16eb-11ea-8a37-3b26d113fd18	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.2	3	0.25	E12	2019-12-04 15:09:34.456663	2019-12-04 15:09:34.456663
22c3c732-16eb-11ea-8a37-b762ffb09448	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b0e234-16eb-11ea-8a37-f7e2f90bb13a	22a9249a-16eb-11ea-8a37-cb18a38e61fb	0.62	3	1	G8	2019-12-04 15:09:34.460211	2019-12-04 15:09:34.460211
22c4c4a2-16eb-11ea-8a37-0fa0f631410a	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.12	3.75	0.2	D12	2019-12-04 15:09:34.466694	2019-12-04 15:09:34.466694
22c5c29e-16eb-11ea-8a37-f73299c447d4	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b53320-16eb-11ea-8a37-9f79413757cf	22a9ba2c-16eb-11ea-8a37-43395c4fb79b	0.5	2.5	1	C2	2019-12-04 15:09:34.473202	2019-12-04 15:09:34.473202
22c6c6bc-16eb-11ea-8a37-97d3f5f10e92	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.1	2.25	0.2	E8	2019-12-04 15:09:34.47984	2019-12-04 15:09:34.47984
22c7d12e-16eb-11ea-8a37-9fe8e433be6e	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.1	3.25	0.5	Bb8	2019-12-04 15:09:34.486642	2019-12-04 15:09:34.486642
22c8ad56-16eb-11ea-8a37-ab669f24f390	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.2	0	0.3	E12	2019-12-04 15:09:34.492325	2019-12-04 15:09:34.492325
22c98a28-16eb-11ea-8a37-c36e8c229ed1	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b3852a-16eb-11ea-8a37-ab76ef4eae00	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.05	1.25	0.7	G5	2019-12-04 15:09:34.497977	2019-12-04 15:09:34.497977
22ca5fb6-16eb-11ea-8a37-cf35d3ded5a3	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22ad0880-16eb-11ea-8a37-9755071eaf39	0.2	0.5	0.25	E8	2019-12-04 15:09:34.503457	2019-12-04 15:09:34.503457
22cb333c-16eb-11ea-8a37-ffd53011c432	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.025	0.75	0.2	D12	2019-12-04 15:09:34.50887	2019-12-04 15:09:34.50887
22cbce46-16eb-11ea-8a37-7b0473b2eb91	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b0e234-16eb-11ea-8a37-f7e2f90bb13a	22a9249a-16eb-11ea-8a37-cb18a38e61fb	0.1	1.75	0.2	G5	2019-12-04 15:09:34.512769	2019-12-04 15:09:34.512769
22cc623e-16eb-11ea-8a37-d394f975eaf2	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.2	3.5	0.5	Bb8	2019-12-04 15:09:34.51661	2019-12-04 15:09:34.51661
22ccea4c-16eb-11ea-8a37-ef0c74b097dd	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b3852a-16eb-11ea-8a37-ab76ef4eae00	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.1	0.5	0.75	C6	2019-12-04 15:09:34.520125	2019-12-04 15:09:34.520125
22cd6f44-16eb-11ea-8a37-f7585a9ccced	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b4a31a-16eb-11ea-8a37-e77838c0a187	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.1	1	1	G4	2019-12-04 15:09:34.523526	2019-12-04 15:09:34.523526
22cdf3e2-16eb-11ea-8a37-abe120e220cc	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b3852a-16eb-11ea-8a37-ab76ef4eae00	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.2	2	1	C5	2019-12-04 15:09:34.526918	2019-12-04 15:09:34.526918
22ce7ab0-16eb-11ea-8a37-93a4f369427f	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b4a31a-16eb-11ea-8a37-e77838c0a187	22a87f40-16eb-11ea-8a37-a7c0938722dd	0.08	2.75	0.8	G4	2019-12-04 15:09:34.530363	2019-12-04 15:09:34.530363
22cf03e0-16eb-11ea-8a37-8fe5e554e5d0	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.025	2.75	0.2	D12	2019-12-04 15:09:34.533876	2019-12-04 15:09:34.533876
22cf84c8-16eb-11ea-8a37-3380777bb3e9	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22abf54e-16eb-11ea-8a37-7783533f3483	0.1	1.25	0.2	G12	2019-12-04 15:09:34.537198	2019-12-04 15:09:34.537198
22d07e46-16eb-11ea-8a37-6391f783db6a	2298444a-16eb-11ea-8a37-5389fe5c6d7c	22b1c2bc-16eb-11ea-8a37-937c9b1f8f96	22ad0880-16eb-11ea-8a37-9755071eaf39	0.2	3.5	0.5	E8	2019-12-04 15:09:34.543575	2019-12-04 15:09:34.543575
\.


--
-- Data for Name: segment_choice; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_choice (id, segment_id, program_id, program_sequence_binding_id, type, transpose, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: segment_choice_arrangement; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_choice_arrangement (id, segment_id, segment_choice_id, program_voice_id, instrument_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: segment_choice_arrangement_pick; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_choice_arrangement_pick (id, segment_id, segment_choice_arrangement_id, instrument_audio_id, program_sequence_pattern_event_id, start, length, amplitude, pitch, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: segment_chord; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_chord (id, segment_id, name, "position", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: segment_meme; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_meme (id, segment_id, name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: segment_message; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.segment_message (id, segment_id, type, body, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_auth; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.user_auth (id, type, external_access_token, external_refresh_token, external_account, user_id, created_at, updated_at) FROM stdin;
488d266c-16ea-11ea-88e3-afea5aeef804	Google	ya29.Il-zB-jNzjBGsZoXInCLVFObktE0Hh9zoIbUk02mDJ7gjoOIZdyRBCeh1O7fzFFvxYfbwL_l9xGSb-doaTSgNpdlCNSnhBcKnpY2nI6RNEyLVb-WNtwg8aamsD5hvB_YKg	\N	118376477486134139916	488ada38-16ea-11ea-88e3-573050fbaae5	2019-12-04 15:03:28.35876	2019-12-04 15:03:28.35876
\.


--
-- Data for Name: user_auth_token; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.user_auth_token (id, user_auth_id, user_id, access_token, created_at, updated_at) FROM stdin;
04c0b92a-16eb-11ea-8328-7fbf381b784a	488d266c-16ea-11ea-88e3-afea5aeef804	488ada38-16ea-11ea-88e3-573050fbaae5	1575500924098-572f25f8-1750-4b96-b9ac-0df94250b062-637758216788	2019-12-04 15:08:44.107933	2019-12-04 15:08:44.107933
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.user_role (id, type, user_id, created_at, updated_at) FROM stdin;
488be1e4-16ea-11ea-88e3-6f8537022681	User	488ada38-16ea-11ea-88e3-573050fbaae5	2019-12-04 15:03:28.350007	2019-12-04 15:03:28.350007
f721c4bc-16ea-11ea-a745-9b21ab64d5fa	Admin	488ada38-16ea-11ea-88e3-573050fbaae5	2019-12-04 23:08:21.254829	2019-12-04 23:08:21.254829
147a5cae-16eb-11ea-8a37-839810d44282	User	14796768-16eb-11ea-8a37-330f05571303	2019-12-04 15:09:10.490767	2019-12-04 15:09:10.490767
147b17d4-16eb-11ea-8a37-83a75999838a	Admin	14796768-16eb-11ea-8a37-330f05571303	2019-12-04 15:09:10.495707	2019-12-04 15:09:10.495707
147bc490-16eb-11ea-8a37-d7e59e5bdffc	Artist	14796768-16eb-11ea-8a37-330f05571303	2019-12-04 15:09:10.500093	2019-12-04 15:09:10.500093
147c7dae-16eb-11ea-8a37-7f1c4fecc0b1	Engineer	14796768-16eb-11ea-8a37-330f05571303	2019-12-04 15:09:10.504855	2019-12-04 15:09:10.504855
147dec48-16eb-11ea-8a37-b3e5765d8f47	User	147d397e-16eb-11ea-8a37-87be9159498b	2019-12-04 15:09:10.514222	2019-12-04 15:09:10.514222
147f04c0-16eb-11ea-8a37-d7d0b97c5393	Artist	147d397e-16eb-11ea-8a37-87be9159498b	2019-12-04 15:09:10.521453	2019-12-04 15:09:10.521453
14816210-16eb-11ea-8a37-e7ac82f857a3	Engineer	14802d14-16eb-11ea-8a37-ff75275e34c2	2019-12-04 15:09:10.536955	2019-12-04 15:09:10.536955
1482afa8-16eb-11ea-8a37-f36f6f3d1052	User	14802d14-16eb-11ea-8a37-ff75275e34c2	2019-12-04 15:09:10.545446	2019-12-04 15:09:10.545446
1483aa84-16eb-11ea-8a37-07ce87f54d5e	Artist	14802d14-16eb-11ea-8a37-ff75275e34c2	2019-12-04 15:09:10.551933	2019-12-04 15:09:10.551933
1485e510-16eb-11ea-8a37-5379b5fc9236	User	1484cd56-16eb-11ea-8a37-67d77cefcb75	2019-12-04 15:09:10.566504	2019-12-04 15:09:10.566504
1486eafa-16eb-11ea-8a37-3fa0c2f92c30	Artist	1484cd56-16eb-11ea-8a37-67d77cefcb75	2019-12-04 15:09:10.573254	2019-12-04 15:09:10.573254
14889cba-16eb-11ea-8a37-43fe55e5cb3c	User	1487cd4e-16eb-11ea-8a37-83d2eae0e391	2019-12-04 15:09:10.584324	2019-12-04 15:09:10.584324
14894a02-16eb-11ea-8a37-ffbb21c9a522	Artist	1487cd4e-16eb-11ea-8a37-83d2eae0e391	2019-12-04 15:09:10.588804	2019-12-04 15:09:10.588804
148ab09a-16eb-11ea-8a37-a33984e30cc6	User	148a07bc-16eb-11ea-8a37-075f1966b269	2019-12-04 15:09:10.597995	2019-12-04 15:09:10.597995
148b5f72-16eb-11ea-8a37-973ee300818c	Admin	148a07bc-16eb-11ea-8a37-075f1966b269	2019-12-04 15:09:10.602454	2019-12-04 15:09:10.602454
148c1b7e-16eb-11ea-8a37-bf88eb7595ce	Engineer	148a07bc-16eb-11ea-8a37-075f1966b269	2019-12-04 15:09:10.607263	2019-12-04 15:09:10.607263
148cd028-16eb-11ea-8a37-0339849f198c	Artist	148a07bc-16eb-11ea-8a37-075f1966b269	2019-12-04 15:09:10.611908	2019-12-04 15:09:10.611908
148f6950-16eb-11ea-8a37-239e9f6613b5	Admin	148df3ea-16eb-11ea-8a37-97f115f0bedd	2019-12-04 15:09:10.62882	2019-12-04 15:09:10.62882
1490fc02-16eb-11ea-8a37-c703db92fcfa	Engineer	148df3ea-16eb-11ea-8a37-97f115f0bedd	2019-12-04 15:09:10.639047	2019-12-04 15:09:10.639047
1492bfb0-16eb-11ea-8a37-1baad7ff11b9	Artist	148df3ea-16eb-11ea-8a37-97f115f0bedd	2019-12-04 15:09:10.650604	2019-12-04 15:09:10.650604
14941a18-16eb-11ea-8a37-038e02ac338b	User	148df3ea-16eb-11ea-8a37-97f115f0bedd	2019-12-04 15:09:10.659572	2019-12-04 15:09:10.659572
149669ee-16eb-11ea-8a37-d72ffa484a23	User	149554a0-16eb-11ea-8a37-97c0864fd98e	2019-12-04 15:09:10.674789	2019-12-04 15:09:10.674789
1498430e-16eb-11ea-8a37-4fcfbf3d4c0e	User	14978a40-16eb-11ea-8a37-076e9e062171	2019-12-04 15:09:10.686904	2019-12-04 15:09:10.686904
1499bbc6-16eb-11ea-8a37-5f0f0aa8c1ce	Banned	14990bae-16eb-11ea-8a37-a7327ff72f8c	2019-12-04 15:09:10.696564	2019-12-04 15:09:10.696564
149b2272-16eb-11ea-8a37-27ef11e16c91	Banned	149a7c6e-16eb-11ea-8a37-17f8e34538c8	2019-12-04 15:09:10.705762	2019-12-04 15:09:10.705762
149c730c-16eb-11ea-8a37-3731123f225d	User	149bde88-16eb-11ea-8a37-8b1169e1c6d0	2019-12-04 15:09:10.714391	2019-12-04 15:09:10.714391
149d03c6-16eb-11ea-8a37-d3ce263a99af	Artist	149bde88-16eb-11ea-8a37-8b1169e1c6d0	2019-12-04 15:09:10.718098	2019-12-04 15:09:10.718098
149e038e-16eb-11ea-8a37-2ff4901693a3	Engineer	149bde88-16eb-11ea-8a37-8b1169e1c6d0	2019-12-04 15:09:10.72465	2019-12-04 15:09:10.72465
14a02646-16eb-11ea-8a37-3ba298deef4e	User	149f194a-16eb-11ea-8a37-c3ef8b613a99	2019-12-04 15:09:10.738636	2019-12-04 15:09:10.738636
14a1337e-16eb-11ea-8a37-f73369ba2151	Artist	149f194a-16eb-11ea-8a37-c3ef8b613a99	2019-12-04 15:09:10.745538	2019-12-04 15:09:10.745538
14a3253a-16eb-11ea-8a37-3b0a5ce46c66	Engineer	14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	2019-12-04 15:09:10.758256	2019-12-04 15:09:10.758256
14a41c92-16eb-11ea-8a37-9bca8dae8829	User	14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	2019-12-04 15:09:10.764554	2019-12-04 15:09:10.764554
14a519a8-16eb-11ea-8a37-0bd38f78ff26	Artist	14a22e1e-16eb-11ea-8a37-ab8e0fc5197e	2019-12-04 15:09:10.771037	2019-12-04 15:09:10.771037
14a69314-16eb-11ea-8a37-0fa4e6d31399	User	14a5deb0-16eb-11ea-8a37-47e8b9b9f25a	2019-12-04 15:09:10.780705	2019-12-04 15:09:10.780705
14a862e8-16eb-11ea-8a37-5375a7a2f3fe	User	14a79886-16eb-11ea-8a37-430f7eac1f53	2019-12-04 15:09:10.792574	2019-12-04 15:09:10.792574
14a9cb38-16eb-11ea-8a37-d7ac38b8d9e9	User	14a91d14-16eb-11ea-8a37-b30273a4ae00	2019-12-04 15:09:10.801789	2019-12-04 15:09:10.801789
14ab7172-16eb-11ea-8a37-4bc0a45c67f1	User	14aaae86-16eb-11ea-8a37-eb68019fc4a5	2019-12-04 15:09:10.812615	2019-12-04 15:09:10.812615
14adc9ea-16eb-11ea-8a37-13710f00111a	User	14acb140-16eb-11ea-8a37-275a6bc6aead	2019-12-04 15:09:10.828001	2019-12-04 15:09:10.828001
14b05dcc-16eb-11ea-8a37-b7d81c418dc5	User	14aefe6e-16eb-11ea-8a37-a74a0a8ce70a	2019-12-04 15:09:10.84489	2019-12-04 15:09:10.84489
14b29cd6-16eb-11ea-8a37-2bb6a09e408e	User	14b161fe-16eb-11ea-8a37-db0f5ecefe44	2019-12-04 15:09:10.859511	2019-12-04 15:09:10.859511
14b54a3a-16eb-11ea-8a37-0b3c16df31ac	User	14b3fb12-16eb-11ea-8a37-1b2feca8ca9a	2019-12-04 15:09:10.877044	2019-12-04 15:09:10.877044
14b64ad4-16eb-11ea-8a37-cbe4d974ff7c	Artist	14b3fb12-16eb-11ea-8a37-1b2feca8ca9a	2019-12-04 15:09:10.883587	2019-12-04 15:09:10.883587
14b747fe-16eb-11ea-8a37-578b89b7b281	Engineer	14b3fb12-16eb-11ea-8a37-1b2feca8ca9a	2019-12-04 15:09:10.890118	2019-12-04 15:09:10.890118
14b9a0a8-16eb-11ea-8a37-d3e32fed34db	User	14b88628-16eb-11ea-8a37-bb97ff523cc4	2019-12-04 15:09:10.90543	2019-12-04 15:09:10.90543
14baa2f0-16eb-11ea-8a37-d3e4074ab581	Artist	14b88628-16eb-11ea-8a37-bb97ff523cc4	2019-12-04 15:09:10.912095	2019-12-04 15:09:10.912095
14bc96aa-16eb-11ea-8a37-3bb9d5ed8366	User	14bbac72-16eb-11ea-8a37-57b9b0855f3d	2019-12-04 15:09:10.924905	2019-12-04 15:09:10.924905
14bd7d72-16eb-11ea-8a37-777f020e37cb	Artist	14bbac72-16eb-11ea-8a37-57b9b0855f3d	2019-12-04 15:09:10.930792	2019-12-04 15:09:10.930792
14c065fa-16eb-11ea-8a37-57129410b4fc	Artist	14bef634-16eb-11ea-8a37-9b5c94c4efae	2019-12-04 15:09:10.949859	2019-12-04 15:09:10.949859
14c1ca12-16eb-11ea-8a37-c33bf6bb427e	Engineer	14bef634-16eb-11ea-8a37-9b5c94c4efae	2019-12-04 15:09:10.958966	2019-12-04 15:09:10.958966
14c31bce-16eb-11ea-8a37-376eca0a42a0	User	14bef634-16eb-11ea-8a37-9b5c94c4efae	2019-12-04 15:09:10.967606	2019-12-04 15:09:10.967606
14c57d9c-16eb-11ea-8a37-5ba0d07c9b80	User	14c466a0-16eb-11ea-8a37-7f9d94616956	2019-12-04 15:09:10.98329	2019-12-04 15:09:10.98329
14c777e6-16eb-11ea-8a37-a35106e8fe82	User	14c688fe-16eb-11ea-8a37-a798275d637c	2019-12-04 15:09:10.996297	2019-12-04 15:09:10.996297
14c81c64-16eb-11ea-8a37-5f2212652d01	Artist	14c688fe-16eb-11ea-8a37-a798275d637c	2019-12-04 15:09:11.00051	2019-12-04 15:09:11.00051
14c8c2fe-16eb-11ea-8a37-8b39fd2db8a2	Engineer	14c688fe-16eb-11ea-8a37-a798275d637c	2019-12-04 15:09:11.004772	2019-12-04 15:09:11.004772
14ca1bc2-16eb-11ea-8a37-af02042493aa	User	14c96c72-16eb-11ea-8a37-ab809d222c21	2019-12-04 15:09:11.013508	2019-12-04 15:09:11.013508
14cb5e06-16eb-11ea-8a37-07bce2bfc6eb	User	14cac298-16eb-11ea-8a37-cfbc84ec2a89	2019-12-04 15:09:11.021856	2019-12-04 15:09:11.021856
14cc9a50-16eb-11ea-8a37-4f0c221099c6	User	14cc0072-16eb-11ea-8a37-bfe8fe56bf82	2019-12-04 15:09:11.029951	2019-12-04 15:09:11.029951
14cda242-16eb-11ea-8a37-236f86e14b9a	Artist	14cc0072-16eb-11ea-8a37-bfe8fe56bf82	2019-12-04 15:09:11.036711	2019-12-04 15:09:11.036711
14cfc748-16eb-11ea-8a37-17fa763360e0	User	14ceb736-16eb-11ea-8a37-4bcf05f4efe0	2019-12-04 15:09:11.050756	2019-12-04 15:09:11.050756
14d1ccd2-16eb-11ea-8a37-83720d910977	User	14d0e254-16eb-11ea-8a37-cf89c5a4023b	2019-12-04 15:09:11.064006	2019-12-04 15:09:11.064006
14d3b5ba-16eb-11ea-8a37-a7903984942f	User	14d2c7e0-16eb-11ea-8a37-9bb9460b2667	2019-12-04 15:09:11.076527	2019-12-04 15:09:11.076527
14d54862-16eb-11ea-8a37-ab6e44c39e17	User	14d4a88a-16eb-11ea-8a37-23200faf4adf	2019-12-04 15:09:11.086822	2019-12-04 15:09:11.086822
14d69f1e-16eb-11ea-8a37-ef9df9074056	User	14d5edda-16eb-11ea-8a37-c3273ffc006f	2019-12-04 15:09:11.095623	2019-12-04 15:09:11.095623
14d8273a-16eb-11ea-8a37-6fa19e117284	User	14d7533c-16eb-11ea-8a37-a704da8d90d0	2019-12-04 15:09:11.105537	2019-12-04 15:09:11.105537
14d9acb8-16eb-11ea-8a37-a7b2649fa00d	User	14d8eff8-16eb-11ea-8a37-2b61f0378af8	2019-12-04 15:09:11.115576	2019-12-04 15:09:11.115576
14db8074-16eb-11ea-8a37-0b09a80a22d1	User	14da6e50-16eb-11ea-8a37-67aadff2ee00	2019-12-04 15:09:11.127581	2019-12-04 15:09:11.127581
14ddc0fa-16eb-11ea-8a37-4fd77b05f9cd	User	14dca4f4-16eb-11ea-8a37-9b49bdcb2e7d	2019-12-04 15:09:11.14232	2019-12-04 15:09:11.14232
14dfe8f8-16eb-11ea-8a37-e7d7d1edac36	User	14deee62-16eb-11ea-8a37-53d507873c72	2019-12-04 15:09:11.156466	2019-12-04 15:09:11.156466
14e1d690-16eb-11ea-8a37-b32918bed6ff	Artist	14e0e8c0-16eb-11ea-8a37-336eae21d833	2019-12-04 15:09:11.169106	2019-12-04 15:09:11.169106
14e2c73a-16eb-11ea-8a37-972296ed3800	User	14e0e8c0-16eb-11ea-8a37-336eae21d833	2019-12-04 15:09:11.175276	2019-12-04 15:09:11.175276
14e37518-16eb-11ea-8a37-c39de06f28dc	Engineer	14e0e8c0-16eb-11ea-8a37-336eae21d833	2019-12-04 15:09:11.179709	2019-12-04 15:09:11.179709
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: xj; Owner: root
--

COPY xj.work (id, type, target_id, created_at, updated_at) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--
