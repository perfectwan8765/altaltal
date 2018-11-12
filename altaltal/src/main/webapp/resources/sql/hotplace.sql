create table hotplace(
    place_num number primary key,
    place_name varchar2(30) not null,
    place_area varchar2(20) not null,
    place_juso varchar2(100),
    place_menu varchar2(100),
    place_phone varchar2(50),
    place_content varchar2(300),
    place_maplat number,
    place_maplng number,
    place_price varchar2(50),
    place_url varchar2(100),
    place_picture varchar2(400),
    place_likecount number,
    place_readcount number
);

========================================
create table hotplace_board(
    pboard_num number primary key,
    place_num number not null,
    member_nickname varchar2(50) not null,
    pboard_content varchar2(200),
    pboard_taste number,
    pboard_price number,
    pboard_service number,
    pboard_date date
);