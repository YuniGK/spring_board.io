/*
 
create sequence seq_board_idx;

/* �ۼ����� ������ ����� ���� ��� ��� �Ϸù�ȣ�� ����
 * �����Ѵ�. */
CREATE TABLE board(
idx int PRIMARY KEY,   --�Ϸù�ȣ
name varchar2(100),    --�ۼ���
m_idx int,			   --��� �Ϸù�ȣ
subject varchar2(100), --����
content clob, 		   --����
ip varchar2(100),	   --������
regdate date, 		   --�������
readhit int,		   --��ȸ��
use_state char(1),     --�������(y - ��� / n - �̻��)
--�亯�� �Խ��� ����
ref int,			   --���� �� ��ȣ	
step int,			   --�׷�� ����	
depth int			   --����� ���� / ����� ����� �ľ�(��� (1), ��� (2), ��� (3))
)

--����Ű
alter table board add constraint fk_board_m_idx
	foreign key(m_idx) references member(m_idx);
	
select * from member;
--�ֽű��� ������ ����. desc ��(��������) asc ��(��������)  
select * from board order by ref desc, step asc;

/* seq_border_idx.nextVal - ���� ��
 * seq_border_idx.currVal - ���簪 */ 

--sample data
--���۾���
insert into board values(seq_board_idx.nextVal, 'ȫ�浿', 2, '������', '�帶 �� ������ �����̳׿�.', '127.168.7.14',
sysdate, 0, 'y', seq_board_idx.currVal, 0, 0);

insert into board values(seq_board_idx.nextVal, '������', 4, '���� �����̳׿�', '���� ������ �ñ��?', '127.168.7.16',
sysdate, 0, 'y', 1, 1, 1);

insert into board values(seq_board_idx.nextVal, 'ȫ�浿', 2, '�׷��Կ�.', '�� ������ ������ ���ڳ׿�.', '127.168.7.14',
sysdate, 0, 'y', 1, 2, 2);

--����¡ ó���� ���� sql
--rownum / rank�� �̿��� ����¡ ó���� �� �� �ִ�.  
select *
from
(
	select rank() over(order by ref desc, step asc) no, b.* 
	from (select * from board) b
) 
where no between 1 and 5

-- from �� where �� select ������ ����ȴ�.

commit

*/