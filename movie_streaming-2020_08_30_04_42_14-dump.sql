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
-- Name: cast; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."cast" (
    id integer,
    "displayName" text,
    "avatarUrl" text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public."cast" OWNER TO postgres;

--
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    text text,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "movieId" integer
);


ALTER TABLE public.chat_message OWNER TO postgres;

--
-- Name: chat_message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_message_id_seq OWNER TO postgres;

--
-- Name: chat_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_message_id_seq OWNED BY public.chat_message.id;


--
-- Name: user_continue_watching; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_continue_watching (
    id integer NOT NULL,
    progress integer,
    "movieId" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_continue_watching OWNER TO postgres;

--
-- Name: continue_watching_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.continue_watching_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.continue_watching_id_seq OWNER TO postgres;

--
-- Name: continue_watching_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.continue_watching_id_seq OWNED BY public.user_continue_watching.id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    "userId" integer,
    text text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedback_id_seq OWNER TO postgres;

--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    title text,
    description text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.genre OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_id_seq OWNED BY public.genre.id;


--
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie (
    id integer NOT NULL,
    "originalTitle" text,
    title text,
    year text,
    description text,
    "directorId" integer,
    "TrailerUrl" text,
    "posterUrl" text,
    "creationTime" timestamp with time zone DEFAULT now(),
    runtime integer,
    "viewCount" integer
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Name: movie_cast; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_cast (
    id integer NOT NULL,
    "peopleId" integer,
    "movieId" text
);


ALTER TABLE public.movie_cast OWNER TO postgres;

--
-- Name: movie_cast_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_cast_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_cast_id_seq OWNER TO postgres;

--
-- Name: movie_cast_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_cast_id_seq OWNED BY public.movie_cast.id;


--
-- Name: movie_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_comment (
    id integer NOT NULL,
    text text,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "movieId" integer
);


ALTER TABLE public.movie_comment OWNER TO postgres;

--
-- Name: movie_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_comment_id_seq OWNER TO postgres;

--
-- Name: movie_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_comment_id_seq OWNED BY public.movie_comment.id;


--
-- Name: movie_episode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_episode (
    id integer NOT NULL,
    "movieId" integer,
    "videoUrl" text
);


ALTER TABLE public.movie_episode OWNER TO postgres;

--
-- Name: movie_episode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_episode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_episode_id_seq OWNER TO postgres;

--
-- Name: movie_episode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_episode_id_seq OWNED BY public.movie_episode.id;


--
-- Name: movie_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genre (
    id integer NOT NULL,
    "movieId" integer,
    "genreId" integer
);


ALTER TABLE public.movie_genre OWNER TO postgres;

--
-- Name: movie_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_genre_id_seq OWNER TO postgres;

--
-- Name: movie_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_genre_id_seq OWNED BY public.movie_genre.id;


--
-- Name: movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_id_seq OWNER TO postgres;

--
-- Name: movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movie_id_seq OWNED BY public.movie.id;


--
-- Name: networks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.networks (
    id integer NOT NULL,
    title text,
    "pictureUrl" text,
    "parentId" integer DEFAULT 0,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.networks OWNER TO postgres;

--
-- Name: networks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.networks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.networks_id_seq OWNER TO postgres;

--
-- Name: networks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.networks_id_seq OWNED BY public.networks.id;


--
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series (
    id integer NOT NULL,
    title text,
    "showType" integer,
    "pictureUrl" text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "networkId" integer
);


ALTER TABLE public.series OWNER TO postgres;

--
-- Name: series_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_id_seq OWNER TO postgres;

--
-- Name: series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_id_seq OWNED BY public.series.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email text,
    password text,
    "displayName" text,
    "avatarUrl" text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_favorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_favorite (
    id integer NOT NULL,
    "movieId" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_favorite OWNER TO postgres;

--
-- Name: user_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_favorite_id_seq OWNER TO postgres;

--
-- Name: user_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_favorite_id_seq OWNED BY public.user_favorite.id;


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
-- Name: user_library; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_library (
    id integer NOT NULL,
    "movieId" integer,
    "userId" integer,
    vote text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_library OWNER TO postgres;

--
-- Name: user_library_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_library_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_library_id_seq OWNER TO postgres;

--
-- Name: user_library_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_library_id_seq OWNED BY public.user_library.id;


--
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_message_id_seq'::regclass);


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: movie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);


--
-- Name: movie_cast id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_cast ALTER COLUMN id SET DEFAULT nextval('public.movie_cast_id_seq'::regclass);


--
-- Name: movie_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_comment ALTER COLUMN id SET DEFAULT nextval('public.movie_comment_id_seq'::regclass);


--
-- Name: movie_episode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_episode ALTER COLUMN id SET DEFAULT nextval('public.movie_episode_id_seq'::regclass);


--
-- Name: movie_genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre ALTER COLUMN id SET DEFAULT nextval('public.movie_genre_id_seq'::regclass);


--
-- Name: networks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.networks ALTER COLUMN id SET DEFAULT nextval('public.networks_id_seq'::regclass);


--
-- Name: series id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series ALTER COLUMN id SET DEFAULT nextval('public.series_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_continue_watching id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_continue_watching ALTER COLUMN id SET DEFAULT nextval('public.continue_watching_id_seq'::regclass);


--
-- Name: user_favorite id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite ALTER COLUMN id SET DEFAULT nextval('public.user_favorite_id_seq'::regclass);


--
-- Name: user_library id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_library ALTER COLUMN id SET DEFAULT nextval('public.user_library_id_seq'::regclass);


--
-- Data for Name: cast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."cast" (id, "displayName", "avatarUrl", "creationTime") FROM stdin;
\.


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, text, "userId", "creationTime", "movieId") FROM stdin;
1	hello	1	2020-08-03 05:14:58.17609+03	1
2	qqq 💖	1	2020-08-03 05:15:01.860543+03	1
3	Devam	1	2020-08-03 05:15:51.710781+03	1
4	Hello 😜	1	2020-08-03 05:17:49.653372+03	1
5	Viven 	1	2020-08-03 05:18:37.127889+03	1
6	I understand	1	2020-08-04 00:38:33.530237+03	1
7	Bro	1	2020-08-04 00:38:34.674153+03	1
8	Xd	1	2020-08-04 00:38:53.51382+03	1
9	xd	1	2020-08-04 00:39:41.867493+03	1
10	HELLO	1	2020-08-04 00:40:07.225805+03	1
11	xd	1	2020-08-04 00:40:26.688713+03	1
12	xd	1	2020-08-04 00:40:46.021577+03	1
13	xd	1	2020-08-04 00:41:01.347022+03	1
14	Hello bitch	1	2020-08-04 00:41:04.99498+03	1
15	I am fuck you	1	2020-08-04 00:41:07.962651+03	1
16	Xd	1	2020-08-04 00:41:25.785044+03	1
17	Bitch	1	2020-08-04 00:41:27.403108+03	1
18	Heyyo 🤦‍♀️🤦‍♀️🤦‍♀️	1	2020-08-04 00:41:43.87595+03	1
19	AHAHA :D	1	2020-08-04 00:41:47.427214+03	1
20	❤💕😘	1	2020-08-04 00:41:56.026929+03	1
21	Daha iyi olabilir	1	2020-08-04 00:41:59.026513+03	1
22	I love you Turkey	1	2020-08-04 00:42:02.538387+03	1
23	Bitch...	1	2020-08-04 00:42:03.978466+03	1
24	🎂🌹🎉🎉🌹🌹	1	2020-08-04 00:42:09.21841+03	1
25	Hello world	1	2020-08-04 02:57:42.160048+03	1
26	Selamlar	1	2020-08-04 02:57:43.568646+03	1
27	Bitch	1	2020-08-04 02:57:44.712572+03	1
28	Where are you from?	1	2020-08-04 02:57:47.688712+03	1
29	Hellob	1	2020-08-04 14:08:15.893364+03	1
30	ro	1	2020-08-04 14:08:16.436594+03	1
31	what's up :D	1	2020-08-04 14:08:18.652448+03	1
32	Haha :D	1	2020-08-04 14:11:51.463162+03	1
33	Hello	1	2020-08-04 17:42:04.993133+03	1
34	World	1	2020-08-04 17:42:08.887504+03	1
35	Hello	1	2020-08-04 17:42:25.021394+03	1
36	Bitch 💕❤	1	2020-08-04 17:42:32.535123+03	1
37	Yeah.	1	2020-08-04 18:39:33.169957+03	1
38	Hello	1	2020-08-04 18:40:03.173756+03	1
39	Xd	1	2020-08-06 21:26:15.76476+03	1
40	Bitch	1	2020-08-06 21:26:17.159161+03	1
41	I work for you	1	2020-08-06 21:26:20.887217+03	1
42	Ha :D	1	2020-08-06 21:26:22.071154+03	1
43	☺😎😋😘😘😘	1	2020-08-06 21:26:28.719+03	1
44	Tabii	1	2020-08-06 22:03:23.13401+03	1
45	Daha ne iste :D	1	2020-08-06 22:03:25.52864+03	1
46	Heyyoh!	1	2020-08-07 00:16:33.570436+03	1
47	xd	1	2020-08-07 00:16:35.350559+03	1
48	Hey yoh!	1	2020-08-07 03:33:05.429433+03	1
49	Xd	1	2020-08-07 03:33:07.486594+03	1
50	Xd	1	2020-08-07 19:08:13.801439+03	1
51	Yeah	1	2020-08-07 19:08:15.92688+03	1
52	Party	1	2020-08-08 00:01:42.843898+03	1
53	Mode is awful	1	2020-08-08 00:01:46.165811+03	1
54	:D	1	2020-08-08 00:01:46.613175+03	1
55	Haha :D	1	2020-08-09 14:08:59.729101+03	1
56	Yeah	1	2020-08-09 19:39:25.398999+03	1
57	Good job bro!	1	2020-08-10 03:58:40.407347+03	1
58	HAGA	1	2020-08-10 03:58:48.137378+03	1
59	Hello!	1	2020-08-10 03:59:58.002031+03	1
60	Xd	1	2020-08-10 04:00:29.925764+03	1
61	Haha :D	1	2020-08-10 04:00:34.153411+03	1
62	xd	1	2020-08-10 04:03:12.276855+03	1
63	Hihi	1	2020-08-10 04:03:18.458759+03	1
64	Q	1	2020-08-10 04:03:20.67295+03	1
65	Hop!	1	2020-08-10 04:05:50.965475+03	1
66	Xd hop..	1	2020-08-10 04:05:54.353649+03	1
67	hello!	1	2020-08-10 04:08:04.280993+03	1
68	haha	1	2020-08-10 04:08:18.48997+03	1
69	Hello world	1	2020-08-11 01:33:18.203349+03	1
70	Yeah	1	2020-08-11 01:33:19.700342+03	1
71	It's cool baby	1	2020-08-11 01:33:22.084246+03	1
72	Hey yoh	1	2020-08-11 17:35:25.332738+03	1
73	Ok	1	2020-08-11 17:35:27.014247+03	1
74	😃	1	2020-08-11 17:35:30.990487+03	1
75	Hello !	1	2020-08-13 23:35:09.608943+03	1
76	Yes	1	2020-08-21 19:23:13.41858+03	1
77	It's cool	1	2020-08-21 19:23:16.286562+03	1
78	Hi :D	1	2020-08-21 19:23:25.590692+03	1
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (id, "userId", text, "creationTime") FROM stdin;
1	1	Cok guzel bir websitesi olmus, tesekkurler.	2020-08-14 01:57:28.176401+03
2	1	Calisiyor xd	2020-08-14 01:58:40.250425+03
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, title, description, "creationTime") FROM stdin;
4	Biography	\N	2020-08-02 23:42:05.05171+03
9	Family	\N	2020-08-02 23:42:21.401204+03
6	Crime	\N	2020-08-02 23:42:05.05171+03
1	Action	\N	2020-08-02 23:41:44.803647+03
11	Film Noir	\N	2020-08-03 01:17:32.269421+03
5	Comedy	\N	2020-08-02 23:42:05.05171+03
2	Adventure	\N	2020-08-02 23:41:49.649337+03
10	Fantasy	\N	2020-08-02 23:42:28.866806+03
13	History	\N	2020-08-03 01:17:32.289087+03
7	Documentary	\N	2020-08-02 23:42:13.625387+03
3	Animation	\N	2020-08-02 23:41:54.529363+03
8	Drama	\N	2020-08-02 23:42:17.753692+03
14	Horror	\N	2020-08-03 01:24:25.344222+03
15	Music	\N	2020-08-03 01:24:25.344222+03
16	Musical	\N	2020-08-03 01:24:25.344222+03
17	Mystery	\N	2020-08-03 01:24:25.344222+03
18	Romance	\N	2020-08-03 01:24:37.194951+03
19	Sci-Fi	\N	2020-08-03 01:24:37.194951+03
20	Short Film	\N	2020-08-03 01:24:42.429764+03
21	Sport	\N	2020-08-03 01:24:51.566896+03
22	Superhero	\N	2020-08-03 01:24:51.566896+03
23	Thriller	\N	2020-08-03 01:25:01.486366+03
24	War	\N	2020-08-03 01:25:01.486366+03
25	Western	\N	2020-08-03 01:25:01.486366+03
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (id, "originalTitle", title, year, description, "directorId", "TrailerUrl", "posterUrl", "creationTime", runtime, "viewCount") FROM stdin;
13	Mile 22	Mile 22	2018	\N	\N	\N	https://img2.hulu.com/user/v3/artwork/63247bc3-2b2e-4687-a8aa-158b7bcc8eaa?base_image_bucket_name=image_manager&base_image=2644a4ab-b7ce-4477-9914-095242d30b3b&operations=%5B%7B%22resize%22:%22810x810%7Cmax%22%7D,%7B%22format%22:%22jpeg%22%7D%5D	2020-07-18 17:58:27.137473+03	\N	\N
14	What Men What	What Men What	2019	\N	\N	\N	https://image.tmdb.org/t/p/w600_and_h900_bestv2/30IiwvIRqPGjUV0bxJkZfnSiCL.jpg	2020-07-18 17:59:31.086287+03	\N	\N
15	Tyler Perry's Acrimony\r\n	Tyler Perry's Acrimony\r\n	2018	\N	\N	\N	https://image.tmdb.org/t/p/w600_and_h900_bestv2/upURIW6jeEcTJKpaJeoNw5jbcr1.jpg	2020-07-18 18:00:56.264186+03	\N	\N
10	Step Brothers	Step Brothers	2008	\N	\N	\N	https://image.tmdb.org/t/p/original/jV0eDViuTRf9cmj4H0JNvbvaNbR.jpg	2020-07-17 18:20:10.775522+03	\N	\N
1	Space Jam	Space Jam	1996	Little, yeniden gençliğini yaşama şansı elde eden bir kadının hikayesini konu ediyor. Jordan 30’lu yaşlarında olan genç bir kadındır. Hayatının zorlu döneminden geçen genç kadın gerek özel hayatı gerekse iş dünyasında çeşitli zorluklarla boğuşur. Jordan’ın asistanı April ise bu süreçten etkilenenlerin başından gelir. Jordan ile çalışmak April için fazlasıyla yorucudur. Yetişkin olmanın yükünü fazlasıyla omuzlarında taşıyan Jordan, tam da artık bu yükü taşımakta zorlandığı dönemde hayatını değiştirecek bir mucize ile karşı karşıya kalır. Bir sabah uyandığında aynada gördüğü 30 yaşındaki bir kadın değil 13 yaşında bir çocuktur. Başına gelen bu inanılmaz durumla nasıl baş edeceğini düşünen Jordan, başlarda ne kadar şikayet etse de bir süre sonra anın tadını çıkarmaya başlar. Yetişkinliğin tüm sorumluluğundan kurtulmuş kaygısız gençlik dönemine dönmüş olmak onun aslında tam da istediği şeydir. Artık ipleri iyice salan Jordan, göründüğü yaşa göre davranmaya karar verir.	\N	\N	https://image.tmdb.org/t/p/original/h9gIUjetY2Ycy04s0MIXdPCe804.jpg	2020-04-02 00:57:58.943303+03	88	\N
17	Ready Player One	Ready Player One	2018	\N	\N	\N	https://image.tmdb.org/t/p/original/sbSEzrkW9ej8VvOtSVCvimt24CE.jpg	2020-07-18 18:06:42.632139+03	\N	\N
12	A Simple Favor	A Simple Favor	2018	\N	\N	\N	https://image.tmdb.org/t/p/original/5EJWZQ8dh99hfgXP9zAD5Ak5Hrn.jpg	2020-07-18 17:56:55.341231+03	\N	\N
11	Overlord	Overlord	2018	\N	\N	\N	https://image.tmdb.org/t/p/original/2Sfo3O54kTAAnBfZaCXrwimORSo.jpg	2020-07-18 17:52:45.916777+03	\N	\N
9	Joker	Joker	2019	\N	\N	\N	https://image.tmdb.org/t/p/original/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg	2020-07-17 18:18:00.442673+03	\N	\N
16	Central Intelligence	Central Intelligence	2016	\N	\N	\N	https://image.tmdb.org/t/p/original/7irCMBIivXAqjZ7MgZoGVLrgACR.jpg	2020-07-18 18:03:38.885066+03	\N	\N
2	Yalanlar Üstüne	Yalanlar Üstüne	2008	Onward, babalarını çok küçük yaşta kaybeden iki genç elf kardeşin hikayesini konu ediniyor. Kardeşler, hatırlamakta zorlandıkları ve çok özledikleri babaları ile son bir gün geçirme fırsatlarının olduğunu öğrenirler. Dünyada var olan bir büyü, onların babaları ile kavuşmalarını sağlayacaktır. Kardeşler, bu fırsatı kaçırmamak için ne yapıp edip büyüye sahip olmanın yolunu bulmalıdır. Kendilerini zorlu bir mücadeleye sokan kardeşler, büyüye ulaşıp babalarını son bir kez görebilme imkanını bulabilecekler midir?	\N	\N	https://image.tmdb.org/t/p/original/igVG6AP1mI4mpiUlKH5ulJGMrDD.jpg	2020-04-02 00:57:58.943303+03	128	\N
4	Düşmanı Korurken 	Düşmanı Korurken 	2012	Andrea, yıllar önce çıkardığı romanından sonra kariyeri duraksamış aklı başında bir yazardır. Savaş zamanı hakında anı yazıları yazan Nick ile ile birlikte olmaya başladığı sırada, masaj terpisti olan kız kardeşi Tara da yaşlı bir rock yıldızı ile ilişki yaşamaya başlamıştır.\r\n\r\n	\N	\N	https://image.tmdb.org/t/p/original/7SYBPjv5ywF6cI4BSFFtlDyChT2.jpg	2020-04-02 02:40:37.847+03	115	\N
6	Ted 2	Ted 2	2015	What starts as a crazy one-night stand ends up in a relationship. But Dharam and Shyra fall out of love just as quickly. Where will life take them now?\r\n\r\n	\N	\N	https://image.tmdb.org/t/p/original/38C91I7Xft0gyY7BITm8i4yvuRb.jpg	2020-04-02 02:42:12.757159+03	\N	\N
7	En Büyük Korku	En Büyük Korku	2002	Bir denizaltı ekibi, suyun altındaki laboratuvarlarında çalışmaktadır. Ancak denizaltında çalışmalarına devam ederken dünya üzerinde büyük bir deprem olur. Bu depremin sonucunda ise binlerce km denizin altında bulunan ekip yaşam mücadelesi vermek zorunda kalacak, karşılarına ummadıkları zorluklar çıkacaktır.	\N	\N	https://image.tmdb.org/t/p/original/3E4LW4bjRhEMDeeXeIsmkJ94v8K.jpg	2020-04-02 04:38:35.904911+03	\N	\N
8	Vanilla Sky	Stargirl 	2001	Mica Lisesi'nde okuyan Leo Borlock, ortalama bir öğrencidir. İyi notlar alan ve okulun bando takımında olan Leo, diğer öğrenciler tarafından pek fark edilmez. Ancak onun hayatı, Susan 'Stargirl' Caraway adında okula yeni bir öğrencinin gelmesi ile bambaşka bir hal alır. Gizemli ve ilginç bir kız olan Stargirl, Leo'nun fazlasyla ilgisini çeker. Zamanını onunla daha fazla bilgi edinmekle geçiren Leo, Stargil sayesinde bilmediği bir hayatın içine dalar.	\N	\N	https://image.tmdb.org/t/p/original/cAh2pCiNPftsY3aSqJuIOde7uWr.jpg	2020-04-02 04:39:48.179683+03	\N	\N
5	Hulk	Hulk	2003	A married woman has an affair with a suicidal lover while caring for her husband's sick relatives.	\N	\N	https://image.tmdb.org/t/p/original/vcFeElC8eXI668WSIxcDNkJSBxv.jpg	2020-04-02 02:41:22.525168+03	138	\N
3	Feal The Beat	Bazen Daima Asla	2020	Alan, scrabble oyunu yüzünden tartıştığı ve evi terkeden favori oğlunu bıkmadan aramaktadır. Kalan oğlu Peter ise, hiç kazanamayacağı bir rekabete girmiştir.	\N	\N	https://image.tmdb.org/t/p/original/Af2jt7m9GLFpR4V11xOsFmT8OKD.jpg	2020-04-02 00:57:58.943303+03	107	\N
18	The First Wives Club	İlk Eşler Kulübü	1996	xd	\N	\N	https://artist.api.cdn.hbo.com/images/GXv4JcgUpMZpiwwEAAALd/tileburnedin?v=82ceaee2a365cb9d40be58848520ae2d&size=1000x1500	2020-08-08 00:30:59.589079+03	\N	\N
19	Batman Forever	Batman Daima	1995	xd	\N	\N	https://artist.api.cdn.hbo.com/images/GXdu2UAA5zMPCwwEAADWg/tileburnedin?v=4ebd18d12a6fcaa94b195633db570aca&size=1000x1500	2020-08-08 00:32:51.794046+03	\N	\N
20	Marvin's Room	Marvin'in Odası\r\n	1996	\N	\N	\N	https://artist.api.cdn.hbo.com/images/GXZtyawwJa8IggQEAAAPZ/tileburnedin?v=4ae5b587bbf5608c8316fb4587cf1d3b&size=1000x1500	2020-08-08 00:33:43.106905+03	\N	\N
21	Wedding Crashers	Davetsiz Çapkınlar	2005	\N	\N	\N	https://artist.api.cdn.hbo.com/images/GXwO8LwQUJbnDHQEAAARh/tileburnedin?v=2a9b665feec61465b80fbcd24905bf17&size=1000x1500	2020-08-08 00:34:52.746034+03	\N	\N
25	Knives Out	\N	2019	\N	\N	\N	https://m.media-amazon.com/images/M/MV5BMGUwZjliMTAtNzAxZi00MWNiLWE2NzgtZGUxMGQxZjhhNDRiXkEyXkFqcGdeQXVyNjU1NzU3MzE@._V1_SY1000_SX675_AL_.jpg	2020-08-21 22:17:25.134862+03	\N	\N
23	Hafız	\N	2020	\N	\N	\N	https://m.media-amazon.com/images/M/MV5BYWJhOGU2OWItMDAxMS00MzQ5LThhNjgtZTkxNjk4ZDJlOGNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_UY268_CR9,0,182,268_AL_.jpg	2020-08-21 22:09:56.75459+03	\N	\N
22	Dil Bechara	\N	2020	\N	\N	\N	https://m.media-amazon.com/images/M/MV5BNmI0MTliMTAtMmJhNC00NTJmLTllMzQtMDI3NzA1ODMyZWI1XkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_UY268_CR16,0,182,268_AL_.jpg	2020-08-21 22:09:36.228824+03	\N	\N
24	The Umbrella Academy	\N	2019	\N	\N	\N	https://m.media-amazon.com/images/M/MV5BNzA5MjkwYzMtNGY2MS00YWRjLThkNTktOTNmMzdlZjE3Y2IxXkEyXkFqcGdeQXVyMjkwMzMxODg@._V1_SY1000_CR0,0,680,1000_AL_.jpg	2020-08-21 22:16:58.576108+03	\N	\N
\.


--
-- Data for Name: movie_cast; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_cast (id, "peopleId", "movieId") FROM stdin;
\.


--
-- Data for Name: movie_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_comment (id, text, "userId", "creationTime", "movieId") FROM stdin;
1	Bu bir deneme yorumdur.	1	2020-08-09 19:43:33.265941+03	1
2	Cok guzel film idi.	2	2020-08-11 03:24:36.846192+03	1
\.


--
-- Data for Name: movie_episode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_episode (id, "movieId", "videoUrl") FROM stdin;
\.


--
-- Data for Name: movie_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_genre (id, "movieId", "genreId") FROM stdin;
1	1	3
3	1	5
6	1	19
4	1	9
2	1	2
5	1	10
7	2	21
\.


--
-- Data for Name: networks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.networks (id, title, "pictureUrl", "parentId", "creationTime") FROM stdin;
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.series (id, title, "showType", "pictureUrl", "creationTime", "networkId") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "displayName", "avatarUrl", "creationTime") FROM stdin;
2	aaa	bbb	Onursoner Bilgin	https://a.rsg.sc/s/GTAIIIAnniversary/n/GTA3Ann11.png	2020-06-28 00:59:14.557348+03
1	olcayusta0@gmail.com	abc	Olcay Usta	https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1e126ec5-a95d-493f-85b4-a8c618b05609/ddlfymx-eeb2fb20-e115-4940-b19e-ba445b859da8.png/v1/fill/w_1280,h_1657,q_80,strp/short_by_sceev_ddlfymx-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD0xNjU3IiwicGF0aCI6IlwvZlwvMWUxMjZlYzUtYTk1ZC00OTNmLTg1YjQtYThjNjE4YjA1NjA5XC9kZGxmeW14LWVlYjJmYjIwLWUxMTUtNDk0MC1iMTllLWJhNDQ1Yjg1OWRhOC5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.mWErFJ0kqZJ5ysgmhww5WKclhv8VNrgNr3CwkfjkLnE	2020-06-27 22:48:52.249759+03
7	olcay02@gmail.com	123456	abc	https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/5ce79a6a-19ed-4c4f-946a-ca8ab3f77e37/ddyi8zl-97af417c-ef69-498a-be0c-e376e9880348.jpg/v1/fit/w_150,h_150,q_70,strp/flor_by_arthurhenri_ddyi8zl-150.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD0xMzUwIiwicGF0aCI6IlwvZlwvNWNlNzlhNmEtMTllZC00YzRmLTk0NmEtY2E4YWIzZjc3ZTM3XC9kZHlpOHpsLTk3YWY0MTdjLWVmNjktNDk4YS1iZTBjLWUzNzZlOTg4MDM0OC5qcGciLCJ3aWR0aCI6Ijw9MTA4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.HTfrUT4JmJE-N3HW3VeoJNSDycd9lOe6vWSOCy8xUac	2020-08-11 17:10:13.841406+03
\.


--
-- Data for Name: user_continue_watching; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_continue_watching (id, progress, "movieId", "userId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user_favorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_favorite (id, "movieId", "userId", "creationTime") FROM stdin;
1	1	1	2020-07-29 05:01:39.337562+03
2	10	1	2020-08-03 01:34:48.792588+03
3	3	1	2020-08-08 00:37:24.806479+03
4	21	1	2020-08-08 00:40:41.472468+03
5	6	1	2020-08-08 14:03:57.503124+03
6	19	1	2020-08-08 17:44:49.695004+03
7	12	1	2020-08-08 19:14:07.599285+03
9	18	1	2020-08-14 18:36:49.6784+03
\.


--
-- Data for Name: user_library; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_library (id, "movieId", "userId", vote, "creationTime") FROM stdin;
1	1	1	watch_later	2020-08-11 03:16:15.297104+03
3	2	1	favorite	2020-08-11 03:16:54.843624+03
4	4	1	watch_later	2020-08-11 17:41:45.981537+03
5	20	1	watch_later	2020-08-11 17:41:55.528734+03
2	2	1	i_watched	2020-08-11 03:16:26.192241+03
\.


--
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 78, true);


--
-- Name: continue_watching_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.continue_watching_id_seq', 1, false);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_id_seq', 2, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 25, true);


--
-- Name: movie_cast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_cast_id_seq', 1, false);


--
-- Name: movie_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_comment_id_seq', 2, true);


--
-- Name: movie_episode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_episode_id_seq', 1, false);


--
-- Name: movie_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_genre_id_seq', 7, true);


--
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_id_seq', 25, true);


--
-- Name: networks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.networks_id_seq', 1, false);


--
-- Name: series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.series_id_seq', 1, false);


--
-- Name: user_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_favorite_id_seq', 9, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 7, true);


--
-- Name: user_library_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_library_id_seq', 5, true);


--
-- Name: chat_message chat_message_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_pk PRIMARY KEY (id);


--
-- Name: user_continue_watching continue_watching_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_continue_watching
    ADD CONSTRAINT continue_watching_pk PRIMARY KEY (id);


--
-- Name: feedback feedback_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pk PRIMARY KEY (id);


--
-- Name: genre genre_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pk PRIMARY KEY (id);


--
-- Name: movie_cast movie_cast_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_cast
    ADD CONSTRAINT movie_cast_pk PRIMARY KEY (id);


--
-- Name: movie_comment movie_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_comment
    ADD CONSTRAINT movie_comment_pk PRIMARY KEY (id);


--
-- Name: movie_episode movie_episode_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_episode
    ADD CONSTRAINT movie_episode_pk PRIMARY KEY (id);


--
-- Name: movie_genre movie_genre_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre
    ADD CONSTRAINT movie_genre_pk PRIMARY KEY (id);


--
-- Name: movie movie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pk PRIMARY KEY (id);


--
-- Name: networks networks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.networks
    ADD CONSTRAINT networks_pk PRIMARY KEY (id);


--
-- Name: series series_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pk PRIMARY KEY (id);


--
-- Name: user_favorite user_favorite_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_favorite
    ADD CONSTRAINT user_favorite_pk PRIMARY KEY (id);


--
-- Name: user_library user_library_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_library
    ADD CONSTRAINT user_library_pk PRIMARY KEY (id);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

