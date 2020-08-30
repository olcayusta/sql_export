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
-- Name: brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brand (
    id integer NOT NULL,
    title text,
    logo text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.brand OWNER TO postgres;

--
-- Name: brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brand_id_seq OWNER TO postgres;

--
-- Name: brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brand_id_seq OWNED BY public.brand.id;


--
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    message text,
    "partyId" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.chat_message OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_messages_id_seq OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_messages_id_seq OWNED BY public.chat_message.id;


--
-- Name: episode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.episode (
    id integer NOT NULL,
    title text,
    description text,
    picture text,
    "seasonNumber" integer,
    "episodeNumber" integer,
    year integer,
    runtime integer,
    rate text,
    "streamUrl" text,
    "seriesId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.episode OWNER TO postgres;

--
-- Name: episode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.episode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episode_id_seq OWNER TO postgres;

--
-- Name: episode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.episode_id_seq OWNED BY public.episode.id;


--
-- Name: genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    title text,
    type text,
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
    title text,
    description text,
    picture text,
    cover text,
    year integer,
    runtime integer,
    "streamUrl" text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Name: movie_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movie_genre (
    id integer NOT NULL,
    "genreId" integer,
    "movieId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
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
-- Name: series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series (
    id integer NOT NULL,
    title text,
    description text,
    picture text,
    cover text,
    "startYear" integer,
    "endYear" integer,
    runtime integer,
    rate text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.series OWNER TO postgres;

--
-- Name: series_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.series_genre (
    id integer NOT NULL,
    "genreId" integer,
    "seriesId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.series_genre OWNER TO postgres;

--
-- Name: series_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.series_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_genre_id_seq OWNER TO postgres;

--
-- Name: series_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.series_genre_id_seq OWNED BY public.series_genre.id;


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
    "pictureUrl" text,
    "signUpDate" timestamp with time zone DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_continue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_continue (
    id integer NOT NULL,
    "contentId" integer,
    runtime integer,
    "genreId" integer,
    "creationTime" integer,
    "userId" integer
);


ALTER TABLE public.user_continue OWNER TO postgres;

--
-- Name: user_continue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_continue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_continue_id_seq OWNER TO postgres;

--
-- Name: user_continue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_continue_id_seq OWNED BY public.user_continue.id;


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
-- Name: user_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_list (
    id integer NOT NULL,
    "genreId" integer,
    "contentId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_list OWNER TO postgres;

--
-- Name: user_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_list_id_seq OWNER TO postgres;

--
-- Name: user_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_list_id_seq OWNED BY public.user_list.id;


--
-- Name: watch_party; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.watch_party (
    id integer NOT NULL,
    "contentId" integer,
    "contentType" integer,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.watch_party OWNER TO postgres;

--
-- Name: watch_party_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.watch_party_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.watch_party_id_seq OWNER TO postgres;

--
-- Name: watch_party_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.watch_party_id_seq OWNED BY public.watch_party.id;


--
-- Name: brand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand ALTER COLUMN id SET DEFAULT nextval('public.brand_id_seq'::regclass);


--
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_messages_id_seq'::regclass);


--
-- Name: episode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episode ALTER COLUMN id SET DEFAULT nextval('public.episode_id_seq'::regclass);


--
-- Name: genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre ALTER COLUMN id SET DEFAULT nextval('public.genre_id_seq'::regclass);


--
-- Name: movie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);


--
-- Name: movie_genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movie_genre ALTER COLUMN id SET DEFAULT nextval('public.movie_genre_id_seq'::regclass);


--
-- Name: series id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series ALTER COLUMN id SET DEFAULT nextval('public.series_id_seq'::regclass);


--
-- Name: series_genre id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_genre ALTER COLUMN id SET DEFAULT nextval('public.series_genre_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: user_continue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_continue ALTER COLUMN id SET DEFAULT nextval('public.user_continue_id_seq'::regclass);


--
-- Name: user_list id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_list ALTER COLUMN id SET DEFAULT nextval('public.user_list_id_seq'::regclass);


--
-- Name: watch_party id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.watch_party ALTER COLUMN id SET DEFAULT nextval('public.watch_party_id_seq'::regclass);


--
-- Data for Name: brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brand (id, title, logo, "creationTime") FROM stdin;
\.


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, message, "partyId", "userId", "creationTime") FROM stdin;
\.


--
-- Data for Name: episode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.episode (id, title, description, picture, "seasonNumber", "episodeNumber", year, runtime, rate, "streamUrl", "seriesId", "creationTime") FROM stdin;
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre (id, title, type, "creationTime") FROM stdin;
\.


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie (id, title, description, picture, cover, year, runtime, "streamUrl", "creationTime") FROM stdin;
\.


--
-- Data for Name: movie_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movie_genre (id, "genreId", "movieId", "creationTime") FROM stdin;
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.series (id, title, description, picture, cover, "startYear", "endYear", runtime, rate, "creationTime") FROM stdin;
\.


--
-- Data for Name: series_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.series_genre (id, "genreId", "seriesId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "displayName", "pictureUrl", "signUpDate") FROM stdin;
\.


--
-- Data for Name: user_continue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_continue (id, "contentId", runtime, "genreId", "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: user_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_list (id, "genreId", "contentId", "creationTime") FROM stdin;
\.


--
-- Data for Name: watch_party; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.watch_party (id, "contentId", "contentType", "userId", "creationTime") FROM stdin;
\.


--
-- Name: brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brand_id_seq', 1, false);


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_messages_id_seq', 1, false);


--
-- Name: episode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.episode_id_seq', 1, false);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_id_seq', 1, false);


--
-- Name: movie_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_genre_id_seq', 1, false);


--
-- Name: movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_id_seq', 1, false);


--
-- Name: series_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.series_genre_id_seq', 1, false);


--
-- Name: series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.series_id_seq', 1, false);


--
-- Name: user_continue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_continue_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: user_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_list_id_seq', 1, false);


--
-- Name: watch_party_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.watch_party_id_seq', 1, false);


--
-- Name: brand brand_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brand
    ADD CONSTRAINT brand_pk PRIMARY KEY (id);


--
-- Name: chat_message chat_messages_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_messages_pk PRIMARY KEY (id);


--
-- Name: episode episode_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.episode
    ADD CONSTRAINT episode_pk PRIMARY KEY (id);


--
-- Name: genre genre_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pk PRIMARY KEY (id);


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
-- Name: series_genre series_genre_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series_genre
    ADD CONSTRAINT series_genre_pk PRIMARY KEY (id);


--
-- Name: series series_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pk PRIMARY KEY (id);


--
-- Name: user_continue user_continue_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_continue
    ADD CONSTRAINT user_continue_pk PRIMARY KEY (id);


--
-- Name: user_list user_list_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_list
    ADD CONSTRAINT user_list_pk PRIMARY KEY (id);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: watch_party watch_party_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.watch_party
    ADD CONSTRAINT watch_party_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

