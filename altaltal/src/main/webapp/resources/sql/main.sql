create table visitor_count(
    visitor_num number primary key,
    visitor_agent varchar2(150),
    visitor_date date
);



==========================================

create table feedback(
    feedback_num number primary key,
    feedback_writer varchar2(30),
    feedback_email varchar2(100),
    feedback_message varchar2(300),
    feedback_status varchar2(20),
    feedback_date date
);