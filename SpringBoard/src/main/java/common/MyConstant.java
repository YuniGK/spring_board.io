package common;

public class MyConstant {

	/* 상수를 사용할 경우 한 곳에 모아서 적는다. 
	 * 각 카테고리 별로 나눈다. */
	public static class Board {
		//게시판 상수
		
		//한페이지당 보여질 게시물 수
		public static final int BLOCK_LIST = 5;
		
		//한 화면에 보여질 메뉴 갯수 
		public static final int BLOCK_PAGE = 3;
		
	}
	
	public static class Notice {
		//공지사항 상수
		
		//한페이지당 보여질 게시물 수
		public static final int BLOCK_LIST = 3;
		//한 화면에 보여질 메뉴 갯수 
		public static final int BLOCK_PAGE = 3;
	}
	
}
