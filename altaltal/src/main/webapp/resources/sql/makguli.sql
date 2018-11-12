create table makguli(
    makguli_num number primary key,
    makguli_name varchar2(20),
    makguli_area varchar2(20),
    makguli_make varchar2(30),
    makguli_make_url varchar2(100),
    makguli_content varchar2(150),
    makguli_ingre varchar2(80),
    makguli_degree number,
    makguli_picture varchar2(30),
    makguli_likecount number,
    makguli_readcount number
);

=============================================

 create table makguli_board(
    mboard_num number primary key,
    makguli_num number not null,
    member_nickname varchar2(50) not null,
    mboard_content varchar2(200),
    mboard_sweat number,
    mboard_sour number,
    mboard_body number,
    mboard_spark number,
    mboard_popular number,
    mboard_date date
 );