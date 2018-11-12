create table free_board(
    free_num number primary key,
    member_nickname varchar2(50),
    free_subject varchar2(30),
    free_content varchar2(100),
    free_readcount number,
    free_ref number,
    free_ref_seq number,
    free_ref_level number,
    free_date date
);