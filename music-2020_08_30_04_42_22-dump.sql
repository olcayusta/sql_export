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

--
-- Name: fnc_check_fk_overhead(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fnc_check_fk_overhead(key_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  i INT;
BEGIN
  CREATE TABLE test_fk
  (
    id   BIGINT PRIMARY KEY,
    junk VARCHAR
  );

  INSERT INTO test_fk
  SELECT generate_series(1, 100000), repeat(' ', 20);

  CLUSTER test_fk_pkey ON test_fk;

  FOR i IN 1..key_count LOOP
    EXECUTE 'CREATE TABLE test_fk_ref_' || i ||
            ' (test_fk_id BIGINT REFERENCES test_fk (id))';
  END LOOP;

  FOR i IN 1..100000 LOOP
    UPDATE test_fk SET junk = '                    '
     WHERE id = i;
  END LOOP;

  DROP TABLE test_fk CASCADE;

  FOR i IN 1..key_count LOOP
    EXECUTE 'DROP TABLE test_fk_ref_' || i;
  END LOOP;

END;
$$;


ALTER FUNCTION public.fnc_check_fk_overhead(key_count integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: album_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album_artists (
    id integer NOT NULL,
    "artistId" integer NOT NULL,
    "albumId" integer NOT NULL
);


ALTER TABLE public.album_artists OWNER TO postgres;

--
-- Name: album_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.album_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.album_artists_id_seq OWNER TO postgres;

--
-- Name: album_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.album_artists_id_seq OWNED BY public.album_artists.id;


--
-- Name: albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.albums (
    id integer NOT NULL,
    title text,
    "releaseDate" timestamp with time zone DEFAULT now(),
    cover text,
    "artistId" integer,
    "albumType" integer,
    artists integer[]
);


ALTER TABLE public.albums OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;


--
-- Name: artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artists (
    id integer NOT NULL,
    "displayName" text,
    picture text,
    description text
);


ALTER TABLE public.artists OWNER TO postgres;

--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.artists_id_seq OWNER TO postgres;

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artists_id_seq OWNED BY public.artists.id;


--
-- Name: playlist_tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlist_tracks (
    id integer NOT NULL,
    "playlistId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.playlist_tracks OWNER TO postgres;

--
-- Name: playlist_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.playlist_tracks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlist_tracks_id_seq OWNER TO postgres;

--
-- Name: playlist_tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.playlist_tracks_id_seq OWNED BY public.playlist_tracks.id;


--
-- Name: playlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlists (
    id integer NOT NULL,
    title text,
    description text,
    picture text,
    private boolean DEFAULT false,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.playlists OWNER TO postgres;

--
-- Name: playlists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.playlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.playlists_id_seq OWNER TO postgres;

--
-- Name: playlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.playlists_id_seq OWNED BY public.playlists.id;


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracks (
    id integer NOT NULL,
    title text,
    length integer,
    artists integer[],
    "albumId" integer
);


ALTER TABLE public.tracks OWNER TO postgres;

--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracks_id_seq OWNER TO postgres;

--
-- Name: tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracks_id_seq OWNED BY public.tracks.id;


--
-- Name: user_albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_albums (
    id integer NOT NULL,
    "userId" integer,
    "albumId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_albums OWNER TO postgres;

--
-- Name: user_albums_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_albums_id_seq OWNER TO postgres;

--
-- Name: user_albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_albums_id_seq OWNED BY public.user_albums.id;


--
-- Name: user_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_artists (
    id integer NOT NULL,
    "userId" integer,
    "albumId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_artists OWNER TO postgres;

--
-- Name: user_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_artists_id_seq OWNER TO postgres;

--
-- Name: user_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_artists_id_seq OWNED BY public.user_artists.id;


--
-- Name: user_liked_tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_liked_tracks (
    id integer NOT NULL,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "trackId" integer
);


ALTER TABLE public.user_liked_tracks OWNER TO postgres;

--
-- Name: userr_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userr_favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userr_favorites_id_seq OWNER TO postgres;

--
-- Name: userr_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userr_favorites_id_seq OWNED BY public.user_liked_tracks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text,
    password text,
    "displayName" text,
    picture text,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: album_artists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_artists ALTER COLUMN id SET DEFAULT nextval('public.album_artists_id_seq'::regclass);


--
-- Name: albums id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);


--
-- Name: artists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists ALTER COLUMN id SET DEFAULT nextval('public.artists_id_seq'::regclass);


--
-- Name: playlist_tracks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks ALTER COLUMN id SET DEFAULT nextval('public.playlist_tracks_id_seq'::regclass);


--
-- Name: playlists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists ALTER COLUMN id SET DEFAULT nextval('public.playlists_id_seq'::regclass);


--
-- Name: tracks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracks ALTER COLUMN id SET DEFAULT nextval('public.tracks_id_seq'::regclass);


--
-- Name: user_albums id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_albums ALTER COLUMN id SET DEFAULT nextval('public.user_albums_id_seq'::regclass);


--
-- Name: user_artists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_artists ALTER COLUMN id SET DEFAULT nextval('public.user_artists_id_seq'::regclass);


--
-- Name: user_liked_tracks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_liked_tracks ALTER COLUMN id SET DEFAULT nextval('public.userr_favorites_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: album_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album_artists (id, "artistId", "albumId") FROM stdin;
6	1	1
7	20	2
8	21	3
9	21	4
10	22	5
11	15	5
12	15	6
\.


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.albums (id, title, "releaseDate", cover, "artistId", "albumType", artists) FROM stdin;
4	Skin	2020-01-06 22:23:42.100883+03	https://resources.tidal.com/images/d6bdb504/0912/4da9/afad/b05186bf28cc/1280x1280.jpg	21	0	{21}
2	hopeless fountain kingdom	2017-02-06 22:21:13.739+03	https://resources.tidal.com/images/984b12f8/f048/4514/bfa5/11c145b41909/1280x1280.jpg	20	0	{20}
3	Hi This Is Flume	2020-01-06 22:23:02.570222+03	https://resources.tidal.com/images/43bd842f/2ce9/4d64/ada8/ce4de6764eaa/1280x1280.jpg	21	0	{21}
1	LOVE AND COMPROMISE	2019-06-09 03:04:30.789+03	https://resources.tidal.com/images/c010a970/604a/44da/8ac3/8885e853fed8/1280x1280.jpg	1	0	{1}
5	JACKBOYS	2020-01-07 12:41:05.533438+03	https://resources.tidal.com/images/dfd1e915/79b9/48c2/8f23/6768cc59bdb2/1280x1280.jpg	22	0	{22,15}
6	TRAVI$ LA FLAME	2020-01-07 15:04:32.288145+03	https://resources.tidal.com/images/eed54238/aa4f/4f4c/b65b/919cc94c41bb/1280x1280.jpg	\N	0	\N
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artists (id, "displayName", picture, description) FROM stdin;
1	Mahalia	https://lh3.googleusercontent.com/3ED-EIzmg-nmqSzSHCT4yxTNEnjvfeXW29Uhzxo-JvrYsm9XdLEKE3N4aOBOVDjE3CryDrV5CXYrRBc=w512-h512-l90-rj	\N
2	Taylor Swift	https://resources.tidal.com/images/27ea60bc/cb1b/49a4/8d6c/a0876445d5f8/320x320.jpg	\N
3	Carly Rae Jepsen	https://resources.tidal.com/images/b9cbb995/c8f7/4b48/a0ac/3ced8461afe7/320x320.jpg	\N
4	Katty Perry	https://resources.tidal.com/images/0c1e2c95/3011/431b/b9d1/881a9e3e3102/320x320.jpg	\N
5	Mariah Carey	https://resources.tidal.com/images/c922f94a/6bc9/4190/97b1/c13358bd7a24/320x320.jpg	\N
6	Diana Ross	https://resources.tidal.com/images/c111dd1e/95c0/4012/b840/f0be8c75884b/320x320.jpg	\N
7	Post Malone	https://resources.tidal.com/images/d57a1856/b1b5/4060/85be/b26def493dbb/320x320.jpg	\N
8	Brenda Lee	https://resources.tidal.com/images/9129e334/a677/438e/b7e9/83c64ed2fd6b/320x320.jpg	\N
9	Lizzo	https://resources.tidal.com/images/5b8b055c/09cf/47de/a138/ced0e1ce4287/320x320.jpg	\N
10	DaBaby	https://resources.tidal.com/images/e57546d9/0a24/4c1c/a3de/9d318b617d94/320x320.jpg	\N
11	Selena Gomez	https://resources.tidal.com/images/ca49dcd1/49b5/4d3f/bcab/26f80c9a0b86/320x320.jpg	\N
12	Camila Cabello	https://resources.tidal.com/images/f8ae9fd4/ec28/4e78/bc50/e405ab22b59d/320x320.jpg	\N
13	Tones and I	https://resources.tidal.com/images/63e7ddef/44fc/4c23/a950/10fe5ea4eace/320x320.jpg	\N
14	Billie Ellish	https://resources.tidal.com/images/446f592f/e64f/40eb/bce0/d4aa25d4c7f3/320x320.jpg	\N
15	Travis Scott	https://resources.tidal.com/images/dd1108c6/0e9b/4ee5/add4/b2fabc15ea4c/320x320.jpg	\N
16	Lil Tecca	https://resources.tidal.com/images/58dc8bce/21bd/49bf/b667/8cf4ea163193/320x320.jpg	\N
17	Young Thug	https://resources.tidal.com/images/74556caa/1158/4540/8923/87875a934c3e/320x320.jpg	\N
18	Dua Lipa	https://resources.tidal.com/images/7b3cba4c/475d/4ef7/b98e/c0f83b486528/320x320.jpg	\N
19	Ed Sheeran	https://resources.tidal.com/images/05d72ae4/319f/4237/821f/1d7af9ec8acf/320x320.jpg	\N
20	Halsey	https://resources.tidal.com/images/4cca8b88/f70c/43c0/8715/8b632a848c1c/320x320.jpg	\N
21	Flume	https://resources.tidal.com/images/23c113da/124e/4781/b2b0/f078f2784f34/320x320.jpg	\N
22	JACKBOYS	https://resources.tidal.com/images/65887ae2/e7b2/436f/8a04/ab7726e950b1/320x320.jpg	\N
\.


--
-- Data for Name: playlist_tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlist_tracks (id, "playlistId", "creationTime") FROM stdin;
\.


--
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlists (id, title, description, picture, private, "userId", "creationTime") FROM stdin;
1	90'lar	90'li yillari yad etmek.	\N	f	1	2020-01-04 19:32:37.170167+03
2	2000'ler	2000li yillarin sarkilari karisik toplama.	\N	f	1	2020-01-04 19:47:52.490968+03
3	Bla bla	bla bla calma listesi	\N	f	1	2020-01-05 13:35:21.088378+03
7	\N	\N	\N	f	\N	2020-08-22 19:49:51.605679+03
\.


--
-- Data for Name: tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracks (id, title, length, artists, "albumId") FROM stdin;
\.


--
-- Data for Name: user_albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_albums (id, "userId", "albumId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_artists (id, "userId", "albumId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user_liked_tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_liked_tracks (id, "userId", "creationTime", "trackId") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, "displayName", picture, "creationTime") FROM stdin;
1	olcay@mail.com	123456	Olcay Usta	https://i.pinimg.com/236x/48/b0/69/48b0698deea748d01a620d653e55b738.jpg	2020-01-04 19:38:05.271171+03
\.


--
-- Name: album_artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.album_artists_id_seq', 13, true);


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.albums_id_seq', 6, true);


--
-- Name: artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artists_id_seq', 22, true);


--
-- Name: playlist_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.playlist_tracks_id_seq', 1, false);


--
-- Name: playlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.playlists_id_seq', 7, true);


--
-- Name: tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracks_id_seq', 1, false);


--
-- Name: user_albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_albums_id_seq', 1, false);


--
-- Name: user_artists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_artists_id_seq', 1, false);


--
-- Name: userr_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userr_favorites_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: album_artists album_artists_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_artists
    ADD CONSTRAINT album_artists_pk PRIMARY KEY (id);


--
-- Name: albums albums_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pk PRIMARY KEY (id);


--
-- Name: artists artists_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pk PRIMARY KEY (id);


--
-- Name: playlist_tracks playlist_tracks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT playlist_tracks_pk PRIMARY KEY (id);


--
-- Name: playlists playlists_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pk PRIMARY KEY (id);


--
-- Name: tracks tracks_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT tracks_pk PRIMARY KEY (id);


--
-- Name: user_albums user_albums_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_albums
    ADD CONSTRAINT user_albums_pk PRIMARY KEY (id);


--
-- Name: user_artists user_artists_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_artists
    ADD CONSTRAINT user_artists_pk PRIMARY KEY (id);


--
-- Name: user_liked_tracks userr_favorites_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_liked_tracks
    ADD CONSTRAINT userr_favorites_pk PRIMARY KEY (id);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: album_artists album_artists_albums_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_artists
    ADD CONSTRAINT album_artists_albums_id_fk FOREIGN KEY ("albumId") REFERENCES public.albums(id);


--
-- Name: album_artists album_artists_artists_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_artists
    ADD CONSTRAINT album_artists_artists_id_fk FOREIGN KEY ("artistId") REFERENCES public.artists(id);


--
-- Name: playlist_tracks playlist_tracks_playlists_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT playlist_tracks_playlists_id_fk FOREIGN KEY ("playlistId") REFERENCES public.playlists(id);


--
-- Name: user_albums user_albums_albums_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_albums
    ADD CONSTRAINT user_albums_albums_id_fk FOREIGN KEY ("albumId") REFERENCES public.albums(id);


--
-- Name: user_albums user_albums_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_albums
    ADD CONSTRAINT user_albums_users_id_fk FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: user_artists user_artists_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_artists
    ADD CONSTRAINT user_artists_users_id_fk FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: user_liked_tracks user_liked_tracks_tracks_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_liked_tracks
    ADD CONSTRAINT user_liked_tracks_tracks_id_fk FOREIGN KEY ("trackId") REFERENCES public.tracks(id);


--
-- PostgreSQL database dump complete
--

