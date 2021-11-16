/*creation d'une bibliotheque Projet*/
libname PROJET "/folders/myfolders/Projet" ;


/** gestion des noms des fichiers **/
filename XLS_2012 "/folders/myfolders/Projet/base-cc-dads-2012.xls" termstr=CRLF encoding='utf-8';
filename XLS_2013 "/folders/myfolders/Projet/base-cc-dads-2013.xls" termstr=CRLF encoding='utf-8';
filename XLS_2014 "/folders/myfolders/Projet/base-cc-dads-2014.xls" termstr=CRLF encoding='utf-8';
filename XLS_2015 "/folders/myfolders/Projet/base-cc-dads-2015.xls" termstr=CRLF encoding='utf-8';


%macro boucle;
%local i; /* Variable compteur */
%let j=12;
%do i=2012 %to 2015;

/* 1. * Etape d'importation */
/** import des fichiers  **/

proc import datafile= XLS_&i
		    out=PROJET.data_ARM_&i
		    dbms=XLS
		    replace;
		    getnames=YES;
		    namerow=6;
		    datarow=7;
		    sheet='ARM'; 
run;

data PROJET.DATA_ARM_&i (keep= CODGEO LIBGEO NAME_DEP SNHM&j SNHM18&j SNHM26&j SNHM50&j SNHMC&j SNHME&j SNHMF&j SNHMF18&j SNHMF26&j SNHMF50&j SNHMFC&j SNHMFE&j SNHMFO&j SNHMFP&j SNHMH&j SNHMH18&j SNHMH26&j SNHMH50&j SNHMHC&j SNHMHE&j SNHMHO&j SNHMHP&j SNHMO&j SNHMP&j); 
	set PROJET.DATA_ARM_&i; 
run;

proc sql;
	alter table PROJET.DATA_ARM_&i
	add ANNEE char(4);
	update PROJET.DATA_ARM_&i
	set ANNEE = "&i";
quit;

data PROJET.DATA_ARM_&i ;
	set PROJET.DATA_ARM_&i ;
	rename SNHM&j = SNHM;
	rename SNHM18&j = SNHM18;
	rename SNHM26&j = SNHM26;
	rename SNHM50&j = SNHM50;
	rename SNHMC&j = SNHMC;
	rename SNHME&j = SNHME;
	rename SNHMF&j = SNHMF;
	rename SNHMF18&j = SNHMF18;
	rename SNHMF26&j = SNHMF26;
	rename SNHMF50&j = SNHMF50;
	rename SNHMFC&j = SNHMFC;
	rename SNHMFE&j = SNHMFE;
	rename SNHMFO&j = SNHMFO;
	rename SNHMFP&j = SNHMFP;
	rename SNHMH&j = SNHMH;
	rename SNHMH18&j = SNHMH18;
	rename SNHMH26&j = SNHMH26;
	rename SNHMH50&j = SNHMH50;
	rename SNHMHC&j = SNHMHC;
	rename SNHMHE&j = SNHMHE;
	rename SNHMHO&j = SNHMHO;
	rename SNHMHP&j = SNHMHP;
	rename SNHMO&j = SNHMO;
	rename SNHMP&j = SNHMP;
run ;


proc import datafile= XLS_&i
		    out=PROJET.data_DEP_&i
		    dbms=XLS
		    replace;
		    getnames=YES;
		    namerow=6;
		    datarow=7;
		    sheet='DEP';
run;

data PROJET.DATA_DEP_&i (keep= CODGEO NAME_DEP SNHM&j SNHM18&j SNHM26&j SNHM50&j SNHMC&j SNHME&j SNHMF&j SNHMF18&j SNHMF26&j SNHMF50&j SNHMFC&j SNHMFE&j SNHMFO&j SNHMFP&j SNHMH&j SNHMH18&j SNHMH26&j SNHMH50&j SNHMHC&j SNHMHE&j SNHMHO&j SNHMHP&j SNHMO&j SNHMP&j); 
	set PROJET.DATA_DEP_&i; 
run;

proc sql;
	alter table PROJET.DATA_DEP_&i
	add ANNEE char(4);
	update PROJET.DATA_DEP_&i
	set ANNEE = "&i";
quit;

data PROJET.DATA_DEP_&i ;
	set PROJET.DATA_DEP_&i ;
	rename SNHM&j = SNHM;
	rename SNHM18&j = SNHM18;
	rename SNHM26&j = SNHM26;
	rename SNHM50&j = SNHM50;
	rename SNHMC&j = SNHMC;
	rename SNHME&j = SNHME;
	rename SNHMF&j = SNHMF;
	rename SNHMF18&j = SNHMF18;
	rename SNHMF26&j = SNHMF26;
	rename SNHMF50&j = SNHMF50;
	rename SNHMFC&j = SNHMFC;
	rename SNHMFE&j = SNHMFE;
	rename SNHMFO&j = SNHMFO;
	rename SNHMFP&j = SNHMFP;
	rename SNHMH&j = SNHMH;
	rename SNHMH18&j = SNHMH18;
	rename SNHMH26&j = SNHMH26;
	rename SNHMH50&j = SNHMH50;
	rename SNHMHC&j = SNHMHC;
	rename SNHMHE&j = SNHMHE;
	rename SNHMHO&j = SNHMHO;
	rename SNHMHP&j = SNHMHP;
	rename SNHMO&j = SNHMO;
	rename SNHMP&j = SNHMP;
run ;

%let j = %eval (&j + 1);
%end; /*fin de la boucle */
%mend ; /*Fin macro */ 
%boucle;

/*Creation d une table avec le nom des departements (pour pallier au probleme d encoding)*/
data projet.departement;
length NAME_DEP $40;
input NAME_DEP $;
datalines;
Ain
Aisne
Allier
Alpes-de-Haute-Provence
Hautes-Alpes
Alpes-Maritimes
Ardeche
Ardennes
Ariege
Aube
Aude
Aveyron
Bouches-du-Rhone
Calvados
Cantal
Charente
Charente-Maritime
Cher
Correze
Cote-d'Or
Cotes-d'Armor
Creuse
Dordogne
Doubs
Drome
Eure
Eure-et-Loir
Finistere
Corse-du-Sud
Haute-Corse
Gard
Haute-Garonne
Gers
Gironde
Herault
Ille-et-Vilaine
Indre
Indre-et-Loire
Isere
Jura
Landes
Loir-et-Cher
Loire
Haute-Loire
Loire-Atlantique
Loiret
Lot
Lot-et-Garonne
Lozere
Maine-et-Loire
Manche
Marne
Haute-Marne
Mayenne
Meurthe-et-Moselle
Meuse
Morbihan
Moselle
Nievre
Nord
Oise
Orne
Pas-de-Calais
Puy-de-Dome
Pyrenees-Atlantiques
Hautes-Pyrenees
Pyrenees-Orientales
Bas-Rhin
Haut-Rhin
Rhone
Haute-Saone
Saone-et-Loire
Sarthe
Savoie
Haute-Savoie
Paris
Seine-Maritime
Seine-et-Marne
Yvelines
Deux-Sevres
Somme
Tarn
Tarn-et-Garonne
Var
Vaucluse
Vendee
Vienne
Haute-Vienne
Vosges
Yonne
Territoire de Belfort
Essonne
Hauts-de-Seine
Seine-Saint-Denis
Val-de-Marne
Val-d'Oise
Guadeloupe
Martinique
Guyane
La-Reunion
;
run;

data PROJET.DATA_ARM;
	set PROJET.DATA_ARM_2012 PROJET.DATA_ARM_2013 PROJET.DATA_ARM_2014 PROJET.DATA_ARM_2015 ;
run;

/*Creation d une table region pour regrouper les departements par region*/
data PROJET.region;
length REGION $ 30;
input CODGEO $ REGION $;
datalines;
01 Auvergne-Rhone-Alpes
03 Auvergne-Rhone-Alpes
07 Auvergne-Rhone-Alpes
15 Auvergne-Rhone-Alpes
26 Auvergne-Rhone-Alpes
38 Auvergne-Rhone-Alpes
42 Auvergne-Rhone-Alpes
43 Auvergne-Rhone-Alpes
63 Auvergne-Rhone-Alpes
69 Auvergne-Rhone-Alpes
73 Auvergne-Rhone-Alpes
74 Auvergne-Rhone-Alpes
21 Bourgogne-Franche-Comte
25 Bourgogne-Franche-Comte
39 Bourgogne-Franche-Comte
58 Bourgogne-Franche-Comte
70 Bourgogne-Franche-Comte
71 Bourgogne-Franche-Comte
89 Bourgogne-Franche-Comte
90 Bourgogne-Franche-Comte
22 Bretagne
29 Bretagne
35 Bretagne
56 Bretagne
18 Centre-Val de Loire
28 Centre-Val de Loire
36 Centre-Val de Loire
37 Centre-Val de Loire
41 Centre-Val de Loire
45 Centre-Val de Loire
2A Corse
2B Corse
08 Grand Est
10 Grand Est
51 Grand Est
52 Grand Est
54 Grand Est
55 Grand Est
57 Grand Est
67 Grand Est
68 Grand Est
88 Grand Est
02 Hauts-de-France
59 Hauts-de-France
60 Hauts-de-France
62 Hauts-de-France
80 Hauts-de-France
75 Ile-de-France
77 Ile-de-France
78 Ile-de-France
91 Ile-de-France
92 Ile-de-France
93 Ile-de-France
94 Ile-de-France
95 Ile-de-France
14 Normandie
27 Normandie
50 Normandie
61 Normandie
76 Normandie
16 Nouvelle-Aquitaine
17 Nouvelle-Aquitaine
19 Nouvelle-Aquitaine
23 Nouvelle-Aquitaine
24 Nouvelle-Aquitaine
33 Nouvelle-Aquitaine
40 Nouvelle-Aquitaine
47 Nouvelle-Aquitaine
64 Nouvelle-Aquitaine
79 Nouvelle-Aquitaine
86 Nouvelle-Aquitaine
87 Nouvelle-Aquitaine
09 Occitanie
11 Occitanie
12 Occitanie
30 Occitanie
31 Occitanie
32 Occitanie
34 Occitanie
46 Occitanie
48 Occitanie
65 Occitanie
66 Occitanie
81 Occitanie
82 Occitanie
44 Pays-de-la-Loire
49 Pays-de-la-Loire
53 Pays-de-la-Loire
72 Pays-de-la-Loire
85 Pays-de-la-Loire
04 PACA
05 PACA
06 PACA
13 PACA
83 PACA
84 PACA
971 Outre-mer
972 Outre-mer
973 Outre-mer
974 Outre-mer
;
run;

/*Concatenation des fichiers dep en ajoutant a chaque fois les regions et les noms des departements modifies*/
proc sort data=PROJET.DATA_DEP_2012;
   by CODGEO;
run;

proc sort data=PROJET.region;
   by CODGEO ;
run;

data PROJET.DATA_DEP_2012;
   merge PROJET.DATA_DEP_2012 PROJET.region;
   by CODGEO;
run;

data PROJET.DATA_DEP_2012;
   merge PROJET.DATA_DEP_2012 PROJET.departement;
run;

proc sort data=PROJET.DATA_DEP_2013;
   by CODGEO;
run;

data PROJET.DATA_DEP_2013;
   merge PROJET.DATA_DEP_2013 PROJET.region;
   by CODGEO;
run;

data PROJET.DATA_DEP_2013;
   merge PROJET.DATA_DEP_2013 PROJET.departement;
run;

proc sort data=PROJET.DATA_DEP_2014;
   by CODGEO;
run;

data PROJET.DATA_DEP_2014;
   merge PROJET.DATA_DEP_2014 PROJET.region;
   by CODGEO;
run;

data PROJET.DATA_DEP_2014;
   merge PROJET.DATA_DEP_2014 PROJET.departement;
run;

proc sort data=PROJET.DATA_DEP_2015;
   by CODGEO;
run;

data PROJET.DATA_DEP_2015;
   merge PROJET.DATA_DEP_2015 PROJET.region;
   by CODGEO;
run;

data PROJET.DATA_DEP_2015;
   merge PROJET.DATA_DEP_2015 PROJET.departement;
run;

data PROJET.DATA_DEP;
	set PROJET.DATA_DEP_2012 PROJET.DATA_DEP_2013 PROJET.DATA_DEP_2014 PROJET.DATA_DEP_2015;
run;

proc sql ;
	alter table PROJET.DATA_DEP
	drop LIBGEO;
quit;

/*Creation d'un format region pour les procedures "tabulate"*/
proc format;
	value $regionf
		"01","03","07","15","26","38","42","43","63","69","73","74" = "Auvergne-Rhone-Alpes"
		"21","25","39","58","70","71","89","90" = "Bourgogne-Franche-Comte" 
		"22","29","35","56" ="Bretagne"
		"18","28","36","37","41","45" ="Centre-Val de Loire"
		"2A","2B" ="Corse"
		"08","10","51","52","54","55","57","67","68","88" ="Grand Est"
		"02","59","60","62","80" ="Hauts-de-France"
		"75","77","78","91","92","93","94","95" ="Ile-de-France"
		"14","27","50","61","76" ="Normandie"
		"16","17","19","23","24","33","40","47","64","79","86","87" ="Nouvelle-Aquitaine"
		"09","11","12","30","31","32","34","46","48","65","66","81","82" ="Occitanie"
		"44","49","53","72","85" ="Pays de la Loire"
		"04","05","06","13","83","84" ="PACA"
		"971","972","973","974"   = "Outre-mer";
run;

/*Quels sont les departements avec les meilleurs/pires salaires ?*/
proc sql ;
	create table PROJET.data_dep1 as
	select *,MEAN(SNHM) as tot_sal from PROJET.data_dep
	group by NAME_DEP;
quit;

/*5 meilleurs departements */
proc sort nodupkey data=PROJET.data_dep1;
   by descending tot_sal ;
run;

proc sql outobs=5;
select NAME_DEP as Depatement, tot_sal from PROJET.data_dep1;
quit;

/*5 pires departements */
proc sort data=PROJET.data_dep1;
   by tot_sal ;
run;

proc sql outobs=5;
	select NAME_DEP as Depatement, tot_sal from PROJET.data_dep1;
quit;

/*Quelles sont les regions avec les meilleurs/pires salaires ?*/
proc sql ;
	create table PROJET.data_dep1_reg as
	select *,MEAN(SNHM) as tot_sal from PROJET.data_dep
	group by REGION;
quit;

/*Salaire moyen par regions */
proc sort nodupkey data=PROJET.data_dep1_reg;
   by descending tot_sal ;
run;

proc sql;
select REGION, tot_sal from PROJET.data_dep1_reg;
quit;

/*Est-ce qu il y a des differences de salaires entre les arrondissements des villes ?(pour chaque ville)*/
proc sql ;
	create table PROJET.data_arm1 as
	select *,MEAN(SNHM) as tot_sal from PROJET.data_arm
	group by LIBGEO;
quit;

/*5 pires arrondissements */
proc sort nodupkey data=PROJET.data_arm1;
   by tot_sal ;
run;

proc sql outobs=5;
	select LIBGEO, tot_sal from PROJET.data_arm1;
quit;

/*5 meilleurs arrondissements */
proc sort nodupkey data=PROJET.data_arm1;
   by descending tot_sal ;
run;

proc sql outobs=5;
	select LIBGEO, tot_sal from PROJET.data_arm1;
quit;

/*Classement des arrondissements (par ordre decroissant) pour Marseille*/
proc sql ;
	create table PROJET.data_arm1_marseille as
	select * from PROJET.data_arm1
	where LIBGEO like "Marseille %";
quit;

proc sql;
	select LIBGEO, tot_sal from PROJET.data_arm1_marseille;
quit;

/*Classement des arrondissements (par ordre decroissant) pour Lyon*/
proc sql ;
	create table PROJET.data_arm1_lyon as
	select * from PROJET.data_arm1
	where LIBGEO like "Lyon %";
quit;

proc sql;
	select LIBGEO, tot_sal from PROJET.data_arm1_lyon;
quit;

/*Classement des arrondissements (par ordre decroissant) pour Paris*/
proc sql ;
	create table PROJET.data_arm1_paris as
	select * from PROJET.data_arm1
	where LIBGEO like "Paris %";
quit;

proc sql;
	select LIBGEO, tot_sal from PROJET.data_arm1_paris;
quit;

/*Est-ce qu il y a des differences de salaires entre les differentes classes d'ages (repartition par departement)? */
proc sql ;
	create table PROJET.data_dep1 as
	select CODGEO, NAME_DEP, MEAN(SNHM18) as SNHM18_mean, MEAN(SNHM26) as SNHM26_mean, MEAN(SNHM50) as SNHM50_mean from PROJET.data_dep
	group by NAME_DEP;
quit;

proc sort nodupkey data=PROJET.data_dep1 out=PROJET.data_dep1;
   by CODGEO ;
run;
/*Creation de 3 tables pour chaque classe d age*/
proc sql ;
	create table PROJET.data_dep_18 as
	select  NAME_DEP,CODGEO,SNHM18_mean as Salaire from PROJET.data_dep1;
quit;

proc sql ;
	create table PROJET.data_dep_26 as
	select  NAME_DEP,CODGEO,SNHM26_mean as Salaire from PROJET.data_dep1;
quit;

proc sql ;
	create table PROJET.data_dep_50 as
	select  NAME_DEP,CODGEO,SNHM50_mean as Salaire from PROJET.data_dep1;
quit;

/*Creation d une table avec les differentes classes d ages */
data PROJET.rep_cl;  
do j = 1 to 3; 
	if j = 1 then z= '18-25';
	else if j=2 then z = '26-50';
	else z = '50+';
	  do i=1 to 100;     
	    x = z;     
	    output;   
	  end;
end;
run;

proc sql ;
	create table PROJET.rep_cl as
	select  x as Classe_age from PROJET.rep_cl;
quit;

/*Concatenation des 3 fichiers*/
data PROJET.data_dep1bis;   
  set PROJET.data_dep_18 PROJET.data_dep_26 PROJET.data_dep_50; 
run;

/*Ajout de la colonne classe d age*/
data PROJET.data_dep1bis;   
  merge PROJET.data_dep1bis PROJET.rep_cl; 
run;

/*Boxplot du salaire par classe d age */
proc boxplot data=PROJET.data_dep1bis;
	plot Salaire * Classe_age 
	/caxis=black ctext=black cboxes=black
	boxstyle=schematic
	idcolor=black idsymbol=dot;
run;

/*Tableau moy,min et max par classe d age et par region*/
proc tabulate data=PROJET.data_dep1bis;
	where put(CODGEO,$regionf.); 
	format CODGEO $regionf.;
	class CODGEO Classe_age;
	var Salaire;
	tables CODGEO*Classe_age ,
	mean = "Salaire moyen"*Salaire=""
	min = "Salaire minimum"*Salaire=""
	max = "Salaire maximum"*Salaire="";
run;

/*Est-ce qu il y a des differences de salaires entre les differentes classes d ages (sans departement)? */
proc sql ;
	create table PROJET.data_dep2 as
	select Classe_age,mean(Salaire) as Salaire_Moyen from PROJET.data_dep1bis
	group by Classe_age;
quit;

proc sort nodupkey data=PROJET.data_dep2;
   by  Salaire_Moyen ;
run;

proc sql;
	select Classe_age, Salaire_Moyen from PROJET.data_dep2;
quit;

/*Est-ce que ces differences sont les memes chez les hommes que chez les femmes ? */
proc sql ;
	create table PROJET.data_dep3 as
	select CODGEO, NAME_DEP, MEAN(SNHMF18) as SNHM18F_mean, MEAN(SNHMF26) as SNHM26F_mean, MEAN(SNHMF50) as SNHM50F_mean, MEAN(SNHMH18) as SNHM18H_mean, MEAN(SNHMH26) as SNHM26H_mean, MEAN(SNHMH50) as SNHM50H_mean from PROJET.data_dep
	group by NAME_DEP;
quit;

proc sort nodupkey data=PROJET.data_dep3 out=PROJET.data_dep3;
   by CODGEO ;
run;

proc sql ;
	create table PROJET.data_dep_18_sexe as
	select  NAME_DEP,CODGEO,SNHM18H_mean as Salaire_H,SNHM18F_mean as Salaire_F from PROJET.data_dep3;
quit;

proc sql ;
	create table PROJET.data_dep_26_sexe as
	select  NAME_DEP,CODGEO,SNHM26H_mean as Salaire_H,SNHM26F_mean as Salaire_F from PROJET.data_dep3;
quit;

proc sql ;
	create table PROJET.data_dep_50_sexe as
	select  NAME_DEP,CODGEO,SNHM50H_mean as Salaire_H,SNHM50F_mean as Salaire_F from PROJET.data_dep3;
quit;

data PROJET.data_dep3bis;   
  set PROJET.data_dep_18_sexe PROJET.data_dep_26_sexe PROJET.data_dep_50_sexe; 
run;

data PROJET.data_dep3bis;   
  merge PROJET.data_dep3bis PROJET.rep_cl; 
run;

proc sql ;
	create table PROJET.data_dep3bisbis as
	select Classe_age,mean(Salaire_H) as Salaire_H_Moyen,mean(Salaire_F) as Salaire_F_Moyen from PROJET.data_dep3bis
	group by Classe_age;
quit;

proc sgplot data=PROJET.data_dep3bisbis; 
	title "Salaire moyen par sexe et par classe d'age"  ;
     vbar Classe_age / 
     response=Salaire_H_Moyen 
     barwidth=.4 discreteoffset=-.2 ;   
     vbar Classe_age / 
     response=Salaire_F_Moyen 
     barwidth=.4 discreteoffset=.2 ; 
     xaxis label="Classe d'age";
     yaxis label="Salaire";
run;

/*Est-ce que les differences entre les csp sont les memes dans tous les departements/regions/ &? */
proc sql ;
	create table PROJET.data_dep4 as
	select CODGEO, NAME_DEP,mean(SNHMC) as SNHM_cadre_sup , mean(SNHMP) as SNHM_prof_inter, mean(SNHME) as SNHM_emp, mean(SNHMO) as SNHM_ouvrier from PROJET.DATA_DEP
	group by CODGEO;
quit;

proc sort nodupkey data=PROJET.data_dep4 out=PROJET.data_dep4;
   by CODGEO ;
run;

/*moyenne par departement*/
proc sql ;
	create table PROJET.data_dep4bis as
	select *,mean(SNHM_cadre_sup,SNHM_prof_inter,SNHM_emp,SNHM_ouvrier) as Moyenne_dep from PROJET.data_dep4
	group by CODGEO;
quit;

/*"centrage reduction" par departement*/
proc sql ;
	create table PROJET.data_dep4bisbis as
	select CODGEO,NAME_DEP, SNHM_cadre_sup- Moyenne_dep as cr_cadre_sup, SNHM_prof_inter- Moyenne_dep as cr_prof_inter, SNHM_emp- Moyenne_dep as cr_emp, SNHM_ouvrier- Moyenne_dep as cr_ouvrier from PROJET.data_dep4bis;
quit;


proc standard DATA=PROJET.data_dep4bisbis mean=0 std=1 out=PROJET.data_dep4_final;
  var cr_cadre_sup cr_prof_inter cr_emp cr_ouvrier ;
run;


/*Est-ce qu il y a des differences de salaires entre les differentes classes d ages (sans departement)? */
proc sql ;
	create table PROJET.data_dep2 as
	select Classe_age,mean(Salaire) as Salaire_Moyen, min(Salaire) as Salaire_Minimal, max(Salaire) as Salaire_Maximal from PROJET.data_dep1bis
	group by Classe_age;
quit;

proc sort nodupkey data=PROJET.data_dep2;
   by  Salaire_Moyen ;
run;

proc sql;
	select Classe_age, Salaire_Moyen, Salaire_Minimal, Salaire_Maximal from PROJET.data_dep2;
quit;


/*Dans le temps*/

/*modification des labels*/
data PROJET.data_dep;
	label SNHMF = "Femme"
	SNHMH = "Homme";
	set PROJET.data_dep;
run;

/*Est-ce que les salaires H/F ont augmente (en France/par departement) */
/*difference salaire moyen homme - femme */ 
proc sql ;
	create table PROJET.salaire_HF as
	select NAME_DEP, SNHMH, SNHMF, ANNEE from PROJET.DATA_DEP;
quit;

proc sql;
	alter table PROJET.salaire_HF
	add DELTA float4;
	update PROJET.salaire_HF
	set DELTA = SNHMH-SNHMF;
quit;

/*Pour toute la france */
proc tabulate data=PROJET.salaire_HF;
	class ANNEE;
	var DELTA ;
	table (ANNEE),
      	((DELTA) *
      	MEAN);
run;

/*Par departement */
proc tabulate data=PROJET.salaire_HF;
	class ANNEE NAME_DEP;
	var DELTA;
	table (NAME_DEP), (ANNEE) *
      	(DELTA);
run;

/*Est-ce que le salaire net a evolue de la meme maniere dans tous les departements ? */
proc sql;
	create table PROJET.ratio_salaire2012 as 
	select SNHM as SNHM12, CODGEO, NAME_DEP from PROJET.data_dep
	where ANNEE = '2012' ;
quit;

proc sql;
	create table PROJET.ratio_salaire2015 as 
	select SNHM as SNHM15, CODGEO, NAME_DEP from PROJET.data_dep
	where ANNEE = '2015' ;
quit;

data PROJET.ratio_salaire;
	merge PROJET.ratio_salaire2012 PROJET.ratio_salaire2015;
run;

proc sql;
	alter table PROJET.ratio_salaire
	add RATIO float4;
	update PROJET.ratio_salaire
	set RATIO = (SNHM15/SNHM12) ;
quit;

proc tabulate data=PROJET.ratio_salaire;
	class NAME_DEP;
	var RATIO;
	tables NAME_DEP,
	RATIO;
run;

/*Est-ce que le salaire net a evolue de la meme maniere dans toutes les regions ?*/
/*taux d'evolution http://www.mathematiques.club/terminale-es-et-l-specialite/evolutions-pourcentages/article/calculer-un-taux-d-evolution-moyen#:~:text=En%20bref%2C%20pour%20calculer%20un,D)1n"1. */

proc sql;
	alter table PROJET.ratio_salaire
	add EVO float4;
	update PROJET.ratio_salaire
	set EVO = (SNHM15/SNHM12)**(1/4) - 1 ;
quit;

proc tabulate data=PROJET.ratio_salaire;
	where put(CODGEO ,$regionf.); 
	format CODGEO $regionf.;
	class CODGEO;
	var EVO;
	tables CODGEO,
	EVO;
run;


/*Est-ce que les differences entre les csp ont evolue (en France/par departement/ &) ?*/
data PROJET.data_dep;
	label SNHMC = "Cadres sup"
	SNHMP = "Prof inter"
	SNHME = "Employes"
	SNHMO= "Ouvrier";
	set PROJET.data_dep;
run;

proc tabulate data=PROJET.data_dep;
	class ANNEE;
	var SNHMC SNHMP SNHME SNHMO ;
	table (ANNEE),
      	((SNHMC SNHMP SNHME SNHMO) *
      	MEAN);
run;
