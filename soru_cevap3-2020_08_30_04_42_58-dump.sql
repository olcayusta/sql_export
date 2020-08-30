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
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    content text,
    text text,
    "renderedText" text,
    "creationTime" timestamp with time zone DEFAULT now(),
    type integer,
    "roomId" integer,
    "userId" integer
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
-- Name: chat_room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_room (
    id integer NOT NULL,
    title text,
    description text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.chat_room OWNER TO postgres;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    "userId" integer,
    "receiverId" integer,
    text text,
    "creationTime" timestamp with time zone DEFAULT now(),
    type integer
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    id integer NOT NULL,
    title text,
    description text,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "viewCount" integer DEFAULT 0
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_answer (
    id integer NOT NULL,
    text text,
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "questionId" integer
);


ALTER TABLE public.question_answer OWNER TO postgres;

--
-- Name: question_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_answer_id_seq OWNER TO postgres;

--
-- Name: question_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_answer_id_seq OWNED BY public.question_answer.id;


--
-- Name: question_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_comment (
    id integer NOT NULL,
    "questionId" integer,
    text text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.question_comment OWNER TO postgres;

--
-- Name: question_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_comment_id_seq OWNER TO postgres;

--
-- Name: question_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_comment_id_seq OWNED BY public.question_comment.id;


--
-- Name: question_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_tag (
    id integer NOT NULL,
    "questionId" integer,
    "tagId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.question_tag OWNER TO postgres;

--
-- Name: question_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_tag_id_seq OWNER TO postgres;

--
-- Name: question_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_tag_id_seq OWNED BY public.question_tag.id;


--
-- Name: question_vote; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_vote (
    id integer NOT NULL,
    "questionId" integer,
    vote boolean,
    "userId" integer
);


ALTER TABLE public.question_vote OWNER TO postgres;

--
-- Name: question_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_vote_id_seq OWNER TO postgres;

--
-- Name: question_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_vote_id_seq OWNED BY public.question_vote.id;


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.question.id;


--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO postgres;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.chat_room.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    title text,
    "creationTime" timestamp with time zone DEFAULT now(),
    description text
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO postgres;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email text,
    password integer,
    "displayName" text,
    "avatarUrl" text,
    "signupTime" timestamp with time zone DEFAULT now(),
    "passwordSalt" text,
    "passwordHash" text
);


ALTER TABLE public."user" OWNER TO postgres;

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

ALTER SEQUENCE public.users_id_seq OWNED BY public."user".id;


--
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_message_id_seq'::regclass);


--
-- Name: chat_room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: question_answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer ALTER COLUMN id SET DEFAULT nextval('public.question_answer_id_seq'::regclass);


--
-- Name: question_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment ALTER COLUMN id SET DEFAULT nextval('public.question_comment_id_seq'::regclass);


--
-- Name: question_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag ALTER COLUMN id SET DEFAULT nextval('public.question_tag_id_seq'::regclass);


--
-- Name: question_vote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_vote ALTER COLUMN id SET DEFAULT nextval('public.question_vote_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, content, text, "renderedText", "creationTime", type, "roomId", "userId") FROM stdin;
\.


--
-- Data for Name: chat_room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_room (id, title, description, "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, "userId", "receiverId", text, "creationTime", type) FROM stdin;
1	2	1	\N	2020-03-31 05:17:15.703535+03	1
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, title, description, "userId", "creationTime", "viewCount") FROM stdin;
1	Now’s the Time to Chop Off Your Hair	It started with getting over a fear of my own forehead, which dates back to summer 2012. I remember I was sitting on a hill at camp when someone first asked me what I looked like without my dramatic side part. (Which I adopted after a friend cautioned that the high school scene kids might write me off as the girl with the “fucking middle part.”) It took some convincing, but eventually, I caved. I bared my forehead, and a friend of mine literally screamed. \r\n\r\nI’ve since lost touch with them; so, too, my forehead fear. Three years ago, I even said goodbye to my other go-to form of forehead coverage: bangs. I now part my hair less dramatically to the side—at least, I did until last week. Six days into social distancing, it occurred to me that while I’m working from home, I should do my hair a favor and stop straightening it. And then came what seemed, at the time, like a logical next step: Why not just chop it all off? \r\n\r\nThe more I thought about it, the more it made sense. In the time of self-isolation, who would even be there to judge? \r\n\r\nLess than an hour after the idea popped into my head, I picked up a pair of scissors. The more I cut, the more elated I felt. Suddenly, I was Keira Knightley in Bend It Like Beckham. A few snips later, I was Shane in The L Word. (Nowhere near as hot, of course,) Then came Agyness Deyn in her supermodel heyday, and Ruby Rose, circa Orange Is the New Black. I felt like I was sprinting through the lesbian pop culture canon—or years’ worth of Kristen Stewart and Justin Bieber’s various permutations—in a matter of minutes. 	1	2020-03-31 02:54:14.356115+03	0
3	Pamela Adlon Has the Recipe for Staying Sane During a Pandemic	aa	3	2020-03-31 03:57:25.579948+03	5
4	Rihanna Has Secretly Been Living Part-Time in Mexico	Rihanna, who semi-emerged from musical retirement with a PARTYNEXTDOOR single last week, has given her loyal fans an official update on what the next few months of her life will look like, and where she's been when she's not in a London studio.	4	2020-03-31 05:02:45.671642+03	13
2	Belgian Shoes Enters a New Era	\N	2	2020-03-31 03:41:50.87616+03	13
\.


--
-- Data for Name: question_answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_answer (id, text, "userId", "creationTime", "questionId") FROM stdin;
\.


--
-- Data for Name: question_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_comment (id, "questionId", text, "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: question_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_tag (id, "questionId", "tagId", "creationTime") FROM stdin;
1	1	1	2020-03-31 03:01:16.02684+03
2	2	2	2020-03-31 03:45:46.968611+03
3	3	1	2020-03-31 04:56:43.509547+03
4	4	3	2020-03-31 05:02:50.867368+03
\.


--
-- Data for Name: question_vote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_vote (id, "questionId", vote, "userId") FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, title, "creationTime", description) FROM stdin;
1	ANGULAR	2020-03-31 02:49:00.836785+03	\N
2	HTML5	2020-03-31 03:46:03.157838+03	\N
3	CULTURE	2020-03-31 05:02:13.732837+03	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "displayName", "avatarUrl", "signupTime", "passwordSalt", "passwordHash") FROM stdin;
1	olcayusta02@gmail.com	123456	Olcay Usta	https://yt3.ggpht.com/a/AATXAJxRsIu7vUrJSfdIG5Dnwbr6gUKvEpliu-4Xxg=s288-c-k-c0xffffffff-no-rj-mo	2020-03-31 02:53:17.951136+03	\N	\N
2	ece@mail.com	123456	Ece Untitled	https://www.wmagazine.com/wp-content/uploads/2017/06/16/5943f52054eeae418243d8df_sam-mcknight-hair-1.jpg?crop=0px,93px,2795px,2795px&w=533px	2020-03-31 03:42:22.810053+03	\N	\N
4	rihanna@mail.com	123456	Rihanna Untitled	https://lh3.googleusercontent.com/a-/AOh14GjLNDp0_qd6-QiVBZqlrz0JAySMB41MXgIRrt691w=s176-c-k-c0x00ffffff-no-rj-mo	2020-03-31 05:03:14.372405+03	\N	\N
3	lipa@mail.com	123456	Jale Untitled	https://lh3.googleusercontent.com/a-/AOh14Gj7yDbTC6KWmgZ-BxLGkmSIX_BDKI-t8rdFlnlhWA=s176-c-k-c0x00ffffff-no-rj-mo	2020-03-31 03:42:22.810053+03	\N	\N
15	shawn@mail.com	123456	Shawn	https://lh3.googleusercontent.com/a-/AOh14GjHJuOMLypojQDTJ8qtUEBox5MDea5he1BcKcjC-g=s176-c-k-c0x00ffffff-no-rj-mo	2020-03-31 22:30:16.272616+03	f364e241099e61aa15228347782fb215	b4dd2e985b69ac58eea379280b187834d47314296013af3c6228b0c15921c3c030887762b0472dbe9bd6de10c06eadda7263333cfbe3a5aaa747767ab4156072
\.


--
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 1, false);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 1, true);


--
-- Name: question_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_answer_id_seq', 1, false);


--
-- Name: question_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_comment_id_seq', 1, false);


--
-- Name: question_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_tag_id_seq', 4, true);


--
-- Name: question_vote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_vote_id_seq', 1, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 4, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 16, true);


--
-- Name: chat_message chat_message_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_pk PRIMARY KEY (id);


--
-- Name: notification notification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pk PRIMARY KEY (id);


--
-- Name: question_answer question_answer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer
    ADD CONSTRAINT question_answer_pk PRIMARY KEY (id);


--
-- Name: question_comment question_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment
    ADD CONSTRAINT question_comment_pk PRIMARY KEY (id);


--
-- Name: question_tag question_tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT question_tag_pk PRIMARY KEY (id);


--
-- Name: question_vote question_vote_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_vote
    ADD CONSTRAINT question_vote_pk PRIMARY KEY (id);


--
-- Name: question questions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT questions_pk PRIMARY KEY (id);


--
-- Name: chat_room rooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT rooms_pk PRIMARY KEY (id);


--
-- Name: tag tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (id);


--
-- Name: user users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

