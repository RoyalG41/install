PGDMP                         q            virtualskynet    9.2.4    9.2.2 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           1262    132485    virtualskynet    DATABASE        CREATE DATABASE virtualskynet WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE virtualskynet;
             postgres    false                        2615    132486    billing    SCHEMA        CREATE SCHEMA billing;
    DROP SCHEMA billing;
             postgres    false            	            2615    140685 
   callcenter    SCHEMA        CREATE SCHEMA callcenter;
    DROP SCHEMA callcenter;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    5            �           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    5                        2615    132488    security    SCHEMA        CREATE SCHEMA security;
    DROP SCHEMA security;
             postgres    false            �           3079    12595    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    409            �           1255    132489    cc_card_serial_set()    FUNCTION       CREATE FUNCTION cc_card_serial_set() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    UPDATE cc_card_seria SET value=value+1 WHERE id=NEW.id_seria;
    SELECT value INTO NEW.serial FROM cc_card_seria WHERE id=NEW.id_seria;
    RETURN NEW;
  END
$$;
 +   DROP FUNCTION public.cc_card_serial_set();
       public       postgres    false    5    409            �           1255    132490    cc_card_serial_update()    FUNCTION     i  CREATE FUNCTION cc_card_serial_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    IF NEW.id_seria IS NOT NULL AND NEW.id_seria = OLD.id_seria THEN
      RETURN NEW;
    END IF;
    UPDATE cc_card_seria SET value=value+1 WHERE id=NEW.id_seria;
    SELECT value INTO NEW.serial FROM cc_card_seria WHERE id=NEW.id_seria;
    RETURN NEW;
  END
$$;
 .   DROP FUNCTION public.cc_card_serial_update();
       public       postgres    false    409    5            �           1255    132491    cc_ratecard_validate_regex()    FUNCTION     �  CREATE FUNCTION cc_ratecard_validate_regex() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
  BEGIN
    IF SUBSTRING(new.dialprefix,1,1) != '_' THEN
      RETURN new;
    END IF;
    PERFORM '0' ~* REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE('^' || new.dialprefix || '$', 'X', '[0-9]', 'g'), 'Z', '[1-9]', 'g'), 'N', '[2-9]', 'g'), E'\\.', E'\\.+', 'g'), '_', '', 'g');
    RETURN new;
  END
$_$;
 3   DROP FUNCTION public.cc_ratecard_validate_regex();
       public       postgres    false    5    409            �            1259    132492    billingaccountprofile    TABLE     V   CREATE TABLE billingaccountprofile (
    id bigint NOT NULL,
    accountid integer
);
 *   DROP TABLE billing.billingaccountprofile;
       billing         postgres    false    7            �            1259    132495    billingaccountprofile_id_seq    SEQUENCE     ~   CREATE SEQUENCE billingaccountprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE billing.billingaccountprofile_id_seq;
       billing       postgres    false    7    171            �           0    0    billingaccountprofile_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE billingaccountprofile_id_seq OWNED BY billingaccountprofile.id;
            billing       postgres    false    172            �            1259    132497    billingorganizationprofile    TABLE     `   CREATE TABLE billingorganizationprofile (
    id bigint NOT NULL,
    organizationid integer
);
 /   DROP TABLE billing.billingorganizationprofile;
       billing         postgres    false    7            �            1259    132500 !   billingorganizationprofile_id_seq    SEQUENCE     �   CREATE SEQUENCE billingorganizationprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE billing.billingorganizationprofile_id_seq;
       billing       postgres    false    173    7            �           0    0 !   billingorganizationprofile_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE billingorganizationprofile_id_seq OWNED BY billingorganizationprofile.id;
            billing       postgres    false    174            �            1259    132502 
   creditcard    TABLE     �   CREATE TABLE creditcard (
    id integer NOT NULL,
    accountid integer,
    accountcode character varying(255),
    creation timestamp without time zone,
    credit double precision,
    enabled boolean
);
    DROP TABLE billing.creditcard;
       billing         postgres    false    7            �            1259    132505    openjpa_sequence_table    TABLE     ]   CREATE TABLE openjpa_sequence_table (
    id smallint NOT NULL,
    sequence_value bigint
);
 +   DROP TABLE billing.openjpa_sequence_table;
       billing         postgres    false    7            �            1259    132508    plan    TABLE     �   CREATE TABLE plan (
    id integer NOT NULL,
    buyblock integer,
    buymin integer,
    name character varying(255),
    sellblock integer,
    sellmin integer
);
    DROP TABLE billing.plan;
       billing         postgres    false    7            �            1259    132511    priority    TABLE     G   CREATE TABLE priority (
    id integer NOT NULL,
    number integer
);
    DROP TABLE billing.priority;
       billing         postgres    false    7            �            1259    132514    report    TABLE     T  CREATE TABLE report (
    id integer NOT NULL,
    billsec character varying(255),
    calldate character varying(255),
    charge character varying(255),
    clid character varying(255),
    dst character varying(255),
    duration character varying(255),
    uniqueid character varying(255),
    creditcard integer,
    tariff integer
);
    DROP TABLE billing.report;
       billing         postgres    false    7            �            1259    132520    route    TABLE     s   CREATE TABLE route (
    id bigint NOT NULL,
    name character varying(255),
    prefix character varying(255)
);
    DROP TABLE billing.route;
       billing         postgres    false    7            �            1259    132526    route_id_seq    SEQUENCE     n   CREATE SEQUENCE route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE billing.route_id_seq;
       billing       postgres    false    7    180            �           0    0    route_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE route_id_seq OWNED BY route.id;
            billing       postgres    false    181            �            1259    132528    tariff    TABLE     �   CREATE TABLE tariff (
    id integer NOT NULL,
    buyrate double precision,
    name character varying(255),
    sellrate double precision
);
    DROP TABLE billing.tariff;
       billing         postgres    false    7            �            1259    132531    trunk    TABLE     �  CREATE TABLE trunk (
    id bigint NOT NULL,
    addprefix character varying(255),
    creation timestamp without time zone,
    hostname character varying(255),
    identifier character varying(255),
    name character varying(255),
    password character varying(255),
    removeprefix character varying(255),
    tech character varying(255),
    timeout character varying(255),
    username character varying(255)
);
    DROP TABLE billing.trunk;
       billing         postgres    false    7            �            1259    132537    trunk_id_seq    SEQUENCE     n   CREATE SEQUENCE trunk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE billing.trunk_id_seq;
       billing       postgres    false    183    7            �           0    0    trunk_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE trunk_id_seq OWNED BY trunk.id;
            billing       postgres    false    184            �           1259    140686    campaign    TABLE     �   CREATE TABLE campaign (
    id integer NOT NULL,
    creationdate timestamp without time zone,
    enabled boolean,
    name character varying(255),
    organizationid integer,
    queueid integer,
    script character varying(10000)
);
     DROP TABLE callcenter.campaign;
    
   callcenter         postgres    false    9            �           1259    140694    disposition    TABLE     �   CREATE TABLE disposition (
    id integer NOT NULL,
    description character varying(255),
    name character varying(255),
    order0 integer,
    campaign_id integer
);
 #   DROP TABLE callcenter.disposition;
    
   callcenter         postgres    false    9            �           1259    140702    field    TABLE     �   CREATE TABLE field (
    id integer NOT NULL,
    name character varying(255),
    type character varying(255),
    layout_id integer
);
    DROP TABLE callcenter.field;
    
   callcenter         postgres    false    9            �           1259    140710    layout    TABLE     J   CREATE TABLE layout (
    id integer NOT NULL,
    campaign_id integer
);
    DROP TABLE callcenter.layout;
    
   callcenter         postgres    false    9            �           1259    140715    lead    TABLE     p   CREATE TABLE lead (
    id integer NOT NULL,
    attemps integer,
    fired boolean,
    campaign_id integer
);
    DROP TABLE callcenter.lead;
    
   callcenter         postgres    false    9            �           1259    140720 
   leaddetail    TABLE     �   CREATE TABLE leaddetail (
    id integer NOT NULL,
    value character varying(255),
    lead_id integer,
    field_id integer
);
 "   DROP TABLE callcenter.leaddetail;
    
   callcenter         postgres    false    9            �           1259    140725    openjpa_sequence_table    TABLE     ]   CREATE TABLE openjpa_sequence_table (
    id smallint NOT NULL,
    sequence_value bigint
);
 .   DROP TABLE callcenter.openjpa_sequence_table;
    
   callcenter         postgres    false    9            �           1259    140730    result    TABLE     p   CREATE TABLE result (
    id integer NOT NULL,
    date timestamp without time zone,
    campaign_id integer
);
    DROP TABLE callcenter.result;
    
   callcenter         postgres    false    9            �            1259    132569    cc_iax_buddies    TABLE     �  CREATE TABLE cc_iax_buddies (
    id integer NOT NULL,
    id_cc_card integer DEFAULT 0 NOT NULL,
    name character varying(80) DEFAULT ''::character varying NOT NULL,
    type character varying(6) DEFAULT 'friend'::character varying NOT NULL,
    username character varying(80) DEFAULT ''::character varying NOT NULL,
    accountcode character varying(20),
    regexten character varying(20),
    callerid character varying(80),
    amaflags character varying(7),
    secret character varying(80),
    disallow character varying(100) DEFAULT 'all'::character varying,
    allow character varying(100) DEFAULT 'gsm,ulaw,alaw'::character varying,
    host character varying(31) DEFAULT ''::character varying NOT NULL,
    qualify character varying(7) DEFAULT 'yes'::character varying NOT NULL,
    context character varying(80),
    defaultip character varying(15),
    language character varying(2),
    deny character varying(95),
    permit character varying(95),
    mask character varying(95),
    port character varying(5) DEFAULT ''::character varying NOT NULL,
    regseconds integer DEFAULT 0 NOT NULL,
    ipaddr character varying(15) DEFAULT ''::character varying NOT NULL,
    trunk character varying(3) DEFAULT 'no'::character varying,
    dbsecret character varying(40) DEFAULT ''::character varying NOT NULL,
    regcontext character varying(40) DEFAULT ''::character varying NOT NULL,
    sourceaddress character varying(20) DEFAULT ''::character varying NOT NULL,
    mohinterpret character varying(20) DEFAULT ''::character varying NOT NULL,
    mohsuggest character varying(20) DEFAULT ''::character varying NOT NULL,
    inkeys character varying(40) DEFAULT ''::character varying NOT NULL,
    outkey character varying(40) DEFAULT ''::character varying NOT NULL,
    cid_number character varying(40) DEFAULT ''::character varying NOT NULL,
    sendani character varying(10) DEFAULT ''::character varying NOT NULL,
    fullname character varying(40) DEFAULT ''::character varying NOT NULL,
    auth character varying(20) DEFAULT ''::character varying NOT NULL,
    maxauthreq character varying(15) DEFAULT ''::character varying NOT NULL,
    encryption character varying(20) DEFAULT ''::character varying NOT NULL,
    transfer character varying(10) DEFAULT ''::character varying NOT NULL,
    jitterbuffer character varying(10) DEFAULT ''::character varying NOT NULL,
    forcejitterbuffer character varying(10) DEFAULT ''::character varying NOT NULL,
    codecpriority character varying(40) DEFAULT ''::character varying NOT NULL,
    qualifysmoothing character varying(10) DEFAULT ''::character varying NOT NULL,
    qualifyfreqok character varying(10) DEFAULT ''::character varying NOT NULL,
    qualifyfreqnotok character varying(10) DEFAULT ''::character varying NOT NULL,
    timezone character varying(20) DEFAULT ''::character varying NOT NULL,
    adsi character varying(10) DEFAULT ''::character varying NOT NULL,
    setvar character varying(200) DEFAULT ''::character varying NOT NULL,
    requirecalltoken character varying(20) DEFAULT ''::character varying NOT NULL,
    maxcallnumbers character varying(10) DEFAULT ''::character varying NOT NULL,
    maxcallnumbers_nonvalidated character varying(10) DEFAULT ''::character varying NOT NULL
);
 "   DROP TABLE public.cc_iax_buddies;
       public         postgres    false    5            �            1259    132613    _cc_iax_buddies_id_seq    SEQUENCE     x   CREATE SEQUENCE _cc_iax_buddies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public._cc_iax_buddies_id_seq;
       public       postgres    false    5    185            �           0    0    _cc_iax_buddies_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE _cc_iax_buddies_id_seq OWNED BY cc_iax_buddies.id;
            public       postgres    false    186            �            1259    132615    cc_sip_buddies    TABLE     O  CREATE TABLE cc_sip_buddies (
    id integer NOT NULL,
    id_cc_card integer DEFAULT 0 NOT NULL,
    name character varying(80) DEFAULT ''::character varying NOT NULL,
    type character varying(6) DEFAULT 'friend'::character varying NOT NULL,
    username character varying(80) DEFAULT ''::character varying NOT NULL,
    accountcode character varying(20),
    regexten character varying(20),
    callerid character varying(80),
    amaflags character varying(7),
    secret character varying(80),
    md5secret character varying(80),
    nat character varying(3) DEFAULT 'yes'::character varying NOT NULL,
    dtmfmode character varying(7) DEFAULT 'RFC2833'::character varying NOT NULL,
    disallow character varying(100) DEFAULT 'all'::character varying,
    allow character varying(100) DEFAULT 'gsm,ulaw,alaw'::character varying,
    host character varying(31) DEFAULT ''::character varying NOT NULL,
    qualify character varying(7) DEFAULT 'yes'::character varying NOT NULL,
    canreinvite character varying(20) DEFAULT 'yes'::character varying,
    callgroup character varying(10),
    context character varying(80),
    defaultip character varying(15),
    fromuser character varying(80),
    fromdomain character varying(80),
    insecure character varying(20),
    language character varying(2),
    mailbox character varying(50),
    deny character varying(95),
    permit character varying(95),
    mask character varying(95),
    pickupgroup character varying(10),
    port character varying(5) DEFAULT ''::character varying NOT NULL,
    restrictcid character varying(1),
    rtptimeout character varying(3),
    rtpholdtimeout character varying(3),
    musiconhold character varying(100),
    regseconds integer DEFAULT 0 NOT NULL,
    ipaddr character varying(15) DEFAULT ''::character varying NOT NULL,
    cancallforward character varying(3) DEFAULT 'yes'::character varying,
    fullcontact character varying(80),
    setvar character varying(100) DEFAULT ''::character varying NOT NULL,
    regserver character varying(20),
    lastms character varying(11),
    defaultuser character varying(40) DEFAULT ''::character varying NOT NULL,
    auth character varying(10) DEFAULT ''::character varying NOT NULL,
    subscribemwi character varying(10) DEFAULT ''::character varying,
    vmexten character varying(20) DEFAULT ''::character varying NOT NULL,
    cid_number character varying(40) DEFAULT ''::character varying NOT NULL,
    callingpres character varying(20) DEFAULT ''::character varying NOT NULL,
    usereqphone character varying(10) DEFAULT ''::character varying NOT NULL,
    incominglimit character varying(10) DEFAULT ''::character varying NOT NULL,
    subscribecontext character varying(40) DEFAULT ''::character varying NOT NULL,
    musicclass character varying(20) DEFAULT ''::character varying NOT NULL,
    mohsuggest character varying(20) DEFAULT ''::character varying NOT NULL,
    allowtransfer character varying(20) DEFAULT ''::character varying NOT NULL,
    autoframing character varying(10) DEFAULT ''::character varying NOT NULL,
    maxcallbitrate character varying(15) DEFAULT ''::character varying NOT NULL,
    outboundproxy character varying(40) DEFAULT ''::character varying NOT NULL,
    rtpkeepalive character varying(15) DEFAULT ''::character varying NOT NULL,
    callbackextension character varying(20),
    useragent character varying(20)
);
 "   DROP TABLE public.cc_sip_buddies;
       public         postgres    false    5            �            1259    132653    _cc_sip_buddies_id_seq    SEQUENCE     x   CREATE SEQUENCE _cc_sip_buddies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public._cc_sip_buddies_id_seq;
       public       postgres    false    5    187            �           0    0    _cc_sip_buddies_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE _cc_sip_buddies_id_seq OWNED BY cc_sip_buddies.id;
            public       postgres    false    188            �            1259    132655    cc_agent    TABLE     �  CREATE TABLE cc_agent (
    id bigint NOT NULL,
    datecreation timestamp without time zone DEFAULT now(),
    active boolean DEFAULT false NOT NULL,
    login character varying(20) NOT NULL,
    passwd character varying(40),
    location text,
    language character varying(5) DEFAULT 'en'::text,
    id_tariffgroup integer,
    options integer DEFAULT 0 NOT NULL,
    credit numeric(15,5) DEFAULT 0 NOT NULL,
    currency character varying(3) DEFAULT 'USD'::character varying NOT NULL,
    locale character varying(10) DEFAULT 'C'::character varying,
    commission numeric(10,4) DEFAULT 0 NOT NULL,
    vat numeric(10,4) DEFAULT 0 NOT NULL,
    banner text,
    perms integer,
    lastname character varying(50),
    firstname character varying(50),
    address character varying(100),
    city character varying(40),
    state character varying(40),
    country character varying(40),
    zipcode character varying(20),
    phone character varying(20),
    email character varying(70),
    fax character varying(20),
    company character varying(50),
    com_balance numeric(15,5) NOT NULL,
    threshold_remittance numeric(15,5) NOT NULL,
    bank_info text
);
    DROP TABLE public.cc_agent;
       public         postgres    true    5            �            1259    132670    cc_agent_commission    TABLE     \  CREATE TABLE cc_agent_commission (
    id bigint NOT NULL,
    id_payment bigint,
    id_card bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    amount numeric(15,5) NOT NULL,
    description text,
    id_agent integer NOT NULL,
    commission_type smallint NOT NULL,
    commission_percent numeric(10,4) NOT NULL
);
 '   DROP TABLE public.cc_agent_commission;
       public         postgres    true    5            �            1259    132677    cc_agent_commission_id_seq    SEQUENCE     |   CREATE SEQUENCE cc_agent_commission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.cc_agent_commission_id_seq;
       public       postgres    false    5    190            �           0    0    cc_agent_commission_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE cc_agent_commission_id_seq OWNED BY cc_agent_commission.id;
            public       postgres    false    191            �            1259    132679    cc_agent_id_seq    SEQUENCE     q   CREATE SEQUENCE cc_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cc_agent_id_seq;
       public       postgres    false    189    5            �           0    0    cc_agent_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE cc_agent_id_seq OWNED BY cc_agent.id;
            public       postgres    false    192            �            1259    132681    cc_agent_signup    TABLE     �   CREATE TABLE cc_agent_signup (
    id bigint NOT NULL,
    id_agent integer NOT NULL,
    code character varying(30) NOT NULL,
    id_tariffgroup integer NOT NULL,
    id_group integer NOT NULL
);
 #   DROP TABLE public.cc_agent_signup;
       public         postgres    true    5            �            1259    132684    cc_agent_signup_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_agent_signup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_agent_signup_id_seq;
       public       postgres    false    193    5            �           0    0    cc_agent_signup_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_agent_signup_id_seq OWNED BY cc_agent_signup.id;
            public       postgres    false    194            �            1259    132686    cc_agent_tariffgroup    TABLE     i   CREATE TABLE cc_agent_tariffgroup (
    id_agent bigint NOT NULL,
    id_tariffgroup integer NOT NULL
);
 (   DROP TABLE public.cc_agent_tariffgroup;
       public         postgres    true    5            �            1259    132689    cc_alarm    TABLE       CREATE TABLE cc_alarm (
    id bigint NOT NULL,
    name text NOT NULL,
    periode integer DEFAULT 1 NOT NULL,
    type integer DEFAULT 1 NOT NULL,
    maxvalue numeric NOT NULL,
    minvalue numeric DEFAULT (-1) NOT NULL,
    id_trunk integer,
    status integer DEFAULT 0 NOT NULL,
    numberofrun integer DEFAULT 0 NOT NULL,
    numberofalarm integer DEFAULT 0 NOT NULL,
    datecreate timestamp without time zone DEFAULT now(),
    datelastrun timestamp without time zone DEFAULT now(),
    emailreport text
);
    DROP TABLE public.cc_alarm;
       public         postgres    true    5            �            1259    132703    cc_alarm_id_seq    SEQUENCE     q   CREATE SEQUENCE cc_alarm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.cc_alarm_id_seq;
       public       postgres    false    5    196            �           0    0    cc_alarm_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE cc_alarm_id_seq OWNED BY cc_alarm.id;
            public       postgres    false    197            �            1259    132705    cc_alarm_report    TABLE     �   CREATE TABLE cc_alarm_report (
    id bigint NOT NULL,
    cc_alarm_id bigint NOT NULL,
    calculatedvalue numeric NOT NULL,
    daterun timestamp without time zone DEFAULT now()
);
 #   DROP TABLE public.cc_alarm_report;
       public         postgres    true    5            �            1259    132712    cc_alarm_report_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_alarm_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_alarm_report_id_seq;
       public       postgres    false    5    198            �           0    0    cc_alarm_report_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_alarm_report_id_seq OWNED BY cc_alarm_report.id;
            public       postgres    false    199            �            1259    132714    cc_autorefill_report    TABLE     �   CREATE TABLE cc_autorefill_report (
    id bigint NOT NULL,
    daterun timestamp(0) without time zone DEFAULT now(),
    totalcardperform integer,
    totalcredit double precision
);
 (   DROP TABLE public.cc_autorefill_report;
       public         postgres    true    5            �            1259    132718    cc_autorefill_report_id_seq    SEQUENCE     }   CREATE SEQUENCE cc_autorefill_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cc_autorefill_report_id_seq;
       public       postgres    false    5    200            �           0    0    cc_autorefill_report_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE cc_autorefill_report_id_seq OWNED BY cc_autorefill_report.id;
            public       postgres    false    201            �            1259    132720 	   cc_backup    TABLE     �   CREATE TABLE cc_backup (
    id bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    path character varying(255) DEFAULT ''::character varying NOT NULL,
    creationdate timestamp without time zone DEFAULT now()
);
    DROP TABLE public.cc_backup;
       public         postgres    true    5            �            1259    132729    cc_backup_id_seq    SEQUENCE     r   CREATE SEQUENCE cc_backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cc_backup_id_seq;
       public       postgres    false    202    5            �           0    0    cc_backup_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE cc_backup_id_seq OWNED BY cc_backup.id;
            public       postgres    false    203            �            1259    132731    cc_billing_customer    TABLE     �   CREATE TABLE cc_billing_customer (
    id bigint NOT NULL,
    id_card bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    id_invoice bigint NOT NULL,
    start_date timestamp without time zone
);
 '   DROP TABLE public.cc_billing_customer;
       public         postgres    true    5            �            1259    132735    cc_billing_customer_id_seq    SEQUENCE     |   CREATE SEQUENCE cc_billing_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.cc_billing_customer_id_seq;
       public       postgres    false    5    204            �           0    0    cc_billing_customer_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE cc_billing_customer_id_seq OWNED BY cc_billing_customer.id;
            public       postgres    false    205            �            1259    132737    cc_call    TABLE     �  CREATE TABLE cc_call (
    id bigint NOT NULL,
    card_id bigint NOT NULL,
    sessionid text NOT NULL,
    uniqueid text NOT NULL,
    nasipaddress text,
    starttime timestamp without time zone,
    stoptime timestamp without time zone,
    sessiontime integer,
    calledstation text,
    destination integer DEFAULT 0,
    terminatecauseid smallint DEFAULT 1,
    sessionbill double precision,
    id_tariffgroup integer,
    id_tariffplan integer,
    id_ratecard integer,
    id_trunk integer,
    sipiax integer DEFAULT 0,
    src text,
    id_did integer,
    buycost numeric(15,5) DEFAULT 0,
    id_card_package_offer integer DEFAULT 0,
    real_sessiontime integer,
    dnid character varying(40)
);
    DROP TABLE public.cc_call;
       public         postgres    true    5            �            1259    132748    cc_call_archive    TABLE     �  CREATE TABLE cc_call_archive (
    id bigint NOT NULL,
    sessionid character varying(40) NOT NULL,
    uniqueid character varying(30) NOT NULL,
    card_id bigint NOT NULL,
    nasipaddress character varying(30) NOT NULL,
    starttime timestamp without time zone DEFAULT now() NOT NULL,
    stoptime timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    sessiontime integer,
    calledstation character varying(30) NOT NULL,
    sessionbill double precision,
    id_tariffgroup integer,
    id_tariffplan integer,
    id_ratecard integer,
    id_trunk integer,
    sipiax integer DEFAULT 0,
    src character varying(40) NOT NULL,
    id_did integer,
    buycost numeric(15,5) DEFAULT 0.00000,
    id_card_package_offer integer DEFAULT 0,
    real_sessiontime integer,
    dnid character varying(40) NOT NULL,
    terminatecauseid smallint DEFAULT 1,
    destination integer DEFAULT 0
);
 #   DROP TABLE public.cc_call_archive;
       public         postgres    false    5            �            1259    132758    cc_call_archive_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_call_archive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_call_archive_id_seq;
       public       postgres    false    207    5            �           0    0    cc_call_archive_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_call_archive_id_seq OWNED BY cc_call_archive.id;
            public       postgres    false    208            �            1259    132760    cc_call_id_seq    SEQUENCE     p   CREATE SEQUENCE cc_call_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cc_call_id_seq;
       public       postgres    false    206    5            �           0    0    cc_call_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE cc_call_id_seq OWNED BY cc_call.id;
            public       postgres    false    209            �            1259    132762    cc_callback_spool    TABLE     �  CREATE TABLE cc_callback_spool (
    id bigint NOT NULL,
    uniqueid text,
    entry_time timestamp without time zone DEFAULT now(),
    status text,
    server_ip text,
    num_attempt integer DEFAULT 0 NOT NULL,
    last_attempt_time timestamp without time zone,
    manager_result text,
    agi_result text,
    callback_time timestamp without time zone,
    channel text,
    exten text,
    context text,
    priority text,
    application text,
    data text,
    timeout text,
    callerid text,
    variable character varying(300),
    account text,
    async text,
    actionid text,
    id_server integer,
    id_server_group integer
);
 %   DROP TABLE public.cc_callback_spool;
       public         postgres    true    5            �            1259    132770    cc_callback_spool_id_seq    SEQUENCE     z   CREATE SEQUENCE cc_callback_spool_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.cc_callback_spool_id_seq;
       public       postgres    false    5    210            �           0    0    cc_callback_spool_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE cc_callback_spool_id_seq OWNED BY cc_callback_spool.id;
            public       postgres    false    211            �            1259    132772    cc_callerid    TABLE     �   CREATE TABLE cc_callerid (
    id bigint NOT NULL,
    cid text NOT NULL,
    id_cc_card bigint NOT NULL,
    activated boolean DEFAULT true NOT NULL
);
    DROP TABLE public.cc_callerid;
       public         postgres    true    5            �            1259    132779    cc_callerid_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_callerid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_callerid_id_seq;
       public       postgres    false    212    5            �           0    0    cc_callerid_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_callerid_id_seq OWNED BY cc_callerid.id;
            public       postgres    false    213            �            1259    132781 	   cc_prefix    TABLE     g   CREATE TABLE cc_prefix (
    prefix bigint NOT NULL,
    destination character varying(60) NOT NULL
);
    DROP TABLE public.cc_prefix;
       public         postgres    true    5            �            1259    132784    cc_ratecard    TABLE     �  CREATE TABLE cc_ratecard (
    id integer NOT NULL,
    idtariffplan integer DEFAULT 0 NOT NULL,
    dialprefix text NOT NULL,
    destination bigint DEFAULT 0 NOT NULL,
    buyrate numeric(15,5) DEFAULT 0 NOT NULL,
    buyrateinitblock integer DEFAULT 0 NOT NULL,
    buyrateincrement integer DEFAULT 0 NOT NULL,
    rateinitial numeric(15,5) DEFAULT 0 NOT NULL,
    initblock integer DEFAULT 0 NOT NULL,
    billingblock integer DEFAULT 0 NOT NULL,
    connectcharge numeric(15,5) DEFAULT 0 NOT NULL,
    disconnectcharge numeric(15,5) DEFAULT 0 NOT NULL,
    stepchargea numeric(15,5) DEFAULT 0 NOT NULL,
    chargea numeric(15,5) DEFAULT 0 NOT NULL,
    timechargea integer DEFAULT 0 NOT NULL,
    billingblocka integer DEFAULT 0 NOT NULL,
    stepchargeb numeric(15,5) DEFAULT 0 NOT NULL,
    chargeb numeric(15,5) DEFAULT 0 NOT NULL,
    timechargeb integer DEFAULT 0 NOT NULL,
    billingblockb integer DEFAULT 0 NOT NULL,
    stepchargec numeric(15,5) DEFAULT 0 NOT NULL,
    chargec numeric(15,5) DEFAULT 0 NOT NULL,
    timechargec integer DEFAULT 0 NOT NULL,
    billingblockc integer DEFAULT 0 NOT NULL,
    startdate timestamp(0) without time zone DEFAULT now(),
    stopdate timestamp(0) without time zone,
    starttime integer DEFAULT 0 NOT NULL,
    endtime integer DEFAULT 10079 NOT NULL,
    id_trunk integer DEFAULT (-1),
    musiconhold character varying(100),
    id_outbound_cidgroup integer DEFAULT (-1) NOT NULL,
    rounding_calltime integer DEFAULT 0 NOT NULL,
    rounding_threshold integer DEFAULT 0 NOT NULL,
    additional_block_charge numeric(15,5) DEFAULT 0 NOT NULL,
    additional_block_charge_time integer DEFAULT 0 NOT NULL,
    tag character varying(50),
    is_merged integer DEFAULT 0,
    additional_grace integer DEFAULT 0 NOT NULL,
    minimal_cost numeric(15,5) DEFAULT 0 NOT NULL,
    announce_time_correction numeric(5,3) DEFAULT 1.0 NOT NULL,
    disconnectcharge_after integer DEFAULT 0 NOT NULL,
    billingorganizationprofile_id integer
);
    DROP TABLE public.cc_ratecard;
       public         postgres    true    5            �            1259    132826    cc_tariffgroup    TABLE     y  CREATE TABLE cc_tariffgroup (
    id integer NOT NULL,
    iduser integer DEFAULT 0 NOT NULL,
    idtariffplan integer DEFAULT 0 NOT NULL,
    tariffgroupname text NOT NULL,
    lcrtype integer DEFAULT 0 NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    removeinterprefix integer DEFAULT 0 NOT NULL,
    id_cc_package_offer bigint DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.cc_tariffgroup;
       public         postgres    true    5            �            1259    132838    cc_tariffgroup_plan    TABLE     l   CREATE TABLE cc_tariffgroup_plan (
    idtariffgroup integer NOT NULL,
    idtariffplan integer NOT NULL
);
 '   DROP TABLE public.cc_tariffgroup_plan;
       public         postgres    true    5            �            1259    132841    cc_tariffplan    TABLE     �  CREATE TABLE cc_tariffplan (
    id integer NOT NULL,
    iduser integer DEFAULT 0 NOT NULL,
    tariffname text NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    startingdate timestamp without time zone DEFAULT now(),
    expirationdate timestamp without time zone,
    description text,
    id_trunk integer DEFAULT 0,
    secondusedreal integer DEFAULT 0,
    secondusedcarrier integer DEFAULT 0,
    secondusedratecard integer DEFAULT 0,
    reftariffplan integer DEFAULT 0,
    idowner integer DEFAULT 0,
    dnidprefix text DEFAULT 'all'::text NOT NULL,
    calleridprefix text DEFAULT 'all'::text NOT NULL
);
 !   DROP TABLE public.cc_tariffplan;
       public         postgres    true    5            �            1259    132858    cc_callplan_lcr    VIEW     �  CREATE VIEW cc_callplan_lcr AS
    SELECT cc_ratecard.id, cc_prefix.destination, cc_ratecard.dialprefix, cc_ratecard.buyrate, cc_ratecard.rateinitial, cc_ratecard.startdate, cc_ratecard.stopdate, cc_ratecard.initblock, cc_ratecard.connectcharge, cc_ratecard.id_trunk, cc_ratecard.idtariffplan, cc_ratecard.id AS ratecard_id, cc_tariffgroup.id AS tariffgroup_id FROM ((((cc_tariffgroup RIGHT JOIN cc_tariffgroup_plan ON ((cc_tariffgroup_plan.idtariffgroup = cc_tariffgroup.id))) JOIN cc_tariffplan ON ((cc_tariffplan.id = cc_tariffgroup_plan.idtariffplan))) LEFT JOIN cc_ratecard ON ((cc_ratecard.idtariffplan = cc_tariffplan.id))) LEFT JOIN cc_prefix ON ((cc_prefix.prefix = cc_ratecard.destination))) WHERE (cc_ratecard.id IS NOT NULL);
 "   DROP VIEW public.cc_callplan_lcr;
       public       postgres    false    215    214    215    214    215    215    218    215    217    215    217    216    215    215    215    215    215    5            �            1259    132863    cc_campaign    TABLE     �  CREATE TABLE cc_campaign (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    startingdate timestamp without time zone DEFAULT now(),
    expirationdate timestamp without time zone,
    description text,
    id_card bigint DEFAULT (0)::bigint NOT NULL,
    secondusedreal integer DEFAULT 0,
    nb_callmade integer DEFAULT 0,
    status integer DEFAULT 1 NOT NULL,
    frequency integer DEFAULT 20 NOT NULL,
    forward_number character varying(50),
    daily_start_time time without time zone DEFAULT '10:00:00'::time without time zone NOT NULL,
    daily_stop_time time without time zone DEFAULT '18:00:00'::time without time zone NOT NULL,
    monday smallint DEFAULT (1)::smallint NOT NULL,
    tuesday smallint DEFAULT (1)::smallint NOT NULL,
    wednesday smallint DEFAULT (1)::smallint NOT NULL,
    thursday smallint DEFAULT (1)::smallint NOT NULL,
    friday smallint DEFAULT (1)::smallint NOT NULL,
    saturday smallint DEFAULT (0)::smallint NOT NULL,
    sunday smallint DEFAULT (0)::smallint NOT NULL,
    id_cid_group integer NOT NULL,
    id_campaign_config integer NOT NULL,
    callerid character varying(60) NOT NULL
);
    DROP TABLE public.cc_campaign;
       public         postgres    true    5            �            1259    132885    cc_campaign_config    TABLE     �   CREATE TABLE cc_campaign_config (
    id integer NOT NULL,
    name character varying(40) NOT NULL,
    flatrate numeric(15,5) DEFAULT 0 NOT NULL,
    context character varying(40) NOT NULL,
    description text
);
 &   DROP TABLE public.cc_campaign_config;
       public         postgres    true    5            �            1259    132892    cc_campaign_config_id_seq    SEQUENCE     {   CREATE SEQUENCE cc_campaign_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cc_campaign_config_id_seq;
       public       postgres    false    5    221            �           0    0    cc_campaign_config_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE cc_campaign_config_id_seq OWNED BY cc_campaign_config.id;
            public       postgres    false    222            �            1259    132894    cc_campaign_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_campaign_id_seq;
       public       postgres    false    220    5            �           0    0    cc_campaign_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_campaign_id_seq OWNED BY cc_campaign.id;
            public       postgres    false    223            �            1259    132896    cc_campaign_phonebook    TABLE     l   CREATE TABLE cc_campaign_phonebook (
    id_campaign integer NOT NULL,
    id_phonebook integer NOT NULL
);
 )   DROP TABLE public.cc_campaign_phonebook;
       public         postgres    true    5            �            1259    132899    cc_campaign_phonestatus    TABLE       CREATE TABLE cc_campaign_phonestatus (
    id_phonenumber bigint NOT NULL,
    id_campaign integer NOT NULL,
    id_callback character varying(40) NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    lastuse timestamp without time zone DEFAULT now() NOT NULL
);
 +   DROP TABLE public.cc_campaign_phonestatus;
       public         postgres    true    5            �            1259    132904    cc_campaignconf_cardgroup    TABLE     x   CREATE TABLE cc_campaignconf_cardgroup (
    id_campaign_config integer NOT NULL,
    id_card_group integer NOT NULL
);
 -   DROP TABLE public.cc_campaignconf_cardgroup;
       public         postgres    true    5            �            1259    132907    cc_card    TABLE     �
  CREATE TABLE cc_card (
    id bigint NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    firstusedate timestamp without time zone,
    expirationdate timestamp without time zone,
    enableexpire integer DEFAULT 0,
    expiredays integer DEFAULT 0,
    username text NOT NULL,
    useralias text NOT NULL,
    uipass text,
    credit numeric(12,4) NOT NULL,
    tariff integer DEFAULT 0,
    id_didgroup integer DEFAULT 0,
    activated boolean DEFAULT false NOT NULL,
    lastname text,
    firstname text,
    address text,
    city text,
    state text,
    country text,
    zipcode text,
    phone text,
    email text,
    fax text,
    inuse integer DEFAULT 0,
    simultaccess integer DEFAULT 0,
    currency character varying(3) DEFAULT 'USD'::character varying,
    lastuse date DEFAULT now(),
    nbused integer DEFAULT 0,
    typepaid integer DEFAULT 0,
    creditlimit integer DEFAULT 0,
    voipcall integer DEFAULT 0,
    sip_buddy integer DEFAULT 0,
    iax_buddy integer DEFAULT 0,
    language text DEFAULT 'en'::text,
    redial text,
    runservice integer DEFAULT 0,
    nbservice integer DEFAULT 0,
    id_campaign integer DEFAULT 0,
    num_trials_done integer DEFAULT 0,
    vat numeric(6,3) DEFAULT 0,
    servicelastrun timestamp without time zone,
    initialbalance numeric(12,4) DEFAULT 0 NOT NULL,
    invoiceday integer DEFAULT 1,
    autorefill integer DEFAULT 0,
    loginkey text,
    mac_addr character varying(17) DEFAULT '00-00-00-00-00-00'::character varying NOT NULL,
    id_timezone integer DEFAULT 0,
    status integer DEFAULT 1 NOT NULL,
    tag character varying(50),
    voicemail_permitted integer DEFAULT 0 NOT NULL,
    voicemail_activated integer DEFAULT 0 NOT NULL,
    last_notification timestamp without time zone,
    email_notification character varying(70),
    notify_email smallint DEFAULT 0 NOT NULL,
    credit_notification integer DEFAULT (-1) NOT NULL,
    id_group integer DEFAULT 1 NOT NULL,
    company_name character varying(50),
    company_website character varying(60),
    vat_rn character varying(40) DEFAULT NULL::character varying,
    traffic bigint DEFAULT 0,
    traffic_target text,
    discount numeric(5,2) DEFAULT (0)::numeric NOT NULL,
    restriction smallint DEFAULT (0)::smallint NOT NULL,
    id_seria integer,
    serial bigint,
    block smallint DEFAULT 0 NOT NULL,
    lock_pin character varying(15) DEFAULT NULL::character varying,
    lock_date timestamp without time zone,
    max_concurrent character varying(20),
    voiceprofile_id integer,
    accountid integer,
    billingprofile_id integer,
    accountprofile_id integer,
    organizationprofile_id integer,
    billingaccountprofile_id integer,
    billingorganizationprofile_id integer
);
    DROP TABLE public.cc_card;
       public         postgres    true    5            �            1259    132952    cc_card_archive    TABLE     	  CREATE TABLE cc_card_archive (
    id bigint NOT NULL,
    creationdate timestamp without time zone,
    firstusedate timestamp without time zone,
    expirationdate timestamp without time zone,
    enableexpire integer DEFAULT 0,
    expiredays integer DEFAULT 0,
    username text NOT NULL,
    useralias text NOT NULL,
    uipass text,
    credit numeric(12,4) NOT NULL,
    tariff integer DEFAULT 0,
    id_didgroup integer DEFAULT 0,
    activated boolean DEFAULT false NOT NULL,
    lastname text,
    firstname text,
    address text,
    city text,
    state text,
    country text,
    zipcode text,
    phone text,
    email text,
    fax text,
    inuse integer DEFAULT 0,
    simultaccess integer DEFAULT 0,
    currency character varying(3) DEFAULT 'USD'::character varying,
    lastuse date DEFAULT now(),
    nbused integer DEFAULT 0,
    typepaid integer DEFAULT 0,
    creditlimit integer DEFAULT 0,
    voipcall integer DEFAULT 0,
    sip_buddy integer DEFAULT 0,
    iax_buddy integer DEFAULT 0,
    language text DEFAULT 'en'::text,
    redial text,
    runservice integer DEFAULT 0,
    nbservice integer DEFAULT 0,
    id_campaign integer DEFAULT 0,
    num_trials_done integer DEFAULT 0,
    vat numeric(6,3) DEFAULT 0,
    servicelastrun timestamp without time zone,
    initialbalance numeric(12,4) DEFAULT 0 NOT NULL,
    invoiceday integer DEFAULT 1,
    autorefill integer DEFAULT 0,
    loginkey text,
    mac_addr character varying(17) DEFAULT '00-00-00-00-00-00'::character varying NOT NULL,
    id_timezone integer DEFAULT 0,
    status integer DEFAULT 1 NOT NULL,
    tag character varying(50),
    voicemail_permitted integer DEFAULT 0 NOT NULL,
    voicemail_activated integer DEFAULT 0 NOT NULL,
    last_notification timestamp without time zone,
    email_notification character varying(70),
    notify_email smallint DEFAULT 0 NOT NULL,
    credit_notification integer DEFAULT (-1) NOT NULL,
    id_group integer DEFAULT 1 NOT NULL,
    company_name character varying(50),
    company_website character varying(60),
    vat_rn character varying(40) DEFAULT NULL::character varying,
    traffic bigint DEFAULT 0,
    traffic_target text,
    discount numeric(5,2) DEFAULT (0)::numeric NOT NULL,
    restriction smallint DEFAULT (0)::smallint NOT NULL,
    id_seria integer,
    serial bigint
);
 #   DROP TABLE public.cc_card_archive;
       public         postgres    true    5            �            1259    132994    cc_card_archive_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_card_archive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_card_archive_id_seq;
       public       postgres    false    228    5            �           0    0    cc_card_archive_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_card_archive_id_seq OWNED BY cc_card_archive.id;
            public       postgres    false    229            �            1259    132996    cc_card_group    TABLE     o  CREATE TABLE cc_card_group (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(400) DEFAULT NULL::character varying,
    users_perms integer DEFAULT 0 NOT NULL,
    id_agent integer,
    flatrate numeric(15,5) DEFAULT 0 NOT NULL,
    campaign_context character varying(40),
    provisioning character varying(200)
);
 !   DROP TABLE public.cc_card_group;
       public         postgres    true    5            �            1259    133005    cc_card_group_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_card_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_card_group_id_seq;
       public       postgres    false    230    5            �           0    0    cc_card_group_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_card_group_id_seq OWNED BY cc_card_group.id;
            public       postgres    false    231            �            1259    133007    cc_card_history    TABLE     �   CREATE TABLE cc_card_history (
    id bigint NOT NULL,
    id_cc_card bigint,
    datecreated timestamp without time zone DEFAULT now(),
    description text
);
 #   DROP TABLE public.cc_card_history;
       public         postgres    true    5            �            1259    133014    cc_card_history_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_card_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_card_history_id_seq;
       public       postgres    false    232    5            �           0    0    cc_card_history_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_card_history_id_seq OWNED BY cc_card_history.id;
            public       postgres    false    233            �            1259    133016    cc_card_id_seq    SEQUENCE     p   CREATE SEQUENCE cc_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cc_card_id_seq;
       public       postgres    false    227    5            �           0    0    cc_card_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE cc_card_id_seq OWNED BY cc_card.id;
            public       postgres    false    234            �            1259    133018    cc_card_package_offer    TABLE     �   CREATE TABLE cc_card_package_offer (
    id bigint NOT NULL,
    id_cc_card bigint NOT NULL,
    id_cc_package_offer bigint NOT NULL,
    date_consumption timestamp without time zone DEFAULT now(),
    used_secondes bigint NOT NULL
);
 )   DROP TABLE public.cc_card_package_offer;
       public         postgres    true    5            �            1259    133022    cc_card_package_offer_id_seq    SEQUENCE     ~   CREATE SEQUENCE cc_card_package_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.cc_card_package_offer_id_seq;
       public       postgres    false    235    5            �           0    0    cc_card_package_offer_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE cc_card_package_offer_id_seq OWNED BY cc_card_package_offer.id;
            public       postgres    false    236            �            1259    133024    cc_card_seria    TABLE     �   CREATE TABLE cc_card_seria (
    id integer NOT NULL,
    name character(30) NOT NULL,
    description text,
    value bigint DEFAULT 0 NOT NULL
);
 !   DROP TABLE public.cc_card_seria;
       public         postgres    true    5            �            1259    133031    cc_card_seria_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_card_seria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_card_seria_id_seq;
       public       postgres    false    5    237            �           0    0    cc_card_seria_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_card_seria_id_seq OWNED BY cc_card_seria.id;
            public       postgres    false    238            �            1259    133033    cc_card_subscription    TABLE       CREATE TABLE cc_card_subscription (
    id bigint NOT NULL,
    id_cc_card bigint DEFAULT 0 NOT NULL,
    id_subscription_fee integer DEFAULT 0 NOT NULL,
    startdate timestamp without time zone DEFAULT now(),
    stopdate timestamp without time zone,
    product_id character varying(100) DEFAULT NULL::character varying,
    product_name character varying(100) DEFAULT NULL::character varying,
    paid_status smallint DEFAULT 0 NOT NULL,
    last_run timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    next_billing_date timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    limit_pay_date timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);
 (   DROP TABLE public.cc_card_subscription;
       public         postgres    true    5            �            1259    133045    cc_card_subscription_id_seq    SEQUENCE     }   CREATE SEQUENCE cc_card_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cc_card_subscription_id_seq;
       public       postgres    false    5    239            �           0    0    cc_card_subscription_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE cc_card_subscription_id_seq OWNED BY cc_card_subscription.id;
            public       postgres    false    240            �            1259    133047    cc_cardgroup_service    TABLE     k   CREATE TABLE cc_cardgroup_service (
    id_card_group integer NOT NULL,
    id_service integer NOT NULL
);
 (   DROP TABLE public.cc_cardgroup_service;
       public         postgres    true    5            �            1259    133050 	   cc_charge    TABLE     �  CREATE TABLE cc_charge (
    id bigint NOT NULL,
    id_cc_card bigint NOT NULL,
    iduser integer DEFAULT 0 NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    amount numeric(12,4) NOT NULL,
    chargetype integer DEFAULT 0,
    description text,
    id_cc_did bigint DEFAULT 0,
    id_cc_card_subscription bigint,
    cover_from date,
    cover_to date,
    charged_status smallint DEFAULT (0)::smallint NOT NULL,
    invoiced_status smallint DEFAULT (0)::smallint NOT NULL
);
    DROP TABLE public.cc_charge;
       public         postgres    true    5            �            1259    133062    cc_charge_id_seq    SEQUENCE     r   CREATE SEQUENCE cc_charge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cc_charge_id_seq;
       public       postgres    false    242    5            �           0    0    cc_charge_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE cc_charge_id_seq OWNED BY cc_charge.id;
            public       postgres    false    243            �            1259    133064 	   cc_config    TABLE     W  CREATE TABLE cc_config (
    id integer NOT NULL,
    config_title character varying(100) NOT NULL,
    config_key character varying(100) NOT NULL,
    config_value text NOT NULL,
    config_description text,
    config_valuetype integer DEFAULT 0 NOT NULL,
    config_listvalues text,
    config_group_title character varying(64) NOT NULL
);
    DROP TABLE public.cc_config;
       public         postgres    true    5            �            1259    133071    cc_config_group    TABLE     �   CREATE TABLE cc_config_group (
    id integer NOT NULL,
    group_title character varying(64) NOT NULL,
    group_description character varying(255) NOT NULL
);
 #   DROP TABLE public.cc_config_group;
       public         postgres    true    5            �            1259    133074    cc_config_group_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_config_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_config_group_id_seq;
       public       postgres    false    245    5            �           0    0    cc_config_group_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_config_group_id_seq OWNED BY cc_config_group.id;
            public       postgres    false    246            �            1259    133076    cc_config_id_seq    SEQUENCE     r   CREATE SEQUENCE cc_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cc_config_id_seq;
       public       postgres    false    5    244            �           0    0    cc_config_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE cc_config_id_seq OWNED BY cc_config.id;
            public       postgres    false    247            �            1259    133078    cc_configuration    TABLE     �  CREATE TABLE cc_configuration (
    configuration_id bigint NOT NULL,
    configuration_title character varying(64) NOT NULL,
    configuration_key character varying(64) NOT NULL,
    configuration_value character varying(255) NOT NULL,
    configuration_description character varying(255) NOT NULL,
    configuration_type integer DEFAULT 0 NOT NULL,
    use_function character varying(255),
    set_function character varying(255)
);
 $   DROP TABLE public.cc_configuration;
       public         postgres    true    5            �            1259    133085 %   cc_configuration_configuration_id_seq    SEQUENCE     �   CREATE SEQUENCE cc_configuration_configuration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.cc_configuration_configuration_id_seq;
       public       postgres    false    248    5            �           0    0 %   cc_configuration_configuration_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE cc_configuration_configuration_id_seq OWNED BY cc_configuration.configuration_id;
            public       postgres    false    249            �            1259    133087 
   cc_country    TABLE     �   CREATE TABLE cc_country (
    id integer NOT NULL,
    countrycode text NOT NULL,
    countryprefix text DEFAULT '0'::text NOT NULL,
    countryname text NOT NULL
);
    DROP TABLE public.cc_country;
       public         postgres    true    5            �            1259    133094    cc_country_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_country_id_seq;
       public       postgres    false    250    5            �           0    0    cc_country_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_country_id_seq OWNED BY cc_country.id;
            public       postgres    false    251            �            1259    133096    cc_currencies    TABLE     `  CREATE TABLE cc_currencies (
    id integer NOT NULL,
    currency character(3) DEFAULT ''::bpchar NOT NULL,
    name character varying(30) DEFAULT ''::character varying NOT NULL,
    value numeric(12,5) DEFAULT 0.00000 NOT NULL,
    lastupdate timestamp without time zone DEFAULT now(),
    basecurrency character(3) DEFAULT 'USD'::bpchar NOT NULL
);
 !   DROP TABLE public.cc_currencies;
       public         postgres    true    5            �            1259    133104    cc_currencies_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_currencies_id_seq;
       public       postgres    false    252    5            �           0    0    cc_currencies_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_currencies_id_seq OWNED BY cc_currencies.id;
            public       postgres    false    253            �            1259    133106    cc_did    TABLE     �  CREATE TABLE cc_did (
    id bigint NOT NULL,
    id_cc_didgroup bigint NOT NULL,
    id_cc_country integer NOT NULL,
    activated integer DEFAULT 1 NOT NULL,
    reserved integer DEFAULT 0,
    iduser bigint DEFAULT 0 NOT NULL,
    did text NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    startingdate timestamp without time zone DEFAULT now(),
    expirationdate timestamp without time zone,
    description text,
    secondusedreal integer DEFAULT 0,
    billingtype integer DEFAULT 0,
    fixrate numeric(12,4) NOT NULL,
    connection_charge numeric(15,5) DEFAULT (0)::numeric NOT NULL,
    selling_rate numeric(15,5) DEFAULT (0)::numeric NOT NULL
);
    DROP TABLE public.cc_did;
       public         postgres    true    5            �            1259    133121    cc_did_destination    TABLE     p  CREATE TABLE cc_did_destination (
    id bigint NOT NULL,
    destination text NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    id_cc_card bigint NOT NULL,
    id_cc_did bigint NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    activated integer DEFAULT 1 NOT NULL,
    secondusedreal integer DEFAULT 0,
    voip_call integer DEFAULT 0
);
 &   DROP TABLE public.cc_did_destination;
       public         postgres    true    5                        1259    133132    cc_did_destination_id_seq    SEQUENCE     {   CREATE SEQUENCE cc_did_destination_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cc_did_destination_id_seq;
       public       postgres    false    5    255            �           0    0    cc_did_destination_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE cc_did_destination_id_seq OWNED BY cc_did_destination.id;
            public       postgres    false    256                       1259    133134    cc_did_id_seq    SEQUENCE     o   CREATE SEQUENCE cc_did_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.cc_did_id_seq;
       public       postgres    false    5    254            �           0    0    cc_did_id_seq    SEQUENCE OWNED BY     1   ALTER SEQUENCE cc_did_id_seq OWNED BY cc_did.id;
            public       postgres    false    257                       1259    133136 
   cc_did_use    TABLE     V  CREATE TABLE cc_did_use (
    id bigint NOT NULL,
    id_cc_card bigint,
    id_did bigint NOT NULL,
    reservationdate timestamp without time zone DEFAULT now() NOT NULL,
    releasedate timestamp without time zone,
    activated integer DEFAULT 0,
    month_payed integer DEFAULT 0,
    reminded smallint DEFAULT (0)::smallint NOT NULL
);
    DROP TABLE public.cc_did_use;
       public         postgres    true    5                       1259    133143    cc_did_use_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_did_use_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_did_use_id_seq;
       public       postgres    false    258    5            �           0    0    cc_did_use_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_did_use_id_seq OWNED BY cc_did_use.id;
            public       postgres    false    259                       1259    133145    cc_didgroup    TABLE     �   CREATE TABLE cc_didgroup (
    id bigint NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    didgroupname text NOT NULL
);
    DROP TABLE public.cc_didgroup;
       public         postgres    true    5                       1259    133152    cc_didgroup_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_didgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_didgroup_id_seq;
       public       postgres    false    260    5            �           0    0    cc_didgroup_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_didgroup_id_seq OWNED BY cc_didgroup.id;
            public       postgres    false    261                       1259    133154    cc_epayment_log    TABLE     �  CREATE TABLE cc_epayment_log (
    id bigint NOT NULL,
    cardid bigint DEFAULT 0 NOT NULL,
    amount character varying(50) DEFAULT 0 NOT NULL,
    vat double precision DEFAULT 0 NOT NULL,
    paymentmethod character varying(255) NOT NULL,
    cc_owner character varying(255) NOT NULL,
    cc_number character varying(255) NOT NULL,
    cc_expires character varying(255) NOT NULL,
    creationdate timestamp(0) without time zone DEFAULT now(),
    status integer DEFAULT 0 NOT NULL,
    cvv character varying(4),
    credit_card_type character varying(20),
    currency character varying(4),
    transaction_detail text,
    item_type character varying(30),
    item_id bigint
);
 #   DROP TABLE public.cc_epayment_log;
       public         postgres    true    5                       1259    133165    cc_epayment_log_agent    TABLE     @  CREATE TABLE cc_epayment_log_agent (
    id bigint NOT NULL,
    agent_id bigint DEFAULT (0)::bigint NOT NULL,
    amount character varying(50) DEFAULT (0)::numeric NOT NULL,
    vat double precision DEFAULT (0)::double precision NOT NULL,
    paymentmethod character(50) NOT NULL,
    cc_owner character varying(64) DEFAULT NULL::character varying,
    cc_number character varying(32) DEFAULT NULL::character varying,
    cc_expires character varying(7) DEFAULT NULL::character varying,
    creationdate timestamp without time zone DEFAULT now() NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    cvv character varying(4) DEFAULT NULL::character varying,
    credit_card_type character varying(20) DEFAULT NULL::character varying,
    currency character varying(4) DEFAULT NULL::character varying,
    transaction_detail text
);
 )   DROP TABLE public.cc_epayment_log_agent;
       public         postgres    true    5                       1259    133182    cc_epayment_log_agent_id_seq    SEQUENCE     ~   CREATE SEQUENCE cc_epayment_log_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.cc_epayment_log_agent_id_seq;
       public       postgres    false    5    263            �           0    0    cc_epayment_log_agent_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE cc_epayment_log_agent_id_seq OWNED BY cc_epayment_log_agent.id;
            public       postgres    false    264            	           1259    133184    cc_epayment_log_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_epayment_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_epayment_log_id_seq;
       public       postgres    false    262    5            �           0    0    cc_epayment_log_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_epayment_log_id_seq OWNED BY cc_epayment_log.id;
            public       postgres    false    265            
           1259    133186 
   cc_invoice    TABLE     i  CREATE TABLE cc_invoice (
    id bigint NOT NULL,
    reference character varying(30),
    id_card bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    paid_status smallint DEFAULT (0)::smallint NOT NULL,
    status smallint DEFAULT (0)::smallint NOT NULL,
    title character varying(50) NOT NULL,
    description text NOT NULL
);
    DROP TABLE public.cc_invoice;
       public         postgres    true    5                       1259    133195    cc_invoice_conf    TABLE     �   CREATE TABLE cc_invoice_conf (
    id integer NOT NULL,
    key_val character varying(50) NOT NULL,
    value character varying(50) NOT NULL
);
 #   DROP TABLE public.cc_invoice_conf;
       public         postgres    true    5                       1259    133198    cc_invoice_conf_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_invoice_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_invoice_conf_id_seq;
       public       postgres    false    5    267            �           0    0    cc_invoice_conf_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_invoice_conf_id_seq OWNED BY cc_invoice_conf.id;
            public       postgres    false    268                       1259    133200    cc_invoice_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_invoice_id_seq;
       public       postgres    false    5    266            �           0    0    cc_invoice_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_invoice_id_seq OWNED BY cc_invoice.id;
            public       postgres    false    269                       1259    133202    cc_invoice_item    TABLE     W  CREATE TABLE cc_invoice_item (
    id bigint NOT NULL,
    id_invoice bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    price numeric(15,5) DEFAULT (0)::numeric NOT NULL,
    vat numeric(4,2) DEFAULT (0)::numeric NOT NULL,
    description text NOT NULL,
    id_ext bigint,
    type_ext character varying(10)
);
 #   DROP TABLE public.cc_invoice_item;
       public         postgres    true    5                       1259    133211    cc_invoice_item_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_invoice_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_invoice_item_id_seq;
       public       postgres    false    270    5            �           0    0    cc_invoice_item_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_invoice_item_id_seq OWNED BY cc_invoice_item.id;
            public       postgres    false    271                       1259    133213    cc_invoice_payment    TABLE     d   CREATE TABLE cc_invoice_payment (
    id_invoice bigint NOT NULL,
    id_payment bigint NOT NULL
);
 &   DROP TABLE public.cc_invoice_payment;
       public         postgres    true    5                       1259    133216 	   cc_iso639    TABLE     �   CREATE TABLE cc_iso639 (
    code text NOT NULL,
    name text NOT NULL,
    lname text,
    charset text DEFAULT 'ISO-8859-1'::text NOT NULL
);
    DROP TABLE public.cc_iso639;
       public         postgres    true    5                       1259    133223    cc_logpayment    TABLE     �  CREATE TABLE cc_logpayment (
    id bigint NOT NULL,
    date timestamp(0) without time zone DEFAULT now() NOT NULL,
    payment numeric(15,5) NOT NULL,
    card_id bigint NOT NULL,
    id_logrefill bigint,
    description text,
    added_refill smallint DEFAULT 0 NOT NULL,
    payment_type smallint DEFAULT 0 NOT NULL,
    added_commission smallint DEFAULT 0 NOT NULL,
    agent_id bigint
);
 !   DROP TABLE public.cc_logpayment;
       public         postgres    true    5                       1259    133233    cc_logpayment_agent    TABLE     �  CREATE TABLE cc_logpayment_agent (
    id bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    payment numeric(15,5) NOT NULL,
    agent_id bigint NOT NULL,
    id_logrefill bigint,
    description text,
    added_refill smallint DEFAULT (0)::smallint NOT NULL,
    payment_type smallint DEFAULT (0)::smallint NOT NULL,
    added_commission smallint DEFAULT (0)::smallint NOT NULL
);
 '   DROP TABLE public.cc_logpayment_agent;
       public         postgres    true    5                       1259    133243    cc_logpayment_agent_id_seq    SEQUENCE     |   CREATE SEQUENCE cc_logpayment_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.cc_logpayment_agent_id_seq;
       public       postgres    false    5    275            �           0    0    cc_logpayment_agent_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE cc_logpayment_agent_id_seq OWNED BY cc_logpayment_agent.id;
            public       postgres    false    276                       1259    133245    cc_logpayment_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_logpayment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_logpayment_id_seq;
       public       postgres    false    274    5            �           0    0    cc_logpayment_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_logpayment_id_seq OWNED BY cc_logpayment.id;
            public       postgres    false    277                       1259    133247    cc_logrefill    TABLE     I  CREATE TABLE cc_logrefill (
    id bigint NOT NULL,
    date timestamp(0) without time zone DEFAULT now() NOT NULL,
    credit numeric(15,5) NOT NULL,
    card_id bigint NOT NULL,
    description text,
    refill_type smallint DEFAULT 0 NOT NULL,
    added_invoice smallint DEFAULT (0)::smallint NOT NULL,
    agent_id bigint
);
     DROP TABLE public.cc_logrefill;
       public         postgres    true    5                       1259    133256    cc_logrefill_agent    TABLE     	  CREATE TABLE cc_logrefill_agent (
    id bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    credit numeric(15,5) NOT NULL,
    agent_id bigint NOT NULL,
    description text,
    refill_type smallint DEFAULT (0)::smallint NOT NULL
);
 &   DROP TABLE public.cc_logrefill_agent;
       public         postgres    true    5                       1259    133264    cc_logrefill_agent_id_seq    SEQUENCE     {   CREATE SEQUENCE cc_logrefill_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cc_logrefill_agent_id_seq;
       public       postgres    false    5    279            �           0    0    cc_logrefill_agent_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE cc_logrefill_agent_id_seq OWNED BY cc_logrefill_agent.id;
            public       postgres    false    280                       1259    133266    cc_logrefill_id_seq    SEQUENCE     u   CREATE SEQUENCE cc_logrefill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cc_logrefill_id_seq;
       public       postgres    false    278    5            �           0    0    cc_logrefill_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE cc_logrefill_id_seq OWNED BY cc_logrefill.id;
            public       postgres    false    281                       1259    133268    cc_message_agent    TABLE     �   CREATE TABLE cc_message_agent (
    id bigint NOT NULL,
    id_agent integer NOT NULL,
    message text,
    type smallint DEFAULT 0 NOT NULL,
    logo smallint DEFAULT 1 NOT NULL,
    order_display integer NOT NULL
);
 $   DROP TABLE public.cc_message_agent;
       public         postgres    false    5                       1259    133276    cc_message_agent_id_seq    SEQUENCE     y   CREATE SEQUENCE cc_message_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.cc_message_agent_id_seq;
       public       postgres    false    5    282            �           0    0    cc_message_agent_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE cc_message_agent_id_seq OWNED BY cc_message_agent.id;
            public       postgres    false    283                       1259    133278 
   cc_monitor    TABLE     h  CREATE TABLE cc_monitor (
    id bigint NOT NULL,
    label character varying(50) NOT NULL,
    dial_code integer,
    description character varying(250),
    text_intro character varying(250),
    query_type smallint DEFAULT 1 NOT NULL,
    query character varying(1000),
    result_type smallint DEFAULT 1 NOT NULL,
    enable smallint DEFAULT 1 NOT NULL
);
    DROP TABLE public.cc_monitor;
       public         postgres    false    5                       1259    133287    cc_monitor_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_monitor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_monitor_id_seq;
       public       postgres    false    284    5            �           0    0    cc_monitor_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_monitor_id_seq OWNED BY cc_monitor.id;
            public       postgres    false    285                       1259    133289    cc_notification    TABLE     T  CREATE TABLE cc_notification (
    id bigint NOT NULL,
    key_value character varying(255),
    date timestamp without time zone DEFAULT now() NOT NULL,
    priority smallint DEFAULT (0)::smallint NOT NULL,
    from_type smallint NOT NULL,
    from_id bigint DEFAULT (0)::bigint,
    link_id bigint,
    link_type character varying(20)
);
 #   DROP TABLE public.cc_notification;
       public         postgres    true    5                       1259    133295    cc_notification_admin    TABLE     �   CREATE TABLE cc_notification_admin (
    id_notification bigint NOT NULL,
    id_admin integer NOT NULL,
    viewed smallint DEFAULT (0)::smallint NOT NULL
);
 )   DROP TABLE public.cc_notification_admin;
       public         postgres    true    5                        1259    133299    cc_notification_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_notification_id_seq;
       public       postgres    false    286    5            �           0    0    cc_notification_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_notification_id_seq OWNED BY cc_notification.id;
            public       postgres    false    288            !           1259    133301    cc_outbound_cid_group    TABLE     �   CREATE TABLE cc_outbound_cid_group (
    id bigint NOT NULL,
    creationdate timestamp(0) without time zone DEFAULT now(),
    group_name text NOT NULL
);
 )   DROP TABLE public.cc_outbound_cid_group;
       public         postgres    true    5            "           1259    133308    cc_outbound_cid_group_id_seq    SEQUENCE     ~   CREATE SEQUENCE cc_outbound_cid_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.cc_outbound_cid_group_id_seq;
       public       postgres    false    5    289            �           0    0    cc_outbound_cid_group_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE cc_outbound_cid_group_id_seq OWNED BY cc_outbound_cid_group.id;
            public       postgres    false    290            #           1259    133310    cc_outbound_cid_list    TABLE     �   CREATE TABLE cc_outbound_cid_list (
    id bigint NOT NULL,
    outbound_cid_group bigint NOT NULL,
    cid text NOT NULL,
    activated integer DEFAULT 0 NOT NULL,
    creationdate timestamp(0) without time zone DEFAULT now()
);
 (   DROP TABLE public.cc_outbound_cid_list;
       public         postgres    true    5            $           1259    133318    cc_outbound_cid_list_id_seq    SEQUENCE     }   CREATE SEQUENCE cc_outbound_cid_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cc_outbound_cid_list_id_seq;
       public       postgres    false    291    5            �           0    0    cc_outbound_cid_list_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE cc_outbound_cid_list_id_seq OWNED BY cc_outbound_cid_list.id;
            public       postgres    false    292            %           1259    133320    cc_package_group    TABLE     z   CREATE TABLE cc_package_group (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);
 $   DROP TABLE public.cc_package_group;
       public         postgres    true    5            &           1259    133326    cc_package_group_id_seq    SEQUENCE     y   CREATE SEQUENCE cc_package_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.cc_package_group_id_seq;
       public       postgres    false    293    5                        0    0    cc_package_group_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE cc_package_group_id_seq OWNED BY cc_package_group.id;
            public       postgres    false    294            '           1259    133328    cc_package_offer    TABLE       CREATE TABLE cc_package_offer (
    id bigint NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    label text NOT NULL,
    packagetype integer NOT NULL,
    billingtype integer NOT NULL,
    startday integer NOT NULL,
    freetimetocall integer NOT NULL
);
 $   DROP TABLE public.cc_package_offer;
       public         postgres    true    5            (           1259    133335    cc_package_offer_id_seq    SEQUENCE     y   CREATE SEQUENCE cc_package_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.cc_package_offer_id_seq;
       public       postgres    false    295    5                       0    0    cc_package_offer_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE cc_package_offer_id_seq OWNED BY cc_package_offer.id;
            public       postgres    false    296            )           1259    133337    cc_package_rate    TABLE     `   CREATE TABLE cc_package_rate (
    package_id integer NOT NULL,
    rate_id integer NOT NULL
);
 #   DROP TABLE public.cc_package_rate;
       public         postgres    true    5            *           1259    133340    cc_packgroup_package    TABLE     m   CREATE TABLE cc_packgroup_package (
    packagegroup_id integer NOT NULL,
    package_id integer NOT NULL
);
 (   DROP TABLE public.cc_packgroup_package;
       public         postgres    true    5            +           1259    133343    cc_payment_methods    TABLE     �   CREATE TABLE cc_payment_methods (
    id bigint NOT NULL,
    payment_method text NOT NULL,
    payment_filename text NOT NULL
);
 &   DROP TABLE public.cc_payment_methods;
       public         postgres    true    5            ,           1259    133349    cc_payment_methods_id_seq    SEQUENCE     {   CREATE SEQUENCE cc_payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cc_payment_methods_id_seq;
       public       postgres    false    5    299                       0    0    cc_payment_methods_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE cc_payment_methods_id_seq OWNED BY cc_payment_methods.id;
            public       postgres    false    300            -           1259    133351    cc_payments    TABLE       CREATE TABLE cc_payments (
    id bigint NOT NULL,
    customers_id bigint DEFAULT (0)::bigint NOT NULL,
    customers_name text NOT NULL,
    customers_email_address text NOT NULL,
    item_name text NOT NULL,
    item_id text NOT NULL,
    item_quantity integer DEFAULT 0 NOT NULL,
    payment_method character varying(32) NOT NULL,
    cc_type character varying(20),
    cc_owner character varying(64),
    cc_number character varying(32),
    cc_expires character varying(6),
    orders_status integer NOT NULL,
    orders_amount numeric(14,6),
    last_modified timestamp without time zone,
    date_purchased timestamp without time zone,
    orders_date_finished timestamp without time zone,
    currency character varying(3),
    currency_value numeric(14,6)
);
    DROP TABLE public.cc_payments;
       public         postgres    true    5            .           1259    133359    cc_payments_agent    TABLE       CREATE TABLE cc_payments_agent (
    id bigint NOT NULL,
    agent_id bigint NOT NULL,
    agent_name character varying(200) NOT NULL,
    agent_email_address character varying(96) NOT NULL,
    item_name character varying(127) DEFAULT NULL::character varying,
    item_id character varying(127) DEFAULT NULL::character varying,
    item_quantity integer DEFAULT 0 NOT NULL,
    payment_method character varying(32) NOT NULL,
    cc_type character varying(20) DEFAULT NULL::character varying,
    cc_owner character varying(64) DEFAULT NULL::character varying,
    cc_number character varying(32) DEFAULT NULL::character varying,
    cc_expires character varying(4) DEFAULT NULL::character varying,
    orders_status integer NOT NULL,
    orders_amount numeric(14,6) DEFAULT NULL::numeric,
    last_modified timestamp without time zone,
    date_purchased timestamp without time zone,
    orders_date_finished timestamp without time zone,
    currency character(3) DEFAULT NULL::bpchar,
    currency_value numeric(14,6) DEFAULT NULL::numeric
);
 %   DROP TABLE public.cc_payments_agent;
       public         postgres    true    5            /           1259    133375    cc_payments_agent_id_seq    SEQUENCE     z   CREATE SEQUENCE cc_payments_agent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.cc_payments_agent_id_seq;
       public       postgres    false    302    5                       0    0    cc_payments_agent_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE cc_payments_agent_id_seq OWNED BY cc_payments_agent.id;
            public       postgres    false    303            0           1259    133377    cc_payments_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_payments_id_seq;
       public       postgres    false    301    5                       0    0    cc_payments_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_payments_id_seq OWNED BY cc_payments.id;
            public       postgres    false    304            1           1259    133379    cc_payments_status    TABLE     �   CREATE TABLE cc_payments_status (
    id bigint NOT NULL,
    status_id integer NOT NULL,
    status_name character varying(200) NOT NULL
);
 &   DROP TABLE public.cc_payments_status;
       public         postgres    true    5            2           1259    133382    cc_payments_status_id_seq    SEQUENCE     {   CREATE SEQUENCE cc_payments_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.cc_payments_status_id_seq;
       public       postgres    false    5    305                       0    0    cc_payments_status_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE cc_payments_status_id_seq OWNED BY cc_payments_status.id;
            public       postgres    false    306            3           1259    133384 	   cc_paypal    TABLE     �  CREATE TABLE cc_paypal (
    id bigint NOT NULL,
    payer_id character varying(60) DEFAULT NULL::character varying,
    payment_date character varying(50) DEFAULT NULL::character varying,
    txn_id character varying(50) DEFAULT NULL::character varying,
    first_name character varying(50) DEFAULT NULL::character varying,
    last_name character varying(50) DEFAULT NULL::character varying,
    payer_email character varying(75) DEFAULT NULL::character varying,
    payer_status character varying(50) DEFAULT NULL::character varying,
    payment_type character varying(50) DEFAULT NULL::character varying,
    memo text,
    item_name character varying(127) DEFAULT NULL::character varying,
    item_number character varying(127) DEFAULT NULL::character varying,
    quantity bigint DEFAULT (0)::bigint NOT NULL,
    mc_gross numeric(9,2) DEFAULT NULL::numeric,
    mc_fee numeric(9,2) DEFAULT NULL::numeric,
    tax numeric(9,2) DEFAULT NULL::numeric,
    mc_currency character varying(3) DEFAULT NULL::character varying,
    address_name character varying(255) DEFAULT ''::character varying NOT NULL,
    address_street character varying(255) DEFAULT ''::character varying NOT NULL,
    address_city character varying(255) DEFAULT ''::character varying NOT NULL,
    address_state character varying(255) DEFAULT ''::character varying NOT NULL,
    address_zip character varying(255) DEFAULT ''::character varying NOT NULL,
    address_country character varying(255) DEFAULT ''::character varying NOT NULL,
    address_status character varying(255) DEFAULT ''::character varying NOT NULL,
    payer_business_name character varying(255) DEFAULT ''::character varying NOT NULL,
    payment_status character varying(255) DEFAULT ''::character varying NOT NULL,
    pending_reason character varying(255) DEFAULT ''::character varying NOT NULL,
    reason_code character varying(255) DEFAULT ''::character varying NOT NULL,
    txn_type character varying(255) DEFAULT ''::character varying NOT NULL
);
    DROP TABLE public.cc_paypal;
       public         postgres    true    5            4           1259    133417    cc_paypal_id_seq    SEQUENCE     r   CREATE SEQUENCE cc_paypal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cc_paypal_id_seq;
       public       postgres    false    307    5                       0    0    cc_paypal_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE cc_paypal_id_seq OWNED BY cc_paypal.id;
            public       postgres    false    308            5           1259    133419    cc_phonebook    TABLE     �   CREATE TABLE cc_phonebook (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    id_card bigint NOT NULL
);
     DROP TABLE public.cc_phonebook;
       public         postgres    true    5            6           1259    133425    cc_phonebook_id_seq    SEQUENCE     u   CREATE SEQUENCE cc_phonebook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cc_phonebook_id_seq;
       public       postgres    false    5    309                       0    0    cc_phonebook_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE cc_phonebook_id_seq OWNED BY cc_phonebook.id;
            public       postgres    false    310            7           1259    133427    cc_phonenumber    TABLE     U  CREATE TABLE cc_phonenumber (
    id bigint NOT NULL,
    id_phonebook integer NOT NULL,
    number character varying(30) NOT NULL,
    name character varying(40),
    creationdate timestamp without time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT (1)::smallint NOT NULL,
    info text,
    amount integer DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.cc_phonenumber;
       public         postgres    true    5            8           1259    133436    cc_phonenumber_id_seq    SEQUENCE     w   CREATE SEQUENCE cc_phonenumber_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cc_phonenumber_id_seq;
       public       postgres    false    5    311                       0    0    cc_phonenumber_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE cc_phonenumber_id_seq OWNED BY cc_phonenumber.id;
            public       postgres    false    312            9           1259    133438    cc_prefix_prefix_seq    SEQUENCE     v   CREATE SEQUENCE cc_prefix_prefix_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_prefix_prefix_seq;
       public       postgres    false    5    214            	           0    0    cc_prefix_prefix_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_prefix_prefix_seq OWNED BY cc_prefix.prefix;
            public       postgres    false    313            :           1259    133440    cc_provider    TABLE     �   CREATE TABLE cc_provider (
    id bigint NOT NULL,
    provider_name text NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    description text
);
    DROP TABLE public.cc_provider;
       public         postgres    true    5            ;           1259    133447    cc_provider_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_provider_id_seq;
       public       postgres    false    5    314            
           0    0    cc_provider_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_provider_id_seq OWNED BY cc_provider.id;
            public       postgres    false    315            <           1259    133449    cc_ratecard_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_ratecard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_ratecard_id_seq;
       public       postgres    false    215    5                       0    0    cc_ratecard_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_ratecard_id_seq OWNED BY cc_ratecard.id;
            public       postgres    false    316            =           1259    133451 
   cc_receipt    TABLE       CREATE TABLE cc_receipt (
    id bigint NOT NULL,
    id_card bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    title character varying(50) NOT NULL,
    description text NOT NULL,
    status smallint DEFAULT (0)::smallint NOT NULL
);
    DROP TABLE public.cc_receipt;
       public         postgres    true    5            >           1259    133459    cc_receipt_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_receipt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_receipt_id_seq;
       public       postgres    false    5    317                       0    0    cc_receipt_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_receipt_id_seq OWNED BY cc_receipt.id;
            public       postgres    false    318            ?           1259    133461    cc_receipt_item    TABLE     C  CREATE TABLE cc_receipt_item (
    id bigint NOT NULL,
    id_receipt bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    price numeric(15,5) DEFAULT (0)::numeric NOT NULL,
    description text NOT NULL,
    id_ext bigint,
    type_ext character varying(10) DEFAULT NULL::character varying
);
 #   DROP TABLE public.cc_receipt_item;
       public         postgres    true    5            @           1259    133470    cc_receipt_item_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_receipt_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_receipt_item_id_seq;
       public       postgres    false    5    319                       0    0    cc_receipt_item_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_receipt_item_id_seq OWNED BY cc_receipt_item.id;
            public       postgres    false    320            A           1259    133472    cc_remittance_request    TABLE       CREATE TABLE cc_remittance_request (
    id bigint NOT NULL,
    id_agent bigint NOT NULL,
    amount numeric(15,5) NOT NULL,
    type smallint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);
 )   DROP TABLE public.cc_remittance_request;
       public         postgres    false    5            B           1259    133477    cc_remittance_request_id_seq    SEQUENCE     ~   CREATE SEQUENCE cc_remittance_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.cc_remittance_request_id_seq;
       public       postgres    false    321    5                       0    0    cc_remittance_request_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE cc_remittance_request_id_seq OWNED BY cc_remittance_request.id;
            public       postgres    false    322            C           1259    133479    cc_restricted_phonenumber    TABLE     �   CREATE TABLE cc_restricted_phonenumber (
    id bigint NOT NULL,
    number character varying(50) NOT NULL,
    id_card bigint NOT NULL
);
 -   DROP TABLE public.cc_restricted_phonenumber;
       public         postgres    true    5            D           1259    133482     cc_restricted_phonenumber_id_seq    SEQUENCE     �   CREATE SEQUENCE cc_restricted_phonenumber_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.cc_restricted_phonenumber_id_seq;
       public       postgres    false    5    323                       0    0     cc_restricted_phonenumber_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE cc_restricted_phonenumber_id_seq OWNED BY cc_restricted_phonenumber.id;
            public       postgres    false    324            E           1259    133484    cc_server_group    TABLE     ^   CREATE TABLE cc_server_group (
    id bigint NOT NULL,
    name text,
    description text
);
 #   DROP TABLE public.cc_server_group;
       public         postgres    true    5            F           1259    133490    cc_server_group_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_server_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_server_group_id_seq;
       public       postgres    false    325    5                       0    0    cc_server_group_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_server_group_id_seq OWNED BY cc_server_group.id;
            public       postgres    false    326            G           1259    133492    cc_server_manager    TABLE     �   CREATE TABLE cc_server_manager (
    id bigint NOT NULL,
    id_group integer DEFAULT 1,
    server_ip text,
    manager_host text,
    manager_username text,
    manager_secret text,
    lasttime_used timestamp without time zone DEFAULT now()
);
 %   DROP TABLE public.cc_server_manager;
       public         postgres    true    5            H           1259    133500    cc_server_manager_id_seq    SEQUENCE     z   CREATE SEQUENCE cc_server_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.cc_server_manager_id_seq;
       public       postgres    false    5    327                       0    0    cc_server_manager_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE cc_server_manager_id_seq OWNED BY cc_server_manager.id;
            public       postgres    false    328            I           1259    133502 
   cc_service    TABLE     �  CREATE TABLE cc_service (
    id bigint NOT NULL,
    name text NOT NULL,
    amount double precision NOT NULL,
    period integer DEFAULT 1 NOT NULL,
    rule integer DEFAULT 0 NOT NULL,
    daynumber integer DEFAULT 0 NOT NULL,
    stopmode integer DEFAULT 0 NOT NULL,
    maxnumbercycle integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    numberofrun integer DEFAULT 0 NOT NULL,
    datecreate timestamp(0) without time zone DEFAULT now(),
    datelastrun timestamp(0) without time zone DEFAULT now(),
    emailreport text,
    totalcredit double precision DEFAULT 0 NOT NULL,
    totalcardperform integer DEFAULT 0 NOT NULL,
    operate_mode smallint DEFAULT 0,
    dialplan integer DEFAULT 0,
    use_group smallint DEFAULT 0
);
    DROP TABLE public.cc_service;
       public         postgres    true    5            J           1259    133522    cc_service_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_service_id_seq;
       public       postgres    false    5    329                       0    0    cc_service_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_service_id_seq OWNED BY cc_service.id;
            public       postgres    false    330            K           1259    133524    cc_service_report    TABLE     �   CREATE TABLE cc_service_report (
    id bigint NOT NULL,
    cc_service_id bigint NOT NULL,
    daterun timestamp(0) without time zone DEFAULT now(),
    totalcardperform integer,
    totalcredit double precision
);
 %   DROP TABLE public.cc_service_report;
       public         postgres    true    5            L           1259    133528    cc_service_report_id_seq    SEQUENCE     z   CREATE SEQUENCE cc_service_report_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.cc_service_report_id_seq;
       public       postgres    false    5    331                       0    0    cc_service_report_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE cc_service_report_id_seq OWNED BY cc_service_report.id;
            public       postgres    false    332            M           1259    133530    cc_sip_buddies_empty    VIEW        CREATE VIEW cc_sip_buddies_empty AS
    SELECT cc_sip_buddies.id, cc_sip_buddies.id_cc_card, cc_sip_buddies.name, cc_sip_buddies.accountcode, cc_sip_buddies.regexten, cc_sip_buddies.amaflags, cc_sip_buddies.callgroup, cc_sip_buddies.callerid, cc_sip_buddies.canreinvite, cc_sip_buddies.context, cc_sip_buddies.defaultip, cc_sip_buddies.dtmfmode, cc_sip_buddies.fromuser, cc_sip_buddies.fromdomain, cc_sip_buddies.host, cc_sip_buddies.insecure, cc_sip_buddies.language, cc_sip_buddies.mailbox, cc_sip_buddies.md5secret, cc_sip_buddies.nat, cc_sip_buddies.permit, cc_sip_buddies.deny, cc_sip_buddies.mask, cc_sip_buddies.pickupgroup, cc_sip_buddies.port, cc_sip_buddies.qualify, cc_sip_buddies.restrictcid, cc_sip_buddies.rtptimeout, cc_sip_buddies.rtpholdtimeout, ''::text AS secret, cc_sip_buddies.type, cc_sip_buddies.username, cc_sip_buddies.disallow, cc_sip_buddies.allow, cc_sip_buddies.musiconhold, cc_sip_buddies.regseconds, cc_sip_buddies.ipaddr, cc_sip_buddies.cancallforward, cc_sip_buddies.fullcontact, cc_sip_buddies.setvar FROM cc_sip_buddies;
 '   DROP VIEW public.cc_sip_buddies_empty;
       public       postgres    false    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    187    5            N           1259    133535    cc_speeddial    TABLE     �   CREATE TABLE cc_speeddial (
    id bigint NOT NULL,
    id_cc_card bigint DEFAULT 0 NOT NULL,
    phone text NOT NULL,
    name text NOT NULL,
    speeddial integer DEFAULT 0,
    creationdate timestamp without time zone DEFAULT now()
);
     DROP TABLE public.cc_speeddial;
       public         postgres    true    5            O           1259    133544    cc_speeddial_id_seq    SEQUENCE     u   CREATE SEQUENCE cc_speeddial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.cc_speeddial_id_seq;
       public       postgres    false    5    334                       0    0    cc_speeddial_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE cc_speeddial_id_seq OWNED BY cc_speeddial.id;
            public       postgres    false    335            P           1259    133546    cc_status_log    TABLE     �   CREATE TABLE cc_status_log (
    id bigint NOT NULL,
    status integer NOT NULL,
    id_cc_card bigint NOT NULL,
    updated_date timestamp without time zone DEFAULT now()
);
 !   DROP TABLE public.cc_status_log;
       public         postgres    true    5            Q           1259    133550    cc_status_log_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_status_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_status_log_id_seq;
       public       postgres    false    336    5                       0    0    cc_status_log_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_status_log_id_seq OWNED BY cc_status_log.id;
            public       postgres    false    337            R           1259    133552    cc_subscription_service    TABLE     �  CREATE TABLE cc_subscription_service (
    id bigint NOT NULL,
    label character varying(200) NOT NULL,
    fee numeric(12,4) NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    numberofrun integer DEFAULT 0 NOT NULL,
    datecreate timestamp(0) without time zone DEFAULT now(),
    datelastrun timestamp(0) without time zone DEFAULT now(),
    emailreport character varying(100) NOT NULL,
    totalcredit double precision DEFAULT 0 NOT NULL,
    totalcardperform integer DEFAULT 0 NOT NULL,
    startdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    stopdate timestamp without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL
);
 +   DROP TABLE public.cc_subscription_service;
       public         postgres    true    5            S           1259    133563    cc_subscription_fee_id_seq    SEQUENCE     |   CREATE SEQUENCE cc_subscription_fee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.cc_subscription_fee_id_seq;
       public       postgres    false    338    5                       0    0    cc_subscription_fee_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE cc_subscription_fee_id_seq OWNED BY cc_subscription_service.id;
            public       postgres    false    339            T           1259    133565    cc_subscription_signup    TABLE       CREATE TABLE cc_subscription_signup (
    id bigint NOT NULL,
    label character varying(50) NOT NULL,
    id_subscription bigint,
    description character varying(500) DEFAULT NULL::character varying,
    enable smallint DEFAULT (1)::smallint NOT NULL,
    id_callplan bigint
);
 *   DROP TABLE public.cc_subscription_signup;
       public         postgres    false    5            U           1259    133573    cc_subscription_signup_id_seq    SEQUENCE        CREATE SEQUENCE cc_subscription_signup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.cc_subscription_signup_id_seq;
       public       postgres    false    340    5                       0    0    cc_subscription_signup_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE cc_subscription_signup_id_seq OWNED BY cc_subscription_signup.id;
            public       postgres    false    341            V           1259    133575 
   cc_support    TABLE     �   CREATE TABLE cc_support (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(70),
    language character(5) DEFAULT 'en'::bpchar NOT NULL
);
    DROP TABLE public.cc_support;
       public         postgres    true    5            W           1259    133579    cc_support_component    TABLE     	  CREATE TABLE cc_support_component (
    id integer NOT NULL,
    id_support integer NOT NULL,
    name character varying(50) DEFAULT ''::character varying NOT NULL,
    activated smallint DEFAULT 1 NOT NULL,
    type_user smallint DEFAULT (2)::smallint NOT NULL
);
 (   DROP TABLE public.cc_support_component;
       public         postgres    true    5            X           1259    133585    cc_support_component_id_seq    SEQUENCE     }   CREATE SEQUENCE cc_support_component_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.cc_support_component_id_seq;
       public       postgres    false    5    343                       0    0    cc_support_component_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE cc_support_component_id_seq OWNED BY cc_support_component.id;
            public       postgres    false    344            Y           1259    133587    cc_support_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_support_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_support_id_seq;
       public       postgres    false    5    342                       0    0    cc_support_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_support_id_seq OWNED BY cc_support.id;
            public       postgres    false    345            Z           1259    133589    cc_system_log    TABLE     �  CREATE TABLE cc_system_log (
    id bigint NOT NULL,
    iduser integer DEFAULT 0 NOT NULL,
    loglevel integer DEFAULT 0 NOT NULL,
    action text NOT NULL,
    description text,
    data text,
    tablename character varying(255),
    pagename character varying(255),
    ipaddress character varying(255),
    creationdate timestamp(0) without time zone DEFAULT now(),
    agent smallint DEFAULT 0
);
 !   DROP TABLE public.cc_system_log;
       public         postgres    true    5            [           1259    133599    cc_system_log_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_system_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_system_log_id_seq;
       public       postgres    false    5    346                       0    0    cc_system_log_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_system_log_id_seq OWNED BY cc_system_log.id;
            public       postgres    false    347            \           1259    133601    cc_tariffgroup_id_seq    SEQUENCE     w   CREATE SEQUENCE cc_tariffgroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cc_tariffgroup_id_seq;
       public       postgres    false    216    5                       0    0    cc_tariffgroup_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE cc_tariffgroup_id_seq OWNED BY cc_tariffgroup.id;
            public       postgres    false    348            ]           1259    133603    cc_tariffplan_id_seq    SEQUENCE     v   CREATE SEQUENCE cc_tariffplan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cc_tariffplan_id_seq;
       public       postgres    false    218    5                       0    0    cc_tariffplan_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE cc_tariffplan_id_seq OWNED BY cc_tariffplan.id;
            public       postgres    false    349            ^           1259    133605    cc_templatemail    TABLE     �  CREATE TABLE cc_templatemail (
    id integer NOT NULL,
    mailtype text,
    fromemail text,
    fromname text,
    subject character varying(130) DEFAULT NULL::character varying,
    messagetext character varying(3000) DEFAULT NULL::character varying,
    messagehtml character varying(3000) DEFAULT NULL::character varying,
    id_language character varying(20) DEFAULT 'en'::character varying
);
 #   DROP TABLE public.cc_templatemail;
       public         postgres    true    5            _           1259    133615    cc_templatemail_id_seq    SEQUENCE     x   CREATE SEQUENCE cc_templatemail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cc_templatemail_id_seq;
       public       postgres    false    5    350                       0    0    cc_templatemail_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE cc_templatemail_id_seq OWNED BY cc_templatemail.id;
            public       postgres    false    351            `           1259    133617 	   cc_ticket    TABLE     1  CREATE TABLE cc_ticket (
    id bigint NOT NULL,
    id_component integer NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    priority smallint DEFAULT 0 NOT NULL,
    creationdate timestamp without time zone DEFAULT now() NOT NULL,
    creator bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    creator_type smallint DEFAULT (0)::smallint NOT NULL,
    viewed_cust smallint DEFAULT (1)::smallint NOT NULL,
    viewed_agent smallint DEFAULT (1)::smallint NOT NULL,
    viewed_admin smallint DEFAULT (1)::smallint NOT NULL
);
    DROP TABLE public.cc_ticket;
       public         postgres    true    5            a           1259    133630    cc_ticket_comment    TABLE     �  CREATE TABLE cc_ticket_comment (
    id bigint NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    id_ticket bigint NOT NULL,
    description text,
    creator bigint NOT NULL,
    creator_type smallint DEFAULT (0)::smallint NOT NULL,
    viewed_cust smallint DEFAULT (1)::smallint NOT NULL,
    viewed_agent smallint DEFAULT (1)::smallint NOT NULL,
    viewed_admin smallint DEFAULT (1)::smallint NOT NULL
);
 %   DROP TABLE public.cc_ticket_comment;
       public         postgres    true    5            b           1259    133641    cc_ticket_comment_id_seq    SEQUENCE     z   CREATE SEQUENCE cc_ticket_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.cc_ticket_comment_id_seq;
       public       postgres    false    353    5                       0    0    cc_ticket_comment_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE cc_ticket_comment_id_seq OWNED BY cc_ticket_comment.id;
            public       postgres    false    354            c           1259    133643    cc_ticket_comment_id_ticket_seq    SEQUENCE     �   CREATE SEQUENCE cc_ticket_comment_id_ticket_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.cc_ticket_comment_id_ticket_seq;
       public       postgres    false    5    353                       0    0    cc_ticket_comment_id_ticket_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE cc_ticket_comment_id_ticket_seq OWNED BY cc_ticket_comment.id_ticket;
            public       postgres    false    355            d           1259    133645    cc_ticket_id_seq    SEQUENCE     r   CREATE SEQUENCE cc_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.cc_ticket_id_seq;
       public       postgres    false    352    5                        0    0    cc_ticket_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE cc_ticket_id_seq OWNED BY cc_ticket.id;
            public       postgres    false    356            e           1259    133647    cc_timezone    TABLE     �   CREATE TABLE cc_timezone (
    id integer NOT NULL,
    gmtzone character varying(255),
    gmttime character varying(255),
    gmtoffset bigint DEFAULT 0 NOT NULL
);
    DROP TABLE public.cc_timezone;
       public         postgres    true    5            f           1259    133654    cc_timezone_id_seq    SEQUENCE     t   CREATE SEQUENCE cc_timezone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.cc_timezone_id_seq;
       public       postgres    false    5    357            !           0    0    cc_timezone_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE cc_timezone_id_seq OWNED BY cc_timezone.id;
            public       postgres    false    358            g           1259    133656    cc_trunk    TABLE     �  CREATE TABLE cc_trunk (
    id_trunk integer NOT NULL,
    trunkcode character varying(50) NOT NULL,
    trunkprefix text,
    providertech text NOT NULL,
    providerip text NOT NULL,
    removeprefix text,
    secondusedreal integer DEFAULT 0,
    secondusedcarrier integer DEFAULT 0,
    secondusedratecard integer DEFAULT 0,
    creationdate timestamp(0) without time zone DEFAULT now(),
    failover_trunk integer,
    addparameter text,
    id_provider integer,
    inuse integer DEFAULT 0,
    maxuse integer DEFAULT (-1),
    status integer DEFAULT 1,
    if_max_use integer DEFAULT 0,
    failover character varying(255),
    billingorganizationprofile_id integer
);
    DROP TABLE public.cc_trunk;
       public         postgres    true    5            h           1259    133670    cc_trunk_id_trunk_seq    SEQUENCE     w   CREATE SEQUENCE cc_trunk_id_trunk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cc_trunk_id_trunk_seq;
       public       postgres    false    359    5            "           0    0    cc_trunk_id_trunk_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE cc_trunk_id_trunk_seq OWNED BY cc_trunk.id_trunk;
            public       postgres    false    360            i           1259    133672    cc_ui_authen    TABLE     �  CREATE TABLE cc_ui_authen (
    userid bigint NOT NULL,
    login text NOT NULL,
    pwd_encoded text NOT NULL,
    groupid integer,
    perms integer,
    confaddcust integer,
    name text,
    direction text,
    zipcode text,
    state text,
    phone text,
    fax text,
    email character varying(70),
    datecreation timestamp without time zone DEFAULT now(),
    country character varying(40),
    city character varying(40)
);
     DROP TABLE public.cc_ui_authen;
       public         postgres    true    5            j           1259    133679    cc_ui_authen_userid_seq    SEQUENCE     y   CREATE SEQUENCE cc_ui_authen_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.cc_ui_authen_userid_seq;
       public       postgres    false    5    361            #           0    0    cc_ui_authen_userid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE cc_ui_authen_userid_seq OWNED BY cc_ui_authen.userid;
            public       postgres    false    362            k           1259    133681 
   cc_version    TABLE     H   CREATE TABLE cc_version (
    version character varying(30) NOT NULL
);
    DROP TABLE public.cc_version;
       public         postgres    false    5            l           1259    133684 
   cc_voucher    TABLE     �  CREATE TABLE cc_voucher (
    id bigint NOT NULL,
    creationdate timestamp without time zone DEFAULT now(),
    usedate timestamp without time zone,
    expirationdate timestamp without time zone,
    voucher text NOT NULL,
    usedcardnumber text,
    tag text,
    credit numeric(12,4) NOT NULL,
    activated boolean DEFAULT true NOT NULL,
    used integer DEFAULT 0,
    currency character varying(3) DEFAULT 'USD'::character varying
);
    DROP TABLE public.cc_voucher;
       public         postgres    true    5            m           1259    133694    cc_voucher_id_seq    SEQUENCE     s   CREATE SEQUENCE cc_voucher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.cc_voucher_id_seq;
       public       postgres    false    364    5            $           0    0    cc_voucher_id_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE cc_voucher_id_seq OWNED BY cc_voucher.id;
            public       postgres    false    365            n           1259    133696    openjpa_sequence_table    TABLE     ]   CREATE TABLE openjpa_sequence_table (
    id smallint NOT NULL,
    sequence_value bigint
);
 *   DROP TABLE public.openjpa_sequence_table;
       public         postgres    false    5            o           1259    133699    pbx_accountprofile    TABLE     S   CREATE TABLE pbx_accountprofile (
    id bigint NOT NULL,
    accountid integer
);
 &   DROP TABLE public.pbx_accountprofile;
       public         postgres    false    5            p           1259    133702    pbx_accountprofile_id_seq    SEQUENCE     {   CREATE SEQUENCE pbx_accountprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.pbx_accountprofile_id_seq;
       public       postgres    false    367    5            %           0    0    pbx_accountprofile_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE pbx_accountprofile_id_seq OWNED BY pbx_accountprofile.id;
            public       postgres    false    368            q           1259    133704    pbx_blacklist    TABLE     �   CREATE TABLE pbx_blacklist (
    id bigint NOT NULL,
    number character varying(255),
    pbxorganizationprofile_id integer
);
 !   DROP TABLE public.pbx_blacklist;
       public         postgres    false    5            r           1259    133707    pbx_blacklist_id_seq    SEQUENCE     v   CREATE SEQUENCE pbx_blacklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pbx_blacklist_id_seq;
       public       postgres    false    5    369            &           0    0    pbx_blacklist_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE pbx_blacklist_id_seq OWNED BY pbx_blacklist.id;
            public       postgres    false    370            s           1259    133709    pbx_cdr    TABLE     �  CREATE TABLE pbx_cdr (
    id bigint NOT NULL,
    accountcode character varying(255),
    amaflags character varying(255),
    billsec character varying(255),
    calldate character varying(255),
    channel character varying(255),
    clid character varying(255),
    dcontext character varying(255),
    disposition character varying(255),
    dst character varying(255),
    dstchannel character varying(255),
    duration character varying(255),
    lastapp character varying(255),
    lastdata character varying(255),
    src character varying(255),
    uniqueid character varying(255),
    userfield character varying(255),
    voiceprofile_id integer
);
    DROP TABLE public.pbx_cdr;
       public         postgres    false    5            t           1259    133715    pbx_cdr_id_seq    SEQUENCE     p   CREATE SEQUENCE pbx_cdr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.pbx_cdr_id_seq;
       public       postgres    false    5    371            '           0    0    pbx_cdr_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE pbx_cdr_id_seq OWNED BY pbx_cdr.id;
            public       postgres    false    372            u           1259    133717 
   pbx_config    TABLE     �   CREATE TABLE pbx_config (
    id integer NOT NULL,
    maximumpoolsize integer,
    name character varying(255),
    poolsize integer,
    port integer
);
    DROP TABLE public.pbx_config;
       public         postgres    false    5            v           1259    133720    pbx_did    TABLE     �   CREATE TABLE pbx_did (
    id integer NOT NULL,
    country character varying(255),
    description character varying(255),
    did character varying(255),
    enabled boolean,
    state character varying(255),
    pbxorganizationprofile_id integer
);
    DROP TABLE public.pbx_did;
       public         postgres    false    5            w           1259    133726    pbx_diddestination    TABLE     �   CREATE TABLE pbx_diddestination (
    id integer NOT NULL,
    destination character varying(255),
    name character varying(255),
    servicetype character varying(255),
    did_id integer,
    order0 integer
);
 &   DROP TABLE public.pbx_diddestination;
       public         postgres    false    5            x           1259    133732 	   pbx_exten    TABLE     �  CREATE TABLE pbx_exten (
    id bigint NOT NULL,
    accountcode integer,
    allow character varying(255),
    calllimit character varying(255),
    callbackextension character varying(255),
    callerid character varying(255),
    context character varying(255),
    defaultuser character varying(255),
    disallow character varying(255),
    enabled boolean,
    fullcontact character varying(255),
    host character varying(255),
    insecure character varying(255),
    ipaddr character varying(255),
    lastms character varying(255),
    name character varying(255),
    port character varying(255),
    regcontext character varying(255),
    regexten character varying(255),
    regseconds character varying(255),
    regserver character varying(255),
    requirecalltoken character varying(255),
    secret character varying(255),
    tech character varying(255),
    type character varying(255),
    useragent character varying(255),
    pbxorganizationprofile_id integer,
    pbxaccountprofile_id integer
);
    DROP TABLE public.pbx_exten;
       public         postgres    false    5            y           1259    133738    pbx_exten_id_seq    SEQUENCE     r   CREATE SEQUENCE pbx_exten_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.pbx_exten_id_seq;
       public       postgres    false    376    5            (           0    0    pbx_exten_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE pbx_exten_id_seq OWNED BY pbx_exten.id;
            public       postgres    false    377            z           1259    133740    pbx_extensions    TABLE       CREATE TABLE pbx_extensions (
    id integer NOT NULL,
    app character varying(20) NOT NULL,
    appdata character varying(128) NOT NULL,
    context character varying(20) NOT NULL,
    exten character varying(20) NOT NULL,
    priority integer NOT NULL
);
 "   DROP TABLE public.pbx_extensions;
       public         postgres    false    5            {           1259    133743    pbx_ivr    TABLE     �   CREATE TABLE pbx_ivr (
    id bigint NOT NULL,
    audiopath character varying(255),
    description character varying(255),
    name character varying(255),
    pbxorganizationprofile_id integer
);
    DROP TABLE public.pbx_ivr;
       public         postgres    false    5            |           1259    133749    pbx_ivr_id_seq    SEQUENCE     p   CREATE SEQUENCE pbx_ivr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.pbx_ivr_id_seq;
       public       postgres    false    379    5            )           0    0    pbx_ivr_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE pbx_ivr_id_seq OWNED BY pbx_ivr.id;
            public       postgres    false    380            }           1259    133751    pbx_ivroption    TABLE     �   CREATE TABLE pbx_ivroption (
    id bigint NOT NULL,
    description character varying(255),
    option character varying(255),
    ivr_id integer
);
 !   DROP TABLE public.pbx_ivroption;
       public         postgres    false    5            ~           1259    133757    pbx_ivroption_id_seq    SEQUENCE     v   CREATE SEQUENCE pbx_ivroption_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pbx_ivroption_id_seq;
       public       postgres    false    381    5            *           0    0    pbx_ivroption_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE pbx_ivroption_id_seq OWNED BY pbx_ivroption.id;
            public       postgres    false    382                       1259    133759    pbx_organizationprofile    TABLE     ]   CREATE TABLE pbx_organizationprofile (
    id bigint NOT NULL,
    organizationid integer
);
 +   DROP TABLE public.pbx_organizationprofile;
       public         postgres    false    5            �           1259    133762    pbx_organizationprofile_id_seq    SEQUENCE     �   CREATE SEQUENCE pbx_organizationprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.pbx_organizationprofile_id_seq;
       public       postgres    false    383    5            +           0    0    pbx_organizationprofile_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE pbx_organizationprofile_id_seq OWNED BY pbx_organizationprofile.id;
            public       postgres    false    384            �           1259    133764 	   pbx_queue    TABLE     �   CREATE TABLE pbx_queue (
    id bigint NOT NULL,
    label character varying(255),
    musiconhold character varying(255),
    name character varying(255),
    strategy character varying(255),
    pbxorganizationprofile_id integer
);
    DROP TABLE public.pbx_queue;
       public         postgres    false    5            �           1259    133770    pbx_queue_id_seq    SEQUENCE     r   CREATE SEQUENCE pbx_queue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.pbx_queue_id_seq;
       public       postgres    false    385    5            ,           0    0    pbx_queue_id_seq    SEQUENCE OWNED BY     7   ALTER SEQUENCE pbx_queue_id_seq OWNED BY pbx_queue.id;
            public       postgres    false    386            �           1259    133772    pbx_queuelog    TABLE     �  CREATE TABLE pbx_queuelog (
    id bigint NOT NULL,
    agent character varying(255),
    callid character varying(255),
    data1 character varying(255),
    data2 character varying(255),
    data3 character varying(255),
    data4 character varying(255),
    data5 character varying(255),
    event character varying(255),
    queuename character varying(255),
    "time" character varying(255),
    pbxorganizationprofile_id integer
);
     DROP TABLE public.pbx_queuelog;
       public         postgres    false    5            �           1259    133778    pbx_queuelog_id_seq    SEQUENCE     u   CREATE SEQUENCE pbx_queuelog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.pbx_queuelog_id_seq;
       public       postgres    false    5    387            -           0    0    pbx_queuelog_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE pbx_queuelog_id_seq OWNED BY pbx_queuelog.id;
            public       postgres    false    388            �           1259    133780    pbx_queuemember    TABLE     [  CREATE TABLE pbx_queuemember (
    id integer NOT NULL,
    interface character varying(255) NOT NULL,
    membername character varying(255),
    paused character varying(255),
    penalty character varying(255),
    queue_name character varying(255),
    uniqueid character varying(255),
    queue_id integer,
    pbxaccountprofile_id integer
);
 #   DROP TABLE public.pbx_queuemember;
       public         postgres    false    5            �           1259    133786    pbx_voicemail    TABLE     "  CREATE TABLE pbx_voicemail (
    id bigint NOT NULL,
    attach character varying(255),
    attachfmt character varying(255),
    backupdeleted character varying(255),
    callback character varying(255),
    cidinternalcontexts character varying(255),
    context character varying(255),
    customer_id character varying(255),
    delete character varying(255),
    dialout character varying(255),
    email character varying(255),
    envelope character varying(255),
    exitcontext character varying(255),
    forcegreetings character varying(255),
    forcename character varying(255),
    fullname character varying(255),
    hidefromdir character varying(255),
    listenccontrolcpausekey character varying(255),
    listenccontrolcrestartkey character varying(255),
    listenccontrolcreversekey character varying(255),
    listencontrolforwardkey character varying(255),
    listencontrolstopkey character varying(255),
    mailbox character varying(255),
    messagewrap character varying(255),
    minpassword character varying(255),
    nextaftercmd character varying(255),
    operator character varying(255),
    pager character varying(255),
    review character varying(255),
    saycid character varying(255),
    sayduration character varying(255),
    saydurationm character varying(255),
    searchcontexts character varying(255),
    sendvoicemail character varying(255),
    stamp character varying(255),
    tempgreetwarn character varying(255),
    tz character varying(255),
    uniqueid character varying(255),
    vmmismatch character varying(255),
    vmnewpassword character varying(255),
    vmpasschanged character varying(255),
    vmpassword character varying(255),
    vmplstryagain character varying(255),
    vmreenterpassword character varying(255),
    volgain character varying(255)
);
 !   DROP TABLE public.pbx_voicemail;
       public         postgres    false    5            �           1259    133792    pbx_voicemail_id_seq    SEQUENCE     v   CREATE SEQUENCE pbx_voicemail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pbx_voicemail_id_seq;
       public       postgres    false    390    5            .           0    0    pbx_voicemail_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE pbx_voicemail_id_seq OWNED BY pbx_voicemail.id;
            public       postgres    false    391            �           1259    133794    account    TABLE     �  CREATE TABLE account (
    id bigint NOT NULL,
    address character varying(255),
    birthdate timestamp without time zone,
    country character varying(255),
    creation timestamp without time zone,
    email character varying(255),
    enabled boolean,
    firstname character varying(255),
    fixed character varying(255),
    identification character varying(255),
    lastname character varying(255),
    location character varying(255),
    mobile character varying(255),
    password character varying(255),
    relationship character varying(255),
    sex character varying(255),
    role_id integer,
    organization_id integer
);
    DROP TABLE security.account;
       security         postgres    false    8            �           1259    133800    account_id_seq    SEQUENCE     p   CREATE SEQUENCE account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE security.account_id_seq;
       security       postgres    false    392    8            /           0    0    account_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE account_id_seq OWNED BY account.id;
            security       postgres    false    393            �           1259    133802    openjpa_sequence_table    TABLE     ]   CREATE TABLE openjpa_sequence_table (
    id smallint NOT NULL,
    sequence_value bigint
);
 ,   DROP TABLE security.openjpa_sequence_table;
       security         postgres    false    8            �           1259    133805    organization    TABLE       CREATE TABLE organization (
    id bigint NOT NULL,
    apikey character varying(255),
    creation timestamp without time zone,
    domain character varying(255),
    enabled boolean,
    identification character varying(255),
    logo bytea,
    name character varying(255)
);
 "   DROP TABLE security.organization;
       security         postgres    false    8            �           1259    133811    organization_id_seq    SEQUENCE     u   CREATE SEQUENCE organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE security.organization_id_seq;
       security       postgres    false    8    395            0           0    0    organization_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE organization_id_seq OWNED BY organization.id;
            security       postgres    false    396            �           1259    133813    role    TABLE     O   CREATE TABLE role (
    id bigint NOT NULL,
    name character varying(255)
);
    DROP TABLE security.role;
       security         postgres    false    8            �           1259    133816    role_id_seq    SEQUENCE     m   CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE security.role_id_seq;
       security       postgres    false    8    397            1           0    0    role_id_seq    SEQUENCE OWNED BY     -   ALTER SEQUENCE role_id_seq OWNED BY role.id;
            security       postgres    false    398            �           1259    133818    session    TABLE     �   CREATE TABLE session (
    id bigint NOT NULL,
    end0 timestamp without time zone,
    ip character varying(255),
    start timestamp without time zone,
    token character varying(255),
    account_id integer
);
    DROP TABLE security.session;
       security         postgres    false    8            �           1259    133824    session_id_seq    SEQUENCE     p   CREATE SEQUENCE session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE security.session_id_seq;
       security       postgres    false    8    399            2           0    0    session_id_seq    SEQUENCE OWNED BY     3   ALTER SEQUENCE session_id_seq OWNED BY session.id;
            security       postgres    false    400                       2604    133826    id    DEFAULT     v   ALTER TABLE ONLY billingaccountprofile ALTER COLUMN id SET DEFAULT nextval('billingaccountprofile_id_seq'::regclass);
 H   ALTER TABLE billing.billingaccountprofile ALTER COLUMN id DROP DEFAULT;
       billing       postgres    false    172    171                        2604    133827    id    DEFAULT     �   ALTER TABLE ONLY billingorganizationprofile ALTER COLUMN id SET DEFAULT nextval('billingorganizationprofile_id_seq'::regclass);
 M   ALTER TABLE billing.billingorganizationprofile ALTER COLUMN id DROP DEFAULT;
       billing       postgres    false    174    173            !           2604    133828    id    DEFAULT     V   ALTER TABLE ONLY route ALTER COLUMN id SET DEFAULT nextval('route_id_seq'::regclass);
 8   ALTER TABLE billing.route ALTER COLUMN id DROP DEFAULT;
       billing       postgres    false    181    180            "           2604    133829    id    DEFAULT     V   ALTER TABLE ONLY trunk ALTER COLUMN id SET DEFAULT nextval('trunk_id_seq'::regclass);
 8   ALTER TABLE billing.trunk ALTER COLUMN id DROP DEFAULT;
       billing       postgres    false    184    183            t           2604    133830    id    DEFAULT     \   ALTER TABLE ONLY cc_agent ALTER COLUMN id SET DEFAULT nextval('cc_agent_id_seq'::regclass);
 :   ALTER TABLE public.cc_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    192    189            u           2604    133831    id    DEFAULT     r   ALTER TABLE ONLY cc_agent_commission ALTER COLUMN id SET DEFAULT nextval('cc_agent_commission_id_seq'::regclass);
 E   ALTER TABLE public.cc_agent_commission ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    191    190            w           2604    133832    id    DEFAULT     j   ALTER TABLE ONLY cc_agent_signup ALTER COLUMN id SET DEFAULT nextval('cc_agent_signup_id_seq'::regclass);
 A   ALTER TABLE public.cc_agent_signup ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    194    193            �           2604    133833    id    DEFAULT     \   ALTER TABLE ONLY cc_alarm ALTER COLUMN id SET DEFAULT nextval('cc_alarm_id_seq'::regclass);
 :   ALTER TABLE public.cc_alarm ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    197    196            �           2604    133834    id    DEFAULT     j   ALTER TABLE ONLY cc_alarm_report ALTER COLUMN id SET DEFAULT nextval('cc_alarm_report_id_seq'::regclass);
 A   ALTER TABLE public.cc_alarm_report ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    199    198            �           2604    133835    id    DEFAULT     t   ALTER TABLE ONLY cc_autorefill_report ALTER COLUMN id SET DEFAULT nextval('cc_autorefill_report_id_seq'::regclass);
 F   ALTER TABLE public.cc_autorefill_report ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    201    200            �           2604    133836    id    DEFAULT     ^   ALTER TABLE ONLY cc_backup ALTER COLUMN id SET DEFAULT nextval('cc_backup_id_seq'::regclass);
 ;   ALTER TABLE public.cc_backup ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    203    202            �           2604    133837    id    DEFAULT     r   ALTER TABLE ONLY cc_billing_customer ALTER COLUMN id SET DEFAULT nextval('cc_billing_customer_id_seq'::regclass);
 E   ALTER TABLE public.cc_billing_customer ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    205    204            �           2604    133838    id    DEFAULT     Z   ALTER TABLE ONLY cc_call ALTER COLUMN id SET DEFAULT nextval('cc_call_id_seq'::regclass);
 9   ALTER TABLE public.cc_call ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    209    206            �           2604    133839    id    DEFAULT     j   ALTER TABLE ONLY cc_call_archive ALTER COLUMN id SET DEFAULT nextval('cc_call_archive_id_seq'::regclass);
 A   ALTER TABLE public.cc_call_archive ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    208    207            �           2604    133840    id    DEFAULT     n   ALTER TABLE ONLY cc_callback_spool ALTER COLUMN id SET DEFAULT nextval('cc_callback_spool_id_seq'::regclass);
 C   ALTER TABLE public.cc_callback_spool ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    211    210            �           2604    133841    id    DEFAULT     b   ALTER TABLE ONLY cc_callerid ALTER COLUMN id SET DEFAULT nextval('cc_callerid_id_seq'::regclass);
 =   ALTER TABLE public.cc_callerid ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    213    212            �           2604    133842    id    DEFAULT     b   ALTER TABLE ONLY cc_campaign ALTER COLUMN id SET DEFAULT nextval('cc_campaign_id_seq'::regclass);
 =   ALTER TABLE public.cc_campaign ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    223    220            �           2604    133843    id    DEFAULT     p   ALTER TABLE ONLY cc_campaign_config ALTER COLUMN id SET DEFAULT nextval('cc_campaign_config_id_seq'::regclass);
 D   ALTER TABLE public.cc_campaign_config ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    222    221                       2604    133844    id    DEFAULT     Z   ALTER TABLE ONLY cc_card ALTER COLUMN id SET DEFAULT nextval('cc_card_id_seq'::regclass);
 9   ALTER TABLE public.cc_card ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    234    227            8           2604    133845    id    DEFAULT     j   ALTER TABLE ONLY cc_card_archive ALTER COLUMN id SET DEFAULT nextval('cc_card_archive_id_seq'::regclass);
 A   ALTER TABLE public.cc_card_archive ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    229    228            9           2604    133846    id    DEFAULT     f   ALTER TABLE ONLY cc_card_group ALTER COLUMN id SET DEFAULT nextval('cc_card_group_id_seq'::regclass);
 ?   ALTER TABLE public.cc_card_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    231    230            =           2604    133847    id    DEFAULT     j   ALTER TABLE ONLY cc_card_history ALTER COLUMN id SET DEFAULT nextval('cc_card_history_id_seq'::regclass);
 A   ALTER TABLE public.cc_card_history ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    233    232            ?           2604    133848    id    DEFAULT     v   ALTER TABLE ONLY cc_card_package_offer ALTER COLUMN id SET DEFAULT nextval('cc_card_package_offer_id_seq'::regclass);
 G   ALTER TABLE public.cc_card_package_offer ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    236    235            A           2604    133849    id    DEFAULT     f   ALTER TABLE ONLY cc_card_seria ALTER COLUMN id SET DEFAULT nextval('cc_card_seria_id_seq'::regclass);
 ?   ALTER TABLE public.cc_card_seria ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    238    237            L           2604    133850    id    DEFAULT     t   ALTER TABLE ONLY cc_card_subscription ALTER COLUMN id SET DEFAULT nextval('cc_card_subscription_id_seq'::regclass);
 F   ALTER TABLE public.cc_card_subscription ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    240    239            S           2604    133851    id    DEFAULT     ^   ALTER TABLE ONLY cc_charge ALTER COLUMN id SET DEFAULT nextval('cc_charge_id_seq'::regclass);
 ;   ALTER TABLE public.cc_charge ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    243    242            T           2604    133852    id    DEFAULT     ^   ALTER TABLE ONLY cc_config ALTER COLUMN id SET DEFAULT nextval('cc_config_id_seq'::regclass);
 ;   ALTER TABLE public.cc_config ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    247    244            V           2604    133853    id    DEFAULT     j   ALTER TABLE ONLY cc_config_group ALTER COLUMN id SET DEFAULT nextval('cc_config_group_id_seq'::regclass);
 A   ALTER TABLE public.cc_config_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    246    245            W           2604    133854    configuration_id    DEFAULT     �   ALTER TABLE ONLY cc_configuration ALTER COLUMN configuration_id SET DEFAULT nextval('cc_configuration_configuration_id_seq'::regclass);
 P   ALTER TABLE public.cc_configuration ALTER COLUMN configuration_id DROP DEFAULT;
       public       postgres    false    249    248            Y           2604    133855    id    DEFAULT     `   ALTER TABLE ONLY cc_country ALTER COLUMN id SET DEFAULT nextval('cc_country_id_seq'::regclass);
 <   ALTER TABLE public.cc_country ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    251    250            `           2604    133856    id    DEFAULT     f   ALTER TABLE ONLY cc_currencies ALTER COLUMN id SET DEFAULT nextval('cc_currencies_id_seq'::regclass);
 ?   ALTER TABLE public.cc_currencies ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    253    252            j           2604    133857    id    DEFAULT     X   ALTER TABLE ONLY cc_did ALTER COLUMN id SET DEFAULT nextval('cc_did_id_seq'::regclass);
 8   ALTER TABLE public.cc_did ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    257    254            p           2604    133858    id    DEFAULT     p   ALTER TABLE ONLY cc_did_destination ALTER COLUMN id SET DEFAULT nextval('cc_did_destination_id_seq'::regclass);
 D   ALTER TABLE public.cc_did_destination ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    256    255            q           2604    133859    id    DEFAULT     `   ALTER TABLE ONLY cc_did_use ALTER COLUMN id SET DEFAULT nextval('cc_did_use_id_seq'::regclass);
 <   ALTER TABLE public.cc_did_use ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    259    258            v           2604    133860    id    DEFAULT     b   ALTER TABLE ONLY cc_didgroup ALTER COLUMN id SET DEFAULT nextval('cc_didgroup_id_seq'::regclass);
 =   ALTER TABLE public.cc_didgroup ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    261    260            }           2604    133861    id    DEFAULT     j   ALTER TABLE ONLY cc_epayment_log ALTER COLUMN id SET DEFAULT nextval('cc_epayment_log_id_seq'::regclass);
 A   ALTER TABLE public.cc_epayment_log ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    265    262            �           2604    133862    id    DEFAULT     v   ALTER TABLE ONLY cc_epayment_log_agent ALTER COLUMN id SET DEFAULT nextval('cc_epayment_log_agent_id_seq'::regclass);
 G   ALTER TABLE public.cc_epayment_log_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    264    263            I           2604    133863    id    DEFAULT     i   ALTER TABLE ONLY cc_iax_buddies ALTER COLUMN id SET DEFAULT nextval('_cc_iax_buddies_id_seq'::regclass);
 @   ALTER TABLE public.cc_iax_buddies ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    186    185            �           2604    133864    id    DEFAULT     `   ALTER TABLE ONLY cc_invoice ALTER COLUMN id SET DEFAULT nextval('cc_invoice_id_seq'::regclass);
 <   ALTER TABLE public.cc_invoice ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    269    266            �           2604    133865    id    DEFAULT     j   ALTER TABLE ONLY cc_invoice_conf ALTER COLUMN id SET DEFAULT nextval('cc_invoice_conf_id_seq'::regclass);
 A   ALTER TABLE public.cc_invoice_conf ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    268    267            �           2604    133866    id    DEFAULT     j   ALTER TABLE ONLY cc_invoice_item ALTER COLUMN id SET DEFAULT nextval('cc_invoice_item_id_seq'::regclass);
 A   ALTER TABLE public.cc_invoice_item ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    271    270            �           2604    133867    id    DEFAULT     f   ALTER TABLE ONLY cc_logpayment ALTER COLUMN id SET DEFAULT nextval('cc_logpayment_id_seq'::regclass);
 ?   ALTER TABLE public.cc_logpayment ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    277    274            �           2604    133868    id    DEFAULT     r   ALTER TABLE ONLY cc_logpayment_agent ALTER COLUMN id SET DEFAULT nextval('cc_logpayment_agent_id_seq'::regclass);
 E   ALTER TABLE public.cc_logpayment_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    276    275            �           2604    133869    id    DEFAULT     d   ALTER TABLE ONLY cc_logrefill ALTER COLUMN id SET DEFAULT nextval('cc_logrefill_id_seq'::regclass);
 >   ALTER TABLE public.cc_logrefill ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    281    278            �           2604    133870    id    DEFAULT     p   ALTER TABLE ONLY cc_logrefill_agent ALTER COLUMN id SET DEFAULT nextval('cc_logrefill_agent_id_seq'::regclass);
 D   ALTER TABLE public.cc_logrefill_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    280    279            �           2604    133871    id    DEFAULT     l   ALTER TABLE ONLY cc_message_agent ALTER COLUMN id SET DEFAULT nextval('cc_message_agent_id_seq'::regclass);
 B   ALTER TABLE public.cc_message_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    283    282            �           2604    133872    id    DEFAULT     `   ALTER TABLE ONLY cc_monitor ALTER COLUMN id SET DEFAULT nextval('cc_monitor_id_seq'::regclass);
 <   ALTER TABLE public.cc_monitor ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    285    284            �           2604    133873    id    DEFAULT     j   ALTER TABLE ONLY cc_notification ALTER COLUMN id SET DEFAULT nextval('cc_notification_id_seq'::regclass);
 A   ALTER TABLE public.cc_notification ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    288    286            �           2604    133874    id    DEFAULT     v   ALTER TABLE ONLY cc_outbound_cid_group ALTER COLUMN id SET DEFAULT nextval('cc_outbound_cid_group_id_seq'::regclass);
 G   ALTER TABLE public.cc_outbound_cid_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    290    289            �           2604    133875    id    DEFAULT     t   ALTER TABLE ONLY cc_outbound_cid_list ALTER COLUMN id SET DEFAULT nextval('cc_outbound_cid_list_id_seq'::regclass);
 F   ALTER TABLE public.cc_outbound_cid_list ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    292    291            �           2604    133876    id    DEFAULT     l   ALTER TABLE ONLY cc_package_group ALTER COLUMN id SET DEFAULT nextval('cc_package_group_id_seq'::regclass);
 B   ALTER TABLE public.cc_package_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    294    293            �           2604    133877    id    DEFAULT     l   ALTER TABLE ONLY cc_package_offer ALTER COLUMN id SET DEFAULT nextval('cc_package_offer_id_seq'::regclass);
 B   ALTER TABLE public.cc_package_offer ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    296    295            �           2604    133878    id    DEFAULT     p   ALTER TABLE ONLY cc_payment_methods ALTER COLUMN id SET DEFAULT nextval('cc_payment_methods_id_seq'::regclass);
 D   ALTER TABLE public.cc_payment_methods ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    300    299            �           2604    133879    id    DEFAULT     b   ALTER TABLE ONLY cc_payments ALTER COLUMN id SET DEFAULT nextval('cc_payments_id_seq'::regclass);
 =   ALTER TABLE public.cc_payments ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    304    301            �           2604    133880    id    DEFAULT     n   ALTER TABLE ONLY cc_payments_agent ALTER COLUMN id SET DEFAULT nextval('cc_payments_agent_id_seq'::regclass);
 C   ALTER TABLE public.cc_payments_agent ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    303    302            �           2604    133881    id    DEFAULT     p   ALTER TABLE ONLY cc_payments_status ALTER COLUMN id SET DEFAULT nextval('cc_payments_status_id_seq'::regclass);
 D   ALTER TABLE public.cc_payments_status ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    306    305            �           2604    133882    id    DEFAULT     ^   ALTER TABLE ONLY cc_paypal ALTER COLUMN id SET DEFAULT nextval('cc_paypal_id_seq'::regclass);
 ;   ALTER TABLE public.cc_paypal ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    308    307            �           2604    133883    id    DEFAULT     d   ALTER TABLE ONLY cc_phonebook ALTER COLUMN id SET DEFAULT nextval('cc_phonebook_id_seq'::regclass);
 >   ALTER TABLE public.cc_phonebook ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    310    309            �           2604    133884    id    DEFAULT     h   ALTER TABLE ONLY cc_phonenumber ALTER COLUMN id SET DEFAULT nextval('cc_phonenumber_id_seq'::regclass);
 @   ALTER TABLE public.cc_phonenumber ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    312    311            �           2604    133885    prefix    DEFAULT     f   ALTER TABLE ONLY cc_prefix ALTER COLUMN prefix SET DEFAULT nextval('cc_prefix_prefix_seq'::regclass);
 ?   ALTER TABLE public.cc_prefix ALTER COLUMN prefix DROP DEFAULT;
       public       postgres    false    313    214            �           2604    133886    id    DEFAULT     b   ALTER TABLE ONLY cc_provider ALTER COLUMN id SET DEFAULT nextval('cc_provider_id_seq'::regclass);
 =   ALTER TABLE public.cc_provider ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    315    314            �           2604    133887    id    DEFAULT     b   ALTER TABLE ONLY cc_ratecard ALTER COLUMN id SET DEFAULT nextval('cc_ratecard_id_seq'::regclass);
 =   ALTER TABLE public.cc_ratecard ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    316    215            �           2604    133888    id    DEFAULT     `   ALTER TABLE ONLY cc_receipt ALTER COLUMN id SET DEFAULT nextval('cc_receipt_id_seq'::regclass);
 <   ALTER TABLE public.cc_receipt ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    318    317            �           2604    133889    id    DEFAULT     j   ALTER TABLE ONLY cc_receipt_item ALTER COLUMN id SET DEFAULT nextval('cc_receipt_item_id_seq'::regclass);
 A   ALTER TABLE public.cc_receipt_item ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    320    319            �           2604    133890    id    DEFAULT     v   ALTER TABLE ONLY cc_remittance_request ALTER COLUMN id SET DEFAULT nextval('cc_remittance_request_id_seq'::regclass);
 G   ALTER TABLE public.cc_remittance_request ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    322    321            �           2604    133891    id    DEFAULT     ~   ALTER TABLE ONLY cc_restricted_phonenumber ALTER COLUMN id SET DEFAULT nextval('cc_restricted_phonenumber_id_seq'::regclass);
 K   ALTER TABLE public.cc_restricted_phonenumber ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    324    323            �           2604    133892    id    DEFAULT     j   ALTER TABLE ONLY cc_server_group ALTER COLUMN id SET DEFAULT nextval('cc_server_group_id_seq'::regclass);
 A   ALTER TABLE public.cc_server_group ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    326    325            �           2604    133893    id    DEFAULT     n   ALTER TABLE ONLY cc_server_manager ALTER COLUMN id SET DEFAULT nextval('cc_server_manager_id_seq'::regclass);
 C   ALTER TABLE public.cc_server_manager ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    328    327            	           2604    133894    id    DEFAULT     `   ALTER TABLE ONLY cc_service ALTER COLUMN id SET DEFAULT nextval('cc_service_id_seq'::regclass);
 <   ALTER TABLE public.cc_service ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    330    329            
           2604    133895    id    DEFAULT     n   ALTER TABLE ONLY cc_service_report ALTER COLUMN id SET DEFAULT nextval('cc_service_report_id_seq'::regclass);
 C   ALTER TABLE public.cc_service_report ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    332    331            j           2604    133896    id    DEFAULT     i   ALTER TABLE ONLY cc_sip_buddies ALTER COLUMN id SET DEFAULT nextval('_cc_sip_buddies_id_seq'::regclass);
 @   ALTER TABLE public.cc_sip_buddies ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    188    187                       2604    133897    id    DEFAULT     d   ALTER TABLE ONLY cc_speeddial ALTER COLUMN id SET DEFAULT nextval('cc_speeddial_id_seq'::regclass);
 >   ALTER TABLE public.cc_speeddial ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    335    334                       2604    133898    id    DEFAULT     f   ALTER TABLE ONLY cc_status_log ALTER COLUMN id SET DEFAULT nextval('cc_status_log_id_seq'::regclass);
 ?   ALTER TABLE public.cc_status_log ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    337    336                       2604    133899    id    DEFAULT     v   ALTER TABLE ONLY cc_subscription_service ALTER COLUMN id SET DEFAULT nextval('cc_subscription_fee_id_seq'::regclass);
 I   ALTER TABLE public.cc_subscription_service ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    339    338                       2604    133900    id    DEFAULT     x   ALTER TABLE ONLY cc_subscription_signup ALTER COLUMN id SET DEFAULT nextval('cc_subscription_signup_id_seq'::regclass);
 H   ALTER TABLE public.cc_subscription_signup ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    341    340                       2604    133901    id    DEFAULT     `   ALTER TABLE ONLY cc_support ALTER COLUMN id SET DEFAULT nextval('cc_support_id_seq'::regclass);
 <   ALTER TABLE public.cc_support ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    345    342                        2604    133902    id    DEFAULT     t   ALTER TABLE ONLY cc_support_component ALTER COLUMN id SET DEFAULT nextval('cc_support_component_id_seq'::regclass);
 F   ALTER TABLE public.cc_support_component ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    344    343            $           2604    133903    id    DEFAULT     f   ALTER TABLE ONLY cc_system_log ALTER COLUMN id SET DEFAULT nextval('cc_system_log_id_seq'::regclass);
 ?   ALTER TABLE public.cc_system_log ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    347    346            �           2604    133904    id    DEFAULT     h   ALTER TABLE ONLY cc_tariffgroup ALTER COLUMN id SET DEFAULT nextval('cc_tariffgroup_id_seq'::regclass);
 @   ALTER TABLE public.cc_tariffgroup ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    348    216            �           2604    133905    id    DEFAULT     f   ALTER TABLE ONLY cc_tariffplan ALTER COLUMN id SET DEFAULT nextval('cc_tariffplan_id_seq'::regclass);
 ?   ALTER TABLE public.cc_tariffplan ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    349    218            )           2604    133906    id    DEFAULT     j   ALTER TABLE ONLY cc_templatemail ALTER COLUMN id SET DEFAULT nextval('cc_templatemail_id_seq'::regclass);
 A   ALTER TABLE public.cc_templatemail ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    351    350            5           2604    133907    id    DEFAULT     ^   ALTER TABLE ONLY cc_ticket ALTER COLUMN id SET DEFAULT nextval('cc_ticket_id_seq'::regclass);
 ;   ALTER TABLE public.cc_ticket ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    356    352            ;           2604    133908    id    DEFAULT     n   ALTER TABLE ONLY cc_ticket_comment ALTER COLUMN id SET DEFAULT nextval('cc_ticket_comment_id_seq'::regclass);
 C   ALTER TABLE public.cc_ticket_comment ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    354    353            <           2604    133909 	   id_ticket    DEFAULT     |   ALTER TABLE ONLY cc_ticket_comment ALTER COLUMN id_ticket SET DEFAULT nextval('cc_ticket_comment_id_ticket_seq'::regclass);
 J   ALTER TABLE public.cc_ticket_comment ALTER COLUMN id_ticket DROP DEFAULT;
       public       postgres    false    355    353            =           2604    133910    id    DEFAULT     b   ALTER TABLE ONLY cc_timezone ALTER COLUMN id SET DEFAULT nextval('cc_timezone_id_seq'::regclass);
 =   ALTER TABLE public.cc_timezone ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    358    357            G           2604    133911    id_trunk    DEFAULT     h   ALTER TABLE ONLY cc_trunk ALTER COLUMN id_trunk SET DEFAULT nextval('cc_trunk_id_trunk_seq'::regclass);
 @   ALTER TABLE public.cc_trunk ALTER COLUMN id_trunk DROP DEFAULT;
       public       postgres    false    360    359            H           2604    133912    userid    DEFAULT     l   ALTER TABLE ONLY cc_ui_authen ALTER COLUMN userid SET DEFAULT nextval('cc_ui_authen_userid_seq'::regclass);
 B   ALTER TABLE public.cc_ui_authen ALTER COLUMN userid DROP DEFAULT;
       public       postgres    false    362    361            J           2604    133913    id    DEFAULT     `   ALTER TABLE ONLY cc_voucher ALTER COLUMN id SET DEFAULT nextval('cc_voucher_id_seq'::regclass);
 <   ALTER TABLE public.cc_voucher ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    365    364            O           2604    133914    id    DEFAULT     p   ALTER TABLE ONLY pbx_accountprofile ALTER COLUMN id SET DEFAULT nextval('pbx_accountprofile_id_seq'::regclass);
 D   ALTER TABLE public.pbx_accountprofile ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    368    367            P           2604    133915    id    DEFAULT     f   ALTER TABLE ONLY pbx_blacklist ALTER COLUMN id SET DEFAULT nextval('pbx_blacklist_id_seq'::regclass);
 ?   ALTER TABLE public.pbx_blacklist ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    370    369            Q           2604    133916    id    DEFAULT     Z   ALTER TABLE ONLY pbx_cdr ALTER COLUMN id SET DEFAULT nextval('pbx_cdr_id_seq'::regclass);
 9   ALTER TABLE public.pbx_cdr ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    372    371            R           2604    133917    id    DEFAULT     ^   ALTER TABLE ONLY pbx_exten ALTER COLUMN id SET DEFAULT nextval('pbx_exten_id_seq'::regclass);
 ;   ALTER TABLE public.pbx_exten ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    377    376            S           2604    133918    id    DEFAULT     Z   ALTER TABLE ONLY pbx_ivr ALTER COLUMN id SET DEFAULT nextval('pbx_ivr_id_seq'::regclass);
 9   ALTER TABLE public.pbx_ivr ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    380    379            T           2604    133919    id    DEFAULT     f   ALTER TABLE ONLY pbx_ivroption ALTER COLUMN id SET DEFAULT nextval('pbx_ivroption_id_seq'::regclass);
 ?   ALTER TABLE public.pbx_ivroption ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    382    381            U           2604    133920    id    DEFAULT     z   ALTER TABLE ONLY pbx_organizationprofile ALTER COLUMN id SET DEFAULT nextval('pbx_organizationprofile_id_seq'::regclass);
 I   ALTER TABLE public.pbx_organizationprofile ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    384    383            V           2604    133921    id    DEFAULT     ^   ALTER TABLE ONLY pbx_queue ALTER COLUMN id SET DEFAULT nextval('pbx_queue_id_seq'::regclass);
 ;   ALTER TABLE public.pbx_queue ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    386    385            W           2604    133922    id    DEFAULT     d   ALTER TABLE ONLY pbx_queuelog ALTER COLUMN id SET DEFAULT nextval('pbx_queuelog_id_seq'::regclass);
 >   ALTER TABLE public.pbx_queuelog ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    388    387            X           2604    133923    id    DEFAULT     f   ALTER TABLE ONLY pbx_voicemail ALTER COLUMN id SET DEFAULT nextval('pbx_voicemail_id_seq'::regclass);
 ?   ALTER TABLE public.pbx_voicemail ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    391    390            Y           2604    133924    id    DEFAULT     Z   ALTER TABLE ONLY account ALTER COLUMN id SET DEFAULT nextval('account_id_seq'::regclass);
 ;   ALTER TABLE security.account ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    393    392            Z           2604    133925    id    DEFAULT     d   ALTER TABLE ONLY organization ALTER COLUMN id SET DEFAULT nextval('organization_id_seq'::regclass);
 @   ALTER TABLE security.organization ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    396    395            [           2604    133926    id    DEFAULT     T   ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);
 8   ALTER TABLE security.role ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    398    397            \           2604    133927    id    DEFAULT     Z   ALTER TABLE ONLY session ALTER COLUMN id SET DEFAULT nextval('session_id_seq'::regclass);
 ;   ALTER TABLE security.session ALTER COLUMN id DROP DEFAULT;
       security       postgres    false    400    399            �          0    132492    billingaccountprofile 
   TABLE DATA               7   COPY billingaccountprofile (id, accountid) FROM stdin;
    billing       postgres    false    171   k�      3           0    0    billingaccountprofile_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('billingaccountprofile_id_seq', 11, true);
            billing       postgres    false    172            �          0    132497    billingorganizationprofile 
   TABLE DATA               A   COPY billingorganizationprofile (id, organizationid) FROM stdin;
    billing       postgres    false    173   ��      4           0    0 !   billingorganizationprofile_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('billingorganizationprofile_id_seq', 6, true);
            billing       postgres    false    174            �          0    132502 
   creditcard 
   TABLE DATA               T   COPY creditcard (id, accountid, accountcode, creation, credit, enabled) FROM stdin;
    billing       postgres    false    175   ��      �          0    132505    openjpa_sequence_table 
   TABLE DATA               =   COPY openjpa_sequence_table (id, sequence_value) FROM stdin;
    billing       postgres    false    176   ̔      �          0    132508    plan 
   TABLE DATA               G   COPY plan (id, buyblock, buymin, name, sellblock, sellmin) FROM stdin;
    billing       postgres    false    177   �      �          0    132511    priority 
   TABLE DATA               '   COPY priority (id, number) FROM stdin;
    billing       postgres    false    178   �      �          0    132514    report 
   TABLE DATA               k   COPY report (id, billsec, calldate, charge, clid, dst, duration, uniqueid, creditcard, tariff) FROM stdin;
    billing       postgres    false    179   #�      �          0    132520    route 
   TABLE DATA               *   COPY route (id, name, prefix) FROM stdin;
    billing       postgres    false    180   @�      5           0    0    route_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('route_id_seq', 1, false);
            billing       postgres    false    181            �          0    132528    tariff 
   TABLE DATA               6   COPY tariff (id, buyrate, name, sellrate) FROM stdin;
    billing       postgres    false    182   ]�      �          0    132531    trunk 
   TABLE DATA               ~   COPY trunk (id, addprefix, creation, hostname, identifier, name, password, removeprefix, tech, timeout, username) FROM stdin;
    billing       postgres    false    183   z�      6           0    0    trunk_id_seq    SEQUENCE SET     4   SELECT pg_catalog.setval('trunk_id_seq', 1, false);
            billing       postgres    false    184            �          0    140686    campaign 
   TABLE DATA               ]   COPY campaign (id, creationdate, enabled, name, organizationid, queueid, script) FROM stdin;
 
   callcenter       postgres    false    401   ��      �          0    140694    disposition 
   TABLE DATA               J   COPY disposition (id, description, name, order0, campaign_id) FROM stdin;
 
   callcenter       postgres    false    402   ɕ      �          0    140702    field 
   TABLE DATA               3   COPY field (id, name, type, layout_id) FROM stdin;
 
   callcenter       postgres    false    403   �      �          0    140710    layout 
   TABLE DATA               *   COPY layout (id, campaign_id) FROM stdin;
 
   callcenter       postgres    false    404   �      �          0    140715    lead 
   TABLE DATA               8   COPY lead (id, attemps, fired, campaign_id) FROM stdin;
 
   callcenter       postgres    false    405   %�      �          0    140720 
   leaddetail 
   TABLE DATA               ;   COPY leaddetail (id, value, lead_id, field_id) FROM stdin;
 
   callcenter       postgres    false    406   B�      �          0    140725    openjpa_sequence_table 
   TABLE DATA               =   COPY openjpa_sequence_table (id, sequence_value) FROM stdin;
 
   callcenter       postgres    false    407   _�      �          0    140730    result 
   TABLE DATA               0   COPY result (id, date, campaign_id) FROM stdin;
 
   callcenter       postgres    false    408   ��      7           0    0    _cc_iax_buddies_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('_cc_iax_buddies_id_seq', 6, true);
            public       postgres    false    186            8           0    0    _cc_sip_buddies_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('_cc_sip_buddies_id_seq', 9, true);
            public       postgres    false    188            �          0    132655    cc_agent 
   TABLE DATA               2  COPY cc_agent (id, datecreation, active, login, passwd, location, language, id_tariffgroup, options, credit, currency, locale, commission, vat, banner, perms, lastname, firstname, address, city, state, country, zipcode, phone, email, fax, company, com_balance, threshold_remittance, bank_info) FROM stdin;
    public       postgres    false    189   ��      �          0    132670    cc_agent_commission 
   TABLE DATA               �   COPY cc_agent_commission (id, id_payment, id_card, date, amount, description, id_agent, commission_type, commission_percent) FROM stdin;
    public       postgres    false    190   ��      9           0    0    cc_agent_commission_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('cc_agent_commission_id_seq', 1, false);
            public       postgres    false    191            :           0    0    cc_agent_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('cc_agent_id_seq', 1, false);
            public       postgres    false    192            �          0    132681    cc_agent_signup 
   TABLE DATA               P   COPY cc_agent_signup (id, id_agent, code, id_tariffgroup, id_group) FROM stdin;
    public       postgres    false    193   ٖ      ;           0    0    cc_agent_signup_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_agent_signup_id_seq', 1, false);
            public       postgres    false    194            �          0    132686    cc_agent_tariffgroup 
   TABLE DATA               A   COPY cc_agent_tariffgroup (id_agent, id_tariffgroup) FROM stdin;
    public       postgres    false    195   ��      �          0    132689    cc_alarm 
   TABLE DATA               �   COPY cc_alarm (id, name, periode, type, maxvalue, minvalue, id_trunk, status, numberofrun, numberofalarm, datecreate, datelastrun, emailreport) FROM stdin;
    public       postgres    false    196   �      <           0    0    cc_alarm_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('cc_alarm_id_seq', 1, false);
            public       postgres    false    197            �          0    132705    cc_alarm_report 
   TABLE DATA               M   COPY cc_alarm_report (id, cc_alarm_id, calculatedvalue, daterun) FROM stdin;
    public       postgres    false    198   0�      =           0    0    cc_alarm_report_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_alarm_report_id_seq', 1, false);
            public       postgres    false    199            �          0    132714    cc_autorefill_report 
   TABLE DATA               S   COPY cc_autorefill_report (id, daterun, totalcardperform, totalcredit) FROM stdin;
    public       postgres    false    200   M�      >           0    0    cc_autorefill_report_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('cc_autorefill_report_id_seq', 1, false);
            public       postgres    false    201            �          0    132720 	   cc_backup 
   TABLE DATA               :   COPY cc_backup (id, name, path, creationdate) FROM stdin;
    public       postgres    false    202   j�      ?           0    0    cc_backup_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_backup_id_seq', 1, false);
            public       postgres    false    203            �          0    132731    cc_billing_customer 
   TABLE DATA               Q   COPY cc_billing_customer (id, id_card, date, id_invoice, start_date) FROM stdin;
    public       postgres    false    204   ��      @           0    0    cc_billing_customer_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('cc_billing_customer_id_seq', 1, false);
            public       postgres    false    205            �          0    132737    cc_call 
   TABLE DATA               *  COPY cc_call (id, card_id, sessionid, uniqueid, nasipaddress, starttime, stoptime, sessiontime, calledstation, destination, terminatecauseid, sessionbill, id_tariffgroup, id_tariffplan, id_ratecard, id_trunk, sipiax, src, id_did, buycost, id_card_package_offer, real_sessiontime, dnid) FROM stdin;
    public       postgres    false    206   ��      �          0    132748    cc_call_archive 
   TABLE DATA               2  COPY cc_call_archive (id, sessionid, uniqueid, card_id, nasipaddress, starttime, stoptime, sessiontime, calledstation, sessionbill, id_tariffgroup, id_tariffplan, id_ratecard, id_trunk, sipiax, src, id_did, buycost, id_card_package_offer, real_sessiontime, dnid, terminatecauseid, destination) FROM stdin;
    public       postgres    false    207   ��      A           0    0    cc_call_archive_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_call_archive_id_seq', 1, false);
            public       postgres    false    208            B           0    0    cc_call_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('cc_call_id_seq', 183, true);
            public       postgres    false    209                       0    132762    cc_callback_spool 
   TABLE DATA               %  COPY cc_callback_spool (id, uniqueid, entry_time, status, server_ip, num_attempt, last_attempt_time, manager_result, agi_result, callback_time, channel, exten, context, priority, application, data, timeout, callerid, variable, account, async, actionid, id_server, id_server_group) FROM stdin;
    public       postgres    false    210   ޗ      C           0    0    cc_callback_spool_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_callback_spool_id_seq', 1, false);
            public       postgres    false    211                      0    132772    cc_callerid 
   TABLE DATA               >   COPY cc_callerid (id, cid, id_cc_card, activated) FROM stdin;
    public       postgres    false    212   ��      D           0    0    cc_callerid_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_callerid_id_seq', 2, true);
            public       postgres    false    213            	          0    132863    cc_campaign 
   TABLE DATA               9  COPY cc_campaign (id, name, creationdate, startingdate, expirationdate, description, id_card, secondusedreal, nb_callmade, status, frequency, forward_number, daily_start_time, daily_stop_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday, id_cid_group, id_campaign_config, callerid) FROM stdin;
    public       postgres    false    220   �      
          0    132885    cc_campaign_config 
   TABLE DATA               O   COPY cc_campaign_config (id, name, flatrate, context, description) FROM stdin;
    public       postgres    false    221   5�      E           0    0    cc_campaign_config_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('cc_campaign_config_id_seq', 1, false);
            public       postgres    false    222            F           0    0    cc_campaign_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_campaign_id_seq', 1, false);
            public       postgres    false    223                      0    132896    cc_campaign_phonebook 
   TABLE DATA               C   COPY cc_campaign_phonebook (id_campaign, id_phonebook) FROM stdin;
    public       postgres    false    224   R�                0    132899    cc_campaign_phonestatus 
   TABLE DATA               e   COPY cc_campaign_phonestatus (id_phonenumber, id_campaign, id_callback, status, lastuse) FROM stdin;
    public       postgres    false    225   o�                0    132904    cc_campaignconf_cardgroup 
   TABLE DATA               O   COPY cc_campaignconf_cardgroup (id_campaign_config, id_card_group) FROM stdin;
    public       postgres    false    226   ��                0    132907    cc_card 
   TABLE DATA               �  COPY cc_card (id, creationdate, firstusedate, expirationdate, enableexpire, expiredays, username, useralias, uipass, credit, tariff, id_didgroup, activated, lastname, firstname, address, city, state, country, zipcode, phone, email, fax, inuse, simultaccess, currency, lastuse, nbused, typepaid, creditlimit, voipcall, sip_buddy, iax_buddy, language, redial, runservice, nbservice, id_campaign, num_trials_done, vat, servicelastrun, initialbalance, invoiceday, autorefill, loginkey, mac_addr, id_timezone, status, tag, voicemail_permitted, voicemail_activated, last_notification, email_notification, notify_email, credit_notification, id_group, company_name, company_website, vat_rn, traffic, traffic_target, discount, restriction, id_seria, serial, block, lock_pin, lock_date, max_concurrent, voiceprofile_id, accountid, billingprofile_id, accountprofile_id, organizationprofile_id, billingaccountprofile_id, billingorganizationprofile_id) FROM stdin;
    public       postgres    false    227   ��                0    132952    cc_card_archive 
   TABLE DATA                 COPY cc_card_archive (id, creationdate, firstusedate, expirationdate, enableexpire, expiredays, username, useralias, uipass, credit, tariff, id_didgroup, activated, lastname, firstname, address, city, state, country, zipcode, phone, email, fax, inuse, simultaccess, currency, lastuse, nbused, typepaid, creditlimit, voipcall, sip_buddy, iax_buddy, language, redial, runservice, nbservice, id_campaign, num_trials_done, vat, servicelastrun, initialbalance, invoiceday, autorefill, loginkey, mac_addr, id_timezone, status, tag, voicemail_permitted, voicemail_activated, last_notification, email_notification, notify_email, credit_notification, id_group, company_name, company_website, vat_rn, traffic, traffic_target, discount, restriction, id_seria, serial) FROM stdin;
    public       postgres    false    228   Ƙ      G           0    0    cc_card_archive_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_card_archive_id_seq', 1, false);
            public       postgres    false    229                      0    132996    cc_card_group 
   TABLE DATA               x   COPY cc_card_group (id, name, description, users_perms, id_agent, flatrate, campaign_context, provisioning) FROM stdin;
    public       postgres    false    230   �      H           0    0    cc_card_group_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('cc_card_group_id_seq', 5, true);
            public       postgres    false    231                      0    133007    cc_card_history 
   TABLE DATA               L   COPY cc_card_history (id, id_cc_card, datecreated, description) FROM stdin;
    public       postgres    false    232   ��      I           0    0    cc_card_history_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('cc_card_history_id_seq', 1, true);
            public       postgres    false    233            J           0    0    cc_card_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('cc_card_id_seq', 7, true);
            public       postgres    false    234                      0    133018    cc_card_package_offer 
   TABLE DATA               n   COPY cc_card_package_offer (id, id_cc_card, id_cc_package_offer, date_consumption, used_secondes) FROM stdin;
    public       postgres    false    235   ��      K           0    0    cc_card_package_offer_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('cc_card_package_offer_id_seq', 1, false);
            public       postgres    false    236                      0    133024    cc_card_seria 
   TABLE DATA               >   COPY cc_card_seria (id, name, description, value) FROM stdin;
    public       postgres    false    237   ř      L           0    0    cc_card_seria_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cc_card_seria_id_seq', 1, false);
            public       postgres    false    238                      0    133033    cc_card_subscription 
   TABLE DATA               �   COPY cc_card_subscription (id, id_cc_card, id_subscription_fee, startdate, stopdate, product_id, product_name, paid_status, last_run, next_billing_date, limit_pay_date) FROM stdin;
    public       postgres    false    239   �      M           0    0    cc_card_subscription_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('cc_card_subscription_id_seq', 1, false);
            public       postgres    false    240                      0    133047    cc_cardgroup_service 
   TABLE DATA               B   COPY cc_cardgroup_service (id_card_group, id_service) FROM stdin;
    public       postgres    false    241   ��                0    133050 	   cc_charge 
   TABLE DATA               �   COPY cc_charge (id, id_cc_card, iduser, creationdate, amount, chargetype, description, id_cc_did, id_cc_card_subscription, cover_from, cover_to, charged_status, invoiced_status) FROM stdin;
    public       postgres    false    242   �      N           0    0    cc_charge_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_charge_id_seq', 1, false);
            public       postgres    false    243            !          0    133064 	   cc_config 
   TABLE DATA               �   COPY cc_config (id, config_title, config_key, config_value, config_description, config_valuetype, config_listvalues, config_group_title) FROM stdin;
    public       postgres    false    244   9�      "          0    133071    cc_config_group 
   TABLE DATA               F   COPY cc_config_group (id, group_title, group_description) FROM stdin;
    public       postgres    false    245   ��      O           0    0    cc_config_group_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_config_group_id_seq', 16, true);
            public       postgres    false    246            P           0    0    cc_config_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_config_id_seq', 300, true);
            public       postgres    false    247            %          0    133078    cc_configuration 
   TABLE DATA               �   COPY cc_configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_type, use_function, set_function) FROM stdin;
    public       postgres    false    248   3�      Q           0    0 %   cc_configuration_configuration_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('cc_configuration_configuration_id_seq', 25, true);
            public       postgres    false    249            '          0    133087 
   cc_country 
   TABLE DATA               J   COPY cc_country (id, countrycode, countryprefix, countryname) FROM stdin;
    public       postgres    false    250   ��      R           0    0    cc_country_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_country_id_seq', 1, false);
            public       postgres    false    251            )          0    133096    cc_currencies 
   TABLE DATA               U   COPY cc_currencies (id, currency, name, value, lastupdate, basecurrency) FROM stdin;
    public       postgres    false    252   ��      S           0    0    cc_currencies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cc_currencies_id_seq', 1, false);
            public       postgres    false    253            +          0    133106    cc_did 
   TABLE DATA               �   COPY cc_did (id, id_cc_didgroup, id_cc_country, activated, reserved, iduser, did, creationdate, startingdate, expirationdate, description, secondusedreal, billingtype, fixrate, connection_charge, selling_rate) FROM stdin;
    public       postgres    false    254   I�      ,          0    133121    cc_did_destination 
   TABLE DATA               �   COPY cc_did_destination (id, destination, priority, id_cc_card, id_cc_did, creationdate, activated, secondusedreal, voip_call) FROM stdin;
    public       postgres    false    255   f�      T           0    0    cc_did_destination_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('cc_did_destination_id_seq', 1, false);
            public       postgres    false    256            U           0    0    cc_did_id_seq    SEQUENCE SET     5   SELECT pg_catalog.setval('cc_did_id_seq', 1, false);
            public       postgres    false    257            /          0    133136 
   cc_did_use 
   TABLE DATA               u   COPY cc_did_use (id, id_cc_card, id_did, reservationdate, releasedate, activated, month_payed, reminded) FROM stdin;
    public       postgres    false    258   ��      V           0    0    cc_did_use_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_did_use_id_seq', 1, false);
            public       postgres    false    259            1          0    133145    cc_didgroup 
   TABLE DATA               >   COPY cc_didgroup (id, creationdate, didgroupname) FROM stdin;
    public       postgres    false    260   ��      W           0    0    cc_didgroup_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_didgroup_id_seq', 1, false);
            public       postgres    false    261            3          0    133154    cc_epayment_log 
   TABLE DATA               �   COPY cc_epayment_log (id, cardid, amount, vat, paymentmethod, cc_owner, cc_number, cc_expires, creationdate, status, cvv, credit_card_type, currency, transaction_detail, item_type, item_id) FROM stdin;
    public       postgres    false    262   ��      4          0    133165    cc_epayment_log_agent 
   TABLE DATA               �   COPY cc_epayment_log_agent (id, agent_id, amount, vat, paymentmethod, cc_owner, cc_number, cc_expires, creationdate, status, cvv, credit_card_type, currency, transaction_detail) FROM stdin;
    public       postgres    false    263   ��      X           0    0    cc_epayment_log_agent_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('cc_epayment_log_agent_id_seq', 1, false);
            public       postgres    false    264            Y           0    0    cc_epayment_log_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_epayment_log_id_seq', 1, false);
            public       postgres    false    265            �          0    132569    cc_iax_buddies 
   TABLE DATA               =  COPY cc_iax_buddies (id, id_cc_card, name, type, username, accountcode, regexten, callerid, amaflags, secret, disallow, allow, host, qualify, context, defaultip, language, deny, permit, mask, port, regseconds, ipaddr, trunk, dbsecret, regcontext, sourceaddress, mohinterpret, mohsuggest, inkeys, outkey, cid_number, sendani, fullname, auth, maxauthreq, encryption, transfer, jitterbuffer, forcejitterbuffer, codecpriority, qualifysmoothing, qualifyfreqok, qualifyfreqnotok, timezone, adsi, setvar, requirecalltoken, maxcallnumbers, maxcallnumbers_nonvalidated) FROM stdin;
    public       postgres    false    185   ��      7          0    133186 
   cc_invoice 
   TABLE DATA               d   COPY cc_invoice (id, reference, id_card, date, paid_status, status, title, description) FROM stdin;
    public       postgres    false    266   �      8          0    133195    cc_invoice_conf 
   TABLE DATA               6   COPY cc_invoice_conf (id, key_val, value) FROM stdin;
    public       postgres    false    267   ��      Z           0    0    cc_invoice_conf_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_invoice_conf_id_seq', 12, true);
            public       postgres    false    268            [           0    0    cc_invoice_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_invoice_id_seq', 4, true);
            public       postgres    false    269            ;          0    133202    cc_invoice_item 
   TABLE DATA               c   COPY cc_invoice_item (id, id_invoice, date, price, vat, description, id_ext, type_ext) FROM stdin;
    public       postgres    false    270   O�      \           0    0    cc_invoice_item_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('cc_invoice_item_id_seq', 4, true);
            public       postgres    false    271            =          0    133213    cc_invoice_payment 
   TABLE DATA               =   COPY cc_invoice_payment (id_invoice, id_payment) FROM stdin;
    public       postgres    false    272   ��      >          0    133216 	   cc_iso639 
   TABLE DATA               8   COPY cc_iso639 (code, name, lname, charset) FROM stdin;
    public       postgres    false    273   ��      ?          0    133223    cc_logpayment 
   TABLE DATA               �   COPY cc_logpayment (id, date, payment, card_id, id_logrefill, description, added_refill, payment_type, added_commission, agent_id) FROM stdin;
    public       postgres    false    274   ��      @          0    133233    cc_logpayment_agent 
   TABLE DATA               �   COPY cc_logpayment_agent (id, date, payment, agent_id, id_logrefill, description, added_refill, payment_type, added_commission) FROM stdin;
    public       postgres    false    275   N�      ]           0    0    cc_logpayment_agent_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('cc_logpayment_agent_id_seq', 1, false);
            public       postgres    false    276            ^           0    0    cc_logpayment_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('cc_logpayment_id_seq', 4, true);
            public       postgres    false    277            C          0    133247    cc_logrefill 
   TABLE DATA               m   COPY cc_logrefill (id, date, credit, card_id, description, refill_type, added_invoice, agent_id) FROM stdin;
    public       postgres    false    278   k�      D          0    133256    cc_logrefill_agent 
   TABLE DATA               [   COPY cc_logrefill_agent (id, date, credit, agent_id, description, refill_type) FROM stdin;
    public       postgres    false    279   ��      _           0    0    cc_logrefill_agent_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('cc_logrefill_agent_id_seq', 1, false);
            public       postgres    false    280            `           0    0    cc_logrefill_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_logrefill_id_seq', 7, true);
            public       postgres    false    281            G          0    133268    cc_message_agent 
   TABLE DATA               U   COPY cc_message_agent (id, id_agent, message, type, logo, order_display) FROM stdin;
    public       postgres    false    282   �      a           0    0    cc_message_agent_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('cc_message_agent_id_seq', 1, false);
            public       postgres    false    283            I          0    133278 
   cc_monitor 
   TABLE DATA               t   COPY cc_monitor (id, label, dial_code, description, text_intro, query_type, query, result_type, enable) FROM stdin;
    public       postgres    false    284   )�      b           0    0    cc_monitor_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_monitor_id_seq', 3, true);
            public       postgres    false    285            K          0    133289    cc_notification 
   TABLE DATA               i   COPY cc_notification (id, key_value, date, priority, from_type, from_id, link_id, link_type) FROM stdin;
    public       postgres    false    286   �      L          0    133295    cc_notification_admin 
   TABLE DATA               K   COPY cc_notification_admin (id_notification, id_admin, viewed) FROM stdin;
    public       postgres    false    287   8�      c           0    0    cc_notification_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_notification_id_seq', 1, false);
            public       postgres    false    288            N          0    133301    cc_outbound_cid_group 
   TABLE DATA               F   COPY cc_outbound_cid_group (id, creationdate, group_name) FROM stdin;
    public       postgres    false    289   U�      d           0    0    cc_outbound_cid_group_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('cc_outbound_cid_group_id_seq', 1, false);
            public       postgres    false    290            P          0    133310    cc_outbound_cid_list 
   TABLE DATA               ]   COPY cc_outbound_cid_list (id, outbound_cid_group, cid, activated, creationdate) FROM stdin;
    public       postgres    false    291   r�      e           0    0    cc_outbound_cid_list_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('cc_outbound_cid_list_id_seq', 1, false);
            public       postgres    false    292            R          0    133320    cc_package_group 
   TABLE DATA               :   COPY cc_package_group (id, name, description) FROM stdin;
    public       postgres    false    293   ��      f           0    0    cc_package_group_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('cc_package_group_id_seq', 1, false);
            public       postgres    false    294            T          0    133328    cc_package_offer 
   TABLE DATA               p   COPY cc_package_offer (id, creationdate, label, packagetype, billingtype, startday, freetimetocall) FROM stdin;
    public       postgres    false    295   ��      g           0    0    cc_package_offer_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('cc_package_offer_id_seq', 1, false);
            public       postgres    false    296            V          0    133337    cc_package_rate 
   TABLE DATA               7   COPY cc_package_rate (package_id, rate_id) FROM stdin;
    public       postgres    false    297   ��      W          0    133340    cc_packgroup_package 
   TABLE DATA               D   COPY cc_packgroup_package (packagegroup_id, package_id) FROM stdin;
    public       postgres    false    298   ��      X          0    133343    cc_payment_methods 
   TABLE DATA               K   COPY cc_payment_methods (id, payment_method, payment_filename) FROM stdin;
    public       postgres    false    299   �      h           0    0    cc_payment_methods_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_payment_methods_id_seq', 4, true);
            public       postgres    false    300            Z          0    133351    cc_payments 
   TABLE DATA               #  COPY cc_payments (id, customers_id, customers_name, customers_email_address, item_name, item_id, item_quantity, payment_method, cc_type, cc_owner, cc_number, cc_expires, orders_status, orders_amount, last_modified, date_purchased, orders_date_finished, currency, currency_value) FROM stdin;
    public       postgres    false    301   Q�      [          0    133359    cc_payments_agent 
   TABLE DATA                 COPY cc_payments_agent (id, agent_id, agent_name, agent_email_address, item_name, item_id, item_quantity, payment_method, cc_type, cc_owner, cc_number, cc_expires, orders_status, orders_amount, last_modified, date_purchased, orders_date_finished, currency, currency_value) FROM stdin;
    public       postgres    false    302   n�      i           0    0    cc_payments_agent_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_payments_agent_id_seq', 1, false);
            public       postgres    false    303            j           0    0    cc_payments_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_payments_id_seq', 1, false);
            public       postgres    false    304            ^          0    133379    cc_payments_status 
   TABLE DATA               A   COPY cc_payments_status (id, status_id, status_name) FROM stdin;
    public       postgres    false    305   ��      k           0    0    cc_payments_status_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_payments_status_id_seq', 8, true);
            public       postgres    false    306            `          0    133384 	   cc_paypal 
   TABLE DATA               �  COPY cc_paypal (id, payer_id, payment_date, txn_id, first_name, last_name, payer_email, payer_status, payment_type, memo, item_name, item_number, quantity, mc_gross, mc_fee, tax, mc_currency, address_name, address_street, address_city, address_state, address_zip, address_country, address_status, payer_business_name, payment_status, pending_reason, reason_code, txn_type) FROM stdin;
    public       postgres    false    307   �      l           0    0    cc_paypal_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_paypal_id_seq', 1, false);
            public       postgres    false    308            b          0    133419    cc_phonebook 
   TABLE DATA               ?   COPY cc_phonebook (id, name, description, id_card) FROM stdin;
    public       postgres    false    309    �      m           0    0    cc_phonebook_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('cc_phonebook_id_seq', 1, false);
            public       postgres    false    310            d          0    133427    cc_phonenumber 
   TABLE DATA               e   COPY cc_phonenumber (id, id_phonebook, number, name, creationdate, status, info, amount) FROM stdin;
    public       postgres    false    311   =�      n           0    0    cc_phonenumber_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('cc_phonenumber_id_seq', 1, false);
            public       postgres    false    312                      0    132781 	   cc_prefix 
   TABLE DATA               1   COPY cc_prefix (prefix, destination) FROM stdin;
    public       postgres    false    214   Z�      o           0    0    cc_prefix_prefix_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cc_prefix_prefix_seq', 1, false);
            public       postgres    false    313            g          0    133440    cc_provider 
   TABLE DATA               L   COPY cc_provider (id, provider_name, creationdate, description) FROM stdin;
    public       postgres    false    314   w�      p           0    0    cc_provider_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_provider_id_seq', 1, false);
            public       postgres    false    315                      0    132784    cc_ratecard 
   TABLE DATA               �  COPY cc_ratecard (id, idtariffplan, dialprefix, destination, buyrate, buyrateinitblock, buyrateincrement, rateinitial, initblock, billingblock, connectcharge, disconnectcharge, stepchargea, chargea, timechargea, billingblocka, stepchargeb, chargeb, timechargeb, billingblockb, stepchargec, chargec, timechargec, billingblockc, startdate, stopdate, starttime, endtime, id_trunk, musiconhold, id_outbound_cidgroup, rounding_calltime, rounding_threshold, additional_block_charge, additional_block_charge_time, tag, is_merged, additional_grace, minimal_cost, announce_time_correction, disconnectcharge_after, billingorganizationprofile_id) FROM stdin;
    public       postgres    false    215   ��      q           0    0    cc_ratecard_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_ratecard_id_seq', 145187, true);
            public       postgres    false    316            j          0    133451 
   cc_receipt 
   TABLE DATA               L   COPY cc_receipt (id, id_card, date, title, description, status) FROM stdin;
    public       postgres    false    317   4�      r           0    0    cc_receipt_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_receipt_id_seq', 1, false);
            public       postgres    false    318            l          0    133461    cc_receipt_item 
   TABLE DATA               ^   COPY cc_receipt_item (id, id_receipt, date, price, description, id_ext, type_ext) FROM stdin;
    public       postgres    false    319   Q�      s           0    0    cc_receipt_item_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_receipt_item_id_seq', 1, false);
            public       postgres    false    320            n          0    133472    cc_remittance_request 
   TABLE DATA               R   COPY cc_remittance_request (id, id_agent, amount, type, date, status) FROM stdin;
    public       postgres    false    321   n�      t           0    0    cc_remittance_request_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('cc_remittance_request_id_seq', 1, false);
            public       postgres    false    322            p          0    133479    cc_restricted_phonenumber 
   TABLE DATA               A   COPY cc_restricted_phonenumber (id, number, id_card) FROM stdin;
    public       postgres    false    323   ��      u           0    0     cc_restricted_phonenumber_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('cc_restricted_phonenumber_id_seq', 1, false);
            public       postgres    false    324            r          0    133484    cc_server_group 
   TABLE DATA               9   COPY cc_server_group (id, name, description) FROM stdin;
    public       postgres    false    325   ��      v           0    0    cc_server_group_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_server_group_id_seq', 1, false);
            public       postgres    false    326            t          0    133492    cc_server_manager 
   TABLE DATA               |   COPY cc_server_manager (id, id_group, server_ip, manager_host, manager_username, manager_secret, lasttime_used) FROM stdin;
    public       postgres    false    327   ��      w           0    0    cc_server_manager_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('cc_server_manager_id_seq', 1, true);
            public       postgres    false    328            v          0    133502 
   cc_service 
   TABLE DATA               �   COPY cc_service (id, name, amount, period, rule, daynumber, stopmode, maxnumbercycle, status, numberofrun, datecreate, datelastrun, emailreport, totalcredit, totalcardperform, operate_mode, dialplan, use_group) FROM stdin;
    public       postgres    false    329   7�      x           0    0    cc_service_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_service_id_seq', 1, false);
            public       postgres    false    330            x          0    133524    cc_service_report 
   TABLE DATA               _   COPY cc_service_report (id, cc_service_id, daterun, totalcardperform, totalcredit) FROM stdin;
    public       postgres    false    331   T�      y           0    0    cc_service_report_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_service_report_id_seq', 1, false);
            public       postgres    false    332            �          0    132615    cc_sip_buddies 
   TABLE DATA               �  COPY cc_sip_buddies (id, id_cc_card, name, type, username, accountcode, regexten, callerid, amaflags, secret, md5secret, nat, dtmfmode, disallow, allow, host, qualify, canreinvite, callgroup, context, defaultip, fromuser, fromdomain, insecure, language, mailbox, deny, permit, mask, pickupgroup, port, restrictcid, rtptimeout, rtpholdtimeout, musiconhold, regseconds, ipaddr, cancallforward, fullcontact, setvar, regserver, lastms, defaultuser, auth, subscribemwi, vmexten, cid_number, callingpres, usereqphone, incominglimit, subscribecontext, musicclass, mohsuggest, allowtransfer, autoframing, maxcallbitrate, outboundproxy, rtpkeepalive, callbackextension, useragent) FROM stdin;
    public       postgres    false    187   q�      z          0    133535    cc_speeddial 
   TABLE DATA               U   COPY cc_speeddial (id, id_cc_card, phone, name, speeddial, creationdate) FROM stdin;
    public       postgres    false    334   ��      z           0    0    cc_speeddial_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('cc_speeddial_id_seq', 1, false);
            public       postgres    false    335            |          0    133546    cc_status_log 
   TABLE DATA               F   COPY cc_status_log (id, status, id_cc_card, updated_date) FROM stdin;
    public       postgres    false    336   ��      {           0    0    cc_status_log_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('cc_status_log_id_seq', 3, true);
            public       postgres    false    337            |           0    0    cc_subscription_fee_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('cc_subscription_fee_id_seq', 1, false);
            public       postgres    false    339            ~          0    133552    cc_subscription_service 
   TABLE DATA               �   COPY cc_subscription_service (id, label, fee, status, numberofrun, datecreate, datelastrun, emailreport, totalcredit, totalcardperform, startdate, stopdate) FROM stdin;
    public       postgres    false    338   ��      �          0    133565    cc_subscription_signup 
   TABLE DATA               g   COPY cc_subscription_signup (id, label, id_subscription, description, enable, id_callplan) FROM stdin;
    public       postgres    false    340   �      }           0    0    cc_subscription_signup_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('cc_subscription_signup_id_seq', 1, false);
            public       postgres    false    341            �          0    133575 
   cc_support 
   TABLE DATA               8   COPY cc_support (id, name, email, language) FROM stdin;
    public       postgres    false    342   $�      �          0    133579    cc_support_component 
   TABLE DATA               S   COPY cc_support_component (id, id_support, name, activated, type_user) FROM stdin;
    public       postgres    false    343   T�      ~           0    0    cc_support_component_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('cc_support_component_id_seq', 1, false);
            public       postgres    false    344                       0    0    cc_support_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_support_id_seq', 1, false);
            public       postgres    false    345            �          0    133589    cc_system_log 
   TABLE DATA               �   COPY cc_system_log (id, iduser, loglevel, action, description, data, tablename, pagename, ipaddress, creationdate, agent) FROM stdin;
    public       postgres    false    346   �      �           0    0    cc_system_log_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_system_log_id_seq', 1843, true);
            public       postgres    false    347                      0    132826    cc_tariffgroup 
   TABLE DATA               �   COPY cc_tariffgroup (id, iduser, idtariffplan, tariffgroupname, lcrtype, creationdate, removeinterprefix, id_cc_package_offer) FROM stdin;
    public       postgres    false    216   �Z      �           0    0    cc_tariffgroup_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cc_tariffgroup_id_seq', 3, true);
            public       postgres    false    348                      0    132838    cc_tariffgroup_plan 
   TABLE DATA               C   COPY cc_tariffgroup_plan (idtariffgroup, idtariffplan) FROM stdin;
    public       postgres    false    217   [                0    132841    cc_tariffplan 
   TABLE DATA               �   COPY cc_tariffplan (id, iduser, tariffname, creationdate, startingdate, expirationdate, description, id_trunk, secondusedreal, secondusedcarrier, secondusedratecard, reftariffplan, idowner, dnidprefix, calleridprefix) FROM stdin;
    public       postgres    false    218   <[      �           0    0    cc_tariffplan_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('cc_tariffplan_id_seq', 11, true);
            public       postgres    false    349            �          0    133605    cc_templatemail 
   TABLE DATA               u   COPY cc_templatemail (id, mailtype, fromemail, fromname, subject, messagetext, messagehtml, id_language) FROM stdin;
    public       postgres    false    350   �[      �           0    0    cc_templatemail_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_templatemail_id_seq', 16, true);
            public       postgres    false    351            �          0    133617 	   cc_ticket 
   TABLE DATA               �   COPY cc_ticket (id, id_component, title, description, priority, creationdate, creator, status, creator_type, viewed_cust, viewed_agent, viewed_admin) FROM stdin;
    public       postgres    false    352   �b      �          0    133630    cc_ticket_comment 
   TABLE DATA               �   COPY cc_ticket_comment (id, date, id_ticket, description, creator, creator_type, viewed_cust, viewed_agent, viewed_admin) FROM stdin;
    public       postgres    false    353   �b      �           0    0    cc_ticket_comment_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('cc_ticket_comment_id_seq', 1, false);
            public       postgres    false    354            �           0    0    cc_ticket_comment_id_ticket_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('cc_ticket_comment_id_ticket_seq', 1, false);
            public       postgres    false    355            �           0    0    cc_ticket_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('cc_ticket_id_seq', 1, false);
            public       postgres    false    356            �          0    133647    cc_timezone 
   TABLE DATA               ?   COPY cc_timezone (id, gmtzone, gmttime, gmtoffset) FROM stdin;
    public       postgres    false    357   �b      �           0    0    cc_timezone_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('cc_timezone_id_seq', 75, true);
            public       postgres    false    358            �          0    133656    cc_trunk 
   TABLE DATA               !  COPY cc_trunk (id_trunk, trunkcode, trunkprefix, providertech, providerip, removeprefix, secondusedreal, secondusedcarrier, secondusedratecard, creationdate, failover_trunk, addparameter, id_provider, inuse, maxuse, status, if_max_use, failover, billingorganizationprofile_id) FROM stdin;
    public       postgres    false    359   �h      �           0    0    cc_trunk_id_trunk_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('cc_trunk_id_trunk_seq', 26, true);
            public       postgres    false    360            �          0    133672    cc_ui_authen 
   TABLE DATA               �   COPY cc_ui_authen (userid, login, pwd_encoded, groupid, perms, confaddcust, name, direction, zipcode, state, phone, fax, email, datecreation, country, city) FROM stdin;
    public       postgres    false    361   �i      �           0    0    cc_ui_authen_userid_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('cc_ui_authen_userid_seq', 4, true);
            public       postgres    false    362            �          0    133681 
   cc_version 
   TABLE DATA               &   COPY cc_version (version) FROM stdin;
    public       postgres    false    363   �j      �          0    133684 
   cc_voucher 
   TABLE DATA               �   COPY cc_voucher (id, creationdate, usedate, expirationdate, voucher, usedcardnumber, tag, credit, activated, used, currency) FROM stdin;
    public       postgres    false    364   �j      �           0    0    cc_voucher_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('cc_voucher_id_seq', 1, false);
            public       postgres    false    365            �          0    133696    openjpa_sequence_table 
   TABLE DATA               =   COPY openjpa_sequence_table (id, sequence_value) FROM stdin;
    public       postgres    false    366   k      �          0    133699    pbx_accountprofile 
   TABLE DATA               4   COPY pbx_accountprofile (id, accountid) FROM stdin;
    public       postgres    false    367   'k      �           0    0    pbx_accountprofile_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('pbx_accountprofile_id_seq', 14, true);
            public       postgres    false    368            �          0    133704    pbx_blacklist 
   TABLE DATA               G   COPY pbx_blacklist (id, number, pbxorganizationprofile_id) FROM stdin;
    public       postgres    false    369   Yk      �           0    0    pbx_blacklist_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('pbx_blacklist_id_seq', 1, false);
            public       postgres    false    370            �          0    133709    pbx_cdr 
   TABLE DATA               �   COPY pbx_cdr (id, accountcode, amaflags, billsec, calldate, channel, clid, dcontext, disposition, dst, dstchannel, duration, lastapp, lastdata, src, uniqueid, userfield, voiceprofile_id) FROM stdin;
    public       postgres    false    371   vk      �           0    0    pbx_cdr_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('pbx_cdr_id_seq', 1, false);
            public       postgres    false    372            �          0    133717 
   pbx_config 
   TABLE DATA               H   COPY pbx_config (id, maximumpoolsize, name, poolsize, port) FROM stdin;
    public       postgres    false    373   �k      �          0    133720    pbx_did 
   TABLE DATA               d   COPY pbx_did (id, country, description, did, enabled, state, pbxorganizationprofile_id) FROM stdin;
    public       postgres    false    374   �k      �          0    133726    pbx_diddestination 
   TABLE DATA               Y   COPY pbx_diddestination (id, destination, name, servicetype, did_id, order0) FROM stdin;
    public       postgres    false    375   �k      �          0    133732 	   pbx_exten 
   TABLE DATA               M  COPY pbx_exten (id, accountcode, allow, calllimit, callbackextension, callerid, context, defaultuser, disallow, enabled, fullcontact, host, insecure, ipaddr, lastms, name, port, regcontext, regexten, regseconds, regserver, requirecalltoken, secret, tech, type, useragent, pbxorganizationprofile_id, pbxaccountprofile_id) FROM stdin;
    public       postgres    false    376   �k      �           0    0    pbx_exten_id_seq    SEQUENCE SET     8   SELECT pg_catalog.setval('pbx_exten_id_seq', 20, true);
            public       postgres    false    377            �          0    133740    pbx_extensions 
   TABLE DATA               M   COPY pbx_extensions (id, app, appdata, context, exten, priority) FROM stdin;
    public       postgres    false    378   l      �          0    133743    pbx_ivr 
   TABLE DATA               W   COPY pbx_ivr (id, audiopath, description, name, pbxorganizationprofile_id) FROM stdin;
    public       postgres    false    379   $l      �           0    0    pbx_ivr_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('pbx_ivr_id_seq', 1, false);
            public       postgres    false    380            �          0    133751    pbx_ivroption 
   TABLE DATA               A   COPY pbx_ivroption (id, description, option, ivr_id) FROM stdin;
    public       postgres    false    381   Al      �           0    0    pbx_ivroption_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('pbx_ivroption_id_seq', 1, false);
            public       postgres    false    382            �          0    133759    pbx_organizationprofile 
   TABLE DATA               >   COPY pbx_organizationprofile (id, organizationid) FROM stdin;
    public       postgres    false    383   ^l      �           0    0    pbx_organizationprofile_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('pbx_organizationprofile_id_seq', 5, true);
            public       postgres    false    384            �          0    133764 	   pbx_queue 
   TABLE DATA               _   COPY pbx_queue (id, label, musiconhold, name, strategy, pbxorganizationprofile_id) FROM stdin;
    public       postgres    false    385   �l      �           0    0    pbx_queue_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('pbx_queue_id_seq', 9, true);
            public       postgres    false    386            �          0    133772    pbx_queuelog 
   TABLE DATA               �   COPY pbx_queuelog (id, agent, callid, data1, data2, data3, data4, data5, event, queuename, "time", pbxorganizationprofile_id) FROM stdin;
    public       postgres    false    387   �l      �           0    0    pbx_queuelog_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('pbx_queuelog_id_seq', 103, true);
            public       postgres    false    388            �          0    133780    pbx_queuemember 
   TABLE DATA               �   COPY pbx_queuemember (id, interface, membername, paused, penalty, queue_name, uniqueid, queue_id, pbxaccountprofile_id) FROM stdin;
    public       postgres    false    389   s      �          0    133786    pbx_voicemail 
   TABLE DATA               k  COPY pbx_voicemail (id, attach, attachfmt, backupdeleted, callback, cidinternalcontexts, context, customer_id, delete, dialout, email, envelope, exitcontext, forcegreetings, forcename, fullname, hidefromdir, listenccontrolcpausekey, listenccontrolcrestartkey, listenccontrolcreversekey, listencontrolforwardkey, listencontrolstopkey, mailbox, messagewrap, minpassword, nextaftercmd, operator, pager, review, saycid, sayduration, saydurationm, searchcontexts, sendvoicemail, stamp, tempgreetwarn, tz, uniqueid, vmmismatch, vmnewpassword, vmpasschanged, vmpassword, vmplstryagain, vmreenterpassword, volgain) FROM stdin;
    public       postgres    false    390   7s      �           0    0    pbx_voicemail_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('pbx_voicemail_id_seq', 1, false);
            public       postgres    false    391            �          0    133794    account 
   TABLE DATA               �   COPY account (id, address, birthdate, country, creation, email, enabled, firstname, fixed, identification, lastname, location, mobile, password, relationship, sex, role_id, organization_id) FROM stdin;
    security       postgres    false    392   Ts      �           0    0    account_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('account_id_seq', 25, true);
            security       postgres    false    393            �          0    133802    openjpa_sequence_table 
   TABLE DATA               =   COPY openjpa_sequence_table (id, sequence_value) FROM stdin;
    security       postgres    false    394   �s      �          0    133805    organization 
   TABLE DATA               b   COPY organization (id, apikey, creation, domain, enabled, identification, logo, name) FROM stdin;
    security       postgres    false    395   �s      �           0    0    organization_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('organization_id_seq', 6, true);
            security       postgres    false    396            �          0    133813    role 
   TABLE DATA               !   COPY role (id, name) FROM stdin;
    security       postgres    false    397   ;t      �           0    0    role_id_seq    SEQUENCE SET     2   SELECT pg_catalog.setval('role_id_seq', 3, true);
            security       postgres    false    398            �          0    133818    session 
   TABLE DATA               B   COPY session (id, end0, ip, start, token, account_id) FROM stdin;
    security       postgres    false    399   ot      �           0    0    session_id_seq    SEQUENCE SET     7   SELECT pg_catalog.setval('session_id_seq', 439, true);
            security       postgres    false    400            ^           2606    136774    billingaccountprofile_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY billingaccountprofile
    ADD CONSTRAINT billingaccountprofile_pkey PRIMARY KEY (id);
 [   ALTER TABLE ONLY billing.billingaccountprofile DROP CONSTRAINT billingaccountprofile_pkey;
       billing         postgres    false    171    171            `           2606    136776    billingorganizationprofile_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY billingorganizationprofile
    ADD CONSTRAINT billingorganizationprofile_pkey PRIMARY KEY (id);
 e   ALTER TABLE ONLY billing.billingorganizationprofile DROP CONSTRAINT billingorganizationprofile_pkey;
       billing         postgres    false    173    173            b           2606    136778    creditcard_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY creditcard
    ADD CONSTRAINT creditcard_pkey PRIMARY KEY (id);
 E   ALTER TABLE ONLY billing.creditcard DROP CONSTRAINT creditcard_pkey;
       billing         postgres    false    175    175            d           2606    136780    openjpa_sequence_table_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY openjpa_sequence_table
    ADD CONSTRAINT openjpa_sequence_table_pkey PRIMARY KEY (id);
 ]   ALTER TABLE ONLY billing.openjpa_sequence_table DROP CONSTRAINT openjpa_sequence_table_pkey;
       billing         postgres    false    176    176            f           2606    136782 	   plan_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY plan
    ADD CONSTRAINT plan_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY billing.plan DROP CONSTRAINT plan_pkey;
       billing         postgres    false    177    177            h           2606    136784    priority_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY priority
    ADD CONSTRAINT priority_pkey PRIMARY KEY (id);
 A   ALTER TABLE ONLY billing.priority DROP CONSTRAINT priority_pkey;
       billing         postgres    false    178    178            l           2606    136786    report_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);
 =   ALTER TABLE ONLY billing.report DROP CONSTRAINT report_pkey;
       billing         postgres    false    179    179            n           2606    136788 
   route_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY billing.route DROP CONSTRAINT route_pkey;
       billing         postgres    false    180    180            p           2606    136790    tariff_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY tariff
    ADD CONSTRAINT tariff_pkey PRIMARY KEY (id);
 =   ALTER TABLE ONLY billing.tariff DROP CONSTRAINT tariff_pkey;
       billing         postgres    false    182    182            r           2606    136792 
   trunk_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY trunk
    ADD CONSTRAINT trunk_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY billing.trunk DROP CONSTRAINT trunk_pkey;
       billing         postgres    false    183    183            �           2606    140693    campaign_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY campaign
    ADD CONSTRAINT campaign_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY callcenter.campaign DROP CONSTRAINT campaign_pkey;
    
   callcenter         postgres    false    401    401            �           2606    140701    disposition_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY disposition
    ADD CONSTRAINT disposition_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY callcenter.disposition DROP CONSTRAINT disposition_pkey;
    
   callcenter         postgres    false    402    402            �           2606    140709 
   field_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY field
    ADD CONSTRAINT field_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY callcenter.field DROP CONSTRAINT field_pkey;
    
   callcenter         postgres    false    403    403            �           2606    140714    layout_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY layout
    ADD CONSTRAINT layout_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY callcenter.layout DROP CONSTRAINT layout_pkey;
    
   callcenter         postgres    false    404    404            �           2606    140719 	   lead_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY lead
    ADD CONSTRAINT lead_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY callcenter.lead DROP CONSTRAINT lead_pkey;
    
   callcenter         postgres    false    405    405            �           2606    140724    leaddetail_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY leaddetail
    ADD CONSTRAINT leaddetail_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY callcenter.leaddetail DROP CONSTRAINT leaddetail_pkey;
    
   callcenter         postgres    false    406    406            �           2606    140729    openjpa_sequence_table_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY openjpa_sequence_table
    ADD CONSTRAINT openjpa_sequence_table_pkey PRIMARY KEY (id);
 `   ALTER TABLE ONLY callcenter.openjpa_sequence_table DROP CONSTRAINT openjpa_sequence_table_pkey;
    
   callcenter         postgres    false    407    407            �           2606    140734    result_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY result
    ADD CONSTRAINT result_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY callcenter.result DROP CONSTRAINT result_pkey;
    
   callcenter         postgres    false    408    408            t           2606    136808    _cc_iax_buddies_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY cc_iax_buddies
    ADD CONSTRAINT _cc_iax_buddies_name_key UNIQUE (name);
 Q   ALTER TABLE ONLY public.cc_iax_buddies DROP CONSTRAINT _cc_iax_buddies_name_key;
       public         postgres    false    185    185            �           2606    136810    _cc_sip_buddies_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY cc_sip_buddies
    ADD CONSTRAINT _cc_sip_buddies_name_key UNIQUE (name);
 Q   ALTER TABLE ONLY public.cc_sip_buddies DROP CONSTRAINT _cc_sip_buddies_name_key;
       public         postgres    false    187    187            �           2606    136812    cc_agent_commission_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY cc_agent_commission
    ADD CONSTRAINT cc_agent_commission_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.cc_agent_commission DROP CONSTRAINT cc_agent_commission_pkey;
       public         postgres    false    190    190            �           2606    136814    cc_agent_login_key 
   CONSTRAINT     P   ALTER TABLE ONLY cc_agent
    ADD CONSTRAINT cc_agent_login_key UNIQUE (login);
 E   ALTER TABLE ONLY public.cc_agent DROP CONSTRAINT cc_agent_login_key;
       public         postgres    false    189    189            �           2606    136816    cc_agent_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY cc_agent
    ADD CONSTRAINT cc_agent_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.cc_agent DROP CONSTRAINT cc_agent_pkey;
       public         postgres    false    189    189            �           2606    136818    cc_agent_signup_code_key 
   CONSTRAINT     \   ALTER TABLE ONLY cc_agent_signup
    ADD CONSTRAINT cc_agent_signup_code_key UNIQUE (code);
 R   ALTER TABLE ONLY public.cc_agent_signup DROP CONSTRAINT cc_agent_signup_code_key;
       public         postgres    false    193    193            �           2606    136820    cc_agent_signup_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_agent_signup
    ADD CONSTRAINT cc_agent_signup_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_agent_signup DROP CONSTRAINT cc_agent_signup_pkey;
       public         postgres    false    193    193            �           2606    136822    cc_agent_tariffgroup_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY cc_agent_tariffgroup
    ADD CONSTRAINT cc_agent_tariffgroup_pkey PRIMARY KEY (id_agent, id_tariffgroup);
 X   ALTER TABLE ONLY public.cc_agent_tariffgroup DROP CONSTRAINT cc_agent_tariffgroup_pkey;
       public         postgres    false    195    195    195            �           2606    136824    cc_alarm_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY cc_alarm
    ADD CONSTRAINT cc_alarm_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.cc_alarm DROP CONSTRAINT cc_alarm_pkey;
       public         postgres    false    196    196            �           2606    136826    cc_alarm_report_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_alarm_report
    ADD CONSTRAINT cc_alarm_report_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_alarm_report DROP CONSTRAINT cc_alarm_report_pkey;
       public         postgres    false    198    198            �           2606    136828    cc_autorefill_report_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY cc_autorefill_report
    ADD CONSTRAINT cc_autorefill_report_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cc_autorefill_report DROP CONSTRAINT cc_autorefill_report_pkey;
       public         postgres    false    200    200            �           2606    136830    cc_backup_name_key 
   CONSTRAINT     P   ALTER TABLE ONLY cc_backup
    ADD CONSTRAINT cc_backup_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.cc_backup DROP CONSTRAINT cc_backup_name_key;
       public         postgres    false    202    202            �           2606    136832    cc_backup_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY cc_backup
    ADD CONSTRAINT cc_backup_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cc_backup DROP CONSTRAINT cc_backup_pkey;
       public         postgres    false    202    202            �           2606    136834    cc_billing_customer_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY cc_billing_customer
    ADD CONSTRAINT cc_billing_customer_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.cc_billing_customer DROP CONSTRAINT cc_billing_customer_pkey;
       public         postgres    false    204    204            �           2606    136836    cc_call_archive_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_call_archive
    ADD CONSTRAINT cc_call_archive_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_call_archive DROP CONSTRAINT cc_call_archive_pkey;
       public         postgres    false    207    207            �           2606    136838    cc_call_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY cc_call
    ADD CONSTRAINT cc_call_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cc_call DROP CONSTRAINT cc_call_pkey;
       public         postgres    false    206    206            �           2606    136840    cc_callback_spool_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY cc_callback_spool
    ADD CONSTRAINT cc_callback_spool_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.cc_callback_spool DROP CONSTRAINT cc_callback_spool_pkey;
       public         postgres    false    210    210            �           2606    136842    cc_callback_spool_uniqueid_key 
   CONSTRAINT     h   ALTER TABLE ONLY cc_callback_spool
    ADD CONSTRAINT cc_callback_spool_uniqueid_key UNIQUE (uniqueid);
 Z   ALTER TABLE ONLY public.cc_callback_spool DROP CONSTRAINT cc_callback_spool_uniqueid_key;
       public         postgres    false    210    210            �           2606    136844    cc_callerid_cid_key 
   CONSTRAINT     R   ALTER TABLE ONLY cc_callerid
    ADD CONSTRAINT cc_callerid_cid_key UNIQUE (cid);
 I   ALTER TABLE ONLY public.cc_callerid DROP CONSTRAINT cc_callerid_cid_key;
       public         postgres    false    212    212            �           2606    136846    cc_callerid_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_callerid
    ADD CONSTRAINT cc_callerid_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_callerid DROP CONSTRAINT cc_callerid_pkey;
       public         postgres    false    212    212            �           2606    136848    cc_campaign_config_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY cc_campaign_config
    ADD CONSTRAINT cc_campaign_config_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cc_campaign_config DROP CONSTRAINT cc_campaign_config_pkey;
       public         postgres    false    221    221            �           2606    136850    cc_campaign_name_key 
   CONSTRAINT     T   ALTER TABLE ONLY cc_campaign
    ADD CONSTRAINT cc_campaign_name_key UNIQUE (name);
 J   ALTER TABLE ONLY public.cc_campaign DROP CONSTRAINT cc_campaign_name_key;
       public         postgres    false    220    220            �           2606    136852    cc_campaign_phonebook_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY cc_campaign_phonebook
    ADD CONSTRAINT cc_campaign_phonebook_pkey PRIMARY KEY (id_campaign, id_phonebook);
 Z   ALTER TABLE ONLY public.cc_campaign_phonebook DROP CONSTRAINT cc_campaign_phonebook_pkey;
       public         postgres    false    224    224    224            �           2606    136854    cc_campaign_phonestatus_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY cc_campaign_phonestatus
    ADD CONSTRAINT cc_campaign_phonestatus_pkey PRIMARY KEY (id_phonenumber, id_campaign);
 ^   ALTER TABLE ONLY public.cc_campaign_phonestatus DROP CONSTRAINT cc_campaign_phonestatus_pkey;
       public         postgres    false    225    225    225            �           2606    136856    cc_campaign_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_campaign
    ADD CONSTRAINT cc_campaign_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_campaign DROP CONSTRAINT cc_campaign_pkey;
       public         postgres    false    220    220            �           2606    136858    cc_campaignconf_cardgroup_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY cc_campaignconf_cardgroup
    ADD CONSTRAINT cc_campaignconf_cardgroup_pkey PRIMARY KEY (id_campaign_config, id_card_group);
 b   ALTER TABLE ONLY public.cc_campaignconf_cardgroup DROP CONSTRAINT cc_campaignconf_cardgroup_pkey;
       public         postgres    false    226    226    226            �           2606    136860    cc_card_archive_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_card_archive
    ADD CONSTRAINT cc_card_archive_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_card_archive DROP CONSTRAINT cc_card_archive_pkey;
       public         postgres    false    228    228            �           2606    136862    cc_card_archive_useralias_key 
   CONSTRAINT     f   ALTER TABLE ONLY cc_card_archive
    ADD CONSTRAINT cc_card_archive_useralias_key UNIQUE (useralias);
 W   ALTER TABLE ONLY public.cc_card_archive DROP CONSTRAINT cc_card_archive_useralias_key;
       public         postgres    false    228    228            �           2606    136864    cc_card_archive_username_key 
   CONSTRAINT     d   ALTER TABLE ONLY cc_card_archive
    ADD CONSTRAINT cc_card_archive_username_key UNIQUE (username);
 V   ALTER TABLE ONLY public.cc_card_archive DROP CONSTRAINT cc_card_archive_username_key;
       public         postgres    false    228    228            �           2606    136866    cc_card_group_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_card_group
    ADD CONSTRAINT cc_card_group_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_card_group DROP CONSTRAINT cc_card_group_pkey;
       public         postgres    false    230    230            �           2606    136868    cc_card_history_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_card_history
    ADD CONSTRAINT cc_card_history_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_card_history DROP CONSTRAINT cc_card_history_pkey;
       public         postgres    false    232    232            �           2606    136870    cc_card_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY cc_card
    ADD CONSTRAINT cc_card_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cc_card DROP CONSTRAINT cc_card_pkey;
       public         postgres    false    227    227            �           2606    136872    cc_card_seria_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_card_seria
    ADD CONSTRAINT cc_card_seria_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_card_seria DROP CONSTRAINT cc_card_seria_pkey;
       public         postgres    false    237    237            �           2606    136874    cc_card_subscription_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY cc_card_subscription
    ADD CONSTRAINT cc_card_subscription_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cc_card_subscription DROP CONSTRAINT cc_card_subscription_pkey;
       public         postgres    false    239    239            �           2606    136876    cc_card_useralias_key 
   CONSTRAINT     V   ALTER TABLE ONLY cc_card
    ADD CONSTRAINT cc_card_useralias_key UNIQUE (useralias);
 G   ALTER TABLE ONLY public.cc_card DROP CONSTRAINT cc_card_useralias_key;
       public         postgres    false    227    227            �           2606    136878    cc_card_username_key 
   CONSTRAINT     T   ALTER TABLE ONLY cc_card
    ADD CONSTRAINT cc_card_username_key UNIQUE (username);
 F   ALTER TABLE ONLY public.cc_card DROP CONSTRAINT cc_card_username_key;
       public         postgres    false    227    227            �           2606    136880    cc_charge_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY cc_charge
    ADD CONSTRAINT cc_charge_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cc_charge DROP CONSTRAINT cc_charge_pkey;
       public         postgres    false    242    242            �           2606    136882    cc_config_group_group_title_key 
   CONSTRAINT     j   ALTER TABLE ONLY cc_config_group
    ADD CONSTRAINT cc_config_group_group_title_key UNIQUE (group_title);
 Y   ALTER TABLE ONLY public.cc_config_group DROP CONSTRAINT cc_config_group_group_title_key;
       public         postgres    false    245    245            �           2606    136884    cc_config_group_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_config_group
    ADD CONSTRAINT cc_config_group_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_config_group DROP CONSTRAINT cc_config_group_pkey;
       public         postgres    false    245    245            �           2606    136886    cc_config_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY cc_config
    ADD CONSTRAINT cc_config_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cc_config DROP CONSTRAINT cc_config_pkey;
       public         postgres    false    244    244            �           2606    136888    cc_configuration_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY cc_configuration
    ADD CONSTRAINT cc_configuration_pkey PRIMARY KEY (configuration_id);
 P   ALTER TABLE ONLY public.cc_configuration DROP CONSTRAINT cc_configuration_pkey;
       public         postgres    false    248    248            �           2606    136890    cc_country_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_country
    ADD CONSTRAINT cc_country_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_country DROP CONSTRAINT cc_country_pkey;
       public         postgres    false    250    250            �           2606    136892    cc_currencies_currency_key 
   CONSTRAINT     `   ALTER TABLE ONLY cc_currencies
    ADD CONSTRAINT cc_currencies_currency_key UNIQUE (currency);
 R   ALTER TABLE ONLY public.cc_currencies DROP CONSTRAINT cc_currencies_currency_key;
       public         postgres    false    252    252            �           2606    136894    cc_currencies_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_currencies
    ADD CONSTRAINT cc_currencies_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_currencies DROP CONSTRAINT cc_currencies_pkey;
       public         postgres    false    252    252                       2606    136896    cc_did_destination_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY cc_did_destination
    ADD CONSTRAINT cc_did_destination_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cc_did_destination DROP CONSTRAINT cc_did_destination_pkey;
       public         postgres    false    255    255            �           2606    136898    cc_did_did_key 
   CONSTRAINT     H   ALTER TABLE ONLY cc_did
    ADD CONSTRAINT cc_did_did_key UNIQUE (did);
 ?   ALTER TABLE ONLY public.cc_did DROP CONSTRAINT cc_did_did_key;
       public         postgres    false    254    254                       2606    136900    cc_did_pkey 
   CONSTRAINT     I   ALTER TABLE ONLY cc_did
    ADD CONSTRAINT cc_did_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.cc_did DROP CONSTRAINT cc_did_pkey;
       public         postgres    false    254    254                       2606    136902    cc_did_uniq 
   CONSTRAINT     E   ALTER TABLE ONLY cc_did
    ADD CONSTRAINT cc_did_uniq UNIQUE (did);
 <   ALTER TABLE ONLY public.cc_did DROP CONSTRAINT cc_did_uniq;
       public         postgres    false    254    254                       2606    136904    cc_did_use_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_did_use
    ADD CONSTRAINT cc_did_use_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_did_use DROP CONSTRAINT cc_did_use_pkey;
       public         postgres    false    258    258            	           2606    136906    cc_didgroup_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_didgroup
    ADD CONSTRAINT cc_didgroup_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_didgroup DROP CONSTRAINT cc_didgroup_pkey;
       public         postgres    false    260    260                       2606    136908    cc_epayment_log_agent_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY cc_epayment_log_agent
    ADD CONSTRAINT cc_epayment_log_agent_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.cc_epayment_log_agent DROP CONSTRAINT cc_epayment_log_agent_pkey;
       public         postgres    false    263    263                       2606    136910    cc_epayment_log_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_epayment_log
    ADD CONSTRAINT cc_epayment_log_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_epayment_log DROP CONSTRAINT cc_epayment_log_pkey;
       public         postgres    false    262    262            y           2606    136912    cc_iax_buddies_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY cc_iax_buddies
    ADD CONSTRAINT cc_iax_buddies_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cc_iax_buddies DROP CONSTRAINT cc_iax_buddies_pkey;
       public         postgres    false    185    185                       2606    136914    cc_invoice_conf_key_val_key 
   CONSTRAINT     b   ALTER TABLE ONLY cc_invoice_conf
    ADD CONSTRAINT cc_invoice_conf_key_val_key UNIQUE (key_val);
 U   ALTER TABLE ONLY public.cc_invoice_conf DROP CONSTRAINT cc_invoice_conf_key_val_key;
       public         postgres    false    267    267                       2606    136916    cc_invoice_conf_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_invoice_conf
    ADD CONSTRAINT cc_invoice_conf_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_invoice_conf DROP CONSTRAINT cc_invoice_conf_pkey;
       public         postgres    false    267    267                       2606    136918    cc_invoice_item_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_invoice_item
    ADD CONSTRAINT cc_invoice_item_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_invoice_item DROP CONSTRAINT cc_invoice_item_pkey;
       public         postgres    false    270    270                       2606    136920 !   cc_invoice_payment_id_payment_key 
   CONSTRAINT     n   ALTER TABLE ONLY cc_invoice_payment
    ADD CONSTRAINT cc_invoice_payment_id_payment_key UNIQUE (id_payment);
 ^   ALTER TABLE ONLY public.cc_invoice_payment DROP CONSTRAINT cc_invoice_payment_id_payment_key;
       public         postgres    false    272    272                       2606    136922    cc_invoice_payment_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY cc_invoice_payment
    ADD CONSTRAINT cc_invoice_payment_pkey PRIMARY KEY (id_invoice, id_payment);
 T   ALTER TABLE ONLY public.cc_invoice_payment DROP CONSTRAINT cc_invoice_payment_pkey;
       public         postgres    false    272    272    272                       2606    136924    cc_invoice_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_invoice
    ADD CONSTRAINT cc_invoice_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_invoice DROP CONSTRAINT cc_invoice_pkey;
       public         postgres    false    266    266                       2606    136926    cc_invoice_reference_key 
   CONSTRAINT     \   ALTER TABLE ONLY cc_invoice
    ADD CONSTRAINT cc_invoice_reference_key UNIQUE (reference);
 M   ALTER TABLE ONLY public.cc_invoice DROP CONSTRAINT cc_invoice_reference_key;
       public         postgres    false    266    266                       2606    136928    cc_iso639_name_key 
   CONSTRAINT     P   ALTER TABLE ONLY cc_iso639
    ADD CONSTRAINT cc_iso639_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.cc_iso639 DROP CONSTRAINT cc_iso639_name_key;
       public         postgres    false    273    273                       2606    136930    cc_iso639_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_iso639
    ADD CONSTRAINT cc_iso639_pkey PRIMARY KEY (code);
 B   ALTER TABLE ONLY public.cc_iso639 DROP CONSTRAINT cc_iso639_pkey;
       public         postgres    false    273    273            #           2606    136932    cc_logpayment_agent_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY cc_logpayment_agent
    ADD CONSTRAINT cc_logpayment_agent_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.cc_logpayment_agent DROP CONSTRAINT cc_logpayment_agent_pkey;
       public         postgres    false    275    275            !           2606    136934    cc_logpayment_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_logpayment
    ADD CONSTRAINT cc_logpayment_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_logpayment DROP CONSTRAINT cc_logpayment_pkey;
       public         postgres    false    274    274            '           2606    136936    cc_logrefill_agent_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY cc_logrefill_agent
    ADD CONSTRAINT cc_logrefill_agent_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cc_logrefill_agent DROP CONSTRAINT cc_logrefill_agent_pkey;
       public         postgres    false    279    279            %           2606    136938    cc_logrefill_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY cc_logrefill
    ADD CONSTRAINT cc_logrefill_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.cc_logrefill DROP CONSTRAINT cc_logrefill_pkey;
       public         postgres    false    278    278            )           2606    136940    cc_message_agent_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY cc_message_agent
    ADD CONSTRAINT cc_message_agent_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.cc_message_agent DROP CONSTRAINT cc_message_agent_pkey;
       public         postgres    false    282    282            +           2606    136942    cc_monitor_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_monitor
    ADD CONSTRAINT cc_monitor_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_monitor DROP CONSTRAINT cc_monitor_pkey;
       public         postgres    false    284    284            /           2606    136944    cc_notification_admin_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY cc_notification_admin
    ADD CONSTRAINT cc_notification_admin_pkey PRIMARY KEY (id_notification, id_admin);
 Z   ALTER TABLE ONLY public.cc_notification_admin DROP CONSTRAINT cc_notification_admin_pkey;
       public         postgres    false    287    287    287            -           2606    136946    cc_notification_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_notification
    ADD CONSTRAINT cc_notification_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_notification DROP CONSTRAINT cc_notification_pkey;
       public         postgres    false    286    286            1           2606    136948    cc_outbound_cid_group_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY cc_outbound_cid_group
    ADD CONSTRAINT cc_outbound_cid_group_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.cc_outbound_cid_group DROP CONSTRAINT cc_outbound_cid_group_pkey;
       public         postgres    false    289    289            3           2606    136950    cc_outbound_cid_list_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY cc_outbound_cid_list
    ADD CONSTRAINT cc_outbound_cid_list_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cc_outbound_cid_list DROP CONSTRAINT cc_outbound_cid_list_pkey;
       public         postgres    false    291    291            5           2606    136952    cc_package_group_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY cc_package_group
    ADD CONSTRAINT cc_package_group_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.cc_package_group DROP CONSTRAINT cc_package_group_pkey;
       public         postgres    false    293    293            7           2606    136954    cc_package_rate_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY cc_package_rate
    ADD CONSTRAINT cc_package_rate_pkey PRIMARY KEY (package_id, rate_id);
 N   ALTER TABLE ONLY public.cc_package_rate DROP CONSTRAINT cc_package_rate_pkey;
       public         postgres    false    297    297    297            9           2606    136956    cc_packgroup_package_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY cc_packgroup_package
    ADD CONSTRAINT cc_packgroup_package_pkey PRIMARY KEY (packagegroup_id, package_id);
 X   ALTER TABLE ONLY public.cc_packgroup_package DROP CONSTRAINT cc_packgroup_package_pkey;
       public         postgres    false    298    298    298            ;           2606    136958    cc_payment_methods_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY cc_payment_methods
    ADD CONSTRAINT cc_payment_methods_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cc_payment_methods DROP CONSTRAINT cc_payment_methods_pkey;
       public         postgres    false    299    299            ?           2606    136960    cc_payments_agent_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY cc_payments_agent
    ADD CONSTRAINT cc_payments_agent_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.cc_payments_agent DROP CONSTRAINT cc_payments_agent_pkey;
       public         postgres    false    302    302            =           2606    136962    cc_payments_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_payments
    ADD CONSTRAINT cc_payments_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_payments DROP CONSTRAINT cc_payments_pkey;
       public         postgres    false    301    301            A           2606    136964    cc_payments_status_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY cc_payments_status
    ADD CONSTRAINT cc_payments_status_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.cc_payments_status DROP CONSTRAINT cc_payments_status_pkey;
       public         postgres    false    305    305            C           2606    136966    cc_paypal_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY cc_paypal
    ADD CONSTRAINT cc_paypal_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cc_paypal DROP CONSTRAINT cc_paypal_pkey;
       public         postgres    false    307    307            E           2606    136968    cc_paypal_txn_id_key 
   CONSTRAINT     T   ALTER TABLE ONLY cc_paypal
    ADD CONSTRAINT cc_paypal_txn_id_key UNIQUE (txn_id);
 H   ALTER TABLE ONLY public.cc_paypal DROP CONSTRAINT cc_paypal_txn_id_key;
       public         postgres    false    307    307            G           2606    136970    cc_phonebook_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY cc_phonebook
    ADD CONSTRAINT cc_phonebook_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.cc_phonebook DROP CONSTRAINT cc_phonebook_pkey;
       public         postgres    false    309    309            I           2606    136972    cc_phonenumber_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY cc_phonenumber
    ADD CONSTRAINT cc_phonenumber_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cc_phonenumber DROP CONSTRAINT cc_phonenumber_pkey;
       public         postgres    false    311    311            �           2606    136974    cc_prefix_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_prefix
    ADD CONSTRAINT cc_prefix_pkey PRIMARY KEY (prefix);
 B   ALTER TABLE ONLY public.cc_prefix DROP CONSTRAINT cc_prefix_pkey;
       public         postgres    false    214    214            K           2606    136976    cc_provider_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_provider
    ADD CONSTRAINT cc_provider_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_provider DROP CONSTRAINT cc_provider_pkey;
       public         postgres    false    314    314            M           2606    136978    cc_provider_provider_name_key 
   CONSTRAINT     f   ALTER TABLE ONLY cc_provider
    ADD CONSTRAINT cc_provider_provider_name_key UNIQUE (provider_name);
 S   ALTER TABLE ONLY public.cc_provider DROP CONSTRAINT cc_provider_provider_name_key;
       public         postgres    false    314    314            �           2606    136980    cc_ratecard_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_ratecard
    ADD CONSTRAINT cc_ratecard_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_ratecard DROP CONSTRAINT cc_ratecard_pkey;
       public         postgres    false    215    215            Q           2606    136982    cc_receipt_item_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_receipt_item
    ADD CONSTRAINT cc_receipt_item_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_receipt_item DROP CONSTRAINT cc_receipt_item_pkey;
       public         postgres    false    319    319            O           2606    136984    cc_receipt_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_receipt
    ADD CONSTRAINT cc_receipt_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_receipt DROP CONSTRAINT cc_receipt_pkey;
       public         postgres    false    317    317            S           2606    136986    cc_remittance_request_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY cc_remittance_request
    ADD CONSTRAINT cc_remittance_request_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.cc_remittance_request DROP CONSTRAINT cc_remittance_request_pkey;
       public         postgres    false    321    321            U           2606    136988    cc_restricted_phonenumber_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY cc_restricted_phonenumber
    ADD CONSTRAINT cc_restricted_phonenumber_pkey PRIMARY KEY (id);
 b   ALTER TABLE ONLY public.cc_restricted_phonenumber DROP CONSTRAINT cc_restricted_phonenumber_pkey;
       public         postgres    false    323    323            W           2606    136990    cc_server_group_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_server_group
    ADD CONSTRAINT cc_server_group_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_server_group DROP CONSTRAINT cc_server_group_pkey;
       public         postgres    false    325    325            Y           2606    136992    cc_server_manager_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY cc_server_manager
    ADD CONSTRAINT cc_server_manager_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.cc_server_manager DROP CONSTRAINT cc_server_manager_pkey;
       public         postgres    false    327    327            [           2606    136994    cc_service_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_service
    ADD CONSTRAINT cc_service_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_service DROP CONSTRAINT cc_service_pkey;
       public         postgres    false    329    329            ]           2606    136996    cc_service_report_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY cc_service_report
    ADD CONSTRAINT cc_service_report_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.cc_service_report DROP CONSTRAINT cc_service_report_pkey;
       public         postgres    false    331    331            �           2606    136998    cc_sip_buddies_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY cc_sip_buddies
    ADD CONSTRAINT cc_sip_buddies_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cc_sip_buddies DROP CONSTRAINT cc_sip_buddies_pkey;
       public         postgres    false    187    187            _           2606    137000    cc_speeddial_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY cc_speeddial
    ADD CONSTRAINT cc_speeddial_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.cc_speeddial DROP CONSTRAINT cc_speeddial_pkey;
       public         postgres    false    334    334            c           2606    137002    cc_status_log_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_status_log
    ADD CONSTRAINT cc_status_log_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_status_log DROP CONSTRAINT cc_status_log_pkey;
       public         postgres    false    336    336            e           2606    137004    cc_subscription_fee_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY cc_subscription_service
    ADD CONSTRAINT cc_subscription_fee_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.cc_subscription_service DROP CONSTRAINT cc_subscription_fee_pkey;
       public         postgres    false    338    338            g           2606    137006    cc_subscription_signup_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY cc_subscription_signup
    ADD CONSTRAINT cc_subscription_signup_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.cc_subscription_signup DROP CONSTRAINT cc_subscription_signup_pkey;
       public         postgres    false    340    340            k           2606    137008    cc_support_component_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY cc_support_component
    ADD CONSTRAINT cc_support_component_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.cc_support_component DROP CONSTRAINT cc_support_component_pkey;
       public         postgres    false    343    343            i           2606    137010    cc_support_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_support
    ADD CONSTRAINT cc_support_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_support DROP CONSTRAINT cc_support_pkey;
       public         postgres    false    342    342            m           2606    137012    cc_system_log_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_system_log
    ADD CONSTRAINT cc_system_log_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_system_log DROP CONSTRAINT cc_system_log_pkey;
       public         postgres    false    346    346            �           2606    137014    cc_tariffgroup_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY cc_tariffgroup
    ADD CONSTRAINT cc_tariffgroup_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cc_tariffgroup DROP CONSTRAINT cc_tariffgroup_pkey;
       public         postgres    false    216    216            �           2606    137016    cc_tariffgroup_plan_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY cc_tariffgroup_plan
    ADD CONSTRAINT cc_tariffgroup_plan_pkey PRIMARY KEY (idtariffgroup, idtariffplan);
 V   ALTER TABLE ONLY public.cc_tariffgroup_plan DROP CONSTRAINT cc_tariffgroup_plan_pkey;
       public         postgres    false    217    217    217            �           2606    137018    cc_tariffplan_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY cc_tariffplan
    ADD CONSTRAINT cc_tariffplan_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.cc_tariffplan DROP CONSTRAINT cc_tariffplan_pkey;
       public         postgres    false    218    218            o           2606    137020    cc_templatemail_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY cc_templatemail
    ADD CONSTRAINT cc_templatemail_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.cc_templatemail DROP CONSTRAINT cc_templatemail_pkey;
       public         postgres    false    350    350            u           2606    137022    cc_ticket_comment_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY cc_ticket_comment
    ADD CONSTRAINT cc_ticket_comment_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.cc_ticket_comment DROP CONSTRAINT cc_ticket_comment_pkey;
       public         postgres    false    353    353            s           2606    137024    cc_ticket_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY cc_ticket
    ADD CONSTRAINT cc_ticket_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.cc_ticket DROP CONSTRAINT cc_ticket_pkey;
       public         postgres    false    352    352            w           2606    137026    cc_timezone_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_timezone
    ADD CONSTRAINT cc_timezone_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.cc_timezone DROP CONSTRAINT cc_timezone_pkey;
       public         postgres    false    357    357            y           2606    137028    cc_trunk_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY cc_trunk
    ADD CONSTRAINT cc_trunk_pkey PRIMARY KEY (id_trunk);
 @   ALTER TABLE ONLY public.cc_trunk DROP CONSTRAINT cc_trunk_pkey;
       public         postgres    false    359    359            {           2606    137030    cc_ui_authen_login_key 
   CONSTRAINT     X   ALTER TABLE ONLY cc_ui_authen
    ADD CONSTRAINT cc_ui_authen_login_key UNIQUE (login);
 M   ALTER TABLE ONLY public.cc_ui_authen DROP CONSTRAINT cc_ui_authen_login_key;
       public         postgres    false    361    361            }           2606    137032    cc_ui_authen_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY cc_ui_authen
    ADD CONSTRAINT cc_ui_authen_pkey PRIMARY KEY (userid);
 H   ALTER TABLE ONLY public.cc_ui_authen DROP CONSTRAINT cc_ui_authen_pkey;
       public         postgres    false    361    361                       2606    137034    cc_voucher_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY cc_voucher
    ADD CONSTRAINT cc_voucher_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.cc_voucher DROP CONSTRAINT cc_voucher_pkey;
       public         postgres    false    364    364            �           2606    137036    cc_voucher_voucher_key 
   CONSTRAINT     X   ALTER TABLE ONLY cc_voucher
    ADD CONSTRAINT cc_voucher_voucher_key UNIQUE (voucher);
 K   ALTER TABLE ONLY public.cc_voucher DROP CONSTRAINT cc_voucher_voucher_key;
       public         postgres    false    364    364            �           2606    137038    cons_cc_cardgroup_unique 
   CONSTRAINT     v   ALTER TABLE ONLY cc_cardgroup_service
    ADD CONSTRAINT cons_cc_cardgroup_unique UNIQUE (id_card_group, id_service);
 W   ALTER TABLE ONLY public.cc_cardgroup_service DROP CONSTRAINT cons_cc_cardgroup_unique;
       public         postgres    false    241    241    241            a           2606    137040    cons_cc_speeddial_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY cc_speeddial
    ADD CONSTRAINT cons_cc_speeddial_pkey UNIQUE (id_cc_card, speeddial);
 M   ALTER TABLE ONLY public.cc_speeddial DROP CONSTRAINT cons_cc_speeddial_pkey;
       public         postgres    false    334    334    334            q           2606    137042    cons_cc_templatemail_mailtype 
   CONSTRAINT     r   ALTER TABLE ONLY cc_templatemail
    ADD CONSTRAINT cons_cc_templatemail_mailtype UNIQUE (mailtype, id_language);
 W   ALTER TABLE ONLY public.cc_templatemail DROP CONSTRAINT cons_cc_templatemail_mailtype;
       public         postgres    false    350    350    350            �           2606    137044    cons_iduser_tariffname 
   CONSTRAINT     f   ALTER TABLE ONLY cc_tariffplan
    ADD CONSTRAINT cons_iduser_tariffname UNIQUE (iduser, tariffname);
 N   ALTER TABLE ONLY public.cc_tariffplan DROP CONSTRAINT cons_iduser_tariffname;
       public         postgres    false    218    218    218            �           2606    137046    openjpa_sequence_table_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY openjpa_sequence_table
    ADD CONSTRAINT openjpa_sequence_table_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.openjpa_sequence_table DROP CONSTRAINT openjpa_sequence_table_pkey;
       public         postgres    false    366    366            �           2606    137048    pbx_accountprofile_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY pbx_accountprofile
    ADD CONSTRAINT pbx_accountprofile_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.pbx_accountprofile DROP CONSTRAINT pbx_accountprofile_pkey;
       public         postgres    false    367    367            �           2606    137050    pbx_blacklist_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY pbx_blacklist
    ADD CONSTRAINT pbx_blacklist_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.pbx_blacklist DROP CONSTRAINT pbx_blacklist_pkey;
       public         postgres    false    369    369            �           2606    137052    pbx_cdr_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY pbx_cdr
    ADD CONSTRAINT pbx_cdr_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pbx_cdr DROP CONSTRAINT pbx_cdr_pkey;
       public         postgres    false    371    371            �           2606    137054    pbx_config_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY pbx_config
    ADD CONSTRAINT pbx_config_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.pbx_config DROP CONSTRAINT pbx_config_pkey;
       public         postgres    false    373    373            �           2606    137056    pbx_did_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY pbx_did
    ADD CONSTRAINT pbx_did_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pbx_did DROP CONSTRAINT pbx_did_pkey;
       public         postgres    false    374    374            �           2606    137058    pbx_diddestination_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY pbx_diddestination
    ADD CONSTRAINT pbx_diddestination_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.pbx_diddestination DROP CONSTRAINT pbx_diddestination_pkey;
       public         postgres    false    375    375            �           2606    137060    pbx_exten_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY pbx_exten
    ADD CONSTRAINT pbx_exten_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.pbx_exten DROP CONSTRAINT pbx_exten_pkey;
       public         postgres    false    376    376            �           2606    137062    pbx_ivr_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY pbx_ivr
    ADD CONSTRAINT pbx_ivr_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.pbx_ivr DROP CONSTRAINT pbx_ivr_pkey;
       public         postgres    false    379    379            �           2606    137064    pbx_ivroption_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY pbx_ivroption
    ADD CONSTRAINT pbx_ivroption_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.pbx_ivroption DROP CONSTRAINT pbx_ivroption_pkey;
       public         postgres    false    381    381            �           2606    137066    pbx_organizationprofile_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY pbx_organizationprofile
    ADD CONSTRAINT pbx_organizationprofile_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.pbx_organizationprofile DROP CONSTRAINT pbx_organizationprofile_pkey;
       public         postgres    false    383    383            �           2606    137068    pbx_queue_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY pbx_queue
    ADD CONSTRAINT pbx_queue_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.pbx_queue DROP CONSTRAINT pbx_queue_pkey;
       public         postgres    false    385    385            �           2606    137070    pbx_queuelog_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY pbx_queuelog
    ADD CONSTRAINT pbx_queuelog_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.pbx_queuelog DROP CONSTRAINT pbx_queuelog_pkey;
       public         postgres    false    387    387            �           2606    137072    pbx_queuemember_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY pbx_queuemember
    ADD CONSTRAINT pbx_queuemember_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pbx_queuemember DROP CONSTRAINT pbx_queuemember_pkey;
       public         postgres    false    389    389            �           2606    137074    pbx_voicemail_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY pbx_voicemail
    ADD CONSTRAINT pbx_voicemail_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.pbx_voicemail DROP CONSTRAINT pbx_voicemail_pkey;
       public         postgres    false    390    390            �           2606    137076    u_pbx_sns_id 
   CONSTRAINT     R   ALTER TABLE ONLY pbx_extensions
    ADD CONSTRAINT u_pbx_sns_id PRIMARY KEY (id);
 E   ALTER TABLE ONLY public.pbx_extensions DROP CONSTRAINT u_pbx_sns_id;
       public         postgres    false    378    378            �           2606    137078    account_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY security.account DROP CONSTRAINT account_pkey;
       security         postgres    false    392    392            �           2606    137080    openjpa_sequence_table_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY openjpa_sequence_table
    ADD CONSTRAINT openjpa_sequence_table_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY security.openjpa_sequence_table DROP CONSTRAINT openjpa_sequence_table_pkey;
       security         postgres    false    394    394            �           2606    137082    organization_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY security.organization DROP CONSTRAINT organization_pkey;
       security         postgres    false    395    395            �           2606    137084 	   role_pkey 
   CONSTRAINT     E   ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY security.role DROP CONSTRAINT role_pkey;
       security         postgres    false    397    397            �           2606    137086    session_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY security.session DROP CONSTRAINT session_pkey;
       security         postgres    false    399    399            �           2606    137088    u_account_email 
   CONSTRAINT     L   ALTER TABLE ONLY account
    ADD CONSTRAINT u_account_email UNIQUE (email);
 C   ALTER TABLE ONLY security.account DROP CONSTRAINT u_account_email;
       security         postgres    false    392    392            i           1259    137089    i_report_creditcard    INDEX     E   CREATE INDEX i_report_creditcard ON report USING btree (creditcard);
 (   DROP INDEX billing.i_report_creditcard;
       billing         postgres    false    179            j           1259    137090    i_report_tariff    INDEX     =   CREATE INDEX i_report_tariff ON report USING btree (tariff);
 $   DROP INDEX billing.i_report_tariff;
       billing         postgres    false    179            �           1259    140735    i_dspston_campaign    INDEX     J   CREATE INDEX i_dspston_campaign ON disposition USING btree (campaign_id);
 *   DROP INDEX callcenter.i_dspston_campaign;
    
   callcenter         postgres    false    402            �           1259    140736    i_field_layout    INDEX     >   CREATE INDEX i_field_layout ON field USING btree (layout_id);
 &   DROP INDEX callcenter.i_field_layout;
    
   callcenter         postgres    false    403            �           1259    140737    i_layout_campaign    INDEX     D   CREATE INDEX i_layout_campaign ON layout USING btree (campaign_id);
 )   DROP INDEX callcenter.i_layout_campaign;
    
   callcenter         postgres    false    404            �           1259    140739    i_lddetil_field    INDEX     C   CREATE INDEX i_lddetil_field ON leaddetail USING btree (field_id);
 '   DROP INDEX callcenter.i_lddetil_field;
    
   callcenter         postgres    false    406            �           1259    140740    i_lddetil_lead    INDEX     A   CREATE INDEX i_lddetil_lead ON leaddetail USING btree (lead_id);
 &   DROP INDEX callcenter.i_lddetil_lead;
    
   callcenter         postgres    false    406            �           1259    140738    i_lead_campaign    INDEX     @   CREATE INDEX i_lead_campaign ON lead USING btree (campaign_id);
 '   DROP INDEX callcenter.i_lead_campaign;
    
   callcenter         postgres    false    405            �           1259    140741    i_result_campaign    INDEX     D   CREATE INDEX i_result_campaign ON result USING btree (campaign_id);
 )   DROP INDEX callcenter.i_result_campaign;
    
   callcenter         postgres    false    408            �           1259    137097 !   cc_call_archive_idx_calledstation    INDEX     _   CREATE INDEX cc_call_archive_idx_calledstation ON cc_call_archive USING btree (calledstation);
 5   DROP INDEX public.cc_call_archive_idx_calledstation;
       public         postgres    false    207            �           1259    137098    cc_call_archive_idx_starttime    INDEX     W   CREATE INDEX cc_call_archive_idx_starttime ON cc_call_archive USING btree (starttime);
 1   DROP INDEX public.cc_call_archive_idx_starttime;
       public         postgres    false    207            �           1259    137099 $   cc_call_archive_idx_terminatecauseid    INDEX     e   CREATE INDEX cc_call_archive_idx_terminatecauseid ON cc_call_archive USING btree (terminatecauseid);
 8   DROP INDEX public.cc_call_archive_idx_terminatecauseid;
       public         postgres    false    207            �           1259    137100    cc_call_calledstation_ind    INDEX     O   CREATE INDEX cc_call_calledstation_ind ON cc_call USING btree (calledstation);
 -   DROP INDEX public.cc_call_calledstation_ind;
       public         postgres    false    206            �           1259    137101    cc_call_starttime_ind    INDEX     G   CREATE INDEX cc_call_starttime_ind ON cc_call USING btree (starttime);
 )   DROP INDEX public.cc_call_starttime_ind;
       public         postgres    false    206            �           1259    137102    cc_call_terminatecause_id    INDEX     R   CREATE INDEX cc_call_terminatecause_id ON cc_call USING btree (terminatecauseid);
 -   DROP INDEX public.cc_call_terminatecause_id;
       public         postgres    false    206            �           1259    137103    cc_call_username_ind    INDEX     D   CREATE INDEX cc_call_username_ind ON cc_call USING btree (card_id);
 (   DROP INDEX public.cc_call_username_ind;
       public         postgres    false    206            �           1259    137104     cc_card_archive_creationdate_ind    INDEX     ]   CREATE INDEX cc_card_archive_creationdate_ind ON cc_card_archive USING btree (creationdate);
 4   DROP INDEX public.cc_card_archive_creationdate_ind;
       public         postgres    false    228            �           1259    137105    cc_card_archive_username_ind    INDEX     U   CREATE INDEX cc_card_archive_username_ind ON cc_card_archive USING btree (username);
 0   DROP INDEX public.cc_card_archive_username_ind;
       public         postgres    false    228            �           1259    137106    cc_card_creationdate_ind    INDEX     M   CREATE INDEX cc_card_creationdate_ind ON cc_card USING btree (creationdate);
 ,   DROP INDEX public.cc_card_creationdate_ind;
       public         postgres    false    227            �           1259    137107    cc_card_username_ind    INDEX     E   CREATE INDEX cc_card_username_ind ON cc_card USING btree (username);
 (   DROP INDEX public.cc_card_username_ind;
       public         postgres    false    227            u           1259    137108    cc_iax_buddies_host    INDEX     G   CREATE INDEX cc_iax_buddies_host ON cc_iax_buddies USING btree (host);
 '   DROP INDEX public.cc_iax_buddies_host;
       public         postgres    false    185            v           1259    137109    cc_iax_buddies_ipaddr    INDEX     K   CREATE INDEX cc_iax_buddies_ipaddr ON cc_iax_buddies USING btree (ipaddr);
 )   DROP INDEX public.cc_iax_buddies_ipaddr;
       public         postgres    false    185            w           1259    137110    cc_iax_buddies_name    INDEX     G   CREATE INDEX cc_iax_buddies_name ON cc_iax_buddies USING btree (name);
 '   DROP INDEX public.cc_iax_buddies_name;
       public         postgres    false    185            z           1259    137111    cc_iax_buddies_port    INDEX     G   CREATE INDEX cc_iax_buddies_port ON cc_iax_buddies USING btree (port);
 '   DROP INDEX public.cc_iax_buddies_port;
       public         postgres    false    185            �           1259    137112    cc_prefix_dest    INDEX     D   CREATE INDEX cc_prefix_dest ON cc_prefix USING btree (destination);
 "   DROP INDEX public.cc_prefix_dest;
       public         postgres    false    214            �           1259    137113    cc_sip_buddies_host    INDEX     G   CREATE INDEX cc_sip_buddies_host ON cc_sip_buddies USING btree (host);
 '   DROP INDEX public.cc_sip_buddies_host;
       public         postgres    false    187            �           1259    137114    cc_sip_buddies_ipaddr    INDEX     K   CREATE INDEX cc_sip_buddies_ipaddr ON cc_sip_buddies USING btree (ipaddr);
 )   DROP INDEX public.cc_sip_buddies_ipaddr;
       public         postgres    false    187            �           1259    137115    cc_sip_buddies_name    INDEX     G   CREATE INDEX cc_sip_buddies_name ON cc_sip_buddies USING btree (name);
 '   DROP INDEX public.cc_sip_buddies_name;
       public         postgres    false    187            �           1259    137116    cc_sip_buddies_port    INDEX     G   CREATE INDEX cc_sip_buddies_port ON cc_sip_buddies USING btree (port);
 '   DROP INDEX public.cc_sip_buddies_port;
       public         postgres    false    187            �           1259    137117    i_pbx_cdr_voiceprofile    INDEX     N   CREATE INDEX i_pbx_cdr_voiceprofile ON pbx_cdr USING btree (voiceprofile_id);
 *   DROP INDEX public.i_pbx_cdr_voiceprofile;
       public         postgres    false    371            �           1259    137118     i_pbx_ivr_pbxorganizationprofile    INDEX     b   CREATE INDEX i_pbx_ivr_pbxorganizationprofile ON pbx_ivr USING btree (pbxorganizationprofile_id);
 4   DROP INDEX public.i_pbx_ivr_pbxorganizationprofile;
       public         postgres    false    379            �           1259    137119     i_pbx_lst_pbxorganizationprofile    INDEX     h   CREATE INDEX i_pbx_lst_pbxorganizationprofile ON pbx_blacklist USING btree (pbxorganizationprofile_id);
 4   DROP INDEX public.i_pbx_lst_pbxorganizationprofile;
       public         postgres    false    369            �           1259    137120    i_pbx_mbr_pbxaccountprofile    INDEX     `   CREATE INDEX i_pbx_mbr_pbxaccountprofile ON pbx_queuemember USING btree (pbxaccountprofile_id);
 /   DROP INDEX public.i_pbx_mbr_pbxaccountprofile;
       public         postgres    false    389            �           1259    137121    i_pbx_mbr_queue    INDEX     H   CREATE INDEX i_pbx_mbr_queue ON pbx_queuemember USING btree (queue_id);
 #   DROP INDEX public.i_pbx_mbr_queue;
       public         postgres    false    389            �           1259    137122    i_pbx_ntn_did    INDEX     G   CREATE INDEX i_pbx_ntn_did ON pbx_diddestination USING btree (did_id);
 !   DROP INDEX public.i_pbx_ntn_did;
       public         postgres    false    375            �           1259    137123    i_pbx_ptn_ivr    INDEX     B   CREATE INDEX i_pbx_ptn_ivr ON pbx_ivroption USING btree (ivr_id);
 !   DROP INDEX public.i_pbx_ptn_ivr;
       public         postgres    false    381            �           1259    137124     i_pbx_qlg_pbxorganizationprofile    INDEX     g   CREATE INDEX i_pbx_qlg_pbxorganizationprofile ON pbx_queuelog USING btree (pbxorganizationprofile_id);
 4   DROP INDEX public.i_pbx_qlg_pbxorganizationprofile;
       public         postgres    false    387            �           1259    137125     i_pbx_quu_pbxorganizationprofile    INDEX     d   CREATE INDEX i_pbx_quu_pbxorganizationprofile ON pbx_queue USING btree (pbxorganizationprofile_id);
 4   DROP INDEX public.i_pbx_quu_pbxorganizationprofile;
       public         postgres    false    385            �           1259    137126    i_pbx_xtn_pbxaccountprofile    INDEX     Z   CREATE INDEX i_pbx_xtn_pbxaccountprofile ON pbx_exten USING btree (pbxaccountprofile_id);
 /   DROP INDEX public.i_pbx_xtn_pbxaccountprofile;
       public         postgres    false    376            �           1259    137127     i_pbx_xtn_pbxorganizationprofile    INDEX     d   CREATE INDEX i_pbx_xtn_pbxorganizationprofile ON pbx_exten USING btree (pbxorganizationprofile_id);
 4   DROP INDEX public.i_pbx_xtn_pbxorganizationprofile;
       public         postgres    false    376            {           1259    137128    iax_friend_hp_index    INDEX     M   CREATE INDEX iax_friend_hp_index ON cc_iax_buddies USING btree (host, port);
 '   DROP INDEX public.iax_friend_hp_index;
       public         postgres    false    185    185            |           1259    137129    iax_friend_ip_index    INDEX     O   CREATE INDEX iax_friend_ip_index ON cc_iax_buddies USING btree (ipaddr, port);
 '   DROP INDEX public.iax_friend_ip_index;
       public         postgres    false    185    185            }           1259    137130    iax_friend_nh_index    INDEX     M   CREATE INDEX iax_friend_nh_index ON cc_iax_buddies USING btree (name, host);
 '   DROP INDEX public.iax_friend_nh_index;
       public         postgres    false    185    185            ~           1259    137131    iax_friend_nip_index    INDEX     V   CREATE INDEX iax_friend_nip_index ON cc_iax_buddies USING btree (name, ipaddr, port);
 (   DROP INDEX public.iax_friend_nip_index;
       public         postgres    false    185    185    185            �           1259    137132    idtariffplan_index    INDEX     K   CREATE INDEX idtariffplan_index ON cc_ratecard USING btree (idtariffplan);
 &   DROP INDEX public.idtariffplan_index;
       public         postgres    false    215            �           1259    137133 *   ind_cc_card_package_offer_date_consumption    INDEX     q   CREATE INDEX ind_cc_card_package_offer_date_consumption ON cc_card_package_offer USING btree (date_consumption);
 >   DROP INDEX public.ind_cc_card_package_offer_date_consumption;
       public         postgres    false    235            �           1259    137134 !   ind_cc_card_package_offer_id_card    INDEX     b   CREATE INDEX ind_cc_card_package_offer_id_card ON cc_card_package_offer USING btree (id_cc_card);
 5   DROP INDEX public.ind_cc_card_package_offer_id_card;
       public         postgres    false    235            �           1259    137135 *   ind_cc_card_package_offer_id_package_offer    INDEX     t   CREATE INDEX ind_cc_card_package_offer_id_package_offer ON cc_card_package_offer USING btree (id_cc_package_offer);
 >   DROP INDEX public.ind_cc_card_package_offer_id_package_offer;
       public         postgres    false    235            �           1259    137136    ind_cc_charge_creationdate    INDEX     Q   CREATE INDEX ind_cc_charge_creationdate ON cc_charge USING btree (creationdate);
 .   DROP INDEX public.ind_cc_charge_creationdate;
       public         postgres    false    242            �           1259    137137    ind_cc_charge_id_cc_card    INDEX     M   CREATE INDEX ind_cc_charge_id_cc_card ON cc_charge USING btree (id_cc_card);
 ,   DROP INDEX public.ind_cc_charge_id_cc_card;
       public         postgres    false    242            �           1259    137138    ind_cc_ratecard_dialprefix    INDEX     Q   CREATE INDEX ind_cc_ratecard_dialprefix ON cc_ratecard USING btree (dialprefix);
 .   DROP INDEX public.ind_cc_ratecard_dialprefix;
       public         postgres    false    215            �           1259    137139    sip_friend_hp_index    INDEX     M   CREATE INDEX sip_friend_hp_index ON cc_sip_buddies USING btree (host, port);
 '   DROP INDEX public.sip_friend_hp_index;
       public         postgres    false    187    187            �           1259    137140    sip_friend_ip_index    INDEX     O   CREATE INDEX sip_friend_ip_index ON cc_sip_buddies USING btree (ipaddr, port);
 '   DROP INDEX public.sip_friend_ip_index;
       public         postgres    false    187    187            �           1259    137141    i_account_organization    INDEX     N   CREATE INDEX i_account_organization ON account USING btree (organization_id);
 ,   DROP INDEX security.i_account_organization;
       security         postgres    false    392            �           1259    137142    i_account_role    INDEX     >   CREATE INDEX i_account_role ON account USING btree (role_id);
 $   DROP INDEX security.i_account_role;
       security         postgres    false    392            �           1259    137143    i_session_account    INDEX     D   CREATE INDEX i_session_account ON session USING btree (account_id);
 '   DROP INDEX security.i_session_account;
       security         postgres    false    399            �           2620    137144    cc_card_serial    TRIGGER     l   CREATE TRIGGER cc_card_serial BEFORE INSERT ON cc_card FOR EACH ROW EXECUTE PROCEDURE cc_card_serial_set();
 /   DROP TRIGGER cc_card_serial ON public.cc_card;
       public       postgres    false    422    227            �           2620    137145    cc_card_serial_upd    TRIGGER     s   CREATE TRIGGER cc_card_serial_upd BEFORE UPDATE ON cc_card FOR EACH ROW EXECUTE PROCEDURE cc_card_serial_update();
 3   DROP TRIGGER cc_card_serial_upd ON public.cc_card;
       public       postgres    false    423    227            �           2620    137146    cc_ratecard_validate_regex    TRIGGER     �   CREATE TRIGGER cc_ratecard_validate_regex BEFORE INSERT OR UPDATE ON cc_ratecard FOR EACH ROW EXECUTE PROCEDURE cc_ratecard_validate_regex();
 ?   DROP TRIGGER cc_ratecard_validate_regex ON public.cc_ratecard;
       public       postgres    false    424    215            �           2606    137147    cc_agent_id_tariffgroup_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY cc_agent
    ADD CONSTRAINT cc_agent_id_tariffgroup_fkey FOREIGN KEY (id_tariffgroup) REFERENCES cc_tariffgroup(id);
 O   ALTER TABLE ONLY public.cc_agent DROP CONSTRAINT cc_agent_id_tariffgroup_fkey;
       public       postgres    false    216    4284    189            �           2606    137152    cc_support_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY cc_support_component
    ADD CONSTRAINT cc_support_id_fkey FOREIGN KEY (id_support) REFERENCES cc_support(id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.cc_support_component DROP CONSTRAINT cc_support_id_fkey;
       public       postgres    false    343    4457    342            �           2606    137157    cc_ticket_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY cc_ticket_comment
    ADD CONSTRAINT cc_ticket_id_fkey FOREIGN KEY (id_ticket) REFERENCES cc_ticket(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.cc_ticket_comment DROP CONSTRAINT cc_ticket_id_fkey;
       public       postgres    false    353    352    4467            �      x������ � �      �      x�3�4�2�4�2�1z\\\ �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   "   x�3��!��܂���<CN3N� W� t��      �      x������ � �      �      x������ � �      �      x�35�4����� pS      �      x������ � �      �      x������ � �      �      x�3�440����� 
~      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �             x������ � �            x������ � �      	      x������ � �      
      x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �         �   x�-�1�0���W���"�
�t�[��y���H���}��tw���t��Nu��x�X^�3��d��[X29�g
�Ă1�e��X2�'%�+�2��8
`!)y�@��oH@���͌h;
��6���<��zߨ�U��V��ouo��_=>            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �      !      x��}�v�H��s�+bt���E��*�dM�Zl��֒�̬�:8Rh�  %ӧ�g�����nX�r�ӓU��@,77n�=u�%��C/�� �e�
�q=,�V�� Q�W��G�{FuuМ�v��Z��5��w��U�T_z�,H����O�齵W�4�/�JO�H��4���k/�2$��Q�G�����20t��x5����a�gd�ʘ<��4�ꭗ�h�$A4Y�;xr'�i����:��
��q���rN�,��r�=5��p���*���䥰Fa��j7�k9ST�=���[�8��}�o㥎�Zz*��W#F�d�s��o7��Ig�>�'��>N3�Sp��j�f������$H�2�u<>�o��\_y�Ee��[+?��,�f�ﭳx	e�ڪ�y�g(�I[}��9���7��e�E�tS��R���é^.<yЙ,2���������	"_��v�V�^)}����Qmō(� 8���kB�����d�Fޢ�����)$���p	Uũz�O�yGQ0����v��>��畗�Oq�s�K�L��t٣E��y\ �������������a����͂( ��cg��4�Âz���t
3�//��$�Ǟ��jo�q����~Əq��P&��}�.��f��1��*tW�\5���S�F~𩹼_��0z@8^y���$^EYy5��0���#o>��&j�@���s��l6�>Y�f�S����P�|ʂ(��Q���n�Z��|�B?�êjӸY��@���7� ��j*&��p�Ex��n����O5m�C8-5*�~,��*!�Ecx���عK�̩#�ӺC�{�)�� �b�KBc_O�xA՞��,��-��)��z�"����� ��-`��W�B�a�����:NW�I ]=��}�8�������m��Κ`������=	�5��'\	���#}�SO�%W/���#�2�̘M�}�lP2Ų�Ȓp6�|T����A��	֏����e3�L9�u㷺J?�d!��MUt�.m� �R�����{�HH��TZ��U��D �	u5�����Ni�+���
�5��E	�� K�0�à���� �	w<��f^m �SWǚ��$�;�V!�e�Co'���
ɫ[��D;���a��׮�򖚛n �W��'Mx,P��p��Tp�����@@~�/�Yd]x>�'���p��e/�C�-�"ْ��Ҁ�am���H���N���Y�;8�N������!�4���ƃ��������)`ØA�TKH/a!��@�
��;f�ACg��^B��w�������=<Ї���y�.�WK� ��� 0aL�_*b��U gz����vu�����ݺD��#�:Z�a�]��������{酾��s;��aW�HpJەP�����r�W�1�JX1 �K|�"g��W�c.�.?�1����*X@�.Z��x5��� ��� <��{��ԑ��3�kE��Z��ц��̛�2��6LH���p�M�Κ�. #�L�~�8p����K7�>��Oc7�rb�@TI�i!
��ӧ��m�p��4��a�h����U��&)�Wp2~y$'XA���RIS��^�=8�f���׵t��n�s�7��R-3Y�rg]5�\j�H��I+���K`�)`W� ����5٪�^���S7�+��>H0K`a~$����y�_*؀�}9}u�	���-���8_؜$���}����[+���}��9��p���Y���J��tS�������qM�Y�Xf|�.��_1y�^�7 �7���EX�z`�+K'����̯A��b���s`�N+3k�) g�m��Ӱ��.��j_�&��$���e���~��i�����:�K�r��1vb�ߜ|�,
�~C��.���>�����b�M��[��v9�WH�ŕ^bA.�	����:��s�U�i9\���������5}�􏁭�=���ٲlf<XK�)uy=8���wZ�!��(�$�a�%��b3�pxa�Ѯ/V6V�[��Uj�N��_�[�iwz�v��������lү wfz����cUۛUǔ�e��1f�WI��g)��m�ӓ�G�ܜ�y�)
�)7�E( I�����t�@���U�χU�Z����(��k��I<�����׬\k[oCe��#�d�r�L�Q˒�j:���v��i)?g��uU�N$ ��i�5��=�3�A��ޥ�۽7[ tڊ���0��j����ZvA�b�J0�/����_��[M��4�E����g���N��K�}DR���yp��3�Ek,z1�, �����l˴���6���h�]�EՇ����=V:����9j��x��A�`۰~�%l����O�����ZR��H%��V��A�:K�(�&�����m�pۨ@�W�+	?͋�[����=��5�����k�J�(��g f=y�}J�1�8�<��8i��j�]\�+��M�
�I�'��H�/�P@Y�"8�%$�K�	9���5�1��bXa��#X��һ�������)��{�n�w���ۃ�֢���3��Ȁ5&l���~K��>ɶ�T[�	��Spp}�>��������_h|���AYpy���%���ρe-	���Yf�;��FLz�p94�m*�Ɛ{@%�l�������..�Ԍv �B�N0sR�E���
��Q�D�B�͐�qQ׀D� ��@`"7�]T��v�Q&iZ���7"��z)��'�B{BÈ�c�2�G���J��27�`��P6��C����LD��-�(Aȴ�6h��d����z��b5�<*�q�1
�i;"��8b:�i�G���=�1s|q<�8>�0:ӣ����Dmxq3>�pv;�8��p#�*S��&��#x2�5>P����j�*������`�=}uys{5�%/lW:��(��I�����!_	�(7�lȦi��YVF��UD�/Z$�U��ϖ!���K�I}-5� ź���V>���\�|Z!�%��q@*#Rb?���mV��QԞ-YJ�pT��$��o��|��X�x~~_�n��;0G���{mg��֭�!��<���+�DP�ns��ы�}�?���+nY�� �f|Ū1���5T�b��!6�x`{�	�Р:����L7��Ϭ��6:��; Ț��5R��ܭ�V!Q�N��C� fB]Њ|7X��#�eS�\��G#�Kf�Xl��9)���職�%Tz�(�+V�P�0��2:u���,����r� JSoB��Üҡya�HV�Rౡ��ӣm�pNQ̶v&e4:�X�B_��W���5J_7��i�D"�Ո/c���6P3��h�O�-�Ez��A�H͂����ޓ�qG�E��K����3įyGe�v�l�ū��z�7�?B��g�4��@�߅�>>qo���Ҵ�ޭ����l���s�z֕>�|}��\���b��6��Q��҄�ʋ��7[T�D�w���3�ܛ)�}IA���,�P>5�Xn��we�/K����W5mۤ�=E�9���\�OP�A6�7ظ_P[� �m�Ư�Y�2�˃1������V!��>�
"�Ka����lͫ��'����k8ib�G�p����<�t�>ٸ��߆Z�o�?���n�m�SO���X��0
��c����k�؋�X.�lb��>7F{k���Q�C7��|N �*(Tmg�l���7я4KB1����w�f�lt��Y���ɨȡ.��GkBƆ��?��@�+yTѡ��_Uգ�xSytQ�JW}u~�^[��DXx[���eG�?z��<���F^`���UN�Kz��7I��Mg����h�i��i�]`�8������X}�ՉNj��/4'�E��d���l6��Ž���Ca��2�l��R���㯶}A8E��|0Gi�˦�/�]zE����c; +;��K:mn ��b�m��(���{���UZN�t�r;SC    _���nN������У��K}��D�}8f_�r��Z_��j�/���l|>���휿�o��'�#`�uyI���[�.c� �oj��I��~����3���`<��,��Q M�<�܋K�����@֦�c�hQꗏ�����cgXMc�J�N���<�O�� s�"{&`?H$�#��t��\	���y�/��𘮀3�S�dG�v{�M,�i�ϰ�Ni���*�$���� 3z�B/_���.���R�b�� �>V"�S�G���1�IxQ��8A�8m>���=T���'��>?w���.�x^$\T��lF>",��`��L�oG)̌���J�^^��n��)��듣���c f���k}:>;��|`5�e�}���7t�J E������e�v��3AZ�e��$^&�V�M�zw�e��<q[V>��F�GT^����©'e@8,uY�L�y�yNco��Vj�0�k5?{h�^ˬy�9p��'�dI,*.A�d�.���A�HB�9�=~�]��Ai_���ɐ����p4�D�El'!nu�<M�Hpa�44.5��t�C�G��8��V>��N�뜜w��E1�*�Ɵ�q/1��)q'~�x]e�4jJݨ�`ʈbxM�ذzڏ'+T'
?g�A�E�9���ص��$,�	 F�1j*������_H@�C�;��7��Ɵ�`y���������|�O��Lyo��~��vZ�C�����E8���v�=?��g�)m���#g��|���̽d�����j� ��I��ų�	ڗ��Wi����4t\4��A�I��1؟��4����;�L<�@Ea)`B�=:� H��L2EmQ��q����z�hҖd�x\�m8M�p�y��]���A/U���5�L&�x8Tכ�]T�|a�5��}�����P������;�������]:IB�86�=-��_�@������l�:�r���S�T�>38��c��h���J��nx��f��/�Z	�_�b���ݶ�?�`����\�'^�X�Ͱ���M�O�=��:H�8��d�`1���A1���U��-KG��&���G-]0���*UuE7G ���Sҁں�~R?����G� ��Q_��:�,
%�j��K��22fW`i�p%���@��a�V�	I_�ލ���/<i�S~��o ���� f忡�Ky�*�Q�aL&yHQo�^�U��V7 &��c��:P��vg��n�B�UJ�f���P)=E�}IR+��+��̋f+��<�VԽ;�(.�!�܂�oD�7r������-��ߞD3���p5O=�o���ҥ���7�70+M�Ϻ����w
������v�� ��Xf��;���~E^Ѱk�Pv�op�R��@�$��L���9C^���ͯ�S��(�^
#�Y�:���*���p4���ӧq(�؆$�H&��%\�v�1�*N�P2�|��(4E�"�
�Ds�}��)v]v5�����a)7Gg۰�PZz�� ��t5'v�/���)�F^��G46͵���P� *'W��M^��5x~�:31�56 ��I�f����~��>��{���MC���3�W/|.��Ӱ��0q���pA���C}c��ɇ�[v�P]O�H�*�^��\7
���	9� �ۧ�$?(
��5�^,��0"Qy�O@�l�u�1g(�]K ��K�a��ɂX�}dҊq��e�Jc;���0���I[�䦡O.����ي�w��!=���zsKy� "��č�0��<$
m,��R�v7k�q��m��h����k���ӆ��������>��I;���ٍ�Y�'��e��������8`����b���k�9:W&�'�ܷ���w�>�<� `��c�&�wY�J�[��%"mf��S�<����l�,Y���'�o���@���Td6u�6��N��Rd�$��}�"� *�eP�w�%��1$8��L"�}��|�#{�8��)�*���l#8��9��zr~���s��]��N�����֛�vzD&iB3d&��%K���+�W�ے�O�EDp��e*NJ{��l�=�a��Qw�a��!���Y�$^eA�H�X�abGgDOn
$���x��.�8^Nm��;4-����qѲ�c;`'T�&��z`�+�#N5��*�8<C���<�2��r�� 0�5�#�q�r) ^��?�W+ ?�/�yP��?B�Az�	��⃾9�����
�����?�`�Q�桅_����hTd�����aH�Q���0|;�/x�17�ש�$I�b(�M���&~!*�v4w/.aC���H�e�C#��FGk�1k{9ςv(
P,Bdc{rH��kb�(�Vo/o���w#�kI�l��A��}5��O��0°7��wpDB�g�,���|
Ӭ� ��i��?��,�7����%F'�]��@4?)L�c��|�Y��e�h�)!��$5m�b��V8/�:�>���.��WX�}�lKB.O�����o��������"�����Iqe-�������i��
 �i����%��Bn�T܄�gv�|(j�N
����nNcމf����gϣ������c��9��%Q�$���X�c��_�RY�]h�8�cB�@�0������o!s%�f�����т��~�K�6M��1^�WQر��`�_�H��Ҵa��� �����g��z|rq|���~����i����(Y����,-Hz8����JT�	�+/SL#��G�`���)S�,eX��`O'�_X�~\�Irgǯ��|dR˃� ��Y���$]5�x�M��k6߅��M!�#�(��@J�+E��URl!��^	A���	����D�;� }�EC[���J��3�c5&�3�I����0��(ߩ��4����h1�k�X�9�S7W8)Ɉ�3�ϔH���V���Ȼ�8B�;B
�i ͷ{���>(���	<�Hn�	q"�3/�#����><���[��a��v��U��M�y����0����F0<P�����fr_ &��'�6:2r�-	�~��.�+��_ɉ��	�2���2��q�4U�7[`�oc�2��``C<�((���c�G2��/��&5�A�t�D/'d/���ob��D�����$� ~���?�A�&rR�|Mn@���x��Lp
��{fh	(�t�#S����r8Y*m�������T�u&�hґ��`��P-�m�Q�M�8hsF'�5f�P$˙Q�zc�=��Wھ��Ѩ�4B]a.P��kS̊fce�)P
wk{�;%5)�D6�c��֛:����`����F�՘c��?|��8���k_�dh�v�Œ��"�(�dJg����<�TY9Kܙe?2
e�L��
yy�Io�S�>i*���;Iʱ��"���w��+QD_�"�Ԩj���FUC��/V�T���Bt��C"L�������$B�����P�%�ZOk:VT�j�28zR�Ȅ�=d#eP$���J��kjh,��#jti��]�&*��n�o�Z��n�Y����yk�K�l��2�P�5�)5��S�|rA�0b~�)�o}\E3���En�J�/���0��������(M�	���}�=)�}�J�C?�Ͻ$m,>E�� �>X%��~����ȁk>sH���J9w*����e[^�8�{ �4X��^�������PV�< 0��0C��z�8?��Wk��仅��&��7{��u��n`�T����4i�=傯��旭sɂ������x�2x�fo�'c���d��n׬Ɓ"K��A�S���V;���XWf�L�x��g�DG�ygmEg����̙���Y�ݚ�R�^���\.Y�u�H��A�r�nS��b�~��j�muf�	�m>�n�R� %e>�L�	�g6t��'��o�d]ğ��/m��.�i�5g����Rb���W�V�lYwjRn��[�ah6��ž������ǊSr�78�w)�A&5Q�������/ ���!    �RMO���Tl������B�Ɵ���B_�n��0-�'�Ґ��fJjXG_8�0�˾��N��U��}{�=%�^q]7	Ӽr�h�������?�Lw���6mA����<a�<�f۴�뀳(3�Oa ���8@P�cz��ṭ��\�lH�J"�J�c(#{�a�#���7��p��Ba]rl0V;�����ɗ,��"���jm:=�n�SV3�d`5��&"ϒ�� U����Jy��)���Ϥ���\�˹��V?ϰ��y�Ȱcd�YR����	[�J�VU_h�� `������e��i��,[��N���=�L�����}љ��`��"�U��hoO�h}�f�������iG2 #P�ߎ͠�����oڹh���'jxP#U�E �ڄ�wj��u-ulz0�t�(�ޫ���H�+����~.@/䭲���հ3���X��O4'�����S�[��N&�BF�ɃS#�~�1�P����a��lr�<A6w>D�r|I`��ZV��K)�X��}�3n�c�JMZ�M5���a9E�~��T  #��:����y�na��a��U�b�mU��lv�i��NDl@!�p�(.p�I�C6 >/�j��,{v����gW쵹yEA'7���m���̤�3y���JK�JG�q��\���Y�n)\�x������y�WoX�Ű4�x�
dE�t��Nn��]�TW�S���c���ހ�s��Q5uɣ�a��@�������)a���Ł�h�d2�"Y���D�a(z�gM`2S��#� �lT{�}���V_�[����IӔ�(�aQ������t�dL ��� � �!�[*�[���Yh99�J!q��\`���R�+�G�9�9H0���E&ה5�y��ߢ#�q��m�R��C�[ �9���"3�Q�%�2�7�Q�B����tz&3��@9�&��|��_qHj�[k\47����1o�t�B�T�=l�U����;��Dk�"� >�;�
��ir�!��4�i��.��C�F��Ц�.F����9J�&O�\p�)��	:����(^M�",�0@��\UK&I��U"G��E�}�r�(e-�x%*�W�����%H�4�@xs�/�gsG��:v���;!U�1$(ƙ�85]_TP� 3/T����=��KN:���J�Yx7�D�[�Qh����].���o�w�놂�uC\����j��+`G�\���G��д�ޭ¨�
EG�����^f_��$��-LS�w�������$t/��{|#�a$0��
ї�!�)��C̑�����̳ⶼ�E����Z�t)���>���fS�A�,6�:rN���X��mk2]��7(�`fδ�C&&G!�F�W)��z���[��sN�
I��m�H^|꩑��(�P�7��8m*���5.,q��4cZ�|�����5��(����6
jy�����וdA�l+� P�_���Jǎ30\�5�<LPd"E���g_DK���xކ���w�?�.�����=�	�W�9�0�Wf�r�d.aH8IJ)���%��gU�eM��W�<D-�<)�����Bb��&8�ԩJJ6���n�5g�N��p8��~��j����F���3�A'ܲ���G1$&n�wv��k7��A'����Ǜ��r6_�4�(N��\�i��
tZ4����e�Ϫ4�^�^��۝��߅��Dڍ ��N�`�HQ���?&�V��vo2��\�c�vA�1{:���@YeO��/��?��/���?����%����㓷����7�q0��f���� �o5@��RT@aŻC�V.&ً��Z�s�NNo�n�bw��p�/������3��
Hk�����⤁#4�N.nO���w�o���w1�F zw;��ㄈF�N%���.�|c�{���%U��������1��g���+dC+͝�M�o��u5_�""��|�K,$JZ�.��MS���K��e����,hNf�d�v��s�;�![L��lH��s����ϛ��R"=\�jts�mQ9�~��m�pU՞�-�)]Df���G���=7 �A�]�t;���rX�M`��+��b���?r�]U����Ɍ��;�d/�@���*w���~�_{��׀�����М���o8���oh�X`�(�T��)9��S,g#��G�	��"�a���b *�ɐک���bŐ<�!2U�M��`X��d`�� f���@FF��a�h;-�Y˩�Hj���7�pچ�S�='[UŨB2��-I-�	ޕ��g���fh3՟ӓ��0;*_D���*U�,{��NO���j.���
���Fb�U�/�j ��/:*��S�lʴAޒ����3
e�!�ڔ�9t�{�UM���v�>`���	f��ķ�`U.��-m��	�`�0���ļ�8_-�t�M�m9��F�D��l;���hRyo���q�U���6؟�t#��Im��R�HQ5Js�l��kb�(`�T�"U�h>Mf��}:���P��bnM�_�ь[I��?!�708vF�5��Y\�'��'�o��H�6z-��-��)�+B2��:U���:�"�b>]��F�.������w쒊�b$�/�C ��A���A��ܱ��r�-6�7lpnf� <�_��4����8ƈ%����ǉ��k��W��A&#�C���$��N\���H�&/46�V&k��ؼj�ڰ�q���\zL��7�>��3q`�W�֘׉#���A���d�x��$�&��:�D[����C��,H3�2L�*�ş�^��71�|_��ac+99gLjmU�^fdǄU�J��ވ���m$%�Ϧ�?|���1���x	fjk��Mr�v=�&���Zh� /1�����en�6���;�@PN�Z�Br���a��� �փ���A��DK˚���ل��?U��K�*��խY{��h�H���($�аQ:�
7!�����{5�Nl]�e����F��ty�1��q-Z��!F�c�� �o80N�;7O�_����D�W�.&w4�����\�h?TfH����k���N-%ض�f�RRIr����؜���pWj�U�_�� dOAU����K ��B�?��\�׻�?��CC��#�� ?�\�Y�~�qx���߄��(�䮿�K_'7u����E�T���Q�����E�K��h�B��$^|�:hծ���X�N�.7�d�bo^2w�{���e]hb���6L����^�x�[�$>�2W�m/��I� 8aߢ��sv
-,��y��ͨ�.�� {�D?#�'�"�9��8���ͥ����6P���x"rf��0:b��CcSU8y��ȀCg�@����wp� �)��+X�(��2μpͩUb�L2ŭ.�t+@�3��`���Lo��˃�f��wq]����ɮ0���ſ��b�+by��e�S������+hrK�z'�'��r qV��Q`S�Ir���u*썉%���E.C֖�ɝS�'U�Y��ձ�g�1�A	���E!��~��1'"�v.�w�5;r�LZ���ν2e2�+I�6�-/�`���y|��MlO:��<R�a7~��R�Ϛ��9�e&�����{*C(�]1i��B7���qM� ����W$�<t����[�����3�� �х]Ố�*<��0J�)ׁ��)�CYN�P��'+���%\��E&"꼸�(�����-�[=�n��6�T�-�;���ی��M�j�VֳlZ��D�*`��P����C�p�r�{CY��V}i$°���IJ�������_�����<�7F�N �!��_2���Dq ��ݗ*���:��ҊO�J_^w[�%]��>ѧ���J/�u��G)�*�J�bŗ�}��.��(�����}�*���L���ާ
N�
/鯃��%�!�@�	��.F��KF��Q�.Y7�����,5|ɘ=�qts��䊐K݊cC���<��^2t/�N麬|���*�PŊ/�{`���(��f��U�H�f/p(ig&y2:����s~�ʛ��ز��oʹ�9%C��S�SGb��
�=�UL��$E.�� U  t�����$Ȓ0x,Ɗ:��4�ZX1�(�s�DyU�E�g�o|΄�"�PG�H9�%��@�H���V��u�lUk�#�Y;sV�jqUx���Vl��l�)|��<�������l:-h÷N
���LXդ8�SrD�X4/�9?(ϊX�'/�OC,>���������'뀍��lF����3E��R��8Q�����NjB%=f�0g�KZ���/���)�dƅ6��?�j���ș�Ҍ�bB��/n �CL ��5|��ULw�З4�l���}\���wA$|�5���+


�B� ls}Kxռ�f�|�%��K�����3h�`��TOHvo���P�T�Y���Ӳ�6�`�	9���6dǤ�cW�&�>MN��f�nYF$���q#.�8��N�Aƛ�`��o[��+��OR��� �#�cV��͌�1M`�� ,1��#޺Q�Ĵ~�y�
�b���/��;������?�~��oY�;�C��?�֋�QL�vB��Y�L3�*d�7�R�~��ȹ�+�fD�\��"@]Vsjl�v�Κ���\�D�X�?jr��[3�����47R�~��f����m�z���]Q�V      "   v  x����N�0E��W̊]i�kJA�@�UY �I2q,\;�A����R�&��3'37�q�s��
�*�[�Nh�趁U)ɂ�	:,9'�Pi�4Rۊ8��̱x?.����h�>(/Z���L+�KV�ì�ai�#S�L��єYь~���4{�pY���܁80f�rΨ���Sokr�.ټ?���la�_G�c\�Ͱ$;ItT�%p�B$C5{j�'`��UtH�����,3�/ ]d��]��ȼU�GW��+���A�>82ݒ{W����I�G����As�8�
C�zt��4Ir1
�d�,��1d2fJ;Q�=��mI_���	+�ֹF�Oh��~h��_�ܯ�Ћ�x�B��Q}D�nK      %   �  x��WmO�:�l~���I]6��f�ym�)W�*�qۈ�ε�qs�=vҴZ�!]M������s^8D=9�k�M8������}�x��׃��_�#��7���P�u�9
��8��͗Ϥ��s�l!U�/��aX�3b����@Q�)�")�-/�"߽[r��~j�傩"5�p��f�F�ذ��p�F2
�=y���
1U�q��T!W��x:a��D�l"Sc�O���~˸l�q�W2̭�ֻ6�;n2��p+�>��.r��T�M���ۨ��6�������=An�3�p�=�E��Qc��2&}�7qǣ`�'CtIc��h!�8\�b��Řb���g�J�U��g�s���Xҟts��§��A?\}�7N0!�u%.d���L(c8U^RZ$\d��8�"�o�ꄡ����榋����9"��0��\�t`¡�YX�|�~�� ���:ܒ�h;|z"/�R>���s8DC>���6Cr	+�N�����G)�r��)�40-��YzT�s:&�p����A#{��L���|�g4�3W�W���
p��{��j��g$�%擌�|�V;��KA7�����z]��o���I�wq> �M��_yp��%#����|Q��M��^i�5��Z��YMD�Ф�j��T�@z�W2���|Gz6���F4��w3�&òvV8���k�Q�Մ��Τ,Ԑ�6�+V����=<�Y�n$���2I�������Ƒ�����C��Bf��E"���FD�qy6�]m�������)���A����i�غ	x\۰��8�v�RچV��^��hÆ��(�/ۑ��F���G�������~�[�:��5��c�0W�w�4��0����w)�ݻ�́�w����D�!J��v`�^��h�!h�恝���S~m��O����������.k�Yт�&�츃��y«����t�*Q�{���x�V&�&���G��l�pP��E�V",R�3s]��������lݕ�g�F�%��ǽ�`w�#�k��QH5�յ�$=���D>'ȱ��|mt���q]���D}������]���l���!�θ�Qɱ"7��������}w#��O����30���e�l���r�l��U�,G�[e���Z������ķ�      '   �  x�m��r�H�ש��nz"�;,q�Y����B��I �-$���Ư3�����w$�U51�Le���#O�c�k���I��R���U0�F���d�P;5|��/9�ISQ��]�g{���>g���P5:m��,ϵï�R�M���,�NG�@y~���6A�UA�v���B���#�±l��K�r�����<hǻQ�z�Z�Rd���Ex6��Ǚ�{���7/w0c�6[�K��D6��f���KG��c���;m�7^[�':5}��'}��� [�^�!�\[�uU<T�����胹����뾼�)�����2_�qK�M�������j�"9������?�֍'"�f��F�����D����Fyͦ����!�3���<�Ul�y9W���ľ`���Ӊjtyf<V9yb�7s�^ĩ>�����(.�Zdܻ��g�)��%���i X������&N�S�e�ͤJ?�����iz�$�ro��q�_�w� 	0-/Scݡ��}vǸ�Žer��Gޢ�U�O����K�4�}8U~�#�ۜF[�&���@�w�A^�A�V�<5Y�e���A�P�T��FOV[� ���ݚ�`��<��k4��3j�/����Vr��r���Y��r�ؽC�ă!{x��Y7�^9ل���P��|-���&aQ�S�d݇�I��`&�<�����ifH����|S	�$�<�$;�|9iQ���YN6��+I�AF�:-�\��h'�/n|2�М�}���O{��o���a�*]9!{������)ɋ�㮥�)��zK�a\�q "~n��ŅR�⏇!G�����&������O�\���b���Фg�?9$��N� ����N�FC��C&��ME\7�^���)�.Xm_�*��F���͝6?�
-F��s� d�|���p0y����x���R��l�65��V#��S�#�?QG��$��K�	v�|�x��*N6{YO��g�v�nu�$>�p��S������p:���^�}yf>����-�iw8��n.�3mZe%xKSt��N��OǛ[��FbR\��@��A��,��悦��[�����ɿU�5��Q㠏�<5�;���U��*_Qu<ZƸ�d��:mi;�tzu��?�z|�H��T:���Hgq���
���`�4^��S��� +��!h�'�VX@=��+L�U�$Y���h�!}ڸ���}_�/�YK���5��	 �,��ֻ���J��o�F޿����R@=5�@�C.N�!�;1:��~��~��:����l��	aq#cܟ�R����H
T$[���ݺ�,��P�46�=��M_dGw��6:ِ-��)8|uH�iD����{S�_N9S*��Uߨ�l�E�����ͦ ��O�}�t>�,l��Wգ������g^_��4���K�M����P
 |Z�䊠���s���-���t��
��=K�骻%'��]�*QO͂G�Q3���NG� 3�=3�U���fSP�4�����2B_��3\���"��=��L����]~4z2C������LV��>F�����d"~�).����ۻ�m5�\�Sg�.�?�掚o�I<ׅ��n3��qn�����S�L����zu�>i�쳻�z0�y��3�$v�\�\q�	߈��4�`y�-`ya�Ka�;�$ޠ��T��5�|�+a��OC/�#�
�V6T��Z�i�p�䐘� iݻn3(a�>�ǌL{���РpH��ܐj?����������`�~%�P���xSI�U*'�p��*����k	��n	o�p�9OHBA#$,��۔x���I'�k�Kz���k�,�o��A�*�c��DE��Z_T�Ķ�30�!�:}��YQ��4�U����i���*�>O��v���Ž5C��C��QM15�~�1Yr�^���j����A#� V.�4��P�D͹1�����6��BS�$4�'�(�'���0z�H�ɥo�*_@B8��eg�tg�i�p��n��zC��IO-Vsb�y� %���7iR�A���� ����2�$�D7.��+'����9�JC-YiV�F�`d,�����P�l�����Åe�B�V����f-��du�!t���������Y�[�|�.��b%��F���
s�(���] 7�,� %���jy�f@,�)rt���у���(r�0�my����:��\$_���_ ����T��V���B�3�)+2�-�B?3���{%& ��e�r���U+<F�VFBJ�����m��yW�3�,�+[��Q�[���
�J嫎�T&+��<JF��Wp4�ChW�ɋL�+�H}���䩅Txh�����jm��
X���%�F��s]�dۚ�/s�x����]��1�D\3cɄ|�B�\Y0�%F�\�>[Hbt�2�Eq�8�¼X즧�BvI�z˼܋t�h%�C������A�*mȰ� ��۶&�S�	�ּ�v2��-U��W(s��R�]���Q�"����en����wu�{��C�(ؐ�����VͣҜ����S�IM$`>z��X3����U)���c�<�����W����3=!���rp�=�m��h���z����):�4�}�<�3��
D��x�q`��̃���>"G0���Z��j?}[Kq����]�@1��s��X��%j�֝������|@.*���P�hC�ȵ�J� DϻPtx��N���Ȼ*ZW#o�{@�J�^e��Z�![�=��������m��K^m�Vc$bv<�☫�N�>Y�O����/<k�*p��7������~}�4�~R����C�b�*p�:}�U�ߤV����ȇ���dS|��6@��9=p�-���Z���X�V���!X�y�3i�l̞� ����if��㥔#��^{�5�����a+��z�|8WLL��22WG�R<��Q���Um+�+�ZnQY�} ��.��!�R��R�SRT%�7�C�%�c�)B63
�<��*̆�k�n���"5:[i�r4s$����>�x�|�j�M�j5Sp��&��\?��4��eY$WN�N���T�U��� ^��y���o;�x��v�����;!=[���o`��ʷ�P�M[k
r�8؎��稭��>�����yʑr���{6�D�8ґ��2�z��f�pܖE)�
?E,������艦��7��ᥛ=����a3f�'����=��Kg~��_A�GJΧ��y�w���D^.���~B�#����3"[s�ܱ����ί)��P�\K����
�H_
��Zp�o�398����DB9�L֑4ӭ����Oa��ߦ/��E'F�y �����o�uT^�M�N�Z(Ib�D��H/����x�"A�O�"��d '� �	��%�F�+-�qg���w�~�Q�fG9\��y�"��;����J>E�>{���;��w��+���-�|�`P ���*I݃vez��?q翶�X�      )   t  x��ZMw�J]W~�Vs��������W$��8�i��d����vK�~�V�0V�覻�vխj�����-?��E��փ�;�w��:3��Ϳ���߆����|�2M�Vi�͠`��}^�����+��D`�e�L��+�OŹ�Oڢ>?���wbw�g�J��IJ�j����9ז���>�T��4,[�`S�a�z˵񱬊3����m�s���W�C}�V�(=Q��0�4=�3]�����B�(=!�� <L%D���[<`�NƝc���B�id@8�|�_ZƟ8 ��	��*��` VQm���|nd }aw�c4X'4��f}ђz{́�Nj�2$̠�	��=�\æ]���J�s�P�����w��h��48�WD4���k��`�1��ވM�ŀ�x�����.`�awX�C�$�A��I�$�G@$�[�n�!\���(���,��N��$�ᚮ�dAc����y���X�a��^:�G��WM�z�D���}CIO�����E�
m\��#f�ZL7���iBC~ږ��kI�Ó0��T�p��p滯gF��9���I�Z`���0��y�y��'�X�ɢ_�1��oG��wd���+�2���T�O�Q(@� ��0Z��Ps���� ��ui��9��ںJ��X��XAy,O��s��-����O��(Oe���z��PVE�~�"����&�"�#�j������� �#�Ď�/�a�L_�M��IHê�Wኰ>��$������
Aa���j�9��x��YT�6��"ܠ�����i�p���-,+�X�,f���P�@ !�U	}уEz��Ռ�G�cLA�b[�׏�c�taz��A)D��'����n�u�F4◫6D��n�/y�Z��M�	�tS=֨֏\�m;��a1M�4ڿ=KZ�q�Mzյ�a�J�4:j)?�ȅ���Y���L%1�PЪ�k1�z��92H�QH�˵�
��MB�S�W�FـF�CQ>�_T	l�>l�>��X��d������]�K��(U�����M��&�ɚ?�Ku0oz���	�&�!MM72�w`��+�P%�u�̖4)���W�&Qf��a3��M���K3��N�m���Ѱ�d?iR�k~���u~}bfS��ȰM��c����[Ҁ�݈Z��M�	M9Ԛ6)�j�c
K#<Mu)E�4�#���]]���鹨D���6|�*��� �#���-����dO��.MWc���V�E�vȪ������,i��K��T����66�:�>��fg�ْ�9�Gai<j�ʘ::�	�2riA
~ J�tf9�:K�R���+<v۠Y���Rq�FZzȟ�z�M@��c��G�?qY�n!�ўuf�}�X�c��3o�Z��	K�O�,�~,����5�mva��b��p�Q�����"Z�,?�TX����:�.���������X��=�)H�z&�"��(!x�5$��!8
�Wy�[O����;�0��tu��!E����Y��s�tE�޽���x�^�o\f�k�kP��2ʷڤnI[=r@��K�,�J-*�,�J����TTl�>����N�)ʰ��z��aZ�݃Q*+�fj��ys��kmɯ��z�F�_E��H� �w�	r��y؞L_=�s=�O� 9�=���Jl�s����!�����ǃ��C�)�V2��i�N$�[�(q���5of@��yJx���eW��b���x�b)�M�t=��'$���U�3�%p.�jܹ���Dy&͓ j�L��}}|0ɢq��G�L�WISȡ�,@�U��@�Sa�4��<�ߗ6	���z��p�Q�"�/5 ��U��z�h��/�*��U���M��Zx�h<G{�(PQ�	���鞯<�`�|3ƻP���sm�_��B�;�2�N1��S��:ɉۥtI>>�x�P�?�XX�Zi�+݊ӏ'�������C;w��B��GپIY��+BS=����<��(�1�	��(�d�s��>�L`�3�Zl�g����k1èv����������C�$J{Ks��x�j�:B.ŋ��z��m�'0�([��F�-�	-NH�nó�"��Zʓ磁_�i�����-+��^֨�9Ul&�@T�r�`l��t�?Z A8w���Y�[�ERt�y@��e �3d�6��m����}��&j9	�j���RXe�?��k2��b���	�$τ@�V	�`��ޱi9�i�W�Cq���ZZ"ذ���w
�C�钖P�������9�]�*��_��?"�T6t�6H����)$ld�ͱ��a%�܎���kB���O.���x��p-W}�,"J����e���A�$��AХEi�a���JVJ�K#J��^
�v��(���HƔ�"+~4���F��2�ҌR~�Ą��g��R7�ٔf�/��<�˱�H����?Jє׻B�W|ۈ�7ڴ��86�R:P��x�e�j��2�zb�J��(���+l%�Evn~���}�nv�A��O�s|�:x�#�B�uHQ�ޅ`��h�>*�ݯ�Pc�0�����1�N���n2��BJg���%糲YǬUZ��NӆI�"��FNn�-���bX�d)k!O~WR|&B�6W���3l��#��*�e����*Q[��|e�`.Rkzզ��ѭ�L�݇�� k��5=k�1�ֺV}ɠ\�\��G�Tk0ʳ���\�t⿊k]���\.�;KPf��#��5��.:ߚ96|�n>��r��Q\>.�`��ѱ:��a׈�[��V ]�AXL�ׇ�2^�~���C;���q�$�mR@�ߛJ��y�o-�:�c��t@فP7t�xl&�zFf:�-���OC9���X���m1|f���U���_���tJvkP:�,ӣ,V}.._fmY�~��r;�����K�>���ﶠ�� ��GÇ�FD�6�Y�V�_�ڋ��5���qUS�YV0�Փ��M�M�����`����. &��+ZUu�6�i���$S9��~uO��\�k�݋=X�)j��@Fޏt����ZLƛ��~+���J߃!�E~�,���}��(Ԍ�\Z�Z��CI�� t���	��<�M{u;�vۆ�oe�O$�Mq����g��<|�D"���MjD��{C��4�V׆�}�����?%�      +      x������ � �      ,      x������ � �      /      x������ � �      1      x������ � �      3      x������ � �      4      x������ � �      �      x������ � �      7   �   x���=
�0�Y>�.�;�����9[H ����4C�Y�-o��+]��ӓzN�j��;�������߾N3.��Ǽ���&�0<u(j,��5�𼉌DV*�A����G����Z�2>�s'�6@
      8   �   x�U�]�0��gO�	H�����	Y��@i -��"��a';�m2�m<�X9n�q���L�'��U��ITN�/7t19����A�g�t���/9�4l�]V�~�3�<lh���Bȶ��ж�5Ǌ�\�d���r!�tˈ��$Q�      ;   k   x�m�A
�0��+���f�J��Ћ x��7+���0	A�ВXb�4guN���Ĳ��v���A��$'���k��~&7l��QĻ�@�:#?�Jdq1�݆�	v	"�      =      x�3�4�2�4�2�4�2�4����� ��      >   �  x���_O9 ���S�}�{��{$��	���ev�Y;��al'����p�T��ABH�?���㱃�TV�֠�<����������?��q:8Y0xsG�o��Q�Z�"c},W�	N\�~?��X<�N#�Z�C��j�J��YuJ��'1b���(��wH(�!n�d��B��,U���f�A(���ը�Y�V��<R�^by�*ߢ3�)��aQ�fS���Jǥaj��1)�*:�P���R��ja�]�]���gE�UK��W.P��%\���bW�F��Y%t��2V��1��^V�Vé6^8�:�i�hjѾ��0�vs�t�j=n�{� |���Hyr��R�xc���� gq�{ק P�/z�.�#᧼X¹Y��Fʰ�^8�sR��}^�������W�up�鰖͡E�P�Z�j+�P����������sh^ڒ��p��ؓe�6�Z2KF�4�%��FJ���Hmd������p���|0�j5��2���o'����(d�9�ی�J��*V�U�ɤ�㲃Zܯߒ�㢃�]+�{��D�W�e�r�j-U��5z������Uԝ!������,�����6���W��YQ��V�g#S�˒X�)a�y��O"�CҲ<�U2~ܨ@��Bݨ����(7f��E+�%VI��}����k��jY9l1��vq��q���v���QgX����H+>)�h�w>��ZvS�|�Hy�[�m)�Wp�V��R��ڨV��R�]]�$����L/�7V�9�rY~�w�jQ�{E����Ѽ-���>8�=e�XQ�|��.��=�~��h>e�'��+��u�I#_Ϗ?�~kU���r/e���b����� <Sb�ʷ:�*Z2I��fuHqr��=�%�f�*�l�
��z�J�"���(PɳJ����J/�ˑ�oZ���T��I�W��xXI������Q�\��N��FKT��/a�V<���F��������aƕ޸`.��f���fq�JIk��`�U��H���Fx;OȪ3N��t��@�R0W����0�(}��M��'s2�Z�ű���aY�"�g��ew�S����|c�^�L��k#[x��F�92�5��Q���ö��c�|6*��78%*���p�E�u_���:l|	.,d�?�� }��|5�4���ʕl�o�7�V�2|�N�6�8::��ɀ�      ?   u   x�U�A
�0��+��]�vl=���
=����j��e��(hV82�9�=n~#5�<���#D�G�K�=��Vos)Jn	�����!J^�.���?��������ߌcK)}��#�      @      x������ � �      C   t   x�E�1
�@D뿧�X�����������޿SAq��c(���*CܷG������Q�&�4w�~{�ѥ[���X�[N���^xy�ɣV�p�I O�)9ι=�P      D      x������ � �      G      x������ � �      I   �   x�u��j�0���S���Ppz�i�0�ă��j�ͱ�V6������MH���_�IlCkC�Ff,vE�����i���N���S�5-�Z�f�4
�]%7[<�4�sc�8��j`��3	���~/�nə�q�Lh�	�r������5��ҿ��?v�y<�np{�zZ���H��$�ߞW�g�?�'|J����Ȕ#�27L���7��ݟ�]�$�V;��/�ntg      K      x������ � �      L      x������ � �      N      x������ � �      P      x������ � �      R      x������ � �      T      x������ � �      V      x������ � �      W      x������ � �      X   >   x�3�,H�,H́Rz\Ɯ��y��N��٩EŜ� N��7�,�)M��3��1z\\\ ���      Z      x������ � �      [      x������ � �      ^   h   x��;�0�o�K����'��v6bV	�����a��84S�ؓ���Y�r���R�VLw����߸�z�Ƞi֢V!G��#^���$�BcBDaO      `      x������ � �      b      x������ � �      d      x������ � �            x������ � �      g      x������ � �         �   x�ő�!D��+���R���jL�����(LL����4���{��"	v����G�{���ϵ	��#v�%����l@ /�[g����x
�L�
�*@uL� ��-������@�a�l�хf�_`���s7��}      j      x������ � �      l      x������ � �      n      x������ � �      p      x������ � �      r   (   x�3�LIMK,�)��
�E��
�i
ũEe�E\1z\\\ q�      t   G   x�3�4���ON���/.Ab�V&��eg���)��F�ƺƺ��
FVF�V��z�&���\1z\\\ y(�      v      x������ � �      x      x������ � �      �      x������ � �      z      x������ � �      |   /   x�3�4�4405�4204�50�52P0��"K=ccK3�=... ��      ~      x������ � �      �      x������ � �      �       x�3�tqus�	���L�SPP������ D!�      �      x�3�4�tqus�	���b���� +��      �      x���{�۸���w�S����7�D�zh`�$�ܩNy̞`�l����I��ɵHI�U6�$V�n��3�.�D�\\\\��Q(������W�-w�>l�����v����ѣGoތ��n�z���~Ă�	���0����s�8��bĂ�,~�٣���nx�����{�<�X.G���Kq�h�x�Ȉl����ǸX����x�Z��[;�H%�{�$O!!�3$$$�Q�$�I$$��������}���۫��~=����������/�������;s���x�
~����û#�?�}9�2J��o7��z,�i^�˷��M>}�o����l�f�V�]����N~����������/���ɮ��rZ.�'��b�h2����#�Ct�E�)����)�+
vɾ!�7�v�e���7���dSt���Y	��5���+Nŷ<e0R}�(T�x�1�ц4����F�^~������M9�����v�o鏔�B�7SK �@�g(A�H�Ԓ�>"�P�����'�⳷/`l)�N%'-�/�M1QRHje�|�����Q5p�
��8f��ɷ�����|+��R��T�Y�1��H~[��DS_E���v�ۯ�������rn�i�S߳���8���>ʛ����X~��۝~�ћ;�ɿ�f妾���,ˉ�Z,�r���7�rR,W_���2_nW��Zi���n
|��r!�h";����廢��j/�Q��û�o�?��d5�~0
�����j	WD�I �@�i���W�X���ݸ~Z����iX}��˗�v�m��[����kZN�.{�}�+��I�Du��v�F��\,%k��ˉn�sl�~�;�f��|��W��� ���r�����Dw���f�����c�|���jW��ؕ��y4�v7��6`�˖��կ�e~3/���rc�	�VS�NX�Z3(�?+��ݶz���f?�ޙ�=���w�M1�B�<βܕ�\��|Y��\~^�����?����W�r�>>Qo[���q��HR9G��Y� r!�?3�$��'��Q�T�������YB�4P�FY��� ���QvL� �#�ziP�3;��翽z���{����v���������54�뫦�r�����!�/�r2},��'�,�.�����b��S,��u�<�zi^^���6,#%�oA�oV+��X���T����qR$Sq��"� ���L�<'Iq3K'�"��d9+���EYr�&A,W�d�R[ȦA4���"K��,���M�L&l:�g�^<d٬`�`�^�0��1O&EZD��| �p*�+#d��`Yn,��wc��V�Zc`A �1���#��<��0
��@���b+��_��I�b�V��T���S�3e�eP֥�Z����`���doG׿�|)�����"�n��f�h,$����B��/��f�SwfO�O�ڨ�D�K���:G�C��0�{�|N#�zÜn��̓H�3n�W�m����O��E���r����-(c���mծ�ϛ�M����s۽Q4�nJ�4*�;�Tm=$8���3xA$!`���i�=��>��'$�)A��ҲaT�F��W�pe���o	P#A2��t�0Me,"i�J�5mG��ɨi#jڃ�A�����Ն5�ej��<MM�S9���e[��Rۖ�N�ͷ�.ߔRq5�i�j�5L5ؤ�RS,G������Rsh�9�Ө��iL?��t���ף�l7�mۍ��#;Oۤ�F�tm�Ѵ��'uz�O,;-�Nˮ�m��'c����KI6_|UB{U�CP�	�eR� ��x�4{���lA��o��=��X��B����(����W�B���b��R'�uRP�IG���҅�MG"k���{s}���6�`j�����m>/�Ԝl�նa����|��j6+6��)�υ�Q���_+b��=S�mG�Z�b�⍜��x65>b��Q
ULYȝ0�!�y5
�ʑ�|@�D=�~[}.�j��{����ٕ���~~��sf��gjْ��'m�.�i=^��\�#�+����z �>��S�Mc-N�=3�����Fl+���b�8�3w]�Z���Ɣ�F�v	]�Yb@�O���y�YY��(����g�wNb7y�ň��������;S�=X��Q���5'$����]��$�X�wV�%t{�s*E6u��;�91*W�@GL� %�ҁ��:j���9l��jEM�J��b�TsL�O�}L5
�Y�̂�|��,�I�(�8J�8�bd\�I���&�%A�y΋��&3^LÛtNoB'�ٔ���6�ND>M�Y���,��'A1�11�dy��<Hn"^S]��J�&��6�3+��qe|?j��n��W��8�zSl�Ǯ'���I�����m���PK�Qzj���)�*[�RmҁN�� p8�t��	�.�����2�$�\�Z�%G��X
Ր��6�[��˝�5������K1\�~���AW�meՀ����qǒy[Y9�e�VV�&�l ��N ��I��P�*���ǟ
�=e��@y���̣ ���̛�,P�ͼMd�v�0}_���MT��m�byve�D���CG � ���é�!��O��'+hBɣ����QI��4���p&�z��܎NzEG�&��i�f�����
c�l���ȹ��{`�IM{��������ۋ���o���I׺�����RS��ɦ\u�m1�'��r���7i�5�S��6g\J\n�F�"�J����	��T��ʡ�(k�:Ð*��9e�so�a �4��9���d���n�_�K��R��ы����,?�͞�T�I&U��B��2{�WhJ�/ȁ0���iC�)4+ns؆��͇�ǌ&�o΋�(f�Tm�+.k��NY��\($E��p>QD����sɏ�&	�3#$E�8C<�I7�-��"E�X�}��QC`�K����h@�c>�0���O��61�2���G�,vG�w)w����z5��g��z���?�L�m6ؗ`�����]`�����$M��h�J%/�>l�@ =�7bCH1�@�kO�>i �0S�,n�t1�X�������N��_��m���]9��:;y��(N�v�IA��?W�|=�~ y���K۬	��fg|�эU�<N~�h3@�	H�GG��;Z��W)� D��1Hv�Npk���c��?�Xn圸��=&�!EY����IH�O4"����dI@���s,����\	 ,H���#���`��#1OW#D�݇�x��u쨔x�^/�[�6ie������#"䃅��[E�UOp��#�q�xۤ87����Y���0�tL���	�E~P� w�0�����y��*�Py: �IQVc��=7)\�m��p�X�IAV!�a ����x]蓛&�s�D��4�l%�	�Y��D�r���E��ŀa�≈�懅Q0�A2K�|VA�,��H���&�)�,�ai:+n&�4-�"�&|$")�T���MM�(	қ0J'��8.n��u#�� �a�v4��V������^;��v�_Wk�Z:����Q*?n�Aw/�lz.�p�����! �BK�t����QA�7�(�M,�q}�6�'�do����p �؆��˭��^�V5<E�4	C����0WR�*o���z��Z����X;��}�n�4y�D�l$L>��y�BD�OPX�pIq"�����@�Ô��������43l��+(�����XT���EZZ|�)n���bپn�gG:��t��/n
�a$_�y~���I�-�&j��:��������L���
�������a�z�O�y��[����v��6a��J�2���6��޽�O;j&�V���|?ߕk|��1����M�y�V>�j9UO�r���:e�b�q���b[�H�����Ϲ���j���K�_Q.)&�O�q�bLE�E��?��n1[��y��3�F���(��1��P�����7��?MWr1yi����T�`�������yt����~ݸ�9�����٭�Q�������|zpM>E)�V]�#&_�g��6_pl�⻪�y�    �QG�7��K�W>/̀��oy-����_�E��,��qk�4�Y��y�w	��n�/��jX�w��&W�3��U=�M��T��d�o�l��7��w����ln#;�SQ�����Vks�T�^��N��)�P`�"E5L�0`oF
rh	�M��t�!�]lćr�6Æ"H�X<h���@6�!�G��$��v�ɴȦA�?jHc̘P}ql�/���U�P�*y]IG#�a-����s�Z�i�ږz�?�)J�3��k����P@)&Ee�Pp�S����#I�Y-�0�0�|M�Lp&7�L�{�'W��nn7_��SGӝ�Ø����~��^#<�\��y傓
�?����D�[jXǰ�^&>�ܝ�YCF��s�@��*:n���2��y�g&��ǚ�����(��2RМe1d7�.���'� ٧IId�l�Ĵ#��&X�����}�QuCR�$r�����	FX7O��P�����-f��$*
C�l E��`��!�ajxA�sF���4Vä�+�R�ak�p{��{���(ޜ?�Q<S<�e�($��~x��T4�IE���7����`���;�w�V���iM"���_��튉��*������6�l��|#�B����sy�M�!������~3�D��׍��0Rݦǋd�7{��F���ע
�v��{�=G�xs"���H�o�$��Qm�?����z�k��Չ�u;O�H4�?��UG����ft�#>��!MY:�Y�L���9�2��F���~�h��ߛ�#Q�|^����z���__��� lQ�*hH.r	���r� �$ԁ:�@%m&�.�z��;eS�X��,�yu�)R�2�� H���$?�S��� 0KM ��C�ʒ�΂)�����������]�$?�xx�@_e9ug��J
uf�0�I�8��(����K�)`\"��9P =#Us�`	\���B�U�Tá±�D�B�n�~js���G��d�D+�E*^�E������ךr���D��0I��|(��ƻ�����gYLv���v>��c���r��pW�>�]������j���?:��"t(�S%�A��P�]�,��_V�w7�V{���-��O=3�h�=�7�����&��ˍ%Ȕ��Z�p��?�A�"=�d-�md��w'���e}�ߝa��F��w�=C��0�}�L]t�����A>�>�ͣ��`)?���Z~�Z~�j�Y�Y_�OL�������p��Qd���i��IZ�i0��bZ�y$Q�X:	�<	�">�S�fa���,�A0�E�EϲH�L�MN��A�8�`�ME<�"P�3)/�"NY2���y��*H'7|&X����Z�?�� ��#Ɋ�B`qpY�.��e��;�H0R�P{�����X�5���R�_��Y	���Y�E|���NK�����%�޽�U�"�.r�&��\�h`�udc�ȋ���ȋ�V^Ts�K(Sŀ�QR�#k�RY3��#%?�g�%�2�m�H9u�0���� ��قEV��Ѱ_1���EJ�cπ�R*K�Nwǒڙ�O���,�X������д���p*[tx:[���JwP�L,�ɲ���U3�r!�X���ϻb.�y̩x�(�Q���O�Q�jx\�"�B�Ad܀XyIe�](��D�%nM�X���Q����h%�Qۓ#�5jG|�H sp�O��_>q�AW^�\��|[b�SĶ���&�#�|e3�*L;"��d�5�$�.�"q/w(��凧�
U[��H�m���c��F_i�E`[��麮<#%s�]���2�Qr�����"�I�&Rx�K,�B�bDJ��kR�,g��{0�B�s)��3*=���U����ћ��}�0�`*0J�)�J�l��������'�dCƫ٬��(�R.��*|X���t�匲]���n����I�܂��ݫ嬼��B)+�y���BN�(�Z�V�r��߷�c��J�r��t$��f9t��
Yv�+E��P�����t<�@�KKeOaH���`����9�$�=�J��"c�Xs%�����B�~�����P�v���N�������P���h��/Ɛ����|�Ww�����rs�����C{�����������_���(07i	�l):�QDKneKa'���<{
DG��jȑ,2�,�5z������;�J�q<jþòj�O[Q�%ݒ��)�5̘)�=�p��kV1`j��mY3P����t7@D|DJ�e>V��T��a��>�|�UV;�b=-:+�t�^p���P���T����R	�r.���$�#@�H&�r�䏀��=��{vEg=��?	|����p�q� c�G	 ~�u�%F5�8���q�s��q�sK�s����ǷN�b�3��9&���Dk���,N�\�f���.GB�b��|���{����6ġH�T���6��4Ny�t�����8�q��H䗛|9U~���\,7���Ei�FpFW�������Q!��B��<3�����T	�ڞ��}A���~�z���q�~��\6-&��E���pRE�u~��B��謅�?�q�����կ/F�����9/9�\�&A����g�r$|i�5��6�a�-|�$����Z�$<�]����\��fu�dS�:�e�P�4�bo�%��mQ�k{��u`k{[9��F1e{h;������s�z U�N�$��EQ�m6-/b���ē�g�@��HG^�y	����K+�$��BB9��%�k�Ly?!�&1R(��@��U�o,�IU_�� .oQ���Cp8�:��HJ�?@2�0��q8M�`,�q��p^D�$��"LX<�TTYS$�4�gEd1ϲd��IT��Mg�K�Yq3��iA4� I���ǅ�n�h�I�ބQ:�p��qq����H�&�_+�[=|%s�	������z<g�!��"e�IaFV� AW�bdK ��z���v�K��/�~�$�Q�Uo�!�G�X��T�T��?r��0o;�T�#e�6��ަe����b�jץ�z/k�én{[<R�MD
���G�7�7Ջ)�Ö ����K����L?�7%�"��<IH�@*Zc=W��x��8N��!dxt���H�N�+�I����\�[<�zs�?��x���h
��ſ���Ta{b�|�����i��l���@6$���!n\�`��r�/�[s�P�o�#���A.��z�>!Ee8Czz�K0��a��Aj_����E�:���%(�=|�Ot?(DCN�[pE�:豣���S⤲��r�'1�P9)N���}G�p"i�e޿L���(A�޿H����|��"L�䳔��x��' �
`���}�֭�
�"�Q5�6���3d�m�1!B�J����{IQ�G��G0�Y׋#�������u`�j[���9�2^5�W�ƫNw��?��S.D-���U����K��
�Fm|L�$s���;l9����zɰӳ��p"�#����p4 �V� ��2w����k�TJ=����˖�#�!w��R�⍰�7�z&���M�՚TDڒ FK�{���$�x%�=vY�}��IU��:���R�-�48�ֱ%�(ͤJ����:��P6IU��h�"�8�f��T�ؚ�RW��5�T�2�?	�c��]K�x���U�Ƣ��S��Ex�B����*�R2,`��+�>{6F��Be�����[�ւ�$���[��qA͉o��eZ� �Ĩ	Em�E1U�`l00�bki����c�ݭ6w6��)ҷ��I,}뻝"�"޷�۽U�n�=)⪬,�_����jb�9�rj9;kϪ�߳�����cq�
8�-��H��7'	�G}kߜ"�F�o囓襤N;أn��q]�]���Of1c����8S�O�x�v�}�j�S�^���O2p�N�E~^��E~z������Jw������:	�;��Hw������o*G�վN ���j}Yt��������K�j��7��@�ϔ��[2R}�E*�e�S)�(घ7[�dH1o�\�I1o    ������Xt�zN
��%��&۱!�D�+�B;�xӤ";���:�;�q`]7�!���lv"|y1c��|��H��f�[��,�D�t�~�e���@pF X{��"@�]�)n_����A�QN9����F� ��ƭE)p(SŉiC�\A����:�]k�b��5w,�k��%̞dI8m`2ݵv3��F�����3���8���G�����o'n���P�3ܷ����#�\�UƢ'Q��f�s�H���H��T��J�{� x|�_cs�쮂���*�[un��{��V��[���!�Q���YqC�DA��=]o�T�,Z���E�^���Y՚����Rz�!�?ϳH'e�W�z�Z>A/׾��c��8ZeD��R�3bܫ�0z�D����F��F=h���v<?���]�5UOx������U4WA���#X@Z�:�N;) )��Zi�c�8�}���IA��F6\r����>���NB�a��ʹ�+;��H:�f;9 옵��z<	�m̗�Dp2�2���`�(D�ImE�s�R~�N	* �O�5&g����e{��_����}-|�*h.e�w0ds}�#H����X��8���Ő-I_�ĕ�uDQ\^R�E+p�.�)���D��?B.�ף7�W��rG4�zz���[��k���a���h���]��l�x5����l���s!��b�VB�8H�� �n4ed:}�zs�Ӫs�.����mݭ�f�.�"�fW.o�Ң�#�s�]����_e�aN�V��&U�z�#��r�֛̓��[S�ַ/�Sω#(3��/�j���'� ��4֊����,�Nmaڄ&���8�йI�ǰ��E��z�H�s��cIB{����N$����p'aܰ�d�0|�S<���;B脠*+�����BQN�7�D�R������_�|��ů���o ��Q9��PU;��m�⠴y!b�Qo��P��jVF���
��T��@/J��Hr��/V�{�"�y�՘b95�� H���J~\�w7rC"U��nj2ê�p��š"����ͽ��EA`��}��$!�^���Ogb�����S۟j��+�BM�6���H���}��{�i�n��1��s��u��ޕ���vO�v�To��jo���'$�\K�����{r�v�j�Bw����� U�mۆn�� MkF�� ��f�i2)HS-��b!�+�$��4�R;���g����ԒL�������`��ޔ|]d@�ޔ�L[�Iaf��%T�i�����I(�S?q*���rl��ܷ����t����&$����W�H�)�	���3���ÌЁf^A�|��0�OO�čQ���g\F��a�g(�"�ʽ�a�K�Z�э��~U�(|3}2؟�濫@!�rm ��J_�����4��!p�Jvٛ���~����)�ϝR˞j�`� ��T�>g� I~��'�)��T�/BK.v�^#D���P��:��=�E�X"@��u`ˏ����@�W2��V�)�3P�S����t t�8�=d֐�'M{Z�T���qܬEA�֗i![���@"������C��&&�����g(M1�̟��Пl�1�r����^���Lu� �X��7)�}���aL�qZ_�oͭv�䣺��՛�b���8����M팢�U6� �� ���J��_W+ V������~�#�)�z2RYS[��3�
z�����DՍ����Z��a�YG� �Z��,ݤ�{�0����C�����GgC�+�}�Q��P�p���Pȧi:JP����5�.K�^��V���'a������MQ�$��d7����J��bj��8��@���-��|.���௚.��M��@���сKdS�o��v���B�	��3���l%D~7~Y]�}�����|����T/D>1�̸����fܸ�'���ڏ5<4��W��&l�v��w֮��c��@�Q�]W�.�G���-K��Q��aOC�(���e7F�'�Ȼ��y��BU��wC��!��]�b�X+��4J�T1ԁ�/�ؑT�v�XؖJJ,��JAh%���GK:��~�����+�K8�H���0�����QRYbwZ]8�Ȋ�����
=�fo�a���������Je�:C�J��1�X�eSt���T-����<NHU��YP�!�sW���Iu��Y����U;)�
Sɾhu�f�Р��,T'�*Y�Y0�I��Y8+G�*����/�
���P(��:
�-��� �Y�%�{L�f$�<�3*]�8�`B�
f��8���>c�a˛��L�ۇ�n8�Q��'e��Jq`8���$̻C �@y7Xϼ�s+y6��R*��Q����q����[�'E��>E��+%�a`�P0X<�0m(X�>����{"�w���?����ٯ�������6�kgD�ُ�_��F�:�,���ʤ	��ʞr6�]ľ�5�r ���d�XL�@�ѷ��F�ۓB��vG*} ��Q�1w.�p�'a��"N)�:������WM��D^@}��#ƿ"�`#�����d��qJ��h�@kX�!]OE�Vx��GB��l)=w��$���f�/�r�>���p��yL�W���2�9��m˅=HW��3�/A���r�^mNU�� 0�2o%6����	��[nW��sR5Z�)$A �IEi��.�t�1�8�#	�R�Z��)��TJ�탢�}#�;�®Cu���&(�Q7A�Y�MP�?�&h�#u���1�x�DQD�H�&��t�H����N6��H.��"No�&D#�Hd�vY�jwB˟r:�WEH��1"B�d��$�h-9�-�!ß����$Ih��;��IG������`Bɀ�JI��$�n���a0`x)��n�������e%~J�V��9uBA;����2�<N��P���Be����+�b�&zSL��m���7�d0�Z	) ޕ�o�V:.�7P&�V�wD�� �:��B_3�-����nπv@������΃�j+�����
9<��\?�����8N��O�+��?2^��f{�8�ct�'��Zn��v=;P������>t��<����O�H���A�8$�H
���{�F=��e����/n �˝������y�����UB�гg��Ƈ֏j�8��=�~��bxT���ǊG���'|h5X���o����j?-W����ߌ��o,Ux��G�@� O�R��	k�1IG�'�x�No�cF�-.�8���b���>���Y"��G��
"B-���h��ч��F��� sܨ�:Np�l���[��޽z3j��S����`�o�E��%��dr�i���~�o������ɰ{&��UO����@�eTU1�?�J�A�ϐ`�O
`�(�UQ���b�l^�B$��&�*���f��b I��=%��e�g�HuO�KDj��{r�Y��*�shs>)��!"�0�!�w��NM�Tܷtӽ��b�.�>īU�����m/�!]�.A
!@��秈����� d<39*�}|Tc��:|Tc��SC��%��5$n�&{����N�=Lߒ��T�э�F��h���$�t�`��$��t�$U�H���0�u��_�Rxq���s��y̝ფ�:C!$��)R�N��}�P:	w�i�P��".����C5��|)�RŠ<dä�%.���t�H�O������	Γl�BĉtY�.3��L����ޯI$��d�,B���P�okD�
y�3�F��<d�dy��E�%56�S�g��In��T�۞��J�30ؐ�/�z�A|*�T�g����{F���u� ����`O�W� �gI�ӌ�GY�ky��p9k���p9k����p9�u�ǢK�˦"{�!|Sl�Xl���k1�5D���(d*�G!�1�yJ
k�f�Ȉz�Y���m%7E��Z=�G�S1<Ja%����)�E��Z��i�{}_̋�jYN�!^q���YŠ�[1���Q%h3L!^q�W�������j��[=�GyV1<n�������3@H���{���))��    �
d��z���dZ�UC�p��Ŏ���EE�Tbו�Q.%Oy�rI�B$�������뮘#��#{L�AL6�[H�G�س�����B��xO�ʧ�ȸs�E -2�®�\�)-.Β �i�ru�HL�R�����ehNIAh��a�Ac)͍����!h��)�ˍ7A���0�z-6O֣���6��i��b��>�(*v�3NV�'l��'�.s4ǻ����G�1[�j��F���(>�O7���� �\i�Bc�0�e�2cV�b�Ҙ���pX�`]�+O�tp�b!r���f�OW�g�n��]�n*�6*��K�[׮�t�f'[�ɦ\����;-�i�z����F���ش.1g��+k�_�Ȍ�O��r〆idT�'1:1
GGðc�:�a�(Ւ9�ƈ��:kO{��C�NR�1
ǯ�80�I�iN�֐Bt������R��s"P�69/���"�a���.�˒���m��Œ�p@������.-�`V�L��;2�,�K���U�Y��^��Q�)D6������.��Z�1���cU_y^_*�������.�,��?\:�~A�1��R��j���y������Rq<���b�Y4��B�f���z��j5��wd�Y���Es<��:�u���I��
]"�q	ç	Q*�ͺ�� �<D�`*Y�	RR-���#F��)R�:bϞ���uGy�����i�!�B`4�kRz�ӣ� ;DjQ0_ݮ�G��uc�Dd:��ûoG׿�|�������G�n4۬�r��H8cpz���Y�]?#�X�C��-�	��)<���m�����0���o����cOU3��#	척���!��1�Ր � �	xeG���� �B�Q�]���n�߃!�U�**��S.ڑ�����G�]���8�M�����GL�~"I���w��T ��)�PB�wS�T�H�W�7i) ĕk��E`Hp����0ԲH�N��aA��x� /��Tʒ!��YOk�b ���($�mC@����h1��|��Q2RA'GRc�O�Dŀ�O��pl�Z�"Sd�4/�Z/�AG����{�z}i��8���V$�5�����[��$�Ej���Oe��~���tBF
�q"i�wF
��[X���2��(�(�(�BH�6��$l���(�@�%��8���G�ń��1jE�6�I�;(#�߸��M~��Ј��RE��ȌR�B
-�HA5�$�=�2B�`D�j29��ȁ(�H��)Tƕ�#·��$�#BɈ�㝓F{��Ώ���W/1��oG�ِ�ާ�Ĕ���QйO��}�٨�S��Z�u��uu����C�r��z���:���Ѓ$�WW��z��V}��D
6�B�N��y�5�@ �{�قp)�ld	�#��B�V)�	��!=�r�A�B��˱�`�V0��.��E[�`��#f���V�������������m<�v0����6��o��d��[7�0*�H>�$�1^�fEU9���]��Và���n��J�|�HO�'D;�9x 
.������9�)�R�>�ElX5D�/�h���#�i8�:�j;Y7$x������~�_tCŁE��भr�:泲�!����:	ǵ��"��f��:!a"Οr=d������Ac�]Π����x�a��F����!�";�fCF�RT�U+tҪL�s�?D	E��q �0�k�o�
�v�Re��=ԍ�.�,;��!�zc�`: "#���F�Z6TGBǸ�,APJJ�z6�l(�`�taݤI�F{u�nH�����[?[��q��1�{�m ��0�Aȓ��H]��e����8����,q,�-���
O�yt���.��3+'e�K�bS�%Q���Wه�t,�]�h.�6��۝~�ћ;����Y��:���ns��}xw%�ͻu��˩a�՘�ad�j��Z�m�D�����|�PH�~�)��x�(����t�u����b?��I�5��k�l��rb���+��jW��Iu���ݍ�E^��n��ټ��W�2���YY��	 Ey��H2y�i~���w=��O�w������n��y�8�e��˪���+�>y_�g�s��AO����Ҧ�1i�۔��@́��c-Qΐ*׸2�r�8����b�:����6؊�갢8��7�SpTT�6�ʛ?o��GA��o�=$Ï
���DR\�5��Qf�Ȩ-�=�u�˺�H;|?����GhJ4R��5�8)�ǖ�q���c���Y|���&7x�!�AKs�i���0�؟.#v7R؏=G:)���ka��������:�[e�Vz=�,�2T�P7$B�P�h�\.!Jh�w�~����:x;	����)��Erΰ^B�(-��"G�iF���B�42	�kg�A2�;x<�|�a=�N�M��M�H
q$�1;h��n����f_�&�{�@�aR�t���6�֤ASv�p=&�8�pb���3d�Y�l���&�6>lU�n�>�/��A)`�v��{���z�u�p[����\�C��x���l�GkM�l2��QE�I1����M1����� ����]��(�$w�~%���Q{�w�P���ߍB�7l1�n��EK����~��(�Ű���(�����Di�<x��3|�euO&�t�[��r�t�7�����p�����Cl~�>��2(���K�_m��a�Nt��a���'�I"0ǃ��x]�؛��eq_탖�q���*���f�N��l���C����';ϳ^� ����W�a�Qt�P-&�:8i4��R����ҫ)���U���`��*��> ;��a��k��lC���!�
�>��K���c�O�Ӂ�LN��3�f�98p�I'+��0�$>�5�Ȓ�T95i���~�&�.��hr0ߺM����<�irr�kr�E�6qcq�@�%bu�� �S�
�XC�ٜ}�;D`j	�� t?pS��r�r�*�d5�Ű�ӛ����Q}��՛�b	ka?��'!O���%t&��rg�i-����,����� ����¸�����#��SFnwsp�K
��o����M]`�MI8X'K�}���a�pI~�n�Xo�� �^��h+��P��[8����h�z�J�o*k��sHI>$ծq$EH�lPS�IG��A8���u_1�k��Ť�?k��記���oe�]�{�I��:*E�w{[��<Ðh�B�TH����*��?�RԕT	�X�SN���}��@����%��_T�?q�Y�a��	緯�����%�"�:�3tS�c��~l���׿�z��!2J��62ΐ�|�]����f����Ow�b�d�Z|��15{�����������Bu���g��6�Z۔�n!uUPTY(��#�����v���e���_�&�"e��oj	\}Q���˷�G�d��A��;�����v��غ7n�T� gz'��������'R"ń��Ŷ��%E�X�S��@k.r�8[���9֌���OĿ`Y�Lj4����\q�A��� �?
���������_����a��o�]��o>�3���fOq���҅b	���ڐC*�d���s-�);{
F�x*�����Ke�P��u;��+�ȇdx[W�:�&��Vf���f��T�t<�I1PȲ��f���@A���dO��H�ٖ�H����'[
767R]
��W�`?�����)& �O�8|��R���2�ߖ����[��|�^�:�`���T��v�_����]���|�[X�b� I&g�?٤�J�����C��e��褐eǈuOH���f�FU%��e�ᨹ#�M7;�t�w('W�U��=-F��-av'`�k�#�/��;���0+�3x (\g��S�$�d��z(���/�/)��jWt��K���rm��F�z��β��?�ۊ����I�+�$���T4jo���Hc;�=P�����`7%7S��n
|��?����f
<d����z?�r/������};,x��+0��k����a�7Y�ڏu����67`�,�؀��    jl��Q)��ջW�Ǉ��j��W%x��w؆����:ؿ�ú��S��M|����3�M��Z�M>���!������I�}h�&m��S�(`h����`�Y�H9(����jk�2���bj�*D�� �XRx�E���I	u[<n.�~R���Rp�=����qs���l!Usr��l���E�os��������I��O�x#�lB�4�cd����_��Θ��\j�.��M
+�e��)2P�"I���&&>}�����Y<)*O�
2p���:�"2�6R8��%��y�ˍ�� 1��>���3���\�W����z�u34Ç8�(�H���RT��T/����:��1A�s���@������ F;3�*��Mvnd")�Ί!�q�J��+��'*���H�sQ�y��Rf���<#�TF���;�����Rj��,|3nKn�jWM�T���\!E*YC��N�T�����r��-�$N{/�r*�z/�rC�Nx)�cz֓"{,�U+�~->{*�-�k`�a�Lc��4Ȋ�$`A�Nϰ��"�Yt��k6�����,��4+���!��.!ͮ#�g�ő�Ӂ�b���ԡbe������f�L�,L͂�:���߉����!���� ��&U,Z�ٹ0u�$z��hQg�\6H�{,!��[3���g�z%'�U���%O�P���=DYQQ�ZQp-%��S0~���Uԁ�g�)�����
�����z����sQ6��ZE"G
)�ʁ�c��ýI!�f���"�)�݁���(�;E�"��/R?�gy�)}ށ"��Y��:�4C��`ي�E�f�J��]���"p�)рo��&�syH)R��R]-���v�Y����1$���<.�H(?=.�H8���L9m��Ӧݵ�D)�$e�b���(��!aIv\v�g�?V��v��K��&�KA�0�ǜ�c�(Cҫ O���Ĩ����5I���)��H�%��d�:����L�Y���M�X�1Չ�Z��و��5	��C��������f����Xi���|��,4����XQ�Vd?�����8t�@ơ����p�K˥z����,�Z㺶�ŹY20����������+bp�M
t�Ƙ04�nxD���~{����!5��i��>G���F}�����uҳ�\���r�5y˪?W���l��n���@:%q�x���/0R(��LS�]zx�:i��1RuGW�KF��iy�ʕ_��b�E�m�ň� ��5D��6�E�?�r���� �fcDK��YO���v�$�3�eqp��.z�)��HA�Tʇ�Ck�������[1p)���U��TO�r�.���<&1�=� ]&�=f�( �=�*X��>xt�ԅ�1F�U�P]h�2F[��� ]��z9��<m�/:��d�Kh�vu����#jqrmn��z�c����NN�ܮ�p������˷�ǋ�r�ъ�#վ�%mz=d}Z��6ajF��uei�W��+Nɬ���C�����+����
��Q���vR�8��S�DV�3R��3}2�qzm��#�6���a	�J�lT���Ѣ��Řא�GKШ�|)���+1\c#Zญm*2�/Z��rz�;�b�"I[F���d`f���+W���� ���+1Z�Bň")����"����|ȵf���h�=k�4<�H���G�v)4��S�T����D	pa��Gna�:;wY��.""щ;#RL�U+��J�Y""=��s�
�#
B����+�:[S8�<(��E�9p�|4G��]*J�~���յd�T��]�9W��D���Tw��~����"rx�qU�YU�+�~j�)��X����~�ݍUi-�n�2O�q����&���S��t>���j�E��䫥�ӑ���"pz�b--���N���bb��.�ǞfHy[Z3�g�H��,h�� <�{N�YM�]&��L����>[�8���U��:<zp�ʂ��܈Ti�\C�����:���Πa���Q���8˲�I��k�
��(��xҬ�ĲP�?>�g�ܱ��>^L?�ͺ�gg+�6j+�`�|�ꦆ�ºbҥz�c��z��y�Ƕ焏,ц�M��0��}̻���f]�������O}�&`_7&�կ/�N��u��w'��ϩjʘ��#3q�@m>��RS����V���ѧ�e��a梞'>��6�����5\a��D�9��⼶���-I:"K�&F��U�Ç�����ѿ�!eT��'�[3R>�IՃ	RJHڐIY1\0(7H)1\0hf�>œ ����#��.q8xI�p�Sp�p��0)�{�)��Ewmth���֑�.�:���E�-NJ�m߼��r��q��G�Z�\p��7��u��~r������P�>z����8;v��M�
�G���1����:V��<)��̑�*��H̒N�i�S�/"�ڶKG^j@"#5'�^j@���^j@F���G�Y��I�d��oΛX�(���+!���z�Y1tC<GC/�^�@V��f
�Ԕ��U�6����ߛ�b�m���q�He[�C>�R-�b�D��J�0��X$2bc<H�!��#��a�H��[1IWJ'R��5%G6��Q��Ə�8d��%4u"/'C�+����~/N�Z�T�l3����"�T���Ƣ)0�91���Ƣ91r��Gs{҅�M�n2l,9�� �*�LхDN}cOJ�D��ITUÞ��u8)�ȑĐT�޽���oG/����]��������$R��#	�)FɑđĆ}�р�W?!Y&ٓ�|���$��rj�$��a<����_�� �4�版&�J@ʁ�HE�C�ր��~�>�,�$k=��3$��s���sR�5[�0���>�Ou�I�Ӭ(��D �d-��iVU}�͞�֡�������� �@�J*f�К|U��_ɒ@Jӆ�g>]�˿.7�}>�~�[;�G9:t�<�+������x�p���,����ξc�=!�N����zt��y�������i�~֎��Y苕��կ/��?ʵ)��m����:UIݯ��|y76���meƋ��h4j����C�Qlu�7Z��5�F?�{>j��B֨F������(dYj���+��x/�?\_���%��m����O�>���������}��<�,~c~�t5��UWSPWSHv�O��ݫ�����Fu%d�i;��jҶx��Pn���Ƣ�*|����3�U��$�|&{OC�'U���Or����F����f�Ti���fB� �^�T��LCj�}x���yX����R��
l���>��<���Y�FFs����� O�8��֚����fk��}�a�kF��,9��֚�҄�C(:<���҄�+/��gT��\����r<������ţ�uh#�3>���a�|aD�W_A���s&��E/Nk���V��"a"1γ?�"������e��,5]"���\�v-L�՚�.;��+�b��P8�F칆����a�P-X�����|�'*�0�����ƞ�e��=��Y���S0� �T�\Cs�rRDk�(��*5Ć�_:���5g!���5wnQ\De�[3�;����PG��1'�oYC���u�����Э�j������/�:l}T�N\�|�n�|�>b����h��E�00�����:b�0~�>����Э6�G����D?`�8sh3���(4˔}�0
問��#��yn>�a����s�k��@����>��>�ax���m��Ȅ���O9��1�+$�[r4gk;)@�͜���i%��j)ZʱQ�P�c�01� �8<�#�վjV�,R���s9=�Ye��%F��}$BR���GA�G+
�9R<�K���;R4�u�a�	��O���A5j�xj�K��I�`,�����O�`��b"�G�Zk��P��V��!~�L�@�������j�� ǚX1t;����?j�!Ï��� ��39b��N2�l'��y��z�G�I��#���u�k��y�J����G��\3��s��:�5 *  ��<GˋOz��u�#�{���u��.ċKz��o����K:0"V���<�����϶��{��2"��<�f|8Iy�mZ/��ą^1<�s��p"<�s`��.���3�#3Bx`6�^��*��,��9d�M4)�3K� R�^'V�]�$C�}f[�$�@,P��"��lu��Y�������\�I2zTNk˱r��;6���R^p���n.���ty��I������'�B�Ј�Z�V���8��1ּl^ҥ�����^�/��lWl���.r,�x�WPaS;@W�B9�
)o�b��~�: o��ˍc�r�?�A�d�'V��T��TGI�_V�w7���j>�_��i�^�|b�qG{��͸q��On7y吮��m�����n�Ì'-��]~����+����'� �JRY��ՍŌ��;i���wҎ�u�QA�f�"A�e0�O�������{Ҥ�!�;��I7��'�I�@-W{N��IQ�s(O������G�{�0���f����9��>��kH�/k�L��:is�j8�W��'Ϟ�V�c^N�+��$Jk���A�t��o?��O�.�X�yO�ۼ�JCQ��0��԰̵J��Ю��sѼbn#����ʻWoK���[ȴ6��7��@��˹����N���f6Vp�׍(C�a�mzu��s�6d���(�Ժ-��ڙtH��eq�GƗ�� t�.1�'i!6��a�H;�Έ"H^�ɪ;Z�Ƌ���G�@)�O1H>��P7�ɋ�x�w R�#HN��O��|$'R�f��I�!�D0�
��%B�o���B���F-zH�/�i:��D����%7�q��� � ҄w	�w�#h��ݜ9C��v�RѽymA���%?e�&y�@��1�{�F��$'X�>�A��y�G���&%v'����N���.&y�:qp� y�R8t�`�����1K��^[�.�8ʜ��%�g��n�$$OZ
ǻ<@ɣ���.P�#y�R8^��yaL�p����u��iK���MB�C�ui��I~�Nl��օ�f����_-�p�@g3|��������N$���E�w��;tH1?k�wD��3ٔk����f���;Y)o��e9��F�S)']
��2�QT}طg��@�A1����p6����HڶA�Bv#i������K�Gv���H�I��:'~L�KvyC�YCH��n$�jI�Qv$�*B�Tv#a���l?Ln˘�w҉���������+�m�ބ�#}^��,?{V���c��v�jG��>��+]8��|+�����I��.b�A~�A�C|b���SǡYL�tj������o�L����X� ON	*�j��[vp�&Oe���*Wl���z�F�n�W� I�R��.-�$C��v�������|9P0I|LҎ%	��`��X`�'9�\�����$&'|��܀��)N�T?��Xr-��;I�j�C�C� �AQ-�� �F`+HTm�R��ډ��"5%��b��z1�.v�TCȓ9��Dѓ�'�2;Of�ۑ�d�q<@C�F@��>�#���o��ԿH�6�0�e�a��v�n�U	��1L�n����d��&��q������d��&�X��J?q��-F�����j뢩*�eU���x��? x���vd"y[P����o,�ޘyr�|ɉD���߰��6�c�ǰ%"C�g�� �$0��8=��u��~B%�t����ׄ�m�P�	"��J���#(�q"�۾��1��4��J�C���~Bӧ�?̗���8{���?�z��H!��Y-!�hY|�Rb�� q���|[	�Cy3����(Q��%J�n��l$�(hH��)9�ו��d�Q����Od�s���[����-�.�%���-��|�-"�9��W�%%���g�����Gڕ �w�.-n��|��Zb�wok<*N�]�n⭭�����-Q���h�C�~k���pk�����}%����F��������chLb�
o���� 4:!�����!U�.1.;&�t'!�m��h!Ҿc�O�w䠬���~ޅA��<�p �z$$�w�a���į�;���7!��;��[�b;��'ä��&�f1L��N:�$$��u~�, 8�Iߖ��M'����7W��ۋ��v&�=8�3}!��!`��&��g�����$5���\���r�E����8�ݭq�v�խ�ޫ��d�C�����5S��%$1��~�V��Iߒ���W�_%!��;qP&������ �uZ���%B�in�v� ���Psy�s&s���b��rΞ0[˹��k';ݏ]� A:�[-g��9K��LH^��ۈ��@Jn���%yٛ��B�~�y�����w�Ϸr4��O��-&ʙ�e3:I���޺�p��[2�n���w4�k���w `N�d����݆��w��n�����Y��XU��y�+1X,��ߥ�Ηw_�����u��".b�B�)��R@Y��8�N�ƱS�|ʻ���s9�5�Z�S��rS]z�X�Ww�w�BJ�{�C��M�Av!�K��B_\헻��~��K���rm��ri:�l|5 ��~��m������M���X�BY.�?��]��sp�-���ͦXNԣ}x��p��6jz,����\�ƕ��|�O&�p���/e�~.+[|�r��������x�ڕ�rb���i����tu`���cl�$�R�V�M�EѸb����H��������i~g�-���tzg���
����'c�������ǫ��?��;lC�߭�ݑ�/��M._Ҥvz�o>�d��g�/�s^�s��F�����kPy��=џ��{[���mʉ��`D�9�
^|`���
�=���As4A�#	-�Ď<Y`L�$��$h��0)�;	Z�&A'���*B�"�/�"��Z�!<�h/�$����
�n�%A/Z�N�3v��b�E?�8fq|��]�b��v\|f�V_����� ��T���HRq�H�����SZt�G�K�B<�d	�K�PO���YA�q��>�d}Z�R�C���M�V�	�B�V�	�R�V�	�:(�&�H��6�?������5]5�O�	�n��K�h��.JZ���:�|���f���
J����9��K
���n��:���D��ĔojIȐ�KQ1��i�]vD�eG����b����&x��Ga%,=9�H��))
چ��*��r��E�`�X�-h<��k�XeA|<_�>�췻բ�l�A��MI�
�ʶ#�SZ�97a����m�m��MiU���WaO��)Tf�}��k[!"�D�#"A��hvD����uL1�S#���r�x&?�K�Z�9;����svLɝBX���*��*sF���
]�2gt��\��Ѓɣ<����2yȉ���@Bqt�yL��'�o��;��Pۉ�`ŝz�kb��A�0r9%�Fp$�6yMu@�ZI�q��%�H^Kc�<�Kh�<�F�6��/�A�Z �I�ϛ��m˅w.���%��v�V.�YاPp,T�\�I)\�7p���������         9   x�3�4 B׼����" ����X��D��T��������D������(�k����� &�
            x�3�4����� ]         `   x�3�4�tN��qN�+I-�4204�50�50U02�25�2��3�0775F�21�21 �a����(x��K��KM.�42�431Z�@�@�+F��� >��      �   �  x��Xko�8���
.F u��v���MZ�8A�)P��AK�6��PT���{.Iɒ�4��`� �x��(�Nj��M�(�2��b{aJ��(3e�L�&��݈����۫�lr=M�z���^�L#V�
KkU;�J��V��h깾)H�$�Be��h���lE� 猐�S��x�L��h��z�\u~v6���U�����K��*ڱH4U�{uc��`a�_,w��nVrWN�JS��dA���R��Ȥ�O�9+u�"{*J�i'���!����
�s�%_�F+D����Pe`��;8P�p���
G��ӹ�>�IB�ś����x�{.c�ml����(k�r;��U&{�A���䂤�T)���C1"y�FЫV+��O�Y�Cԥ�Țה#�cݚ]��2�����j�Y�s����q�����)�4S%	�3���j��HN��0R�G�p0�����C��� A������j2���MX-��=Q�c��\��R���8�Fk�D�
��.D�Z$f~��9�?i�Y���O�<��j�nT�a=0�=��6X�*DN+�����zm\W%'�X�T���F�w��"Ҿ�2�����dTF,>Y�����5\٪z�B�2�&�WP�7\����4E��qϦQ��>��,��PD>���k�㫅�Ck҄����bU�)��U��`*���hϘ�*k*�xZUML��: 3��kŖ���c9�a��|=���j@��_�)ع6:����4l��B�����u����G����m |����5�V�n�佘�a���\�$����]�t0�!�R�;����S��;��S�d�����v�$��mrv�X�9�L��Jْ����y���k/�?�˙k�b<*�Y���1��%�=�������[Y�7��t��"v�%����~�{�	��)�����u�6Ux��_ϖo#urѣM.%,�!b���mL�b��,��9�Pz8�c��G��|QI˿�垬�������x�EL�W�����u�
�
ғ����x��R`��'����H�\_`�B#`L���n�s�04P��$.4���	p�`fj�����,�4��{�XdPn(? ����n0|����*f����[�X2�2t���5��/L�0P�0��m�����Ҋ6å��# �烇=��ɕ�rW�����(�V���� ^�^~����U*N�B�L��V��D�E �dɏ�\@�w�zK<�N��Y������:�:Ѵ]���1.�5Ue�3/!~H����)m���
��SO�kJў�-�?��@�$�;��gΑ�������Xţ��qn�ɵ?��3���9���gk�x��n����E<�:�b�X��K�)y�-P��zӂ��b`��F�H`���"�1i����1�Mb��&��հ��B�[ޚxA�e�ۡc�J
-~��@积��rl�����z6�$^�����I|�Nz��E*�$8�!����׳;4���ٵ��>N~ �3)��Px��+L�Ah�Z�{�ė'Z������w�a���!��)��e��+��'t�ҁ�B➑b^N��}�|j����0\�M+��W*$��oţ��m�G���}b�|��p��<����]��6�\s���֯øt�& ճp�8XO.�g�ݗr?��۝̿���0A��岀W����>���@^�!͝���ŋ�-�'�x��T1�P��0<�� ���ŋ���7      �      x������ � �      �      x������ � �      �   �  x�uW�r�6}��O�d*gx%�͒Ǳ����L:}Y�0	�\��*}��:���9����7W���0zo���q)����1z��?XۑGΓ8
���qÞ�������A�3��F�'��*EN�8A�����D!(8K,*X�������%��D�j٣�`������7�v��9�EѣƏdD��h�D�Ӱ��(�"������)y�f��ؗ��tx�)u�Q�R����l�2W���C����a����Ʊap?��	j�Q�4�jx�7ܲ��^����4�����ӱ3��%;N��.�y^�Bvƛ��߿k�I2~M�åI�0�8�5�����s�z-r�P���8�"�Yaۍ�坒XZb�1\x��o�#'�K�3�@!O �L�����1�rSfd�#82���ܻVA����L�G���LȖ^p���+&U�:y'��G�R���ƼB�;�����!���\�H����΢�����ߙʱ；�m$���C��J>[���]���os��3\z���:����9�VEi���$�����d�ؠ�:\�1Y�C3�k�z�����}U���ΙΦ��+OݚՅ��׎c�}��u�^h;���|���;�f���>�ۖ��|b���	��rű�߁��DC�i�a�?�g�w���#Z�T��
Ų	=��f�������1bǈ\5�L���m��墭�!�<��c���冘��{�p%'���|BE�c}�!�^�>��E�g��ȟ1������?���)�	-�n'�����Li��5��(���(s��("�ƒ���h����y9E�z+۽<��}w�0�[S	h��i�rʏ<��܌Oa�3�힕�+!��%CD]W�4�,!C�nu�پoڶ��=�*��L7l����<�󚖎4c�`��Q@�Ը;b��:�}k ���q�,=�ُ� �ƌ���4h�
�`�]�ܸ�<L�0�$k<�43�dF�C�^���d��pe�;F��ܧ+l֚�B�����3��g�򌫡��An��<�)�&�(�KSp�w���p�P�L�'�NP��b��D!� ��Dq��^�H����+UH��g�FuN{�a�k�z��Ba��k������s�ɿ)�(���'���1�)���Bѯ�vۜ/=-ת�]�v~�G�
jJZy�����:KO�'�Zx�;��r

=�=�'65;�l���Z�����`l���:���/�v7Oc��cr(�נ����!S�܃]���).q&].A� ��ĉ�e�b� kr��>B�$]z8��2�}���ΤV��c.�6�SWj��wRu�Cq
eS�"��d�);E��{9���d5����3(pkf�Բ�¬K�klp�����}�٧�н/���O��L��s��W�}.���Ĵ��og�f��U���5�.̡��j��,�'F���������?j~��      �   �   x�}�M
�0���^������
n
�
�覔�b5�?&�.+�2�o�h؍�]�z�d0�P�|�Xd
��R�R<��SR�|�g�*1�ġ]�q�>�E�h<���]T�T�*�E�BY���81���Β�F��2�K�~��~��.��O#�\Ԙ\���u��ڡR�gfAh      �   0  x�UP1jl1��N�x�$˖��ߤiҦ�%�����8l"�@�0�����+�(UB��PT .4\{C����BaPVdP���JE�wY�PQ�Xl��bF�u.-F���e��b�"ϙ bj���%=� ��S=9$窘�w(żCޱ��T��g�YR�8u�^nI��(��+H���.�'Afc'���D����SsF#Ё[A��L�T��#4^�k#���,�<m���Y{���?�����Oϗ�c��˾:������o~���ݯ�Y�b�\Y+!��lo�m۾՛v      �      x�3�3�3������ ��      �      x������ � �      �      x�3�4465����� _�      �   "   x�3�44�2�44��44�24�44����� 1:�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x�3�4�2�4�2�4����� �      �   1   x���L��I4�LIMK,�)��,��KO���4����,��b���� ?��      �   B  x����n7���S�����8B��S�i/���Cm� �gV�nC)��X��i���u�}���g�=n�?<v�u��������i�w�� ���'�=��5q���ݗ��y�r^4匔��������㯇sڃ$f����&p�SI�k��ew|<������������s|s~��1�QR��_6}��yi�����<�r��B~�������h5���6�ϸ�����J?��?���|���9�6���i���lHl��Gf9kA�YU�A��k8C`.N��,P����]C' ����P�t�5,�T
�Ƶ$�������?����?_-w���������KX�;ӳ�eKY��p||�=~�ml��$$�៶3]W���x�#4��G�]��=�{<)�0kC���T��)+`V��_��h�B��2$Q#w�%���uy���$��ƞ��#��Q��'a�8@y���vހw�����yH�T���2����������p�ެ�z(�)@u)�Zje�1��)��0����%Y��ӪbI
��F8X#��?�
���r���Eiۓ�l<WJyfڄ��3Mf���z� l�<�G<YH����%@�n�27��Z&@k��A+zF�9OM�mnU�q��Vi%�,��\��{�,��ٮD/f���r��:�p�(GZ%�t'���A�?7��l�-�	�Ћ6\(k}ʓD@�cJ\��j3�F��gD��Y�p�xf{>��+���=>�<X���z�T)�O^�[�I����9��)d�;˃��������2N-�e�[oF"H%��`�L�XS�`�$���nq�(��\8�h�l�.I5^M�O��!o���w�� ٫/2A���*��������-0v��lf���d�x�KJ6ʆ��@;cE�Y&�pyE���Zm�����Hu�\/te�a�gZշ]�"��m�,C-*Z\�,/��lӥ��M���i����%��uC�\2�V\G<^#�H=K�b�EG��c�s�T�i+�Rh�j��6�p�|i 	�ϔۛ����=ެ�����2��U�mRɖsSZ<
�M�K���J�2Thd��Q���g�R�褐�����e�B+j�nT��'2�]t�.Բ�2��KoЋ7I�u%�,Q�b'�F��o7���3�M�U3����h`#��ڵ�Bez�ߣ�,�)�\m���j����!�~<�Kmܳ��M�n|�#���MK��e����t�SۆI�����y՟pyeC�r�Z\�l�yA�Y���9��~-�ʀ�^������@�&T�-'P�z�:-��4���z�e�y��5Vٵ���A��X�Q��T��*��b�/۔���Q!�_oU��n�)���ު@զ�㍖�Qe-ɺ}�q-����l�(�F��*�S,�k�2V�����>\c����_oU���%Dah�z�e�LE����_��U�.mT�7��G�}5�_�Z0x�o�`߆j���+�]��+4�ߓ�+�=PX$J{�v^K� �\���Ai��Q���
�7�}�U(65�k��Ҿ�Ҧ߯�_��� ��}I777�X�Q      �      x������ � �      �      x������ � �      �   r   x�3������҂ԢĔ��<��̢��Ĝ��ʼ����\�|0H�$���QV�����[X�؜�\��ps!F)H̫���3�'��$/17�2S�8͸b���� !�3�      �      x������ � �      �   8   x�3��CG����y�\�P��̢��Ĝ��ʼ����\��0�T0X�+F��� ��      �   $   x�3�,.-H-JL����2��Ɯ�ũE\1z\\\ ��	x      �      x���I�4���סS�ʇ�1��O��?GDUS7#��(*�"p77�u�r����3Y��_>~�e�����>e?.\�V'���W�MZ�r����DƼl�������zG�����j.�j$����bS����e3������Ǹ�;�΃��ʱ��bO����x�/�"&�����4�r͕f[ȩO�>̓���|��w��Hֲ���h�5Imu�S�6��1}���r�b[.�*��_f��s�̸����}�����ٷ�Ҍ>Xہ_q�6��aE'7b|C�/�?J�W
�˲��(m����3W[Z�r���D��}�5��ZJs��|�#���[�et��A̿@�c���4��G�#�\��1�M5��l;����+�ONWoޛ�M"\J��cl3�\b0Q����3���O��bb�1���k�]��������y��"�+�]Bu���J���%Q��_�5e�+�/g>N.k�]�˘<�x�R�Fs�Q^SD�0l�*ݛVmĹ	m���k�ч9S-�)b�����Oy$�٘����j����G�Q�k�p������ٚ�:��fZ1�D���_SD�%�c�U{.�QL��XE`�>�e��ɣ߈�)��p$�Ǽr��Sbjkk���L�{�_S��e�'�k��}eZ?l��쪁a���p��kʀ����D���.�0b����>��I�33�5e@,����aQe�d��]��;F�Ba~~tx͘�e�򄋗�ZN�e�~^�v�ƈov���A|M��h
s�~T�2vL���d������ה	Z[5��x-�x
��	Fnי���5e@M���P'���B�e�5�`���nb� �"el�r�C��2ܚ��,LwN$�p�Ĭ���{�2���?�\�ـ��\7�8��NGYh5Of�~�_���L�&��g�Iu-S�k#3�J�T��:��4��X�������	����5����^8O�E��`?F.�r����U��ɕB�U��/�H5��:*�5�K���Lf�e���`�3[�yb�S2��_���݄&I�z�-���ȣ`�nq�H�̬%%�bL��;f�L��)��,�"���r�Q���G�ӱF���%��}O���E���1^�WW�.�Pk�f��(_DGR8��H#��p���4c�1�I�,GE��YW)*,M:��H��9�c��]��!���֫�0��Q���ґ�Ј(�?+dG6-7�j@�!��ZyT�5c������$f���~��� KS9�<��LT�`�&���;�x�C���#7�y',;Jf#�הQ��'�g$��T��U�I���b�;�ה1��2)����a�3�A}0-���V�A|M\�RA/�g�P7���\r1S�P�w1K�)�<D�v��e�Z�k�Wr#�&.�!�o�׌�_�'"�"�EA0�͈H�b!�6��*���ה.iVSQ�Qj`��H\��l�c ��-2�kʀX�_���T�D-��(�`ܢ����~�2���>�(<�uԜ`r�hN�#f׉X#�OZ�_�L�`(�)��\'2��xg|�����ϯg5�җ�@G�cʵ�p�]r�Q�̌�_��d\��T�l���I�v$�>Q�W��X\��!�����O
�ݫ�5����S5����s� �':)���TJ@�	%��V���cX�ǚ]+�奓X+̲���#����v��Ōi�ǧ��m]F`M;k�$'Lh\֡ⱙ�v�e�s����,���+͹�6���uK�>{�Oxm#>��F�'�\�Yo]0�D#1��>�Z�-�b>���v��F����js�����B-��
�l>������f0<�@�i��`ʍú˟�/s��s�D�k�c�F쓨�&W�HBX}1�8�^�A|.QyG��dM����ɶ�B�{��r͡*�*by.Q�=�Cy\PVh�#�g'��hST�g}ES�smD�;��#�El��8��� `��v�Qꉞ�G�)�w��
�W�������a��:�A|.Q1ijE -)n�K�x��/��*���8��)s ��C*�M���W��7�`fxUgt�� >��7���,
�
_��`��Ui�*U� >g�Dm�|�s@�l�I�8�k=�X��{N�Ǥx\u�c�ISJvU|הb��i��:�9[�W�VV���Ɠ�K���u�c��_�%S ��H\~2�aJ�x�RR�ُ����μfK���>6]ч=���^�rz�=�h��&/�_���q���6X_	D�[�����$�\C=��ϯoI�zy���A+Q2n�Բ\F�o���d�M��?Oy͠�BT=] �[��`4qs�$%���Bj� ��P�j��t�y'tY�q�^��`�d�~_S����\������I��`Z�	�a#�|>��9�7[�5Q�����+o����']"��u��k�4F3�i�'��C/��� y_��� ��Q�� ��� ���&+���LEj��ck7�/��g���[�0���t��bqȍM���"�tu"���
U���6�	�E�b�n�_�V���6�he��L���{M�9D�}��ZtT�nW��L���$�ͪ�[���	�������V��B�S�$I��T+!U�7=�o)�@` �Lk�ux�Kh˩����SY(ك��2*��L$��<F}{�I����F��]�xW�[�(b��q��A׋:�`�@��쩐��eڷ�9��u�N&dY�0E�Qq}d;�Y*��[ʀH-��2�Hх��kD��"t:��d1A�r�RFE}:��Rǒ&*��sɲƠ����{��:�1\�1����B������b�@k7�[ƠNQ�pxTl'�y��2�F���M�Z�?���RF��OOF"FAxS�P%�7u�E�G��2��̀�./�6�G莳G%��)���_S���{�S��+�W,���ċW�Q4��
���{M��E�p@�<���b�L?�hw��{M���W�s�^��V�.cJ�IHčRo�t��{�`�Ƞ�4�ʠ�����JP�0�Ş�a|�]	ވ���}��E�țC�N�,�J;�нfDf���Z�l�\��A@D����0���� :��q�I�#\π�����	9�3�/�Q��q�Іo��e�"t�ز
�Jꅱ�k�l�PTFs>w?��s啨�37������Ĥ�:׵�U�̋SƊ�%�����~���� �>X�&�=�jBJh�PK���c��/RC�8R֛--���St�	>s��⒆�z/�1���B���*05���E��+�0i/8�J��L9u�"qڼ�VG��3sm����HQ�Z�����כ
ک�_f�N�p�Ko�ATE�K�T�����g�fKK�����C��y�-؈�Ѣ�K2�����1�|��&t�7Ｔ@K!T��]��M@1��p����Q+*���T�R�<ĭ�#Ж/hچ��pdE���?�5_��;����L�K7��C�@f�5�����{�-8���K��ne��Bn�bO�����=˱�`#���龽���69�j�%��&�	�-��s����U���A{-������P�S���� >��At���������֥�Iܢ���هSc^z��.�SI@L��m�2|�{c���yN��v'@A���S��FIJVb�S��L��F|�-8�Q�}��a������.[�w�:�*�h�4Ĥ3�k��yDo-�UҲ��:л��q|i.8�eo$ȵ�1}A�1,c+��h�Y�r/�QEԎkCށ��{����ee8gm��/�qo.������ڠ/l�-��9����<��A}Gr!�5��D^2Ӄ{S)��'Q�w�E� �M���7:�*Uq���d��=3��]h�+���B�l�$�P��b� w� �"g����R%��L;�O�}��r~����S�_	6"�C^kc)l%�_�I��Q3����d�K#�AԭVǖ\=t���:�+���ܗ��9����|#�Tr�kL��_��gbB|����K#�F�jX�b��0�    V�I��|tTD��G�4D���J�G˜`b���De%����VL�q_	�VzS��?�²۸��ZB��o�k�T��N���v�2��
�*�����Y��8�ׄ�;*v7&��[s#��(ն*':l?���X7�k�lDJB��QV�ݪbV��p%%�r��k�X-�a;LӜ��C1�I[!���0�-�N�6���4�!p���9ю�PЍ�Ԃ0uzw#���S��.� .E�9�\����:2zw_F��t�a����XX6�k����}�j�5a��0۰7+��b�Z���y_J��GW�����0v�r��
��R�'^�Őn�x�yY3B��k�J�(+�.1�32�3I�ژ)»7�k¨c�%^TQ�+���\0����y(�(?����w!����`������i��YP�!Oj�K��k[� t�i��ک��T�0��G���Eʸ�LL�T�ea8����'<���J/�"et�#���79WX{@A(|�m�*�@��ͿH�g5��������\�8h-��/�C�� ��u1��E&=?E?&[Y:e�I���d�YJ��D��jyi�F��y�c���5K�3kPcx�ɜ�ʿH#��	�u$0pNJ[]���]�i��Gc�����Z�=8�
aꦗ'�i�ٌs�5r��8�����x�q�v��	���2ok�x�q�{��˓�9��׽
\l&l����dMW��C$e��BW/+�.�{ ��V��>��!�1�r��flͮT-L�BԂJ�&���?���w�ޞ"����R�U����9ou*�[��v�	S��zѸ}h,9�ʻ� �т��,�;E�G�U%����f��~�n@B����?���`�z��0�s�4��f��]:�m�o�x�U�t��)g�Z�g�$<�o��n�>F]a�U���d�Egc���R=���_wVEYp�nO9cl����,2�5��N^#V@d�"��u����~������Xp�BƋ�Hg�Bg�i�
��}�)�ϯ�(+�O���.5W�!��L��B	b�V�u���z��BR�<%�L�:3x&�"0���*o��h6�q?�2�.�	)���%��)��6a�iF̋;����P� �R����8$y"�Խ�dĊ-{o���0lDo��R��N��Ǆ�����B�]��-��KC�W�CхH��i�p�@��^�z�i��\:��_Z�^��;�g�D�B�`�u�4�0��5ķ<��b?ģ��R�Me<]7�LFf�B��A|�����uw!-g�?�\����e�8�>��]��k���ˏ�+HPaN*������HA�$���Vq�[��p�nb"�p��P����M�C:�obR��T�)'�[Hz������!�ٙ�~������%cR�Q�M��\ڂM�)j�̃��3�b�9CT؀��=fݬqȳ��a푖gMο�+DѶK�6۩��	�����Әb�� ��+�=�p
%6�Gictuľ���kPv�5g���x��]f뱃S�����a�������~��x�����ʳ0K��8�QM���5g�}0�\I�*�g�1��R)V̙�v�r/c#��D��%����G5%�A��}��!��v���GgTu�s���c���#%��hY	�P�K��ALZ��+����iO���f�u��v�C/�
1��َ��'�	�K���&�+\|�2A�GOb3���0��e���z����(^�b�˯�*>���	XW���"����H�\?�+xso0ب&qd�W���,���2�������֙��~�q�;GaFM(�T�?�hk��)��yS�F�j��X 
�lD���5�<1�%'�c���%�k?��uL��z���W��Qw'����~̙q7�;DJ���d+�Jy�MG���嬂��~����u�K���j��F8-�Hx��x6���ǜ�5����kAx����5<�2_沭߈�9��{A@Wj�ǔP�&�'��A�Y=3��oʔ��>7,܈�`�*S�HL����Xk2��y�� >�̍X��J������GB��BՊG�b�?7,D��qTm���7Y�(���2`4ѣ�n=�+܀��G.%B<��W8���H�5S�C��_� J�s\$a�&��4��=%��b֣���w|M�:JU��֌��D��c��P�Y[}��(���ѩ��vE].�(y?�M=�=��Ǆ�� :I�ܯp#歙��.��դ�	մ1g��Q�y������n���k�$��j��̭��(�k�p��nD�}Cmv�t���z�����ԕ=��NQxnY��z(E}�T߻��,T[���.�s7�k��>�s�Ő�+ZAO�����ڐF`:��s�X� "E"�VC�eae�uz�2/=M�oķ����#�|��wr��+Qe��x�SW������W��^%������d�OcA;*��⽯U�s�cN��nc�y��Z\���=W\ۭ-@�M
��^v���c�P�����~�������1��v��� 'nVmD$��`��z����ױ����_�"� ��;j�6��h�:����ZKQ%ݒ|�����(�<�e���v50�&�I���[p�#PS?A�_�Q6��1���!���f�l��߱9��Fti�EA����"���E��^�NT�"/�<��լK��D�Hw��?�����2���ԟ��ܼ"����F��>��j��r<wJ�}�-�)Q�5��m�n����^��.C�#d�;%�.�y�Ȫi�A][w��C�����G�?wJ�s�8�2�.&kk�h=�M����ʤM�O���ו����>?Ū��U"�M�J1��Q-®��V@�$WO�?wO�ֻ>)��'L�YTn�)�ۤJ�=oOU�Q)BSL &]m�9jVD�f
��ҩO��7�����U��S����@F'�o;z=����y����b��g蘰&qU�C}�'y��	�5��^�u:1H��')F�D�1E���mވ��Z�$��V�2>��5^�u�g�b�!��"����͟_�J��OAP��TT� �<��5��=&�/%2����ѩ�>sJ��E���޴g�`�Tf:���x���n#s��壶Z
̄�W$�Ä��1���w
�{��.�*d��{1Yw�\�	uհ&�~f='�r�x���Fڜ�m��x}و'�-P@�˱��j"x�0~j�8�[j�����Z� �	ـP4F��Í����/kT�ݙ��O��N˖k� ���NC7\��-b��S��)y�7D$$:�ry4�-;AW��W���l�3���qߎc�E3F���~L�C��-J�,n7�݈zp���S�}���:XX@8|��e���i��O=߈�p��>�źL�*�'��2��`=����E����t�|���Bʗ:�f؜����7!��na��Է�X��p�mu�3�!7�.y��0�!L��FTЌe��6bL���퐤��-��T�?�m��������,CW�B$�075�N.#+�5�����贁�KZ�L��HFW��ɡ�V�2������D��9�ƛC���u���!���d^"=�@��#�Z1j�Ri�U&�w�`闞SJAB[����ϩ�U��9��N�E�,�֪uV|$�4�i��O����xG*8�L�-%�Ho�C��������Z9~�*Vj̨b#"^�`tH�8z�M�d���?�.e���O��?O���D�Č��"KF ���4kg�,����ʱ�^���C��
�O�Qhz үjbw��V���7,ctQX��!���^&���qf���:�����0���:��!�hQ�^��!R���#@�9����4]�L^!7�}*������Kֹ��?]�����;py�/;�f,m�T��=0�6�̻��?]���hO�������)�l�tAÜYo��P����E��k�����0?�����^�B廻E��E߈~�503.���̂[�c3ڙH�֜�i��{����V�����lp%�l�rz�p�Tm`�����ܝ.>\���o>W�}Z�K$���e�u �  ���֋�!�1*�^�u	����6�lї���O�<� ��<Z�ls���%SW�E/�DH�}��ِ��o�H�MFf�g?T���6��(8�8��%�P���6p��Fr��F��Y�^h�W��z�-��c��7ie)�L=�듧���m�M��)O�:dj��ǖ�ĐUy�:��i$�n瀣����i�Jݝ����=ܳ��F���D�A\J�h�����H�c	n�|j��A,Z0�����x��!=�f��ЩWښ=���>��=��\��C#��u�`��ίK�ѳf~��<
��Z{�������B�衜PP0z�F7,�zyj��FTM�	L�z��jsC����D�Q�9ߗ�*�sm� �څ���+�2e!*�	�N4���j�|�KO��z������ڵn"�I���L+�u#>��A,�~J!�FN��"���53Wo!�{f�s&�=�&�?�)(�k�y��	7�ʔOߵ<�O� f-f�c[��V�q5�R�%����>񍸏j
2%z��U�L&jeS}�&��A,~}/�u��1�r4'B������"�l�9��J�<婥���z��� 2b]��L�3;��*^�}�<�T� �B�S]��/��yꑱ*��}������oD��}�{�4N�����A��(s�vo�r�<�T� ��D����[�y�R�,�	W�R:�g��S�(z>WGϹ��#�v&=j���t���'�z*~��YO"umd��7�3�S�$��y$ߢp��&�ѧ!^*�Xxboڄ��>���#�W�b��G��ZL,�F�L��Qz��4��SO�7�9ԑ�ӷP�V[�w3ƴ��P��2ʹ�E�z*~�n�PX��f�{��I��p`�n�xj�8�LI�$��Z`�W����5/I�F��y#���V�z����[h�/!�+v�&ɦ��H���SK�7�v:]���D���D�K5 �װ�'��Z*~�n��xU�,w?>�cς�T��r(��QtђB�����Ƈ �,����x��v�~�הqz�i��׵����]ʱ��;1��z��k�lĐt�������T��n�}-Yg�YE����D��В���|5M�A�6bs��Ȍz|j��A�}i5���3�ܳ��b�~�jo?*O-qw�k��^���˱8L���.N��Q�+��e�<�T� �m��-g���`��rL~r#��u�m���S�U<z�y(����7X\=�o������UA��f�����8t0�����:�@Vȶss�<�YD�T�]wQ#\�HR����T:/����[���S��bQ׃Tax�� ?�O�w�Tu��k�y]UY�T+��$������Cw6U=D�e�����;���EO9�2��_�N?��`��9O�6�d^A����o�������Ү�@�2�D
� y���E/X���������l     