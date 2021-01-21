--4
alter session 
set nls_language = 'AMERICAN';

create table sponsori(
    id_sponsor number(6) constraint sponsori_pk primary key,
    nume varchar2(20) unique constraint sponsori_nn not null,
    email varchar2(30),
    telefon varchar2(10),
    adresa varchar2(100)
);

create table campionate(
    id_campionat number(4) constraint campionate_pk primary key,
    id_sponsor number(6) constraint campionate_fk references sponsori(id_sponsor),
    nume varchar2(50) unique constraint campionate_nn1 not null,
    sezon number(4) constraint campionate_nn2 not null check (sezon between 2010 and 2030)
);

alter table campionate
drop constraint campionate_fk;
alter table campionate
add constraint campionate_fk foreign key(id_sponsor) references sponsori(id_sponsor) on delete set null;

create table etape(
    id_etapa number(6) constraint etape_pk primary key,
    id_campionat number(6) constraint etape_fk references campionate(id_campionat) on delete cascade,
    nume varchar2(30) unique constraint etape_nn1 not null,
    oras varchar2(20) constraint etape_nn2 not null,
    data date constraint etape_nn3 not null
);

create table echipe(
    id_echipa varchar2(5) constraint echipe_pk primary key,
    nume varchar2(20) unique constraint echipe_nn not null
);

create table clase(
    id_clasa varchar2(3) constraint clase_pk primary key,
    nume varchar2(5) unique constraint clase_nn1 not null,
    putere_min number(3) constraint clase_nn2 not null check (putere_min between 200 and 999),
    putere_max number(3) constraint clase_nn3 not null check (putere_max between 200 and 999),
    check (putere_min < putere_max)
);

create table producatori(
    id_producator varchar2(5) constraint producatori_pk primary key,
    nume varchar2(30) constraint producatori_nn not null,
    email varchar2(30),
    telefon varchar2(10),
    tara varchar2(20),
    adresa varchar2(60)
);

create table masini(
    id_masina number(3) constraint masini_pk primary key,
    id_producator varchar2(5) constraint masini_fk references producatori(id_producator),
    model varchar2(15),
    putere number(3) constraint masini_nn not null check (putere between 200 and 999)
);

alter table masini
drop constraint masini_fk;
alter table masini
add constraint masini_fk foreign key(id_producator) references producatori(id_producator) on delete set null;

create table piloti(
    id_pilot number(3) constraint piloti_pk primary key,
    nume varchar2(15) constraint piloti_nn1 not null,
    prenume varchar2(15) constraint piloti_nn2 not null,
    id_masina number(3) unique constraint piloti_fk1 references masini(id_masina),
    id_clasa varchar2(3) constraint piloti_fk2 references clase(id_clasa),
    id_echipa varchar2(5) constraint piloti_fk3 references echipe(id_echipa) on delete cascade
);

alter table piloti
drop constraint piloti_fk1;
alter table piloti
add constraint piloti_fk1 foreign key(id_masina) references masini(id_masina) on delete set null;

alter table piloti
drop constraint piloti_fk2;
alter table piloti
add constraint piloti_fk2 foreign key(id_clasa) references clase(id_clasa) on delete set null;

create table sponsori_echipe(
    id_sponsor number(6) constraint sponsori_echipe_fk1 references sponsori(id_sponsor),
    id_echipa varchar2(5) constraint sponsori_echipe_fk2 references echipe(id_echipa),
    sezon number(4) constraint sponsori_echipe_nn not null check (sezon between 2010 and 2030),
    primary key(id_sponsor, id_echipa, sezon)
);

alter table sponsori_echipe
drop constraint sponsori_echipe_fk1;
alter table sponsori_echipe
add constraint sponsori_echipe_fk1 foreign key(id_sponsor) references sponsori(id_sponsor) on delete cascade;

alter table sponsori_echipe
drop constraint sponsori_echipe_fk2;
alter table sponsori_echipe
add constraint sponsori_echipe_fk2 foreign key(id_echipa) references echipe(id_echipa) on delete cascade;

create table piloti_etape(
    id_pilot number(3) constraint piloti_etape_fk1 references piloti(id_pilot),
    id_etapa number(6) constraint piloti_etpae_fk2 references etape(id_etapa),
    pozitie_clasament number(3) check (pozitie_clasament between 1 and 999),
    primary key(id_pilot, id_etapa)
);

alter table piloti_etape
drop constraint piloti_etape_fk1;
alter table piloti_etape
add constraint piloti_etape_fk1 foreign key(id_pilot) references piloti(id_pilot) on delete cascade;

alter table piloti_etape
drop constraint piloti_etpae_fk2;
alter table piloti_etape
add constraint piloti_etape_fk2 foreign key(id_etapa) references etape(id_etapa) on delete cascade;

--5
--SPONSORI
create sequence id_sponsori
start with 1
increment by 1;

insert into sponsori(id_sponsor, nume)
values (id_sponsori.nextval, 'Kaufland');

insert into sponsori
values (id_sponsori.nextval, 'Dunlop', 'dunlop@gmail.com', '0734990999', 'Bucuresti, Sector 6, Splaiul Independentei, 143');

insert into sponsori
values (id_sponsori.nextval, 'Microsoft', 'microsoft@outlook.com', '0739923674', 'Bucuresti, Sector 1, Bulevardul Marasti, 89');

insert into sponsori(id_sponsor, nume)
values (id_sponsori.nextval, 'Dedeman');

insert into sponsori(id_sponsor, nume)
values (id_sponsori.nextval, 'Betano');

insert into sponsori(id_sponsor, nume, email, telefon)
values (id_sponsori.nextval, 'City Insurance', 'city_insurance@yahoo.com', '0732256780');

--CAMPIONATE
create sequence id_campionate
start with 1
increment by 1;

insert into campionate(id_campionat, id_sponsor, nume, sezon)
values (id_campionate.nextval, 5, 'Campionat Betano 2019', 2019);

insert into campionate
values (id_campionate.nextval, 2, 'Campionat Dunlop 2015', 2015);

insert into campionate
values (id_campionate.nextval, 2, 'Campionat Dunlop 2016', 2016);

insert into campionate
values (id_campionate.nextval, 6, 'Campionat City Insurance 2020', 2020);

insert into campionate
values (id_campionate.nextval, 1, 'Campionat Kaufland 2017', 2017);

insert into campionate
values (id_campionate.nextval, 3, 'Campionat Microsoft 2018', 2018);

insert into campionate
values (id_campionate.nextval, 2, 'Campionat Dunlop 2021', 2021);

--ETAPE
create sequence id_etape
start with 1
increment by 1;

insert into etape(id_etapa, id_campionat, nume, oras, data)
values (id_etape.nextval, 1, 'Etapa Brasov 2019', 'Brasov', to_date('24-03-2019', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 1, 'Etapa Campulung 2019', 'Campulung', to_date('22-09-2019', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 2, 'Etapa Resita 2015', 'Resita', to_date('12-07-2015', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 4, 'Etapa Sinaia 2020', 'Sinaia', to_date('26-04-2020', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 6, 'Etapa Sinaia 2018', 'Sinaia', to_date('15-04-2018', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 5, 'Etapa Cluj 2017', 'Cluj', to_date('06-08-2017', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 2, 'Etapa Cheile Gradistei 2015', 'Cheile Gradistei', to_date('06-09-2015', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 3, 'Etapa Ranca 2016', 'Ranca', to_date('22-05-2015', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 4, 'Etapa Ranca 2020', 'Ranca', to_date('24-05-2020', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 1, 'Etapa Ranca 2019', 'Ranca', to_date('19-05-2019', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 4, 'Etapa Sibiu 2020', 'Sibiu', to_date('28-06-2020', 'dd-mm-yyyy'));

insert into etape
values (id_etape.nextval, 3, 'Etapa Campulung 2016', 'Campulung', to_date('25-09-2016', 'dd-mm-yyyy'));

--ECHIPE
insert into echipe
values ('HNDRT', 'Honda Racing Team');

insert into echipe
values ('DTORT', 'DTO Racing Team');

insert into echipe
values ('RVRT', 'Rally West Racing');

insert into echipe
values ('RBRT', 'Red Bull Racing Team');

insert into echipe
values ('MTSRT', 'Mitsubishi Racing');

--CLASE
insert into clase(id_clasa, nume, putere_min, putere_max)
values ('CH3', 'H3', 500, 550);

insert into clase
values ('CB2', 'B2', 300, 350);

insert into clase
values ('CH4', 'H4', 551, 600);

insert into clase
values ('CA1', 'A1', 200, 250);

insert into clase
values ('CD4', 'D4', 450, 499);

--PRODUCATORI
insert into producatori(id_producator, nume, email, telefon, tara, adresa)
values ('MTS', 'Mitsubishi', 'mitsubishi@gmail.com', '0982334510', 'Japonia', 'Tokyo');

insert into producatori(id_producator, nume, tara)
values ('HND', 'Honda', 'Japonia');

insert into producatori(id_producator, nume)
values ('BMW', 'BMW');

insert into producatori(id_producator, nume, tara, adresa)
values ('RNT', 'Renault', 'Franta', 'Paris');

insert into producatori(id_producator, nume, tara)
values ('MRC', 'Mercedes', 'Germania');

--MASINI
create sequence id_masini
start with 1
increment by 1;

insert into masini(id_masina, id_producator, model, putere)
values (id_masini.nextval, 'RNT', 'Clio', 300);

insert into masini
values (id_masini.nextval, 'BMW', 'M3', 500);

insert into masini
values (id_masini.nextval, 'MRC', 'Benz 190', 480);

insert into masini
values (id_masini.nextval, 'MTS', 'Lancer Evo 8', 600);

insert into masini
values (id_masini.nextval, 'MTS', 'Lancer Evo 5', 590);

insert into masini
values (id_masini.nextval, 'HND', 'Civic', 280);

insert into masini
values (id_masini.nextval, 'MTS', 'Lancer Evo 8', 620);

--PILOTI
create sequence id_piloti
start with 1
increment by 1;

insert into piloti(id_pilot, nume, prenume, id_masina, id_clasa, id_echipa)
values (id_piloti.nextval, 'Popescu', 'Dan', 3, 'CD4', 'RVRT');

insert into piloti
values (id_piloti.nextval, 'Andronic', 'Paul', 5, 'CH4', 'RVRT');

insert into piloti
values (id_piloti.nextval, 'Manolache', 'Ionut', 6, 'CB2', 'HNDRT');

insert into piloti
values (id_piloti.nextval, 'Stefanescu', 'Andrei', 1, 'CB2', 'RBRT');

insert into piloti
values (id_piloti.nextval, 'Radu', 'Mihai', 2, 'CH3', 'DTORT');

insert into piloti
values (id_piloti.nextval, 'Voinea', 'Ciprian', 4, 'CH4', 'MTSRT');

--SPONOSRI_ECHIPE
insert into sponsori_echipe(id_sponsor, id_echipa, sezon)
values (4, 'HNDRT', 2018);

insert into sponsori_echipe
values (5, 'HNDRT', 2018);

insert into sponsori_echipe
values (4, 'HNDRT', 2016);

insert into sponsori_echipe
values (5, 'DTORT', 2020);

insert into sponsori_echipe
values (6, 'RVRT', 2020);

insert into sponsori_echipe
values (3, 'MTSRT', 2019);

insert into sponsori_echipe
values (2, 'RBRT', 2015);

insert into sponsori_echipe
values (2, 'MTSRT', 2015);

insert into sponsori_echipe
values (2, 'RVRT', 2015);

insert into sponsori_echipe
values (5, 'RVRT', 2018);

insert into sponsori_echipe
values (1, 'DTORT', 2019);

insert into sponsori_echipe
values (5, 'MTSRT', 2017);

--PILOTI_ETAPE
insert into piloti_etape(id_pilot, id_etapa, pozitie_clasament)
values (1, 6, 5);

insert into piloti_etape
values (1, 11, 12);

insert into piloti_etape
values (1, 12, 9);

insert into piloti_etape
values (1, 1, 14);

insert into piloti_etape
values (1, 2, 7);

insert into piloti_etape
values (2, 1, 3);

insert into piloti_etape
values (2, 2, 2);

insert into piloti_etape
values (2, 4, 7);

insert into piloti_etape
values (2, 6, 1);

insert into piloti_etape
values (2, 7, 1);

insert into piloti_etape
values (2, 10, 4);

insert into piloti_etape
values (3, 2, 10);

insert into piloti_etape
values (3, 8, 19);

insert into piloti_etape
values (3, 9, 19);

insert into piloti_etape
values (4, 1, 13);

insert into piloti_etape
values (4, 11, 20);

insert into piloti_etape
values (5, 1, 1);

insert into piloti_etape
values (5, 9, 2);

insert into piloti_etape
values (5, 10, 7);

insert into piloti_etape
values (5, 11, 8);

insert into piloti_etape
values (6, 1, 3);

insert into piloti_etape
values (6, 2, 1);

insert into piloti_etape
values (6, 4, 6);

insert into piloti_etape
values (6, 9, 3);

insert into piloti_etape
values (6, 10, 1);

insert into piloti_etape
values (6, 11, 10);

insert into piloti_etape
values (6, 12, 1);


--6
/*  Definiti un subprogram stocat care sa afiseze clasamentul general(piloti si echipe) pentru un campionat al carui sezon 
este dat ca parametru de la tastatura. Pentru un pilot, in cadrul unei etape, se obtin punctajele: 25, 18, 15, 12, 10, 8, 6, 4,
2, 1, iar echipa acumuleaza suma punctajelor obtinute de pilotii sai intr-o etapa.*/
create or replace procedure clasament(sezon number) is
    type info_pilot is record(cod piloti.id_pilot % type,
                              nume piloti.nume % type,
                              prenume piloti.prenume % type, 
                              echipa piloti.id_echipa % type);
    type info_echipa is record(cod echipe.id_echipa % type,
                               nume echipe.nume % type);
    type vector_piloti is varray(1000) of info_pilot;
    type vector_echipe is varray(1000) of info_echipa;
    type vector is varray(1000) of number(3);
    type tablou_indexat is table of number index by pls_integer;
    type tablou_indexat2 is table of number index by varchar2(5);
    type tablou_inregistrari is table of piloti_etape % rowtype;
    type vector_punctaje is varray(10) of number(2);
    
    punctaje_piloti vector := vector();
    punctaje_echipe vector := vector();
    punctaje vector_punctaje := vector_punctaje();
    info_piloti vector_piloti := vector_piloti();
    info_echipe vector_echipe := vector_echipe();
    inreg tablou_inregistrari := tablou_inregistrari();
    pozitie_cod tablou_indexat;
    pozitie_cod_ec tablou_indexat2;
    p_cod number(3);
    p_clasam number(3);
    s number(4);
    aux number(4);
    aux2 info_pilot;
    aux3 info_echipa;
begin
    aux := sezon;
    select c.sezon
    into s
    from campionate c
    where c.sezon = aux;

    select id_pilot, nume, prenume, id_echipa
    bulk collect into info_piloti   -- vector cu informatii despre piloti
    from piloti;
    
    select id_echipa, nume
    bulk collect into info_echipe
    from echipe;        -- vector cu informatii despre echipe
    
    for i in info_piloti.first..info_piloti.last loop
        pozitie_cod(info_piloti(i).cod) := i;    -- pozitie_cod(c) = pozitia pilotului cu codul c in vectorul de informatii
        punctaje_piloti.extend;
        punctaje_piloti(i) := 0;
    end loop;
    
    for i in info_echipe.first..info_echipe.last loop
        pozitie_cod_ec(info_echipe(i).cod) := i; -- pozitie_cod_ec(c) = pozitia echipei cu codul c in vectorul de informatii
        punctaje_echipe.extend;
        punctaje_echipe(i) := 0;
    end loop;
    
    punctaje.extend;
    punctaje(1) := 25;
    punctaje.extend;
    punctaje(2) := 18;
    punctaje.extend;
    punctaje(3) := 15;
    punctaje.extend;
    punctaje(4) := 12;
    punctaje.extend;
    punctaje(5) := 10;
    punctaje.extend;
    punctaje(6) := 8;
    punctaje.extend;
    punctaje(7) := 6;
    punctaje.extend;
    punctaje(8) := 4;
    punctaje.extend;
    punctaje(9) := 2;
    punctaje.extend;
    punctaje(10) := 1;  -- punctaje(i) = puncte pentru pozitia i
    
    select *
    bulk collect into inreg
    from piloti_etape
    where id_etapa in (select id_etapa
                       from etape
                       where to_char(data, 'yyyy') = to_char(sezon));  
        -- informatii despre participarile la etapele din sezonul curent
    
    for i in inreg.first..inreg.last loop
        if inreg(i).pozitie_clasament <= 10 then
            p_cod := pozitie_cod(inreg(i).id_pilot);
            p_clasam := inreg(i).pozitie_clasament;
            punctaje_piloti(p_cod) := punctaje_piloti(p_cod) + punctaje(p_clasam);
        end if;
    end loop;
    
    for i in punctaje_piloti.first..(punctaje_piloti.last - 1) loop   -- sortare piloti dupa punctaj
        for j in (i + 1)..punctaje_piloti.last loop
            if punctaje_piloti(i) < punctaje_piloti(j) then
                aux := punctaje_piloti(i);
                punctaje_piloti(i) := punctaje_piloti(j);
                punctaje_piloti(j) := aux;          -- interschimbare punctaje
                
                pozitie_cod(info_piloti(i).cod) := j;
                pozitie_cod(info_piloti(j).cod) := i;    -- interschimabre pozitii coduri piloti
                
                aux2 := info_piloti(i);
                info_piloti(i) := info_piloti(j);
                info_piloti(j) := aux2;               -- interschimabre coduri piloti
            end if;
        end loop;
    end loop;
    
    dbms_output.put_line('----------CLASAMENT PILOTI ' || sezon || '----------');
    for i in punctaje_piloti.first..punctaje_piloti.last loop
        p_cod := pozitie_cod_ec(info_piloti(i).echipa);
        punctaje_echipe(p_cod) := punctaje_echipe(p_cod) + punctaje_piloti(i);  -- calcul punctaje echipe
        dbms_output.put_line(i || '. ' || info_piloti(i).nume || ' ' || info_piloti(i).prenume || ' ' || punctaje_piloti(i) || 'p');
    end loop;
    
    for i in punctaje_echipe.first..(punctaje_echipe.last - 1) loop
        for j in (i + 1)..punctaje_echipe.last loop
            if punctaje_echipe(i) < punctaje_echipe(j) then
                aux := punctaje_echipe(i);
                punctaje_echipe(i) := punctaje_echipe(j);
                punctaje_echipe(j) := aux;
                
                pozitie_cod_ec(info_echipe(i).cod) := j;
                pozitie_cod_ec(info_echipe(j).cod) := i;
                
                aux3 := info_echipe(i);
                info_echipe(i) := info_echipe(j);
                info_echipe(j) := aux3;
            end if;
        end loop;
    end loop;
    
    dbms_output.new_line;
    dbms_output.put_line('----------CLASAMENT ECHIPE ' || sezon || '----------');
    for i in punctaje_echipe.first..punctaje_echipe.last loop
        dbms_output.put_line(i || '. ' || info_echipe(i).nume || ' ' || punctaje_echipe(i) || 'p');
    end loop;
    dbms_output.new_line;
    
    exception
        when no_data_found then
            dbms_output.put_line('Nu exista date pentru sezonul ' || sezon || '.');
            dbms_output.new_line;
        when others then
            dbms_output.put_line('EROARE...');
            dbms_output.new_line;
end clasament;
/

declare
    sezon number(4) := &sezon;
begin
    clasament(sezon);
end;
/


--7
/*  Definiti un subprogram stocat, care folosind unul sau mai multe cursoare, afiseaza pilotii fiecarei echipe(nume, prenume), 
informatii despre masina fiecaruia(marca, model, putere) si clasa la care concureaza fiecare dintre ei.*/
create or replace procedure componenta_echipe is
    cursor piloti_echipa(cod_echipa varchar2) is    -- pilotii unei echipe
        select nume, prenume, id_clasa, id_masina
        from piloti
        where id_echipa = cod_echipa
        order by nume, prenume;

    cursor info_echipe is   -- echipele
        select *
        from echipe
        order by nume;
    
    nume_clasa clase.nume % type;
    k number(4);
    cod_producator producatori.id_producator % type;
    marca_masina producatori.nume % type;
    model_masina masini.model % type;
    putere_masina masini.putere % type;
    ok boolean := false;
begin
    for i in info_echipe loop
        ok := true;
        dbms_output.put_line('Echipa ' || i.nume);
        
        k := 0;
        for j in piloti_echipa(i.id_echipa) loop
            select nume     -- clasa la care concureaza
            into nume_clasa
            from clase
            where id_clasa = j.id_clasa;
            
            select id_producator, model, putere     -- informatii despre masina
            into cod_producator, model_masina, putere_masina
            from masini
            where id_masina = j.id_masina;
            
            select nume
            into marca_masina
            from producatori
            where id_producator = cod_producator;
            
            k := k + 1;
            dbms_output.put_line('   ' || k || '. ' || j.nume || ' ' || j.prenume || ', ' || marca_masina || ' ' || model_masina || ', ' || putere_masina || ' CP, clasa ' || nume_clasa);
        end loop;
        
        if k = 0 then
            dbms_output.put_line('   La aceasta echipa nu este inregistrat niciun pilot.');
        end if;
        dbms_output.new_line;
    end loop;
    
    if ok = false then
        dbms_output.put_line('Nu sunt inregistrate echipe.');
    end if;
end componenta_echipe;
/

begin
    componenta_echipe;
end;
/


--8
/*  Folosind un subprogram stocat de tip functie, cel mai implicat sponsor pentru o anumita perioada de timp. Pentru a 
determina scorul, se stie ca un sponsor primeste 4 puncte pe sezon daca sponsorizeaza campionatul, iar pentru sponsorizarea 
unei echipe primeste 1 punct pe sezon. Daca sunt mai multi sponsori care au scorul de implicare maxim, acestia vor fi afisati
in ordine alfabetica.*/
create or replace type vector_nume is varray(1000) of varchar2(20);
/

create or replace function top_sponsori(s1 number, s2 number) return vector_nume is
    type info_sponsor is record(cod sponsori.id_sponsor % type,
                                nume sponsori.nume % type);
    type vector is varray(1000000) of info_sponsor;
    type scor_sponsori is varray(1000000) of number;
    type tablou_indexat is table of number index by pls_integer;
    
    all_sponsors vector := vector();
    scor scor_sponsori := scor_sponsori();
    top vector_nume := vector_nume();
    poz_cod tablou_indexat;
    max1 number(4) := 0;
    k number(6) := 0;
begin
    select id_sponsor, nume     -- informatii despre toti sponsori
    bulk collect into all_sponsors
    from sponsori
    order by nume;
    
    if all_sponsors.count = 0 then
        dbms_output.put_line('Nu s-au gasit date despre sponsori.');
        return top;
    end if;
    
    for i in all_sponsors.first..all_sponsors.last loop
        poz_cod(all_sponsors(i).cod) := i;  -- pozitia codului sponsorului in vectorul de informatii
        scor.extend;
        scor(i) := 0;
    end loop;
    
    for x in (select id_sponsor cod
              from campionate
              where s1 <= sezon and sezon <= s2) loop
        scor(poz_cod(x.cod)) := scor(poz_cod(x.cod)) + 4;
    end loop;
    
    for x in (select id_sponsor cod
              from sponsori_echipe
              where s1 <= sezon and sezon <= s2) loop
        scor(poz_cod(x.cod)) := scor(poz_cod(x.cod)) + 1;
    end loop;
    
    for i in scor.first..scor.last loop
        if scor(i) > max1 then
            max1 := scor(i);
        end if;
    end loop;
    
    for i in scor.first..scor.last loop
        if scor(i) = max1 and max1 > 0 then
            top.extend;
            k := k + 1;
            top(k) := all_sponsors(i).nume;
        end if;
    end loop;
    
    return top;
    
    exception
        when no_data_found then
            dbms_output.put_line('Nu sunt suficiente date.');
            return top;
        when others then
            dbms_output.put_line('EROARE');
            return top;
end top_sponsori;
/

declare
    nume_sponsori vector_nume := vector_nume();
    x number(4) := &sezon1;
    y number(4) := &sezon2;
    aux number(4);
    perioada varchar2(30);
begin
    if x > y then
        aux := x;
        x := y;
        y := aux;
    end if;
    
    nume_sponsori := top_sponsori(x, y);
    if x = y then
            perioada := 'anul ' || x;
        else
            perioada := 'perioada ' || x || '-' || y;
    end if;
        
    if nume_sponsori.count > 0 then        
        if nume_sponsori.count = 1 then
            dbms_output.put_line('Cel mai implicat sponsor in ' || perioada || ' este: ' || nume_sponsori(1));
        else
            dbms_output.put_line('Cei mai implicati sponsori in ' || perioada || ' sunt:');
            for i in nume_sponsori.first..nume_sponsori.last loop
                dbms_output.put_line('  ' || nume_sponsori(i));
            end loop;
        end if;
    else
        dbms_output.put_line('Nu exista date pentru ' || perioada || '.');
    end if;
end;
/


--9
/*  Definiti un subprogram stocat de tip procedura care determina, pentru fiecare producator, cate puncte au obtinut la fiecare 
clasa la care au avut participari, dar si in total, masinile produse de acesta, intr-un interval de timp delimitat de 2 sezoane 
transmise ca parametri.
    Apoi sa se afiseze coeficientul de putere si coeficientul de performanta al fiecarui producator, stiind ca acestea se 
calculeaza astfel: coeficient_putere = puterea medie a masinilor fabricate de producatorul respectiv;
                   coeficient_performanta = numarul total de puncte / nr_masini care au participat la cel putin o etapa. */
create or replace procedure puncte_producatori(s1 number, s2 number) is
    type vector_punctaje is varray(10) of number(2);
    type tablou_indexat is table of boolean index by pls_integer;
    
    masini_prod tablou_indexat;
    punctaje vector_punctaje := vector_punctaje();
    puncte_clasa number(4);
    total number(4);
    coef_putere number(3);
    coef_performanta number(7, 2);
    ord number(3) := 0;
    nr_masini number(3);
    perioada varchar2(30);
    ok boolean;

begin
    punctaje.extend;
    punctaje(1) := 25;
    punctaje.extend;
    punctaje(2) := 18;
    punctaje.extend;
    punctaje(3) := 15;
    punctaje.extend;
    punctaje(4) := 12;
    punctaje.extend;
    punctaje(5) := 10;
    punctaje.extend;
    punctaje(6) := 8;
    punctaje.extend;
    punctaje(7) := 6;
    punctaje.extend;
    punctaje(8) := 4;
    punctaje.extend;
    punctaje(9) := 2;
    punctaje.extend;
    punctaje(10) := 1;  -- punctaje(i) = puncte pentru pozitia i

    for p in (select id_producator cod, nume
              from producatori
              order by nume) loop   -- pentru fiecare producator
        ord := ord + 1;
        dbms_output.put_line(ord || '. ' || p.nume);
        
        select avg(putere)          -- coeficient putere
        into coef_putere
        from masini
        where id_producator = p.cod;
        
        if coef_putere is null then     -- nu sunt masini pentru producatorul curent
            dbms_output.put_line('   Producatorul nu are masini inregistrate in baza de date.');
        else
            masini_prod.delete;     -- golesc colectia pentru a adauga masinile de la noul producator
            for x in (select id_masina
                      from masini
                      where id_producator = p.cod) loop
                masini_prod(x.id_masina) := false;  -- masina cu codul x.id_masina nu a participat initial la nicio etapa
            end loop;
            total := 0;
            nr_masini := 0;
            
            for c in (select id_clasa, nume
                      from clase
                      order by nume) loop   -- parcurg clasele
                puncte_clasa := 0;
                ok := false;    -- verific daca producatorul are participari la clasa curenta
                
                for s in s1..s2 loop    -- parcurg sezoanele din intervalul dat
                    for x in (select pe.pozitie_clasament poz, mas.id_masina cod_mas
                              from piloti_etape pe, piloti pil, clase cls, masini mas, etape et
                              where to_char(et.data, 'yyyy') = to_char(s) and mas.id_producator = p.cod 
                                    and pil.id_masina = mas.id_masina and pil.id_clasa = c.id_clasa 
                                    and pe.id_pilot = pil.id_pilot and pe.id_etapa = et.id_etapa) loop
                    -- pozitiile in clasament din etapele desfasurate in sezonul s, la clasa c, obtinute de masinile fabricate
                    -- de producatorul p
                        ok := true;     -- am gasit o participare la clasa curenta
                        
                        if x.poz <= 10 then
                            puncte_clasa := puncte_clasa + punctaje(x.poz);
                        end if;
                        
                        if masini_prod(x.cod_mas) = false then
                            nr_masini := nr_masini + 1;     -- numar cate masini au participat la cel putin o etapa
                            masini_prod(x.cod_mas) := true;
                        end if;
                    end loop;
                end loop;
                
                if ok = true then
                    dbms_output.put_line('   Clasa ' || c.nume || ': ' || puncte_clasa || ' puncte');
                end if;
                total := total + puncte_clasa;
            end loop;
            
            dbms_output.put_line(' Coeficient de putere: ' || coef_putere);
            if nr_masini <> 0 then
                coef_performanta := total / nr_masini;
                dbms_output.put_line(' Coeficient de performanta: ' || coef_performanta);
            else
                if s1 = s2 then
                    perioada := 'anul ' || s1;
                else
                    perioada := 'perioada ' || s1 || '-' || s2;
                end if;
                dbms_output.put_line('   Masinile produse de ' || p.nume || ' nu au concurat la nicio etapa in ' || perioada || '.');
            end if;
        end if;
        
        dbms_output.new_line;
        dbms_output.new_line;
    end loop;
end puncte_producatori;
/

declare
    x number(4) := &sezon1;
    y number(4) := &sezon2;
    aux number(4);
begin
    if x > y then
        aux := x;
        x := y;
        y := aux;
    end if;
        
    puncte_producatori(x, y);
end;
/


--10
/*  Definiti un trigger de tip LMD la nivel de comanda, care sa nu permita operatii pe tabela PILOTI_ETAPE in perioadele 
20 decembrie - 31 decembrie, 1 ianuarie - 7 ianuarie, iar modificarile pot fi efectuate in intervalul orar 08:00-20:00, de 
luni pana vineri.*/
create or replace trigger restrictii_acces
    before insert or update or delete on piloti_etape
declare
    zi_luna varchar2(2);
    zi varchar2(10);
    luna varchar2(2);
    ora varchar2(2);
begin
    select to_char(sysdate, 'dd')
    into zi_luna
    from dual;
    select to_char(sysdate, 'day')
    into zi
    from dual;
    select to_char(sysdate, 'mm')
    into luna
    from dual;
    select to_char(sysdate, 'hh24')
    into ora
    from dual;
    
    if luna = '12' and '20' <= zi_luna and zi_luna <= '31' then
        raise_application_error(-20101, 'Nu se pot face actualizari in perioada 20-31 decembrie!');
    elsif luna = '01' and '01' <= zi_luna and zi_luna <= '07' then
        raise_application_error(-20102, 'Nu se pot face actualizari in perioada 1-7 ianuarie!');
    elsif zi = 'saturday ' or zi = 'sunday ' then
        raise_application_error(-20103, 'Nu se pot face actualizari in weekend!');
    elsif ora < '08' or '20' < ora then
        raise_application_error(-20104, 'Nu se pot face actualizari in afara intervalului orar 08:00-20:00!');
    end if;
end;
/

insert into piloti_etape
values (1, 3, 5);

drop trigger restrictii_acces;

--11
/*  Definiti un trigger de tip LMD la nivel de linie, care la inserarea sau actualizarea datelor din tabelul PILOTI, verifica
daca participarea la clasa selectata este posibila(puterea masinii sa fie in intervalul pentru clasa respectiva).*/
create or replace trigger verificare_clasa
    before insert or update on piloti
    for each row
declare
    p number(3);
    pmin number(3);
    pmax number(3);
begin
    select putere
    into p
    from masini
    where id_masina = :new.id_masina;
    
    select putere_min, putere_max
    into pmin, pmax
    from clase
    where id_clasa = :new.id_clasa;
    
    if p not between pmin and pmax then
        raise_application_error(-20105, 'Nu se poate efectua operatiunea!');
    end if;
    
    exception
        when no_data_found then
            raise_application_error(-20106, 'Nu au fost gasite date!');
end;
/

insert into piloti
values(id_piloti.nextval, 'Ionescu', 'Mihai', 7, 'CB2', 'MTSRT');

insert into piloti
values(id_piloti.nextval, 'Costea', 'George', 7, 'CC2', 'MTSRT');

drop trigger verificare_clasa;

--12
/*  Definiti un trigger de tip LDD care, la aparitia unor actiuni asupra bazei de date, insereaza informatii in tabelul
INFO_LDD (utilizatorul, operatia efectuata, obiectul, data).*/
create table info_ldd(
    id number(3) constraint info_pk primary key,
    utilizator varchar2(30),
    operatie varchar2(20),
    obiect varchar2(30),
    data date
);

create sequence id_info
start with 1
increment by 1;

create or replace trigger inserare_info_ldd
    after create or alter or drop on database
begin
    insert into info_ldd
    values (id_info.nextval, sys.login_user, sys.sysevent, sys.dictionary_obj_name, sysdate);
end;
/

create table tabel_test(
    id number(2) constraint test_pk primary key,
    nume varchar2(30),
    prenume varchar2(30)
);    

alter table tabel_test
add data_nasterii date;

drop table tabel_test;

select *
from info_ldd;

drop trigger inserare_info_ldd;


--13
/*  Definiti un pachet care sa cuprinda toate obiectele definite in proiect.*/

--8
create or replace type vector_nume is varray(1000) of varchar2(20);
/

create or replace package cerinte as
    type vector_punctaje is varray(10) of number(2);
    
    --6
    procedure clasament(sezon number);
    
    --7
    procedure componenta_echipe;
    
    --8
    function top_sponsori(s1 number, s2 number) return vector_nume;
    
    --9
    procedure puncte_producatori(s1 number, s2 number);
end cerinte;
/

create or replace package body cerinte as
    --6
    procedure clasament(sezon number) is
        type info_pilot is record(cod piloti.id_pilot % type,
                                  nume piloti.nume % type,
                                  prenume piloti.prenume % type, 
                                  echipa piloti.id_echipa % type);
        type info_echipa is record(cod echipe.id_echipa % type,
                                   nume echipe.nume % type);
        type vector_piloti is varray(1000) of info_pilot;
        type vector_echipe is varray(1000) of info_echipa;
        type vector is varray(1000) of number(3);
        type tablou_indexat is table of number index by pls_integer;
        type tablou_indexat2 is table of number index by varchar2(5);
        type tablou_inregistrari is table of piloti_etape % rowtype;
        
        punctaje_piloti vector := vector();
        punctaje_echipe vector := vector();
        punctaje vector_punctaje := vector_punctaje();
        info_piloti vector_piloti := vector_piloti();
        info_echipe vector_echipe := vector_echipe();
        inreg tablou_inregistrari := tablou_inregistrari();
        pozitie_cod tablou_indexat;
        pozitie_cod_ec tablou_indexat2;
        p_cod number(3);
        p_clasam number(3);
        s number(4);
        aux number(4);
        aux2 info_pilot;
        aux3 info_echipa;
    begin
        aux := sezon;
        select c.sezon
        into s
        from campionate c
        where c.sezon = aux;
    
        select id_pilot, nume, prenume, id_echipa
        bulk collect into info_piloti   -- vector cu informatii despre piloti
        from piloti;
        
        select id_echipa, nume
        bulk collect into info_echipe
        from echipe;        -- vector cu informatii despre echipe
        
        for i in info_piloti.first..info_piloti.last loop
            pozitie_cod(info_piloti(i).cod) := i;    -- pozitie_cod(c) = pozitia pilotului cu codul c in vectorul de informatii
            punctaje_piloti.extend;
            punctaje_piloti(i) := 0;
        end loop;
        
        for i in info_echipe.first..info_echipe.last loop
            pozitie_cod_ec(info_echipe(i).cod) := i; -- pozitie_cod_ec(c) = pozitia echipei cu codul c in vectorul de informatii
            punctaje_echipe.extend;
            punctaje_echipe(i) := 0;
        end loop;
        
        punctaje.extend;
        punctaje(1) := 25;
        punctaje.extend;
        punctaje(2) := 18;
        punctaje.extend;
        punctaje(3) := 15;
        punctaje.extend;
        punctaje(4) := 12;
        punctaje.extend;
        punctaje(5) := 10;
        punctaje.extend;
        punctaje(6) := 8;
        punctaje.extend;
        punctaje(7) := 6;
        punctaje.extend;
        punctaje(8) := 4;
        punctaje.extend;
        punctaje(9) := 2;
        punctaje.extend;
        punctaje(10) := 1;  -- punctaje(i) = puncte pentru pozitia i
        
        select *
        bulk collect into inreg
        from piloti_etape
        where id_etapa in (select id_etapa
                           from etape
                           where to_char(data, 'yyyy') = to_char(sezon));  
            -- informatii despre participarile la etapele din sezonul curent
        
        for i in inreg.first..inreg.last loop
            if inreg(i).pozitie_clasament <= 10 then
                p_cod := pozitie_cod(inreg(i).id_pilot);
                p_clasam := inreg(i).pozitie_clasament;
                punctaje_piloti(p_cod) := punctaje_piloti(p_cod) + punctaje(p_clasam);
            end if;
        end loop;
        
        for i in punctaje_piloti.first..(punctaje_piloti.last - 1) loop   -- sortare piloti dupa punctaj
            for j in (i + 1)..punctaje_piloti.last loop
                if punctaje_piloti(i) < punctaje_piloti(j) then
                    aux := punctaje_piloti(i);
                    punctaje_piloti(i) := punctaje_piloti(j);
                    punctaje_piloti(j) := aux;          -- interschimbare punctaje
                    
                    pozitie_cod(info_piloti(i).cod) := j;
                    pozitie_cod(info_piloti(j).cod) := i;    -- interschimabre pozitii coduri piloti
                    
                    aux2 := info_piloti(i);
                    info_piloti(i) := info_piloti(j);
                    info_piloti(j) := aux2;               -- interschimabre coduri piloti
                end if;
            end loop;
        end loop;
        
        dbms_output.put_line('----------CLASAMENT PILOTI ' || sezon || '----------');
        for i in punctaje_piloti.first..punctaje_piloti.last loop
            p_cod := pozitie_cod_ec(info_piloti(i).echipa);
            punctaje_echipe(p_cod) := punctaje_echipe(p_cod) + punctaje_piloti(i);  -- calcul punctaje echipe
            dbms_output.put_line(i || '. ' || info_piloti(i).nume || ' ' || info_piloti(i).prenume || ' ' || punctaje_piloti(i) || 'p');
        end loop;
        
        for i in punctaje_echipe.first..(punctaje_echipe.last - 1) loop
            for j in (i + 1)..punctaje_echipe.last loop
                if punctaje_echipe(i) < punctaje_echipe(j) then
                    aux := punctaje_echipe(i);
                    punctaje_echipe(i) := punctaje_echipe(j);
                    punctaje_echipe(j) := aux;
                    
                    pozitie_cod_ec(info_echipe(i).cod) := j;
                    pozitie_cod_ec(info_echipe(j).cod) := i;
                    
                    aux3 := info_echipe(i);
                    info_echipe(i) := info_echipe(j);
                    info_echipe(j) := aux3;
                end if;
            end loop;
        end loop;
        
        dbms_output.new_line;
        dbms_output.put_line('----------CLASAMENT ECHIPE ' || sezon || '----------');
        for i in punctaje_echipe.first..punctaje_echipe.last loop
            dbms_output.put_line(i || '. ' || info_echipe(i).nume || ' ' || punctaje_echipe(i) || 'p');
        end loop;
        dbms_output.new_line;
        
        exception
            when no_data_found then
                dbms_output.put_line('Nu exista date pentru sezonul ' || sezon || '.');
                dbms_output.new_line;
            when others then
                dbms_output.put_line('EROARE...');
                dbms_output.new_line;
    end clasament;
    
    --7
    procedure componenta_echipe is
        cursor piloti_echipa(cod_echipa varchar2) is    -- pilotii unei echipe
            select nume, prenume, id_clasa, id_masina
            from piloti
            where id_echipa = cod_echipa
            order by nume, prenume;
    
        cursor info_echipe is   -- echipele
            select *
            from echipe
            order by nume;
        
        nume_clasa clase.nume % type;
        k number(4);
        cod_producator producatori.id_producator % type;
        marca_masina producatori.nume % type;
        model_masina masini.model % type;
        putere_masina masini.putere % type;
        ok boolean := false;
    begin
        for i in info_echipe loop
            ok := true;
            dbms_output.put_line('Echipa ' || i.nume);
            
            k := 0;
            for j in piloti_echipa(i.id_echipa) loop
                select nume     -- clasa la care concureaza
                into nume_clasa
                from clase
                where id_clasa = j.id_clasa;
                
                select id_producator, model, putere     -- informatii despre masina
                into cod_producator, model_masina, putere_masina
                from masini
                where id_masina = j.id_masina;
                
                select nume
                into marca_masina
                from producatori
                where id_producator = cod_producator;
                
                k := k + 1;
                dbms_output.put_line('   ' || k || '. ' || j.nume || ' ' || j.prenume || ', ' || marca_masina || ' ' || model_masina || ', ' || putere_masina || ' CP, clasa ' || nume_clasa);
            end loop;
            
            if k = 0 then
                dbms_output.put_line('   La aceasta echipa nu este inregistrat niciun pilot.');
            end if;
            dbms_output.new_line;
        end loop;
        
        if ok = false then
            dbms_output.put_line('Nu sunt inregistrate echipe.');
        end if;
    end componenta_echipe;
    
    --8
    function top_sponsori(s1 number, s2 number) return vector_nume is
        type info_sponsor is record(cod sponsori.id_sponsor % type,
                                    nume sponsori.nume % type);
        type vector is varray(1000000) of info_sponsor;
        type scor_sponsori is varray(1000000) of number;
        type tablou_indexat is table of number index by pls_integer;
        
        all_sponsors vector := vector();
        scor scor_sponsori := scor_sponsori();
        top vector_nume := vector_nume();
        poz_cod tablou_indexat;
        max1 number(4) := 0;
        k number(6) := 0;
    begin
        select id_sponsor, nume     -- informatii despre toti sponsori
        bulk collect into all_sponsors
        from sponsori
        order by nume;
        
        if all_sponsors.count = 0 then
            dbms_output.put_line('Nu s-au gasit date despre sponsori.');
            return top;
        end if;
        
        for i in all_sponsors.first..all_sponsors.last loop
            poz_cod(all_sponsors(i).cod) := i;  -- pozitia codului sponsorului in vectorul de informatii
            scor.extend;
            scor(i) := 0;
        end loop;
        
        for x in (select id_sponsor cod
                  from campionate
                  where s1 <= sezon and sezon <= s2) loop
            scor(poz_cod(x.cod)) := scor(poz_cod(x.cod)) + 4;
        end loop;
        
        for x in (select id_sponsor cod
                  from sponsori_echipe
                  where s1 <= sezon and sezon <= s2) loop
            scor(poz_cod(x.cod)) := scor(poz_cod(x.cod)) + 1;
        end loop;
        
        for i in scor.first..scor.last loop
            if scor(i) > max1 then
                max1 := scor(i);
            end if;
        end loop;
        
        for i in scor.first..scor.last loop
            if scor(i) = max1 and max1 > 0 then
                top.extend;
                k := k + 1;
                top(k) := all_sponsors(i).nume;
            end if;
        end loop;
        
        return top;
        
        exception
            when no_data_found then
                dbms_output.put_line('Nu sunt suficiente date.');
                return top;
            when others then
                dbms_output.put_line('EROARE');
                return top;
    end top_sponsori;
    
    --9
    procedure puncte_producatori(s1 number, s2 number) is
        type tablou_indexat is table of boolean index by pls_integer;
        
        masini_prod tablou_indexat;
        punctaje vector_punctaje := vector_punctaje();
        puncte_clasa number(4);
        total number(4);
        coef_putere number(3);
        coef_performanta number(7, 2);
        ord number(3) := 0;
        nr_masini number(3);
        perioada varchar2(30);
        ok boolean;
    
    begin
        punctaje.extend;
        punctaje(1) := 25;
        punctaje.extend;
        punctaje(2) := 18;
        punctaje.extend;
        punctaje(3) := 15;
        punctaje.extend;
        punctaje(4) := 12;
        punctaje.extend;
        punctaje(5) := 10;
        punctaje.extend;
        punctaje(6) := 8;
        punctaje.extend;
        punctaje(7) := 6;
        punctaje.extend;
        punctaje(8) := 4;
        punctaje.extend;
        punctaje(9) := 2;
        punctaje.extend;
        punctaje(10) := 1;  -- punctaje(i) = puncte pentru pozitia i
    
        for p in (select id_producator cod, nume
                  from producatori
                  order by nume) loop   -- pentru fiecare producator
            ord := ord + 1;
            dbms_output.put_line(ord || '. ' || p.nume);
            
            select avg(putere)          -- coeficient putere
            into coef_putere
            from masini
            where id_producator = p.cod;
            
            if coef_putere is null then     -- nu sunt masini pentru producatorul curent
                dbms_output.put_line('   Producatorul nu are masini inregistrate in baza de date.');
            else
                masini_prod.delete;     -- golesc colectia pentru a adauga masinile de la noul producator
                for x in (select id_masina
                          from masini
                          where id_producator = p.cod) loop
                    masini_prod(x.id_masina) := false;  -- masina cu codul x.id_masina nu a participat initial la nicio etapa
                end loop;
                total := 0;
                nr_masini := 0;
                
                for c in (select id_clasa, nume
                          from clase
                          order by nume) loop   -- parcurg clasele
                    puncte_clasa := 0;
                    ok := false;    -- verific daca producatorul are participari la clasa curenta
                    
                    for s in s1..s2 loop    -- parcurg sezoanele din intervalul dat
                        for x in (select pe.pozitie_clasament poz, mas.id_masina cod_mas
                                  from piloti_etape pe, piloti pil, clase cls, masini mas, etape et
                                  where to_char(et.data, 'yyyy') = to_char(s) and mas.id_producator = p.cod 
                                        and pil.id_masina = mas.id_masina and pil.id_clasa = c.id_clasa 
                                        and pe.id_pilot = pil.id_pilot and pe.id_etapa = et.id_etapa) loop
                        -- pozitiile in clasament din etapele desfasurate in sezonul s, la clasa c, obtinute de masinile fabricate
                        -- de producatorul p
                            ok := true;     -- am gasit o participare la clasa curenta
                            
                            if x.poz <= 10 then
                                puncte_clasa := puncte_clasa + punctaje(x.poz);
                            end if;
                            
                            if masini_prod(x.cod_mas) = false then
                                nr_masini := nr_masini + 1;     -- numar cate masini au participat la cel putin o etapa
                                masini_prod(x.cod_mas) := true;
                            end if;
                        end loop;
                    end loop;
                    
                    if ok = true then
                        dbms_output.put_line('   Clasa ' || c.nume || ': ' || puncte_clasa || ' puncte');
                    end if;
                    total := total + puncte_clasa;
                end loop;
                
                dbms_output.put_line(' Coeficient de putere: ' || coef_putere);
                if nr_masini <> 0 then
                    coef_performanta := total / nr_masini;
                    dbms_output.put_line(' Coeficient de performanta: ' || coef_performanta);
                else
                    if s1 = s2 then
                        perioada := 'anul ' || s1;
                    else
                        perioada := 'perioada ' || s1 || '-' || s2;
                    end if;
                    dbms_output.put_line('   Masinile produse de ' || p.nume || ' nu au concurat la nicio etapa in ' || perioada || '.');
                end if;
            end if;
            
            dbms_output.new_line;
            dbms_output.new_line;
        end loop;
    end puncte_producatori;
end cerinte;
/

--6
declare
    sezon number(4) := &sezon;
begin
    cerinte.clasament(sezon);
end;
/

--7
begin
    cerinte.componenta_echipe;
end;
/

--8
declare
    nume_sponsori vector_nume := vector_nume();
    x number(4) := &sezon1;
    y number(4) := &sezon2;
    aux number(4);
    perioada varchar2(30);
begin
    if x > y then
        aux := x;
        x := y;
        y := aux;
    end if;
    
    nume_sponsori := cerinte.top_sponsori(x, y);
    if x = y then
            perioada := 'anul ' || x;
        else
            perioada := 'perioada ' || x || '-' || y;
    end if;
        
    if nume_sponsori.count > 0 then        
        if nume_sponsori.count = 1 then
            dbms_output.put_line('Cel mai implicat sponsor in ' || perioada || ' este: ' || nume_sponsori(1));
        else
            dbms_output.put_line('Cei mai implicati sponsori in ' || perioada || ' sunt:');
            for i in nume_sponsori.first..nume_sponsori.last loop
                dbms_output.put_line('  ' || nume_sponsori(i));
            end loop;
        end if;
    else
        dbms_output.put_line('Nu exista date pentru ' || perioada || '.');
    end if;
end;
/

--9
declare
    x number(4) := &sezon1;
    y number(4) := &sezon2;
    aux number(4);
begin
    if x > y then
        aux := x;
        x := y;
        y := aux;
    end if;
        
    cerinte.puncte_producatori(x, y);
end;
/


--14
/*  Definiti un pachet care genereaza ordinea in care concurentii pleaca in cursa pentru fiecare etapa dintr-un sezon dat ca 
parametru.*/
create or replace package grila_start is
    type info_pilot is record(nume piloti.nume % type,
                              prenume piloti.prenume % type,
                              masina piloti.id_masina % type);
    type vector is varray(1000) of info_pilot;
    
    procedure ordine_start(sezon number);    -- grila de start
end grila_start;
/

create or replace package body grila_start is   
    procedure ordine_start(sezon number) is
        pil vector := vector();
        k number(2);
        marca producatori.nume % type;
        tip masini.model % type;
    begin
        select nume, prenume, id_masina
        bulk collect into pil
        from (select nume, prenume, id_masina
              from piloti
              order by dbms_random.value);
        
        if pil.count = 0 then
            dbms_output.put_line('Nu sunt piloti inregistrati in baza de date');
        else
            k := 0;
            dbms_output.put_line('Sezonul ' || sezon);
            for e in (select nume, data
                      from etape
                      where to_char(data, 'yyyy') = to_char(sezon)
                      order by data) loop
                k := k + 1;
                dbms_output.put_line('  ' || k || '. ' || e.nume || ', ' || e.data);
                
                select nume, prenume, id_masina
                bulk collect into pil
                from (select nume, prenume, id_masina
                      from piloti
                      order by dbms_random.value);
                
                for p in pil.first..pil.last loop
                    select m.model, prod.nume
                    into tip, marca
                    from masini m, producatori prod
                    where m.id_masina = pil(p).masina and m.id_producator = prod.id_producator;
                    
                    dbms_output.put_line('       ' || p || '.' || pil(p).nume || ' ' || pil(p).prenume || ', ' || marca || ' ' || tip);
                end loop;
                
                dbms_output.new_line;
            end loop;
            
            if k = 0 then
                dbms_output.put_line('   Nu sunt date inregistrate pentru acest sezon!');
            end if;
        end if;
    end ordine_start;
end grila_start;
/

begin
    grila_start.ordine_start(2019);
    grila_start.ordine_start(2023);
end;
/
