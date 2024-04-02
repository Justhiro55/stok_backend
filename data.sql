--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-04-02 16:24:27 JST

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
-- TOC entry 6 (class 2615 OID 16542)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16656)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    brand_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16655)
-- Name: brands_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_brand_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_brand_id_seq OWNER TO postgres;

--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 216
-- Name: brands_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_brand_id_seq OWNED BY public.brands.brand_id;


--
-- TOC entry 221 (class 1259 OID 16681)
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.images (
    image_id integer NOT NULL,
    image_path character varying(255) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.images OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16680)
-- Name: images_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.images_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.images_image_id_seq OWNER TO postgres;

--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 220
-- Name: images_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.images_image_id_seq OWNED BY public.images.image_id;


--
-- TOC entry 219 (class 1259 OID 16667)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(255) NOT NULL,
    brand_id integer NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16666)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- TOC entry 3454 (class 2604 OID 16659)
-- Name: brands brand_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN brand_id SET DEFAULT nextval('public.brands_brand_id_seq'::regclass);


--
-- TOC entry 3456 (class 2604 OID 16684)
-- Name: images image_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images ALTER COLUMN image_id SET DEFAULT nextval('public.images_image_id_seq'::regclass);


--
-- TOC entry 3455 (class 2604 OID 16670)
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- TOC entry 3615 (class 0 OID 16656)
-- Dependencies: 217
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (brand_id, name) FROM stdin;
1	KENZO
2	A.P.C.
3	MIU MIU
4	Alexander McQUEEN
\.


--
-- TOC entry 3619 (class 0 OID 16681)
-- Dependencies: 221
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.images (image_id, image_path, product_id) FROM stdin;
42	https://stok.store/cdn/shop/files/20220304040105603_E52---kenzo---FA65PO0014PU01B_4_M1.jpg	21
43	https://stok.store/cdn/shop/files/20220304040124567_E52---kenzo---FA65PO0014PU01B_5_M1.jpg	21
44	https://stok.store/cdn/shop/files/20220304040128900_E52---kenzo---FA65PO0014PU01B_7_M1.jpg	21
45	https://stok.store/cdn/shop/files/20211218140947410_E52---apc---COETKF05822IAL_1_M1.jpg	22
46	https://stok.store/cdn/shop/files/20211218140947600_E52---apc---COETKF05822IAL_2_M1.jpg	22
47	https://stok.store/cdn/shop/files/5T953DF0503F33F0002_01_M_2024-02-22T08-12-47.316Z.jpg	23
48	https://stok.store/cdn/shop/files/5T953DF0503F33F0002_04_M_2024-02-22T08-12-47.566Z.jpg	23
49	https://stok.store/cdn/shop/files/20220125140133136_E52---alexander_20mcqueen---690812W4SQ11053_1_M1.jpg	24
50	https://stok.store/cdn/shop/files/757487WIDU11000_2023-07-07T07-27-52.221Z.jpg	25
51	https://stok.store/cdn/shop/files/757487WIDU11000_5_P_2023-07-07T07-27-52.533Z.jpg	25
52	https://stok.store/cdn/shop/files/757487WIDU11000_3_P_2023-07-07T07-27-52.392Z.jpg	25
53	https://stok.store/cdn/shop/files/6831171AAMJ_O_ALEXQ-1070.a.jpg	26
54	https://stok.store/cdn/shop/files/718139WIEE5_O_ALEXQ-8742.a.jpg	27
55	https://stok.store/cdn/shop/files/7262921AAQ0_O_ALEXQ-1000.a.jpg	28
56	https://stok.store/cdn/shop/files/20230505000427217_A55---apc---COGFAF61413LZZ_1_M1.jpg	29
57	https://stok.store/cdn/shop/files/20230505000427378_A55---apc---COGFAF61413LZZ_2_M1.jpg	29
58	https://stok.store/cdn/shop/files/20230505000427514_A55---apc---COGFAF61413LZZ_3_M1.jpg	29
59	https://stok.store/cdn/shop/files/20230505000432125_A55---apc---COGFAF61413LZZ_4_M1.jpg	29
60	https://stok.store/cdn/shop/files/20220221181331577_E52---apc---PXBMWF63412LZZBLACK_3_M1.jpg	30
61	https://stok.store/cdn/shop/files/20220221181331639_E52---apc---PXBMWF63412LZZBLACK_4_M1.jpg	30
\.


--
-- TOC entry 3617 (class 0 OID 16667)
-- Dependencies: 219
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, brand_id) FROM stdin;
21	KENZO 'TIGER CREST' POLO SHIRT	1
22	A.P.C. 'AURELIA' DENIM DRESS	2
23	MIU MIU VINTAGE LEATHER ANKLE BOOTS	3
24	Alexander McQUEEN 'SLIM TREAD' ANKLE BOOTS	4
25	STIVALETTO	4
26	Alexander McQUEEN Black leather zipped card holder with logo	4
27	Alexander McQUEEN White and clay Oversize Sneaker	4
28	Alexander McQUEEN Black camera bag with leather details	4
29	A.P.C. 'GRACE SMALL' CROSSBODY BAG	2
30	A.P.C. JAMIE' CROSSBODY BAG	2
\.


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 216
-- Name: brands_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_brand_id_seq', 27, true);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 220
-- Name: images_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.images_image_id_seq', 68, true);


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 218
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 37, true);


--
-- TOC entry 3458 (class 2606 OID 16661)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (brand_id);


--
-- TOC entry 3466 (class 2606 OID 16688)
-- Name: images images_image_path_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_image_path_key UNIQUE (image_path);


--
-- TOC entry 3468 (class 2606 OID 16686)
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (image_id);


--
-- TOC entry 3462 (class 2606 OID 16674)
-- Name: products products_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_key UNIQUE (name);


--
-- TOC entry 3464 (class 2606 OID 16672)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3460 (class 2606 OID 16665)
-- Name: brands unique_brand_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT unique_brand_name UNIQUE (name);


--
-- TOC entry 3470 (class 2606 OID 16689)
-- Name: images images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


--
-- TOC entry 3469 (class 2606 OID 16675)
-- Name: products products_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(brand_id);


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-04-02 16:24:27 JST

--
-- PostgreSQL database dump complete
--

