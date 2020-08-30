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
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    title character varying(364),
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "viewCount" integer DEFAULT 0,
    tags integer[],
    "acceptedAnswerID" integer,
    "acceptedAnswerTime" timestamp with time zone,
    "modifiedDate" timestamp with time zone
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: fx(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fx(integer) RETURNS SETOF public.questions
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN QUERY SELECT a.id, a."creationTime", jsonb_build_object('id', q.id, 'title', q.title) AS "question"
FROM questions q,
     LATERAL ( SELECT * FROM answers a
     WHERE a."questionId" = q.id AND a."userId" = $1
     ORDER BY id DESC LIMIT 1) a;
END
$_$;


ALTER FUNCTION public.fx(integer) OWNER TO postgres;

--
-- Name: get_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_user(_id integer) RETURNS TABLE(id integer, "displayName" character varying, "pictureUrl" character varying)
    LANGUAGE plpgsql STABLE ROWS 1
    AS $_$
    BEGIN
    RETURN QUERY EXECUTE' SELECT u.id, u."displayName", u."pictureUrl" FROM "user" u WHERE u.id = $1;' USING $1;
    END
$_$;


ALTER FUNCTION public.get_user(_id integer) OWNER TO postgres;

--
-- Name: AnswerComments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AnswerComments" (
    id integer NOT NULL,
    text text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "answerId" integer
);


ALTER TABLE public."AnswerComments" OWNER TO postgres;

--
-- Name: AnswerComments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AnswerComments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AnswerComments_id_seq" OWNER TO postgres;

--
-- Name: AnswerComments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AnswerComments_id_seq" OWNED BY public."AnswerComments".id;


--
-- Name: AnswerVotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AnswerVotes" (
    id integer NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "answerId" integer,
    vote integer
);


ALTER TABLE public."AnswerVotes" OWNER TO postgres;

--
-- Name: AnswerVotes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."AnswerVotes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."AnswerVotes_id_seq" OWNER TO postgres;

--
-- Name: AnswerVotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."AnswerVotes_id_seq" OWNED BY public."AnswerVotes".id;


--
-- Name: PostTypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostTypes" (
    id integer NOT NULL,
    title text
);


ALTER TABLE public."PostTypes" OWNER TO postgres;

--
-- Name: PostTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PostTypes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PostTypes_id_seq" OWNER TO postgres;

--
-- Name: PostTypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PostTypes_id_seq" OWNED BY public."PostTypes".id;


--
-- Name: Posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Posts" (
    id integer NOT NULL,
    text text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    data jsonb,
    "parentId" integer
);


ALTER TABLE public."Posts" OWNER TO postgres;

--
-- Name: Posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Posts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Posts_id_seq" OWNER TO postgres;

--
-- Name: Posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Posts_id_seq" OWNED BY public."Posts".id;


--
-- Name: QuestionComments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionComments" (
    id integer NOT NULL,
    text text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "questionId" integer
);


ALTER TABLE public."QuestionComments" OWNER TO postgres;

--
-- Name: QuestionComments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuestionComments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."QuestionComments_id_seq" OWNER TO postgres;

--
-- Name: QuestionComments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuestionComments_id_seq" OWNED BY public."QuestionComments".id;


--
-- Name: QuestionTag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionTag" (
    "questionId" integer,
    "tagId" integer
);


ALTER TABLE public."QuestionTag" OWNER TO postgres;

--
-- Name: QuestionTags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionTags" (
    id integer NOT NULL,
    "questionId" integer,
    "tagId" integer
);


ALTER TABLE public."QuestionTags" OWNER TO postgres;

--
-- Name: QuestionVotes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuestionVotes" (
    id integer NOT NULL,
    "voteType" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "questionId" integer
);


ALTER TABLE public."QuestionVotes" OWNER TO postgres;

--
-- Name: QuestionVotes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."QuestionVotes_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."QuestionVotes_id_seq" OWNER TO postgres;

--
-- Name: QuestionVotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."QuestionVotes_id_seq" OWNED BY public."QuestionVotes".id;


--
-- Name: UserFavoriteQuestions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserFavoriteQuestions" (
    id integer NOT NULL,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "questionId" integer
);


ALTER TABLE public."UserFavoriteQuestions" OWNER TO postgres;

--
-- Name: Votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Votes" (
    id integer NOT NULL,
    "voteType" integer,
    "creationTime" timestamp without time zone DEFAULT now(),
    "userId" integer,
    "postTypeId" integer,
    "postId" integer
);


ALTER TABLE public."Votes" OWNER TO postgres;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    text text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "questionId" integer,
    "userId" integer,
    data jsonb,
    "upVotes" integer[],
    "downVotes" integer[]
);


ALTER TABLE public.answers OWNER TO postgres;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    title character varying(128),
    description character varying(512),
    "parentId" integer DEFAULT 0
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    "displayName" character varying(128),
    "pictureUrl" character varying(512),
    email character varying(96),
    password character varying(64),
    "firstName" character varying(96),
    "lastName" character varying(96),
    "aboutMe" text,
    "creationTime" timestamp with time zone DEFAULT now(),
    birthday date DEFAULT CURRENT_DATE,
    "lastSeen" timestamp with time zone
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: all_questions; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.all_questions AS
 SELECT q.id,
    q.title,
    q."creationTime",
    q."acceptedAnswerID",
    q."acceptedAnswerTime",
    q."modifiedDate",
    ( SELECT jsonb_agg(jsonb_build_object('id', t.id, 'title', t.title)) AS tags
           FROM public.tag t,
            unnest(q.tags) tagid(tagid)
          WHERE (tagid.tagid = t.id)) AS tags,
    jsonb_build_object('id', u.id, 'displayName', u."displayName", 'pictureUrl', u."pictureUrl") AS "user",
    ( SELECT ( SELECT jsonb_build_object('id', u_1.id, 'displayName', u_1."displayName", 'pictureUrl', u_1."pictureUrl") AS jsonb_build_object
                   FROM public."user" u_1
                  WHERE (u_1.id = a."userId")) AS jsonb_build_object
           FROM public.answers a
          WHERE (a.id = q."acceptedAnswerID")) AS accepted_user
   FROM (public.questions q
     LEFT JOIN public."user" u ON ((u.id = q."userId")))
  ORDER BY q.id DESC;


ALTER TABLE public.all_questions OWNER TO postgres;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO postgres;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.articles OWNER TO postgres;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    text text,
    "renderedText" text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "postId" integer,
    "postTypeId" integer
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO postgres;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public."UserFavoriteQuestions".id;


--
-- Name: flags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flags (
    id integer NOT NULL,
    "flagTypeId" integer,
    "creationTime" timestamp without time zone DEFAULT now(),
    "userId" integer,
    "postId" integer,
    "voteTypeId" integer
);


ALTER TABLE public.flags OWNER TO postgres;

--
-- Name: flags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flags_id_seq OWNER TO postgres;

--
-- Name: flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flags_id_seq OWNED BY public.flags.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    text text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "roomId" integer,
    type integer DEFAULT 0,
    content text
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: messages_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages_types (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.messages_types OWNER TO postgres;

--
-- Name: messages_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_types_id_seq OWNER TO postgres;

--
-- Name: messages_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_types_id_seq OWNED BY public.messages_types.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    "userId" integer,
    "receiverId" integer,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "isRead" boolean
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notification.id;


--
-- Name: push_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.push_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_id_seq OWNER TO postgres;

--
-- Name: push_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.push_id_seq OWNED BY public.articles.id;


--
-- Name: question_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_tags_id_seq OWNER TO postgres;

--
-- Name: question_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_tags_id_seq OWNED BY public."QuestionTags".id;


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

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revisions (
    id integer NOT NULL,
    "postTypeId" integer,
    "postId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    data jsonb
);


ALTER TABLE public.revisions OWNER TO postgres;

--
-- Name: revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.revisions_id_seq OWNER TO postgres;

--
-- Name: revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.revisions_id_seq OWNED BY public.revisions.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rooms (
    id smallint NOT NULL,
    title character varying(128),
    description text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.rooms OWNER TO postgres;

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

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: suggested_edits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suggested_edits (
    id integer NOT NULL,
    "postId" integer,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    data jsonb,
    summary text
);


ALTER TABLE public.suggested_edits OWNER TO postgres;

--
-- Name: suggested_edits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suggested_edits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suggested_edits_id_seq OWNER TO postgres;

--
-- Name: suggested_edits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suggested_edits_id_seq OWNED BY public.suggested_edits.id;


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tag.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    id integer NOT NULL,
    title character varying(128),
    "userId" integer,
    "creationTime" timestamp with time zone DEFAULT now()
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.team.id;


--
-- Name: user_logins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_logins (
    id integer NOT NULL,
    ip cidr,
    "userAgent" jsonb,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.user_logins OWNER TO postgres;

--
-- Name: user_logins_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_logins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_logins_id_seq OWNER TO postgres;

--
-- Name: user_logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_logins_id_seq OWNED BY public.user_logins.id;


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
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votes_id_seq OWNER TO postgres;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public."Votes".id;


--
-- Name: AnswerComments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerComments" ALTER COLUMN id SET DEFAULT nextval('public."AnswerComments_id_seq"'::regclass);


--
-- Name: AnswerVotes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerVotes" ALTER COLUMN id SET DEFAULT nextval('public."AnswerVotes_id_seq"'::regclass);


--
-- Name: PostTypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostTypes" ALTER COLUMN id SET DEFAULT nextval('public."PostTypes_id_seq"'::regclass);


--
-- Name: Posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posts" ALTER COLUMN id SET DEFAULT nextval('public."Posts_id_seq"'::regclass);


--
-- Name: QuestionComments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionComments" ALTER COLUMN id SET DEFAULT nextval('public."QuestionComments_id_seq"'::regclass);


--
-- Name: QuestionTags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTags" ALTER COLUMN id SET DEFAULT nextval('public.question_tags_id_seq'::regclass);


--
-- Name: QuestionVotes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionVotes" ALTER COLUMN id SET DEFAULT nextval('public."QuestionVotes_id_seq"'::regclass);


--
-- Name: UserFavoriteQuestions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserFavoriteQuestions" ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: Votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Votes" ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.push_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: flags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flags ALTER COLUMN id SET DEFAULT nextval('public.flags_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: messages_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_types ALTER COLUMN id SET DEFAULT nextval('public.messages_types_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions ALTER COLUMN id SET DEFAULT nextval('public.revisions_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: suggested_edits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suggested_edits ALTER COLUMN id SET DEFAULT nextval('public.suggested_edits_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: user_logins id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_logins ALTER COLUMN id SET DEFAULT nextval('public.user_logins_id_seq'::regclass);


--
-- Data for Name: AnswerComments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AnswerComments" (id, text, content, "creationTime", "userId", "answerId") FROM stdin;
46	Bu cevaba ithafen yazilmistir.	Bu cevaba ithafen yazilmistir.	2019-08-23 15:36:37.049815+03	9	80
47	Please, please, please note that doing this on massive images will result in long download times for pages that shouldn't have long download times. It's always better to actually resize the image if possible.	Please, please, please note that doing this on massive images will result in long download times for pages that shouldn&#39;t have long download times. It&#39;s always better to actually resize the image if possible.	2019-08-23 15:55:03.863313+03	9	29
48	Haha :D	Haha :D	2019-08-23 16:11:26.134353+03	9	45
51	Bu bir yurumdur, derler. 😎	Bu bir yurumdur, derler. 😎	2019-08-23 22:54:44.162022+03	5	44
52	Yorum denemeleri.	Yorum denemeleri.	2019-08-26 02:29:30.433771+03	5	44
53	JENNIFER ANISTON	JENNIFER ANISTON	2019-08-26 02:29:41.60366+03	5	44
55	Daha iyi bir cevap olabilirdi...	Daha iyi bir cevap olabilirdi...	2019-08-27 02:24:24.826102+03	5	137
56	Kurkayrum :D	Kurkayrum :D	2019-08-29 04:47:17.783592+03	1	137
\.


--
-- Data for Name: AnswerVotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AnswerVotes" (id, "creationTime", "userId", "answerId", vote) FROM stdin;
\.


--
-- Data for Name: PostTypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostTypes" (id, title) FROM stdin;
1	Question
2	Answer
\.


--
-- Data for Name: Posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Posts" (id, text, content, "creationTime", "userId", data, "parentId") FROM stdin;
\.


--
-- Data for Name: QuestionComments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionComments" (id, text, content, "creationTime", "userId", "questionId") FROM stdin;
1	Hola hola 🎃	Hola hola 🎃	2019-08-15 03:40:11.746326+03	4	45
2	Bu boyle bir yorumdur iste...	Bu boyle bir yorumdur iste...	2019-08-15 20:30:11.784583+03	1	56
3	🎈🎈 Hayirli ugurlu olsun, yeni platform.	🎈🎈 Hayirli ugurlu olsun, yeni platform.	2019-08-15 20:31:06.550015+03	1	56
7	Keep in mind that its not recommended to send huge images and make them small with css. It's better to have different versions of the same image to save bandwidth and to make the page more responsive (even if the image will look small, the full image will be sent).	Keep in mind that its not recommended to send huge images and make them small with css. It&#39;s better to have different versions of the same image to save bandwidth and to make the page more responsive (even if the image will look small, the full image will be sent).	2019-08-23 14:39:16.546664+03	10	71
8	rwallace, are you using .net or PHP or something other than pure HTML?	rwallace, are you using .net or PHP or something other than pure HTML?	2019-08-23 14:44:37.578167+03	5	71
9	Pissik	Pissik	2019-08-26 17:10:11.186689+03	5	45
10	xd	xd	2019-08-27 02:22:07.652451+03	5	74
11	Bu baska bir yorumdur....	Bu baska bir yorumdur....	2019-08-27 02:22:19.445375+03	5	74
12	# Hello world	# Hello world	2019-08-27 02:23:14.221813+03	5	74
\.


--
-- Data for Name: QuestionTag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionTag" ("questionId", "tagId") FROM stdin;
42	1
42	2
42	3
38	2
\.


--
-- Data for Name: QuestionTags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionTags" (id, "questionId", "tagId") FROM stdin;
1	39	1
2	28	10
3	28	12
4	39	10
8	8	1
9	8	24
10	66	1
11	66	24
12	67	5
13	67	27
14	68	15
15	69	1
16	70	1
17	71	26
18	72	26
19	72	3
20	73	26
21	73	3
22	74	5
23	74	23
24	75	1
25	76	1
26	77	5
27	77	10
28	78	10
29	78	28
30	79	5
31	79	23
\.


--
-- Data for Name: QuestionVotes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."QuestionVotes" (id, "voteType", "creationTime", "userId", "questionId") FROM stdin;
\.


--
-- Data for Name: UserFavoriteQuestions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserFavoriteQuestions" (id, "creationTime", "userId", "questionId") FROM stdin;
1	2019-08-22 16:26:21.451174+03	6	68
2	2019-08-22 16:31:51.037974+03	6	46
3	2019-08-22 16:32:03.318654+03	6	31
4	2019-08-23 14:23:22.00452+03	1	48
5	2019-08-27 11:37:13.91683+03	5	68
6	2019-08-27 12:01:26.276491+03	5	72
7	2019-08-27 18:06:42.066784+03	5	75
8	2019-08-29 14:10:15.615583+03	1	53
9	2019-08-29 20:22:33.254938+03	1	75
10	2019-08-30 04:01:11.877714+03	8	75
\.


--
-- Data for Name: Votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Votes" (id, "voteType", "creationTime", "userId", "postTypeId", "postId") FROM stdin;
1	1	2019-02-18 22:42:39.078538	1	1	5
\.


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answers (id, text, content, "creationTime", "questionId", "userId", data, "upVotes", "downVotes") FROM stdin;
25	After installing socket.io-client:\n\n    npm install socket.io-client\n\nThis is how the client code looks like:\n\n    var io = require('socket.io-client'),\n    socket = io.connect('localhost', {\n        port: 1337\n    });\n    socket.on('connect', function () { console.log("socket connected"); });\n    socket.emit('private message', { user: 'me', msg: 'whazzzup?' });\n\nThanks [alessioalex][1].\n\n\n  [1]: https://stackoverflow.com/users/617839/alessioalex	<p>After installing socket.io-client:</p>\n<pre><code>npm install socket.io-client</code></pre><p>This is how the client code looks like:</p>\n<pre><code>var io = require(&#39;socket.io-client&#39;),\nsocket = io.connect(&#39;localhost&#39;, {\n    port: 1337\n});\nsocket.on(&#39;connect&#39;, function () { console.log(&quot;socket connected&quot;); });\nsocket.emit(&#39;private message&#39;, { user: &#39;me&#39;, msg: &#39;whazzzup?&#39; });</code></pre><p>Thanks <a href="https://stackoverflow.com/users/617839/alessioalex">alessioalex</a>.</p>\n	2019-03-13 20:43:37.370558+03	28	5	\N	\N	\N
26	As long as the version of the client you are using is the same as what you use on your server, there should not be any problem serving it from a CDN.\n\nThat said, the client is tiny (24kb), and if caching is setup properly, this should have very little impact on your server.\n\nupdate: as mentioned by @maxwell2022, socket.io has its own cdn starting with 1.0.0, so you can use:\n\n    <script src="https://cdn.socket.io/socket.io-1.0.0.js"></script>\n	<p>As long as the version of the client you are using is the same as what you use on your server, there should not be any problem serving it from a CDN.</p>\n<p>That said, the client is tiny (24kb), and if caching is setup properly, this should have very little impact on your server.</p>\n<p>update: as mentioned by @maxwell2022, socket.io has its own cdn starting with 1.0.0, so you can use:</p>\n<pre><code>&lt;script src=&quot;https://cdn.socket.io/socket.io-1.0.0.js&quot;&gt;&lt;/script&gt;</code></pre>	2019-03-13 20:51:55.407304+03	29	7	\N	\N	\N
23	That should be possible using Socket.IO-client: https://github.com/LearnBoost/socket.io-client	<p>That should be possible using Socket.IO-client: <a href="https://github.com/LearnBoost/socket.io-client">https://github.com/LearnBoost/socket.io-client</a></p>\n	2019-03-13 20:42:01.006898+03	28	6	\N	\N	\N
27	You can find [here](http://cdnjs.com/libraries/socket.io/) CDN links to the socket.io client script files.\n\n## 0.9.16\n\n    //cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min.js\n\n## 0.9.6\n    \n    //cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.6/socket.io.min.js\n\n...and so on.\n	<p>You can find <a href="http://cdnjs.com/libraries/socket.io/">here</a> CDN links to the socket.io client script files.</p>\n<h2 id="0916">0.9.16</h2>\n<pre><code>//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.16/socket.io.min.js</code></pre><h2 id="096">0.9.6</h2>\n<pre><code>//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.6/socket.io.min.js</code></pre><p>...and so on.</p>\n	2019-03-13 20:52:11.245065+03	29	1	\N	\N	\N
28	According to [the wiki][1], if you choose to serve the client yourself, you can clone the [socket.io-client][2] repository and look at the `dist/` subdirectory. There are 4 files to serve (this may change):\n\n - `WebSocketMain.swf`\n - `WebSocketMainInsecure.swf`\n - `socket.io.js`\n - `socket.io.min.js`\n\nJust make sure you update these files whenever you update the server.\n\n\n  [1]: http://github.com/LearnBoost/Socket.IO/wiki/How-do-I-serve-the-client\n  [2]: https://github.com/LearnBoost/socket.io-client	<p>According to <a href="http://github.com/LearnBoost/Socket.IO/wiki/How-do-I-serve-the-client">the wiki</a>, if you choose to serve the client yourself, you can clone the <a href="https://github.com/LearnBoost/socket.io-client">socket.io-client</a> repository and look at the <code>dist/</code> subdirectory. There are 4 files to serve (this may change):</p>\n<ul>\n<li><code>WebSocketMain.swf</code></li>\n<li><code>WebSocketMainInsecure.swf</code></li>\n<li><code>socket.io.js</code></li>\n<li><code>socket.io.min.js</code></li>\n</ul>\n<p>Just make sure you update these files whenever you update the server.</p>\n	2019-03-13 20:52:55.85818+03	29	2	\N	\N	\N
29	You can add an event listener with 'ended' as first param\n\nLike this :\n\n    <video src="video.ogv" id="myVideo">\n      video not supported\n    </video>\n\n    <script type='text/javascript'>\n        document.getElementById('myVideo').addEventListener('ended',myHandler,false);\n        function myHandler(e) {\n            // What you want to do after the event\n        }\n    </script>	<p>You can add an event listener with &#39;ended&#39; as first param</p>\n<p>Like this :</p>\n<pre><code>&lt;video src=&quot;video.ogv&quot; id=&quot;myVideo&quot;&gt;\n  video not supported\n&lt;/video&gt;\n\n&lt;script type=&#39;text/javascript&#39;&gt;\n    document.getElementById(&#39;myVideo&#39;).addEventListener(&#39;ended&#39;,myHandler,false);\n    function myHandler(e) {\n        // What you want to do after the event\n    }\n&lt;/script&gt;</code></pre>	2019-03-14 21:52:27.072274+03	31	5	\N	\N	\N
31	# Hello, hola!	<h1 id="hello-hola">Hello, hola!</h1>\n	2019-06-17 01:03:50.168201+03	32	5	\N	\N	\N
138	 **WARNING:** This answer has merely been provided as a possible solution; it is obviously *not* the best solution, as it requires jQuery. Instead, prefer the pure JavaScript solution.\n\n<!-- language: lang-js -->\n\n    $(location).attr('href', 'http://stackoverflow.com')\n	<p> <strong>WARNING:</strong> This answer has merely been provided as a possible solution; it is obviously <em>not</em> the best solution, as it requires jQuery. Instead, prefer the pure JavaScript solution.</p>\n<!-- language: lang-js -->\n\n<pre><code>$(location).attr(&#39;href&#39;, &#39;http://stackoverflow.com&#39;)</code></pre>	2019-08-26 18:03:53.160468+03	74	10	\N	\N	\N
141	You can do that without jQuery as:\n\n    window.location = "http://yourdomain.com";\n\nAnd if you want only jQuery then you can do it like:\n\n    $jq(window).attr("location","http://yourdomain.com");\n	<p>You can do that without jQuery as:</p>\n<pre><code>window.location = &quot;http://yourdomain.com&quot;;</code></pre><p>And if you want only jQuery then you can do it like:</p>\n<pre><code>$jq(window).attr(&quot;location&quot;,&quot;http://yourdomain.com&quot;);</code></pre>	2019-08-26 18:12:45.327855+03	74	4	\N	\N	\N
143	## WEBSOCKET TEST	<h2 id="websocket-test">WEBSOCKET TEST</h2>\n	2019-08-29 14:25:46.678619+03	76	2	\N	\N	\N
147	yes	<p>yes</p>\n	2019-08-29 14:37:12.668907+03	76	2	\N	\N	\N
151	calisti	<p>calisti</p>\n	2019-08-29 14:40:38.457438+03	76	2	\N	\N	\N
154	BRAD PITT	<p>BRAD PITT</p>\n	2019-08-29 14:45:26.42519+03	76	5	\N	\N	\N
159	HELLO WORLD	<p>HELLO WORLD</p>\n	2019-08-29 15:15:52.567546+03	76	5	\N	\N	\N
163	JASON STATHAM	<p>JASON STATHAM</p>\n	2019-08-29 15:45:32.65511+03	76	2	\N	\N	\N
32	It means that using the `bodyParser()` **constructor** has been [deprecated](https://github.com/expressjs/body-parser/commit/b7420f8dc5c8b17a277c9e50d72bbaf3086a3900),  as of 2014-06-19.\n\n    app.use(bodyParser()); //Now deprecated\n\nYou now need to call the methods separately\n\n    app.use(bodyParser.urlencoded());\n\n    app.use(bodyParser.json());\nAnd so on.\n\nIf you're still getting a warning with `urlencoded` you need to use\n\n    app.use(bodyParser.urlencoded({\n      extended: true\n    }));\n\nThe `extended` config object key now needs to be explicitly passed, since it now has no default value.\n\nIf you are using Express >= 4.16.0, body parser has been re-added under the methods `express.json()` and `express.urlencoded() `.	<p>It means that using the <code>bodyParser()</code> <strong>constructor</strong> has been <a href="https://github.com/expressjs/body-parser/commit/b7420f8dc5c8b17a277c9e50d72bbaf3086a3900">deprecated</a>,  as of 2014-06-19.</p>\n<pre><code>app.use(bodyParser()); //Now deprecated</code></pre><p>You now need to call the methods separately</p>\n<pre><code>app.use(bodyParser.urlencoded());\n\napp.use(bodyParser.json());</code></pre><p>And so on.</p>\n<p>If you&#39;re still getting a warning with <code>urlencoded</code> you need to use</p>\n<pre><code>app.use(bodyParser.urlencoded({\n  extended: true\n}));</code></pre><p>The <code>extended</code> config object key now needs to be explicitly passed, since it now has no default value.</p>\n<p>If you are using Express &gt;= 4.16.0, body parser has been re-added under the methods <code>express.json()</code> and <code>express.urlencoded()</code>.</p>\n	2019-07-23 16:06:24.456312+03	49	35	\N	\N	\N
33	Want **zero warnings**? Use it like this:\n\n    app.use(bodyParser.json());\n    app.use(bodyParser.urlencoded({\n      extended: true\n    }));\n\n**Explanation**: The default value of the `extended` option has been deprecated, meaning you need to explicitly pass true or false value.	<p>Want <strong>zero warnings</strong>? Use it like this:</p>\n<pre><code>app.use(bodyParser.json());\napp.use(bodyParser.urlencoded({\n  extended: true\n}));</code></pre><p><strong>Explanation</strong>: The default value of the <code>extended</code> option has been deprecated, meaning you need to explicitly pass true or false value.</p>\n	2019-07-23 18:40:41.49642+03	49	3	\N	\N	\N
34	In older versions of express, we had to use:\n\n    app.use(express.bodyparser()); \n\nbecause body-parser was a middleware between node and \nexpress. Now we have to use it like:\n\n    app.use(bodyParser.urlencoded({ extended: false }));\n    app.use(bodyParser.json());\n	<p>In older versions of express, we had to use:</p>\n<pre><code>app.use(express.bodyparser()); </code></pre><p>because body-parser was a middleware between node and \nexpress. Now we have to use it like:</p>\n<pre><code>app.use(bodyParser.urlencoded({ extended: false }));\napp.use(bodyParser.json());</code></pre>	2019-07-24 00:22:30.853904+03	49	39	\N	\N	\N
35	 > body-parser is a piece of express middleware that \n       reads a form's input and stores it as a javascript\n        object accessible through `req.body` \n      'body-parser' must be installed (via `npm install --save body-parser`) For more info see: https://github.com/expressjs/body-parser\n       \n       var bodyParser = require('body-parser');\n       app.use(bodyParser.json()); // support json encoded bodies\n       app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies\n\nWhen `extended` is set to true, then deflated (compressed) bodies will be inflated; when `extended` is set to false, deflated bodies are rejected. 	<blockquote>\n<p>body-parser is a piece of express middleware that \n       reads a form&#39;s input and stores it as a javascript\n        object accessible through <code>req.body</code> \n      &#39;body-parser&#39; must be installed (via <code>npm install --save body-parser</code>) For more info see: <a href="https://github.com/expressjs/body-parser">https://github.com/expressjs/body-parser</a></p>\n</blockquote>\n<pre><code>   var bodyParser = require(&#39;body-parser&#39;);\n   app.use(bodyParser.json()); // support json encoded bodies\n   app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies</code></pre><p>When <code>extended</code> is set to true, then deflated (compressed) bodies will be inflated; when <code>extended</code> is set to false, deflated bodies are rejected. </p>\n	2019-07-24 00:23:00.977314+03	49	8	\N	\N	\N
79	Only set the width or height, and it will scale the other automatically. And yes you can use a percentage.\n\nThe first part can be done, but requires JavaScript, so might not work for all users.	<p>Only set the width or height, and it will scale the other automatically. And yes you can use a percentage.</p>\n<p>The first part can be done, but requires JavaScript, so might not work for all users.</p>\n	2019-08-23 15:29:33.50206+03	71	9	\N	\N	\N
136	It would help if you were a little more descriptive in what you are trying to do.  If you are trying to generate paged data, there are some options in how you do this.  You can generate separate links for each page that you want to be able to get directly to.\n\n    <a href='/path-to-page?page=1' class='pager-link'>1</a>\n    <a href='/path-to-page?page=2' class='pager-link'>2</a>\n    <span class='pager-link current-page'>3</a>\n    ...\n\nNote that the current page in the example is handled differently in the code and with CSS.\n\nIf you want the paged data to be changed via AJAX, this is where jQuery would come in.  What you would do is add a click handler to each of the anchor tags corresponding to a different page.  This click handler would invoke some jQuery code that goes and fetches the next page via AJAX and updates the table with the new data.  The example below assumes that you have a web service that returns the new page data.\n\n\n    $(document).ready( function() {\n        $('a.pager-link').click( function() {\n            var page = $(this).attr('href').split(/\\?/)[1];\n            $.ajax({\n                type: 'POST',\n                url: '/path-to-service',\n                data: page,\n                success: function(content) {\n                   $('#myTable').html(content);  // replace\n                }\n            });\n            return false; // to stop link\n        });\n    });	<p>It would help if you were a little more descriptive in what you are trying to do.  If you are trying to generate paged data, there are some options in how you do this.  You can generate separate links for each page that you want to be able to get directly to.</p>\n<pre><code>&lt;a href=&#39;/path-to-page?page=1&#39; class=&#39;pager-link&#39;&gt;1&lt;/a&gt;\n&lt;a href=&#39;/path-to-page?page=2&#39; class=&#39;pager-link&#39;&gt;2&lt;/a&gt;\n&lt;span class=&#39;pager-link current-page&#39;&gt;3&lt;/a&gt;\n...</code></pre><p>Note that the current page in the example is handled differently in the code and with CSS.</p>\n<p>If you want the paged data to be changed via AJAX, this is where jQuery would come in.  What you would do is add a click handler to each of the anchor tags corresponding to a different page.  This click handler would invoke some jQuery code that goes and fetches the next page via AJAX and updates the table with the new data.  The example below assumes that you have a web service that returns the new page data.</p>\n<pre><code>$(document).ready( function() {\n    $(&#39;a.pager-link&#39;).click( function() {\n        var page = $(this).attr(&#39;href&#39;).split(/\\?/)[1];\n        $.ajax({\n            type: &#39;POST&#39;,\n            url: &#39;/path-to-service&#39;,\n            data: page,\n            success: function(content) {\n               $(&#39;#myTable&#39;).html(content);  // replace\n            }\n        });\n        return false; // to stop link\n    });\n});</code></pre>	2019-08-26 17:36:38.074349+03	74	2	\N	\N	\N
139	This works for every browser:\n\n    window.location.href = 'your_url';\n\n\n	<p>This works for every browser:</p>\n<pre><code>window.location.href = &#39;your_url&#39;;</code></pre>	2019-08-26 18:08:45.263771+03	74	8	\N	\N	\N
144	@@@@ Websocket test3	<p>@@@@ Websocket test3</p>\n	2019-08-29 14:29:01.347246+03	76	2	\N	\N	\N
148	qqq	<p>qqq</p>\n	2019-08-29 14:39:23.914033+03	76	2	\N	\N	\N
152	JENNIFER ANISTON	<p>JENNIFER ANISTON</p>\n	2019-08-29 14:42:22.163336+03	76	2	\N	\N	\N
155	Yuppi!!	<p>Yuppi!!</p>\n	2019-08-29 14:45:53.911781+03	76	5	\N	\N	\N
160	HELLO WORLD2	<p>HELLO WORLD2</p>\n	2019-08-29 15:16:07.050861+03	76	5	\N	\N	\N
161	HELLO WORLD24	<p>HELLO WORLD24</p>\n	2019-08-29 15:16:12.598044+03	76	5	\N	\N	\N
164	JASON MAMO	<p>JASON MAMO</p>\n	2019-08-29 15:45:53.202199+03	76	2	\N	\N	\N
36	I found that while adding\n\n    app.use(bodyParser.json());\n    app.use(bodyParser.urlencoded({\n      extended: true\n    }));\n\nhelps, sometimes it's a matter of your querying that determines how express handles it. \n\nFor instance, it could be that your parameters are passed in the **URL** rather than in the body\n\nIn such a case, you need to capture both the **body** and **url** parameters and use whichever is available (with preference for the body parameters in the case below)\n\n    app.route('/echo')\n        .all((req,res)=>{\n    \t    let pars = (Object.keys(req.body).length > 0)?req.body:req.query;\n    \t    res.send(pars);\n        });	<p>I found that while adding</p>\n<pre><code>app.use(bodyParser.json());\napp.use(bodyParser.urlencoded({\n  extended: true\n}));</code></pre><p>helps, sometimes it&#39;s a matter of your querying that determines how express handles it. </p>\n<p>For instance, it could be that your parameters are passed in the <strong>URL</strong> rather than in the body</p>\n<p>In such a case, you need to capture both the <strong>body</strong> and <strong>url</strong> parameters and use whichever is available (with preference for the body parameters in the case below)</p>\n<pre><code>app.route(&#39;/echo&#39;)\n    .all((req,res)=&gt;{\n        let pars = (Object.keys(req.body).length &gt; 0)?req.body:req.query;\n        res.send(pars);\n    });</code></pre>	2019-07-24 00:23:16.976328+03	49	9	\N	\N	\N
37	It is happening coz you are confusing it with `path` and `url`.\n\n\n     url('', index),\n\nHere as you have given `''` in url it's not the correct way. And that's why it's not going to next subsequent patterns.\n\n>**Solution-1:** Use proper `url` patterns with regular patterns using `^` and `$`.\n\n    urlpatterns = [\n        url(r'^$', index),\n        url(r'^user/login/$',Login.as_view()),\n        . . . . . \n    ]\n\n\n>**Solution-2:** Use `path` if using `django>=2.0`.\n\n    from django.urls import path\n\n    urlpatterns = [\n        path('', index),\n        path('user/login',Login.as_view()),\n        . . . . \n    ]	<p>It is happening coz you are confusing it with <code>path</code> and <code>url</code>.</p>\n<pre><code> url(&#39;&#39;, index),</code></pre><p>Here as you have given <code>&#39;&#39;</code> in url it&#39;s not the correct way. And that&#39;s why it&#39;s not going to next subsequent patterns.</p>\n<blockquote>\n<p><strong>Solution-1:</strong> Use proper <code>url</code> patterns with regular patterns using <code>^</code> and <code>$</code>.</p>\n</blockquote>\n<pre><code>urlpatterns = [\n    url(r&#39;^$&#39;, index),\n    url(r&#39;^user/login/$&#39;,Login.as_view()),\n    . . . . . \n]</code></pre><blockquote>\n<p><strong>Solution-2:</strong> Use <code>path</code> if using <code>django&gt;=2.0</code>.</p>\n</blockquote>\n<pre><code>from django.urls import path\n\nurlpatterns = [\n    path(&#39;&#39;, index),\n    path(&#39;user/login&#39;,Login.as_view()),\n    . . . . \n]</code></pre>	2019-08-04 23:55:30.857013+03	44	5	\N	\N	\N
24	Adding in example for solution given earlier. By using `socket.io-client` https://github.com/socketio/socket.io-client \n\n\nClient Side:\n\n    //client.js\n\tvar io = require('socket.io-client');\n\tvar socket = io.connect('http://localhost:3000', {reconnect: true});\n\n\t// Add a connect listener\n\tsocket.on('connect', function (socket) {\n\t\tconsole.log('Connected!');\n\t});\n\tsocket.emit('CH01', 'me', 'test msg');\n\n\nServer Side :\n\n    //server.js\n\tvar app = require('express')();\n\tvar http = require('http').Server(app);\n\tvar io = require('socket.io')(http);\n\n\tio.on('connection', function (socket){\n\t   console.log('connection');\n\n\t  socket.on('CH01', function (from, msg) {\n\t\tconsole.log('MSG', from, ' saying ', msg);\n\t  });\n\n\t});\n\n\thttp.listen(3000, function () {\n\t  console.log('listening on *:3000');\n\t});\n\n\nRun :\n\nOpen 2 console and run `node server.js` and `node client.js`	<p>Adding in example for solution given earlier. By using <code>socket.io-client</code> <a href="https://github.com/socketio/socket.io-client">https://github.com/socketio/socket.io-client</a> </p>\n<p>Client Side:</p>\n<pre><code>//client.js\nvar io = require(&#39;socket.io-client&#39;);\nvar socket = io.connect(&#39;http://localhost:3000&#39;, {reconnect: true});\n\n// Add a connect listener\nsocket.on(&#39;connect&#39;, function (socket) {\n    console.log(&#39;Connected!&#39;);\n});\nsocket.emit(&#39;CH01&#39;, &#39;me&#39;, &#39;test msg&#39;);</code></pre><p>Server Side :</p>\n<pre><code>//server.js\nvar app = require(&#39;express&#39;)();\nvar http = require(&#39;http&#39;).Server(app);\nvar io = require(&#39;socket.io&#39;)(http);\n\nio.on(&#39;connection&#39;, function (socket){\n   console.log(&#39;connection&#39;);\n\n  socket.on(&#39;CH01&#39;, function (from, msg) {\n    console.log(&#39;MSG&#39;, from, &#39; saying &#39;, msg);\n  });\n\n});\n\nhttp.listen(3000, function () {\n  console.log(&#39;listening on *:3000&#39;);\n});</code></pre><p>Run :</p>\n<p>Open 2 console and run <code>node server.js</code> and <code>node client.js</code></p>\n	2019-03-13 20:43:15.490817+03	28	2	\N	{10,20,4}	\N
137	    var url = 'asdf.html';\n    window.location.href = url;	<pre><code>var url = &#39;asdf.html&#39;;\nwindow.location.href = url;</code></pre>	2019-08-26 18:02:03.214734+03	74	9	\N	\N	\N
140	This works with jQuery:\n\n    $(window).attr("location", "http://google.fr");\n	<p>This works with jQuery:</p>\n<pre><code>$(window).attr(&quot;location&quot;, &quot;http://google.fr&quot;);</code></pre>	2019-08-26 18:10:13.75443+03	74	6	\N	\N	\N
142	# Standard "vanilla" JavaScript way to redirect a page\n\n```\nwindow.location.href = 'newPage.html';\n```\n\n## Or more simply:  (since `window` is Global) \n\n```\nlocation.href = 'newPage.html';\n```\n\n------\n\n> **If you are here because you are *losing* HTTP_REFERER when redirecting, keep reading:**\n\n> (Otherwise ignore this last part)\n\n---------\n\nThe following section is for those using `HTTP_REFERER` as one of many secure measures (although it isn't a great protective measure). If you're using [Internet&nbsp;Explorer&nbsp;8][1] or lower, these variables get lost when using any form of JavaScript page redirection (location.href,  etc.).\n\n Below we are going to implement an alternative for **IE8 & lower** so that we don't lose HTTP_REFERER. Otherwise you can almost always simply use `window.location.href`.\n\nTesting against `HTTP_REFERER` (URL pasting, session, etc.) *can* be helpful in telling whether a request is legitimate.\n*(**Note:** there are also ways to work-around / spoof these referrers, as noted by droop's link in the comments)*\n\n------\n\nSimple cross-browser testing solution (fallback to window.location.href for Internet&nbsp;Explorer&nbsp;9+ and all other browsers)\n\n**Usage: `redirect('anotherpage.aspx');`**\n\n    function redirect (url) {\n        var ua        = navigator.userAgent.toLowerCase(),\n            isIE      = ua.indexOf('msie') !== -1,\n            version   = parseInt(ua.substr(4, 2), 10);\n\n        // Internet Explorer 8 and lower\n        if (isIE && version < 9) {\n            var link = document.createElement('a');\n            link.href = url;\n            document.body.appendChild(link);\n            link.click();\n        }\n\n        // All other browsers can use the standard window.location.href (they don't lose HTTP_REFERER like Internet Explorer 8 & lower does)\n        else { \n            window.location.href = url; \n        }\n    }\n\n  [1]: http://en.wikipedia.org/wiki/Internet_Explorer_8\n	<h1 id="standard-vanilla-javascript-way-to-redirect-a-page">Standard &quot;vanilla&quot; JavaScript way to redirect a page</h1>\n<pre><code>window.location.href = &#39;newPage.html&#39;;</code></pre><h2 id="or-more-simply--since-window-is-global">Or more simply:  (since <code>window</code> is Global)</h2>\n<pre><code>location.href = &#39;newPage.html&#39;;</code></pre><hr>\n<blockquote>\n<p><strong>If you are here because you are <em>losing</em> HTTP_REFERER when redirecting, keep reading:</strong></p>\n</blockquote>\n<blockquote>\n<p>(Otherwise ignore this last part)</p>\n</blockquote>\n<hr>\n<p>The following section is for those using <code>HTTP_REFERER</code> as one of many secure measures (although it isn&#39;t a great protective measure). If you&#39;re using <a href="http://en.wikipedia.org/wiki/Internet_Explorer_8">Internet&nbsp;Explorer&nbsp;8</a> or lower, these variables get lost when using any form of JavaScript page redirection (location.href,  etc.).</p>\n<p> Below we are going to implement an alternative for <strong>IE8 &amp; lower</strong> so that we don&#39;t lose HTTP_REFERER. Otherwise you can almost always simply use <code>window.location.href</code>.</p>\n<p>Testing against <code>HTTP_REFERER</code> (URL pasting, session, etc.) <em>can</em> be helpful in telling whether a request is legitimate.\n<em>(<strong>Note:</strong> there are also ways to work-around / spoof these referrers, as noted by droop&#39;s link in the comments)</em></p>\n<hr>\n<p>Simple cross-browser testing solution (fallback to window.location.href for Internet&nbsp;Explorer&nbsp;9+ and all other browsers)</p>\n<p><strong>Usage: <code>redirect(&#39;anotherpage.aspx&#39;);</code></strong></p>\n<pre><code>function redirect (url) {\n    var ua        = navigator.userAgent.toLowerCase(),\n        isIE      = ua.indexOf(&#39;msie&#39;) !== -1,\n        version   = parseInt(ua.substr(4, 2), 10);\n\n    // Internet Explorer 8 and lower\n    if (isIE &amp;&amp; version &lt; 9) {\n        var link = document.createElement(&#39;a&#39;);\n        link.href = url;\n        document.body.appendChild(link);\n        link.click();\n    }\n\n    // All other browsers can use the standard window.location.href (they don&#39;t lose HTTP_REFERER like Internet Explorer 8 &amp; lower does)\n    else { \n        window.location.href = url; \n    }\n}</code></pre>	2019-08-26 18:26:56.59769+03	74	7	\N	\N	\N
145	@@@@ Websocket test4	<p>@@@@ Websocket test4</p>\n	2019-08-29 14:29:27.148226+03	76	2	\N	\N	\N
146	@@@@ Websocket test4qqq	<p>@@@@ Websocket test4qqq</p>\n	2019-08-29 14:29:36.260651+03	76	2	\N	\N	\N
149	GOOD JOB!	<p>GOOD JOB!</p>\n	2019-08-29 14:39:37.450213+03	76	2	\N	\N	\N
150	GOOD JOB!x	<p>GOOD JOB!x</p>\n	2019-08-29 14:39:45.954126+03	76	2	\N	\N	\N
153	ANGELINE JOLIE	<p>ANGELINE JOLIE</p>\n	2019-08-29 14:43:34.739109+03	76	5	\N	\N	\N
156	KATY PERRY	<p>KATY PERRY</p>\n	2019-08-29 14:47:05.378566+03	76	5	\N	\N	\N
157	KATY PERRY2	<p>KATY PERRY2</p>\n	2019-08-29 14:47:13.83164+03	76	5	\N	\N	\N
158	KATY PERRY3	<p>KATY PERRY3</p>\n	2019-08-29 14:47:21.284325+03	76	5	\N	\N	\N
162	Hola, hola XD	<p>Hola, hola XD</p>\n	2019-08-29 15:44:17.774541+03	76	2	\N	\N	\N
165	Thi is incredible...	<p>Thi is incredible...</p>\n	2019-08-29 15:46:20.621968+03	76	2	\N	\N	\N
44	The `e.target` property type depends on the element you are returning on `getElementById(...)`. `files` is a property of `input` element: https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement\n\nIn this case, the TypeScript compiler doesn't know you are returning an `input` element and we dont have an `Event` class specific for this. So, you can create one like the following code:\n\n    interface HTMLInputEvent extends Event {\n        target: HTMLInputElement & EventTarget;\n    }\n\n    document.getElementById("customimage").onchange = function(e?: HTMLInputEvent) {\n        let files: any = e.target.files[0]; \n        //...\n    }	<p>The <code>e.target</code> property type depends on the element you are returning on <code>getElementById(...)</code>. <code>files</code> is a property of <code>input</code> element: <a href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement">https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement</a></p>\n<p>In this case, the TypeScript compiler doesn&#39;t know you are returning an <code>input</code> element and we dont have an <code>Event</code> class specific for this. So, you can create one like the following code:</p>\n<pre><code>interface HTMLInputEvent extends Event {\n    target: HTMLInputElement &amp; EventTarget;\n}\n\ndocument.getElementById(&quot;customimage&quot;).onchange = function(e?: HTMLInputEvent) {\n    let files: any = e.target.files[0]; \n    //...\n}</code></pre>	2019-08-11 00:30:11.74867+03	55	10	\N	\N	\N
65	## 2019 Update: It *still* depends on the browsers *your* demographic uses.\n\nAn important thing to understand with the "new" HTML5 `file` API is that is [wasn't supported until IE 10][1]. If the specific market you're aiming at has a higher-than-average prepensity toward older versions of Windows, you might not have access to it.\n\nAs of 2017, about 5% of browsers are one of IE 6, 7, 8 or 9. If you head into a big corporation (eg this is a B2B tool, or something you're delivering for training) that number can rocket. In 2016, I dealt with a company using IE8 on over 60% of their machines.\n\nIt's 2019 as of this edit, almost 11 years after my initial answer. IE9 and lower are *globally* around the 1% mark but there are still clusters  of higher usage.\n\nThe important take-away from this —whatever the feature— is, **check what browser *your* users use**. If you don't, you'll learn a quick and painful lesson in why "works for me" isn't good enough in a deliverable to a client. [caniuse][2] is a useful tool but note where they get their demographics from. They may not align with yours. This is never truer than enterprise environments.\n\nMy answer from 2008 follows.\n\n---\n\nHowever, there are viable non-JS methods of file uploads. You can create an iframe on the page (that you hide with CSS) and then target your form to post to that iframe. The main page doesn't need to move.\n\nIt's a "real" post so it's not wholly interactive. If you need status you need something server-side to process that. This varies massively depending on your server. [ASP.NET][3] has nicer mechanisms. PHP plain fails, but you can use [Perl][4] or Apache modifications to get around it.\n\nIf you need multiple file-uploads, it's best to do each file one at a time (to overcome maximum file upload limits). Post the first form to the iframe, monitor its progress using the above and when it has finished, post the second form to the iframe, and so on.\n\nOr use a Java/Flash solution. They're a lot more flexible in what they can do with their posts...\n\n\n  [1]: http://caniuse.com/fileapi\n  [2]: https://caniuse.com/\n  [3]: http://en.wikipedia.org/wiki/ASP.NET\n  [4]: http://en.wikipedia.org/wiki/Perl	<h2 id="2019-update-it-still-depends-on-the-browsers-your-demographic-uses">2019 Update: It <em>still</em> depends on the browsers <em>your</em> demographic uses.</h2>\n<p>An important thing to understand with the &quot;new&quot; HTML5 <code>file</code> API is that is <a href="http://caniuse.com/fileapi">wasn&#39;t supported until IE 10</a>. If the specific market you&#39;re aiming at has a higher-than-average prepensity toward older versions of Windows, you might not have access to it.</p>\n<p>As of 2017, about 5% of browsers are one of IE 6, 7, 8 or 9. If you head into a big corporation (eg this is a B2B tool, or something you&#39;re delivering for training) that number can rocket. In 2016, I dealt with a company using IE8 on over 60% of their machines.</p>\n<p>It&#39;s 2019 as of this edit, almost 11 years after my initial answer. IE9 and lower are <em>globally</em> around the 1% mark but there are still clusters  of higher usage.</p>\n<p>The important take-away from this —whatever the feature— is, <strong>check what browser <em>your</em> users use</strong>. If you don&#39;t, you&#39;ll learn a quick and painful lesson in why &quot;works for me&quot; isn&#39;t good enough in a deliverable to a client. <a href="https://caniuse.com/">caniuse</a> is a useful tool but note where they get their demographics from. They may not align with yours. This is never truer than enterprise environments.</p>\n<p>My answer from 2008 follows.</p>\n<hr>\n<p>However, there are viable non-JS methods of file uploads. You can create an iframe on the page (that you hide with CSS) and then target your form to post to that iframe. The main page doesn&#39;t need to move.</p>\n<p>It&#39;s a &quot;real&quot; post so it&#39;s not wholly interactive. If you need status you need something server-side to process that. This varies massively depending on your server. <a href="http://en.wikipedia.org/wiki/ASP.NET">ASP.NET</a> has nicer mechanisms. PHP plain fails, but you can use <a href="http://en.wikipedia.org/wiki/Perl">Perl</a> or Apache modifications to get around it.</p>\n<p>If you need multiple file-uploads, it&#39;s best to do each file one at a time (to overcome maximum file upload limits). Post the first form to the iframe, monitor its progress using the above and when it has finished, post the second form to the iframe, and so on.</p>\n<p>Or use a Java/Flash solution. They&#39;re a lot more flexible in what they can do with their posts...</p>\n	2019-08-14 02:33:06.324554+03	63	6	\N	\N	\N
66	I recommend using the [Fine Uploader][1] plugin for this purpose. Your `JavaScript` code would be:\n\n    $(document).ready(function() {\n      $("#uploadbutton").jsupload({\n        action: "addFile.do",\n        onComplete: function(response){\n          alert( "server response: " + response);\n        }\n      });\n    });\n\n  [1]: http://fineuploader.com/demos.html\n	<p>I recommend using the <a href="http://fineuploader.com/demos.html">Fine Uploader</a> plugin for this purpose. Your <code>JavaScript</code> code would be:</p>\n<pre><code>$(document).ready(function() {\n  $(&quot;#uploadbutton&quot;).jsupload({\n    action: &quot;addFile.do&quot;,\n    onComplete: function(response){\n      alert( &quot;server response: &quot; + response);\n    }\n  });\n});</code></pre>	2019-08-14 15:57:41.900047+03	63	10	\N	\N	\N
45	You can cast it as a **HTMLInputElement**:\n\n    document.getElementById("customimage").onchange= function(e: Event) {\n        let file = (<HTMLInputElement>e.target).files[0];\n        //rest of your code...\n    }	<p>You can cast it as a <strong>HTMLInputElement</strong>:</p>\n<pre><code>document.getElementById(&quot;customimage&quot;).onchange= function(e: Event) {\n    let file = (&lt;HTMLInputElement&gt;e.target).files[0];\n    //rest of your code...\n}</code></pre>	2019-08-11 00:31:57.521583+03	55	9	\N	\N	\N
51	# Testing yorumdur.	<h1 id="testing-yorumdur">Testing yorumdur.</h1>\n	2019-08-11 03:09:56.593178+03	45	1	\N	\N	\N
52	## Ikinci deneme yorum...	<h2 id="ikinci-deneme-yorum">Ikinci deneme yorum...</h2>\n	2019-08-11 03:17:07.189671+03	45	1	\N	\N	\N
53	* Her an her sey olabilir *\n\nLorem ipsum...	<ul>\n<li>Her an her sey olabilir *</li>\n</ul>\n<p>Lorem ipsum...</p>\n	2019-08-11 03:19:37.913866+03	45	4	\N	\N	\N
54	* Her an her sey olabilir *\n\nLorem ipsum...\nsglkjksgjljklsg	<ul>\n<li>Her an her sey olabilir *</li>\n</ul>\n<p>Lorem ipsum...\nsglkjksgjljklsg</p>\n	2019-08-11 03:21:10.493015+03	45	4	\N	\N	\N
55	Websocket denemeleri devam ediyor...	<p>Websocket denemeleri devam ediyor...</p>\n	2019-08-11 03:21:44.652512+03	45	4	\N	\N	\N
56	Besiktassin sen bizim canimiz...	<p>Besiktassin sen bizim canimiz...</p>\n	2019-08-11 03:30:49.853417+03	45	10	\N	\N	\N
57	Test asamasi suruyor...	<p>Test asamasi suruyor...</p>\n	2019-08-11 03:36:40.213338+03	45	10	\N	\N	\N
58	Dale don dale..\n	<p>Dale don dale..</p>\n	2019-08-11 03:37:26.121327+03	45	10	\N	\N	\N
59	cevaplar devam ediyor..	<p>cevaplar devam ediyor..</p>\n	2019-08-11 03:37:54.151629+03	45	10	\N	\N	\N
60	damlacemre	<p>damlacemre</p>\n	2019-08-11 03:38:23.131348+03	45	10	\N	\N	\N
61	xdxdxdxddd	<p>xdxdxdxddd</p>\n	2019-08-11 03:38:47.34617+03	45	10	\N	\N	\N
62	yehhu :"D	<p>yehhu :&quot;D</p>\n	2019-08-11 03:39:23.86432+03	45	10	\N	\N	\N
63	# Hola	<h1 id="hola">Hola</h1>\n	2019-08-11 22:49:22.45152+03	56	1	\N	\N	\N
64	With [HTML5][1] you can make file uploads with Ajax and jQuery. Not only that, you can do file validations (name, size, and MIME type) or handle the progress event with the HTML5 progress tag (or a div). Recently I had to make a file uploader, but I didn't want to use [Flash][2] nor Iframes or plugins and after some research I came up with the solution.\n\nThe HTML:\n\n    <form enctype="multipart/form-data">\n        <input name="file" type="file" />\n        <input type="button" value="Upload" />\n    </form>\n    <progress></progress>\n\nFirst, you can do some validation if you want. For example, in the `.on('change')` event of the file:\n\n    $(':file').on('change', function () {\n      var file = this.files[0];\n\n      if (file.size > 1024) {\n        alert('max upload size is 1k');\n      }\n    \n      // Also see .name, .type\n    });\n\nNow the `$.ajax()` submit with the button's click:\n\n    $(':button').on('click', function () {\n      $.ajax({\n        // Your server script to process the upload\n        url: 'upload.php',\n        type: 'POST',\n    \n        // Form data\n        data: new FormData($('form')[0]),\n    \n        // Tell jQuery not to process data or worry about content-type\n        // You *must* include these options!\n        cache: false,\n        contentType: false,\n        processData: false,\n    \n        // Custom XMLHttpRequest\n        xhr: function () {\n          var myXhr = $.ajaxSettings.xhr();\n          if (myXhr.upload) {\n            // For handling the progress of the upload\n            myXhr.upload.addEventListener('progress', function (e) {\n              if (e.lengthComputable) {\n                $('progress').attr({\n                  value: e.loaded,\n                  max: e.total,\n                });\n              }\n            }, false);\n          }\n          return myXhr;\n        }\n      });\n    });\n\n\nAs you can see, with HTML5 (and some research) file uploading not only becomes possible but super easy. Try it with [Google Chrome][3] as some of the HTML5 components of the examples aren't available in every browser.\n\n  [1]: http://en.wikipedia.org/wiki/HTML5\n  [2]: http://en.wikipedia.org/wiki/Adobe_Flash\n  [3]: http://en.wikipedia.org/wiki/Google_Chrome\n	<p>With <a href="http://en.wikipedia.org/wiki/HTML5">HTML5</a> you can make file uploads with Ajax and jQuery. Not only that, you can do file validations (name, size, and MIME type) or handle the progress event with the HTML5 progress tag (or a div). Recently I had to make a file uploader, but I didn&#39;t want to use <a href="http://en.wikipedia.org/wiki/Adobe_Flash">Flash</a> nor Iframes or plugins and after some research I came up with the solution.</p>\n<p>The HTML:</p>\n<pre><code>&lt;form enctype=&quot;multipart/form-data&quot;&gt;\n    &lt;input name=&quot;file&quot; type=&quot;file&quot; /&gt;\n    &lt;input type=&quot;button&quot; value=&quot;Upload&quot; /&gt;\n&lt;/form&gt;\n&lt;progress&gt;&lt;/progress&gt;</code></pre><p>First, you can do some validation if you want. For example, in the <code>.on(&#39;change&#39;)</code> event of the file:</p>\n<pre><code>$(&#39;:file&#39;).on(&#39;change&#39;, function () {\n  var file = this.files[0];\n\n  if (file.size &gt; 1024) {\n    alert(&#39;max upload size is 1k&#39;);\n  }\n\n  // Also see .name, .type\n});</code></pre><p>Now the <code>$.ajax()</code> submit with the button&#39;s click:</p>\n<pre><code>$(&#39;:button&#39;).on(&#39;click&#39;, function () {\n  $.ajax({\n    // Your server script to process the upload\n    url: &#39;upload.php&#39;,\n    type: &#39;POST&#39;,\n\n    // Form data\n    data: new FormData($(&#39;form&#39;)[0]),\n\n    // Tell jQuery not to process data or worry about content-type\n    // You *must* include these options!\n    cache: false,\n    contentType: false,\n    processData: false,\n\n    // Custom XMLHttpRequest\n    xhr: function () {\n      var myXhr = $.ajaxSettings.xhr();\n      if (myXhr.upload) {\n        // For handling the progress of the upload\n        myXhr.upload.addEventListener(&#39;progress&#39;, function (e) {\n          if (e.lengthComputable) {\n            $(&#39;progress&#39;).attr({\n              value: e.loaded,\n              max: e.total,\n            });\n          }\n        }, false);\n      }\n      return myXhr;\n    }\n  });\n});</code></pre><p>As you can see, with HTML5 (and some research) file uploading not only becomes possible but super easy. Try it with <a href="http://en.wikipedia.org/wiki/Google_Chrome">Google Chrome</a> as some of the HTML5 components of the examples aren&#39;t available in every browser.</p>\n	2019-08-14 02:30:54.101522+03	63	1	\N	\N	\N
80	# Hello world	<h1 id="hello-world">Hello world</h1>\n	2019-08-23 15:30:17.363096+03	70	9	\N	\N	\N
166	I read this question and implemented the approach that has been stated regarding setting the response status code to 278 in order to avoid the browser transparently handling the redirects. Even though this worked, I was a little dissatisfied as it is a bit of a hack.\n\nAfter more digging around, I ditched this approach and used [JSON][1]. In this case, all responses to ajax requests have the status code 200 and the body of the response contains a JSON object that is constructed on the server. The javascript on the client can then use the JSON object to decide what it needs to do.\n\nI had a similar problem to yours. I perform an ajax request that has 2 possible responses: one that redirects the browser to a new page and one that replaces an existing HTML form on the current page with a new one. The jquery code to do this looks something like:\n\n    $.ajax({\n        type: "POST",\n        url: reqUrl,\n        data: reqBody,\n        dataType: "json",\n        success: function(data, textStatus) {\n            if (data.redirect) {\n                // data.redirect contains the string URL to redirect to\n                window.location.href = data.redirect;\n            }\n            else {\n                // data.form contains the HTML for the replacement form\n                $("#myform").replaceWith(data.form);\n            }\n        }\n    });\n\nThe JSON object "data" is constructed on the server to have 2 members: data.redirect and data.form. I found this approach to be much better.\n\n  [1]: http://en.wikipedia.org/wiki/JSON	<p>I read this question and implemented the approach that has been stated regarding setting the response status code to 278 in order to avoid the browser transparently handling the redirects. Even though this worked, I was a little dissatisfied as it is a bit of a hack.</p>\n<p>After more digging around, I ditched this approach and used <a href="http://en.wikipedia.org/wiki/JSON">JSON</a>. In this case, all responses to ajax requests have the status code 200 and the body of the response contains a JSON object that is constructed on the server. The javascript on the client can then use the JSON object to decide what it needs to do.</p>\n<p>I had a similar problem to yours. I perform an ajax request that has 2 possible responses: one that redirects the browser to a new page and one that replaces an existing HTML form on the current page with a new one. The jquery code to do this looks something like:</p>\n<pre><code>$.ajax({\n    type: &quot;POST&quot;,\n    url: reqUrl,\n    data: reqBody,\n    dataType: &quot;json&quot;,\n    success: function(data, textStatus) {\n        if (data.redirect) {\n            // data.redirect contains the string URL to redirect to\n            window.location.href = data.redirect;\n        }\n        else {\n            // data.form contains the HTML for the replacement form\n            $(&quot;#myform&quot;).replaceWith(data.form);\n        }\n    }\n});</code></pre><p>The JSON object &quot;data&quot; is constructed on the server to have 2 members: data.redirect and data.form. I found this approach to be much better.</p>\n	2019-09-13 05:12:21.647449+03	79	8	\N	\N	\N
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.articles (id, title) FROM stdin;
1	Hello Push!
2	Hello Push!
3	Hello Push!
4	Hello Push!
5	Hello Push!
6	Hello Push!
7	Hello Push!
8	Hello Push!
9	Hello Push!
10	Hello Push!
11	Hello Push!
12	Hello Push!
13	Hello Push!
14	Hello Push!
15	Hello Push!
16	Hello Push!
17	Hello Push!
18	Hello Push!
19	Hello Push!
20	Hello Push!
21	Hello Push!
22	Hello Push!
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, text, "renderedText", "creationTime", "userId", "postId", "postTypeId") FROM stdin;
1	Ekliler zaten	Ekliler zaten	2019-03-05 16:49:14.26092+03	6	7	2
2	Regarding why web inspectors don't catch the traffic: see [How to view WS/WSS Websocket request content using Firebug or other?](http://stackoverflow.com/questions/9221018/how-to-view-ws-wss-websocket-request-content-using-firebug-or-other)	Regarding why web inspectors don't catch the traffic: see <a href="http://stackoverflow.com/questions/9221018/how-to-view-ws-wss-websocket-request-content-using-firebug-or-other">How to view WS/WSS Websocket request content using Firebug or other?</a>	2019-03-05 16:49:14.26092+03	5	15	1
3	How do I view the response from socket.emit()?	How do I view the response from socket.emit()?	2019-04-12 03:04:01.653967+03	1	28	1
4	Hello comment	Hello comment	2019-08-04 19:49:00.203809+03	1	49	1
5	*Cici cici*	<em>Cici cici</em>	2019-08-04 19:49:20.82873+03	1	49	1
6	Bu soru ilk siraya cikmali XD	Bu soru ilk siraya cikmali XD	2019-08-04 20:19:31.15249+03	5	44	1
7	Flood yorum yapiyorum :D, denetleme yok nasilsa.	Flood yorum yapiyorum :D, denetleme yok nasilsa.	2019-08-07 20:55:54.265094+03	6	51	1
8	This is not a programming question. Express 3.0 hasn't had any releases yet, but you can look at the migration guide and the new features. Hold your horses.	This is not a programming question. Express 3.0 hasn&#39;t had any releases yet, but you can look at the migration guide and the new features. Hold your horses.	2019-08-11 03:59:21.511564+03	8	56	3
10	you are only getting the file name because your var filename is getting the value of $('#file'), not the file that lies in the input	you are only getting the file name because your var filename is getting the value of $(&#39;#file&#39;), not the file that lies in the input	2019-08-14 05:27:17.574154+03	1	\N	3
\.


--
-- Data for Name: flags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flags (id, "flagTypeId", "creationTime", "userId", "postId", "voteTypeId") FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, text, "creationTime", "userId", "roomId", type, content) FROM stdin;
116	Coca Cola!	2019-05-31 07:56:09.750029+03	1	1	0	Coca Cola!
117	yok	2019-06-12 23:38:59.688288+03	35	1	0	yok
121	bırısı ekledınde	2019-06-12 23:40:31.966592+03	35	1	0	bırısı ekledınde
129	Eski cizgi filmleri ozleyen var mi?	2019-06-13 00:12:36.669228+03	3	10	0	Eski cizgi filmleri ozleyen var mi?
133	Kanal D'de cikiyodu ben cocukken, sevimli kahramanlar diye.	2019-06-15 18:47:39.564082+03	4	10	0	Kanal D&#39;de cikiyodu ben cocukken, sevimli kahramanlar diye.
201	Hello world	2019-08-07 16:43:51.145473+03	39	11	0	Hello world
202	Hello dunya.	2019-08-16 18:45:47.182279+03	7	11	0	Hello dunya.
203	Bu ne dunya kardesim	2019-08-16 18:45:57.069065+03	39	11	0	Bu ne dunya kardesim
204	Seven sevene	2019-08-16 18:46:02.81911+03	7	11	0	Seven sevene
209	XD 2	2019-08-17 15:49:40.823808+03	32	11	0	XD 2
213	Arsenal 21	2019-08-17 15:55:36.632133+03	5	11	0	Arsenal 21
218	xdxd	2019-08-17 16:00:43.910031+03	36	11	0	xdxd
222	qqq	2019-08-17 16:05:39.848708+03	36	11	0	qqq
226	xd	2019-08-17 16:25:50.649056+03	3	11	0	xd
230	dale don dale...	2019-08-17 16:35:18.369654+03	35	11	0	dale don dale...
236	yrsh	2019-08-17 16:40:00.537331+03	6	11	0	yrsh
237	deneme	2019-08-17 16:40:06.896862+03	6	11	0	deneme
244	Kadi kizi	2019-08-17 16:44:13.881016+03	10	11	0	Kadi kizi
252	Jelibon	2019-08-17 17:04:40.857991+03	7	11	0	Jelibon
259	This is	2019-08-17 17:09:28.202336+03	4	11	0	This is
260	Incredibles 3	2019-08-17 17:09:43.866012+03	1	11	0	Incredibles 3
261	Cehennem melekleri izlerler	2019-08-17 17:09:50.513952+03	1	11	0	Cehennem melekleri izlerler
262	SURARLAR	2019-08-17 17:09:54.450173+03	1	11	0	SURARLAR
747	Yazicam daha	2019-08-29 04:05:21.213509+03	5	12	0	Yazicam daha
748	Angular ve nodejs	2019-08-29 04:05:24.460205+03	5	12	0	Angular ve nodejs
749	ile ilgili seyler derler	2019-08-29 04:05:28.364408+03	5	12	0	ile ilgili seyler derler
760	XD	2019-08-29 15:59:35.406177+03	5	11	0	XD
195	Merhabalar.	2019-08-05 02:53:25.460403+03	3	11	0	Merhabalar.
198	Oley be	2019-08-05 03:07:16.16195+03	7	11	0	Oley be
767	Iyi iyi derler	2019-08-29 19:23:57.092868+03	9	12	0	Iyi iyi derler
772	MongoDB var.	2019-08-29 19:27:43.721876+03	9	12	0	MongoDB var.
778	duzensiz bir verimiz yok sonucta	2019-08-29 19:40:40.524748+03	9	12	0	duzensiz bir verimiz yok sonucta
785	Relax olalim, cikacak ortaya :)	2019-08-29 19:47:27.023574+03	9	8	0	Relax olalim, cikacak ortaya :)
793	Evet, temel ozellikleri kesinkes halletmemiz lazim	2019-08-29 20:25:42.439512+03	5	8	0	Evet, temel ozellikleri kesinkes halletmemiz lazim
306	Helloooo	2019-08-18 03:15:03.42467+03	5	11	0	Helloooo
310	xd	2019-08-18 03:18:45.072416+03	37	11	0	xd
798	Guzel gunler yaklasiyor desene	2019-08-29 22:28:22.850219+03	5	8	0	Guzel gunler yaklasiyor desene
808	Hahha :D	2019-09-02 03:55:40.68079+03	5	8	0	Hahha :D
819	PostgreSQL 12 cikinca inceleriz.	2019-09-02 18:49:55.262313+03	7	11	0	PostgreSQL 12 cikinca inceleriz.
323	Programlama ile ilgili chat	2019-08-18 04:37:48.19847+03	5	12	0	Programlama ile ilgili chat
324	Denemeler baslasin xd	2019-08-18 04:38:01.051076+03	10	12	0	Denemeler baslasin xd
325	heyt be	2019-08-18 04:38:04.571311+03	7	12	0	heyt be
326	yasa be	2019-08-18 04:38:07.682726+03	37	12	0	yasa be
327	ne guzel dimi	2019-08-18 04:38:09.802878+03	3	12	0	ne guzel dimi
328	boyle hayat oh	2019-08-18 04:38:13.050583+03	37	12	0	boyle hayat oh
333	Sohbet BETA Devam ediyor.	2019-08-18 04:44:30.947322+03	5	10	0	Sohbet BETA Devam ediyor.
337	🎑 EMOJI TEST	2019-08-18 04:46:23.795663+03	9	10	0	🎑 EMOJI TEST
342	YES	2019-08-18 04:48:12.738868+03	2	10	0	YES
343	HULOGGG	2019-08-18 04:48:24.275023+03	3	10	0	HULOGGG
348	GOL GOL	2019-08-18 04:50:12.339292+03	7	10	0	GOL GOL
349	123456	2019-08-18 04:50:21.947667+03	9	10	0	123456
353	STOP!	2019-08-18 04:52:08.398071+03	7	10	0	STOP!
357	Gul bakalim 😁	2019-08-18 04:54:56.355261+03	8	10	0	Gul bakalim 😁
362	Denemelik	2019-08-18 17:12:27.379508+03	9	11	0	Denemelik
379	1234	2019-08-19 13:41:42.076127+03	8	11	0	1234
380	546	2019-08-19 13:41:43.059991+03	39	11	0	546
381	789	2019-08-19 13:41:44.371829+03	4	11	0	789
382	654	2019-08-19 13:41:45.731639+03	1	11	0	654
383	54+456+	2019-08-19 13:41:46.811699+03	36	11	0	54+456+
384	564546	2019-08-19 13:41:48.020212+03	1	11	0	564546
385	564564564	2019-08-19 13:41:49.091676+03	35	11	0	564564564
386	564546546	2019-08-19 13:41:50.115644+03	5	11	0	564546546
387	56546456	2019-08-19 13:41:51.132213+03	2	11	0	56546456
388	564546456	2019-08-19 13:41:52.1964+03	39	11	0	564546456
389	564456564	2019-08-19 13:41:53.14006+03	10	11	0	564456564
390	dkfjgjhkdl	2019-08-19 13:41:54.259571+03	5	11	0	dkfjgjhkdl
391	ahaha	2019-08-19 13:41:55.228128+03	39	11	0	ahaha
392	ne guzel ne guzel	2019-08-19 13:41:57.812478+03	32	11	0	ne guzel ne guzel
393	bir turlu multiple olmuyor	2019-08-19 13:42:00.956372+03	35	11	0	bir turlu multiple olmuyor
1	Angular sohbeti baslangic mesaji	2019-02-25 16:53:16.352403+03	1	1	0	Angular sohbeti baslangic mesaji
394	lorem derler	2019-08-19 13:42:03.012369+03	37	11	0	lorem derler
400	987	2019-08-19 13:47:01.397739+03	4	11	0	987
403	yeah	2019-08-19 13:49:24.549028+03	1	11	0	yeah
408	Alo	2019-08-19 13:56:13.549341+03	2	11	0	Alo
409	alo diyorum	2019-08-19 13:56:15.72495+03	5	11	0	alo diyorum
414	123456	2019-08-19 14:15:12.909781+03	10	11	0	123456
423	Huh!	2019-08-19 14:22:08.926296+03	5	11	0	Huh!
424	Test	2019-08-19 14:22:17.638246+03	5	11	0	Test
428	I'm John Doe	2019-08-19 14:25:02.381154+03	37	11	0	I&#39;m John Doe
429	I'm professor	2019-08-19 14:25:06.125889+03	37	11	0	I&#39;m professor
430	XD	2019-08-19 14:25:08.133739+03	37	11	0	XD
435	lorem 1	2019-08-19 14:27:20.035511+03	40	11	0	lorem 1
436	lorem 2	2019-08-19 14:27:22.477206+03	40	11	0	lorem 2
437	lorem 3	2019-08-19 14:27:27.246036+03	40	11	0	lorem 3
441	Hayali paralar	2019-08-19 14:32:51.990485+03	30	11	0	Hayali paralar
442	dunuyor	2019-08-19 14:32:53.669634+03	30	11	0	dunuyor
205	Bu bir genel sohbet grubudur	2019-08-17 00:50:00.876625+03	6	11	0	Bu bir genel sohbet grubudur
206	Delilo delilo destane	2019-08-17 00:50:11.193339+03	7	11	0	Delilo delilo destane
92	Bu proje yarida kalmazda, guzel bir ornek olur	2019-03-01 03:02:09.751637+03	7	8	0	Bu proje yarida kalmazda, guzel bir ornek olur
93	Herkesin temennisi o yonde.	2019-03-01 03:02:17.423317+03	4	8	0	Herkesin temennisi o yonde.
94	Deno.land gelene kadar halletmeliyiz	2019-03-01 03:02:33.247204+03	5	8	0	Deno.land gelene kadar halletmeliyiz
95	http://deno.land	2019-03-01 03:02:40.175279+03	10	8	0	http://deno.land
96	Lebron James 48 points\nJames Harden 58 points\nYeah.	2019-03-01 23:02:44.281914+03	3	8	0	Lebron James 48 points\nJames Harden 58 points\nYeah.
210	gklgskjlgsjkl	2019-08-17 15:51:57.103993+03	7	11	0	gklgskjlgsjkl
100	DENVER - SAN ANTONIO SPURS	2019-03-05 08:25:54.001841+03	9	1	0	DENVER - SAN ANTONIO SPURS
214	Windows 10 yeah	2019-08-17 15:57:59.766546+03	10	11	0	Windows 10 yeah
75	![Alt tag](https://images.unsplash.com/photo-1559056408-94245a95e30e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80 'Image title')	2019-02-27 21:41:37.245501+03	2	8	1	![Alt tag](https://images.unsplash.com/photo-1559056408-94245a95e30e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80 'Image title')
97	![Alt tag](https://images.unsplash.com/photo-1551576693-43a462b3661d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80 'Image title')	2019-03-02 00:03:22.903126+03	5	8	1	![Alt tag](https://images.unsplash.com/photo-1551576693-43a462b3661d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80 'Image title')
101	Coca Cola!	2019-05-30 05:18:18.883122+03	9	8	0	Coca Cola!
103	sure	2019-05-30 05:25:49.846647+03	35	8	0	sure
105	Ahh, I can finally go to sleep happy now :)\nThanks guys	2019-05-30 05:26:27.790694+03	10	8	0	Ahh, I can finally go to sleep happy now :)\nThanks guys
104	Well there we go that seems to have solved the problem.	2019-05-30 05:26:10.750082+03	10	8	0	Well there we go that seems to have solved the problem.
118	yok	2019-06-12 23:39:49.422966+03	35	1	0	yok
119	onla alakalı	2019-06-12 23:40:11.75892+03	35	1	0	onla alakalı
196	Test	2019-08-05 02:54:00.685451+03	6	10	0	Test
130	Kim ozlemez ki 🔥	2019-06-13 00:15:36.572469+03	4	10	0	Kim ozlemez ki 🔥
106	heck yeah	2019-05-30 05:27:21.597342+03	35	8	0	heck yeah
131	Tom ve Jerry efsanesi...	2019-06-15 18:45:31.564975+03	37	10	0	Tom ve Jerry efsanesi...
134	Speedy Gonzales'i hatirlayan bakalim :D	2019-06-15 18:49:34.250843+03	8	10	0	Speedy Gonzales&#39;i hatirlayan bakalim :D
219	Helloo	2019-08-17 16:02:37.033925+03	39	11	0	Helloo
223	yeah	2019-08-17 16:13:52.416768+03	36	11	0	yeah
227	xd2	2019-08-17 16:28:54.832698+03	5	11	0	xd2
231	i love you chat.	2019-08-17 16:35:49.977419+03	5	11	0	i love you chat.
64	mukemmel gozukuyor.	2019-02-27 02:24:59.167204+03	10	8	0	mukemmel gozukuyor.
2	Angular sohbetten mesajlar	2019-02-25 23:18:10.72529+03	4	1	0	Angular sohbetten mesajlar
232	test	2019-08-17 16:35:57.833093+03	5	11	0	test
238	Don	2019-08-17 16:41:32.881217+03	3	11	0	Don
245	GOOD MORNING	2019-08-17 16:44:55.018326+03	2	11	0	GOOD MORNING
246	HELLO EVERYBODY	2019-08-17 16:45:02.680988+03	2	11	0	HELLO EVERYBODY
253	ONUR SONER DERLER	2019-08-17 17:04:51.142163+03	7	11	0	ONUR SONER DERLER
254	EYMEN DERLER	2019-08-17 17:04:57.553989+03	7	11	0	EYMEN DERLER
263	merhabalar	2019-08-17 17:11:02.914307+03	9	11	0	merhabalar
102	I guess I would be able to substitute parcel with Webpack.	2019-05-30 05:20:16.845273+03	10	8	0	I guess I would be able to substitute parcel with Webpack.
107	Hello guys! 🐱‍💻	2019-05-30 05:32:35.341555+03	5	8	0	Hello guys! 🐱‍💻
108	Node.js öğrenmeye hazırım! 👌	2019-05-30 05:33:24.175417+03	3	8	0	Node.js öğrenmeye hazırım! 👌
61	![Kate Upton](https://images.unsplash.com/photo-1556985623-ea141170df77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1491&q=80 "Kate Upton")	2019-02-26 21:11:40.646986+03	5	8	1	![Kate Upton](https://images.unsplash.com/photo-1556985623-ea141170df77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1491&q=80 "Kate Upton")
110	Golden State Warriors - Toronto Raptors maci var, ne dusunuyorsunuz?	2019-05-30 21:39:28.274546+03	36	1	0	Golden State Warriors - Toronto Raptors maci var, ne dusunuyorsunuz?
264	Of anam of	2019-08-17 17:11:16.939002+03	1	11	0	Of anam of
265	CHAT YAZARLAR	2019-08-17 17:11:21.64212+03	39	11	0	CHAT YAZARLAR
266	PROGRAM YAPARLAR	2019-08-17 17:11:27.346239+03	9	11	0	PROGRAM YAPARLAR
158	Sylvester ve Tweety favorimdir ✔	2019-06-16 00:29:02.125797+03	4	10	0	Sylvester ve Tweety favorimdir ✔
161	D cocuk vardi	2019-06-16 02:07:36.32623+03	3	10	0	D cocuk vardi
267	NASIL IYIMI DERLER ISTE	2019-08-17 17:11:32.138326+03	3	11	0	NASIL IYIMI DERLER ISTE
303	Hello world	2019-08-18 03:12:10.00453+03	10	11	0	Hello world
307	Holahola xd	2019-08-18 03:16:03.355722+03	32	11	0	Holahola xd
191	Testing	2019-06-29 02:43:56.129495+03	3	10	0	Testing
192	Hola! BETA	2019-08-05 01:05:53.390967+03	6	10	0	Hola! BETA
193	TOM AND JERRY KIDS	2019-08-05 01:06:09.204764+03	10	10	0	TOM AND JERRY KIDS
199	Test asamasi devam ediyor...	2019-08-05 03:07:30.575017+03	7	11	0	Test asamasi devam ediyor...
329	Deli deli	2019-08-18 04:41:47.261142+03	5	11	0	Deli deli
330	Birakin gitsin derler	2019-08-18 04:41:54.146518+03	40	11	0	Birakin gitsin derler
334	xd	2019-08-18 04:44:43.13942+03	40	10	0	xd
338	OYKU	2019-08-18 04:46:50.067852+03	7	10	0	OYKU
339	qwerty1234	2019-08-18 04:46:58.746896+03	37	10	0	qwerty1234
344	9102	2019-08-18 04:48:40.243244+03	39	10	0	9102
345	56454456456645	2019-08-18 04:48:59.44319+03	40	10	0	56454456456645
350	gkjhsghjkslkgjhsgjklsjlkg	2019-08-18 04:50:44.924219+03	1	10	0	gkjhsghjkslkgjhsgjklsjlkg
354	DUR TABELA	2019-08-18 04:52:24.395824+03	39	10	0	DUR TABELA
358	Daha dur daha dur :D	2019-08-18 04:55:28.218883+03	37	10	0	Daha dur daha dur :D
359	Sohbet edik, nere gidin hemen uyle :D	2019-08-18 04:55:43.332987+03	3	11	0	Sohbet edik, nere gidin hemen uyle :D
363	XD	2019-08-18 18:15:13.383498+03	4	11	0	XD
395	Angular 9	2019-08-19 13:42:28.633477+03	2	11	0	Angular 9
396	XD	2019-08-19 13:42:37.516516+03	5	11	0	XD
401	hula	2019-08-19 13:47:52.332821+03	2	11	0	hula
404	qwerty	2019-08-19 13:49:37.684932+03	3	11	0	qwerty
410	Alo alo askim susma	2019-08-19 14:00:25.925324+03	5	11	0	Alo alo askim susma
411	jale de jale	2019-08-19 14:00:31.069227+03	7	11	0	jale de jale
415	Uh derler	2019-08-19 14:19:04.599347+03	10	11	0	Uh derler
416	dale dun dale	2019-08-19 14:19:08.797717+03	10	11	0	dale dun dale
425	Test	2019-08-19 14:23:35.542178+03	8	11	0	Test
207	Hello world	2019-08-17 15:47:03.963886+03	2	11	0	Hello world
211	Denemeler...	2019-08-17 15:52:38.136683+03	5	11	0	Denemeler...
215	qqq	2019-08-17 15:59:10.007519+03	32	11	0	qqq
220	Denemeler...	2019-08-17 16:03:50.247855+03	36	11	0	Denemeler...
224	yeah	2019-08-17 16:14:55.975356+03	7	11	0	yeah
228	yeah	2019-08-17 16:29:46.352631+03	32	11	0	yeah
233	yeah	2019-08-17 16:36:42.649454+03	10	11	0	yeah
234	i'm Man.	2019-08-17 16:36:51.177139+03	10	11	0	i&#39;m Man.
239	qwerty	2019-08-17 16:42:13.945694+03	32	11	0	qwerty
240	12345	2019-08-17 16:42:23.064958+03	32	11	0	12345
247	123456	2019-08-17 17:00:34.641751+03	2	11	0	123456
248	Good job	2019-08-17 17:00:44.529756+03	2	11	0	Good job
249	Please	2019-08-17 17:00:58.75339+03	2	11	0	Please
65	Daha da gelisecek	2019-02-27 03:00:19.386101+03	3	8	0	Daha da gelisecek
250	Dortmund	2019-08-17 17:01:09.665736+03	2	11	0	Dortmund
66	Evet, daha yeni emekliyoruz	2019-02-27 03:00:33.256844+03	3	8	0	Evet, daha yeni emekliyoruz
255	xd	2019-08-17 17:07:20.300972+03	9	11	0	xd
268	IYI IS DERLER	2019-08-17 17:11:50.101561+03	37	11	0	IYI IS DERLER
269	HELLO	2019-08-17 17:11:52.362143+03	3	11	0	HELLO
270	MY NAME IS	2019-08-17 17:11:53.841686+03	3	11	0	MY NAME IS
271	EMINEM	2019-08-17 17:11:55.738124+03	4	11	0	EMINEM
272	DERLER	2019-08-17 17:11:57.769989+03	36	11	0	DERLER
273	xd	2019-08-17 17:12:00.089736+03	10	11	0	xd
304	Bugs bunny	2019-08-18 03:13:15.506859+03	4	11	0	Bugs bunny
308	44	2019-08-18 03:17:28.329228+03	36	11	0	44
319	Snoop doggg.	2019-08-18 03:22:56.587506+03	5	11	0	Snoop doggg.
331	TOM AND JERRY KIDS NOSTALJI	2019-08-18 04:42:53.519834+03	5	10	0	TOM AND JERRY KIDS NOSTALJI
335	Ahaha :D	2019-08-18 04:45:17.779135+03	9	10	0	Ahaha :D
340	Hayirli gunler	2019-08-18 04:47:18.754917+03	6	10	0	Hayirli gunler
346	USER	2019-08-18 04:49:25.051094+03	6	10	0	USER
351	TEMPNATION	2019-08-18 04:50:57.619118+03	2	10	0	TEMPNATION
355	Eymen pasa 🥼	2019-08-18 04:53:42.020972+03	35	10	0	Eymen pasa 🥼
360	Youtube'dan yagmur dinliyom	2019-08-18 04:57:26.089578+03	1	11	0	Youtube&#39;dan yagmur dinliyom
364	Testing	2019-08-19 13:38:42.369724+03	10	12	0	Testing
365	Yasa	2019-08-19 13:38:54.452605+03	8	11	0	Yasa
397	HOLA 😆	2019-08-19 13:42:51.542267+03	10	11	0	HOLA 😆
402	ELSE	2019-08-19 13:48:14.645969+03	8	11	0	ELSE
405	Haydi gel	2019-08-19 13:55:23.309332+03	9	11	0	Haydi gel
406	durma gel	2019-08-19 13:55:26.149036+03	4	11	0	durma gel
407	xd	2019-08-19 13:55:31.357106+03	35	11	0	xd
412	deneme	2019-08-19 14:13:50.534331+03	10	11	0	deneme
413	123	2019-08-19 14:13:52.327866+03	10	11	0	123
417	Hola, yes!	2019-08-19 14:20:18.856306+03	10	11	0	Hola, yes!
418	Test	2019-08-19 14:20:22.299174+03	10	11	0	Test
419	qqq	2019-08-19 14:20:25.21009+03	10	11	0	qqq
420	I'm Elena	2019-08-19 14:20:49.107771+03	5	11	0	I&#39;m Elena
421	Baby'ler	2019-08-19 14:20:51.71752+03	5	11	0	Baby&#39;ler
422	XD	2019-08-19 14:20:57.502266+03	5	11	0	XD
426	123456	2019-08-19 14:23:37.54993+03	8	11	0	123456
427	987	2019-08-19 14:23:45.550946+03	8	11	0	987
431	Mesaj 1	2019-08-19 14:25:27.150311+03	39	11	0	Mesaj 1
432	mesaj 2	2019-08-19 14:25:28.734157+03	39	11	0	mesaj 2
433	mesaj 3	2019-08-19 14:25:31.501942+03	39	11	0	mesaj 3
434	mesaj 4	2019-08-19 14:25:35.137171+03	39	11	0	mesaj 4
438	oh be	2019-08-19 14:32:21.758689+03	39	11	0	oh be
439	serinlik varmis	2019-08-19 14:32:24.474388+03	39	11	0	serinlik varmis
440	xd	2019-08-19 14:32:26.726403+03	39	11	0	xd
750	Celeb celeb :)	2019-08-29 04:20:10.472143+03	5	12	0	Celeb celeb :)
761	JENNIFER ANISTON	2019-08-29 18:37:39.347853+03	5	12	0	JENNIFER ANISTON
762	DUA LIPA	2019-08-29 18:37:41.979353+03	5	12	0	DUA LIPA
763	XD	2019-08-29 18:37:44.986832+03	5	12	0	XD
768	Guzel guzel, daha iyi olabilir	2019-08-29 19:24:21.176507+03	9	12	0	Guzel guzel, daha iyi olabilir
773	CouchDB var	2019-08-29 19:29:10.334087+03	9	12	0	CouchDB var
774	Rethink db vardi ama gelistirilmiyor.	2019-08-29 19:29:25.981637+03	9	12	0	Rethink db vardi ama gelistirilmiyor.
779	Foreign Key'leri yapistirip gecicez	2019-08-29 19:41:07.293049+03	9	12	0	Foreign Key&#39;leri yapistirip gecicez
786	Cikti sanki	2019-08-29 19:47:38.471472+03	9	8	0	Cikti sanki
787	Detayli bakicam, geri donerim	2019-08-29 19:47:49.782828+03	9	8	0	Detayli bakicam, geri donerim
799	Hihi	2019-08-30 04:19:15.983136+03	5	12	0	Hihi
800	:D	2019-08-30 04:19:16.967024+03	5	12	0	:D
809	Hadi deli uglan	2019-09-02 18:47:05.57777+03	5	11	0	Hadi deli uglan
820	XD	2019-09-02 18:59:50.685472+03	7	10	0	XD
208	XD	2019-08-17 15:48:53.255853+03	35	11	0	XD
212	Lorem	2019-08-17 15:52:59.392866+03	8	11	0	Lorem
216	Chatttt.t.t	2019-08-17 15:59:52.128806+03	6	11	0	Chatttt.t.t
62	bu chat ne zaman duzgun calisacak	2019-02-27 02:23:21.711059+03	2	8	0	bu chat ne zaman duzgun calisacak
63	suan calisiyor ya	2019-02-27 02:23:58.320072+03	5	8	0	suan calisiyor ya
78	---strikeout---	2019-02-27 22:21:17.313188+03	4	8	0	---strikeout---
86	Cok uzun mesaj listesi olusturmak lazim	2019-03-01 02:55:11.183266+03	7	8	0	Cok uzun mesaj listesi olusturmak lazim
87	Open source olarak projeyi yayinlayacak miyiz?	2019-03-01 02:55:30.422922+03	9	8	0	Open source olarak projeyi yayinlayacak miyiz?
88	Bilmiyorum, daha karar verilmedi	2019-03-01 02:55:48.104874+03	2	8	0	Bilmiyorum, daha karar verilmedi
89	socket.io ile ornek cok fazla var aslinda	2019-03-01 02:56:00.790817+03	8	8	0	socket.io ile ornek cok fazla var aslinda
90	ama buyuk capli uygulama goremedim	2019-03-01 02:56:10.246932+03	2	8	0	ama buyuk capli uygulama goremedim
91	Evet, ben de goremedim.	2019-03-01 02:56:21.063005+03	4	8	0	Evet, ben de goremedim.
111	Toronto sürpriz yapabilir.	2019-05-30 21:41:14.200777+03	10	1	0	Toronto sürpriz yapabilir.
112	Sanmiyorum, KD varken 😍	2019-05-30 21:42:04.232792+03	1	1	0	Sanmiyorum, KD varken 😍
113	Leonard yok sanki 😁	2019-05-30 21:42:52.206851+03	7	1	0	Leonard yok sanki 😁
114	Iyice kizisti ortalik 🐱‍👤🐱‍🏍🐱‍🚀	2019-05-30 21:43:24.509299+03	4	1	0	Iyice kizisti ortalik 🐱‍👤🐱‍🏍🐱‍🚀
115	Deneme metinleri yaziyorum	2019-05-30 21:56:47.205619+03	35	1	0	Deneme metinleri yaziyorum
79	[link text](https://example.com "optional title")	2019-02-27 22:23:32.099639+03	4	8	0	<a href="https://example.com" title="optional title">link text</a>
76	__Italic__	2019-02-27 22:20:08.809127+03	1	8	0	<strong>Italic</strong>
77	*bold*	2019-02-27 22:20:19.953782+03	10	8	0	<em>bold</em>\r\n
85	`ctrl`	2019-03-01 02:53:12.095244+03	5	8	0	<code>ctrl</code>\r\n
120	degıl	2019-06-12 23:40:16.875759+03	35	1	0	degıl
122	dıgerı ona onerıyo	2019-06-12 23:41:57.836182+03	35	1	0	dıgerı ona onerıyo
123	felan	2019-06-12 23:42:03.084265+03	35	1	0	felan
128	derler 😀	2019-06-12 23:42:22.347616+03	35	1	0	derler 😀
126	dursun 😀	2019-06-12 23:42:14.251907+03	35	1	0	dursun 😀
127	dınlen canm	2019-06-12 23:42:17.587906+03	35	1	0	dınlen canm
124	hep ole sacmalıklar	2019-06-12 23:42:07.07558+03	35	1	0	hep ole sacmalıklar
125	bakarım bı ara sımdılık	2019-06-12 23:42:10.443723+03	35	1	0	bakarım bı ara sımdılık
132	Jetgilleri hatirlayan var mi?	2019-06-15 18:47:21.545627+03	8	10	0	Jetgilleri hatirlayan var mi?
135	Bip bip 😆	2019-06-15 18:50:19.252522+03	10	10	0	Bip bip 😆
221	Pappa...	2019-08-17 16:04:34.576866+03	5	11	0	Pappa...
225	duba	2019-08-17 16:16:21.153001+03	2	11	0	duba
229	cuppa	2019-08-17 16:34:36.051689+03	32	11	0	cuppa
235	Oh	2019-08-17 16:39:01.168851+03	32	11	0	Oh
241	Goccuk.	2019-08-17 16:43:17.065827+03	9	11	0	Goccuk.
159	Pinky ve Brain vardi 💕	2019-06-16 00:29:33.801438+03	40	10	0	Pinky ve Brain vardi 💕
242	Halo!	2019-08-17 16:43:29.105277+03	2	11	0	Halo!
243	1546456546	2019-08-17 16:43:35.2973+03	2	11	0	1546456546
251	Hello	2019-08-17 17:01:43.068596+03	1	11	0	Hello
256	Bauman	2019-08-17 17:08:01.803582+03	37	11	0	Bauman
257	Dortmund.	2019-08-17 17:08:07.457854+03	37	11	0	Dortmund.
258	Augsburg	2019-08-17 17:08:11.474384+03	37	11	0	Augsburg
274	deneme	2019-08-17 17:12:41.084453+03	32	11	0	deneme
275	bir kic	2019-08-17 17:12:42.770655+03	9	11	0	bir kic
194	Daha emekliyoruz, cok yolumuz var... Cokca...	2019-08-05 01:06:34.690904+03	10	10	0	Daha emekliyoruz, cok yolumuz var... Cokca...
276	XD	2019-08-17 17:12:46.658248+03	5	11	0	XD
197	Testing...	2019-08-05 03:06:42.583849+03	5	11	0	Testing...
200	Bla bla...	2019-08-05 03:08:42.891024+03	39	11	0	Bla bla...
277	123456	2019-08-17 17:12:52.593846+03	9	11	0	123456
278	78	2019-08-17 17:12:54.417991+03	39	11	0	78
279	gelir	2019-08-17 17:12:55.57046+03	1	11	0	gelir
280	mesajlar	2019-08-17 17:12:56.961599+03	9	11	0	mesajlar
281	ses ederler	2019-08-17 17:12:58.890575+03	8	11	0	ses ederler
282	REIS	2019-08-17 17:13:02.210047+03	7	11	0	REIS
283	LOREM IPSUM	2019-08-17 17:13:04.738268+03	40	11	0	LOREM IPSUM
284	AYNI KISI GELMEZ	2019-08-17 17:13:07.105739+03	5	11	0	AYNI KISI GELMEZ
285	HADI LA	2019-08-17 17:13:08.826116+03	40	11	0	HADI LA
286	HADI BE :D	2019-08-17 17:13:11.218186+03	36	11	0	HADI BE :D
287	gel iste derler	2019-08-17 17:13:13.970142+03	3	11	0	gel iste derler
288	gelmezler ama	2019-08-17 17:13:15.850257+03	3	11	0	gelmezler ama
289	xd	2019-08-17 17:13:17.721676+03	6	11	0	xd
290	calisirlar	2019-08-17 17:13:19.329753+03	8	11	0	calisirlar
291	xd	2019-08-17 17:13:21.234285+03	10	11	0	xd
305	Duffy duck +2	2019-08-18 03:13:52.555758+03	36	11	0	Duffy duck +2
309	45654546456	2019-08-18 03:17:51.291401+03	5	11	0	45654546456
320	Snop dog x2	2019-08-18 03:23:50.100307+03	39	11	0	Snop dog x2
321	yehhu!	2019-08-18 03:23:52.859331+03	3	11	0	yehhu!
322	it's perfecting....	2019-08-18 03:23:59.296754+03	40	11	0	it&#39;s perfecting....
332	xd	2019-08-18 04:44:07.339269+03	3	10	0	xd
336	🏀 NBA 2020	2019-08-18 04:45:53.469914+03	36	10	0	🏀 NBA 2020
341	Halo ibrahim	2019-08-18 04:47:49.23538+03	9	10	0	Halo ibrahim
347	78	2019-08-18 04:49:45.307397+03	32	10	0	78
352	SCOOBY DOO	2019-08-18 04:51:46.406935+03	37	10	0	SCOOBY DOO
356	Kate Upton Forever! 🐱‍🐉	2019-08-18 04:54:36.16698+03	40	10	0	Kate Upton Forever! 🐱‍🐉
361	Hello pappa	2019-08-18 17:10:50.537263+03	3	11	0	Hello pappa
366	XD	2019-08-19 13:41:21.059033+03	32	11	0	XD
367	ahaha	2019-08-19 13:41:23.309412+03	2	11	0	ahaha
368	hello	2019-08-19 13:41:25.028378+03	9	11	0	hello
369	world	2019-08-19 13:41:26.100304+03	7	11	0	world
370	merhaba	2019-08-19 13:41:27.780195+03	3	11	0	merhaba
371	dunya	2019-08-19 13:41:28.723894+03	9	11	0	dunya
372	testing	2019-08-19 13:41:30.140417+03	2	11	0	testing
373	domates	2019-08-19 13:41:31.86776+03	6	11	0	domates
374	biber	2019-08-19 13:41:32.788187+03	40	11	0	biber
375	patlican	2019-08-19 13:41:34.076098+03	10	11	0	patlican
376	hadi gel oynucan	2019-08-19 13:41:37.524609+03	39	11	0	hadi gel oynucan
377	genel sohbet	2019-08-19 13:41:40.044423+03	5	11	0	genel sohbet
378	deneme	2019-08-19 13:41:40.86821+03	3	11	0	deneme
398	Hoppi	2019-08-19 13:45:46.092952+03	9	11	0	Hoppi
399	Thi is perfect	2019-08-19 13:45:58.284721+03	37	11	0	Thi is perfect
751	Sinin ulsun celebler :D	2019-08-29 04:20:29.949948+03	10	12	0	Sinin ulsun celebler :D
752	Deli uglan seni	2019-08-29 04:20:36.69363+03	10	12	0	Deli uglan seni
764	Deneme	2019-08-29 19:22:09.176479+03	9	12	0	Deneme
769	Daha karar vermedik, PostgreSQL JSON destegi var, Firebase ise iyi ama pahali gelir.	2019-08-29 19:24:49.013261+03	9	12	0	Daha karar vermedik, PostgreSQL JSON destegi var, Firebase ise iyi ama pahali gelir.
775	Postgres bayagi guclu duruyor aslinda, bize yeter gibi.	2019-08-29 19:30:20.633463+03	5	12	0	Postgres bayagi guclu duruyor aslinda, bize yeter gibi.
780	Ariyorum suan	2019-08-29 19:42:39.736926+03	9	8	0	Ariyorum suan
781	404 donduren bir istek var	2019-08-29 19:42:46.47093+03	9	8	0	404 donduren bir istek var
788	Notification'dan olcagini sanmiyorum	2019-08-29 19:48:07.61553+03	9	8	0	Notification&#39;dan olcagini sanmiyorum
801	Geldim tekrardan	2019-08-31 05:08:27.596854+03	5	12	0	Geldim tekrardan
802	:D	2019-08-31 05:08:28.803312+03	5	12	0	:D
810	XD	2019-09-02 18:47:45.480651+03	5	11	0	XD
811	xxx	2019-09-02 18:47:51.206733+03	5	11	0	xxx
821	Firebase iyi ama, Turkiye destegi yeterli degil gibi.	2019-09-02 19:00:07.30582+03	7	11	0	Firebase iyi ama, Turkiye destegi yeterli degil gibi.
721	Daha neler gurucez derler	2019-08-26 16:58:53.762+03	1	11	0	Daha neler gurucez derler
722	🏀 LEBRON IS KING 🏀	2019-08-26 16:59:08.721625+03	1	11	0	🏀 LEBRON IS KING 🏀
742	Daha iyi olur	2019-08-29 03:58:36.115764+03	5	8	0	Daha iyi olur
743	herhalde	2019-08-29 03:58:37.323849+03	5	8	0	herhalde
744	iler de	2019-08-29 03:58:38.643925+03	5	8	0	iler de
745	9.0.0.0 next 4 cikti!	2019-08-29 03:58:43.755061+03	5	8	0	9.0.0.0 next 4 cikti!
753	Yeah, budur :D	2019-08-29 04:42:07.675154+03	5	11	0	Yeah, budur :D
765	EN YENI MACLAR, NESINE.COM'DA. VAR MISIN IDDIA'YA?	2019-08-29 19:22:29.177393+03	9	12	0	EN YENI MACLAR, NESINE.COM&#39;DA. VAR MISIN IDDIA&#39;YA?
770	Dogru soyluyorsun.	2019-08-29 19:27:07.70513+03	5	12	0	Dogru soyluyorsun.
776	yani, bende oyle dusunuyorum.	2019-08-29 19:37:58.663315+03	9	12	0	yani, bende oyle dusunuyorum.
782	Bende onu ariyorum.	2019-08-29 19:45:18.544271+03	5	8	0	Bende onu ariyorum.
783	Bulacagiz insallah :D	2019-08-29 19:45:32.830974+03	9	8	0	Bulacagiz insallah :D
789	Olabilirmis demek ki 	2019-08-29 19:49:46.609722+03	5	8	0	Olabilirmis demek ki 
790	Aynen, duzeldi herhalde.	2019-08-29 19:49:57.328927+03	9	8	0	Aynen, duzeldi herhalde.
791	Iyi iyi oley fixed :D	2019-08-29 19:50:03.887406+03	9	8	0	Iyi iyi oley fixed :D
796	Mecburuz yani	2019-08-29 22:24:20.602463+03	5	8	0	Mecburuz yani
803	Iyi gozukuyor suan, yakinda BETA'ya cikacaz	2019-08-31 05:24:25.587192+03	5	12	0	Iyi gozukuyor suan, yakinda BETA&#39;ya cikacaz
804	Bu projenin en onemli yani, bagcilardan cikmasi	2019-08-31 05:24:35.270897+03	5	12	0	Bu projenin en onemli yani, bagcilardan cikmasi
805	Kimsenin boyle islere imza atmamasi	2019-08-31 05:24:42.019641+03	5	12	0	Kimsenin boyle islere imza atmamasi
806	Tasarim olarak zaten harika gozukuyor.	2019-08-31 05:24:47.539798+03	5	12	0	Tasarim olarak zaten harika gozukuyor.
812	Haha	2019-09-02 18:48:14.754372+03	5	11	0	Haha
822	Eski cizgi filmlerin yerini tutan yuk	2019-09-02 19:06:58.753491+03	7	10	0	Eski cizgi filmlerin yerini tutan yuk
723	![yay!](https://scontent-vie1-1.cdninstagram.com/vp/006a6d3e5eeaa424bc14d62124c6305e/5DF34628/t51.2885-15/sh0.08/e35/p640x640/67083466_663848770779013_4488084650531011119_n.jpg?_nc_ht=scontent-vie1-1.cdninstagram.com)	2019-08-26 17:04:04.255751+03	1	8	1	<img src="https://scontent-vie1-1.cdninstagram.com/vp/006a6d3e5eeaa424bc14d62124c6305e/5DF34628/t51.2885-15/sh0.08/e35/p640x640/67083466_663848770779013_4488084650531011119_n.jpg?_nc_ht=scontent-vie1-1.cdninstagram.com" alt="yay!">
746	Kullanak, buglari raporlayak hadi 😎	2019-08-29 03:58:58.935267+03	5	8	0	Kullanak, buglari raporlayak hadi 😎
754	Hidi dili uglan	2019-08-29 15:53:36.221252+03	5	11	0	Hidi dili uglan
755	hadi belime dulan	2019-08-29 15:53:38.410752+03	5	11	0	hadi belime dulan
756	hele bir up bakalim, kizi dudadindan...	2019-08-29 15:53:47.682209+03	5	11	0	hele bir up bakalim, kizi dudadindan...
757	xd	2019-08-29 15:53:48.002093+03	5	11	0	xd
758	x	2019-08-29 15:53:48.290817+03	5	11	0	x
759	d	2019-08-29 15:53:48.578024+03	5	11	0	d
766	Ahaha 😆	2019-08-29 19:23:13.109581+03	9	12	0	Ahaha 😆
771	Baska alternatif var mi?	2019-08-29 19:27:25.101357+03	5	12	0	Baska alternatif var mi?
777	iliskisel veritabani olmasi daha iyi	2019-08-29 19:40:10.537774+03	9	12	0	iliskisel veritabani olmasi daha iyi
784	Ipucu yok	2019-08-29 19:46:33.99056+03	9	8	0	Ipucu yok
792	Guzel guzel, yakinda BETA'ya cikariz	2019-08-29 19:58:10.816867+03	9	8	0	Guzel guzel, yakinda BETA&#39;ya cikariz
797	Biran once yayina almamiz gerekli	2019-08-29 22:24:33.881183+03	5	8	0	Biran once yayina almamiz gerekli
807	Testing	2019-09-02 03:51:58.396778+03	5	8	0	Testing
813	Yes	2019-09-02 18:49:21.782898+03	7	11	0	Yes
814	Iste bu dedim :D	2019-09-02 18:49:25.765654+03	7	11	0	Iste bu dedim :D
815	Iyi iyi	2019-09-02 18:49:30.715564+03	7	11	0	Iyi iyi
816	Dur	2019-09-02 18:49:33.118392+03	7	11	0	Dur
817	XD	2019-09-02 18:49:39.126518+03	7	11	0	XD
818	dghdhrdhhd	2019-09-02 18:49:42.16623+03	7	11	0	dghdhrdhhd
\.


--
-- Data for Name: messages_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages_types (id, title) FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, "userId", "receiverId", content, "creationTime", "isRead") FROM stdin;
2	1	5	Katerina, xd2	2019-08-26 17:27:29.089369+03	\N
1	2	5	Katerina, yorumunu beğendi	2019-06-17 21:03:30.557529+03	\N
3	3	5	Katerina, xd3	2019-08-26 17:27:29.089369+03	\N
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, title, content, "creationTime", "userId", "viewCount", tags, "acceptedAnswerID", "acceptedAnswerTime", "modifiedDate") FROM stdin;
38	array içinde azaltma ve artırma işlemi	<p>Merhaba herkese. Şöyle bir işlemim var.</p>\n<pre><code class="language-php">-&gt;set(array(\n    &#39;heart_count&#39; =&gt; $row[&#39;heart_count&#39;]--\n));</code></pre>\n<p>Burada <strong>heart_count</strong> nasıl bir eklerim ve ya azaltırım?</p>\n	2019-04-20 19:33:09.980332+03	5	0	{2}	\N	\N	\N
54	Rotate image with javascript	<p>I need to rotate an image with javascript in 90-degree intervals. I have tried a few libraries like <a href="http://code.google.com/p/jqueryrotate/">jQuery rotate</a> and <a href="http://raphaeljs.com/image-rotation.html">Raphaël</a>, but they have the same problem - The image is rotated around its center. I have a bunch of content on all sides of the image, and if the image isn&#39;t perfectly square, parts of it will end up on top of that content. I want the image to stay inside its parent div, which has max-with and max-height set.</p>\n<p>Using jQuery rotate like this (<a href="http://jsfiddle.net/s6zSn/1073/">http://jsfiddle.net/s6zSn/1073/</a>):</p>\n<pre><code>var angle = 0;\n$(&#39;#button&#39;).on(&#39;click&#39;, function() {\n    angle += 90;\n    $(&quot;#image&quot;).rotate(angle);\n});</code></pre><p>Results in this:</p>\n<p><img src="http://i.stack.imgur.com/2pu8l.png" alt="How jQuery rotate works"></p>\n<p>And this is the result i would like instead:</p>\n<p><img src="http://i.stack.imgur.com/mD86F.png" alt="How I would like it to work"></p>\n<p>Anyone have an idea on how to accomplish this?</p>\n	2019-08-07 18:03:42.306192+03	7	19	{5,23}	\N	\N	\N
76	BehaviorSubject vs Observable?	<p>I&#39;m looking into Angular RxJs patterns and I don&#39;t understand the difference between a <code>BehaviorSubject</code> and an <code>Observable</code>.</p>\n<p>From my understanding, a <code>BehaviorSubject</code> is a value that can change over time (can be subscribed to and subscribers can receive updated results). This seems to be the exact same purpose of an <code>Observable</code>.\nWhen would you use an <code>Observable</code> vs a <code>BehaviorSubject</code>? Are there benefits to using a <code>BehaviorSubject</code> over an <code>Observable</code> or vice versa?</p>\n	2019-08-29 14:11:36.497042+03	1	128	{1}	\N	\N	\N
28	Node.js client for a socket.io server	<p>I have a socket.io server running and a matching webpage with a socket.io.js client. All works fine.</p>\n<p>But, I am wondering if it is possible, on another machine, to run a separate node.js application which would act as a client and connect to the mentioned socket.io server?</p>\n	2019-03-13 20:41:27.064755+03	8	5	{10,12}	23	2019-03-13 20:42:27.679022+03	\N
39	Example HTML Page	<pre><code class="language-html">&lt;!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD HTML 3.2//EN&quot;&gt;\n&lt;!--\n*        Sample comment\n--&gt;\n&lt;HTML&gt;\n&lt;head&gt;\n&lt;title&gt;WebStorm&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n&lt;h1&gt;WebStorm&lt;/h1&gt;\n&lt;p&gt;&lt;br&gt;&lt;b&gt;&lt;IMG border=0 height=12 src=&quot;images/hg.gif&quot; width=18 &gt;\nWhat is WebStorm? &amp;#x00B7; &amp;Alpha; &lt;/b&gt;&lt;br&gt;&lt;br&gt;\n&lt;/body&gt;\n&lt;/html&gt;</code></pre>\n	2019-04-20 19:44:30.045118+03	40	3	{15}	\N	\N	\N
27	Synchronously download an image from URL	<p>I just want to get a BitmapImage from a internet URL, but my function doesn&#39;t seem to work properly, it only return me a small part of the image. I know WebResponse is working async and that&#39;s certainly why I have this problem, but how can I do it synchronously?</p>\n<pre><code>    internal static BitmapImage GetImageFromUrl(string url)\n    {\n        Uri urlUri = new Uri(url);\n        WebRequest webRequest = WebRequest.CreateDefault(urlUri);\n        webRequest.ContentType = &quot;image/jpeg&quot;;\n        WebResponse webResponse = webRequest.GetResponse();\n\n        BitmapImage image = new BitmapImage();\n        image.BeginInit();\n        image.StreamSource = webResponse.GetResponseStream();\n        image.EndInit();\n\n        return image;\n    }</code></pre>	2019-03-13 20:06:37.886211+03	3	622	{14}	\N	\N	2019-03-13 20:07:32.12554+03
33	Save user data in Angular application	<p>I have Angular + Firebase application, where I used auth service from Firebase. And I&#39;m looking for a best way to store user data after login.</p>\n<p>What is the best way:</p>\n<ol>\n<li>Save user data to cookies, and clear them after sign-out </li>\n<li>Save user data to localstorage</li>\n<li>Save user data to global variable in service, and share this service between components</li>\n</ol>\n<p>Thanks in advance for any opinion, and appreciate for you to sharing your experience.</p>\n	2019-04-10 06:16:02.958844+03	32	2	{5,1,18}	\N	\N	\N
31	Detect when an HTML5 video finishes	<p>How do you detect when a HTML5 <code>&lt;video&gt;</code> element has finished playing?</p>\n	2019-03-14 21:45:20.708394+03	6	40	{15}	29	2019-03-18 18:43:42.949314+03	\N
36	Stop node.js program from command line	<p>I have a simple TCP server that listens on a port.</p>\n<pre><code>var net = require(&quot;net&quot;);\n\nvar server = net.createServer(function(socket) {\n    socket.end(&quot;Hello!\\n&quot;);\n});\n\nserver.listen(7777);</code></pre><p>I start it with <code>node server.js</code> and then close it with Ctrl + Z on Mac. When I try to run it again with <code>node server.js</code> I get this error message:</p>\n<pre><code>node.js:201\n        throw e; // process.nextTick error, or &#39;error&#39; event on first tick\n          ^\nError: listen EADDRINUSE\nat errnoException (net.js:670:11)\nat Array.0 (net.js:771:26)\nat EventEmitter._tickCallback (node.js:192:41)</code></pre><p>Am I closing the program the wrong way? How can I prevent this from happening?</p>\n	2019-04-12 07:43:12.93753+03	39	0	{10}	\N	\N	\N
37	Get the full URL in PHP	<p>I use this code to get the full URL:</p>\n<pre><code class="language-php">$actual_link = &#39;http://&#39;.$_SERVER[&#39;HTTP_HOST&#39;].$_SERVER[&#39;PHP_SELF&#39;];</code></pre>\n<p>The problem is that I use some masks in my .htaccess, so what we see in the URL is not always the real path of the file.</p>\n<p>What I need is to get the URL, what is written in the URL, nothing more and nothing less—the full URL.</p>\n<p>I need to get how it appears in the Navigation Bar in the web browser, and not the real path of the file on the server.</p>\n	2019-04-20 09:20:39.431115+03	40	1	{2}	\N	\N	\N
50	redundant HTML notifications by several tabs	<p>my pages using socket.io for real-time notification. it works well. however, opening several tabs (i.e. <a href="https://mypage.com/">https://mypage.com/</a>, <a href="https://mypage.com/settings">https://mypage.com/settings</a>, <a href="https://mypage.com/list">https://mypage.com/list</a>) cause multiple notifications. </p>\n<p>i knew facebook web using notification for new post or new messages, and that notification are unique. (in spite of several tabs!) i wonder how it possible.</p>\n<p>i tried sockets classify by ip and send one notification to one of them. but it is not gorgeous. </p>\n<p>is there any other methods or strategy for unique notification?</p>\n	2019-08-07 17:47:58.063232+03	5	1	{1,2,3}	\N	\N	\N
58	Best way to select random rows PostgreSQL	<p>I want a random selection of rows in PostgreSQL, I tried this:</p>\n<pre><code>select * from table where random() &lt; 0.01;</code></pre><p>But some other recommend this:</p>\n<pre><code>select * from table order by random() limit 1000;</code></pre><p>I have a very large table with 500 Million rows, I want it to be fast.</p>\n<p>Which approach is better?  What are the differences?  What is the best way to select random rows?</p>\n	2019-08-11 23:15:50.590846+03	1	16	{1,2,3}	\N	\N	\N
35	How to rate limit a node.js API that uses JWT?	<p>I have a node.js application that runs on different servers/containers. Clients are authenticated with JWT tokens. I want to protect this API from DDos attacks. User usage limit settings can be stored in the token. I&#39;ve been thinking about som approaches:</p>\n<ul>\n<li>Increment counters in a memory database like redis or memcached and check it on every request. Could cause bottlenecks?.</li>\n<li>Do something in a nginx server (is it possible?)</li>\n<li>Use some cloud based solution (AWS WAF? Cloudfront? API Gateway? Do they do what I want?)</li>\n</ul>\n<p>How to solve this?</p>\n	2019-04-12 05:05:22.60693+03	36	1	{10}	\N	\N	\N
45	Playing audio with Javascript?	<p>I am making a game with HTML5 and Javascript.</p>\n<p>How could I play game audio via Javascript?</p>\n	2019-06-13 15:49:15.889677+03	2	30	{1,2,3}	\N	\N	\N
42	How to import MatButtonModule in angular 8, with ivy renderer?	<p>In Angular 8 version people suggesting to render component directly rather to bootstrap AppModule.</p>\n<p>main.ts</p>\n<p><code>renderComponent(AppComponent);</code></p>\n<hr>\n<p>and for injecting module dependency, Add module code to the component file, like below code</p>\n<p>app.component.ts</p>\n<pre><code class="language-typescript">    @Component({\n      selector: &#39;app-root&#39;,\n      templateUrl: &#39;app.component.html&#39;\n    })\n    export class AppComponent {\n    }\n\n    @NgModule({\n      declarations: [\n        AppComponent\n      ],\n      imports: [\n        CommonModule,\n        MatButtonModule\n      ],\n      providers: [],\n      bootstrap: [AppComponent]\n    })\n    export class AppModule {\n    }</code></pre>\n<p>But while importing MatButtonModule, it&#39;s giving error <code>must be called from an injection context</code></p>\n<p>So how to solve this issue.</p>\n	2019-04-20 20:43:15.215062+03	40	5	{1}	\N	\N	\N
46	How do I wrap text in a pre tag?	<p><code>pre</code> tags are super-useful for code blocks in HTML and for debugging output while writing scripts, but how do I make the text word-wrap instead of printing out one long line?</p>\n	2019-06-13 20:02:18.399209+03	10	3	{3}	\N	\N	\N
48	How to go back last page	<p>Açısal 2&#39;deki son sayfaya geri dönmenin akıllıca bir yolu var mı?</p>\n<p>Gibi bir şey</p>\n<pre><code>this._router.navigate (LASTPAGE);</code></pre><p>Örneğin, C sayfasında bir <kbd> Geri Dön </kbd> düğmesi var,</p>\n<ul>\n<li><p>Sayfa A -&gt; Sayfa C, sayfa A&#39;ya tıklayın.</p>\n</li>\n<li><p>Sayfa B -&gt; Sayfa C, sayfa B&#39;ye tıklayın.</p>\n</li>\n</ul>\n<p>Yönlendirici bu geçmiş bilgisine sahip mi?</p>\n	2019-06-17 23:15:55.168435+03	36	23	{1}	\N	\N	\N
43	Caddy webserver Brotli example	<p>I was trying to deploy my angular2 app with brotli compressed distribution to Caddy webserver.</p>\n<p>Are there any examples for the caddy webserver with Brotli compression support?</p>\n	2019-05-31 00:55:02.510988+03	35	3	{1,2,3}	\N	\N	\N
73	How do you wrap div block with a link?	<p>I&#39;ve found that in html5 standart it is possible to wrap any kind of tag (div, img, other a(href=&quot;&quot;)) inside tag <a>.\nBut in real world that doesn&#39;t work as supposed</p>\n<pre><code class="language-html">&lt;a href=&quot;/contact&quot;&gt;\n    &lt;div&gt; Test test &lt;/div&gt;\n    &lt;div class=&quot;menu&quot;&gt;\n        &lt;h3&gt; Point 1\n        &lt;h3&gt; Point 1\n    &lt;/div&gt;\n&lt;/a&gt;</code></pre>\n<p>Produces a very strange DOM code in both Opera and Chrome. \nIt gives me this DOM code:</p>\n<pre><code class="language-html">&lt;a href=&quot;/contact&quot;&gt;&lt;/a&gt;\n    &lt;div&gt; Test test &lt;/div&gt;\n    &lt;div class=&quot;menu&quot;&gt;\n        &lt;a href=&quot;/contact&quot;&gt;&lt;/a&gt;\n        &lt;h3&gt; Point 1\n        &lt;h3&gt; Point 1\n    &lt;/div&gt;\n</code></pre>\n<p>Cuts <a> tag to have nothing inside of it and clones it somewhy to put it inside &quot;menu&quot; div tag.</p>\n<p>So how to correctly wrap a div block with a link tag in 2k19 ?\nI&#39;ve tried adding display: block to a link tag - no help</p>\n	2019-08-26 02:38:08.050181+03	5	81	{26,3}	\N	\N	\N
55	Property 'files' does not exist on type 'EventTarget' error in typescript	<p>I am trying to access the value of the input file from my ionic 2 application but still I&#39;m facing the issue of property files does not exist on type &#39;EventTarget&#39;.\nAs it is properly working in js but not in typescript.\nThe code is given below:</p>\n<pre><code>  document.getElementById(&quot;customimage&quot;).onchange= function(e?) {\n            var files: any = e.target.files[0]; \n              EXIF.getData(e.target.files[0], function() {\n                  alert(EXIF.getTag(this,&quot;GPSLatitude&quot;));\n              });\n          }</code></pre><p>Please help me solve this issue as it is not building my ionic 2 application. </p>\n	2019-08-11 00:15:07.649934+03	5	100	{1,22}	\N	\N	\N
51	Best way to send data from server to frontend in real time (MEAN)	<p>I&#39;m creating a nodejs (10.16) and angular(8) app whichs is intended to generate and mail png files based on a list. The user is supposed to enter to the principal page and load an excel file, then the app reads this file and turns it into an array like:</p>\n<pre><code>list = [\n  [name1, email1@mail.com]\n  [name2, email2@mail.com]\n  [        ...           ]\n  [namex, emailx@mail.com]\n]</code></pre><p>Which is shown through a table as shown bellow:</p>\n<p><a href="https://i.stack.imgur.com/NAj5w.jpg"><img src="https://i.stack.imgur.com/NAj5w.jpg" alt="enter image description here"></a></p>\n<p>Then, when the user clicks on the send button, the app creates the png files and send them to the given emails. This whole process (since the user clicks on send and when the server finishes to send the last email) can take 1-3 seconds with each mail, so if the user provides 10 mails, the process can take 30 seconds.</p>\n<p>So what I want to do is to show a progress bar or some sort of notification mechanism to show the user which element is being handled and how many mails are pending to send in real time.</p>\n<p>The matter is that , for example, I can show the names and emails when the user selects an excel file because what I do is to upload the file to the server (backend) and then it returns one specific response (a json actually) which can be handled in the frontend, but it is just one element that doesn&#39;t change with time.</p>\n<p>So the question is, what resource/mechanism would you recomend me to send data from the backend to the frontend in real time? At this way I should be able to show what resource is being handled in real time.</p>\n<p>I&#39;ve researched a little and found info about Server Sent Events and Websockets but I really want to know if those are correct approaches and what alternatives should I have to consider.</p>\n<p>Thanks!</p>\n	2019-08-07 17:50:47.28878+03	4	1	{1,2,3}	\N	\N	\N
62	Treeshaking * imports with Angular?	<p>If we import material modules like this:</p>\n<pre><code>import * as material from &#39;@angular/material&#39;;\nlet materialModules = [material.MatBadgeModule];</code></pre><p>Now we would use the <code>materialModules</code> array for our shared material module import / export declarations.</p>\n<p>If we do it like this will Angular import all material modules with the application, or will it only include the ones that are declared in <code>NgModule</code>s import and export declarations?</p>\n	2019-08-14 02:21:58.564937+03	9	17	{5,1,22}	\N	\N	\N
61	How disable “defer” in angular build?	<p>When i build my angular project, the compiler put the &quot;defer&quot; attribute in &quot;index.html&quot; but i need to disable this. Is it possible? </p>\n<p>Im using angular 8.0.0.</p>\n<pre><code>&lt;pre&gt;\n    &lt;script src=&quot;runtime.js&quot; defer&gt;\n&lt;/pre&gt;</code></pre>	2019-08-14 02:17:00.466215+03	2	10	{1,22}	\N	\N	\N
56	nodejs express 3.0	<p>I have a nodejs express 2.0 application and I want to use express 3.0 within it. Tell me please which is state of express 3.0 at now and is there examples of express 3.0 applications?</p>\n<p>I saw connect 2.0 has been released, so can I use it with express 2.0 ?</p>\n	2019-08-11 00:58:33.697856+03	8	21	{10,21}	\N	\N	\N
52	Websockets, socket.io, nodejs, and security	<p>I am working on a real-time analytics application and am using websockets (through the socket.io library) along with nodejs. There will be no &quot;sensitive&quot; data being sent through the websockets (like names, addresses, etc). It will be only used to track visits and to track the total visitors (along with the number of visitors on the top 10 most visited URLs).</p>\n<p>Are there any security issues that I should be aware of? Am I opening myself up to:</p>\n<ol>\n<li>DoS attacks?</li>\n<li>XSS attacks?</li>\n<li>Additional security holes that could be used to gain access to the webserver/webserver&#39;s LAN?</li>\n<li>Anything else I didn&#39;t mention here?</li>\n</ol>\n<p>Thanks!</p>\n	2019-08-07 17:51:51.426897+03	6	1	{1,2,3}	\N	\N	\N
78	Node.js + Nginx - What now?	<p>I&#39;ve set up Node.js and Nginx on my server. Now I want to use it, but, before I start there are 2 questions:</p>\n<ol>\n<li><p>How should they work together? How should I handle the requests?</p>\n</li>\n<li><p>There are 2 concepts for a Node.js server, which one is better:   </p>\n<p> a. Create a separate HTTP server for each website that needs it. Then load all JavaScript code at the start of the program, so the code is interpreted once.</p>\n<p> b. Create one single Node.js server which handles all Node.js requests. This reads the requested files and evals their contents. So the files are interpreted on each request, but the server logic is much simpler.</p>\n</li>\n</ol>\n<p>It&#39;s not clear for me how to use Node.js correctly.</p>\n	2019-09-01 22:09:34.023855+03	7	378	{10,28}	\N	\N	\N
53	Render JSON into HTML	<p>I get JSON data with next code:    </p>\n<pre><code>$.getJSON(\n     &quot;data.json&quot;,function foo(result) {\n       $.each(result[1].data.children.slice(0, 10),\n        function (i, post) {\n          $(&quot;#content&quot;).append( &#39;&lt;br&gt; HTML &lt;br&gt;&#39; + post.data.body_html );       \n        }\n      )\n    }\n )\n\n &lt;div id=&quot;content&quot;&gt;&lt;/div&gt;</code></pre><p>Some of strings included : <code>&amp;lt;</code> and <code>&amp;gt;</code> and this did not displaying as regular html <code>&lt;</code>, <code>&gt;</code>\nTry to use <code>.html()</code> instead <code>.append()</code>  did not work.</p>\n<p>Here is live example <a href="http://jsfiddle.net/u6yUN/">http://jsfiddle.net/u6yUN/</a></p>\n	2019-08-07 18:01:33.534007+03	1	19	{1,2,3}	\N	\N	\N
72	CSS: Div only as wide as floated children	<p>I am currently working on an overview about some products. They are loaded from database therefore the number of them varies. I have a big &quot;productContainer&quot; which holds all of those products. As you know display-size varies and therefore the amount of products per row is different. This is not a problem, but I want them to be centered in this case (right now I have white space on the right, because no new product fits there). I managed to center them via inline-block but this makes the last row look weird, since it isn&#39;t filled with products and still centered with lots of space between products. If I float them to the left the last row is great but the items which are in a &quot;full&quot; row are not centered (again space on the right).</p>\n<p>It would be great if the &quot;productContainer&quot; would be as wide as the floated elements inside (I do not know the amount of them). If I do not float my elemnts, the parent div is exactly as wide as -one- element (which is great). When I start floating my elements, the Container jumps to 100% width instantly, instead of the width which would be enought for X elements. (After that I could obviously easy center the Container with margin: 0 auto, but this will not work with 100% width.)</p>\n<p>Thanks for your help!!</p>\n	2019-08-26 02:25:53.778969+03	1	38	{26,3}	\N	\N	\N
44	Django index url is disabling api urls	<p>integrating Angular with Django, server is receiving request from frontend but I can&#39;t handle them, because they doesn&#39;t reach target function</p>\n<p>here is views.py:</p>\n<pre><code>class VView(viewsets.ModelViewSet):\n        queryset = User.objects.all()\n        serializer_class = UserSerializer\n\ndef index(request):\n    return render(request, &#39;index.html&#39;)\n\n@permission_classes((permissions.AllowAny))\nclass Login(APIView):\n   def post(self, request)\n       return JsonRespone({&quot;some&quot;:&quot;data&quot;}, status=200)</code></pre><p>here are my urls.py</p>\n<pre><code>urlpatterns = [\n  url(r&#39;^admin/&#39;, admin.site.urls),\n  url(&#39;&#39;, index),\n  url(&#39;user/login&#39;,Login.as_view()),\n  url(&#39;user/registration&#39;,Login.as_view()),\n]</code></pre><p>and the thing is when send request now for <code>user/login</code> server doesn&#39;t respond with json as it should but when i comment out or delete my index url \nso I have:</p>\n<pre><code>urlpatterns = [\n  url(r&#39;^admin/&#39;, admin.site.urls),\n  url(&#39;user/login&#39;,Login.as_view()),\n  url(&#39;user/registration&#39;,Login.as_view()),\n]</code></pre><p>everything works fine I get responses from server when I am using Postman for that, or run frontend on another localhost, but the problem is that server doesn&#39;t render webpage, when I access it by localhost:8000</p>\n	2019-06-03 23:12:19.746933+03	5	1	{20}	\N	\N	\N
32	How do I fix this issue I'm having with my lowercase function	<p>I&#39;m trying to make a function that goes through a linked list and finds all strings that contain a substring that the user inputs.</p>\n<p>The problem is that its case sensitive and I need it to not be.\nMy idea was to make everything lowercase while going through the list. And wrote something that should work... I think... but doesn&#39;t</p>\n<pre><code>char *lowerCase(char* strToLower){\n    char *lowCase;\n    strcpy(lowCase, strToLower);\n    for(int i = 0; lowCase[i]; i++){\n       lowCase[i] = tolower(lowCase[i]);\n    }\n    return lowCase;\n}</code></pre><pre><code>printf(&quot;%s&quot;, lowerCase(&quot;Name&quot;));</code></pre><p>Now, what ideally should pop up is &quot;name&quot;, but I instead get nothing.</p>\n<p>I get Process returned -1073741819 (0xC0000005), which I think is an error related to pointers or memory? I don&#39;t really know because build log doesn&#39;t tell me anything.</p>\n<p>Any help is appreciated &lt;3</p>\n	2019-04-10 00:54:51.489059+03	30	5	{16,17}	\N	\N	\N
77	Using Node.js require vs. ES6 import/export	<p>In a project I&#39;m collaborating on, we have two choices on which module system we can use:</p>\n<ol>\n<li>Importing modules using <code>require</code>, and exporting using <code>module.exports</code> and <code>exports.foo</code>.</li>\n<li>Importing modules using ES6 <code>import</code>, and exporting using ES6 <code>export</code></li>\n</ol>\n<p>Are there any performance benefits to using one over the other? Is there anything else that we should know if we were to use ES6 modules over Node ones?</p>\n	2019-08-31 04:51:35.696072+03	8	48	{5,10}	\N	\N	\N
67	Javascript: How to get multiple matches in RegEx .exec results	<p>When I run</p>\n<pre><code>/(a)/g.exec(&#39;a a a &#39;).length</code></pre><p>I get </p>\n<pre><code>2</code></pre><p>but I thought it should return</p>\n<pre><code>3</code></pre><p>because there are 3 <code>a</code>s in the string, not 2!</p>\n<p>Why is that?</p>\n<p>I want to be able to search for all occurances of a string in RegEx and iterate over them.</p>\n<p>FWIW: I&#39;m using node.js</p>\n	2019-08-21 19:43:40.383222+03	4	59	{5,27}	\N	\N	\N
70	What is the difference between Promises and Observables?	<p>Can someone please explain the difference between <code>Promise</code> and <code>Observable</code> in Angular?</p>\n<p>An example on each would be helpful in understanding both the cases.\nIn what scenario can we use each case?</p>\n	2019-08-23 01:22:21.168631+03	6	69	{1}	\N	\N	\N
49	bodyParser is deprecated express 4	<p>I am using express 4.0 and I&#39;m aware that body parser has been taken out of the express core, I am using the recommended replacement, however I am getting </p>\n<p><code>body-parser deprecated bodyParser: use individual json/urlencoded middlewares server.js:15:12\nbody-parser deprecated urlencoded: explicitly specify &quot;extended: true&quot; for extended parsing node_modules/body-parser/index.js:74:29</code></p>\n<p>Where do I find this supposed middlewares? or should I not be getting this error?</p>\n<pre><code>var express     = require(&#39;express&#39;);\nvar server         = express();\nvar bodyParser     = require(&#39;body-parser&#39;);\nvar mongoose     = require(&#39;mongoose&#39;);\nvar passport    = require(&#39;./config/passport&#39;);\nvar routes        = require(&#39;./routes&#39;);\n\nmongoose.connect(&#39;mongodb://localhost/myapp&#39;, function(err) {\n    if(err) throw err;\n});\n\nserver.set(&#39;view engine&#39;, &#39;jade&#39;);\nserver.set(&#39;views&#39;, __dirname + &#39;/views&#39;);\n\nserver.use(bodyParser()); \nserver.use(passport.initialize());\n\n// Application Level Routes\nroutes(server, passport);\n\nserver.use(express.static(__dirname + &#39;/public&#39;));\n\nserver.listen(3000);</code></pre>	2019-07-23 15:59:26.642109+03	5	10	{2,1,3}	\N	\N	\N
34	Changing background color in outline input field	<p>Hey guys I want to change the background color of my searchbar. It has the <code>appearance=&quot;outline&quot;</code> and I like the design but like you see if I set a new color it goes over the borders and looks ugly. What can I do here?</p>\n<p>My css:</p>\n<pre><code>::ng-deep .mat-form-field-appearance-outline .mat-form-field-infix {\n  padding: 5%;\n}\n\n::ng-deep .mat-form-field-infix {\n  top: -3px;\n}\n\n::ng-deep .mat-form-field-appearance-outline .mat-form-field-outline {\n  background-color: white;\n}</code></pre><p>My html:</p>\n<pre><code>&lt;mat-form-field style=&quot;width:110%;&quot; appearance=&quot;outline&quot; &gt;\n    &lt;mat-icon matPrefix&gt;search&lt;/mat-icon&gt;\n    &lt;input type=&quot;search&quot; name=&quot;test&quot; [(ngModel)]=&quot;searchText&quot;\n    placeholder=&quot;Search&quot; aria-label=&quot;Search&quot; matInput&gt;\n&lt;/mat-form-field&gt;</code></pre><p><a href="https://i.stack.imgur.com/EGCee.png"><img src="https://i.stack.imgur.com/EGCee.png" alt="enter image description here"></a></p>\n	2019-04-12 01:37:44.857477+03	35	2	{1,3}	\N	\N	\N
63	How can I upload files asynchronously?	<p>I would like to upload a file asynchronously with jQuery. This is my HTML:</p>\n<pre><code>&lt;span&gt;File&lt;/span&gt;\n&lt;input type=&quot;file&quot; id=&quot;file&quot; name=&quot;file&quot; size=&quot;10&quot;/&gt;\n&lt;input id=&quot;uploadbutton&quot; type=&quot;button&quot; value=&quot;Upload&quot;/&gt;</code></pre><p>And here my <code>Jquery</code> code:</p>\n<pre><code>$(document).ready(function () {\n    $(&quot;#uploadbutton&quot;).click(function () {\n        var filename = $(&quot;#file&quot;).val();\n\n        $.ajax({\n            type: &quot;POST&quot;,\n            url: &quot;addFile.do&quot;,\n            enctype: &#39;multipart/form-data&#39;,\n            data: {\n                file: filename\n            },\n            success: function () {\n                alert(&quot;Data Uploaded: &quot;);\n            }\n        });\n    });\n});</code></pre><p>Instead of the file being uploaded, I am only getting the filename. What can I do to fix this problem?</p>\n<h3 id="current-solution">Current Solution</h3>\n<p>I am using the <a href="http://malsup.com/jquery/form/#code-samples">jQuery Form Plugin</a> to upload files.</p>\n	2019-08-14 02:26:39.249419+03	9	74	{5,23,4}	\N	\N	\N
71	HTML img scaling	<p>I&#39;m trying to display some large images with HTML img tags. At the moment they go off the edge of the screen; how can I scale them to stay within the browser window?</p>\n<p>Or in the likely event that this is not possible, is it possible to at least say &quot;display this image at 50% of its normal width and height&quot;?</p>\n<p>The width and height attributes distort the image -- as far as I can tell, this is because they refer to whatever attributes the container may end up with, which will be unrelated to the image. I can&#39;t specify pixels because I have to deal with a large collection of images each with a different pixel size. Max-width doesn&#39;t work.</p>\n	2019-08-23 14:38:53.408908+03	1	132	{26}	\N	\N	\N
29	Socket.io client served from CDN	<p>According to the Socket.io documentation:</p>\n<blockquote>\n<p>A standalone build of socket.io-client is exposed automatically by the socket.io server as /socket.io/socket.io.js. Alternatively you can serve the file socket.io-client.js found at the root of this repository.</p>\n</blockquote>\n<pre><code>&lt;script src=&quot;/socket.io/socket.io.js&quot;&gt;&lt;/script&gt;\n&lt;script&gt;\n    var socket = io(&#39;http://localhost&#39;);\n    socket.on(&#39;connect&#39;, function(){\n    socket.on(&#39;event&#39;, function(data){});\n    socket.on(&#39;disconnect&#39;, function(){});\n  });\n&lt;/script&gt;</code></pre><p>However, I would like to serve the socket.io client from a separate CDN (it&#39;s cheaper, faster, and reduces load on my server).</p>\n<p>How can I do this?  Do I have to disable the socket.io default?</p>\n	2019-03-13 20:46:03.24739+03	10	2	{12}	\N	\N	\N
79	How to manage a redirect request after a jQuery Ajax call	<p>I&#39;m using <code>$.post()</code> to call a servlet using Ajax and then using the resulting HTML fragment to replace a <code>div</code> element in the user&#39;s current page. However, if the session times out, the server sends a redirect directive to send the user to the login page. In this case, jQuery is replacing the <code>div</code> element with the contents of the login page, forcing the user&#39;s eyes to witness a rare scene indeed. </p>\n<p>How can I manage a redirect directive from an Ajax call with jQuery 1.2.6?</p>\n	2019-09-13 04:55:25.777156+03	1	5	{5,23}	\N	\N	\N
74	How do I redirect to another webpage?	<p>How can I redirect the user from one page to another using jQuery or pure JavaScript?</p>\n	2019-08-26 17:35:37.048345+03	5	198	{5,23}	\N	\N	\N
68	PUT vs. POST in REST	<p>According to the HTTP/1.1 Spec: </p>\n<blockquote>\n<p>The <strong><code>POST</code></strong> method is used to request that the origin server accept the entity enclosed in the request as a new subordinate of the resource identified by the <code>Request-URI</code> in the <code>Request-Line</code></p>\n</blockquote>\n<p>In other words, <code>POST</code> is used to <strong>create</strong>.</p>\n<blockquote>\n<p>The <strong><code>PUT</code></strong> method requests that the enclosed entity be stored under the supplied <code>Request-URI</code>. If the <code>Request-URI</code> refers to an already existing resource, the enclosed entity SHOULD be considered as a modified version of the one residing on the origin server. If the <code>Request-URI</code> does not point to an existing resource, and that URI is capable of being defined as a new resource by the requesting user agent, the origin server can create the resource with that URI.&quot;</p>\n</blockquote>\n<p>That is, <code>PUT</code> is used to <strong>create or update</strong>.</p>\n<p>So, which one should be used to create a resource? Or one needs to support both?</p>\n	2019-08-21 22:27:01.316474+03	4	121	{15}	\N	\N	\N
75	Send data to a TemplateRef MatDialog	<p>How to get data sent to a MatDialog that is a <code>ng-template</code>?</p>\n<p><strong>Template</strong></p>\n<pre><code>&lt;button mat-button (click)=&quot;openDialog()&quot;&gt;Open&lt;/button&gt;\n\n&lt;ng-template #dialogRef&gt;\n    {{data?}} &lt;!-- &lt;&lt;&lt; Here is the problem data is undefined --&gt;\n&lt;/ng-template&gt;</code></pre><p><strong>Component</strong></p>\n<pre><code>export class SomeComponent {\n    @ViewChild(&quot;dialogRef&quot;) dialogRef: TemplateRef&lt;any&gt;;\n\n    constructor(private dialog: MatDialog) { }\n\n    openDialog(): void {\n        this.dialog.open(this.dialogRef, { data: &quot;some data&quot; });\n    }\n}</code></pre>	2019-08-26 18:25:27.00597+03	7	159	{1}	\N	\N	\N
64	Türkiye	<p>Türkiye ya da resmî adıyla Türkiye Cumhuriyeti, topraklarının büyük bölümü Anadolu&#39;ya, küçük bir bölümü ise Balkanlar&#39;ın uzantısı olan Trakya&#39;ya yayılmış bir ülke. Kuzeybatıda Bulgaristan, batıda Yunanistan, kuzeydoğuda Gürcistan, doğuda Ermenistan, İran ve Azerbaycan&#39;ın ekslav toprağı Nahçıvan, güneydoğuda ise Irak ve Suriye komşusudur. Güneyini Akdeniz, batısını Ege Denizi ve kuzeyini Karadeniz çevreler. Marmara Denizi ise İstanbul Boğazı ve Çanakkale Boğazı ile birlikte Anadolu&#39;yu Trakya&#39;dan yani Asya&#39;yı Avrupa&#39;dan ayırır. Türkiye, Avrupa ve Asya&#39;nın kavşak noktasında yer alması sayesinde önemli bir jeostratejik güce sahiptir.[6]</p>\n<p>Türkiye toprakları üzerindeki ilk yerleşmeler Yontma Taş Devri&#39;nde başlar.[7][8][9][10] Doğu Trakya&#39;da Traklar olmak üzere, Hititler, Frigler, Lidyalılar ve Dor istilası sonucu Yunanistan&#39;dan kaçan Akalar tarafından kurulan İyon medeniyeti gibi çeşitli eski Anadolu medeniyetlerinin ardından III. Aleksandros egemenliğiyle birlikte Helenistik dönem geldi. Daha sonra sırasıyla Roma ve Anadolu&#39;nun Hristiyanlaştığı Bizans dönemleri yaşandı.[9][11] 11. yüzyılda Abbasi hilafetini siyasi hakimiyeti altına alan ve Orta Doğu&#39;da büyük bir güç konumuna gelen Selçukluların 1071 yılında Bizans&#39;a karşı kazandığı Malazgirt Muharebesi sonrasında Anadolu&#39;daki Bizans üstünlüğünün büyük ölçüde kırılmasıyla, Anadolu kısa süre içerisinde Selçuklulara bağlı Türk beyleri tarafından fethedildi ve Anadolu topraklar üzerinde İslamlaşma ve Türkleşme başladı.[12] Bu süreç esnasında 1075 yılında İznik&#39;te kurularak kısa sürede diğer Türk beylikleri üzerinde ve tüm Anadolu&#39;da hakimiyet kuran ancak 1097 yılındaki I. Haçlı Seferinden sonra İznik&#39;in elden çıkmasıyla başkenti Konya&#39;ya taşımak zorunda kalan Anadolu Selçuklu Sultanlığı, Anadolu&#39;yu 1243&#39;teki Moğol istilasına kadar yönetti. İstila sonrasında Anadolu&#39;da pek çok küçük Türk beyliği ortaya çıktı.[13]</p>\n	2019-08-15 01:26:52.001747+03	1	22	{24,1}	\N	\N	\N
\.


--
-- Data for Name: revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revisions (id, "postTypeId", "postId", "creationTime", "userId", data) FROM stdin;
14	1	29	2019-03-13 20:46:03.24739+03	10	{"tags": [12], "text": "According to the Socket.io documentation:\\n\\n>A standalone build of socket.io-client is exposed automatically by the socket.io server as /socket.io/socket.io.js. Alternatively you can serve the file socket.io-client.js found at the root of this repository.\\n\\n    <script src=\\"/socket.io/socket.io.js\\"></script>\\n    <script>\\n        var socket = io('http://localhost');\\n        socket.on('connect', function(){\\n        socket.on('event', function(data){});\\n        socket.on('disconnect', function(){});\\n      });\\n    </script>\\n\\nHowever, I would like to serve the socket.io client from a separate CDN (it's cheaper, faster, and reduces load on my server).\\n\\nHow can I do this?  Do I have to disable the socket.io default?\\n", "title": "Socket.io client served from CDN"}
24	1	39	2019-04-20 19:44:30.045118+03	40	{"tags": [15], "text": "```html\\n<!DOCTYPE HTML PUBLIC \\"-//W3C//DTD HTML 3.2//EN\\">\\n<!--\\n*        Sample comment\\n-->\\n<HTML>\\n<head>\\n<title>WebStorm</title>\\n</head>\\n<body>\\n<h1>WebStorm</h1>\\n<p><br><b><IMG border=0 height=12 src=\\"images/hg.gif\\" width=18 >\\nWhat is WebStorm? &#x00B7; &Alpha; </b><br><br>\\n</body>\\n</html>\\n```", "title": "Example HTML Page"}
25	1	40	2019-04-20 20:34:57.647918+03	40	{"tags": [1], "text": "In Angular 8 version people suggesting to render component directly rather to bootstrap AppModule.\\n\\nmain.ts\\n\\n`renderComponent(AppComponent);`\\n\\n---------\\n\\nand for injecting module dependency, Add module code to the component file, like below code\\n\\napp.component.ts\\n\\n    @Component({\\n      selector: 'app-root',\\n      templateUrl: 'app.component.html'\\n    })\\n    export class AppComponent {\\n    }\\n    \\n    @NgModule({\\n      declarations: [\\n        AppComponent\\n      ],\\n      imports: [\\n        CommonModule,\\n        MatButtonModule\\n      ],\\n      providers: [],\\n      bootstrap: [AppComponent]\\n    })\\n    export class AppModule {\\n    }\\n\\nBut while importing MatButtonModule, it's giving error `must be called from an injection context`\\n\\nSo how to solve this issue.", "title": "How to import MatButtonModule in angular 8, with ivy renderer? Ask Question"}
26	1	41	2019-04-20 20:41:52.825156+03	40	{"tags": [1], "text": "In Angular 8 version people suggesting to render component directly rather to bootstrap AppModule.\\n\\nmain.ts\\n\\n`renderComponent(AppComponent);`\\n\\n---------\\n\\nand for injecting module dependency, Add module code to the component file, like below code\\n\\napp.component.ts\\n\\n```typecsript\\n    @Component({\\n      selector: 'app-root',\\n      templateUrl: 'app.component.html'\\n    })\\n    export class AppComponent {\\n    }\\n    \\n    @NgModule({\\n      declarations: [\\n        AppComponent\\n      ],\\n      imports: [\\n        CommonModule,\\n        MatButtonModule\\n      ],\\n      providers: [],\\n      bootstrap: [AppComponent]\\n    })\\n    export class AppModule {\\n    }\\n```\\n\\nBut while importing MatButtonModule, it's giving error `must be called from an injection context`\\n\\nSo how to solve this issue.", "title": "qqq"}
27	1	42	2019-04-20 20:43:15.215062+03	40	{"tags": [1], "text": "In Angular 8 version people suggesting to render component directly rather to bootstrap AppModule.\\n\\nmain.ts\\n\\n`renderComponent(AppComponent);`\\n\\n---------\\n\\nand for injecting module dependency, Add module code to the component file, like below code\\n\\napp.component.ts\\n\\n```typescript\\n    @Component({\\n      selector: 'app-root',\\n      templateUrl: 'app.component.html'\\n    })\\n    export class AppComponent {\\n    }\\n    \\n    @NgModule({\\n      declarations: [\\n        AppComponent\\n      ],\\n      imports: [\\n        CommonModule,\\n        MatButtonModule\\n      ],\\n      providers: [],\\n      bootstrap: [AppComponent]\\n    })\\n    export class AppModule {\\n    }\\n```\\n\\nBut while importing MatButtonModule, it's giving error `must be called from an injection context`\\n\\nSo how to solve this issue.", "title": "How to import MatButtonModule in angular 8, with ivy renderer?"}
11	1	27	2019-03-13 20:06:37.886211+03	3	{"tags": [14], "text": "I am trying to do  a simple thing but I can't ...\\n\\nI just want to get a BitmapImage from a internet URL, but my function doesn't seem to work properly, it only return me a small part of the image. I know WebResponse are working async and that's certainly why I have this problem, but how can I do it synchronously ?\\n\\nHere is my function :\\n\\n        internal static BitmapImage GetImageFromUrl(string url)\\n        {\\n            Uri urlUri = new Uri(url);\\n            WebRequest webRequest = WebRequest.CreateDefault(urlUri);\\n            webRequest.ContentType = \\"image/jpeg\\";\\n            WebResponse webResponse = webRequest.GetResponse();\\n\\n            BitmapImage image = new BitmapImage();\\n            image.BeginInit();\\n            image.StreamSource = webResponse.GetResponseStream();\\n            image.EndInit();\\n\\n            return image;\\n        }\\n\\nThank a lot for your help.", "title": "[WPF] Synchronously download an image from URL"}
12	1	27	2019-03-13 20:07:32.12554+03	1	{"tags": [14], "text": "I just want to get a BitmapImage from a internet URL, but my function doesn't seem to work properly, it only return me a small part of the image. I know WebResponse is working async and that's certainly why I have this problem, but how can I do it synchronously?\\n\\n\\n\\n        internal static BitmapImage GetImageFromUrl(string url)\\n        {\\n            Uri urlUri = new Uri(url);\\n            WebRequest webRequest = WebRequest.CreateDefault(urlUri);\\n            webRequest.ContentType = \\"image/jpeg\\";\\n            WebResponse webResponse = webRequest.GetResponse();\\n\\n            BitmapImage image = new BitmapImage();\\n            image.BeginInit();\\n            image.StreamSource = webResponse.GetResponseStream();\\n            image.EndInit();\\n\\n            return image;\\n        }", "title": "Synchronously download an image from URL"}
13	1	28	2019-03-13 20:41:27.064755+03	8	{"tags": [10, 12], "text": "I have a socket.io server running and a matching webpage with a socket.io.js client. All works fine.\\n\\nBut, I am wondering if it is possible, on another machine, to run a separate node.js application which would act as a client and connect to the mentioned socket.io server?", "title": "Node.js client for a socket.io server"}
15	1	30	2019-03-14 21:42:22.113935+03	6	{"tags": [15], "text": "Detect when an HTML5 video finishes", "title": "Detect when an HTML5 video finishes"}
16	1	31	2019-03-14 21:45:20.708394+03	6	{"tags": [15], "text": "How do you detect when a HTML5 `<video>` element has finished playing?", "title": "Detect when an HTML5 video finishes"}
17	1	32	2019-04-10 00:54:51.489059+03	30	{"tags": [16, 17], "text": "I'm trying to make a function that goes through a linked list and finds all strings that contain a substring that the user inputs.\\n\\nThe problem is that its case sensitive and I need it to not be.\\nMy idea was to make everything lowercase while going through the list. And wrote something that should work... I think... but doesn't\\n\\n```\\nchar *lowerCase(char* strToLower){\\n    char *lowCase;\\n    strcpy(lowCase, strToLower);\\n    for(int i = 0; lowCase[i]; i++){\\n       lowCase[i] = tolower(lowCase[i]);\\n    }\\n    return lowCase;\\n}\\n```\\n```\\nprintf(\\"%s\\", lowerCase(\\"Name\\"));\\n```\\n\\nNow, what ideally should pop up is \\"name\\", but I instead get nothing.\\n\\nI get Process returned -1073741819 (0xC0000005), which I think is an error related to pointers or memory? I don't really know because build log doesn't tell me anything.\\n\\nAny help is appreciated <3", "title": "How do I fix this issue I'm having with my lowercase function"}
167	2	143	2019-08-29 14:25:46.678619+03	2	{"text": "## WEBSOCKET TEST"}
18	1	33	2019-04-10 06:16:02.958844+03	32	{"tags": [5, 1, 18], "text": "I have Angular + Firebase application, where I used auth service from Firebase. And I'm looking for a best way to store user data after login.\\n\\nWhat is the best way:\\n\\n 1. Save user data to cookies, and clear them after sign-out \\n 2. Save user data to localstorage\\n 3. Save user data to global variable in service, and share this service between components\\n\\nThanks in advance for any opinion, and appreciate for you to sharing your experience.", "title": "Save user data in Angular application"}
19	1	34	2019-04-12 01:37:44.857477+03	35	{"tags": [1, 3], "text": "Hey guys I want to change the background color of my searchbar. It has the `appearance=\\"outline\\"` and I like the design but like you see if I set a new color it goes over the borders and looks ugly. What can I do here?\\n\\nMy css:\\n\\n    ::ng-deep .mat-form-field-appearance-outline .mat-form-field-infix {\\n      padding: 5%;\\n    }\\n    \\n    ::ng-deep .mat-form-field-infix {\\n      top: -3px;\\n    }\\n    \\n    ::ng-deep .mat-form-field-appearance-outline .mat-form-field-outline {\\n      background-color: white;\\n    }\\n\\nMy html:\\n\\n    <mat-form-field style=\\"width:110%;\\" appearance=\\"outline\\" >\\n        <mat-icon matPrefix>search</mat-icon>\\n        <input type=\\"search\\" name=\\"test\\" [(ngModel)]=\\"searchText\\"\\n        placeholder=\\"Search\\" aria-label=\\"Search\\" matInput>\\n    </mat-form-field>\\n\\n[![enter image description here][1]][1]\\n\\n\\n  [1]: https://i.stack.imgur.com/EGCee.png", "title": "Changing background color in outline input field"}
20	1	35	2019-04-12 05:05:22.60693+03	36	{"tags": [10], "text": "I have a node.js application that runs on different servers/containers. Clients are authenticated with JWT tokens. I want to protect this API from DDos attacks. User usage limit settings can be stored in the token. I've been thinking about som approaches:\\n\\n - Increment counters in a memory database like redis or memcached and check it on every request. Could cause bottlenecks?.\\n - Do something in a nginx server (is it possible?)\\n - Use some cloud based solution (AWS WAF? Cloudfront? API Gateway? Do they do what I want?)\\n\\nHow to solve this?", "title": "How to rate limit a node.js API that uses JWT?"}
21	1	36	2019-04-12 07:43:12.93753+03	36	{"tags": [10], "text": "I have a simple TCP server that listens on a port.\\n\\n    var net = require(\\"net\\");\\n  \\n    var server = net.createServer(function(socket) {\\n\\t    socket.end(\\"Hello!\\\\n\\");\\n    });\\n\\n    server.listen(7777);\\n\\nI start it with `node server.js` and then close it with Ctrl + Z on Mac. When I try to run it again with `node server.js` I get this error message:\\n\\n    node.js:201\\n            throw e; // process.nextTick error, or 'error' event on first tick\\n              ^\\n    Error: listen EADDRINUSE\\n    at errnoException (net.js:670:11)\\n    at Array.0 (net.js:771:26)\\n    at EventEmitter._tickCallback (node.js:192:41)\\n\\nAm I closing the program the wrong way? How can I prevent this from happening?", "title": "Stop node.js program from command line"}
22	1	37	2019-04-20 09:20:39.431115+03	40	{"tags": [2], "text": "I use this code to get the full URL:\\n\\n```php\\n$actual_link = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'];\\n```\\n\\nThe problem is that I use some masks in my .htaccess, so what we see in the URL is not always the real path of the file.\\n\\nWhat I need is to get the URL, what is written in the URL, nothing more and nothing less—the full URL.\\n\\nI need to get how it appears in the Navigation Bar in the web browser, and not the real path of the file on the server.", "title": "Get the full URL in PHP"}
23	1	38	2019-04-20 19:33:09.980332+03	40	{"tags": [2], "text": "Merhaba herkese. Şöyle bir işlemim var.\\n\\n```php\\n->set(array(\\n    'heart_count' => $row['heart_count']--\\n));\\n```\\n\\nBurada **heart_count** nasıl bir eklerim ve ya azaltırım?", "title": "array içinde azaltma ve artırma işlemi"}
28	1	43	2019-05-31 00:55:02.510988+03	35	{"tags": [1, 2, 3], "text": "I was trying to deploy my angular2 app with brotli compressed distribution to Caddy webserver.\\n\\nAre there any examples for the caddy webserver with Brotli compression support?", "title": "Caddy webserver Brotli example"}
29	1	44	2019-06-03 23:12:19.746933+03	5	{"tags": [20], "text": "integrating Angular with Django, server is receiving request from frontend but I can't handle them, because they doesn't reach target function\\n\\nhere is views.py:\\n\\n    class VView(viewsets.ModelViewSet):\\n            queryset = User.objects.all()\\n            serializer_class = UserSerializer\\n\\n    def index(request):\\n        return render(request, 'index.html')\\n\\n    @permission_classes((permissions.AllowAny))\\n    class Login(APIView):\\n       def post(self, request)\\n           return JsonRespone({\\"some\\":\\"data\\"}, status=200)\\n\\nhere are my urls.py\\n\\n    urlpatterns = [\\n      url(r'^admin/', admin.site.urls),\\n      url('', index),\\n      url('user/login',Login.as_view()),\\n      url('user/registration',Login.as_view()),\\n    ]\\n\\nand the thing is when send request now for `user/login` server doesn't respond with json as it should but when i comment out or delete my index url \\nso I have:\\n\\n\\n    urlpatterns = [\\n      url(r'^admin/', admin.site.urls),\\n      url('user/login',Login.as_view()),\\n      url('user/registration',Login.as_view()),\\n    ]\\n\\neverything works fine I get responses from server when I am using Postman for that, or run frontend on another localhost, but the problem is that server doesn't render webpage, when I access it by localhost:8000", "title": "Django index url is disabling api urls"}
159	2	137	2019-08-26 18:02:03.214734+03	9	{"text": "    var url = 'asdf.html';\\n    window.location.href = url;"}
33	2	31	2019-06-17 01:03:50.168201+03	5	{"text": "# Hello, hola!"}
30	1	45	2019-06-13 15:49:15.889677+03	2	{"tags": [1, 2, 3], "text": "I am making a game with HTML5 and Javascript.\\n\\nHow could I play game audio via Javascript?", "title": "Playing audio with Javascript??"}
45	1	52	2019-08-07 17:51:51.426897+03	6	{"tags": [1, 2, 3], "text": "I am working on a real-time analytics application and am using websockets (through the socket.io library) along with nodejs. There will be no \\"sensitive\\" data being sent through the websockets (like names, addresses, etc). It will be only used to track visits and to track the total visitors (along with the number of visitors on the top 10 most visited URLs).\\n\\nAre there any security issues that I should be aware of? Am I opening myself up to:\\n\\n1. DoS attacks?\\n2. XSS attacks?\\n3. Additional security holes that could be used to gain access to the webserver/webserver's LAN?\\n4. Anything else I didn't mention here?\\n\\nThanks!", "title": "Websockets, socket.io, nodejs, and security"}
35	1	48	2019-06-17 23:15:55.168435+03	36	{"tags": [1], "text": "\\nAçısal 2'deki son sayfaya geri dönmenin akıllıca bir yolu var mı?\\n\\nGibi bir şey\\n\\n    this._router.navigate (LASTPAGE);\\n\\nÖrneğin, C sayfasında bir <kbd> Geri Dön </kbd> düğmesi var,\\n\\n - Sayfa A -> Sayfa C, sayfa A'ya tıklayın.\\n    \\n - Sayfa B -> Sayfa C, sayfa B'ye tıklayın.\\n\\nYönlendirici bu geçmiş bilgisine sahip mi?", "title": "How to go back last page"}
31	1	46	2019-06-13 20:02:18.399209+03	10	{"tags": [3], "text": "`pre` tags are super-useful for code blocks in HTML and for debugging output while writing scripts, but how do I make the text word-wrap instead of printing out one long line?", "title": "How do I wrap text in a pre tag?"}
36	1	49	2019-07-23 15:59:26.642109+03	5	{"tags": [1, 2, 3], "text": "I am using express 4.0 and I'm aware that body parser has been taken out of the express core, I am using the recommended replacement, however I am getting \\n\\n`body-parser deprecated bodyParser: use individual json/urlencoded middlewares server.js:15:12\\nbody-parser deprecated urlencoded: explicitly specify \\"extended: true\\" for extended parsing node_modules/body-parser/index.js:74:29`\\n\\nWhere do I find this supposed middlewares? or should I not be getting this error?\\n\\n    var express \\t= require('express');\\n\\tvar server \\t\\t= express();\\n\\tvar bodyParser \\t= require('body-parser');\\n\\tvar mongoose \\t= require('mongoose');\\n\\tvar passport\\t= require('./config/passport');\\n\\tvar routes\\t\\t= require('./routes');\\n\\n\\tmongoose.connect('mongodb://localhost/myapp', function(err) {\\n\\t\\tif(err) throw err;\\n\\t});\\n\\n\\tserver.set('view engine', 'jade');\\n\\tserver.set('views', __dirname + '/views');\\n\\n\\tserver.use(bodyParser()); \\n\\tserver.use(passport.initialize());\\n\\n\\t// Application Level Routes\\n\\troutes(server, passport);\\n\\n\\tserver.use(express.static(__dirname + '/public'));\\n\\n\\tserver.listen(3000);\\n", "title": "bodyParser is deprecated express 4"}
37	2	32	2019-07-23 16:06:24.456312+03	35	{"text": "It means that using the `bodyParser()` **constructor** has been [deprecated](https://github.com/expressjs/body-parser/commit/b7420f8dc5c8b17a277c9e50d72bbaf3086a3900),  as of 2014-06-19.\\n\\n    app.use(bodyParser()); //Now deprecated\\n\\nYou now need to call the methods separately\\n\\n    app.use(bodyParser.urlencoded());\\n\\n    app.use(bodyParser.json());\\nAnd so on.\\n\\nIf you're still getting a warning with `urlencoded` you need to use\\n\\n    app.use(bodyParser.urlencoded({\\n      extended: true\\n    }));\\n\\nThe `extended` config object key now needs to be explicitly passed, since it now has no default value.\\n\\nIf you are using Express >= 4.16.0, body parser has been re-added under the methods `express.json()` and `express.urlencoded() `."}
38	2	33	2019-07-23 18:40:41.49642+03	3	{"text": "Want **zero warnings**? Use it like this:\\n\\n    app.use(bodyParser.json());\\n    app.use(bodyParser.urlencoded({\\n      extended: true\\n    }));\\n\\n**Explanation**: The default value of the `extended` option has been deprecated, meaning you need to explicitly pass true or false value."}
39	2	34	2019-07-24 00:22:30.853904+03	39	{"text": "In older versions of express, we had to use:\\n\\n    app.use(express.bodyparser()); \\n\\nbecause body-parser was a middleware between node and \\nexpress. Now we have to use it like:\\n\\n    app.use(bodyParser.urlencoded({ extended: false }));\\n    app.use(bodyParser.json());\\n"}
40	2	35	2019-07-24 00:23:00.977314+03	39	{"text": " > body-parser is a piece of express middleware that \\n       reads a form's input and stores it as a javascript\\n        object accessible through `req.body` \\n      'body-parser' must be installed (via `npm install --save body-parser`) For more info see: https://github.com/expressjs/body-parser\\n       \\n       var bodyParser = require('body-parser');\\n       app.use(bodyParser.json()); // support json encoded bodies\\n       app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies\\n\\nWhen `extended` is set to true, then deflated (compressed) bodies will be inflated; when `extended` is set to false, deflated bodies are rejected. "}
41	2	36	2019-07-24 00:23:16.976328+03	39	{"text": "I found that while adding\\n\\n    app.use(bodyParser.json());\\n    app.use(bodyParser.urlencoded({\\n      extended: true\\n    }));\\n\\nhelps, sometimes it's a matter of your querying that determines how express handles it. \\n\\nFor instance, it could be that your parameters are passed in the **URL** rather than in the body\\n\\nIn such a case, you need to capture both the **body** and **url** parameters and use whichever is available (with preference for the body parameters in the case below)\\n\\n    app.route('/echo')\\n        .all((req,res)=>{\\n    \\t    let pars = (Object.keys(req.body).length > 0)?req.body:req.query;\\n    \\t    res.send(pars);\\n        });"}
42	2	37	2019-08-04 23:55:30.857013+03	5	{"text": "It is happening coz you are confusing it with `path` and `url`.\\n\\n\\n     url('', index),\\n\\nHere as you have given `''` in url it's not the correct way. And that's why it's not going to next subsequent patterns.\\n\\n>**Solution-1:** Use proper `url` patterns with regular patterns using `^` and `$`.\\n\\n    urlpatterns = [\\n        url(r'^$', index),\\n        url(r'^user/login/$',Login.as_view()),\\n        . . . . . \\n    ]\\n\\n\\n>**Solution-2:** Use `path` if using `django>=2.0`.\\n\\n    from django.urls import path\\n\\n    urlpatterns = [\\n        path('', index),\\n        path('user/login',Login.as_view()),\\n        . . . . \\n    ]"}
43	1	50	2019-08-07 17:47:58.063232+03	5	{"tags": [1, 2, 3], "text": "my pages using socket.io for real-time notification. it works well. however, opening several tabs (i.e. https://mypage.com/, https://mypage.com/settings, https://mypage.com/list) cause multiple notifications. \\n\\ni knew facebook web using notification for new post or new messages, and that notification are unique. (in spite of several tabs!) i wonder how it possible.\\n\\ni tried sockets classify by ip and send one notification to one of them. but it is not gorgeous. \\n\\nis there any other methods or strategy for unique notification?", "title": "redundant HTML notifications by several tabs"}
44	1	51	2019-08-07 17:50:47.28878+03	4	{"tags": [1, 2, 3], "text": "I'm creating a nodejs (10.16) and angular(8) app whichs is intended to generate and mail png files based on a list. The user is supposed to enter to the principal page and load an excel file, then the app reads this file and turns it into an array like:\\n\\n    list = [\\n      [name1, email1@mail.com]\\n      [name2, email2@mail.com]\\n      [        ...           ]\\n      [namex, emailx@mail.com]\\n    ]\\n\\nWhich is shown through a table as shown bellow:\\n\\n[![enter image description here][1]][1]\\n\\nThen, when the user clicks on the send button, the app creates the png files and send them to the given emails. This whole process (since the user clicks on send and when the server finishes to send the last email) can take 1-3 seconds with each mail, so if the user provides 10 mails, the process can take 30 seconds.\\n\\nSo what I want to do is to show a progress bar or some sort of notification mechanism to show the user which element is being handled and how many mails are pending to send in real time.\\n\\nThe matter is that , for example, I can show the names and emails when the user selects an excel file because what I do is to upload the file to the server (backend) and then it returns one specific response (a json actually) which can be handled in the frontend, but it is just one element that doesn't change with time.\\n\\nSo the question is, what resource/mechanism would you recomend me to send data from the backend to the frontend in real time? At this way I should be able to show what resource is being handled in real time.\\n\\nI've researched a little and found info about Server Sent Events and Websockets but I really want to know if those are correct approaches and what alternatives should I have to consider.\\n\\nThanks!\\n\\n\\n  [1]: https://i.stack.imgur.com/NAj5w.jpg", "title": "Best way to send data from server to frontend in real time (MEAN)"}
168	2	144	2019-08-29 14:29:01.347246+03	2	{"text": "@@@@ Websocket test3"}
57	1	56	2019-08-11 00:58:33.697856+03	8	{"tags": [1, 22], "text": "I have a nodejs express 2.0 application and I want to use express 3.0 within it. Tell me please which is state of express 3.0 at now and is there examples of express 3.0 applications?\\n\\nI saw connect 2.0 has been released, so can I use it with express 2.0 ?", "title": "nodejs express 3.0"}
47	1	53	2019-08-07 18:01:33.534007+03	1	{"tags": [1, 2, 3], "text": "I get JSON data with next code:    \\n     \\n    $.getJSON(\\n         \\"data.json\\",function foo(result) {\\n           $.each(result[1].data.children.slice(0, 10),\\n            function (i, post) {\\n              $(\\"#content\\").append( '<br> HTML <br>' + post.data.body_html );       \\n            }\\n          )\\n        }\\n     )\\n     \\n     <div id=\\"content\\"></div>\\n\\nSome of strings included : `&lt;` and `&gt;` and this did not displaying as regular html `<`, `>`\\nTry to use `.html()` instead `.append()`  did not work.\\n\\nHere is live example http://jsfiddle.net/u6yUN/", "title": "Render JSON into HTML"}
49	1	55	2019-08-11 00:15:07.649934+03	5	{"tags": [1, 2, 3], "text": "I am trying to access the value of the input file from my ionic 2 application but still I'm facing the issue of property files does not exist on type 'EventTarget'.\\nAs it is properly working in js but not in typescript.\\nThe code is given below:\\n\\n      document.getElementById(\\"customimage\\").onchange= function(e?) {\\n                var files: any = e.target.files[0]; \\n                  EXIF.getData(e.target.files[0], function() {\\n                      alert(EXIF.getTag(this,\\"GPSLatitude\\"));\\n                  });\\n              }\\n\\nPlease help me solve this issue as it is not building my ionic 2 application. ", "title": "Property 'files' does not exist on type 'EventTarget' error in typescript"}
157	1	74	2019-08-26 17:35:37.048345+03	5	{"tags": [5, 23], "text": "How can I redirect the user from one page to another using jQuery or pure JavaScript?", "title": "How do I redirect to another webpage?"}
55	2	44	2019-08-11 00:30:11.74867+03	10	{"text": "The `e.target` property type depends on the element you are returning on `getElementById(...)`. `files` is a property of `input` element: https://developer.mozilla.org/en-US/docs/Web/API/HTMLInputElement\\n\\nIn this case, the TypeScript compiler doesn't know you are returning an `input` element and we dont have an `Event` class specific for this. So, you can create one like the following code:\\n\\n    interface HTMLInputEvent extends Event {\\n        target: HTMLInputElement & EventTarget;\\n    }\\n\\n    document.getElementById(\\"customimage\\").onchange = function(e?: HTMLInputEvent) {\\n        let files: any = e.target.files[0]; \\n        //...\\n    }"}
56	2	45	2019-08-11 00:31:57.521583+03	10	{"text": "You can cast it as a **HTMLInputElement**:\\n\\n    document.getElementById(\\"customimage\\").onchange= function(e: Event) {\\n        let file = (<HTMLInputElement>e.target).files[0];\\n        //rest of your code...\\n    }"}
48	1	54	2019-08-07 18:03:42.306192+03	7	{"tags": [5, 24], "text": "I need to rotate an image with javascript in 90-degree intervals. I have tried a few libraries like [jQuery rotate][1] and [Raphaël][2], but they have the same problem - The image is rotated around its center. I have a bunch of content on all sides of the image, and if the image isn't perfectly square, parts of it will end up on top of that content. I want the image to stay inside its parent div, which has max-with and max-height set.\\n\\nUsing jQuery rotate like this ([http://jsfiddle.net/s6zSn/1073/][3]):\\n\\n    var angle = 0;\\n    $('#button').on('click', function() {\\n        angle += 90;\\n        $(\\"#image\\").rotate(angle);\\n    });\\n\\nResults in this:\\n\\n![How jQuery rotate works][4]\\n\\nAnd this is the result i would like instead:\\n\\n![How I would like it to work][5]\\n\\nAnyone have an idea on how to accomplish this?\\n\\n  [1]: http://code.google.com/p/jqueryrotate/\\n  [2]: http://raphaeljs.com/image-rotation.html\\n  [3]: http://jsfiddle.net/s6zSn/1073/\\n  [4]: http://i.stack.imgur.com/2pu8l.png\\n  [5]: http://i.stack.imgur.com/mD86F.png", "title": "Rotate image with javascript"}
63	2	51	2019-08-11 03:09:56.593178+03	1	{"text": "# Testing yorumdur."}
64	2	52	2019-08-11 03:17:07.189671+03	1	{"text": "## Ikinci deneme yorum..."}
65	2	53	2019-08-11 03:19:37.913866+03	4	{"text": "* Her an her sey olabilir *\\n\\nLorem ipsum..."}
66	2	54	2019-08-11 03:21:10.493015+03	4	{"text": "* Her an her sey olabilir *\\n\\nLorem ipsum...\\nsglkjksgjljklsg"}
67	2	55	2019-08-11 03:21:44.652512+03	4	{"text": "Websocket denemeleri devam ediyor..."}
68	2	56	2019-08-11 03:30:49.853417+03	10	{"text": "Besiktassin sen bizim canimiz..."}
69	2	57	2019-08-11 03:36:40.213338+03	10	{"text": "Test asamasi suruyor..."}
70	2	58	2019-08-11 03:37:26.121327+03	10	{"text": "Dale don dale..\\n"}
71	2	59	2019-08-11 03:37:54.151629+03	10	{"text": "cevaplar devam ediyor.."}
72	2	60	2019-08-11 03:38:23.131348+03	10	{"text": "damlacemre"}
73	2	61	2019-08-11 03:38:47.34617+03	10	{"text": "xdxdxdxddd"}
74	2	62	2019-08-11 03:39:23.86432+03	10	{"text": "yehhu :\\"D"}
75	2	63	2019-08-11 22:49:22.45152+03	1	{"text": "# Hola"}
77	1	58	2019-08-11 23:15:50.590846+03	1	{"tags": [1, 2, 3], "text": "I want a random selection of rows in PostgreSQL, I tried this:\\n\\n    select * from table where random() < 0.01;\\n\\nBut some other recommend this:\\n\\n    select * from table order by random() limit 1000;\\n\\nI have a very large table with 500 Million rows, I want it to be fast.\\n\\nWhich approach is better?  What are the differences?  What is the best way to select random rows?", "title": "Best way to select random rows PostgreSQL"}
80	1	61	2019-08-14 02:17:00.466215+03	2	{"tags": [1, 22], "text": "When i build my angular project, the compiler put the \\"defer\\" attribute in \\"index.html\\" but i need to disable this. Is it possible? \\n\\nIm using angular 8.0.0.\\n\\n```\\n<pre>\\n    <script src=\\"runtime.js\\" defer>\\n</pre>\\n```", "title": "How disable “defer” in angular build?"}
81	1	62	2019-08-14 02:21:58.564937+03	9	{"tags": [5, 1, 22], "text": "If we import material modules like this:\\n\\n    import * as material from '@angular/material';\\n    let materialModules = [material.MatBadgeModule];\\n\\nNow we would use the `materialModules` array for our shared material module import / export declarations.\\n\\nIf we do it like this will Angular import all material modules with the application, or will it only include the ones that are declared in `NgModule`s import and export declarations?\\n", "title": "Treeshaking * imports with Angular?"}
82	1	63	2019-08-14 02:26:39.249419+03	9	{"tags": [5, 23, 4], "text": "I would like to upload a file asynchronously with jQuery. This is my HTML:\\n\\n    <span>File</span>\\n    <input type=\\"file\\" id=\\"file\\" name=\\"file\\" size=\\"10\\"/>\\n    <input id=\\"uploadbutton\\" type=\\"button\\" value=\\"Upload\\"/>\\n\\nAnd here my `Jquery` code:\\n\\n    $(document).ready(function () {\\n        $(\\"#uploadbutton\\").click(function () {\\n            var filename = $(\\"#file\\").val();\\n\\n            $.ajax({\\n                type: \\"POST\\",\\n                url: \\"addFile.do\\",\\n                enctype: 'multipart/form-data',\\n                data: {\\n                    file: filename\\n                },\\n                success: function () {\\n                    alert(\\"Data Uploaded: \\");\\n                }\\n            });\\n        });\\n    });\\n\\nInstead of the file being uploaded, I am only getting the filename. What can I do to fix this problem?\\n\\n### Current Solution\\n\\nI am using the [jQuery Form Plugin][1] to upload files.\\n\\n  [1]: http://malsup.com/jquery/form/#code-samples", "title": "How can I upload files asynchronously?"}
180	2	156	2019-08-29 14:47:05.378566+03	5	{"text": "KATY PERRY"}
83	2	64	2019-08-14 02:30:54.101522+03	1	{"text": "With [HTML5][1] you can make file uploads with Ajax and jQuery. Not only that, you can do file validations (name, size, and MIME type) or handle the progress event with the HTML5 progress tag (or a div). Recently I had to make a file uploader, but I didn't want to use [Flash][2] nor Iframes or plugins and after some research I came up with the solution.\\n\\nThe HTML:\\n\\n    <form enctype=\\"multipart/form-data\\">\\n        <input name=\\"file\\" type=\\"file\\" />\\n        <input type=\\"button\\" value=\\"Upload\\" />\\n    </form>\\n    <progress></progress>\\n\\nFirst, you can do some validation if you want. For example, in the `.on('change')` event of the file:\\n\\n    $(':file').on('change', function () {\\n      var file = this.files[0];\\n\\n      if (file.size > 1024) {\\n        alert('max upload size is 1k');\\n      }\\n    \\n      // Also see .name, .type\\n    });\\n\\nNow the `$.ajax()` submit with the button's click:\\n\\n    $(':button').on('click', function () {\\n      $.ajax({\\n        // Your server script to process the upload\\n        url: 'upload.php',\\n        type: 'POST',\\n    \\n        // Form data\\n        data: new FormData($('form')[0]),\\n    \\n        // Tell jQuery not to process data or worry about content-type\\n        // You *must* include these options!\\n        cache: false,\\n        contentType: false,\\n        processData: false,\\n    \\n        // Custom XMLHttpRequest\\n        xhr: function () {\\n          var myXhr = $.ajaxSettings.xhr();\\n          if (myXhr.upload) {\\n            // For handling the progress of the upload\\n            myXhr.upload.addEventListener('progress', function (e) {\\n              if (e.lengthComputable) {\\n                $('progress').attr({\\n                  value: e.loaded,\\n                  max: e.total,\\n                });\\n              }\\n            }, false);\\n          }\\n          return myXhr;\\n        }\\n      });\\n    });\\n\\n\\nAs you can see, with HTML5 (and some research) file uploading not only becomes possible but super easy. Try it with [Google Chrome][3] as some of the HTML5 components of the examples aren't available in every browser.\\n\\n  [1]: http://en.wikipedia.org/wiki/HTML5\\n  [2]: http://en.wikipedia.org/wiki/Adobe_Flash\\n  [3]: http://en.wikipedia.org/wiki/Google_Chrome\\n"}
84	2	65	2019-08-14 02:33:06.324554+03	6	{"text": "## 2019 Update: It *still* depends on the browsers *your* demographic uses.\\n\\nAn important thing to understand with the \\"new\\" HTML5 `file` API is that is [wasn't supported until IE 10][1]. If the specific market you're aiming at has a higher-than-average prepensity toward older versions of Windows, you might not have access to it.\\n\\nAs of 2017, about 5% of browsers are one of IE 6, 7, 8 or 9. If you head into a big corporation (eg this is a B2B tool, or something you're delivering for training) that number can rocket. In 2016, I dealt with a company using IE8 on over 60% of their machines.\\n\\nIt's 2019 as of this edit, almost 11 years after my initial answer. IE9 and lower are *globally* around the 1% mark but there are still clusters  of higher usage.\\n\\nThe important take-away from this —whatever the feature— is, **check what browser *your* users use**. If you don't, you'll learn a quick and painful lesson in why \\"works for me\\" isn't good enough in a deliverable to a client. [caniuse][2] is a useful tool but note where they get their demographics from. They may not align with yours. This is never truer than enterprise environments.\\n\\nMy answer from 2008 follows.\\n\\n---\\n\\nHowever, there are viable non-JS methods of file uploads. You can create an iframe on the page (that you hide with CSS) and then target your form to post to that iframe. The main page doesn't need to move.\\n\\nIt's a \\"real\\" post so it's not wholly interactive. If you need status you need something server-side to process that. This varies massively depending on your server. [ASP.NET][3] has nicer mechanisms. PHP plain fails, but you can use [Perl][4] or Apache modifications to get around it.\\n\\nIf you need multiple file-uploads, it's best to do each file one at a time (to overcome maximum file upload limits). Post the first form to the iframe, monitor its progress using the above and when it has finished, post the second form to the iframe, and so on.\\n\\nOr use a Java/Flash solution. They're a lot more flexible in what they can do with their posts...\\n\\n\\n  [1]: http://caniuse.com/fileapi\\n  [2]: https://caniuse.com/\\n  [3]: http://en.wikipedia.org/wiki/ASP.NET\\n  [4]: http://en.wikipedia.org/wiki/Perl"}
85	2	66	2019-08-14 15:57:41.900047+03	10	{"text": "I recommend using the [Fine Uploader][1] plugin for this purpose. Your `JavaScript` code would be:\\n\\n    $(document).ready(function() {\\n      $(\\"#uploadbutton\\").jsupload({\\n        action: \\"addFile.do\\",\\n        onComplete: function(response){\\n          alert( \\"server response: \\" + response);\\n        }\\n      });\\n    });\\n\\n  [1]: http://fineuploader.com/demos.html\\n"}
86	1	64	2019-08-15 01:26:52.001747+03	1	{"tags": [24, 1], "text": "Türkiye ya da resmî adıyla Türkiye Cumhuriyeti, topraklarının büyük bölümü Anadolu'ya, küçük bir bölümü ise Balkanlar'ın uzantısı olan Trakya'ya yayılmış bir ülke. Kuzeybatıda Bulgaristan, batıda Yunanistan, kuzeydoğuda Gürcistan, doğuda Ermenistan, İran ve Azerbaycan'ın ekslav toprağı Nahçıvan, güneydoğuda ise Irak ve Suriye komşusudur. Güneyini Akdeniz, batısını Ege Denizi ve kuzeyini Karadeniz çevreler. Marmara Denizi ise İstanbul Boğazı ve Çanakkale Boğazı ile birlikte Anadolu'yu Trakya'dan yani Asya'yı Avrupa'dan ayırır. Türkiye, Avrupa ve Asya'nın kavşak noktasında yer alması sayesinde önemli bir jeostratejik güce sahiptir.[6]\\n\\nTürkiye toprakları üzerindeki ilk yerleşmeler Yontma Taş Devri'nde başlar.[7][8][9][10] Doğu Trakya'da Traklar olmak üzere, Hititler, Frigler, Lidyalılar ve Dor istilası sonucu Yunanistan'dan kaçan Akalar tarafından kurulan İyon medeniyeti gibi çeşitli eski Anadolu medeniyetlerinin ardından III. Aleksandros egemenliğiyle birlikte Helenistik dönem geldi. Daha sonra sırasıyla Roma ve Anadolu'nun Hristiyanlaştığı Bizans dönemleri yaşandı.[9][11] 11. yüzyılda Abbasi hilafetini siyasi hakimiyeti altına alan ve Orta Doğu'da büyük bir güç konumuna gelen Selçukluların 1071 yılında Bizans'a karşı kazandığı Malazgirt Muharebesi sonrasında Anadolu'daki Bizans üstünlüğünün büyük ölçüde kırılmasıyla, Anadolu kısa süre içerisinde Selçuklulara bağlı Türk beyleri tarafından fethedildi ve Anadolu topraklar üzerinde İslamlaşma ve Türkleşme başladı.[12] Bu süreç esnasında 1075 yılında İznik'te kurularak kısa sürede diğer Türk beylikleri üzerinde ve tüm Anadolu'da hakimiyet kuran ancak 1097 yılındaki I. Haçlı Seferinden sonra İznik'in elden çıkmasıyla başkenti Konya'ya taşımak zorunda kalan Anadolu Selçuklu Sultanlığı, Anadolu'yu 1243'teki Moğol istilasına kadar yönetti. İstila sonrasında Anadolu'da pek çok küçük Türk beyliği ortaya çıktı.[13]", "title": "Türkiye"}
87	1	65	2019-08-15 02:47:28.103069+03	4	{"tags": [26, 25], "text": "Chrome added support for native lazy image loading in Chrome 76 which I found out from [this article][1].\\n\\nThe premise is that you add `loading=\\"lazy\\"` to all of your `img` tags.\\n\\nInstead of going through multiple pages and lines of img code, how can I globally apply this setting to all images?\\n\\n\\n  [1]: https://medium.com/bbc-design-engineering/native-lazy-loading-has-arrived-c37a165d70a5", "title": "How do I apply Chrome's native loading=“lazy” to all my images?"}
160	2	138	2019-08-26 18:03:53.160468+03	10	{"text": " **WARNING:** This answer has merely been provided as a possible solution; it is obviously *not* the best solution, as it requires jQuery. Instead, prefer the pure JavaScript solution.\\n\\n<!-- language: lang-js -->\\n\\n    $(location).attr('href', 'http://stackoverflow.com')\\n"}
162	2	140	2019-08-26 18:10:13.75443+03	6	{"text": "This works with jQuery:\\n\\n    $(window).attr(\\"location\\", \\"http://google.fr\\");\\n"}
169	2	145	2019-08-29 14:29:27.148226+03	2	{"text": "@@@@ Websocket test4"}
170	2	146	2019-08-29 14:29:36.260651+03	2	{"text": "@@@@ Websocket test4qqq"}
172	2	148	2019-08-29 14:39:23.914033+03	2	{"text": "qqq"}
93	1	67	2019-08-21 19:43:40.383222+03	4	{"tags": [5, 27], "text": "When I run\\n\\n    /(a)/g.exec('a a a ').length\\n\\nI get \\n\\n    2\\n\\nbut I thought it should return\\n\\n    3\\n\\nbecause there are 3 `a`s in the string, not 2!\\n\\nWhy is that?\\n\\nI want to be able to search for all occurances of a string in RegEx and iterate over them.\\n\\nFWIW: I'm using node.js", "title": "Javascript: How to get multiple matches in RegEx .exec results"}
94	1	68	2019-08-21 22:27:01.316474+03	4	{"tags": [15], "text": "According to the HTTP/1.1 Spec: \\n\\n> The **`POST`** method is used to request that the origin server accept the entity enclosed in the request as a new subordinate of the resource identified by the `Request-URI` in the `Request-Line`\\n\\nIn other words, `POST` is used to **create**.\\n\\n> The **`PUT`** method requests that the enclosed entity be stored under the supplied `Request-URI`. If the `Request-URI` refers to an already existing resource, the enclosed entity SHOULD be considered as a modified version of the one residing on the origin server. If the `Request-URI` does not point to an existing resource, and that URI is capable of being defined as a new resource by the requesting user agent, the origin server can create the resource with that URI.\\"\\n\\nThat is, `PUT` is used to **create or update**.\\n\\nSo, which one should be used to create a resource? Or one needs to support both?", "title": "PUT vs. POST in REST"}
175	2	151	2019-08-29 14:40:38.457438+03	2	{"text": "calisti"}
96	1	70	2019-08-23 01:22:21.168631+03	6	{"tags": [1], "text": "Can someone please explain the difference between `Promise` and `Observable` in Angular?\\n\\nAn example on each would be helpful in understanding both the cases.\\nIn what scenario can we use each case?", "title": "What is the difference between Promises and Observables?"}
97	1	71	2019-08-23 14:38:53.408908+03	1	{"tags": [26], "text": "I'm trying to display some large images with HTML img tags. At the moment they go off the edge of the screen; how can I scale them to stay within the browser window?\\n\\nOr in the likely event that this is not possible, is it possible to at least say \\"display this image at 50% of its normal width and height\\"?\\n\\nThe width and height attributes distort the image -- as far as I can tell, this is because they refer to whatever attributes the container may end up with, which will be unrelated to the image. I can't specify pixels because I have to deal with a large collection of images each with a different pixel size. Max-width doesn't work.", "title": "HTML img scaling"}
98	2	79	2019-08-23 15:29:33.50206+03	9	{"text": "Only set the width or height, and it will scale the other automatically. And yes you can use a percentage.\\n\\nThe first part can be done, but requires JavaScript, so might not work for all users."}
99	2	80	2019-08-23 15:30:17.363096+03	9	{"text": "# Hello world"}
177	2	153	2019-08-29 14:43:34.739109+03	5	{"text": "ANGELINE JOLIE"}
100	1	72	2019-08-26 02:25:53.778969+03	1	{"tags": [26, 3], "text": "I am currently working on an overview about some products. They are loaded from database therefore the number of them varies. I have a big \\"productContainer\\" which holds all of those products. As you know display-size varies and therefore the amount of products per row is different. This is not a problem, but I want them to be centered in this case (right now I have white space on the right, because no new product fits there). I managed to center them via inline-block but this makes the last row look weird, since it isn't filled with products and still centered with lots of space between products. If I float them to the left the last row is great but the items which are in a \\"full\\" row are not centered (again space on the right).\\n\\nIt would be great if the \\"productContainer\\" would be as wide as the floated elements inside (I do not know the amount of them). If I do not float my elemnts, the parent div is exactly as wide as -one- element (which is great). When I start floating my elements, the Container jumps to 100% width instantly, instead of the width which would be enought for X elements. (After that I could obviously easy center the Container with margin: 0 auto, but this will not work with 100% width.)\\n\\nThanks for your help!!", "title": "CSS: Div only as wide as floated children"}
101	1	73	2019-08-26 02:38:08.050181+03	5	{"tags": [26, 3], "text": "I've found that in html5 standart it is possible to wrap any kind of tag (div, img, other a(href=\\"\\")) inside tag <a>.\\nBut in real world that doesn't work as supposed\\n\\n````html\\n<a href=\\"/contact\\">\\n    <div> Test test </div>\\n    <div class=\\"menu\\">\\n        <h3> Point 1\\n        <h3> Point 1\\n    </div>\\n</a>\\n````\\n\\nProduces a very strange DOM code in both Opera and Chrome. \\nIt gives me this DOM code:\\n````html\\n<a href=\\"/contact\\"></a>\\n    <div> Test test </div>\\n    <div class=\\"menu\\">\\n        <a href=\\"/contact\\"></a>\\n        <h3> Point 1\\n        <h3> Point 1\\n    </div>\\n\\n````\\n\\nCuts <a> tag to have nothing inside of it and clones it somewhy to put it inside \\"menu\\" div tag.\\n\\nSo how to correctly wrap a div block with a link tag in 2k19 ?\\nI've tried adding display: block to a link tag - no help", "title": "How do you wrap div block with a link?"}
158	2	136	2019-08-26 17:36:38.074349+03	2	{"text": "It would help if you were a little more descriptive in what you are trying to do.  If you are trying to generate paged data, there are some options in how you do this.  You can generate separate links for each page that you want to be able to get directly to.\\n\\n    <a href='/path-to-page?page=1' class='pager-link'>1</a>\\n    <a href='/path-to-page?page=2' class='pager-link'>2</a>\\n    <span class='pager-link current-page'>3</a>\\n    ...\\n\\nNote that the current page in the example is handled differently in the code and with CSS.\\n\\nIf you want the paged data to be changed via AJAX, this is where jQuery would come in.  What you would do is add a click handler to each of the anchor tags corresponding to a different page.  This click handler would invoke some jQuery code that goes and fetches the next page via AJAX and updates the table with the new data.  The example below assumes that you have a web service that returns the new page data.\\n\\n\\n    $(document).ready( function() {\\n        $('a.pager-link').click( function() {\\n            var page = $(this).attr('href').split(/\\\\?/)[1];\\n            $.ajax({\\n                type: 'POST',\\n                url: '/path-to-service',\\n                data: page,\\n                success: function(content) {\\n                   $('#myTable').html(content);  // replace\\n                }\\n            });\\n            return false; // to stop link\\n        });\\n    });"}
161	2	139	2019-08-26 18:08:45.263771+03	8	{"text": "This works for every browser:\\n\\n    window.location.href = 'your_url';\\n\\n\\n"}
163	2	141	2019-08-26 18:12:45.327855+03	4	{"text": "You can do that without jQuery as:\\n\\n    window.location = \\"http://yourdomain.com\\";\\n\\nAnd if you want only jQuery then you can do it like:\\n\\n    $jq(window).attr(\\"location\\",\\"http://yourdomain.com\\");\\n"}
164	1	75	2019-08-26 18:25:27.00597+03	7	{"tags": [1], "text": "How to get data sent to a MatDialog that is a `ng-template`?\\n\\n**Template**\\n\\n\\t<button mat-button (click)=\\"openDialog()\\">Open</button>\\n\\n\\t<ng-template #dialogRef>\\n\\t    {{data?}} <!-- <<< Here is the problem data is undefined -->\\n\\t</ng-template>\\n\\n**Component**\\n\\n\\texport class SomeComponent {\\n\\t\\t@ViewChild(\\"dialogRef\\") dialogRef: TemplateRef<any>;\\n\\n\\t\\tconstructor(private dialog: MatDialog) { }\\n\\n\\t\\topenDialog(): void {\\n\\t\\t\\tthis.dialog.open(this.dialogRef, { data: \\"some data\\" });\\n\\t\\t}\\n\\t}", "title": "Send data to a TemplateRef MatDialog"}
165	2	142	2019-08-26 18:26:56.59769+03	7	{"text": "# Standard \\"vanilla\\" JavaScript way to redirect a page\\n\\n```\\nwindow.location.href = 'newPage.html';\\n```\\n\\n## Or more simply:  (since `window` is Global) \\n\\n```\\nlocation.href = 'newPage.html';\\n```\\n\\n------\\n\\n> **If you are here because you are *losing* HTTP_REFERER when redirecting, keep reading:**\\n\\n> (Otherwise ignore this last part)\\n\\n---------\\n\\nThe following section is for those using `HTTP_REFERER` as one of many secure measures (although it isn't a great protective measure). If you're using [Internet&nbsp;Explorer&nbsp;8][1] or lower, these variables get lost when using any form of JavaScript page redirection (location.href,  etc.).\\n\\n Below we are going to implement an alternative for **IE8 & lower** so that we don't lose HTTP_REFERER. Otherwise you can almost always simply use `window.location.href`.\\n\\nTesting against `HTTP_REFERER` (URL pasting, session, etc.) *can* be helpful in telling whether a request is legitimate.\\n*(**Note:** there are also ways to work-around / spoof these referrers, as noted by droop's link in the comments)*\\n\\n------\\n\\nSimple cross-browser testing solution (fallback to window.location.href for Internet&nbsp;Explorer&nbsp;9+ and all other browsers)\\n\\n**Usage: `redirect('anotherpage.aspx');`**\\n\\n    function redirect (url) {\\n        var ua        = navigator.userAgent.toLowerCase(),\\n            isIE      = ua.indexOf('msie') !== -1,\\n            version   = parseInt(ua.substr(4, 2), 10);\\n\\n        // Internet Explorer 8 and lower\\n        if (isIE && version < 9) {\\n            var link = document.createElement('a');\\n            link.href = url;\\n            document.body.appendChild(link);\\n            link.click();\\n        }\\n\\n        // All other browsers can use the standard window.location.href (they don't lose HTTP_REFERER like Internet Explorer 8 & lower does)\\n        else { \\n            window.location.href = url; \\n        }\\n    }\\n\\n  [1]: http://en.wikipedia.org/wiki/Internet_Explorer_8\\n"}
166	1	76	2019-08-29 14:11:36.497042+03	1	{"tags": [1], "text": "I'm looking into Angular RxJs patterns and I don't understand the difference between a `BehaviorSubject` and an `Observable`.\\n\\nFrom my understanding, a `BehaviorSubject` is a value that can change over time (can be subscribed to and subscribers can receive updated results). This seems to be the exact same purpose of an `Observable`.\\nWhen would you use an `Observable` vs a `BehaviorSubject`? Are there benefits to using a `BehaviorSubject` over an `Observable` or vice versa?", "title": "BehaviorSubject vs Observable?"}
171	2	147	2019-08-29 14:37:12.668907+03	2	{"text": "yes"}
173	2	149	2019-08-29 14:39:37.450213+03	2	{"text": "GOOD JOB!"}
174	2	150	2019-08-29 14:39:45.954126+03	2	{"text": "GOOD JOB!x"}
176	2	152	2019-08-29 14:42:22.163336+03	2	{"text": "JENNIFER ANISTON"}
178	2	154	2019-08-29 14:45:26.42519+03	5	{"text": "BRAD PITT"}
179	2	155	2019-08-29 14:45:53.911781+03	5	{"text": "Yuppi!!"}
181	2	157	2019-08-29 14:47:13.83164+03	5	{"text": "KATY PERRY2"}
182	2	158	2019-08-29 14:47:21.284325+03	5	{"text": "KATY PERRY3"}
183	2	159	2019-08-29 15:15:52.567546+03	5	{"text": "HELLO WORLD"}
184	2	160	2019-08-29 15:16:07.050861+03	5	{"text": "HELLO WORLD2"}
185	2	161	2019-08-29 15:16:12.598044+03	5	{"text": "HELLO WORLD24"}
186	2	162	2019-08-29 15:44:17.774541+03	2	{"text": "Hola, hola XD"}
187	2	163	2019-08-29 15:45:32.65511+03	2	{"text": "JASON STATHAM"}
188	2	164	2019-08-29 15:45:53.202199+03	2	{"text": "JASON MAMO"}
189	2	165	2019-08-29 15:46:20.621968+03	2	{"text": "Thi is incredible..."}
190	1	77	2019-08-31 04:51:35.696072+03	8	{"tags": [5, 10], "text": "In a project I'm collaborating on, we have two choices on which module system we can use:\\n\\n1. Importing modules using `require`, and exporting using `module.exports` and `exports.foo`.\\n2. Importing modules using ES6 `import`, and exporting using ES6 `export`\\n\\nAre there any performance benefits to using one over the other? Is there anything else that we should know if we were to use ES6 modules over Node ones?", "title": "Using Node.js require vs. ES6 import/export"}
191	1	78	2019-09-01 22:09:34.023855+03	7	{"tags": [10, 28], "text": "I've set up Node.js and Nginx on my server. Now I want to use it, but, before I start there are 2 questions:\\n\\n1. How should they work together? How should I handle the requests?\\n2. There are 2 concepts for a Node.js server, which one is better:   \\n\\n    a. Create a separate HTTP server for each website that needs it. Then load all JavaScript code at the start of the program, so the code is interpreted once.\\n\\n    b. Create one single Node.js server which handles all Node.js requests. This reads the requested files and evals their contents. So the files are interpreted on each request, but the server logic is much simpler.\\n\\nIt's not clear for me how to use Node.js correctly.", "title": "Node.js + Nginx - What now?"}
192	1	79	2019-09-13 04:55:25.777156+03	1	{"tags": [5, 23], "text": "I'm using `$.post()` to call a servlet using Ajax and then using the resulting HTML fragment to replace a `div` element in the user's current page. However, if the session times out, the server sends a redirect directive to send the user to the login page. In this case, jQuery is replacing the `div` element with the contents of the login page, forcing the user's eyes to witness a rare scene indeed. \\n\\nHow can I manage a redirect directive from an Ajax call with jQuery 1.2.6?", "title": "How to manage a redirect request after a jQuery Ajax call"}
193	2	166	2019-09-13 05:12:21.647449+03	8	{"text": "I read this question and implemented the approach that has been stated regarding setting the response status code to 278 in order to avoid the browser transparently handling the redirects. Even though this worked, I was a little dissatisfied as it is a bit of a hack.\\n\\nAfter more digging around, I ditched this approach and used [JSON][1]. In this case, all responses to ajax requests have the status code 200 and the body of the response contains a JSON object that is constructed on the server. The javascript on the client can then use the JSON object to decide what it needs to do.\\n\\nI had a similar problem to yours. I perform an ajax request that has 2 possible responses: one that redirects the browser to a new page and one that replaces an existing HTML form on the current page with a new one. The jquery code to do this looks something like:\\n\\n    $.ajax({\\n        type: \\"POST\\",\\n        url: reqUrl,\\n        data: reqBody,\\n        dataType: \\"json\\",\\n        success: function(data, textStatus) {\\n            if (data.redirect) {\\n                // data.redirect contains the string URL to redirect to\\n                window.location.href = data.redirect;\\n            }\\n            else {\\n                // data.form contains the HTML for the replacement form\\n                $(\\"#myform\\").replaceWith(data.form);\\n            }\\n        }\\n    });\\n\\nThe JSON object \\"data\\" is constructed on the server to have 2 members: data.redirect and data.form. I found this approach to be much better.\\n\\n  [1]: http://en.wikipedia.org/wiki/JSON"}
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, title, description, "creationTime", "userId") FROM stdin;
1	Angular	\N	2019-02-25 16:22:29.190909+03	0
8	Bug Report	\N	2019-02-26 18:11:33.549277+03	0
10	Çizgi Film		2019-06-13 00:12:20.390216+03	0
11	Genel Sohbet	\N	2019-08-05 00:10:40.195348+03	0
12	Web Programlama	\N	2019-08-05 00:10:54.257847+03	0
\.


--
-- Data for Name: suggested_edits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suggested_edits (id, "postId", "creationTime", "userId", data, summary) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, title, description, "parentId") FROM stdin;
1	Angular	Angular framework.	0
2	Php	Personal website.	0
3	Css	Css 3.0	0
4	Ajax	Ajax framework	0
5	Javascript	Ecmascript	0
6	Vue	Vue.js framework	0
7	Güvenlik	Security.	0
11	Websocket	\N	0
12	Socket.io	\N	0
13	Github	\N	0
14	WPF	\N	0
15	HTML5	\N	0
16	C		0
17	Pointers	\N	0
18	Firebase	\N	0
19	Security	\N	0
9	MySql	MySQL, altı milyondan fazla sistemde yüklü bulunan çoklu iş parçacıklı, çok kullanıcılı, hızlı ve sağlam bir veri tabanı yönetim sistemidir. UNIX, OS/2 ve Windows platformları için ücretsiz dağıtılmakla birlikte ticari lisans kullanmak isteyenler için de ücretli bir lisans seçeneği de mevcuttur.	0
20	Django	\N	0
10	Node.js	Google V8 Engine...	0
8	Test	Testing...	0
21	Express	Nodejs Web Framework	10
22	Typescript	\N	0
23	Jquery	\N	0
24	BugFix	\N	0
25	Chrome	\N	0
26	Html	\N	0
27	Regex	\N	0
28	Nginx	\N	0
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (id, title, "userId", "creationTime") FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, "displayName", "pictureUrl", email, password, "firstName", "lastName", "aboutMe", "creationTime", birthday, "lastSeen") FROM stdin;
5	Elena Guberman	https://images.unsplash.com/photo-1511485977113-f34c92461ad9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&ixid=eyJhcHBfaWQiOjE3Nzg0fQ	test5@mail.com	123456	Elena	Guberman	\N	2019-04-09 19:55:13.293368+03	\N	\N
1	Sehnaraz	https://m.media-amazon.com/images/M/MV5BMTQwMDQ0NDk1OV5BMl5BanBnXkFtZTcwNDcxOTExNg@@._V1_UY256_CR2,0,172,256_AL_.jpg	test@mail.com	123456	Olcay	Usta	Check out my book Data Analysis Using SQL and Excel".\r\n\r\nI have a blog with periodic posts about data analysis and SQL here at blog.data-miners.com.	2019-04-09 19:55:13.293368+03	\N	\N
36	Smith Johnson	https://randomuser.me/api/portraits/men/1.jpg	johndoe8@mail.com	123456	Pinar	Ozlen	\N	2019-04-12 04:57:52.768638+03	2019-04-12	\N
3	Alissa Cara	https://i.pinimg.com/564x/d8/eb/7b/d8eb7b3a70e6e5c260904d1d553d79c5.jpg	test9@mail.com	123456	\N	\N	\N	2019-04-09 19:55:13.293368+03	\N	\N
35	Amy Grant	https://images-na.ssl-images-amazon.com/images/M/MV5BMjEzMjA0ODk1OF5BMl5BanBnXkFtZTcwMTA4ODM3OQ@@._V1_UY256_CR5,0,172,256_AL_.jpg	johndoe4@mail.com	123456	Max	Gubin	\N	2019-04-12 01:29:56.89558+03	2019-04-11	\N
37	John Doe	https://i.pinimg.com/564x/98/77/df/9877df7d725206069b6039b03f25fece.jpg	johndoe12@mail.com	123456	John	Doe	\N	2019-04-12 07:44:01.748162+03	2019-04-12	\N
9	Julia Louis-Dreyfus	https://i.pinimg.com/564x/9f/9a/10/9f9a10a5f848f152874a7cd46ca26e97.jpg	test6@mail.com	123456	\N	\N	Hello world	2019-04-09 19:55:13.293368+03	\N	\N
7	Sebastian Schmidt	https://i.pinimg.com/564x/6b/46/25/6b46259c77e5bdec55f78ede30eaa026.jpg	test10@mail.com	123456	Sebastian	Schmidt	\N	2019-04-09 19:55:13.293368+03	\N	\N
39	Hiranya Jayathilaka	https://2.bp.blogspot.com/-4_uzgMy-FaU/W4QbFB6mM4I/AAAAAAAACeY/5DAiF6sLCwE4K9bXkH30gX5fSWfzPJToQCLcBGAs/s1600/1N6A1277.jpg	johndoe14@mail.com	123456	Hiranya	Jayathilaka	\N	2019-04-12 07:47:32.035103+03	2019-04-12	\N
8	Kechy Eke	https://i.pinimg.com/564x/c9/ea/c8/c9eac88b42a23893538ff8f284ef7f92.jpg	test2@mail.com	123456	Kechy 	Eke	\N	2019-04-09 19:55:13.293368+03	\N	\N
32	Gabrielle Thomas	https://i.pinimg.com/564x/8b/aa/a5/8baaa50251e353fbe259a152ef4bc051.jpg	johndoe2@mail.com	123456	Gabrielle	Thomas	\N	2019-04-10 03:53:12.523741+03	\N	\N
30	Ece Çetin	https://i.pravatar.cc/150?img=31	johndoe1@mail.com	123456	John	Doe	\N	2019-04-09 23:04:08.095922+03	\N	\N
40	Selena Gomez	https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0MzgxMzQ5N15BMl5BanBnXkFtZTgwMzMzNjkwOTE@._V1_UX172_CR0,0,172,256_AL_.jpg	johndoe20@mail.com	123456	Rachel	Myers	\N	2019-04-20 08:45:05.051939+03	2019-04-20	\N
6	Katherine Heigl	https://i.pinimg.com/564x/15/a3/bb/15a3bbb87e8c2da3d1e6ce56c65558f2.jpg	test3@mail.com	123456	Katherine	Heigl	\N	2019-04-09 19:55:13.293368+03	\N	\N
2	Jen Person	https://randomuser.me/api/portraits/men/81.jpg	test4@mail.com	123456	Jen	Person	\N	2019-04-09 19:55:13.293368+03	\N	\N
10	Todd	https://i.pinimg.com/564x/b8/f0/01/b8f001de26432a4fd18aab9ef3f29c96.jpg	test7@mail.com	123456	Todd	Kerpelman	Biyo...	2019-04-09 19:55:13.293368+03	\N	\N
4	Jingyu Shi	https://i.pinimg.com/originals/ec/05/d7/ec05d776d3b11435b25c3f5e076c81ad.gif	test8@mail.com	123456	Jingyu	Shi	\N	2019-04-09 19:55:13.293368+03	\N	\N
\.


--
-- Data for Name: user_logins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_logins (id, ip, "userAgent", "creationTime", "userId") FROM stdin;
1	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-10 15:10:02.258754+03	1
2	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-10 15:30:40.432373+03	2
3	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-10 15:30:53.269613+03	5
4	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-10 23:27:39.614288+03	1
5	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-10 23:27:56.343558+03	10
6	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-11 00:02:12.26165+03	1
7	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 00:03:34.117545+03	5
8	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 00:22:50.219795+03	10
9	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 00:58:10.884101+03	6
10	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 00:58:18.86631+03	8
11	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 01:20:57.915482+03	2
12	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 01:22:04.734081+03	2
13	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-11 03:04:13.525009+03	1
14	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-11 03:19:13.456866+03	4
15	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-11 03:30:26.681843+03	10
16	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-11 22:34:55.202855+03	1
17	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 00:18:28.171871+03	1
18	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:40:57.215594+03	1
19	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:44:17.25824+03	2
20	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:45:16.973976+03	2
21	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:49:55.097306+03	1
22	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:53:32.343428+03	2
23	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:55:08.579271+03	2
24	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-12 23:56:15.317721+03	2
25	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 00:05:35.318353+03	2
26	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 00:05:59.2075+03	1
27	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 00:08:28.205881+03	1
28	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 00:08:45.405565+03	1
29	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 00:08:59.259738+03	1
30	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-13 01:29:22.385865+03	2
31	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-14 02:18:21.394681+03	9
32	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-14 02:27:09.0047+03	1
33	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3876.0 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3876.0"}}	2019-08-14 02:32:48.257028+03	6
34	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-14 15:56:47.560308+03	9
35	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-14 15:56:59.386366+03	10
36	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-14 23:11:53.239564+03	1
37	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-15 02:46:50.83863+03	1
38	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-15 02:47:02.140007+03	4
39	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-15 19:07:14.628243+03	1
40	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-16 18:37:36.589121+03	1
41	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-17 15:36:58.623105+03	1
42	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-17 15:38:05.083978+03	7
43	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-17 15:38:14.360144+03	8
44	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-17 15:46:53.291536+03	1
45	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3880.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3880.4"}}	2019-08-19 13:22:31.671535+03	1
46	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-21 17:15:30.61785+03	1
47	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-21 17:15:38.730566+03	10
48	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-21 19:39:57.469852+03	4
49	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-22 16:25:32.658513+03	6
50	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 14:20:49.618608+03	1
51	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 14:21:00.007302+03	1
52	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 14:22:38.361598+03	1
53	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 14:22:54.927016+03	1
54	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-23 14:44:10.432895+03	8
55	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-23 14:44:20.596811+03	1
56	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Gecko", "version": "68.0"}, "browser": {"name": "Firefox", "major": "68", "version": "68.0"}}	2019-08-23 14:44:26.297723+03	5
57	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 15:28:43.761452+03	9
58	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 16:14:10.306618+03	10
59	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-23 16:14:14.795875+03	5
60	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-25 20:14:29.552515+03	1
61	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-26 02:29:10.676467+03	5
62	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36 OPR/62.0.3331.132", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Opera", "major": "62", "version": "62.0.3331.132"}}	2019-08-26 14:06:44.303241+03	1
63	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-26 17:16:12.408171+03	1
64	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-26 17:19:18.000705+03	5
65	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 17:36:23.41742+03	2
66	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:01:43.668389+03	9
67	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:03:39.043577+03	10
68	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:06:04.048783+03	8
69	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:09:56.089149+03	6
70	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:12:16.674607+03	2
71	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:12:22.892207+03	5
72	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:12:27.722965+03	9
73	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:12:32.087743+03	10
74	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:12:37.589508+03	4
75	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:25:02.259222+03	4
76	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:25:07.90458+03	7
77	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.18362", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "EdgeHTML", "version": "18.18362"}, "browser": {"name": "Edge", "major": "18", "version": "18.18362"}}	2019-08-26 18:26:11.208725+03	7
78	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 01:45:07.063192+03	5
79	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 12:00:38.342243+03	5
80	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 18:16:14.144684+03	1
81	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 18:50:34.539684+03	1
82	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 21:17:53.68797+03	1
83	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 21:25:18.014679+03	1
84	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-27 22:19:01.617458+03	5
85	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-28 03:16:13.542856+03	1
86	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 03:00:40.404587+03	1
87	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 03:09:12.474172+03	2
88	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 03:09:16.91657+03	2
89	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 03:09:20.970091+03	5
90	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 03:48:34.064112+03	5
91	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 04:24:30.842939+03	1
92	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 05:22:27.052543+03	1
93	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 05:22:51.428796+03	1
94	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 05:23:06.236409+03	1
95	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "76", "version": "76.0.3809.132"}}	2019-08-29 14:17:29.118558+03	8
96	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "76", "version": "76.0.3809.132"}}	2019-08-29 14:17:47.153787+03	8
97	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 14:18:14.4983+03	1
98	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 14:19:09.571715+03	1
99	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 14:20:54.077232+03	1
100	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-29 14:22:54.965751+03	1
101	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 14:25:06.278539+03	2
102	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 15:19:38.717121+03	5
103	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 15:22:05.875483+03	1
104	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 15:25:54.65461+03	1
105	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 18:12:13.508096+03	1
106	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 19:20:53.46271+03	1
107	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 19:21:04.870376+03	8
108	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 19:21:11.242637+03	6
109	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 19:21:16.333445+03	2
110	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.15", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.15"}}	2019-08-29 19:21:21.695351+03	9
111	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 03:47:01.9823+03	1
112	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 03:47:17.165567+03	2
113	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 03:49:07.278891+03	8
114	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 17:53:08.923564+03	1
115	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 17:53:44.943863+03	10
116	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-30 17:53:51.315517+03	1
117	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3887.7 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3887.7"}}	2019-08-31 04:47:31.203928+03	8
118	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 06:17:23.6003+03	1
119	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 06:17:33.419826+03	10
120	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 15:19:25.196939+03	6
121	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 15:19:44.742735+03	10
122	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 15:22:24.101567+03	10
123	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 15:22:35.876459+03	7
124	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.42 Safari/537.36 Edg/77.0.235.17", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Edge", "major": "77", "version": "77.0.235.17"}}	2019-09-01 16:11:00.861336+03	1
125	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-01 16:13:06.720488+03	7
126	::ffff:192.168.1.37/128	{"os": {"name": "Android", "version": "5.1"}, "ua": "Mozilla/5.0 (Linux; Android 5.1; Turk Telekom TT175) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36", "cpu": {}, "device": {"type": "mobile"}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "76", "version": "76.0.3809.111"}}	2019-09-01 23:37:38.070803+03	1
127	::ffff:192.168.1.37/128	{"os": {"name": "Android", "version": "5.1"}, "ua": "Mozilla/5.0 (Linux; Android 5.1; Turk Telekom TT175) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.111 Mobile Safari/537.36", "cpu": {}, "device": {"type": "mobile"}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "76", "version": "76.0.3809.111"}}	2019-09-01 23:58:26.638954+03	7
128	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3895.5 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3895.5"}}	2019-09-02 18:09:53.663107+03	7
129	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3902.4 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "78", "version": "78.0.3902.4"}}	2019-09-12 00:51:09.657328+03	1
130	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.75 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "77", "version": "77.0.3865.75"}}	2019-09-12 08:34:01.795482+03	1
131	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.75 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "77", "version": "77.0.3865.75"}}	2019-09-12 23:46:33.084248+03	1
132	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.75 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "77", "version": "77.0.3865.75"}}	2019-09-13 05:12:06.60366+03	8
133	::ffff:192.168.1.6/128	{"os": {"name": "Windows", "version": "10"}, "ua": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.75 Safari/537.36", "cpu": {"architecture": "amd64"}, "device": {}, "engine": {"name": "Blink"}, "browser": {"name": "Chrome", "major": "77", "version": "77.0.3865.75"}}	2019-09-13 05:56:28.660935+03	8
\.


--
-- Name: AnswerComments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AnswerComments_id_seq"', 57, true);


--
-- Name: AnswerVotes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."AnswerVotes_id_seq"', 1, false);


--
-- Name: PostTypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PostTypes_id_seq"', 2, true);


--
-- Name: Posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Posts_id_seq"', 1, false);


--
-- Name: QuestionComments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionComments_id_seq"', 12, true);


--
-- Name: QuestionVotes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."QuestionVotes_id_seq"', 1, false);


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answers_id_seq', 166, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 12, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_id_seq', 10, true);


--
-- Name: flags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flags_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 822, true);


--
-- Name: messages_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_types_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 3, true);


--
-- Name: push_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.push_id_seq', 22, true);


--
-- Name: question_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_tags_id_seq', 31, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 79, true);


--
-- Name: revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revisions_id_seq', 193, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 14, true);


--
-- Name: suggested_edits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suggested_edits_id_seq', 1, false);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 28, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_id_seq', 1, false);


--
-- Name: user_logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_logins_id_seq', 133, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 40, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, true);


--
-- Name: AnswerVotes "AnswerVotes"_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerVotes"
    ADD CONSTRAINT """AnswerVotes""_pk" PRIMARY KEY (id);


--
-- Name: PostTypes "PostTypes"_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostTypes"
    ADD CONSTRAINT """PostTypes""_pk" PRIMARY KEY (id);


--
-- Name: Posts "Posts"_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Posts"
    ADD CONSTRAINT """Posts""_pk" PRIMARY KEY (id);


--
-- Name: QuestionComments "QuestionComments"_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionComments"
    ADD CONSTRAINT """QuestionComments""_pk" PRIMARY KEY (id);


--
-- Name: QuestionVotes "QuestionVotes"_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionVotes"
    ADD CONSTRAINT """QuestionVotes""_pk" PRIMARY KEY (id);


--
-- Name: AnswerComments answercomments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerComments"
    ADD CONSTRAINT answercomments_pk PRIMARY KEY (id);


--
-- Name: answers answers_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pk PRIMARY KEY (id);


--
-- Name: comments comments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pk PRIMARY KEY (id);


--
-- Name: UserFavoriteQuestions favorites_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserFavoriteQuestions"
    ADD CONSTRAINT favorites_pk PRIMARY KEY (id);


--
-- Name: flags flags_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_pk PRIMARY KEY (id);


--
-- Name: messages messages_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pk PRIMARY KEY (id);


--
-- Name: messages_types messages_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_types
    ADD CONSTRAINT messages_types_pk PRIMARY KEY (id);


--
-- Name: notification notifications_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notifications_pk PRIMARY KEY (id);


--
-- Name: articles push_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT push_pk PRIMARY KEY (id);


--
-- Name: QuestionTags question_tags_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTags"
    ADD CONSTRAINT question_tags_pk PRIMARY KEY (id);


--
-- Name: questions questions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pk PRIMARY KEY (id);


--
-- Name: revisions revisions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_pk PRIMARY KEY (id);


--
-- Name: rooms rooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pk PRIMARY KEY (id);


--
-- Name: suggested_edits suggested_edits_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suggested_edits
    ADD CONSTRAINT suggested_edits_pk PRIMARY KEY (id);


--
-- Name: tag tags_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tags_pk PRIMARY KEY (id);


--
-- Name: team teams_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT teams_pk PRIMARY KEY (id);


--
-- Name: user_logins user_logins_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_logins
    ADD CONSTRAINT user_logins_pk PRIMARY KEY (id);


--
-- Name: user users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: Votes votes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Votes"
    ADD CONSTRAINT votes_pk PRIMARY KEY (id);


--
-- Name: "AnswerVotes"_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX """AnswerVotes""_id_uindex" ON public."AnswerVotes" USING btree (id);


--
-- Name: "PostTypes"_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX """PostTypes""_id_uindex" ON public."PostTypes" USING btree (id);


--
-- Name: "Posts"_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX """Posts""_id_uindex" ON public."Posts" USING btree (id);


--
-- Name: "QuestionComments"_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX """QuestionComments""_id_uindex" ON public."QuestionComments" USING btree (id);


--
-- Name: "QuestionVotes"_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX """QuestionVotes""_id_uindex" ON public."QuestionVotes" USING btree (id);


--
-- Name: answercomments_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX answercomments_id_uindex ON public."AnswerComments" USING btree (id);


--
-- Name: answers_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX answers_id_uindex ON public.answers USING btree (id);


--
-- Name: comments_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX comments_id_uindex ON public.comments USING btree (id);


--
-- Name: favorites_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX favorites_id_uindex ON public."UserFavoriteQuestions" USING btree (id);


--
-- Name: flags_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX flags_id_uindex ON public.flags USING btree (id);


--
-- Name: messages_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX messages_id_uindex ON public.messages USING btree (id);


--
-- Name: messages_types_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX messages_types_id_uindex ON public.messages_types USING btree (id);


--
-- Name: notifications_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX notifications_id_uindex ON public.notification USING btree (id);


--
-- Name: push_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX push_id_uindex ON public.articles USING btree (id);


--
-- Name: question_tags_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX question_tags_id_uindex ON public."QuestionTags" USING btree (id);


--
-- Name: questions_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX questions_id_uindex ON public.questions USING btree (id);


--
-- Name: revisions_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX revisions_id_uindex ON public.revisions USING btree (id);


--
-- Name: rooms_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX rooms_id_uindex ON public.rooms USING btree (id);


--
-- Name: suggested_edits_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX suggested_edits_id_uindex ON public.suggested_edits USING btree (id);


--
-- Name: tags_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tags_id_uindex ON public.tag USING btree (id);


--
-- Name: teams_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX teams_id_uindex ON public.team USING btree (id);


--
-- Name: user_logins_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_logins_id_uindex ON public.user_logins USING btree (id);


--
-- Name: users_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_id_uindex ON public."user" USING btree (id);


--
-- Name: votes_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX votes_id_uindex ON public."Votes" USING btree (id);


--
-- Name: QuestionTag "QuestionTag"_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTag"
    ADD CONSTRAINT """QuestionTag""_questions_id_fk" FOREIGN KEY ("questionId") REFERENCES public.questions(id);


--
-- Name: QuestionTag "QuestionTag"_tag_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionTag"
    ADD CONSTRAINT """QuestionTag""_tag_id_fk_2" FOREIGN KEY ("tagId") REFERENCES public.tag(id);


--
-- Name: AnswerComments answercomments_answers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerComments"
    ADD CONSTRAINT answercomments_answers_id_fk FOREIGN KEY ("answerId") REFERENCES public.answers(id);


--
-- Name: AnswerComments answercomments_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AnswerComments"
    ADD CONSTRAINT answercomments_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: answers answers_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_questions_id_fk FOREIGN KEY ("questionId") REFERENCES public.questions(id);


--
-- Name: answers answers_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: comments comments_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: flags flags_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flags
    ADD CONSTRAINT flags_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: messages messages_rooms_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_rooms_id_fk FOREIGN KEY ("roomId") REFERENCES public.rooms(id);


--
-- Name: messages messages_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: notification notification_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: notification notification_user_id_fk_2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_user_id_fk_2 FOREIGN KEY ("receiverId") REFERENCES public."user"(id);


--
-- Name: QuestionComments questioncomments_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionComments"
    ADD CONSTRAINT questioncomments_questions_id_fk FOREIGN KEY ("questionId") REFERENCES public.questions(id);


--
-- Name: QuestionComments questioncomments_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuestionComments"
    ADD CONSTRAINT questioncomments_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: questions questions_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: UserFavoriteQuestions userfavoritequestions_questions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserFavoriteQuestions"
    ADD CONSTRAINT userfavoritequestions_questions_id_fk FOREIGN KEY ("questionId") REFERENCES public.questions(id);


--
-- Name: UserFavoriteQuestions userfavoritequestions_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserFavoriteQuestions"
    ADD CONSTRAINT userfavoritequestions_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: Votes votes_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Votes"
    ADD CONSTRAINT votes_user_id_fk FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

