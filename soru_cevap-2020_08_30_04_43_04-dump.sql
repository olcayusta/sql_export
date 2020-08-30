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
-- Name: answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer (
    id integer NOT NULL,
    text text NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now(),
    "authorId" integer NOT NULL,
    "questionId" integer NOT NULL
);


ALTER TABLE public.answer OWNER TO postgres;

--
-- Name: answer_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_comment (
    id integer NOT NULL,
    text text NOT NULL,
    "authorId" integer NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now(),
    "answerId" integer NOT NULL
);


ALTER TABLE public.answer_comment OWNER TO postgres;

--
-- Name: answer_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_comment_id_seq OWNER TO postgres;

--
-- Name: answer_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_comment_id_seq OWNED BY public.answer_comment.id;


--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_id_seq OWNER TO postgres;

--
-- Name: answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_id_seq OWNED BY public.answer.id;


--
-- Name: chat_message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_message (
    id integer NOT NULL,
    text text,
    "roomId" integer,
    "authorId" integer,
    "createdTime" timestamp with time zone DEFAULT now(),
    type integer
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
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL,
    "authorId" integer
);


ALTER TABLE public.chat_room OWNER TO postgres;

--
-- Name: chat_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chat_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chat_room_id_seq OWNER TO postgres;

--
-- Name: chat_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chat_room_id_seq OWNED BY public.chat_room.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    text text NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL,
    "authorId" integer NOT NULL,
    "receiverId" integer NOT NULL,
    "isRead" boolean,
    type text
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
    title character varying(255) NOT NULL,
    text text NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now(),
    "userId" integer NOT NULL,
    "viewCount" integer,
    tags integer[],
    "acceptedAnswerId" integer
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_comment (
    id integer NOT NULL,
    text text NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL,
    "authorId" integer NOT NULL,
    "questionId" integer NOT NULL
);


ALTER TABLE public.question_comment OWNER TO postgres;

--
-- Name: question_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_comments_id_seq OWNER TO postgres;

--
-- Name: question_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_comments_id_seq OWNED BY public.question_comment.id;


--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_id_seq OWNER TO postgres;

--
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_id_seq OWNED BY public.question.id;


--
-- Name: question_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_revision (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    text text NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL,
    "questionId" integer NOT NULL,
    "authorId" integer NOT NULL,
    tags integer[]
);


ALTER TABLE public.question_revision OWNER TO postgres;

--
-- Name: question_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_revision_id_seq OWNER TO postgres;

--
-- Name: question_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_revision_id_seq OWNED BY public.question_revision.id;


--
-- Name: question_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_tag (
    id integer NOT NULL,
    "tagId" integer NOT NULL,
    "questionId" integer NOT NULL
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
    "authorId" integer NOT NULL,
    "questionId" integer NOT NULL,
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL,
    vote boolean DEFAULT true NOT NULL
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
-- Name: revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revision (
    id integer NOT NULL,
    summary text NOT NULL,
    data jsonb NOT NULL,
    "authorId" integer,
    "createdTime" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.revision OWNER TO postgres;

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

ALTER SEQUENCE public.revisions_id_seq OWNED BY public.revision.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    text text,
    "parentId" integer
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
    email character varying(64) NOT NULL,
    salt text NOT NULL,
    hash text NOT NULL,
    "displayName" text,
    "avatarUrl" text,
    "signupDate" timestamp with time zone DEFAULT now() NOT NULL
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
-- Name: answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);


--
-- Name: answer_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment ALTER COLUMN id SET DEFAULT nextval('public.answer_comment_id_seq'::regclass);


--
-- Name: chat_message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message ALTER COLUMN id SET DEFAULT nextval('public.chat_message_id_seq'::regclass);


--
-- Name: chat_room id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room ALTER COLUMN id SET DEFAULT nextval('public.chat_room_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.question_id_seq'::regclass);


--
-- Name: question_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment ALTER COLUMN id SET DEFAULT nextval('public.question_comments_id_seq'::regclass);


--
-- Name: question_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_revision ALTER COLUMN id SET DEFAULT nextval('public.question_revision_id_seq'::regclass);


--
-- Name: question_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag ALTER COLUMN id SET DEFAULT nextval('public.question_tag_id_seq'::regclass);


--
-- Name: question_vote id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_vote ALTER COLUMN id SET DEFAULT nextval('public.question_vote_id_seq'::regclass);


--
-- Name: revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision ALTER COLUMN id SET DEFAULT nextval('public.revisions_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer (id, text, "createdTime", "authorId", "questionId") FROM stdin;
2	<p>Setup throttling (rate limiter) with restify for some endpoints like this.</p>\n<pre><code>    var rateLimit = restify.throttle({burst:100,rate:50,ip:true});\n    server.get(&#39;/my/endpoint&#39;,\n        rateLimit,\n        function(req, res, next) {\n            // Do something here\n            return next();\n        }\n    );\n    server.post(&#39;/another/endpoint&#39;,\n        rateLimit,\n        function(req, res, next) {\n            // Do something here\n            return next();\n        }\n    );</code></pre><p>Or like this.</p>\n<pre><code>    server.post(&#39;/my/endpoint&#39;,\n        restify.throttle({burst:100,rate:50,ip:true}),\n        function(req, res, next) {\n            // Do something here\n            return next();\n        }\n    );</code></pre><p>Even when throttling per endpoint a global throttle may still be desired, so that can be done like this.</p>\n<pre><code>    server.use(restify.throttle({burst:100,rate:50,ip:true});</code></pre><p>(reference) <a href="http://restify.com/docs/plugins-api/#throttle">Throttle is one of restify&#39;s plugins.</a></p>\n	2019-09-23 23:04:35.24382+03	2	11
3	<p>From the <a href="http://restify.com/docs/plugins-api/#servestatic">documentation</a>:</p>\n<pre><code>server.get(/\\/docs\\/public\\/?.*/, restify.serveStatic({\n  directory: &#39;./public&#39;\n}));</code></pre><p>But this will search files in the <code>./public/docs/public/</code> directory.<br>I prefer to use <a href="https://nodejs.org/docs/latest/api/modules.html#modules_dirname">__dirname</a> key here:  </p>\n<pre><code>server.get(/\\/public\\/?.*/, restify.serveStatic({\n    directory: __dirname \n}));</code></pre><p><em>The value of <code>__dirname</code> is equal to script file directory path, which assumed to be also a folder, where is <code>public</code> directory.</em></p>\n<p>And now we map all <code>/public/.*</code> urls to <code>./public/</code> directory.</p>\n	2019-09-24 10:12:36.608475+03	2	12
4	<p>According to my current restify version <strong>(v5.2.0)</strong></p>\n<p>the <code>serveStatic</code> has been moved into <code>plugins</code>, so the code would be like this</p>\n<pre><code>server.get(\n  /\\/(.*)?.*/,\n  restify.plugins.serveStatic({\n    directory: &#39;./static&#39;,\n  })\n)</code></pre><p>Syntax above will serve your static files on folder <code>static</code>. So you can get the static file like <code>http://yoursite.com/awesome-photo.jpg</code></p>\n<p>For some reason if you want to serve the static files under specific path like this <code>http://yoursite.com/assets/awesome-photo.jpg</code> for example.</p>\n<p>The code should be refactored into this</p>\n<pre><code>server.get(\n  /\\/assets\\/(.*)?.*/,\n  restify.plugins.serveStatic({\n    directory: `${app_root}/static`,\n    appendRequestPath: false\n  })\n)</code></pre><p>The option <code>appendRequestPath: false</code> above means we dont include <code>assets</code> path into the file name</p>\n	2019-09-24 10:13:20.560603+03	4	12
\.


--
-- Data for Name: answer_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer_comment (id, text, "authorId", "createdTime", "answerId") FROM stdin;
\.


--
-- Data for Name: chat_message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_message (id, text, "roomId", "authorId", "createdTime", type) FROM stdin;
5	KATE UPTON IS BEAUTIFUL!	1	1	2019-10-29 23:58:10.792717+03	\N
10	Yurtta sulh, cihanda sulh.	1	1	2019-10-30 00:56:39.791435+03	\N
11	Hayatta en hakiki mürşit ilimdir.	1	1	2019-10-30 00:56:46.044455+03	\N
12	Bir ulus sanattan ve sanatçıdan yoksunsa, tam bir hayata sahip olamaz.	1	1	2019-10-30 00:56:53.650639+03	\N
13	Dünyada her şey için, maddiyat için, başarı için en gerçek yol gösterici bilimdir, fendir; bilim ve fennin dışında kılavuz aramak aymazlıktır, bilgisizliktir, doğru yoldan sapmaktır.	1	1	2019-10-30 00:57:49.876482+03	\N
14	Daha endişesiz ve korkusuzca, daha dürüst olarak yürüyeceğimiz yol vardır. Büyük Türk kadınını çalışmamıza ortak yapmak, yaşamımızı onunla birlikte yürütmek; Türk kadınını bilimsel, ahlaksal, sosyal, ekonomik yaşamda erkeğin ortağı, arkadaşı, yardımcısı ve koruyucusu yapmak yoludur.	1	3	2019-10-30 00:58:03.434392+03	\N
15	Ne denli varsıl (zengin) ve gönece (refaha) kavuşturulmuş olursa olsun, bağımsızlıktan yoksun bir ulus, uygar insanlık karşısında uşak olma konumundan yüksek bir işleme layık olamaz.	1	1	2019-10-30 00:58:35.942571+03	\N
16	Bütün dünya bilsin ki benim için bir yanlılık vardır: Cumhuriyet yanlılığı, düşünsel ve sosyal devrim yanlılığı. Bu noktada, yeni Türkiye topluluğunda 1 bireyi hariç düşünmek istemiyorum.	1	1	2019-10-30 00:59:07.586607+03	\N
18	Firefox nightly PREVIEW TEST	1	1	2019-10-30 21:45:33.934909+03	\N
19	POSTGRESQL 12 RELEASED! 😊	1	2	2019-10-30 21:49:32.392909+03	\N
20	😂😘	1	6	2019-10-30 21:58:30.400281+03	\N
21	Haha xd :D	1	1	2019-10-30 22:43:08.301186+03	\N
22	Sen iyi misin?	1	8	2019-10-31 13:37:43.205698+03	\N
88	JIT varsayilan olarak acik duruma getirilmis	3	4	2019-11-01 16:06:35.597653+03	\N
25	Web programlama uzerine sohbet etmek icin actik.	3	1	2019-10-31 16:11:06.460748+03	\N
89	Ornek kullanici resimleri ararken cok zorlaniyorum. :p 😒	1	7	2019-11-01 16:09:01.382564+03	\N
173	Bla bla...	2	5	2019-11-04 00:19:04.007927+03	\N
26	Postgresql 12 kullanan var mi? performans nasil.	3	6	2019-10-31 16:30:18.098887+03	\N
27	Where are you?	2	1	2019-10-31 16:37:50.527612+03	\N
174	Her türlü boş muhabbet çeriği yapabilirsiniz 🏓	4	7	2019-11-04 00:37:58.649738+03	\N
175	Fifa 20 crack cikmamis halen	4	1	2019-11-04 00:40:10.082635+03	\N
97	NBA 2019\nTORONTO - LAKERS	1	1	2019-11-03 01:33:05.472532+03	\N
176	ciksada oynasak	4	1	2019-11-04 00:40:16.75155+03	\N
\.


--
-- Data for Name: chat_room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chat_room (id, title, description, "createdTime", "authorId") FROM stdin;
1	Just Chatting	\N	2019-10-29 23:39:51.419361+03	1
2	Web Programlama	\N	2019-10-31 16:09:40.612708+03	1
3	POSTGRESQL	\N	2019-10-31 16:09:53.917011+03	\N
4	Boş Muhabbet	\N	2019-11-04 00:36:51.888714+03	\N
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, text, "createdTime", "authorId", "receiverId", "isRead", type) FROM stdin;
1	Bir yorumunu begendi	2019-09-22 10:26:28.479633+03	5	1	\N	"comment"
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, title, text, "createdTime", "userId", "viewCount", tags, "acceptedAnswerId") FROM stdin;
4	javascript, json value counting?	<p>I want to count value&#39;s number.\nHere is json.</p>\n<pre><code>x = {&quot;first&quot; : [&quot;apple&quot;, &quot;banana&quot;, &quot;car&quot;, &quot;day&quot;],\n     &quot;second&quot; : [&quot;apple&quot;,&quot;car&quot;],\n     &quot;third&quot; : [&quot;day&quot;],\n     &quot;fourth&quot; &quot; [],\n     &quot;fifth&quot; : [&quot;apple&quot;]\n}</code></pre><p>And I need these output.</p>\n<pre><code>object..???[&#39;apple&#39;]\n&gt;&gt;&gt;3\nobject..???[&#39;banana&#39;]\n&gt;&gt;&gt;1\nobject..???[&#39;car&#39;]\n&gt;&gt;&gt;2\nobject..???[&#39;day&#39;]\n&gt;&gt;&gt;2\nobject..???[&#39;elephant&#39;]\n&gt;&gt;&gt;0</code></pre><p>What kind of code should I use?</p>\n<p>I tried the following but it isn&#39;t working:</p>\n<pre><code>Object.values(x[&#39;day&#39;]).length;</code></pre>	2019-09-16 05:39:51.276012+03	3	\N	{4,1}	\N
3	Accessing element of a complex javascript object	<p>Please refer to\n<a href="https://jsfiddle.net/qL35dvsm/">https://jsfiddle.net/qL35dvsm/</a></p>\n<p>I have</p>\n<pre><code>var data = {&quot;name&quot;: [{&quot;message&quot;: &quot;Please enter your name&quot;, &quot;code&quot;: &quot;required&quot;}]};\n\nfor (d in data)\n{\n    // name\n    alert(d[0].message);\n}</code></pre><p>I want to access &quot;Please enter your name&quot; but I get &#39;undefined&#39;.</p>\n	2019-09-16 05:37:56.076694+03	2	\N	{2,3}	\N
5	Javascript multiple fields validating	<p>First, I have to validate that id and password textboxes are not empty(That one&#39;s working). Then I have to validate on the same form that id on textbox needs to be a number and also a number between 3000 and 3999 (That one doesn&#39;t work). Any ideas on what&#39;s wrong with my code?</p>\n<pre><code>function validatefunctions() {\n  if (document.getElementById(&#39;idtb&#39;).value === &#39;&#39;) {\n    alert(&#39;You need to enter a Customer ID&#39;);\n    return false;\n  }\n\n  if (document.getElementById(&#39;pwtb&#39;).value === &#39;&#39;) {\n    alert(&#39;Please enter your password&#39;);\n    return false;\n  }\n  var custID;\n  custID = document.getElementsByName(&quot;idtb&quot;).valueOf();\n\n  if (custID !== isNan) {\n    alert(&quot;Customer ID needs to be numeric&quot;);\n    return false;\n  }\n  if (custID &lt; 3000) {\n    alert(&quot;ID must be above 3000&quot;);\n    return false;\n  }\n  if (custID &gt; 3999) {\n    alert(&quot;ID must be below 3999&quot;);\n    return false;\n  }\n}</code></pre>	2019-09-16 05:44:26.910077+03	4	\N	{1,4}	\N
2	Local notification every ten minutes	I wrote:\n```\nLocalNotification localNotification = new LocalNotification();\n        localNotification.setId("Gratitudine");\n        localNotification.setAlertTitle("Pratica della Gratitudine");\n        localNotification.setAlertBody("Leggi e ripeti interiormente");\n        localNotification.setAlertSound("/notification_sound_bell.mp3");\n        // alert sound file name must begin with notification_sound\n\n        Display.getInstance().scheduleLocalNotification(localNotification,\n                System.currentTimeMillis() + 60 * 1000, // first notification\n                LocalNotification.REPEAT_MINUTE // Whether to repeat and what frequency\n        );\n```\n\nIt works.\n\nWhat is a correct way to repeat the notification every ten minutes? The only available options are: `REPEAT_NONE`, `REPEAT_MINUTE`, `REPEAT_HOUR`, `REPEAT_DAY`, `REPEAT_WEEK`.\n\nSame question for any arbitrary number of minutes (for example 4 or 13).\n\nThank you	2019-09-16 05:12:39.309007+03	1	\N	{1,2}	\N
6	Javascript: How do I fetch specific data from an API?	<p>I&#39;m doing a Javascript exercise and I&#39;m trying to display specific data using a fetch request. </p>\n<p>I&#39;m trying to display the data from <code>title</code> and <code>body</code> from the api url. I keep on getting <code>undefined</code> for some reason when I&#39;m fetching for <code>body</code> and <code>title</code> data. </p>\n<p>How do I do display the data from <code>body</code> and <code>title</code> correctly that with my current JS code?</p>\n<p>Any help is appreciated, thanks!</p>\n<p>Javascript:</p>\n<pre><code>fetch(&#39;https://uqnzta2geb.execute-api.us-east-1.amazonaws.com/default/FrontEndCodeChallenge&#39;)\n    .then(function (response) {\n        return response.json();\n    })\n    .then(function (data) {\n        appendData(data);\n    })\n    .catch(function (err) {\n        console.log(&#39;This is an error&#39;);\n    });\n\nfunction appendData(data) {\n    let mainContainer = document.getElementById(&quot;testdata&quot;);\n    for (var i = 0; i &lt; data.length; i++) {\n        var div = document.createElement(&quot;div&quot;);\n        div.innerHTML = &#39;Name: &#39; + data[i].id + &#39; &#39; + data[i].body;\n        mainContainer.appendChild(div);\n    }\n}</code></pre>	2019-09-16 19:11:47.228802+03	5	\N	\N	\N
7	Can't use for … of in bixby studio?	<p>I understand that bixby studio supports es6.\nso I used <code>for of</code> when writing the loop\nbut I got the following error</p>\n<p><code>ERROR missing ; after for-loop initializer</code></p>\n<p>Please let me know what is wrong.</p>\n<pre><code>    // email  \n    if (contactInfo.emailInfos) {\n      for (let emailInfo of contactInfo.emailInfos) {  // &lt;-- error is here\n        if (emailInfo &amp;&amp; emailInfo.address \n          &amp;&amp; emailInfo.address.replace(/ /gi, &#39;&#39;).toLowerCase().indexOf(keyword) &gt; -1) {\n          contactInfo.subText = emailInfo.address;\n\n          return contactInfo;\n        }\n      }\n    }</code></pre><pre><code>dummy data\n\n  contactInfo = {\n    nameInfo: {\n      structuredName: &#39;James&#39;\n    },\n    phoneInfos: [\n      { number: &#39;1234&#39;, phoneType: &#39;Home&#39; },\n      { number: &#39;3456&#39;, phoneType: &#39;Work&#39; }\n    ],\n    emailInfos: [\n      { address: &#39;address1@email.com&#39;, emailType: &#39;Home&#39; },\n      { address: &#39;address2@email.com&#39;, emailType: &#39;Work&#39; }\n    ]\n  }</code></pre>	2019-09-17 07:14:25.600124+03	1	\N	\N	\N
8	Mod-Rewrite or PHP router?	<p>I am debating routing my requests with one of the two options:</p>\n<p>Option 1: simple capture route with Mod-Rewrite and funnel written <code>$_GET</code> route to index.php for loading...</p>\n<pre><code>#default routing\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule    ^blog/([0-9]+)?$    index.php?rt=blog&amp;params=$1    [L,QSA]\n// ..more custom routes, and then a default route\nRewriteRule    ^([A-Za-z]+)/([A-Za-z]+)/(.*)?$    index.php?rt=$1/$2&amp;params=$3    [L,QSA]</code></pre><p>Option 2: simply route requests to Front Controller, and create a PHP routing class to handle the routing...</p>\n<pre><code>#default routing\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule ^(.*)$ index.php?rt=$1 [L,QSA]\n\n/* --- on front controller, process $_GET[&#39;rt&#39;] --- */</code></pre><p>at the end of the day, which will run faster, be easier to secure, and be easier to maintain?</p>\n<p>any other ideas?</p>\n<p>NOTE: I am not running a known framework. I am building my own MVC pattern to learn it.</p>\n	2019-09-18 07:09:18.872224+03	7	\N	\N	\N
9	jquery load metodu	<p>merhaba arkadaşlar.kullandığım sistem wp öncelikle onu söyleyeyim.bu sorunu önceden de yaşadım ancak aşamadım.çözümünü de gerçtekten merak ediyorum</p>\n<pre><code> $(&quot;#deneme&quot;).load(&quot;&lt;?php echo bloginfo(template_url); ?&gt;/a.php&quot;);</code></pre><p>deneme divinmin içine tema klasörümdeki bir php dosyasını load edebiliyorum fakat nedense o dosyanın içinde kullandığım wordpress fonksiyonları tanınmıyor.\na.php nin içine de hiçbir şey include edilmiyor.</p>\n<pre><code>include(&#39;../wp-config.php&#39;);</code></pre><p>vb tüm yolları denedim.\nbu sorunun bir çözüm yolu yok mudur?</p>\n	2019-09-20 23:45:53.495495+03	1	\N	\N	\N
10	jquery scrolltop işlemi	<p>Herkese merhaba\nBu fonksiyonu kullanarak uyarının olduğu id&#39;ye getirtiyorum sayfayı ancak benim istediğim belirlediğim id&#39;nin biraz daha yukarısına gelmesi.\nBu mesafeyi offsette mi belirtmek gerekiyor birkaç kod denedim ancak olmadı yardımlarınızı bekliyorum</p>\n<pre><code>\nfunction odaklan() {\n    $(&#39;html, body&#39;).animate({\n        scrollTop: $(&quot;#focusedInput&quot;).offset().top\n     }, 1000);\n}</code></pre>	2019-09-21 00:52:25.610778+03	1	\N	\N	\N
11	throttle per url in node.js restify	<p>The documentation states:</p>\n<blockquote>\n<p>Note that you can always place this on per-URL routes to enable\ndifferent request rates to different resources (if for example, one\nroute, like /my/slow/database is much easier to overwhlem than\n/my/fast/memcache).</p>\n</blockquote>\n<p>I am having trouble finding out how to implement this exactly.</p>\n<p>Basically, I want to serve static files at a different throttle rate than my API.</p>\n	2019-09-23 22:32:07.486463+03	2	\N	\N	\N
12	Serving static files with RESTIFY	<p>I am learning to use Node.js. Currently, I have a folder structure that looks like the following:</p>\n<pre><code>index.html\nserver.js\nclient\n  index.html\n  subs\n    index.html\n    page.html\nres\n  css\n    style.css\n  img\n    profile.png\n  js\n    page.js\n    jquery.min.js</code></pre><p>server.js is my webserver code. I run this from a command-line using <code>node server.js</code>. The contents of that file are:</p>\n<pre><code>var restify = require(&#39;restify&#39;);\n\nvar server = restify.createServer({\n    name: &#39;Test App&#39;,\n    version: &#39;1.0.0&#39;\n});\n\nserver.use(restify.acceptParser(server.acceptable));\nserver.use(restify.queryParser());\nserver.use(restify.bodyParser());\n\nserver.get(&#39;/echo/:name&#39;, function (req, res, next) {\n    res.send(req.params);\n    return next();\n});\n\nserver.listen(2000, function () {\n    console.log(&#39;%s running on %s&#39;, server.name, server.url);\n});</code></pre><p>As you can see, this server relies on RESTIFY. I&#39;ve been told I must use RESTIFY. However, I can&#39;t figure out how to serve static files. For instance, how do I server the *.html, *.css, *.png, and *.js files in my app?</p>\n<p>Thank you!</p>\n	2019-09-24 10:12:12.494427+03	5	\N	\N	\N
13	Node.js restify with socket.io	<p>Is it possible to run socket.io &amp; restify on the same port like express &amp; socket.io?</p>\n<p>I did just like this but it didn&#39;t work</p>\n<pre><code># server.coffee\nrestify = require &#39;restify&#39;\nsocket  = require &#39;socket.io&#39;\n\nserver = restify.createServer()\n\nio = socket.listen server\nserver.listen 1337</code></pre><p>when I try to connect to socket.io:</p>\n<pre><code>GET http://localhost:1337/socket.io/socket.io.js 404 (Not Found) </code></pre>	2019-09-24 21:37:50.488508+03	8	\N	\N	\N
20	Can use Angular8 like AngularJS?	<p>I have to transform a site made from AngularJS to Angular8, however, the site used js files without using NPM. Is it possible to do the same thing with Angular8? That is to download the Angular8 files and not to use a Node server.</p>\n	2019-09-25 00:23:20.358878+03	9	\N	\N	\N
21	Cannot use Ng-bootstrap in Angular 9	<p>I started my first project in angular with ng-bootstrap and followed the installation procedure, but nevertheless It doesn&#39;t work. </p>\n<p>The message is &quot;Uncaught Error: It looks like your application or one of its dependencies is using <code>i18n</code>.</p>\n<p>Angular 9 introduced a global <code>$localize()</code> function that needs to be loaded.\nPlease add <code>import &#39;@angular/localize&#39;;</code> to your polyfills.ts file.&quot;</p>\n<p>Then I added in polyfill.ts the line </p>\n<pre><code>import &#39;@angular/localize&#39;;</code></pre><p>and now the message changed to </p>\n<blockquote>\n<p>ERROR in ./src/polyfills.ts Module not found: Error: Can&#39;t resolve &#39;\n@angular/localize&#39; in &#39;D:\\source\\mh\\Reclamos-v2\\src&#39;</p>\n</blockquote>\n<p>What should I install? What is the name of localize library?</p>\n	2019-10-13 22:49:55.251821+03	1	\N	\N	\N
22	Express.js'de HTTPS'yi etkinleştirme	<p>I&#39;m trying to get HTTPS working on express.js for node, and I can&#39;t figure it out.</p>\n<p>This is my <code>app.js</code> code.</p>\n<pre><code>var express = require(&#39;express&#39;);\nvar fs = require(&#39;fs&#39;);\n\nvar privateKey = fs.readFileSync(&#39;sslcert/server.key&#39;);\nvar certificate = fs.readFileSync(&#39;sslcert/server.crt&#39;);\n\nvar credentials = {key: privateKey, cert: certificate};\n\n\nvar app = express.createServer(credentials);\n\napp.get(&#39;/&#39;, function(req,res) {\n    res.send(&#39;hello&#39;);\n});\n\napp.listen(8000);</code></pre><p>When I run it, it seems to only respond to HTTP requests.</p>\n<p>I wrote simple vanilla <code>node.js</code> based HTTPS app:</p>\n<pre><code>var   fs = require(&quot;fs&quot;),\n      http = require(&quot;https&quot;);\n\nvar privateKey = fs.readFileSync(&#39;sslcert/server.key&#39;).toString();\nvar certificate = fs.readFileSync(&#39;sslcert/server.crt&#39;).toString();\n\nvar credentials = {key: privateKey, cert: certificate};\n\nvar server = http.createServer(credentials,function (req, res) {\n  res.writeHead(200, {&#39;Content-Type&#39;: &#39;text/plain&#39;});\n  res.end(&#39;Hello World\\n&#39;);\n});\n\nserver.listen(8000);</code></pre><p>And when I run this app, it <em>does</em> respond to HTTPS requests. Note that I don&#39;t think the toString() on the fs result matters, as I&#39;ve used combinations of both and still no es bueno.</p>\n<hr>\n<p>EDIT TO ADD:</p>\n<p>For production systems, you&#39;re probably better off using Nginx or HAProxy to proxy requests to your nodejs app. You can setup nginx to handle the ssl requests and just speak http to your node app.js. </p>\n<p>EDIT TO ADD (4/6/2015)</p>\n<p>For systems on using AWS, you are better off using EC2 Elastic Load Balancers to handle SSL Termination, and allow regular HTTP traffic to your EC2 web servers. For further security, setup your security group such that only the ELB is allowed to send HTTP traffic to the EC2 instances, which will prevent external unencrypted HTTP traffic from hitting your machines.</p>\n<hr>\n	2019-10-15 16:23:43.351901+03	6	\N	\N	\N
\.


--
-- Data for Name: question_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_comment (id, text, "createdTime", "authorId", "questionId") FROM stdin;
1	In this specific case it would be <code>data.name[0].message</code>	2019-09-16 22:58:45.235403+03	3	3
2	i want to access it by for loop.	2019-09-16 23:25:25.810391+03	4	3
3		2019-09-18 03:48:31.399763+03	1	7
\.


--
-- Data for Name: question_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_revision (id, title, text, "createdTime", "questionId", "authorId", tags) FROM stdin;
1	Local notification every ten minutes	I wrote:\n```\nLocalNotification localNotification = new LocalNotification();\n        localNotification.setId("Gratitudine");\n        localNotification.setAlertTitle("Pratica della Gratitudine");\n        localNotification.setAlertBody("Leggi e ripeti interiormente");\n        localNotification.setAlertSound("/notification_sound_bell.mp3");\n        // alert sound file name must begin with notification_sound\n\n        Display.getInstance().scheduleLocalNotification(localNotification,\n                System.currentTimeMillis() + 60 * 1000, // first notification\n                LocalNotification.REPEAT_MINUTE // Whether to repeat and what frequency\n        );\n```\n\nIt works.\n\nWhat is a correct way to repeat the notification every ten minutes? The only available options are: `REPEAT_NONE`, `REPEAT_MINUTE`, `REPEAT_HOUR`, `REPEAT_DAY`, `REPEAT_WEEK`.\n\nSame question for any arbitrary number of minutes (for example 4 or 13).\n\nThank you	2019-09-16 05:12:39.309007+03	2	1	\N
2	Accessing element of a complex javascript object	Please refer to\nhttps://jsfiddle.net/qL35dvsm/\n\nI have\n```\nvar data = {"name": [{"message": "Please enter your name", "code": "required"}]};\n\nfor (d in data)\n{\n\t// name\n\talert(d[0].message);\n}\n```\n\nI want to access "Please enter your name" but I get 'undefined'.	2019-09-16 05:37:56.076694+03	3	2	\N
3	javascript, json value counting?	I want to count value's number.\nHere is json.\n\n    x = {"first" : ["apple", "banana", "car", "day"],\n         "second" : ["apple","car"],\n         "third" : ["day"],\n         "fourth" " [],\n         "fifth" : ["apple"]\n    }\n\nAnd I need these output.\n\n    object..???['apple']\n    >>>3\n    object..???['banana']\n    >>>1\n    object..???['car']\n    >>>2\n    object..???['day']\n    >>>2\n    object..???['elephant']\n    >>>0\n\nWhat kind of code should I use?\n\nI tried the following but it isn't working:\n\n    Object.values(x['day']).length;\n	2019-09-16 05:39:51.276012+03	4	3	\N
4	Javascript multiple fields validating	First, I have to validate that id and password textboxes are not empty(That one's working). Then I have to validate on the same form that id on textbox needs to be a number and also a number between 3000 and 3999 (That one doesn't work). Any ideas on what's wrong with my code?\n\n    function validatefunctions() {\n      if (document.getElementById('idtb').value === '') {\n        alert('You need to enter a Customer ID');\n        return false;\n      }\n    \n      if (document.getElementById('pwtb').value === '') {\n        alert('Please enter your password');\n        return false;\n      }\n      var custID;\n      custID = document.getElementsByName("idtb").valueOf();\n    \n      if (custID !== isNan) {\n        alert("Customer ID needs to be numeric");\n        return false;\n      }\n      if (custID < 3000) {\n        alert("ID must be above 3000");\n        return false;\n      }\n      if (custID > 3999) {\n        alert("ID must be below 3999");\n        return false;\n      }\n    }	2019-09-16 05:44:26.910077+03	5	4	\N
5	Javascript: How do I fetch specific data from an API?	I'm doing a Javascript exercise and I'm trying to display specific data using a fetch request. \n\nI'm trying to display the data from `title` and `body` from the api url. I keep on getting `undefined` for some reason when I'm fetching for `body` and `title` data. \n\nHow do I do display the data from `body` and `title` correctly that with my current JS code?\n\nAny help is appreciated, thanks!\n\nJavascript:\n\n    fetch('https://uqnzta2geb.execute-api.us-east-1.amazonaws.com/default/FrontEndCodeChallenge')\n        .then(function (response) {\n            return response.json();\n        })\n        .then(function (data) {\n            appendData(data);\n        })\n        .catch(function (err) {\n            console.log('This is an error');\n        });\n    \n    function appendData(data) {\n        let mainContainer = document.getElementById("testdata");\n        for (var i = 0; i < data.length; i++) {\n            var div = document.createElement("div");\n            div.innerHTML = 'Name: ' + data[i].id + ' ' + data[i].body;\n            mainContainer.appendChild(div);\n        }\n    }	2019-09-16 19:11:47.228802+03	6	5	\N
6	Can't use for … of in bixby studio?	I understand that bixby studio supports es6.\nso I used `for of` when writing the loop\nbut I got the following error\n\n`ERROR missing ; after for-loop initializer`\n\nPlease let me know what is wrong.\n\n```\n    // email  \n    if (contactInfo.emailInfos) {\n      for (let emailInfo of contactInfo.emailInfos) {  // <-- error is here\n        if (emailInfo && emailInfo.address \n          && emailInfo.address.replace(/ /gi, '').toLowerCase().indexOf(keyword) > -1) {\n          contactInfo.subText = emailInfo.address;\n\n          return contactInfo;\n        }\n      }\n    }\n```\n\n```\ndummy data\n\n  contactInfo = {\n    nameInfo: {\n      structuredName: 'James'\n    },\n    phoneInfos: [\n      { number: '1234', phoneType: 'Home' },\n      { number: '3456', phoneType: 'Work' }\n    ],\n    emailInfos: [\n      { address: 'address1@email.com', emailType: 'Home' },\n      { address: 'address2@email.com', emailType: 'Work' }\n    ]\n  }\n```	2019-09-17 07:14:25.600124+03	7	1	\N
7	Mod-Rewrite or PHP router?	I am debating routing my requests with one of the two options:\n\nOption 1: simple capture route with Mod-Rewrite and funnel written `$_GET` route to index.php for loading...\n\n    #default routing\n    RewriteCond %{REQUEST_FILENAME} !-f\n    RewriteCond %{REQUEST_FILENAME} !-d\n    RewriteRule    ^blog/([0-9]+)?$    index.php?rt=blog&params=$1    [L,QSA]\n    // ..more custom routes, and then a default route\n    RewriteRule    ^([A-Za-z]+)/([A-Za-z]+)/(.*)?$    index.php?rt=$1/$2&params=$3    [L,QSA]\n\nOption 2: simply route requests to Front Controller, and create a PHP routing class to handle the routing...\n\n    #default routing\n    RewriteCond %{REQUEST_FILENAME} !-f\n    RewriteCond %{REQUEST_FILENAME} !-d\n    RewriteRule ^(.*)$ index.php?rt=$1 [L,QSA]\n\n    /* --- on front controller, process $_GET['rt'] --- */\n\nat the end of the day, which will run faster, be easier to secure, and be easier to maintain?\n\nany other ideas?\n\nNOTE: I am not running a known framework. I am building my own MVC pattern to learn it.	2019-09-18 07:09:18.872224+03	8	7	\N
8	jquery load metodu	merhaba arkadaşlar.kullandığım sistem wp öncelikle onu söyleyeyim.bu sorunu önceden de yaşadım ancak aşamadım.çözümünü de gerçtekten merak ediyorum\n\n```\n $("#deneme").load("<?php echo bloginfo(template_url); ?>/a.php");\n```\n\ndeneme divinmin içine tema klasörümdeki bir php dosyasını load edebiliyorum fakat nedense o dosyanın içinde kullandığım wordpress fonksiyonları tanınmıyor.\na.php nin içine de hiçbir şey include edilmiyor.\n\n```\ninclude('../wp-config.php');\n```\n\nvb tüm yolları denedim.\nbu sorunun bir çözüm yolu yok mudur?	2019-09-20 23:45:53.495495+03	9	1	\N
9	jquery scrolltop işlemi	Herkese merhaba\nBu fonksiyonu kullanarak uyarının olduğu id'ye getirtiyorum sayfayı ancak benim istediğim belirlediğim id'nin biraz daha yukarısına gelmesi.\nBu mesafeyi offsette mi belirtmek gerekiyor birkaç kod denedim ancak olmadı yardımlarınızı bekliyorum\n\n```\n\nfunction odaklan() {\n\t$('html, body').animate({\n    \tscrollTop: $("#focusedInput").offset().top\n \t}, 1000);\n}\n```	2019-09-21 00:52:25.610778+03	10	1	\N
10	throttle per url in node.js restify	The documentation states:\n\n> Note that you can always place this on per-URL routes to enable\n> different request rates to different resources (if for example, one\n> route, like /my/slow/database is much easier to overwhlem than\n> /my/fast/memcache).\n\nI am having trouble finding out how to implement this exactly.\n\nBasically, I want to serve static files at a different throttle rate than my API.	2019-09-23 22:32:07.486463+03	11	2	\N
11	Serving static files with RESTIFY	I am learning to use Node.js. Currently, I have a folder structure that looks like the following:\n\n    index.html\n    server.js\n    client\n      index.html\n      subs\n        index.html\n        page.html\n    res\n      css\n        style.css\n      img\n        profile.png\n      js\n        page.js\n        jquery.min.js\n\nserver.js is my webserver code. I run this from a command-line using `node server.js`. The contents of that file are:\n\n    var restify = require('restify');\n    \n    var server = restify.createServer({\n        name: 'Test App',\n        version: '1.0.0'\n    });\n    \n    server.use(restify.acceptParser(server.acceptable));\n    server.use(restify.queryParser());\n    server.use(restify.bodyParser());\n    \n    server.get('/echo/:name', function (req, res, next) {\n        res.send(req.params);\n        return next();\n    });\n    \n    server.listen(2000, function () {\n        console.log('%s running on %s', server.name, server.url);\n    });\n\nAs you can see, this server relies on RESTIFY. I've been told I must use RESTIFY. However, I can't figure out how to serve static files. For instance, how do I server the *.html, *.css, *.png, and *.js files in my app?\n\nThank you!	2019-09-24 10:12:12.494427+03	12	5	\N
12	Node.js restify with socket.io	Is it possible to run socket.io & restify on the same port like express & socket.io?\n\nI did just like this but it didn't work\n\n    # server.coffee\n    restify = require 'restify'\n    socket  = require 'socket.io'\n    \n    server = restify.createServer()\n    \n    io = socket.listen server\n    server.listen 1337\n\n\nwhen I try to connect to socket.io:\n\n    GET http://localhost:1337/socket.io/socket.io.js 404 (Not Found) 	2019-09-24 21:37:50.488508+03	13	8	\N
17	Can use Angular8 like AngularJS?	I have to transform a site made from AngularJS to Angular8, however, the site used js files without using NPM. Is it possible to do the same thing with Angular8? That is to download the Angular8 files and not to use a Node server.	2019-09-25 00:23:20.358878+03	20	9	\N
18	Cannot use Ng-bootstrap in Angular 9	I started my first project in angular with ng-bootstrap and followed the installation procedure, but nevertheless It doesn't work. \n\nThe message is "Uncaught Error: It looks like your application or one of its dependencies is using `i18n`.\n\nAngular 9 introduced a global `$localize()` function that needs to be loaded.\nPlease add `import '@angular/localize';` to your polyfills.ts file."\n\nThen I added in polyfill.ts the line \n\n    import '@angular/localize';\n\nand now the message changed to \n\n> ERROR in ./src/polyfills.ts Module not found: Error: Can't resolve '\n> @angular/localize' in 'D:\\source\\mh\\Reclamos-v2\\src'\n\n\nWhat should I install? What is the name of localize library?	2019-10-13 22:49:55.251821+03	21	1	\N
19	Express.js'de HTTPS'yi etkinleştirme	I'm trying to get HTTPS working on express.js for node, and I can't figure it out.\n\nThis is my `app.js` code.\n\n    var express = require('express');\n    var fs = require('fs');\n    \n    var privateKey = fs.readFileSync('sslcert/server.key');\n    var certificate = fs.readFileSync('sslcert/server.crt');\n    \n    var credentials = {key: privateKey, cert: certificate};\n    \n    \n    var app = express.createServer(credentials);\n    \n    app.get('/', function(req,res) {\n    \tres.send('hello');\n    });\n    \n    app.listen(8000);\n\nWhen I run it, it seems to only respond to HTTP requests.\n\nI wrote simple vanilla `node.js` based HTTPS app:\n\n    var   fs = require("fs"),\n          http = require("https");\n    \n    var privateKey = fs.readFileSync('sslcert/server.key').toString();\n    var certificate = fs.readFileSync('sslcert/server.crt').toString();\n    \n    var credentials = {key: privateKey, cert: certificate};\n    \n    var server = http.createServer(credentials,function (req, res) {\n      res.writeHead(200, {'Content-Type': 'text/plain'});\n      res.end('Hello World\\n');\n    });\n    \n    server.listen(8000);\n\nAnd when I run this app, it *does* respond to HTTPS requests. Note that I don't think the toString() on the fs result matters, as I've used combinations of both and still no es bueno.\n\n----\n\nEDIT TO ADD:\n\nFor production systems, you're probably better off using Nginx or HAProxy to proxy requests to your nodejs app. You can setup nginx to handle the ssl requests and just speak http to your node app.js. \n\nEDIT TO ADD (4/6/2015)\n\nFor systems on using AWS, you are better off using EC2 Elastic Load Balancers to handle SSL Termination, and allow regular HTTP traffic to your EC2 web servers. For further security, setup your security group such that only the ELB is allowed to send HTTP traffic to the EC2 instances, which will prevent external unencrypted HTTP traffic from hitting your machines.\n\n----\n	2019-10-15 16:23:43.351901+03	22	6	\N
\.


--
-- Data for Name: question_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_tag (id, "tagId", "questionId") FROM stdin;
1	1	2
2	2	2
3	1	3
5	1	4
4	3	3
7	3	5
6	4	4
8	4	5
9	1	6
10	2	6
11	1	7
12	2	7
13	1	8
14	2	8
15	1	9
16	2	9
17	1	10
18	2	10
19	1	11
20	2	11
21	1	12
22	2	12
27	3	13
34	2	20
35	2	21
36	1	22
37	11	22
38	12	22
\.


--
-- Data for Name: question_vote; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_vote (id, "authorId", "questionId", "createdTime", vote) FROM stdin;
2	8	12	2019-09-25 13:22:59.900216+03	t
5	1	21	2019-10-13 22:50:03.255132+03	t
6	1	21	2019-10-13 22:50:06.993075+03	f
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revision (id, summary, data, "authorId", "createdTime") FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, title, text, "parentId") FROM stdin;
1	Node.js	\N	\N
2	Angular	\N	\N
3	Php	\N	\N
4	HTML5	\N	\N
5	CSS	\N	\N
6	Javascript	\N	\N
7	Jquery	\N	\N
8	Restify	\N	\N
9	Socket.io	\N	\N
10	Http	\N	\N
11	Https	\N	\N
12	Express	\N	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, salt, hash, "displayName", "avatarUrl", "signupDate") FROM stdin;
2	logan@mail.com	080195b1b3cfcaa68194b4a77e54e7b0	c87e4adee8ddc723bd620ae22065c3848cb029f1fe670828ec4902754c0a31446d8403c50de679fe64b1f22618ff3c1e1c4f564783e5645730a705cb68a5be66	logan	https://i.pinimg.com/564x/14/a9/22/14a9221d94b4241ee1f1cd50da696a28.jpg	2019-09-16 05:37:34.061281+03
8	viktor@mail.com	cf78248d032c6b3f1af93333e0fc57f6	63db74ee8829c9d8174016af583939cc7579178d7452456adcdc26de4b3f9713bbe7b88a7740e1a9e90c9451058a4a9bcd620312804e4c3daa0f7a7c2528f767	viktor	https://i.pinimg.com/564x/94/80/1d/94801d292e5ccc8db00e7623b005e1c0.jpg	2019-09-24 19:10:26.079894+03
1	olcay@gmail.com	c74b65199d8946d3a2d0ea1d830e8002	1bbafdd06f373bbed03d7fcdd233f8c83b740b5ad406c5117de63cb0e84c59fe3b30680025d23a8eb83383348bf6f08cf2b2a86e156a60a1d4f803702e37a3f9	Francesco Galgani	https://i.pinimg.com/564x/90/8f/c4/908fc43a57ea6141be48755453d6e084.jpg	2019-09-16 04:11:47.123571+03
3	japan@mail.com	7273b87ddf6e30ff38221a513f78963e	f7c764108033fe895a7c8ee7794e2389673a4aa2ef4a37572ee5734fc31d3c36a9ed8a3d28cf537c5e6ba3aa2a102715f2969499c7c68a2b410d6e52e66ea72f	홍기김	https://i.pinimg.com/564x/91/7e/e3/917ee3b45db5d269e426a7ff48421e8d.jpg	2019-09-16 05:39:09.028487+03
4	monique@mail.com	b6072a8c0184787350fb3e6a8f839a8c	df7113ed1009d0fb1fd82dcad90c017b693a5ad2e00fdd35d2ba2aa7f2b2eb45f955a535912f23befe4687a2a4a289b11c9da2642580944f711844452c581a3d	Monique Sullivan	https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f776e8e-f8ab-440a-a331-f8bcbe37d5a8/d9bo1bh-42846d95-3963-48fe-bb59-607e5ba25de4.jpg/v1/fill/w_894,h_894,q_70,strp/snow_by_samuelyounart_d9bo1bh-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzNmNzc2ZThlLWY4YWItNDQwYS1hMzMxLWY4YmNiZTM3ZDVhOFwvZDlibzFiaC00Mjg0NmQ5NS0zOTYzLTQ4ZmUtYmI1OS02MDdlNWJhMjVkZTQuanBnIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.ggo3eT2f-T4Se82pBeOw52vi52llg-wppkgZdnWSxWA	2019-09-16 05:43:32.0873+03
6	leandro@mail.com	4f703e4c2c3c27a493f258e9d3e8fa3a	411e0621d1a4b8bd2c3d68d3b83e9a26a317ffb5d4aa4d4e90c67a5f97acebd22f16b1769250fe19cdb0d4af7672aa618ee8169ee3e88ca6a7766ecb38c1df0d	Leandro Gamarra	https://i.pinimg.com/564x/7e/f7/7f/7ef77fa3a3097dc029121879ebda8404.jpg	2019-09-16 21:01:33.253522+03
7	johnnietheblack@mail.com	22fee0c7aa45d67424545d412166906d	8d906447740b2e67b41ac040c67334cbdf3f6234f6058ed857bce686a6a62be1f3d21a6a6fc8e7cb1d29b70a981bded6fa46b7f0cce38d6538cec6c10dbd960e	johnnietheblack	https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3f776e8e-f8ab-440a-a331-f8bcbe37d5a8/d8o1j8b-7df34b47-8d9a-4ca2-8d8e-9aba99520117.jpg/v1/fill/w_1024,h_1152,q_75,strp/christine_by_samuelyounart_d8o1j8b-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTE1MiIsInBhdGgiOiJcL2ZcLzNmNzc2ZThlLWY4YWItNDQwYS1hMzMxLWY4YmNiZTM3ZDVhOFwvZDhvMWo4Yi03ZGYzNGI0Ny04ZDlhLTRjYTItOGQ4ZS05YWJhOTk1MjAxMTcuanBnIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.PriY2a6f6io63MtXSW_TCCncdowL5D8kCb4ULSbP0rs	2019-09-18 07:06:47.301748+03
5	spidey677@mail.com	deb3b6a0d056f097066b820d8b727306	dae58cdac2009e99c6187b794251523fe91f437df89d2c217fc8a5e809c917a6c2f624ed6d523594a759316ce11805e288c36c5d90faf038f0e75a6efdb0c4d0	spidey677	https://i.pinimg.com/564x/c4/db/9d/c4db9ddc649e25753eb1c279960ad948.jpg	2019-09-16 06:17:22.414301+03
9	she@mail.com	e6433415eedcdfc1fab3b97100ce4db1	3904ea3d9268309dd469609a4fbf4a186524371ef705cf63aa8ff8e5c0644315becf24b13b0ec03eab99a5a132f77417d6f619912219b4cf90a386539e449528	she	https://i.pinimg.com/564x/72/aa/ad/72aaaddf63b3e3d965cf4001305c4dcf.jpg	2019-09-25 00:13:23.849203+03
\.


--
-- Name: answer_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_comment_id_seq', 1, false);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_id_seq', 4, true);


--
-- Name: chat_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_message_id_seq', 176, true);


--
-- Name: chat_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chat_room_id_seq', 4, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 1, true);


--
-- Name: question_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_comments_id_seq', 3, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_id_seq', 22, true);


--
-- Name: question_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_revision_id_seq', 19, true);


--
-- Name: question_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_tag_id_seq', 38, true);


--
-- Name: question_vote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_vote_id_seq', 6, true);


--
-- Name: revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.revisions_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 12, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 45, true);


--
-- Name: answer_comment answer_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment
    ADD CONSTRAINT answer_comment_pk PRIMARY KEY (id);


--
-- Name: answer answer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pk PRIMARY KEY (id);


--
-- Name: chat_message chat_message_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_message
    ADD CONSTRAINT chat_message_pk PRIMARY KEY (id);


--
-- Name: chat_room chat_room_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_room
    ADD CONSTRAINT chat_room_pk PRIMARY KEY (id);


--
-- Name: notification notification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pk PRIMARY KEY (id);


--
-- Name: question_comment question_comments_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment
    ADD CONSTRAINT question_comments_pk PRIMARY KEY (id);


--
-- Name: question question_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pk PRIMARY KEY (id);


--
-- Name: question_revision question_revision_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_revision
    ADD CONSTRAINT question_revision_pk PRIMARY KEY (id);


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
-- Name: revision revisions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revision
    ADD CONSTRAINT revisions_pk PRIMARY KEY (id);


--
-- Name: tag tag_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pk PRIMARY KEY (id);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: notification_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX notification_id_uindex ON public.notification USING btree (id);


--
-- PostgreSQL database dump complete
--

