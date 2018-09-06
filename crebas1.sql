/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     6/14/2016 4:07:57 PM                         */
/*==============================================================*/


alter table "Contains"
   drop constraint FK_CONTAINS_CONTAINS_ENTITY_T;

alter table "Contains"
   drop constraint FK_CONTAINS_CONTAINS2_ATTR_TYP;

alter table "Derives"
   drop constraint FK_DERIVES_DERIVES_ATTR_TYP;

alter table "Derives"
   drop constraint FK_DERIVES_DERIVES2_ATTR_TYP;

alter table "Is_In"
   drop constraint FK_IS_IN_IS_IN_ATTR_TYP;

alter table "Is_In"
   drop constraint FK_IS_IN_IS_IN2_ATTR_TYP;

alter table "Is_Uesd_by"
   drop constraint FK_IS_UESD__IS_UESD_B_ATTR_TYP;

alter table "Is_Uesd_by"
   drop constraint FK_IS_UESD__IS_UESD_B_REL_TYPE;

alter table "Relates"
   drop constraint FK_RELATES_RELATES_ENTITY_T;

alter table "Relates"
   drop constraint FK_RELATES_RELATES2_REL_TYPE;

alter table "Specialization"
   drop constraint FK_SPECIALI_SUPER_ENTITY_T;

alter table "Sub"
   drop constraint FK_SUB_SUB_SPECIALI;

alter table "Sub"
   drop constraint FK_SUB_SUB2_ENTITY_T;

drop table "Attr_Type" cascade constraints;

drop index "Contains_FK";

drop index "Contains2_FK";

drop table "Contains" cascade constraints;

drop index "Derives_FK";

drop index "Derives2_FK";

drop table "Derives" cascade constraints;

drop table "Entity_Type" cascade constraints;

drop index "Is_In_FK";

drop index "Is_In2_FK";

drop table "Is_In" cascade constraints;

drop index "Is_Uesd_by_FK";

drop index "Is_Uesd_by2_FK";

drop table "Is_Uesd_by" cascade constraints;

drop table "Rel_type" cascade constraints;

drop index "Relates_FK";

drop index "Relates2_FK";

drop table "Relates" cascade constraints;

drop index "Super_FK";

drop table "Specialization" cascade constraints;

drop index "Sub_FK";

drop index "Sub2_FK";

drop table "Sub" cascade constraints;

/*==============================================================*/
/* Table: "Attr_Type"                                           */
/*==============================================================*/
create table "Attr_Type" 
(
   "AName"              CHAR(20)             not null,
   "Multivalued"        NUMBER(2),
   constraint PK_ATTR_TYPE primary key ("AName")
);

/*==============================================================*/
/* Table: "Contains"                                            */
/*==============================================================*/
create table "Contains" 
(
   "AName"              CHAR(20)             not null,
   "EName"              CHAR(20)             not null,
   "Data_Type"          CHAR(20)             not null,
   "Is_Key"             CHAR(1),
   "Key_Type"           CHAR(20),
   constraint PK_CONTAINS primary key ("AName", "EName")
);

/*==============================================================*/
/* Index: "Contains2_FK"                                        */
/*==============================================================*/
create index "Contains2_FK" on "Contains" (
   "AName" ASC
);

/*==============================================================*/
/* Index: "Contains_FK"                                         */
/*==============================================================*/
create index "Contains_FK" on "Contains" (
   "EName" ASC
);

/*==============================================================*/
/* Table: "Derives"                                             */
/*==============================================================*/
create table "Derives" 
(
   "AName"              CHAR(20)             not null,
   "Att_AName"          CHAR(20)             not null,
   "Data_Type"          CHAR(20)             not null,
   constraint PK_DERIVES primary key ("AName", "Att_AName")
);

/*==============================================================*/
/* Index: "Derives2_FK"                                         */
/*==============================================================*/
create index "Derives2_FK" on "Derives" (
   "AName" ASC
);

/*==============================================================*/
/* Index: "Derives_FK"                                          */
/*==============================================================*/
create index "Derives_FK" on "Derives" (
   "Att_AName" ASC
);

/*==============================================================*/
/* Table: "Entity_Type"                                         */
/*==============================================================*/
create table "Entity_Type" 
(
   "EName"              CHAR(20)             not null,
   "Type"               CHAR(20),
   constraint PK_ENTITY_TYPE primary key ("EName")
);

/*==============================================================*/
/* Table: "Is_In"                                               */
/*==============================================================*/
create table "Is_In" 
(
   "AName"              CHAR(20)             not null,
   "Att_AName"          CHAR(20)             not null,
   "Data_Type"          CHAR(20)             not null,
   constraint PK_IS_IN primary key ("AName", "Att_AName")
);

/*==============================================================*/
/* Index: "Is_In2_FK"                                           */
/*==============================================================*/
create index "Is_In2_FK" on "Is_In" (
   "AName" ASC
);

/*==============================================================*/
/* Index: "Is_In_FK"                                            */
/*==============================================================*/
create index "Is_In_FK" on "Is_In" (
   "Att_AName" ASC
);

/*==============================================================*/
/* Table: "Is_Uesd_by"                                          */
/*==============================================================*/
create table "Is_Uesd_by" 
(
   "RName"              CHAR(20)             not null,
   "AName"              CHAR(20)             not null,
   "Data_Type"          CHAR(20)             not null,
   constraint PK_IS_UESD_BY primary key ("RName", "AName")
);

/*==============================================================*/
/* Index: "Is_Uesd_by2_FK"                                      */
/*==============================================================*/
create index "Is_Uesd_by2_FK" on "Is_Uesd_by" (
   "RName" ASC
);

/*==============================================================*/
/* Index: "Is_Uesd_by_FK"                                       */
/*==============================================================*/
create index "Is_Uesd_by_FK" on "Is_Uesd_by" (
   "AName" ASC
);

/*==============================================================*/
/* Table: "Rel_type"                                            */
/*==============================================================*/
create table "Rel_type" 
(
   "RName"              CHAR(20)             not null,
   "Type"               CHAR(20),
   constraint PK_REL_TYPE primary key ("RName")
);

/*==============================================================*/
/* Table: "Relates"                                             */
/*==============================================================*/
create table "Relates" 
(
   "RName"              CHAR(20)             not null,
   "EName"              CHAR(20)             not null,
   "Role"               CHAR(20)             not null,
   "Cardinality"        CHAR(1),
   "Min_Card"           CHAR(2),
   "Max_card"           CHAR(2)
);

/*==============================================================*/
/* Index: "Relates2_FK"                                         */
/*==============================================================*/
create index "Relates2_FK" on "Relates" (
   "RName" ASC
);

/*==============================================================*/
/* Index: "Relates_FK"                                          */
/*==============================================================*/
create index "Relates_FK" on "Relates" (
   "EName" ASC
);

/*==============================================================*/
/* Table: "Specialization"                                      */
/*==============================================================*/
create table "Specialization" 
(
   "SName"              CHAR(20)             not null,
   "EName"              CHAR(20)             not null,
   "Total"              CHAR(1),
   "Overlapping"        CHAR(1),
   constraint PK_SPECIALIZATION primary key ("SName")
);

/*==============================================================*/
/* Index: "Super_FK"                                            */
/*==============================================================*/
create index "Super_FK" on "Specialization" (
   "EName" ASC
);

/*==============================================================*/
/* Table: "Sub"                                                 */
/*==============================================================*/
create table "Sub" 
(
   "SName"              CHAR(20)             not null,
   "EName"              CHAR(20)             not null,
   constraint PK_SUB primary key ("SName", "EName")
);

/*==============================================================*/
/* Index: "Sub2_FK"                                             */
/*==============================================================*/
create index "Sub2_FK" on "Sub" (
   "EName" ASC
);

/*==============================================================*/
/* Index: "Sub_FK"                                              */
/*==============================================================*/
create index "Sub_FK" on "Sub" (
   "SName" ASC
);

alter table "Contains"
   add constraint FK_CONTAINS_CONTAINS_ENTITY_T foreign key ("EName")
      references "Entity_Type" ("EName");

alter table "Contains"
   add constraint FK_CONTAINS_CONTAINS2_ATTR_TYP foreign key ("AName")
      references "Attr_Type" ("AName");

alter table "Derives"
   add constraint FK_DERIVES_DERIVES_ATTR_TYP foreign key ("Att_AName")
      references "Attr_Type" ("AName");

alter table "Derives"
   add constraint FK_DERIVES_DERIVES2_ATTR_TYP foreign key ("AName")
      references "Attr_Type" ("AName");

alter table "Is_In"
   add constraint FK_IS_IN_IS_IN_ATTR_TYP foreign key ("Att_AName")
      references "Attr_Type" ("AName");

alter table "Is_In"
   add constraint FK_IS_IN_IS_IN2_ATTR_TYP foreign key ("AName")
      references "Attr_Type" ("AName");

alter table "Is_Uesd_by"
   add constraint FK_IS_UESD__IS_UESD_B_ATTR_TYP foreign key ("AName")
      references "Attr_Type" ("AName");

alter table "Is_Uesd_by"
   add constraint FK_IS_UESD__IS_UESD_B_REL_TYPE foreign key ("RName")
      references "Rel_type" ("RName");

alter table "Relates"
   add constraint FK_RELATES_RELATES_ENTITY_T foreign key ("EName")
      references "Entity_Type" ("EName");

alter table "Relates"
   add constraint FK_RELATES_RELATES2_REL_TYPE foreign key ("RName")
      references "Rel_type" ("RName");

alter table "Specialization"
   add constraint FK_SPECIALI_SUPER_ENTITY_T foreign key ("EName")
      references "Entity_Type" ("EName");

alter table "Sub"
   add constraint FK_SUB_SUB_SPECIALI foreign key ("SName")
      references "Specialization" ("SName");

alter table "Sub"
   add constraint FK_SUB_SUB2_ENTITY_T foreign key ("EName")
      references "Entity_Type" ("EName");

