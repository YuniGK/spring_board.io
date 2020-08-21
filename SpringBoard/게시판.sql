/*
 
create sequence seq_board_idx;

/* 작성명이 동일한 사람이 있을 경우 멤버 일련번호를 통해
 * 구별한다. */
CREATE TABLE board(
idx int PRIMARY KEY,   --일련번호
name varchar2(100),    --작성자
m_idx int,			   --멤버 일련번호
subject varchar2(100), --제목
content clob, 		   --내용
ip varchar2(100),	   --아이피
regdate date, 		   --등록일자
readhit int,		   --조회수
use_state char(1),     --사용유무(y - 사용 / n - 미사용)
--답변형 게시판 정보
ref int,			   --메인 글 번호	
step int,			   --그룹글 순서	
depth int			   --댓글의 깊이 / 댓글의 댓글을 파악(댓글 (1), 댓글 (2), 댓글 (3))
)

--참조키
alter table board add constraint fk_board_m_idx
	foreign key(m_idx) references member(m_idx);
	
select * from member;
--최신글을 앞으로 뺀다. desc ↑(내림차순) asc ↓(오름차순)  
select * from board order by ref desc, step asc;

/* seq_border_idx.nextVal - 다음 값
 * seq_border_idx.currVal - 현재값 */ 

--sample data
--새글쓰기
insert into board values(seq_board_idx.nextVal, '홍길동', 2, '더워요', '장마 끝 여름의 시작이네요.', '127.168.7.14',
sysdate, 0, 'y', seq_board_idx.currVal, 0, 0);

insert into board values(seq_board_idx.nextVal, '이유진', 4, '아직 여름이네요', '언제 가을이 올까요?', '127.168.7.16',
sysdate, 0, 'y', 1, 1, 1);

insert into board values(seq_board_idx.nextVal, '홍길동', 2, '그러게요.', '얼른 가을이 왔으면 좋겠네요.', '127.168.7.14',
sysdate, 0, 'y', 1, 2, 2);

--페이징 처리를 위한 sql
--rownum / rank를 이용해 페이징 처리를 할 수 있다.  
select *
from
(
	select rank() over(order by ref desc, step asc) no, b.* 
	from (select * from board) b
) 
where no between 1 and 5

-- from → where → select 순으로 적용된다.

commit

*/