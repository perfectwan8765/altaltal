create table course(
    course_num number primary key,
    course_area varchar2(20) not null,
    course_name varchar2(100) not null,
    course_picture varchar2(100),
    course_content varchar2(300)
);


==============================

create table travel_site(
    site_num number primary key,
    course_num number not null,
    site_order number,
    site_name varchar2(20),
    site_content varchar2(300),
    site_picture varchar2(100),
    site_maplat number,
    site_maplng number
);