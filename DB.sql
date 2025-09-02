--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-09-01 21:45:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 220 (class 1259 OID 16395)
-- Name: arestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.arestas (
    id integer NOT NULL,
    origem integer,
    destino integer,
    peso integer
);


ALTER TABLE public.arestas OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16394)
-- Name: arestas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.arestas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.arestas_id_seq OWNER TO postgres;

--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 219
-- Name: arestas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.arestas_id_seq OWNED BY public.arestas.id;


--
-- TOC entry 218 (class 1259 OID 16386)
-- Name: vertices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vertices (
    id integer NOT NULL,
    nome character varying(50)
);


ALTER TABLE public.vertices OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16385)
-- Name: vertices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vertices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vertices_id_seq OWNER TO postgres;

--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 217
-- Name: vertices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vertices_id_seq OWNED BY public.vertices.id;


--
-- TOC entry 4748 (class 2604 OID 16398)
-- Name: arestas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arestas ALTER COLUMN id SET DEFAULT nextval('public.arestas_id_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 16389)
-- Name: vertices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vertices ALTER COLUMN id SET DEFAULT nextval('public.vertices_id_seq'::regclass);


--
-- TOC entry 4905 (class 0 OID 16395)
-- Dependencies: 220
-- Data for Name: arestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.arestas VALUES (1, 4, 1, 4);
INSERT INTO public.arestas VALUES (2, 4, 5, 2);
INSERT INTO public.arestas VALUES (3, 1, 3, 3);
INSERT INTO public.arestas VALUES (4, 1, 5, 4);
INSERT INTO public.arestas VALUES (5, 5, 3, 4);
INSERT INTO public.arestas VALUES (6, 5, 7, 5);
INSERT INTO public.arestas VALUES (7, 3, 6, 5);
INSERT INTO public.arestas VALUES (8, 3, 2, 2);
INSERT INTO public.arestas VALUES (9, 2, 6, 2);
INSERT INTO public.arestas VALUES (10, 7, 6, 5);
INSERT INTO public.arestas VALUES (11, 7, 9, 4);
INSERT INTO public.arestas VALUES (12, 7, 8, 5);
INSERT INTO public.arestas VALUES (13, 9, 10, 2);


--
-- TOC entry 4903 (class 0 OID 16386)
-- Dependencies: 218
-- Data for Name: vertices; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vertices VALUES (2, 'B');
INSERT INTO public.vertices VALUES (3, 'C');
INSERT INTO public.vertices VALUES (4, 'D');
INSERT INTO public.vertices VALUES (5, 'E');
INSERT INTO public.vertices VALUES (6, 'F');
INSERT INTO public.vertices VALUES (7, 'G');
INSERT INTO public.vertices VALUES (8, 'H');
INSERT INTO public.vertices VALUES (9, 'I');
INSERT INTO public.vertices VALUES (10, 'J');
INSERT INTO public.vertices VALUES (1, 'A');


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 219
-- Name: arestas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.arestas_id_seq', 13, true);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 217
-- Name: vertices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vertices_id_seq', 10, true);


--
-- TOC entry 4754 (class 2606 OID 16400)
-- Name: arestas arestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arestas
    ADD CONSTRAINT arestas_pkey PRIMARY KEY (id);


--
-- TOC entry 4750 (class 2606 OID 16393)
-- Name: vertices vertices_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vertices
    ADD CONSTRAINT vertices_nome_key UNIQUE (nome);


--
-- TOC entry 4752 (class 2606 OID 16391)
-- Name: vertices vertices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vertices
    ADD CONSTRAINT vertices_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 16406)
-- Name: arestas arestas_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arestas
    ADD CONSTRAINT arestas_destino_fkey FOREIGN KEY (destino) REFERENCES public.vertices(id);


--
-- TOC entry 4756 (class 2606 OID 16401)
-- Name: arestas arestas_origem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.arestas
    ADD CONSTRAINT arestas_origem_fkey FOREIGN KEY (origem) REFERENCES public.vertices(id);


-- Completed on 2025-09-01 21:45:09

--
-- PostgreSQL database dump complete
--

