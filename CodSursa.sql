--4.
--crearea tabelului clienti
CREATE TABLE clienti
    (id_client number(5),
    nume varchar2(25) constraint c_nume not null,
    prenume varchar2(25),
    nr_telefon char(10),
    CONSTRAINT client_pk PRIMARY KEY (id_client),
    unique(nr_telefon)
    );

--crearea tabelului tipuri_evenimente    
CREATE TABLE tipuri_evenimente
    (id_tip_eveniment number(5),
    denumire_tip varchar2(20),
    descriere long,
    CONSTRAINT tip_eveniment_pk PRIMARY KEY (id_tip_eveniment)
    );
    
--crearea tabelului evenimente
CREATE TABLE evenimente
    (id_eveniment number(5),
    data_eveniment date,
    preferinte long,
    id_tip_eveniment number(5) CONSTRAINT c_tip_eveniment not null,
    CONSTRAINT eveniment_pk PRIMARY KEY (id_eveniment),
    CONSTRAINT eveniment_fk foreign key(id_tip_eveniment) references tipuri_evenimente(id_tip_eveniment)
    );
    
--crearea tabelului moduri_de_plata
CREATE TABLE moduri_de_plata
    (id_mod_plata number(5),
    denumire varchar2(20),
    observatii long,
    CONSTRAINT mod_plata_pk PRIMARY KEY (id_mod_plata),
    unique(denumire)
    );   
    
--crearea tabelului comenzi
CREATE TABLE comenzi
    (id_comanda number(5),
    data_comanda date default sysdate,
    id_mod_plata number(5) constraint mod_not_null not null,
    id_client number(5) constraint client_not_null not null,
    id_eveniment number(5),
    CONSTRAINT comenzi_pk PRIMARY KEY (id_comanda),
    CONSTRAINT comanda_mod_plata_fk foreign key(id_mod_plata) references moduri_de_plata(id_mod_plata),
    CONSTRAINT comanda_client_fk foreign key(id_client) references clienti(id_client),
    CONSTRAINT comanda_eveniment_fk foreign key(id_eveniment) references evenimente(id_eveniment)
    );

--crearea tabelului categorii
CREATE TABLE categorii
    (id_categorie number(5),
    nume_categorie varchar(20) constraint nume_categ_not_null not null,
    CONSTRAINT categorii_pk PRIMARY KEY (id_categorie),
    unique(nume_categorie)
    );

--crearea tabelului furnizori
CREATE TABLE furnizori
    (id_furnizor number(5),
    denumire varchar2(20) constraint denumiref_not_null not null,
    nr_telefon char(10) constraint nr_telf_not_null not null,
    unique(nr_telefon),
    CONSTRAINT furnizori_pk PRIMARY KEY (id_furnizor)
    );

--crearea tabelului ingrediente
CREATE TABLE ingrediente
    (id_ingredient number(5),
    denumire varchar2(20) constraint denumire_i_not_null not null,
    id_furnizor number(5) constraint furnizor_not_null not null,
    CONSTRAINT ingrediente_pk PRIMARY KEY (id_ingredient),
    CONSTRAINT ingred_furnizor_fk foreign key(id_furnizor) references furnizori(id_furnizor),
    unique(denumire)
    );

--crearea tabelului produse
CREATE TABLE produse
    (id_produs number(5),
    denumire varchar2(30) constraint denumire_p_not_null not null,
    pret number(3) constraint pret_not_null not null,
    observatii long,
    id_categorie number(5) constraint categ_not_null not null,
    unique(denumire),
    check(pret>0),
    CONSTRAINT produse_pk PRIMARY KEY (id_produs),
    CONSTRAINT produs_categ_fk foreign key(id_categorie) references categorii(id_categorie)
    );
    
--crearea tabelului contine
CREATE TABLE contine
    (id_produs number(5) constraint produs_not_null not null,
    id_ingredient number(5) constraint ingred_not_null not null,
    CONSTRAINT contine_ingred_fk foreign key(id_ingredient) references ingrediente(id_ingredient),
    CONSTRAINT contine_produs_fk foreign key(id_produs) references produse(id_produs),
    CONSTRAINT pk_contine primary key(id_produs, id_ingredient)
    );    

--crearea tabelului angajati
CREATE TABLE angajati
    (id_angajat number(5),
    nume varchar(25) constraint nume_ang_not_null not null,
    prenume varchar(25),
    email varchar(50),
    nr_telefon char(10) constraint nr_ang_not_null not null,
    data_angajare date default sysdate,
    tip_angajat varchar2(10) constraint tip_not_null not null,
    specializare varchar2(50),
    experienta number(2),
    CONSTRAINT angajati_pk PRIMARY KEY (id_angajat),
    unique(email),
    unique(nr_telefon)
    );    

--crearea tabelului gateste_serveste
CREATE TABLE gateste_serveste
    (id_angajat number(5) constraint ang_g_not_null not null,
    id_comanda number(5) constraint comanda_g_not_null not null,
    id_produs number(5) constraint produs_g_not_null not null,
    cantitate number(2) constraint c_cantitate not null,
    CONSTRAINT gateste_angajat_fk foreign key(id_angajat) references angajati(id_angajat),
    CONSTRAINT gateste_produs_fk foreign key(id_produs) references produse(id_produs),
    CONSTRAINT gateste_comanda_fk foreign key(id_comanda) references comenzi(id_comanda),
    CONSTRAINT pk_gateste primary key(id_angajat, id_comanda,id_produs),
    check(cantitate>0)
    );
    
--5.
--secventa pentru generarea codurilor clientilor
CREATE SEQUENCE SEQ_CLIENT
INCREMENT by 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE;

--inserarea datelor in tabelul clienti
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Popescu', 'Maria', '0371692722');
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Radu',	'Andrei', '0772262672');
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Avram', 'Ana-Maria', '0727635283');    
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Gavrila', 'Cristina', '0742830745');    
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Istrate', 'Bogdan-Ionut', '0739428220');    
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Comnoiu', 'Adela-Ioana', '0762863289');    
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Marin', 'Liviu', '0758263927');
INSERT INTO clienti(id_client, nume, prenume, nr_telefon)
    VALUES (SEQ_CLIENT.NEXTVAL, 'Marin', 'Liviu', '0758261234');
    
SELECT * FROM clienti;  


--inserarea datelor in tabelul tipuri_evenimente
INSERT INTO tipuri_evenimente
    VALUES (121, 'nunta', null);
INSERT INTO tipuri_evenimente
    VALUES (122, 'botez', null);
INSERT INTO tipuri_evenimente
    VALUES (123, 'aniversare', 'inclusiv majorat');    
INSERT INTO tipuri_evenimente
    VALUES (124, 'revedere', 'liceu/facultate');    
INSERT INTO tipuri_evenimente
    VALUES (125, 'cununie',	null);    
    
SELECT * FROM tipuri_evenimente;


--inserarea datelor in tabelul evenimente
INSERT INTO evenimente
    VALUES (110, to_date('13-07-2021','dd-mm-yyyy'), 'decor albastru', 122);
INSERT INTO evenimente
    VALUES (111, to_date('25-06-2021','dd-mm-yyyy'), null, 125); 
INSERT INTO evenimente
    VALUES (112, to_date('15-09-2020','dd-mm-yyyy'), null, 124); 
INSERT INTO evenimente
    VALUES (113, to_date('03-04-2021','dd-mm-yyyy'), 'flori naturale', 121); 
INSERT INTO evenimente
    VALUES (114, to_date('28-02-2021','dd-mm-yyyy'), 'decor rosu', 123); 
INSERT INTO evenimente
    VALUES (115, to_date('28-02-2021','dd-mm-yyyy'), 'decor albastru', 124);
INSERT INTO evenimente
    VALUES (116, to_date('07-10-2021','dd-mm-yyyy'), null, 125);
INSERT INTO evenimente
    VALUES (117, to_date('12-02-2022','dd-mm-yyyy'), 'decor roz', 121);
    
SELECT * FROM evenimente;

  
--inserarea datelor in tabelul moduri_de_plata
INSERT INTO moduri_de_plata
    VALUES (600, 'cash', null);
INSERT INTO moduri_de_plata
    VALUES (610, 'card', null);
INSERT INTO moduri_de_plata
    VALUES (620, 'online', null);
INSERT INTO moduri_de_plata
    VALUES (630, 'in rate', 'numai pentru evenimente');
INSERT INTO moduri_de_plata
    VALUES (640, 'tichet', null);
    
SELECT * FROM moduri_de_plata;


--secventa pentru generarea codurilor comenzilor
CREATE SEQUENCE SEQ_COMENZI
INCREMENT by 10
START WITH 10
MINVALUE 10
MAXVALUE 10000
NOCYCLE; 

--inserarea datelor in tabelul comenzi
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('09-03-2021','dd-mm-yyyy'), 600, 2, 113);
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('15-10-2020','dd-mm-yyyy'), 610, 5, null);     
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('03-05-2020','dd-mm-yyyy'), 620, 1, null);     
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('05-07-2021','dd-mm-yyyy'), 600, 3, 110);    
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('18-10-2019','dd-mm-yyyy'), 630, 7, null);
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('23-12-2020','dd-mm-yyyy'), 610, 4, null);     
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('16-02-2021','dd-mm-yyyy'), 620, 2, 114);     
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('30-04-2021','dd-mm-yyyy'), 600, 6, 111);     
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('02-08-2020','dd-mm-yyyy'), 630, 1, 112);   
INSERT INTO comenzi
     VALUES(SEQ_COMENZI.NEXTVAL, to_date('05-10-2021','dd-mm-yyyy'), 600, 1, 116);
  
SELECT * FROM comenzi;


--secventa pentru generarea codurilor categoriilor
CREATE SEQUENCE SEQ_CATEGORII
INCREMENT by 10
START WITH 200
MINVALUE 200
MAXVALUE 10000
NOCYCLE; 

--inserarea datelor in tabelul categorii
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'paste');
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'salate');    
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'pizza');    
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'desert');    
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'bauturi');    
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'friptura');   
INSERT INTO categorii
    VALUES (SEQ_CATEGORII.NEXTVAL, 'garnituri');   

SELECT * FROM categorii;


--secventa pentru generarea codurilor furnizorilor
CREATE SEQUENCE SEQ_FURNIZOR
INCREMENT by 10
START WITH 1000
MINVALUE 1000
MAXVALUE 90000
NOCYCLE; 

--inserarea datelor in tabelul furnizori
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC Bucuria Gustului', '0764652224');
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC Gustos din Natura', '0775375472');    
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC CrisFoods', '0775264221');   
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC De Bun Gust', '0787625242');    
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC Delicios', '0769727366');  
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC Natural', '0769721234'); 
INSERT INTO furnizori
    VALUES (SEQ_FURNIZOR.NEXTVAL, 'SC Natural', '0769712345'); 

SELECT * FROM furnizori; 


--secventa pentru generarea codurilor ingredientelor
CREATE SEQUENCE SEQ_INGREDIENT
INCREMENT by 1
START WITH 170
MINVALUE 170
MAXVALUE 90000
NOCYCLE;

--inserarea datelor in tabelul ingrediente
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'spaghete', 1000);
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'sos de rosii', 1000);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'carne tocata', 1010);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'parmezan', 1020);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'salata verde', 1030);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'piept de pui', 1020);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'rosii', 1000);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'castraveti', 1040);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'branza', 1040);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'faina', 1020);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'masline', 1030);  
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'piscoturi', 1000);
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'mascarpone', 1010);    
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'ciocolata', 1010);    
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'apa', 1030); 
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'suc', 1040);
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'vin', 1010);
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'carne porc', 1020);
INSERT INTO ingrediente
    VALUES(SEQ_INGREDIENT.NEXTVAL, 'carne pui', 1020);
    
SELECT * FROM ingrediente;

 
--secventa pentru generarea codurilor produselor
CREATE SEQUENCE SEQ_PRODUS
INCREMENT by 1
START WITH 50
MINVALUE 50
MAXVALUE 90000
NOCYCLE;

--inserarea datelor in tabelul produse
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'paste carbonara', 24, '300g', 200);
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'paste bologneze', 22, null,	200);
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'salata cu pui',	23,	'200g',	210);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'salata greceasca', 16, '200g', 210);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'pizza margherita', 17, 'medie',	220);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'pizza capriciosa', 19, 'medie', 220);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'tiramisu', 15, null, 230);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'clatite', 14, null, 230);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'apa', 5, '500ml', 240);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'suc', 7, 'diverse sortimente', 240);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'vin', 10, 'la sticla', 240);
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'friptura pui', 25, '230g', 250);    
INSERT INTO produse
    VALUES(SEQ_PRODUS.NEXTVAL, 'friptura porc',	28,	'200g',	250);
    
SELECT * FROM produse;

    
--inserarea datelor in tabelul contine
INSERT INTO contine
    VALUES(50,170);
INSERT INTO contine
    VALUES(50,173);
INSERT INTO contine
    VALUES(51,170);    
INSERT INTO contine
    VALUES(51,171);    
INSERT INTO contine
    VALUES(51,172);    
INSERT INTO contine
    VALUES(52,174);    
INSERT INTO contine
    VALUES(52,175);    
INSERT INTO contine
    VALUES(53,174);    
INSERT INTO contine
    VALUES(53,176);    
INSERT INTO contine
    VALUES(53,177);    
INSERT INTO contine
    VALUES(53,178);    
INSERT INTO contine
    VALUES(54,179);    
INSERT INTO contine
    VALUES(54,171);
INSERT INTO contine
    VALUES(54,173);    
INSERT INTO contine
    VALUES(55,179);    
INSERT INTO contine
    VALUES(55,180);    
INSERT INTO contine
    VALUES(55,171);   
INSERT INTO contine
    VALUES(55,173);    
INSERT INTO contine
    VALUES(56,181);    
INSERT INTO contine
    VALUES(56,182);   
INSERT INTO contine
    VALUES(57,179);    
INSERT INTO contine
    VALUES(57,183);    
INSERT INTO contine
    VALUES(58,184);
INSERT INTO contine
    VALUES(59,185);    
INSERT INTO contine
    VALUES(60,186);    
 
SELECT * FROM contine; 


--inserarea datelor in tabelul angajati
INSERT INTO angajati
    VALUES(200,	'Avram', 'Alina', 'alina@angajat.ro', '0765242562',	to_date('03-03-2018','dd-mm-yyyy'), 'bucatar', 'Franta', null);
INSERT INTO angajati
    VALUES(201,	'Dumitrache', 'Bianca-Maria', 'bianca@angajat.ro', '0775252425', to_date('15-10-2019','dd-mm-yyyy'), 'ospatar', null,	2);
INSERT INTO angajati
    VALUES(202,	'Vilcu', 'Elena', 'ella@angajat.ro', '0738726252',	to_date('19-07-2019','dd-mm-yyyy'), 'bucatar', 'Romania',	null);
INSERT INTO angajati
    VALUES(203,	'Nistor', 'Izabela', 'iza@angajat.ro', '0758625279', to_date('07-02-2021','dd-mm-yyyy'), 'ospatar', null,	3);
INSERT INTO angajati
    VALUES(204,	'Dinu',	'Marian', 'marian@angajat.ro', '0787534299', to_date('21-05-2015','dd-mm-yyyy'), 'bucatar', 'Spania',	null);
INSERT INTO angajati
    VALUES(205,	'Ionsecu', 'Ion', 'ion@angajat.ro',	'0749293633', to_date('18-04-2020','dd-mm-yyyy'),	'ospatar', null, null);
INSERT INTO angajati
    VALUES(206,	'Brezan', 'Sabin-Alexandru', 'sabin@angajat.ro', '0758622885', to_date('11-09-2020','dd-mm-yyyy'), 'bucatar', 'Franta', null);    
INSERT INTO angajati
    VALUES(207,	'Albu',	'Georgiana', 'geo@angajat.ro',	'0769628434', to_date('13-01-2021','dd-mm-yyyy'),	'ospatar',	null, 6);    
INSERT INTO angajati
    VALUES(208,	'Brezan', 'Sabin-Alexandru', 'sabin2@angajat.ro', '0723961024', to_date('03-04-2021','dd-mm-yyyy'), 'bucatar', null, null);
INSERT INTO angajati
    VALUES(209,	'Stroilescu', 'Maria', 'maria@angajat.ro', '0722567024', to_date('23-09-2021','dd-mm-yyyy'), 'bucatar', null, null);    

SELECT * FROM angajati;


--inserararea datelor in tabelul gateste_serveste
INSERT INTO gateste_serveste
    VALUES(204,10,62,20);
INSERT INTO gateste_serveste
    VALUES(206,10,56,15);    
INSERT INTO gateste_serveste
    VALUES(207,10,59,20);    
INSERT INTO gateste_serveste
    VALUES(200,20,55,2);    
INSERT INTO gateste_serveste
    VALUES(202,30,57,4);    
INSERT INTO gateste_serveste
    VALUES(205,30,59,4);    
INSERT INTO gateste_serveste
    VALUES(204,40,61,10);    
INSERT INTO gateste_serveste
    VALUES(203,40,60,8);    
INSERT INTO gateste_serveste
    VALUES(200,50,51,3);    
INSERT INTO gateste_serveste
    VALUES(206,60,53,6);    
INSERT INTO gateste_serveste
    VALUES(204,70,55,16);
INSERT INTO gateste_serveste
    VALUES(207,70,59,16);
INSERT INTO gateste_serveste
    VALUES(206,80,62,22);    
INSERT INTO gateste_serveste
    VALUES(201,80,60,22);    
INSERT INTO gateste_serveste
    VALUES(202,90,50,5);    
INSERT INTO gateste_serveste
    VALUES(201,90,58,7);    
INSERT INTO gateste_serveste
    VALUES(207,10,62,20);    
INSERT INTO gateste_serveste
    VALUES(207,10,56,15);    
INSERT INTO gateste_serveste
    VALUES(201,20,55,2);    
INSERT INTO gateste_serveste
    VALUES(205,30,57,4);    
INSERT INTO gateste_serveste
    VALUES(203,40,61,10);    
INSERT INTO gateste_serveste
    VALUES(201,50,51,3);
INSERT INTO gateste_serveste
    VALUES(205,60,53,6);
INSERT INTO gateste_serveste
    VALUES(207,70,55,16);    
INSERT INTO gateste_serveste
    VALUES(203,80,62,22);    
INSERT INTO gateste_serveste
    VALUES(205,90,50,5);         
INSERT INTO gateste_serveste
    VALUES(203,10,58,3);
INSERT INTO gateste_serveste
    VALUES(204,100,52,7);         
INSERT INTO gateste_serveste
    VALUES(205,100,52,7);
    
SELECT * FROM gateste_serveste;

--6.
--Definiti o functie care primeste ca parametru denumirea unui furnizor si returneaza numarul de comenzi care contin cel putin
--un produs gatit cu ingrediente de la furnizorul dat.

--  In rezolvarea exercitiului am folosit:
-- - un vector cu dimensiune maxima 100 pentru a retine ingredientele furnizate de furnizorul dat
-- - un tablou indexat pentru a retine lista de produse ce contin ingredientele din vector
-- - un tablou imbricat pentru a retine comenzile ce contin produse din tabloul indexat
-- La final functia a returnat numarul de elemente din tabloul imbricat (numarul de comenzi ce indeplinesc conditia)
CREATE OR REPLACE FUNCTION comenzi_furnizor
    (nume furnizori.denumire%TYPE)
RETURN NUMBER IS
    TYPE vector IS VARRAY(100) OF ingrediente.id_ingredient%TYPE; --presupunem ca nu avem mai mult de 100 de ingrediente
    t_ing vector := vector(); --vector folosit pentru a retine lista de ingrediente furnizate

    TYPE tablou_indexat IS TABLE OF produse.id_produs%TYPE INDEX BY PLS_INTEGER;
    t_prod  tablou_indexat; --tablou indexat folosit pentru a retine lista de produse ce contin ingredientele furnizorului 
    t_prod_aux tablou_indexat; --tablou indexat auxiliar folosit pentru a adauga in tabloul indexat mai sus definit numai elemente distincte

    TYPE tablou_imbricat IS TABLE OF comenzi.id_comanda%TYPE;
    t_comenzi tablou_imbricat:= tablou_imbricat(); --tablou imbricat folosit pentru a retine comenzile ce contin produse din t_prod
    t_comenzi_aux tablou_imbricat:= tablou_imbricat();--tablou imbricat auxiliar folosit pentru a adauga in tabloul imbricat mai sus definit numai elemente distincte
    
    id_ing ingrediente.id_ingredient%TYPE;
    id_prod produse.id_produs%TYPE;
    v_id furnizori.id_furnizor%TYPE;
    aux NUMBER;
BEGIN
    SELECT id_furnizor  --selectez id-ul furnizorului dat
    INTO v_id
    FROM furnizori
    WHERE upper(denumire) = upper(nume);
    
    SELECT id_ingredient --introduc in vectorul t_ing id-urile ingredientelor
    BULK COLLECT INTO t_ing
    FROM ingrediente
    WHERE id_furnizor = v_id;
    
    DBMS_OUTPUT.PUT_LINE('Id furnizor: ' || v_id);
    DBMS_OUTPUT.PUT_LINE('Ingrediente: ');
    FOR i in t_ing.FIRST..t_ing.LAST LOOP --afisare id-uri ingrediente
        DBMS_OUTPUT.PUT_LINE(t_ing(i));
    END LOOP;
    
    id_ing := t_ing(t_ing.FIRST);
    
    SELECT DISTINCT id_produs --initializez tabloul indexat cu produsele gatite cu primul ingredient
    BULK COLLECT INTO t_prod
    FROM contine
    WHERE id_ingredient = id_ing;

    FOR i in t_ing.FIRST+1..t_ing.LAST LOOP -- pentru fiecare ingredient ramas
        
        id_ing := t_ing(i);
        SELECT DISTINCT id_produs --introduc in tabloul indexat auxiliar produsele gatite cu ingredientul curent
        BULK COLLECT INTO t_prod_aux
        FROM contine
        WHERE id_ingredient = id_ing;
        
        --verificare daca exista deja produsul in lista finala
        FOR k in t_prod_aux.FIRST..t_prod_aux.LAST LOOP
            aux := 0;
              
            FOR j in t_prod.FIRST..t_prod.LAST LOOP 
                IF t_prod_aux(k) = t_prod(j) THEN
                    aux :=1;
                END IF;
            END LOOP;
           
            --daca aux = 0 inseamna ca produsul nu exista deja in lista, asa ca il adaugam la final
            IF aux = 0 THEN
                t_prod(t_prod.LAST + 1) := t_prod_aux(k);
            END IF;
           
        END LOOP;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Produse: ');
    FOR i in t_prod.FIRST..t_prod.LAST LOOP --afisare id-uri produse
        DBMS_OUTPUT.PUT_LINE(t_prod(i));
    END LOOP;
    
    id_prod := t_prod(t_prod.FIRST); 
    SELECT DISTINCT id_comanda --initializez tabloul imbricat t_comenzi cu id-ul comenzilor ce contin primul produs din t_prod
    BULK COLLECT INTO t_comenzi
    FROM gateste_serveste
    WHERE id_produs = id_prod;
    
    FOR i in t_prod.FIRST+1..t_prod.LAST LOOP
        id_prod := t_prod(i); 
        SELECT DISTINCT id_comanda --introduc in tabloul imbricat auxiliar id-ul comenzilor ce contin primul produs din t_prod
        BULK COLLECT INTO t_comenzi_aux
        FROM gateste_serveste
        WHERE id_produs = id_prod;
        
        --verificare daca exista deja comanda in lista finala
        FOR k in t_comenzi_aux.FIRST..t_comenzi_aux.LAST LOOP
            aux := 0;
            
            FOR j in t_comenzi.FIRST..t_comenzi.LAST LOOP 
                IF t_comenzi_aux(k) = t_comenzi(j) THEN
                    aux :=1;
                END IF;
            END LOOP;
           
            --daca aux = 0 inseamna ca id-ul comenzii nu exista deja in lista, asa ca il adaugam la final
            IF aux = 0 THEN
                t_comenzi.EXTEND;
                t_comenzi(t_comenzi.LAST) := t_comenzi_aux(k);
            END IF;
        END LOOP;
    END LOOP;
      
    DBMS_OUTPUT.PUT_LINE('Comenzi: ');
    FOR i in t_comenzi.FIRST..t_comenzi.LAST LOOP --afisare id-uri comenzi
        DBMS_OUTPUT.PUT_LINE(t_comenzi(i));
    END LOOP;
    
    RETURN t_comenzi.COUNT; --returnare numar de elemente ale tabloului imbricat cu id-urile comenzilor
    
     EXCEPTION
        WHEN NO_DATA_FOUND THEN --cazul in care denumirea data nu corespunde cu denumirea unui furnizor
            RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun furnizor cu denumirea data');
        WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multi furnizori cu denumirea introdusa
            RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi furnizori cu denumirea data');
END comenzi_furnizor;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Numarul de comenzi: ' || comenzi_furnizor('SC Gustos din Natura'));
    --DBMS_OUTPUT.PUT_LINE('Numarul de comenzi: ' || comenzi_furnizor('SC Alt Nume')); --exceptie: no_data_found
    --DBMS_OUTPUT.PUT_LINE('Numarul de comenzi: ' || comenzi_furnizor('SC Natural')); --exceptie: to_many_rows
END;
/
--pentru a introduce denumirea de la tastatura
DECLARE
    nume furnizori.denumire%TYPE := '&p_nume';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Numarul de comenzi: ' || comenzi_furnizor(nume));
END;
/

--7.
--Sa se scrie o procedura care pentru numele unui bucatar sa afiseze produsele pe care le-a gatit acesta(o singura data fiecare), 
--iar pentru fiecare produs sa afiseze si ingredientele folosite. 

--Pentru a rezolva problema am utilizat un cursor clasic pentru a stoca si procesa produsele gatite de bucatar
--si un ciclu cursor parametrizat pentru a stoca si parcurge ingredientele pentru fiecare produs.
CREATE OR REPLACE PROCEDURE produse_gatite
        (v_nume angajati.nume%TYPE,
        v_prenume angajati.prenume%TYPE)
    IS
        v_id angajati.id_angajat%TYPE;
        v_prod produse.id_produs%TYPE;
        nume_prod produse.denumire%TYPE;
        --cursor clasic
        CURSOR c_prod IS 
            SELECT DISTINCT id_produs
            FROM gateste_serveste
            WHERE id_angajat = (SELECT id_angajat
                                FROM angajati
                                WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume) 
                                        AND tip_angajat = 'bucatar'
                                );
        --ciclu cursor parametrizat
        CURSOR c_ingr(id_prod produse.id_produs%TYPE) IS 
            SELECT denumire
            FROM ingrediente 
            WHERE id_ingredient IN (SELECT id_ingredient
                                    FROM contine
                                    WHERE id_produs = id_prod
                                    );
    BEGIN
        SELECT id_angajat --selectare id bucatar
        INTO v_id
        FROM angajati
        WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume) AND tip_angajat = 'bucatar';
        --am pus si conditia ca numele introdus sa fie al unui bucatar
        
        DBMS_OUTPUT.PUT_LINE('BUCATARUL ' || initcap(v_nume) || ' ' || initcap(v_prenume));
        
        OPEN c_prod; --deschidere cursor
        LOOP FETCH c_prod INTO v_prod; --incarcare linii pe rand in variabila v_prod
        EXIT WHEN c_prod%NOTFOUND;
            SELECT denumire --selectare denumire produs
            INTO nume_prod
            FROM produse
            WHERE id_produs = v_prod;
            DBMS_OUTPUT.PUT_LINE('Produsul: ' || nume_prod);
            FOR ingr IN c_ingr(v_prod) LOOP --ciclu cursor pentru afisarea ingredientelor
                DBMS_OUTPUT.PUT_LINE('  -> ' || ingr.denumire);
            END LOOP;
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        
        --daca numarul liniilor este 0, atunci inseamna ca bucatarul nu a gatit nimic inca
        IF c_prod%ROWCOUNT = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Bucatarul dat nu a gatit niciun produs pana acum');
        END IF;
        CLOSE c_prod; --inchidere cursor
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN --cazul in care nu exista niciun bucatar cu numele dat
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun bucatar cu numele dat');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multi bucatari cu numele dat
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi bucatari cu numele dat');
    END produse_gatite;
/

BEGIN
    produse_gatite('Avram', 'Alina');
    --produse_gatite('Ana', 'Maria'); -- exceptie no_data_found (nu exista niciun bucatar cu acest nume)
    --produse_gatite('Brezan', 'Sabin-Alexandru'); -- exceptie too_many_rows (exista doi bucatari cu acest nume)
    --produse_gatite('Stroilescu', 'Maria'); -- Bucatarul dat nu a gatit niciun produs pana acum
END;
/
--pentru a introduce numele bucatarului de la tastatura
DECLARE
    nume angajati.nume%TYPE := '&p_nume';
    prenume angajati.prenume%TYPE := '&p_prenume';
BEGIN
    produse_gatite(nume, prenume);
END;
/

--8.
--Definiti o functie care primeste ca parametru ziua unui eveniment si o categorie de produse si returneaza numarul de
--produse comandate din acea categorie pentru evenimentul din ziua data.

CREATE OR REPLACE FUNCTION nr_produse
    (zi DATE,
    categ categorii.nume_categorie%TYPE)
RETURN NUMBER IS
    nr NUMBER := 0;
    nr_aux NUMBER;
    TYPE t_ind IS TABLE OF produse.id_produs%TYPE
            INDEX BY PLS_INTEGER;
    v_ind t_ind; --tablou indexat pentru a retine produsele ce fac parte din categoria data
    id_ev evenimente.id_eveniment%TYPE;
    exc_categ EXCEPTION;
    exc_produse EXCEPTION;
BEGIN
    --verific daca exista categoria
    SELECT COUNT(id_categorie)
    INTO nr
    FROM categorii
    WHERE upper(nume_categorie) = upper(categ);
    
    IF nr = 0 THEN --cazul in care categoria data nu exista
        RAISE exc_categ;
    END IF;
    
    --verific daca exista produse in categoria data
    SELECT COUNT(id_produs)
    INTO nr
    FROM produse p JOIN categorii c ON (p.id_categorie=c.id_categorie)
    WHERE upper(nume_categorie) = upper(categ);
    
    IF nr = 0 THEN --cazul in care nu exista produse in categoria data
        RAISE exc_produse;
    END IF;
    
    --selectez id-urile produselor din categoria data
    SELECT id_produs
    BULK COLLECT INTO v_ind
    FROM produse p JOIN categorii c ON (p.id_categorie=c.id_categorie)
    WHERE upper(nume_categorie) = upper(categ);
    
    --selectez id-ul evenimentului din ziua data
    SELECT id_eveniment
    INTO id_ev
    FROM evenimente
    WHERE data_eveniment = zi;
    
    nr := 0;
    FOR i IN v_ind.FIRST..v_ind.LAST LOOP
        SELECT SUM(cantitate) --retin cantitatea vanduta pentru fiecare produs in parte 
        INTO nr_aux
        FROM gateste_serveste g JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                JOIN angajati a ON (g.id_angajat = a.id_angajat)
        WHERE c.id_eveniment = id_ev AND tip_angajat = 'ospatar'
                AND id_produs = v_ind(i); 
                
        nr := nr + NVL(nr_aux, 0); -- adaug cantitatea la suma totala
    END LOOP;
    
    RETURN nr; --returnez numarul de produse obtinut
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN --cazul in care nu exista un eveniment in ziua data
            RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun eveniment in ziua data');
        WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multe evenimente in ziua data
            RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe evenimente in ziua data');
        WHEN exc_categ THEN --cazul in care categoria introdusa nu exista sau cazul in care inca nu sunt introduse produsele care fac parte din aceasta
            RAISE_APPLICATION_ERROR(-20002, 'Categoria data nu exista');
        WHEN exc_produse THEN --cazul in care inca nu sunt introduse produse care sa faca parte din categoria data
            RAISE_APPLICATION_ERROR(-20003, 'Nu exista produse care sa faca parte din categoria data');
END nr_produse;
/

DECLARE
    nr_prod NUMBER;
BEGIN
    nr_prod := nr_produse(TO_DATE('03-APR-21'), 'bauturi'); --23 produse = 20 sticle apa + 3 sticle suc
    --nr_prod := nr_produse(TO_DATE('23-APR-21'), 'salate'); --exceptie: Nu exista niciun eveniment in ziua data
    --nr_prod := nr_produse(TO_DATE('28-FEB-21'), 'paste'); -- exceptie: Exista mai multe evenimente in ziua data
    --nr_prod := nr_produse(TO_DATE('13-JUL-21'), 'aaa'); --exceptie: Categoria data nu exista
    --nr_prod := nr_produse(TO_DATE('13-JUL-21'), 'garnituri');-- exceptie: Nu exista produse care sa faca parte din categoria data
    IF nr_prod = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Nu au fost comandate produse din aceasta categorie');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Au fost comandate ' || nr_prod || ' produse din aceasta categorie');
    END IF;
END;
/
--pentru a introduce data evenimentului si categoria de la tastatura
DECLARE
    nr_prod NUMBER;
    data_ev DATE := TO_DATE('&p_data');
    categ categorii.nume_categorie%TYPE := '&p_categorie';
BEGIN
    nr_prod := nr_produse(data_ev, categ);
    IF nr_prod = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Nu au fost comandate produse din categoria ' || categ);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Au fost comandate ' || nr_prod || ' produse din categoria ' || categ);
    END IF;
END;
/

--9.
--Sa se scrie o procedura care pentru numele unui client dat sa afiseze pentru fiecare eveniment toti furnizorii care
--au furnizat ingrediente ce au fost continute de produsele din comenzile date pentru evenimentul respectiv.

--In rezolvarea exercitiului am folosit un cursor imbricat. Cursorul parinte incarca date despre evenimentele clientului si un
--cursor generat de o subcerere pentru a incarca si procesa furnizorii de ingrediente folosite pentru fiecare eveniment. 
--Subcererea utilizeaza 5 dintre tabelele din baza de date.

CREATE OR REPLACE PROCEDURE furnizori_evenimente
    (v_nume clienti.nume%TYPE,
    v_prenume clienti.prenume%TYPE)
IS  
    --cursor imbricat
    CURSOR ev(id_c clienti.id_client%TYPE) IS 
                SELECT data_eveniment, denumire_tip, --selectez date despre eveniment
                            CURSOR(SELECT DISTINCT f.denumire --selectez furnizorii ceruti in functie de eveniment
                                   FROM furnizori f JOIN ingrediente i ON (f.id_furnizor=i.id_furnizor)
                                                    JOIN contine c ON (i.id_ingredient=c.id_ingredient)
                                                    JOIN produse p ON (p.id_produs=c.id_produs)
                                                    JOIN gateste_serveste g ON (p.id_produs=g.id_produs)
                                   WHERE g.id_comanda = c.id_comanda
                                  )
                 FROM evenimente e JOIN tipuri_evenimente t ON (e.id_tip_eveniment = t.id_tip_eveniment)
                                   JOIN comenzi c ON (e.id_eveniment = c.id_eveniment)
                                   JOIN clienti cli ON (cli.id_client = c.id_client)
                 WHERE cli.id_client = id_c;
                 
    c_furnizori SYS_REFCURSOR;
    v_id clienti.id_client%TYPE;
    data_ev evenimente.data_eveniment%TYPE;
    nume_tip tipuri_evenimente.denumire_tip%TYPE;
    TYPE tablou_indexat IS TABLE OF furnizori.denumire%TYPE INDEX BY PLS_INTEGER;
    t_furnizori  tablou_indexat; --tablou indexat pt a retine denumirea furnizorilor
    exc EXCEPTION;
BEGIN
    SELECT id_client --selectez id-ul clientului introdus
    INTO v_id
    FROM clienti
    WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume);
    
    OPEN ev(v_id); --deschid cursorul 
    
    LOOP
        FETCH ev INTO data_ev, nume_tip, c_furnizori;
        EXIT WHEN ev%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Eveniment: ' || nume_tip || ' din data ' || TO_CHAR(data_ev));
        FETCH c_furnizori BULK COLLECT INTO t_furnizori;
        
        IF  t_furnizori.COUNT = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Pentru acest eveniment nu au fost date comenzi');
        ELSE
            FOR i IN t_furnizori.FIRST..t_furnizori.LAST LOOP
                DBMS_OUTPUT.PUT_LINE(i|| '. '|| t_furnizori(i)); --afisez furnizorii
            END LOOP;
        END IF;
        
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;
    
    IF ev%ROWCOUNT = 0 THEN --cazul in care clientul nu a dat nicio comanda pentru un eveniment
        RAISE exc;
    END IF;
    
    CLOSE ev;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN -- cazul in care nu exista niciun client cu numele dat 
            RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun client cu numele dat');
        WHEN TOO_MANY_ROWS THEN -- cazul in care exista mai multi clienti cu numele dat
            RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi clienti cu numele dat');
        WHEN exc THEN -- cazul in care clientul nu a dat nicio comanda pentru un eveniment
            RAISE_APPLICATION_ERROR(-20002, 'Clientul dat nu a dat nicio comanda pentru un eveniment');
END furnizori_evenimente;
/
BEGIN
    furnizori_evenimente('Popescu', 'Maria'); 
    --furnizori_evenimente('Ana', 'Ana'); --exceptie: Nu exista niciun client cu numele dat
    --furnizori_evenimente('Marin', 'Liviu'); --exceptie: Exista mai multi clienti cu numele dat
    --furnizori_evenimente('Gavrila', 'Cristina'); --exceptie: Clientul dat nu a dat nicio comanda pentru un eveniment
END;
/
--pentru a introduce numele clientului de la tastatura
DECLARE
    nume clienti.nume%TYPE := '&p_nume';
    prenume clienti.prenume%TYPE := '&p_prenume';
BEGIN
    furnizori_evenimente(nume, prenume);
END;
/

--10.
--Creati un trigger care nu permite adaugarea, stergerea si modificarea comenzilor in afara programului restaurantului. 
--In timpul saptamanii restaurantul este deschis intre 10:00-22:00, iar in weekend intre 9:00-23:30.
CREATE OR REPLACE TRIGGER program_restaurant
    BEFORE INSERT OR UPDATE OR DELETE ON comenzi
BEGIN
    IF TO_CHAR(SYSDATE, 'DAY') = 'SATURDAY' OR TO_CHAR(SYSDATE, 'DAY') = 'SUNDAY' THEN 
        -- in weekend, programul este 9 - 23:30
        IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 THEN
            RAISE_APPLICATION_ERROR(-20110, 'Restaurantul se deschide la 9:00 in weekend!'); 
        END IF;
        IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) = 23 AND TO_NUMBER(TO_CHAR(SYSDATE, 'MI')) > 30 THEN
            RAISE_APPLICATION_ERROR(-20111, 'Restaurantul este inchis dupa ora 23:30 in weekend!');
        END IF;
    ELSE 
        -- in timpul saptamanii, programul este 10 - 22
        IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 10 THEN
            RAISE_APPLICATION_ERROR(-20112, 'Restaurantul se deschide la 9:00 in timpul saptamanii!');
        END IF;
        IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) >= 22 THEN
            RAISE_APPLICATION_ERROR(-20113, 'Restaurantul este inchis dupa ora 22:00 in timpul saptamanii!');
        END IF;
    END IF;
END;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Zi: ' || TO_CHAR(SYSDATE, 'DAY'));
    DBMS_OUTPUT.PUT_LINE('Ora: ' || TO_CHAR(SYSDATE, 'HH24:MI'));
    INSERT INTO comenzi
        VALUES(SEQ_COMENZI.NEXTVAL, to_date('15-12-2021','dd-mm-yyyy'), 610, 7, null);
END;
/

--11.
--Sa se scrie un trigger care atunci cand se incearca servirea unor produse sa verifice ca acestea sa fi fost 
--preparate inainte de un bucatar. Exceptie fac produsele din categoria bauturi care pot fi servite direct, fara a fi
--pregatite de un bucatar. La stergerea unei inregistrari sa se afiseze detalii despre cantitatea stearsa.
CREATE OR REPLACE TRIGGER prod_gatit
BEFORE INSERT OR DELETE 
ON gateste_serveste
FOR EACH ROW  
DECLARE
    tip angajati.tip_angajat%TYPE;
    bauturi_id categorii.id_categorie%TYPE;
    categ_id categorii.id_categorie%TYPE;
    nr_prod_gatite NUMBER;
    nr_prod_servite NUMBER;
    can_stearsa gateste_serveste.cantitate%TYPE;
BEGIN
    IF INSERTING THEN
        --selectez tipul angajatului
        SELECT tip_angajat
        INTO tip
        FROM angajati
        WHERE id_angajat = :NEW.id_angajat;
        
        IF tip = 'ospatar' THEN
            --verificam din ce categorie face parte produsul
            --numai bauturile nu trebuie gatite, deci verificam ca produsul sa nu faca parte din aceasta categorie
            SELECT id_categorie --selectez id-ul categoriei 'bauturi'
            INTO bauturi_id
            FROM categorii
            WHERE nume_categorie = 'bauturi';
            
            SELECT id_categorie --selectez id-ul categoriei din care face parte produsul 
            INTO categ_id
            FROM produse
            WHERE id_produs = :NEW.id_produs;
            
            IF categ_id != bauturi_id THEN --produsul trebuie gatit
                SELECT NVL(SUM(cantitate),0) --retin cantitatea de produse gatite pentru aceasta comanda
                INTO nr_prod_gatite
                FROM gateste_serveste g JOIN angajati a ON (g.id_angajat = a.id_angajat)
                WHERE id_produs = :NEW.id_produs AND id_comanda = :NEW.id_comanda
                        AND tip_angajat = 'bucatar';
                
                DBMS_OUTPUT.PUT_LINE('Nr produse gatite:' || nr_prod_gatite);
                
                --calculam si numarul de produse deja servite
                SELECT NVL(SUM(cantitate),0)
                INTO nr_prod_servite
                FROM gateste_serveste g JOIN angajati a ON (g.id_angajat = a.id_angajat)
                WHERE id_produs = :NEW.id_produs AND id_comanda = :NEW.id_comanda
                        AND tip_angajat = 'ospatar';
                        
                DBMS_OUTPUT.PUT_LINE('Nr produse servite:' || nr_prod_servite);
                DBMS_OUTPUT.PUT_LINE('Cantitatea care ar putea fi servita:' || TO_CHAR(nr_prod_gatite - nr_prod_servite));
                
                IF nr_prod_gatite - nr_prod_servite < :NEW.cantitate THEN
                    RAISE_APPLICATION_ERROR(-20000, 'Cantitatea mentionata nu poate fi servita');
                END IF;
            END IF;
        END IF;
    ELSE
        --incercam sa selectam cantitatea din tabelul in care se produce modificarea => tabel mutating
        SELECT cantitate
        INTO can_stearsa
        FROM gateste_serveste
        WHERE id_angajat = :OLD.id_angajat AND id_comanda = :OLD.id_comanda AND id_produs = :OLD.id_produs;
        
        --rezolvare fara a aparea eroarea 'table is mutating'
        --can_stearsa := :OLD.cantitate;
        
        DBMS_OUTPUT.PUT_LINE('Cantitatea ' || can_stearsa || ' a fost stearsa cu succes');
    END IF;
END;
/
ALTER TRIGGER prod_gatit DISABLE;
ALTER TRIGGER prod_gatit ENABLE;

--incercam servirea unor produse care nu sunt gatite => declansam trigger-ul
INSERT INTO gateste_serveste
VALUES(201, 30, 51, 5);
                  
--cazul in care produsele sunt gatite inainte, iar apoi servite => inserare reusita
INSERT INTO gateste_serveste
VALUES(200, 30, 51, 5);

INSERT INTO gateste_serveste
VALUES(201, 30, 51, 5);

--incercam sa stergem inregistrarile introduse
DELETE FROM gateste_serveste
WHERE id_angajat = 200 AND id_comanda = 30 AND id_produs = 51;
DELETE FROM gateste_serveste
WHERE id_angajat = 201 AND id_comanda = 30 AND id_produs = 51;

--12.
--Creati un trigger care permite modificarea schemei numai in timpul saptamanii si de catre utilizatorul 'PROIECTSGBD'.
--In plus, trigger-ul va insera informatii despre utilizator, data si comanda in tabelul info_modificari 
--la fiecare incercare de modificare a schemei.

CREATE TABLE info_modificari --creare tabel info_modificari
    (nume_user varchar(30),
    comanda varchar(15),
    nume_obiect varchar(30),
    data_modificare DATE
    );

CREATE OR REPLACE TRIGGER modificare_schema
    BEFORE CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    INSERT INTO info_modificari --adaugam informatii in tabel
        VALUES(SYS.LOGIN_USER, SYS.SYSEVENT, SYS.DICTIONARY_OBJ_NAME, SYSDATE);
        
    IF USER != UPPER('proiectSGBD') THEN --verificam user-ul
        RAISE_APPLICATION_ERROR(-20010,'Numai utilizatorul proiectSGBD poate modifica schema!');
    ELSIF TO_CHAR(SYSDATE, 'DAY') = 'SATURDAY' OR TO_CHAR(SYSDATE, 'DAY') = 'SUNDAY' THEN --verificam ziua saptamanii
        RAISE_APPLICATION_ERROR(-20011,'Schema poate fi modificata numai in timpul saptamanii!');
    END IF;
END;
/

--pentru a ilustra inserarea datelor in tabelul info_modificari rulam urmatoarele instructiuni
CREATE TABLE incercare
    (nume varchar(20)
    );
    
ALTER TABLE incercare 
ADD prenume varchar(20);

DROP TABLE incercare;    

ALTER TABLE angajati
ADD salariu NUMBER;

ALTER TABLE angajati
DROP COLUMN salariu;

SELECT * FROM info_modificari;

--13.
--Pentru a rezolva cerinta am introdus subprogramele definite la exercitiile 6-9 in interiorul unui pachet.
--specificatia pachetului:
CREATE OR REPLACE PACKAGE pachet_proiect AS
    --functie ex. 6
    FUNCTION p_comenzi_furnizor
        (nume furnizori.denumire%TYPE)
    RETURN NUMBER;
    
    --procedura ex. 7
    PROCEDURE p_produse_gatite
        (v_nume angajati.nume%TYPE,
        v_prenume angajati.prenume%TYPE);
        
    --functie ex. 8
    FUNCTION p_nr_produse
        (zi DATE,
        categ categorii.nume_categorie%TYPE)
    RETURN NUMBER;
    
    --procedura ex. 9
    PROCEDURE p_furnizori_evenimente
        (v_nume clienti.nume%TYPE,
        v_prenume clienti.prenume%TYPE);
END pachet_proiect;
/

--corpul pachetului:
CREATE OR REPLACE PACKAGE BODY pachet_proiect AS
    --functie ex. 6
    FUNCTION p_comenzi_furnizor
        (nume furnizori.denumire%TYPE)
    RETURN NUMBER IS
        TYPE vector IS VARRAY(100) OF ingrediente.id_ingredient%TYPE; --presupunem ca nu avem mai mult de 100 de ingrediente
        t_ing vector := vector(); --vector folosit pentru a retine lista de ingrediente furnizate
    
        TYPE tablou_indexat IS TABLE OF produse.id_produs%TYPE INDEX BY PLS_INTEGER;
        t_prod  tablou_indexat; --tablou indexat folosit pentru a retine lista de produse ce contin ingredientele furnizorului 
        t_prod_aux tablou_indexat; --tablou indexat auxiliar folosit pentru a adauga in tabloul indexat mai sus definit numai elemente distincte
    
        TYPE tablou_imbricat IS TABLE OF comenzi.id_comanda%TYPE;
        t_comenzi tablou_imbricat:= tablou_imbricat(); --tablou imbricat folosit pentru a retine comenzile ce contin produse din t_prod
        t_comenzi_aux tablou_imbricat:= tablou_imbricat();--tablou imbricat auxiliar folosit pentru a adauga in tabloul imbricat mai sus definit numai elemente distincte
        
        id_ing ingrediente.id_ingredient%TYPE;
        id_prod produse.id_produs%TYPE;
        v_id furnizori.id_furnizor%TYPE;
        aux NUMBER;
    BEGIN
        SELECT id_furnizor  --selectez id-ul furnizorului dat
        INTO v_id
        FROM furnizori
        WHERE upper(denumire) = upper(nume);
        
        SELECT id_ingredient --introduc in vectorul t_ing id-urile ingredientelor
        BULK COLLECT INTO t_ing
        FROM ingrediente
        WHERE id_furnizor = v_id;
        
        DBMS_OUTPUT.PUT_LINE('Id furnizor: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Ingrediente: ');
        FOR i in t_ing.FIRST..t_ing.LAST LOOP --afisare id-uri ingrediente
            DBMS_OUTPUT.PUT_LINE(t_ing(i));
        END LOOP;
        
        id_ing := t_ing(t_ing.FIRST);
        
        SELECT DISTINCT id_produs --initializez tabloul indexat cu produsele gatite cu primul ingredient
        BULK COLLECT INTO t_prod
        FROM contine
        WHERE id_ingredient = id_ing;
    
        FOR i in t_ing.FIRST+1..t_ing.LAST LOOP -- pentru fiecare ingredient ramas
            
            id_ing := t_ing(i);
            SELECT DISTINCT id_produs --introduc in tabloul indexat auxiliar produsele gatite cu ingredientul curent
            BULK COLLECT INTO t_prod_aux
            FROM contine
            WHERE id_ingredient = id_ing;
            
            --verificare daca exista deja produsul in lista finala
            FOR k in t_prod_aux.FIRST..t_prod_aux.LAST LOOP
                aux := 0;
                  
                FOR j in t_prod.FIRST..t_prod.LAST LOOP 
                    IF t_prod_aux(k) = t_prod(j) THEN
                        aux :=1;
                    END IF;
                END LOOP;
               
                --daca aux = 0 inseamna ca produsul nu exista deja in lista, asa ca il adaugam la final
                IF aux = 0 THEN
                    t_prod(t_prod.LAST + 1) := t_prod_aux(k);
                END IF;
               
            END LOOP;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('Produse: ');
        FOR i in t_prod.FIRST..t_prod.LAST LOOP --afisare id-uri produse
            DBMS_OUTPUT.PUT_LINE(t_prod(i));
        END LOOP;
        
        id_prod := t_prod(t_prod.FIRST); 
        SELECT DISTINCT id_comanda --initializez tabloul imbricat t_comenzi cu id-ul comenzilor ce contin primul produs din t_prod
        BULK COLLECT INTO t_comenzi
        FROM gateste_serveste
        WHERE id_produs = id_prod;
        
        FOR i in t_prod.FIRST+1..t_prod.LAST LOOP
            id_prod := t_prod(i); 
            SELECT DISTINCT id_comanda --introduc in tabloul imbricat auxiliar id-ul comenzilor ce contin primul produs din t_prod
            BULK COLLECT INTO t_comenzi_aux
            FROM gateste_serveste
            WHERE id_produs = id_prod;
            
            --verificare daca exista deja comanda in lista finala
            FOR k in t_comenzi_aux.FIRST..t_comenzi_aux.LAST LOOP
                aux := 0;
                
                FOR j in t_comenzi.FIRST..t_comenzi.LAST LOOP 
                    IF t_comenzi_aux(k) = t_comenzi(j) THEN
                        aux :=1;
                    END IF;
                END LOOP;
               
                --daca aux = 0 inseamna ca id-ul comenzii nu exista deja in lista, asa ca il adaugam la final
                IF aux = 0 THEN
                    t_comenzi.EXTEND;
                    t_comenzi(t_comenzi.LAST) := t_comenzi_aux(k);
                END IF;
            END LOOP;
        END LOOP;
          
        DBMS_OUTPUT.PUT_LINE('Comenzi: ');
        FOR i in t_comenzi.FIRST..t_comenzi.LAST LOOP --afisare id-uri comenzi
            DBMS_OUTPUT.PUT_LINE(t_comenzi(i));
        END LOOP;
        
        RETURN t_comenzi.COUNT; --returnare numar de elemente ale tabloului imbricat cu id-urile comenzilor
        
         EXCEPTION
            WHEN NO_DATA_FOUND THEN --cazul in care denumirea data nu corespunde cu denumirea unui furnizor
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun furnizor cu denumirea data');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multi furnizori cu denumirea introdusa
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi furnizori cu denumirea data');
    END p_comenzi_furnizor;
    
    --procedura ex. 7
    PROCEDURE p_produse_gatite
        (v_nume angajati.nume%TYPE,
        v_prenume angajati.prenume%TYPE)
    IS
        v_id angajati.id_angajat%TYPE;
        v_prod produse.id_produs%TYPE;
        nume_prod produse.denumire%TYPE;
        --cursor clasic
        CURSOR c_prod IS 
            SELECT DISTINCT id_produs
            FROM gateste_serveste
            WHERE id_angajat = (SELECT id_angajat
                                FROM angajati
                                WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume) 
                                        AND tip_angajat = 'bucatar'
                                );
        --ciclu cursor parametrizat
        CURSOR c_ingr(id_prod produse.id_produs%TYPE) IS 
            SELECT denumire
            FROM ingrediente 
            WHERE id_ingredient IN (SELECT id_ingredient
                                    FROM contine
                                    WHERE id_produs = id_prod
                                    );
    BEGIN
        SELECT id_angajat --selectare id bucatar
        INTO v_id
        FROM angajati
        WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume) AND tip_angajat = 'bucatar';
        --am pus si conditia ca numele introdus sa fie al unui bucatar
        
        DBMS_OUTPUT.PUT_LINE('BUCATARUL ' || initcap(v_nume) || ' ' || initcap(v_prenume));
        
        OPEN c_prod; --deschidere cursor
        LOOP FETCH c_prod INTO v_prod; --incarcare linii pe rand in variabila v_prod
        EXIT WHEN c_prod%NOTFOUND;
            SELECT denumire --selectare denumire produs
            INTO nume_prod
            FROM produse
            WHERE id_produs = v_prod;
            DBMS_OUTPUT.PUT_LINE('Produsul: ' || nume_prod);
            FOR ingr IN c_ingr(v_prod) LOOP --ciclu cursor pentru afisarea ingredientelor
                DBMS_OUTPUT.PUT_LINE('  -> ' || ingr.denumire);
            END LOOP;
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        
        --daca numarul liniilor este 0, atunci inseamna ca bucatarul nu a gatit nimic inca
        IF c_prod%ROWCOUNT = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Bucatarul dat nu a gatit niciun produs pana acum');
        END IF;
        CLOSE c_prod; --inchidere cursor
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN --cazul in care nu exista niciun bucatar cu numele dat
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun bucatar cu numele dat');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multi bucatari cu numele dat
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi bucatari cu numele dat');
    END p_produse_gatite;
    
    --functie ex. 8
    FUNCTION p_nr_produse
        (zi DATE,
        categ categorii.nume_categorie%TYPE)
    RETURN NUMBER IS
        nr NUMBER := 0;
        nr_aux NUMBER;
        TYPE t_ind IS TABLE OF produse.id_produs%TYPE
                INDEX BY PLS_INTEGER;
        v_ind t_ind; --tablou indexat pentru a retine produsele ce fac parte din categoria data
        id_ev evenimente.id_eveniment%TYPE;
        exc_categ EXCEPTION;
        exc_produse EXCEPTION;
    BEGIN
        --verific daca exista categoria
        SELECT COUNT(id_categorie)
        INTO nr
        FROM categorii
        WHERE upper(nume_categorie) = upper(categ);
        
        IF nr = 0 THEN --cazul in care categoria data nu exista
            RAISE exc_categ;
        END IF;
        
        --verific daca exista produse in categoria data
        SELECT COUNT(id_produs)
        INTO nr
        FROM produse p JOIN categorii c ON (p.id_categorie=c.id_categorie)
        WHERE upper(nume_categorie) = upper(categ);
        
        IF nr = 0 THEN --cazul in care nu exista produse in categoria data
            RAISE exc_produse;
        END IF;
        
        --selectez id-urile produselor din categoria data
        SELECT id_produs
        BULK COLLECT INTO v_ind
        FROM produse p JOIN categorii c ON (p.id_categorie=c.id_categorie)
        WHERE upper(nume_categorie) = upper(categ);
        
        --selectez id-ul evenimentului din ziua data
        SELECT id_eveniment
        INTO id_ev
        FROM evenimente
        WHERE data_eveniment = zi;
        
        nr := 0;
        FOR i IN v_ind.FIRST..v_ind.LAST LOOP
            SELECT SUM(cantitate) --retin cantitatea vanduta pentru fiecare produs in parte 
            INTO nr_aux
            FROM gateste_serveste g JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                    JOIN angajati a ON (g.id_angajat = a.id_angajat)
            WHERE c.id_eveniment = id_ev AND tip_angajat = 'ospatar'
                    AND id_produs = v_ind(i); 
                    
            nr := nr + NVL(nr_aux, 0); -- adaug cantitatea la suma totala
        END LOOP;
        
        RETURN nr; --returnez numarul de produse obtinut
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN --cazul in care nu exista un eveniment in ziua data
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun eveniment in ziua data');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multe evenimente in ziua data
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe evenimente in ziua data');
            WHEN exc_categ THEN --cazul in care categoria introdusa nu exista sau cazul in care inca nu sunt introduse produsele care fac parte din aceasta
                RAISE_APPLICATION_ERROR(-20002, 'Categoria data nu exista');
            WHEN exc_produse THEN --cazul in care inca nu sunt introduse produse care sa faca parte din categoria data
                RAISE_APPLICATION_ERROR(-20003, 'Nu exista produse care sa faca parte din categoria data');
    END p_nr_produse;
    
    --procedura ex. 9
    PROCEDURE p_furnizori_evenimente
        (v_nume clienti.nume%TYPE,
        v_prenume clienti.prenume%TYPE)
    IS  
        --cursor imbricat
        CURSOR ev(id_c clienti.id_client%TYPE) IS 
                    SELECT data_eveniment, denumire_tip, --selectez date despre eveniment
                                CURSOR(SELECT DISTINCT f.denumire --selectez furnizorii ceruti in functie de eveniment
                                       FROM furnizori f JOIN ingrediente i ON (f.id_furnizor=i.id_furnizor)
                                                        JOIN contine c ON (i.id_ingredient=c.id_ingredient)
                                                        JOIN produse p ON (p.id_produs=c.id_produs)
                                                        JOIN gateste_serveste g ON (p.id_produs=g.id_produs)
                                       WHERE g.id_comanda = c.id_comanda
                                      )
                     FROM evenimente e JOIN tipuri_evenimente t ON (e.id_tip_eveniment = t.id_tip_eveniment)
                                       JOIN comenzi c ON (e.id_eveniment = c.id_eveniment)
                                       JOIN clienti cli ON (cli.id_client = c.id_client)
                     WHERE cli.id_client = id_c;
                     
        c_furnizori SYS_REFCURSOR;
        v_id clienti.id_client%TYPE;
        data_ev evenimente.data_eveniment%TYPE;
        nume_tip tipuri_evenimente.denumire_tip%TYPE;
        TYPE tablou_indexat IS TABLE OF furnizori.denumire%TYPE INDEX BY PLS_INTEGER;
        t_furnizori  tablou_indexat; --tablou indexat pt a retine denumirea furnizorilor
        exc EXCEPTION;
    BEGIN
        SELECT id_client --selectez id-ul clientului introdus
        INTO v_id
        FROM clienti
        WHERE upper(nume)=upper(v_nume) AND upper(prenume)=upper(v_prenume);
        
        OPEN ev(v_id); --deschid cursorul 
        
        LOOP
            FETCH ev INTO data_ev, nume_tip, c_furnizori;
            EXIT WHEN ev%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE('Eveniment: ' || nume_tip || ' din data ' || TO_CHAR(data_ev));
            FETCH c_furnizori BULK COLLECT INTO t_furnizori;
            
            IF  t_furnizori.COUNT = 0 THEN 
                DBMS_OUTPUT.PUT_LINE('Pentru acest eveniment nu au fost date comenzi');
            ELSE
                FOR i IN t_furnizori.FIRST..t_furnizori.LAST LOOP
                    DBMS_OUTPUT.PUT_LINE(i|| '. '|| t_furnizori(i)); --afisez furnizorii
                END LOOP;
            END IF;
            
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        
        IF ev%ROWCOUNT = 0 THEN --cazul in care clientul nu a dat nicio comanda pentru un eveniment
            RAISE exc;
        END IF;
        
        CLOSE ev;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN -- cazul in care nu exista niciun client cu numele dat 
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun client cu numele dat');
            WHEN TOO_MANY_ROWS THEN -- cazul in care exista mai multi clienti cu numele dat
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multi clienti cu numele dat');
            WHEN exc THEN -- cazul in care clientul nu a dat nicio comanda pentru un eveniment
                RAISE_APPLICATION_ERROR(-20002, 'Clientul dat nu a dat nicio comanda pentru un eveniment');
    END p_furnizori_evenimente;
END pachet_proiect;
/

BEGIN
    --apelare functie ex 6 - din pachet:
    DBMS_OUTPUT.PUT_LINE('Numarul de comenzi: ' || pachet_proiect.p_comenzi_furnizor('SC Delicios'));
END;
/
BEGIN
    --apelare procedura ex 7 - din pachet:
    pachet_proiect.p_produse_gatite('Vilcu', 'Elena');
END;
/
BEGIN
    --apelare functie ex 8 - din pachet:
    DBMS_OUTPUT.PUT_LINE('Au fost comandate ' || pachet_proiect.p_nr_produse(TO_DATE('03-APR-21'), 'friptura') || ' produse din aceasta categorie');
END;
/
BEGIN
    --apelare procedura ex 9 - din pachet:
    pachet_proiect.p_furnizori_evenimente('Popescu', 'Maria'); 
END;
/

--14.
--Definiti un pachet care prin intermediul mai multor subprograme sa realizeze statistica incasarilor si produselor comandate 
--pe o perioada de timp. Pachetul va contine:
-- o functie care pentru un an dat ca parametru returneaza suma incasarilor restaurantului in acel an
-- o functie care returneaza unul dintre cele mai bine vandute produse dintr-un an
-- o functie care primeste ca parametrii denumirea unui produs si un an si returneaza o lista cu id-urile bucatarilor care au gatit produsul in anul dat
-- o procedura care primeste ca parametrii un an si un nr n si afiseaza un top n cele mai bine vandute produse in acel an
-- o procedura care primeste ca parametrii un an si un nr n si afiseaza suma incasarilor, nr produselor comandate din fiecare categorie 
--si un top n al produselor din acel an (folosind subprogramele definite anterior)
-- o procedura care primeste ca parametrii denumirea unui produs si un an si afiseaza suma incasarilor obtinute in urma vanzarii 
--produsului in anul dat si ce procent reprezinta aceasta din suma totala obtinuta, cat si o lista a bucatarilor care au gatit acest produs
-- o procedura care primeste un interval de ani ca parametru si afiseaza pentru fiecare an din acest interval o analiza detaliata a anului 
--(suma incasarilor, numarul de produse comandate din fiecare categorie, top 3 cele mai bine vandute produse) si apoi o analiza  
--a unuia dintre cele mai bine vandute produse in acel an (incasari din vanzarea acestuia, procent incasari din totalul incasarilor, 
--lista bucatarilor care au gatit acest produs) (folosind subprogramele definite anterior)

CREATE OR REPLACE PACKAGE statistica AS
    TYPE tablou_imb_prod IS TABLE OF produse.id_produs%TYPE;
    TYPE vector_bucatari IS VARRAY(50) OF angajati.id_angajat%TYPE;
    
    -- functie care pentru un an dat ca parametru returneaza suma incasarilor restaurantului in acel an
    FUNCTION incasari_an(an NUMBER)
        RETURN NUMBER;
    
    -- functie care returneaza unul dintre cele mai bine vandute produse dintr-un an
    FUNCTION produs_top1(an NUMBER) 
        RETURN produse.denumire%TYPE;
    
    -- functie care primeste ca parametrii denumirea unui produs si un an si returneaza o lista cu id-urile bucatarilor 
    --care au gatit produsul in anul dat
    FUNCTION bucatari_pentru(prod produse.denumire%TYPE,
                            an NUMBER)
        RETURN vector_bucatari;
        
    -- procedura care primeste ca parametrii un an si un nr n si afiseaza un top n cele mai bine vandute produse in acel an
    PROCEDURE produse_top_n(an NUMBER,
                            n_top NUMBER);
    
    -- o procedura care primeste ca parametrii un an si un nr n si afiseaza suma incasarilor, nr produselor comandate din fiecare categorie 
    --si un top n al produselor din acel an (folosind subprogramele definite anterior)
    PROCEDURE analiza_an(an NUMBER,
                        n NUMBER);
                        
    -- procedura care primeste ca parametrii denumirea unui produs si un an si afiseaza suma incasarilor obtinute in urma vanzarii 
    --produsului in anul dat si ce procent reprezinta aceasta din suma totala obtinuta, cat si o lista a bucatarilor care au gatit acest produs
    PROCEDURE analiza_produs(prod produse.denumire%TYPE,
                             an NUMBER);
                             
    -- procedura care primeste un interval de ani ca parametru si afiseaza pentru fiecare an din acest interval o analiza detaliata a anului 
    --(suma incasarilor, numarul de produse comandate din fiecare categorie, top 3 cele mai bine vandute produse) si apoi o analiza  
    --a unuia dintre cele mai bine vandute produse in acel an (incasari din vanzarea acestuia, procent incasari din totalul incasarilor, 
    --lista bucatarilor care au gatit acest produs)
    PROCEDURE analiza_interval (an_s NUMBER, 
                                an_e NUMBER);
END statistica;
/
CREATE OR REPLACE PACKAGE BODY statistica AS
    -- functie care pentru un an dat ca parametru returneaza suma incasarilor restaurantului in acel an
    FUNCTION incasari_an(an NUMBER)
        RETURN NUMBER 
    IS
        incasari NUMBER;
    BEGIN
        SELECT SUM(cantitate * pret) --calculam incasarile ca fiind suma dintre cantitatea de produse * pret
        INTO incasari
        FROM gateste_serveste g JOIN produse p ON (g.id_produs = p.id_produs)
                                JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                JOIN angajati a ON (g.id_angajat = a.id_angajat)
        WHERE tip_angajat='ospatar' AND TO_CHAR(data_comanda, 'YYYY') = an
        GROUP BY TO_CHAR(data_comanda, 'YYYY')
        HAVING TO_CHAR(data_comanda, 'YYYY') = an;
        
        RETURN incasari; --returnam suma calculata
        
        EXCEPTION
            WHEN no_data_found THEN --inseamna ca nu exista comenzi in acel an, deci incasarile sunt 0
                RETURN 0; 
    END incasari_an;
    
    -- functie care returneaza unul dintre cele mai bine vandute produse dintr-un an
    FUNCTION produs_top1(an NUMBER) 
        RETURN produse.denumire%TYPE
    IS
        nr_prod_max NUMBER;
        v_produse tablou_imb_prod := tablou_imb_prod();
        nume_prod produse.denumire%TYPE;
        id_max produse.id_produs%TYPE;
    BEGIN
        SELECT MAX(SUM(cantitate)) --selectez cantitatea maxima de produse vandute
        INTO nr_prod_max
        FROM gateste_serveste g JOIN produse p ON (g.id_produs = p.id_produs)
                                JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                JOIN angajati a ON (g.id_angajat = a.id_angajat)
        WHERE tip_angajat='ospatar' AND TO_CHAR(data_comanda, 'YYYY') = an
        GROUP BY g.id_produs; 
        
        SELECT g.id_produs --introduc in tabloul imbricat v_produse toate produsele din care s-a vandut 
                           -- o cantitate egala cu cantitatea maxima calculata mai sus
        BULK COLLECT INTO v_produse
        FROM gateste_serveste g JOIN produse p ON (g.id_produs = p.id_produs)
                                JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                JOIN angajati a ON (g.id_angajat = a.id_angajat)
        WHERE tip_angajat='ospatar' AND TO_CHAR(data_comanda, 'YYYY') = an
        GROUP BY g.id_produs
        HAVING SUM(cantitate) = nr_prod_max; 
        
        IF v_produse.COUNT > 0 THEN
            --pentru ca ne trebuie un singur produs dintre cele mai bine vandute, luam numai primul produs, cel de pe prima pozitie in tablou
            id_max := v_produse(v_produse.FIRST);
            SELECT denumire
            INTO nume_prod
            FROM produse
            WHERE id_produs = id_max;
            
            RETURN nume_prod;
        ELSE
            RETURN '0'; --cazul in care in acel an nu a fost plasata nicio comanda
        END IF;
    END produs_top1;
    
    -- functie care primeste ca parametrii denumirea unui produs si un an si returneaza o lista cu id-urile bucatarilor 
    --care au gatit produsul in anul dat 
    FUNCTION bucatari_pentru(prod produse.denumire%TYPE, an NUMBER)
        RETURN vector_bucatari
    IS
        vec_bucatari vector_bucatari := vector_bucatari();
        id_prod produse.id_produs%TYPE;
    BEGIN
        SELECT id_produs --selectez id-ul produsului cu denumirea data
        INTO id_prod
        FROM produse
        WHERE upper(denumire) = upper(prod);
        
        SELECT DISTINCT g.id_angajat --introduc in vector id-urile bucatarilor care au gatit produsul dat
        BULK COLLECT INTO vec_bucatari
        FROM angajati a JOIN gateste_serveste g ON (a.id_angajat = g.id_angajat)
                        JOIN comenzi c ON (g.id_comanda = c.id_comanda)
        WHERE tip_angajat = 'bucatar' AND TO_CHAR(data_comanda, 'YYYY') = an
                AND g.id_produs = id_prod;
        
        RETURN vec_bucatari; --returnez vectorul obtinut
        
        EXCEPTION
            WHEN no_data_found THEN -- cazul in care nu exista niciun produs cu denumirea data
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun produs cu denumirea data');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multe produse cu denumirea data
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe produse cu denumirea data');
    END bucatari_pentru;
    
    -- procedura care primeste ca parametru un an si un nr n si afiseaza un top n cele mai bine vandute produse in acel an
    PROCEDURE produse_top_n(an NUMBER,
                            n_top NUMBER)
    IS
        nr_top NUMBER := 0;
        trecere NUMBER := 0;
        cant_anterioara NUMBER;
        nume produse.denumire%TYPE;
        cantitate gateste_serveste.cantitate%TYPE;
        aux NUMBER := 0;
    
        CURSOR c_prod --cursor pentru a procesa denumirea produselor alaturi de cantitate in ordine descrescatoare a cantitatii vandute
        IS
            SELECT MAX(denumire), SUM(cantitate)
            FROM produse p JOIN gateste_serveste g ON (p.id_produs = g.id_produs)
                           JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                           JOIN angajati a ON (g.id_angajat = a.id_angajat)
            WHERE tip_angajat='ospatar' AND TO_CHAR(data_comanda, 'YYYY') = an
            GROUP BY p.id_produs
            ORDER BY SUM(cantitate) DESC;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Top ' || n_top || ' produse:');
        OPEN c_prod; --deschidem cursorul
        LOOP
            FETCH c_prod INTO nume, cantitate;
            EXIT WHEN c_prod%NOTFOUND OR nr_top = n_top; --ne oprim cand nu mai sunt produse de procesat sau cand deja avem top n
            trecere := trecere + 1;
            IF trecere = 1 THEN
                cant_anterioara := cantitate; --la inceput cantitatea anterioara devine cantitatea primului produs
                nr_top := nr_top + 1;
            END IF;
            
            IF cant_anterioara <> cantitate THEN --crestem o pozitie in top cand gasim o noua cantitate
                nr_top := nr_top + 1;
                cant_anterioara := cantitate;
            aux := 1;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE(nr_top || '. ' || nume);
        END LOOP;
        CLOSE c_prod; 
        FOR i IN nr_top+1..n_top LOOP -- pentru pozitiile din top ramase necompletate afisam o -
            DBMS_OUTPUT.PUT_LINE(i || '. -');
        END LOOP;
    END produse_top_n;
    
    -- o procedura care primeste ca parametru un an si un nr n si afiseaza suma incasarilor, nr produselor comandate din fiecare categorie 
    --si un top n al produselor din acel an (folosind subprogramele definite anterior)
    PROCEDURE analiza_an(an NUMBER,
                        n NUMBER)
    IS
        nr NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Suma incasari: ' || incasari_an(an)); --afisam incasarile din anul dat
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Nr de produse comandate din ');
            
        FOR categ IN (SELECT nume_categorie 
                        FROM categorii) LOOP --pentru fiecare categorie
            SELECT SUM(cantitate) --calculez nr de produse comandate
            INTO nr
            FROM produse p  JOIN gateste_serveste g ON (p.id_produs = g.id_produs)
                            JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                            JOIN angajati a ON (g.id_angajat = a.id_angajat)
                            JOIN categorii cat ON (p.id_categorie = cat.id_categorie)
            WHERE tip_angajat='ospatar' AND TO_CHAR(data_comanda, 'YYYY') = an
                    AND nume_categorie = categ.nume_categorie;
                        
            DBMS_OUTPUT.PUT_LINE('- categoria ' || categ.nume_categorie || ' -> ' || NVL(nr, 0) || ' produse');
                
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
        produse_top_n(an, n); --apelam procedura pentru a afisa top n produse
        DBMS_OUTPUT.NEW_LINE;
    END analiza_an;
    
    -- procedura care primeste ca parametru denumirea unui produs si un an si afiseaza suma incasarilor obtinute in urma vanzarii 
    --produsului in anul dat si ce procent reprezinta aceasta din suma totala obtinuta, cat si o lista a bucatarilor care au gatit acest produs
    PROCEDURE analiza_produs(prod produse.denumire%TYPE,
                             an NUMBER)
    IS
        incasari_totale NUMBER := 0;
        incasari_produs NUMBER := 0;
        an_curent NUMBER;
        procent NUMBER;
        id_prod produse.id_produs%TYPE;
        vec_bucatari vector_bucatari := vector_bucatari();
    BEGIN
        SELECT id_produs --selectez id-ul produsului cu denumirea data
        INTO id_prod
        FROM produse
        WHERE upper(denumire) = upper(prod);
        
        incasari_totale := incasari_an(an);
        
        SELECT NVL(SUM(cantitate * pret), 0) --calculam incasarile obtinute in urma vanzarii produsului dat
        INTO incasari_produs
        FROM gateste_serveste g JOIN produse p ON (g.id_produs = p.id_produs)
                                JOIN comenzi c ON (g.id_comanda = c.id_comanda)
                                JOIN angajati a ON (g.id_angajat = a.id_angajat)
        WHERE tip_angajat='ospatar' AND g.id_produs = id_prod
                AND TO_CHAR(data_comanda, 'YYYY') = an;
        
        DBMS_OUTPUT.PUT_LINE('Incasari din urma vanzarii produsului: ' || incasari_produs);
        
        procent := TRUNC((incasari_produs * 100) / incasari_totale, 2); --calculam procentul 
        
        DBMS_OUTPUT.PUT_LINE('Procent din suma totala a incasarilor: ' || procent || '%');
        DBMS_OUTPUT.NEW_LINE;
        
        vec_bucatari := bucatari_pentru(prod, an);
        IF vec_bucatari.COUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Bucatarii care au gatit acest produs: '); --afisam si bucatarii care au gatit acest produs
            FOR i IN vec_bucatari.FIRST..vec_bucatari.LAST LOOP
                DBMS_OUTPUT.PUT_LINE(i || '. ' || vec_bucatari(i));
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Acest produs nu este gatit.'); --face parte din categoria bauturi
        END IF;
        vec_bucatari.delete;
        
        EXCEPTION
            WHEN no_data_found THEN -- cazul in care nu exista niciun produs cu denumirea data
                RAISE_APPLICATION_ERROR(-20000, 'Nu exista niciun produs cu denumirea data');
            WHEN TOO_MANY_ROWS THEN --cazul in care exista mai multe produse cu denumirea data
                RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe produse cu denumirea data');
    END analiza_produs;
    
    -- procedura care primeste un interval de ani ca parametru si afiseaza pentru fiecare an din acest interval o analiza detaliata a anului 
    --(suma incasarilor, numarul de produse comandate din fiecare categorie, top 3 cele mai bine vandute produse) si apoi o analiza  
    --a unuia dintre cele mai bine vandute produse in acel an (incasari din vanzarea acestuia, procent incasari din totalul incasarilor, 
    --lista bucatarilor care au gatit acest produs)
    PROCEDURE analiza_interval (an_s NUMBER, 
                                an_e NUMBER)
    IS
        exc_interval EXCEPTION;
        an_aux NUMBER;
        an_curent NUMBER;
        an_start NUMBER;
        an_end NUMBER;
        produs1 produse.denumire%TYPE;
    BEGIN
        an_start := an_s;
        an_end := an_e;
        an_curent := TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'));
        
        --verificam intervalul dat
        IF an_start > an_end THEN --daca anii nu sunt in ordine crescatoare ii interschimbam
            an_aux := an_start;
            an_start := an_end;
            an_end := an_aux;
        END IF;
        
        IF an_start < 2019 THEN
            an_start := 2019; --pornim cu anul 2019 daca anul de start dat este mai mic decat acesta
            IF an_end < 2019 THEN --daca ambii ani sunt mai mici decat 2019, aruncam o exceptie
                RAISE exc_interval;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Restaurantul a fost infiintat in anul 2019. Analiza afisata va incepe cu acest an.');
        END IF;
        
        IF an_end > an_curent THEN
            an_end := an_curent; --incheiem cu anul curent daca anul de incheiere dat este mai mare
            IF an_start > an_curent THEN --daca ambii ani sunt mai mari decat anul curent, aruncam o exceptie
                RAISE exc_interval;
            END IF;
            DBMS_OUTPUT.PUT_LINE('Nu poate fi afisata analiza pe anii urmatori. Analiza se va termina cu anul curent.');
        END IF;
        
        --afisare analiza pentru fiecare an
        FOR i IN an_start..an_end LOOP
            DBMS_OUTPUT.PUT_LINE('-----------------------------');
            DBMS_OUTPUT.PUT_LINE('ANUL ' || i);
            
            analiza_an(i, 3); --apelam procedura definita anterior pentru analiza anului
            
            produs1 := produs_top1(i);
            IF produs1 != '0' THEN 
                DBMS_OUTPUT.PUT_LINE('Cel mai vandut produs: ' || produs1); --afisam si unul dintre cele mai bine vandute produse
                DBMS_OUTPUT.NEW_LINE;
                analiza_produs(produs1, i); --apelam procedura definita anterior pentru analiza produsului
            ELSE
                DBMS_OUTPUT.PUT_LINE('Nu au fost plasate comenzi in acest an.');
            END IF;
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;
            
        EXCEPTION
            WHEN exc_interval THEN
                RAISE_APPLICATION_ERROR(-20000, 'Interval invalid! Introduceti un interval intre 2019 si anul curent.');
    END analiza_interval;
END statistica;
/

BEGIN
    statistica.analiza_interval(2017, 2023);
    --statistica.analiza_interval(2017, 2018); --exceptie: interval invalid
END;
/
--pentru a introduce cei doi ani de la tastatura:
DECLARE
    an_start NUMBER := &p_an_start;
    an_end NUMBER := &p_an_end;
BEGIN
    statistica.analiza_interval(an_start, an_end);
END;