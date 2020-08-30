--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "roomId" integer,
    "receiverId" integer
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: room_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room_user (
    id integer NOT NULL,
    "userId" integer,
    "roomId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.room_user OWNER TO postgres;

--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.participants_id_seq OWNER TO postgres;

--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.participants_id_seq OWNED BY public.room_user.id;


--
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    id integer NOT NULL,
    title text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    type text
);


ALTER TABLE public.room OWNER TO postgres;

--
-- Name: room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_id_seq OWNER TO postgres;

--
-- Name: room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_id_seq OWNED BY public.room.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    "displayName" text,
    picture text
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN id SET DEFAULT nextval('public.room_id_seq'::regclass);


--
-- Name: room_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_user ALTER COLUMN id SET DEFAULT nextval('public.participants_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, content, "creationTime", "userId", "roomId", "receiverId") FROM stdin;
1	"Ilk mesaj."	2020-07-30 15:48:44.766971+03	1	1	\N
5	heyyo! 😁	2020-07-30 15:55:59.148516+03	1	1	\N
6	heyyo! 😁 213	2020-07-30 15:57:20.399135+03	1	1	\N
7	Heyyo Bitch!	2020-07-30 17:09:24.27065+03	1	1	\N
8	Hey yo!	2020-07-30 20:05:58.778542+03	1	1	\N
9	Hey yo bitch! 😉	2020-07-30 20:27:33.030486+03	1	1	\N
10	Haha	2020-07-30 20:28:36.668947+03	1	1	\N
11	Heyyo bitch!	2020-08-02 05:08:29.85845+03	1	1	\N
12	hehe :d	2020-08-06 18:55:11.114148+03	1	1	\N
13	xd	2020-08-06 19:34:25.137597+03	1	1	\N
14	qqq	2020-08-06 19:34:55.495259+03	1	1	\N
15	Destek	2020-08-06 19:35:00.915331+03	1	1	\N
16	xd	2020-08-06 19:35:11.607496+03	1	1	\N
17	Hello	2020-08-06 19:36:13.703137+03	1	1	\N
18	Hello	2020-08-06 19:37:00.745035+03	1	1	\N
19	Hop!	2020-08-06 19:37:33.2958+03	1	1	\N
20	Hop	2020-08-06 19:38:25.310765+03	1	1	\N
21	Haha!	2020-08-06 19:38:32.763371+03	1	1	\N
22	Havagi	2020-08-06 19:38:43.382442+03	1	1	\N
23	Why	2020-08-06 19:38:49.939603+03	1	1	\N
24	xd	2020-08-06 19:39:08.399617+03	1	1	\N
25	qq	2020-08-06 19:39:22.031943+03	1	1	\N
28	Hop v2	2020-08-06 19:43:24.59342+03	1	1	\N
29	Hop v54	2020-08-06 19:43:36.248734+03	1	1	\N
30	Iyi tam dedik bizde :D	2020-08-06 19:43:47.2966+03	1	1	\N
32	Bitch.	2020-08-06 19:44:15.284509+03	1	1	\N
33	Hop2	2020-08-06 20:59:50.291674+03	1	1	\N
34	Hop	2020-08-06 21:00:14.148041+03	1	1	\N
35	Bitik	2020-08-06 21:00:19.407249+03	1	1	\N
36	Hey yay!	2020-08-25 00:15:38.499203+03	1	1	\N
26	Hello	2020-08-06 19:40:11.053422+03	2	1	\N
31	Hop	2020-08-06 19:44:08.80811+03	3	1	\N
27	Hop!	2020-08-06 19:42:16.684336+03	3	1	\N
37	Hey yo bitch!	2020-08-25 00:58:24.053313+03	1	1	\N
\.


--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (id, title, "creationTime", "userId", type) FROM stdin;
2	Abigail ve Arthur Private Chat	2020-07-30 16:07:46.949012+03	1	private
1	Genel	2020-07-30 16:05:55.11034+03	1	group
\.


--
-- Data for Name: room_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room_user (id, "userId", "roomId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, "displayName", picture) FROM stdin;
1	Abigail Roberts	https://www.gtabase.com/images/red-dead-redemption-2/characters/abigail-marston.jpg
2	Arthur Morgan	https://www.gtabase.com/images/red-dead-redemption-2/characters/arthur-morgan.jpg
3	Bill Williamson	https://www.gtabase.com/images/red-dead-redemption-2/characters/bill-williamson.jpg
\.


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 37, true);


--
-- Name: participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.participants_id_seq', 1, false);


--
-- Name: room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: message message_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pk PRIMARY KEY (id);


--
-- Name: room_user participants_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room_user
    ADD CONSTRAINT participants_pk PRIMARY KEY (id);


--
-- Name: room room_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pk PRIMARY KEY (id);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

