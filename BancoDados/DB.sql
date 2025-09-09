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

/*
drop table arestas
drop table vertices

CREATE TABLE vertices (
	id SERIAL PRIMARY KEY,
    nome varchar(50)
);

CREATE TABLE arestas (
id SERIAL PRIMARY KEY,
    origem integer,
	destino integer,
	peso real
);


INSERT INTO vertices (nome) VALUES
('AGL'),
('AGN'),
('ATA'),
('AUR'),
('BRA'),
('CHA'),
('DON'),
('GET'),
('IBI'),
('ITU'),
('JOS'),
('LAU'),
('LON'),
('MIR'),
('NER'),
('PET'),
('POU'),
('RDC'),
('RDO'),
('RDS'),
('SAL'),
('TAI'),
('TER'),
('TRO'),
('VID'),
('VIT'),
('WIT');

INSERT INTO arestas (origem, destino, peso) VALUES
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'CHA'), 64.26),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'ITU'), 16.90),
((SELECT id FROM vertices WHERE nome = 'JOS'), (SELECT id FROM vertices WHERE nome = 'TAI'), 2.00),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'SAL'), 47.25),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'POU'), 55.25),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'PET'), 18.00),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'JOS'), 30.60),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'JOS'), 22.50),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'NER'), 11.70),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'LON'), 6.80),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'LON'), 14.00),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'TAI'), 10.20),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'IBI'), 7.80),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'LON'), 22.10),
((SELECT id FROM vertices WHERE nome = 'MIR'), (SELECT id FROM vertices WHERE nome = 'VID'), 14.40),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'TRO'), 17.68),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'RDS'), 12.50),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'RDO'), 3.06),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'MIR'), 40.63),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'MIR'), 23.40),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'RDC'), 36.72),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'PET'), 39.10),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'PET'), 11.05),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'VID'), 5.40),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'NER'), 8.75),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'NER'), 21.13),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'TRO'), 6.00),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'JOS'), 15.30),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'NER'), 20.00),
((SELECT id FROM vertices WHERE nome = 'PET'), (SELECT id FROM vertices WHERE nome = 'WIT'), 15.75),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'TAI'), 27.30),
((SELECT id FROM vertices WHERE nome = 'ITU'), (SELECT id FROM vertices WHERE nome = 'TAI'), 21.13),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'SAL'), 22.10),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'PET'), 64.26),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'TER'), 23.40),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'RDS'), 6.00),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'RDC'), 39.10),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'RDC'), 1.00),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'WIT'), 43.20),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'TER'), 40.63),
((SELECT id FROM vertices WHERE nome = 'RDO'), (SELECT id FROM vertices WHERE nome = 'VIT'), 10.20),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'SAL'), 19.50),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'BRA'), 2.00),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'LON'), 6.25),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'RDC'), 17.68),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'JOS'), 15.00),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'WIT'), 36.00),
((SELECT id FROM vertices WHERE nome = 'NER'), (SELECT id FROM vertices WHERE nome = 'TAI'), 16.00),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'POU'), 25.50),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'RDS'), 19.80);
*/