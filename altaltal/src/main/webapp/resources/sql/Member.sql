create table Member (
   member_email  varchar2(50) primary key,
   member_password varchar2(30) not null,
   member_admin number,
   member_nickname varchar2(50) not null,
   member_picture varchar2(30),
   member_area varchar2(20) not null,
   member_country varchar2(20) not null,
   member_makguli varchar2(50),
   member_place varchar2(50),
   member_date date
);