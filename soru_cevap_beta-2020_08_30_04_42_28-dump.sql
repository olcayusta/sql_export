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
-- Name: answer_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer_comment (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
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
-- Name: question_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_answer (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "questionId" integer
);


ALTER TABLE public.question_answer OWNER TO postgres;

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

ALTER SEQUENCE public.answer_id_seq OWNED BY public.question_answer.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    "senderId" integer,
    "receiverId" integer,
    text text,
    type integer,
    "creationTime" timestamp with time zone DEFAULT now()
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
    "rawContent" text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer,
    "viewCount" integer DEFAULT 0
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_comment (
    id integer NOT NULL,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "userId" integer
);


ALTER TABLE public.question_comment OWNER TO postgres;

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
    title text,
    content text,
    "creationTime" timestamp with time zone DEFAULT now(),
    "questionId" integer
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
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    title text,
    description text,
    "creationTime" timestamp with time zone DEFAULT now()
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
    password text,
    "displayName" text,
    picture text,
    "signupDate" timestamp with time zone DEFAULT now()
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
-- Name: answer_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment ALTER COLUMN id SET DEFAULT nextval('public.answer_comment_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.question_id_seq'::regclass);


--
-- Name: question_answer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer ALTER COLUMN id SET DEFAULT nextval('public.answer_id_seq'::regclass);


--
-- Name: question_revision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_revision ALTER COLUMN id SET DEFAULT nextval('public.question_revision_id_seq'::regclass);


--
-- Name: question_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag ALTER COLUMN id SET DEFAULT nextval('public.question_tag_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: answer_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer_comment (id, content, "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, "senderId", "receiverId", text, type, "creationTime") FROM stdin;
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, title, "rawContent", content, "creationTime", "userId", "viewCount") FROM stdin;
8	TypeScript: an interface property dependent on another	is it possible to type an interface property dependent on another?\n\nFor example I have:\n```\nconst object = {\n  foo: 'hello',\n  bar: { hello: '123', },\n}\n```\n\nAnd I want to make sure that the key of **bar** must be the value of **foo**.\n```\ninterface ObjectType = {\n  foo: string;\n  bar: { hello: string; } // instead of hardcoding have something like this? --> payload: { ValueOfFoo: string; }\n}\n```\n\nThanks! :)	<p>is it possible to type an interface property dependent on another?</p>\n<p>For example I have:</p>\n<pre><code>const object = {\n  foo: &#39;hello&#39;,\n  bar: { hello: &#39;123&#39;, },\n}</code></pre>\n<p>And I want to make sure that the key of <strong>bar</strong> must be the value of <strong>foo</strong>.</p>\n<pre><code>interface ObjectType = {\n  foo: string;\n  bar: { hello: string; } // instead of hardcoding have something like this? --&gt; payload: { ValueOfFoo: string; }\n}</code></pre>\n<p>Thanks! :)</p>\n	2020-08-15 20:46:26.019154+03	4	62
11	Deno - access web apis	I am bundling my Deno code for the web using `deno bundle` and I know the browser has `RTCPeerConnection` from the WebRTC API which I would like to use.\n\nI thought Deno was aiming to have web compatibility, so I don't see why WebRTC is not planned to be implemented.\n\nBut since it isn't at the moment, how can I tell Deno to trust that this global variable exists and to compile?\n	<p>I am bundling my Deno code for the web using <code>deno bundle</code> and I know the browser has <code>RTCPeerConnection</code> from the WebRTC API which I would like to use.</p>\n<p>I thought Deno was aiming to have web compatibility, so I don&#39;t see why WebRTC is not planned to be implemented.</p>\n<p>But since it isn&#39;t at the moment, how can I tell Deno to trust that this global variable exists and to compile?</p>\n	2020-08-15 22:05:44.129969+03	1	22
2	curl ile youtube indirme işlemleri	curl ile videoyu mp3 olarak indirmek mümkünmüdür converter siteleri nasıl bunu yapıyor hep merak ediyorum internette sürekli başka birilerin apilerini kullanarak yapmışlar sitelerde kapandığı için çoğu çalışmıyor curl ile yapmak mümkün mü?	<p>curl ile videoyu mp3 olarak indirmek mümkünmüdür converter siteleri nasıl bunu yapıyor hep merak ediyorum internette sürekli başka birilerin apilerini kullanarak yapmışlar sitelerde kapandığı için çoğu çalışmıyor curl ile yapmak mümkün mü?</p>\n	2020-08-15 05:42:51.345058+03	7	27
14	System has not been booted with systemd as init system (PID 1). Can't operate	I'm trying to follow the Redis installation process as discuss in this [article][1] of digital ocean, in WSL. The Ubuntu version installed is Ubuntu 18.04.\n\nEverything in redis installation is fine but when I tried to run this `sudo systemctl start redis` I got this message.\n\n    System has not been booted with systemd as init system (PID 1). Can't operate.\n\nAny Idea on what should I do with that?\n\n\n  [1]: https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04	<p>I&#39;m trying to follow the Redis installation process as discuss in this <a href="https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04">article</a> of digital ocean, in WSL. The Ubuntu version installed is Ubuntu 18.04.</p>\n<p>Everything in redis installation is fine but when I tried to run this <code>sudo systemctl start redis</code> I got this message.</p>\n<pre><code>System has not been booted with systemd as init system (PID 1). Can&#39;t operate.</code></pre>\n<p>Any Idea on what should I do with that?</p>\n	2020-08-22 05:28:26.23906+03	7	10
10	Typing an adjust function	I'm looking to setup a function which takes an index, a function, and an array, and returns a clone of the array, except with the item at the index specified adjusted using the function.\n\n```typescript\nconst adjust = <T, U extends T[], V extends number>(index: V) =>\n  (f: (x: U[V]) => U[V]) => (xs: T[]) =>\n    Object.assign([], xs, { [index]: f(xs[index]) });\n```\n\nI would hope that this would return the type `U`, but it returns type:\n```typescript\nnever[] & T[] & {\n    [x: number]: U[V];\n}\n```\nAny thoughts on how I can get this to return a more usable type?	<p>I&#39;m looking to setup a function which takes an index, a function, and an array, and returns a clone of the array, except with the item at the index specified adjusted using the function.</p>\n<pre><code class="language-typescript">const adjust = &lt;T, U extends T[], V extends number&gt;(index: V) =&gt;\n  (f: (x: U[V]) =&gt; U[V]) =&gt; (xs: T[]) =&gt;\n    Object.assign([], xs, { [index]: f(xs[index]) });</code></pre>\n<p>I would hope that this would return the type <code>U</code>, but it returns type:</p>\n<pre><code class="language-typescript">never[] &amp; T[] &amp; {\n    [x: number]: U[V];\n}</code></pre>\n<p>Any thoughts on how I can get this to return a more usable type?</p>\n	2020-08-15 22:02:20.355704+03	5	65
17	Measuring web performance metrices in TypeScript front end program	My front end is written in Angular9, TypeScript. \n\nI am interested to annotate my app with different page load time performance metrics (both browser timing as well as DOM handling) as suggested by W3 working group [W3 performance working group][1]. \n\nHow can I start importing the Performance object in my TypeScript app such that I can start monitoring the different performance metrics as mentioned [here][2].\n\nThanks,\nPradip\n\n\n\n  [1]: https://www.w3.org/webperf/\n  [2]: https://web.dev/user-centric-performance-metrics/#important-metrics-to-measure	<p>My front end is written in Angular9, TypeScript. </p>\n<p>I am interested to annotate my app with different page load time performance metrics (both browser timing as well as DOM handling) as suggested by W3 working group <a href="https://www.w3.org/webperf/">W3 performance working group</a>. </p>\n<p>How can I start importing the Performance object in my TypeScript app such that I can start monitoring the different performance metrics as mentioned <a href="https://web.dev/user-centric-performance-metrics/#important-metrics-to-measure">here</a>.</p>\n<p>Thanks,\nPradip</p>\n	2020-08-22 17:49:46.384471+03	2	79
12	Unblocking clipboard access	Over the past few years, browsers have used document.execCommand() for clipboard interactions. Though widely supported, this method of cutting and pasting came at a cost: clipboard access was synchronous, and could only read and write to the DOM.\n\nThat's fine for small bits of text, but there are many cases where blocking the page for clipboard transfer is a poor experience. Time consuming sanitization or image decoding might be needed before content can be safely pasted. The browser may need to load or inline linked resources from a pasted document. That would block the page while waiting on the disk or network. Imagine adding permissions into the mix, requiring that the browser block the page while requesting clipboard access. At the same time, the permissions put in place around document.execCommand() for clipboard interaction are loosely defined and vary between browsers.\n\n```\nasync function copyPageUrl() {\n  try {\n    await navigator.clipboard.writeText(location.href);\n    console.log('Page URL copied to clipboard');\n  } catch (err) {\n    console.error('Failed to copy: ', err);\n  }\n}\n```	<p>Over the past few years, browsers have used document.execCommand() for clipboard interactions. Though widely supported, this method of cutting and pasting came at a cost: clipboard access was synchronous, and could only read and write to the DOM.</p>\n<p>That&#39;s fine for small bits of text, but there are many cases where blocking the page for clipboard transfer is a poor experience. Time consuming sanitization or image decoding might be needed before content can be safely pasted. The browser may need to load or inline linked resources from a pasted document. That would block the page while waiting on the disk or network. Imagine adding permissions into the mix, requiring that the browser block the page while requesting clipboard access. At the same time, the permissions put in place around document.execCommand() for clipboard interaction are loosely defined and vary between browsers.</p>\n<pre><code>async function copyPageUrl() {\n  try {\n    await navigator.clipboard.writeText(location.href);\n    console.log(&#39;Page URL copied to clipboard&#39;);\n  } catch (err) {\n    console.error(&#39;Failed to copy: &#39;, err);\n  }\n}</code></pre>\n	2020-08-19 00:34:09.165593+03	4	67
3	class'a müzik efekti ekleme	Merhaba, tıkladığında anlık olarak çalabilecek şekilde ayarlanmış bir bip sesim var. Bunu ben aşağıda gösterdiğim şekilde kullanmak istiyorum ama henüz CSS'de çok yeni olduğum için bir türlü çözemedim. Çeşitli js kaynaklarını denedim ama istediğim gibi çalıştıramadım ne yazıkki...\n\n<div class="butonum"></div>\n\n'a tıklanınca belirlediğim bir sound'un çalmasını istiyorum. Butona tıklanınca değil de benim yukarıda belirttiğim divimde çalmasını istiyorum.	<p>Merhaba, tıkladığında anlık olarak çalabilecek şekilde ayarlanmış bir bip sesim var. Bunu ben aşağıda gösterdiğim şekilde kullanmak istiyorum ama henüz CSS&#39;de çok yeni olduğum için bir türlü çözemedim. Çeşitli js kaynaklarını denedim ama istediğim gibi çalıştıramadım ne yazıkki...</p>\n<div class="butonum"></div>\n\n<p>&#39;a tıklanınca belirlediğim bir sound&#39;un çalmasını istiyorum. Butona tıklanınca değil de benim yukarıda belirttiğim divimde çalmasını istiyorum.</p>\n	2020-08-15 06:15:09.603639+03	2	8
18	if (!options.algorithms) throw new Error('algorithms should be set'); Error: algorithms should be set	I started learning Nodejs and i am stuck somewhere in the middle. I installed a new library from npm  and that was **express-jwt**, its showing some kind of error after running. Attached the code and the logs of the error, please help me out!\n\n\n```\nconst jwt = require('jsonwebtoken');\nrequire('dotenv').config()\nconst expressJwt =  require('express-jwt');\nconst User = require('../models/user');\n\n\n\n\nexports.requireSignin =  expressJwt({ secret:  process.env.JWT_SECRET});\n```\nThe below thing is  the logs of the error.\n\n```\n[nodemon] starting `node app.js`\nD:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22\n  if (!options.algorithms) throw new Error('algorithms should be set');\n                           ^\n\n**Error: algorithms should be set**\n    at module.exports (D:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22:34)\n    at Object.<anonymous> (D:\\shubh\\proj\\Nodejs\\nodeapi\\controllers\\auth.js:64:26)\n    at Module._compile (internal/modules/cjs/loader.js:1138:30)\n    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1158:10)\n \n```	<p>I started learning Nodejs and i am stuck somewhere in the middle. I installed a new library from npm  and that was <strong>express-jwt</strong>, its showing some kind of error after running. Attached the code and the logs of the error, please help me out!</p>\n<pre><code>const jwt = require(&#39;jsonwebtoken&#39;);\nrequire(&#39;dotenv&#39;).config()\nconst expressJwt =  require(&#39;express-jwt&#39;);\nconst User = require(&#39;../models/user&#39;);\n\n\n\n\nexports.requireSignin =  expressJwt({ secret:  process.env.JWT_SECRET});</code></pre>\n<p>The below thing is  the logs of the error.</p>\n<pre><code>[nodemon] starting `node app.js`\nD:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22\n  if (!options.algorithms) throw new Error(&#39;algorithms should be set&#39;);\n                           ^\n\n**Error: algorithms should be set**\n    at module.exports (D:\\shubh\\proj\\Nodejs\\nodeapi\\node_modules\\express-jwt\\lib\\index.js:22:34)\n    at Object.&lt;anonymous&gt; (D:\\shubh\\proj\\Nodejs\\nodeapi\\controllers\\auth.js:64:26)\n    at Module._compile (internal/modules/cjs/loader.js:1138:30)\n    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1158:10)\n</code></pre>\n	2020-08-27 18:40:52.723033+03	4	66
19	Extend Express Request object using Typescript	I’m trying to add a property to express request object from a middleware using typescript. However I can’t figure out how to add extra properties to the object. I’d prefer to not use bracket notation if possible. \n\nI’m looking for a solution that would allow me to write something similar to this (if possible):<br>\n    \n    app.use((req, res, next) => {\n        req.property = setProperty(); \n        next();\n    });\n	<p>I’m trying to add a property to express request object from a middleware using typescript. However I can’t figure out how to add extra properties to the object. I’d prefer to not use bracket notation if possible. </p>\n<p>I’m looking for a solution that would allow me to write something similar to this (if possible):<br></p>\n<pre><code>app.use((req, res, next) =&gt; {\n    req.property = setProperty(); \n    next();\n});</code></pre>\n	2020-08-28 11:31:42.023354+03	1	17
13	Yönetim paneli ver işleme kolaylığı Hk.	Arkdaşlar merhaba yapacağım bir proje için yardım almak durumundayım yardımcı olursanız sevinmirm :)\n\nWeb site yönetim paneli yapıyorum panel ve çalışır sistem hazır halde fakat veri işleme de kolaylık için aşağıdakşi sistem aklıma geldi\n\nPaneli 2 bölmeye ayırırz ve birinde web sitesi birinde veri gireceğimiz alan yer alır\nWeb sitesinde ayırdığımız bölümde siteden bir metinin üerine tıkladığımızda\nİkinci alan da buna denk gelen veri gireceğimiz alan açlır veya konumu gösterilir.\n\nJavascript ile gerçekleştirilecek bir şey bunun farkındayım fakat çok az derce de bildiğim için yardıma ihtiyacım var\n\nŞimdiden teşekkür ederim :)\n\n	<p>Arkdaşlar merhaba yapacağım bir proje için yardım almak durumundayım yardımcı olursanız sevinmirm :)</p>\n<p>Web site yönetim paneli yapıyorum panel ve çalışır sistem hazır halde fakat veri işleme de kolaylık için aşağıdakşi sistem aklıma geldi</p>\n<p>Paneli 2 bölmeye ayırırz ve birinde web sitesi birinde veri gireceğimiz alan yer alır\nWeb sitesinde ayırdığımız bölümde siteden bir metinin üerine tıkladığımızda\nİkinci alan da buna denk gelen veri gireceğimiz alan açlır veya konumu gösterilir.</p>\n<p>Javascript ile gerçekleştirilecek bir şey bunun farkındayım fakat çok az derce de bildiğim için yardıma ihtiyacım var</p>\n<p>Şimdiden teşekkür ederim :)</p>\n	2020-08-19 05:03:02.688536+03	1	130
9	How to avoid java script duplicate code in if statement	I have the following function with some stetemsnts inside:\n\n     isFieldVisible(node: any, field: DocumentField): boolean {\n            if (field.tag === 'ADDR_KOMU') {\n                let field = this.dfs_look(node.children, 'ADDR_APPLICANTTYPE');\n                return field.fieldvalue == 1;\n            }\n    \n            if (field.tag === 'ADDR_SNAME') {\n                let field = this.dfs_look(node.children, 'ADDR_APPLICANTTYPE');\n                return field.fieldvalue == 1;\n            }\n    \n            if (field.tag === 'ADDR_FNAME') {\n                let field = this.dfs_look(node.children, 'ADDR_APPLICANTTYPE');\n                  return field.fieldvalue == 1 || field.fieldvalue == 2;\n            }\n    }\nHow to improve it and avoid duplicates?\n\nI have tried to use foreach with tuple as iteration value, but I can not return boolean from foreach\n\n	<p>I have the following function with some stetemsnts inside:</p>\n<pre><code> isFieldVisible(node: any, field: DocumentField): boolean {\n        if (field.tag === &#39;ADDR_KOMU&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n            return field.fieldvalue == 1;\n        }\n\n        if (field.tag === &#39;ADDR_SNAME&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n            return field.fieldvalue == 1;\n        }\n\n        if (field.tag === &#39;ADDR_FNAME&#39;) {\n            let field = this.dfs_look(node.children, &#39;ADDR_APPLICANTTYPE&#39;);\n              return field.fieldvalue == 1 || field.fieldvalue == 2;\n        }\n}</code></pre>\n<p>How to improve it and avoid duplicates?</p>\n<p>I have tried to use foreach with tuple as iteration value, but I can not return boolean from foreach</p>\n	2020-08-15 22:01:50.198507+03	1	293
20	TS2307: Cannot find module '~express/lib/express'	I'm converting a working JavaScript file to TypeScript.\n\nI use Express in this file, so I've added the following to the top of the file:\n\n    ///<reference path="./typings/globals/node/index.d.ts" />\n    \n    import {Request} from "~express/lib/express";\n\nBut the second line produces an error:\n\n> TS2307: Cannot fine module '~express/lib/express'\n\nI've installed the typings of express, so I actually didn't wrote those two lines by myself, but WebStorm auto generated them by clicking "alt + enter", so I would expect it to work. Unfortunately I get that error.\n\nWhat am I doing wrong?	<p>I&#39;m converting a working JavaScript file to TypeScript.</p>\n<p>I use Express in this file, so I&#39;ve added the following to the top of the file:</p>\n<pre><code>///&lt;reference path=&quot;./typings/globals/node/index.d.ts&quot; /&gt;\n\nimport {Request} from &quot;~express/lib/express&quot;;</code></pre>\n<p>But the second line produces an error:</p>\n<blockquote>\n<p>TS2307: Cannot fine module &#39;~express/lib/express&#39;</p>\n</blockquote>\n<p>I&#39;ve installed the typings of express, so I actually didn&#39;t wrote those two lines by myself, but WebStorm auto generated them by clicking &quot;alt + enter&quot;, so I would expect it to work. Unfortunately I get that error.</p>\n<p>What am I doing wrong?</p>\n	2020-08-28 13:14:38.722749+03	8	9
21	How to programmatically send a 404 response with Express/Node?	I want to simulate a 404 error on my Express/Node server. How can I do that?	<p>I want to simulate a 404 error on my Express/Node server. How can I do that?</p>\n	2020-08-28 13:42:41.582811+03	9	5
6	Common object change in all component when one of them edit it	I have :\n\n**item.ts**\n\n    export interface IItem {\n      name: string;\n      isActive?: boolean;\n    }\n\n    const data: IItem[] = [\n      {\n        name: 'item1',\n        isActive: true\n      },\n      {\n        name: 'item2',\n        isActive: true\n      },\n      {\n        name: 'item3',\n        isActive: false\n      },\n      {\n        name: 'item4',\n        isActive: true\n      }\n    ];\n    export default data;\n\nI use this data in multiple component :\n\n**Component1**\n\n    export class C1Component {\n      items: IItem [] = items;\n    }\n\n**Component1**\n    \n    export class C2Component {\n      items: IItem [] = items;\n    }\n        \nWhen I make changes in the items for example delete item in Component1, the items in the other component also changed.\nI can't understand why.\n\nDoes angular Objects are loosely coupled? and how can solve this issue please.\n\n----\n\nI tried also:\n\n    ...\n    export class Menu {\n      static get data() {\n        return data;\n      }\n    }\n\nand call `Menu.data`, but the error persist and it is the same behavior.\n	<p>I have :</p>\n<p><strong>item.ts</strong></p>\n<pre><code>export interface IItem {\n  name: string;\n  isActive?: boolean;\n}\n\nconst data: IItem[] = [\n  {\n    name: &#39;item1&#39;,\n    isActive: true\n  },\n  {\n    name: &#39;item2&#39;,\n    isActive: true\n  },\n  {\n    name: &#39;item3&#39;,\n    isActive: false\n  },\n  {\n    name: &#39;item4&#39;,\n    isActive: true\n  }\n];\nexport default data;</code></pre>\n<p>I use this data in multiple component :</p>\n<p><strong>Component1</strong></p>\n<pre><code>export class C1Component {\n  items: IItem [] = items;\n}</code></pre>\n<p><strong>Component1</strong></p>\n<pre><code>export class C2Component {\n  items: IItem [] = items;\n}</code></pre>\n<p>When I make changes in the items for example delete item in Component1, the items in the other component also changed.\nI can&#39;t understand why.</p>\n<p>Does angular Objects are loosely coupled? and how can solve this issue please.</p>\n<hr>\n<p>I tried also:</p>\n<pre><code>...\nexport class Menu {\n  static get data() {\n    return data;\n  }\n}</code></pre>\n<p>and call <code>Menu.data</code>, but the error persist and it is the same behavior.</p>\n	2020-08-15 20:44:47.105469+03	7	70
4	Toast not showing on screen	<p>I have read the existing ionic 4 documentation but the following code does not show the toast:</p>\n<pre><code>async prosesLogin(){\n  if(this.username != &quot;&quot; &amp;&amp; this.password != &quot;&quot;){\n  .\n  . \n  .\n}else{\n  const toast = await this.toastCtrl.create({\n    message: &#39;Username or Password Invalid.&#39;,\n    duration: 2000\n  });\n  toast.present();\n}</code></pre>\n<p>Function prosesLogin() is executed the following way:</p>\n<pre><code>&lt;ion-button expand=&quot;block&quot; padding color=&quot;tertiary&quot; (click)=&quot;prosesLogin()&quot;&gt;Sign In&lt;/ion-button&gt;</code></pre>\n	I have read the existing ionic 4 documentation but the following code does not show the toast:\n\n```\nasync prosesLogin(){\n  if(this.username != "" && this.password != ""){\n  .\n  . \n  .\n}else{\n  const toast = await this.toastCtrl.create({\n    message: 'Username or Password Invalid.',\n    duration: 2000\n  });\n  toast.present();\n}\n```\n\nFunction prosesLogin() is executed the following way:\n\n```\n<ion-button expand="block" padding color="tertiary" (click)="prosesLogin()">Sign In</ion-button>\n```	2020-08-15 19:26:19.527143+03	3	35
7	How to correctly await a promise in TypeScript	I have some code where I `continue` a loop if a promise rejects or use its result with something that _requires_ it to be of the reolved type, as shown in the following example code:\n```typescript\nfor (const i in bar) {\n    let error = false;\n    const foo = await somePromise(i)\n        .catch(() => { error = true; });\n    if (error) continue;\n    // Something that requires foo to be resolved here\n}\n```\nMy issue is that typescript does not realize that `foo` is correctly resolved at the end (it still thinks it could be `void` due to not correctly resolving, and therefore gives a `2339` error). What is the correct, type-safe way to have typescript realize that this is fine?\n\nThe ways I have found to fix it are by stating that `foo` is of type `any`, which is not ideal and my linter doesn't like that, or using `.then`, which also sucks since I'd have to start nesting multiple `.then` statements and functions in my code, leading to massive indentations.	<p>I have some code where I <code>continue</code> a loop if a promise rejects or use its result with something that <em>requires</em> it to be of the reolved type, as shown in the following example code:</p>\n<pre><code class="language-typescript">for (const i in bar) {\n    let error = false;\n    const foo = await somePromise(i)\n        .catch(() =&gt; { error = true; });\n    if (error) continue;\n    // Something that requires foo to be resolved here\n}</code></pre>\n<p>My issue is that typescript does not realize that <code>foo</code> is correctly resolved at the end (it still thinks it could be <code>void</code> due to not correctly resolving, and therefore gives a <code>2339</code> error). What is the correct, type-safe way to have typescript realize that this is fine?</p>\n<p>The ways I have found to fix it are by stating that <code>foo</code> is of type <code>any</code>, which is not ideal and my linter doesn&#39;t like that, or using <code>.then</code>, which also sucks since I&#39;d have to start nesting multiple <code>.then</code> statements and functions in my code, leading to massive indentations.</p>\n	2020-08-15 20:45:45.439786+03	2	32
\.


--
-- Data for Name: question_answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_answer (id, content, "creationTime", "userId", "questionId") FROM stdin;
1	Hello world	2020-08-20 16:56:58.138229+03	1	13
2	Tabi kesin oyledir XD	2020-08-23 17:05:33.401625+03	3	17
4	Bos bir cevap atiyorum yine xd :D	2020-08-23 17:12:05.840719+03	1	9
5	Denemeler	2020-08-24 01:23:02.566026+03	2	17
3	Haha	2020-08-23 17:06:27.426474+03	4	17
6	Biraz daha teste devam...	2020-08-27 00:22:07.874574+03	1	17
\.


--
-- Data for Name: question_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_comment (id, content, "creationTime", "userId") FROM stdin;
\.


--
-- Data for Name: question_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_revision (id, title, content, "creationTime", "questionId") FROM stdin;
\.


--
-- Data for Name: question_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_tag (id, "questionId", "tagId", "creationTime") FROM stdin;
1	14	6	2020-08-22 05:32:34.821192+03
2	17	5	2020-08-23 00:38:40.401229+03
3	8	5	2020-08-24 03:40:03.129303+03
4	18	4	2020-08-27 18:41:42.755887+03
5	18	9	2020-08-27 18:41:45.699156+03
6	19	5	2020-08-28 11:32:11.742721+03
7	19	9	2020-08-28 11:32:15.710348+03
8	19	10	2020-08-28 11:32:20.158068+03
9	20	4	2020-08-28 13:15:22.533341+03
10	20	5	2020-08-28 13:15:25.492285+03
11	20	9	2020-08-28 13:15:29.996481+03
12	20	10	2020-08-28 13:15:34.180751+03
13	21	4	2020-08-28 13:43:18.762482+03
14	21	9	2020-08-28 13:43:22.406718+03
15	21	10	2020-08-28 13:43:26.119274+03
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (id, title, description, "creationTime") FROM stdin;
6	redis	\N	2020-08-22 05:27:50.321114+03
7	linux	\N	2020-08-22 05:27:54.414373+03
8	php	\N	2020-08-22 17:13:51.481438+03
1	html	HTML etiketi.	2020-08-16 01:10:31.840614+03
2	angular	Angular questions.	2020-08-19 02:01:23.759175+03
3	css	\N	2020-08-19 02:01:29.650449+03
4	javascript	\N	2020-08-19 02:01:34.60473+03
5	typescript	\N	2020-08-19 02:01:41.11841+03
9	node.js	\N	2020-08-27 18:41:27.986354+03
10	express	\N	2020-08-28 11:31:53.603226+03
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, password, "displayName", picture, "signupDate") FROM stdin;
6	eee	eee	Baby Rose	https://resources.tidal.com/images/35f05805/5d01/4752/af23/fc53193aadce/320x320.jpg	2020-08-16 04:44:04.301767+03
1	olcay@mail.com	12345678	Katy Perry	//localhost:9001/public/lost_a_father.jpg	2020-08-15 04:11:24.609176+03
8	sloh@mail	123456	SLOH Pink Cool	//localhost:9001/public/pink_cool.jpg	2020-08-28 11:30:56.948947+03
2	aa@mail.com	123	Alicia Keys	//localhost:9001/public/happy_easter_day.png	2020-08-15 06:14:07.492467+03
5	ddd	ddd	Are we all	//localhost:9001/public/are_we_all.png	2020-08-16 04:22:44.970259+03
9	grumpy@mail	123456	Grumpy Lannister	//localhost:9001/public/grumpy_lannister.jpg	2020-08-28 13:41:00.50064+03
4	ccc@mail	ddd	Corinne Bailey Rae	//localhost:9001/resize/48	2020-08-16 03:46:50.294483+03
7	zzz@mail	123456	Jessica Parker	//localhost:9001/public/baloon.jpg	2020-08-21 04:06:31.379266+03
3	aaa@mail.com	bbb	Olcay Usta	//localhost:9001/public/jozef_kolesar.jpg	2020-08-15 19:26:45.713453+03
\.


--
-- Name: answer_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_comment_id_seq', 1, false);


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_id_seq', 6, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 1, false);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_id_seq', 21, true);


--
-- Name: question_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_revision_id_seq', 1, false);


--
-- Name: question_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_tag_id_seq', 15, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_id_seq', 10, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 9, true);


--
-- Name: answer_comment answer_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer_comment
    ADD CONSTRAINT answer_comment_pk PRIMARY KEY (id);


--
-- Name: question_answer answer_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_answer
    ADD CONSTRAINT answer_pk PRIMARY KEY (id);


--
-- Name: notification notification_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pk PRIMARY KEY (id);


--
-- Name: question_comment question_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_comment
    ADD CONSTRAINT question_comment_pk PRIMARY KEY (id);


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
-- PostgreSQL database dump complete
--

