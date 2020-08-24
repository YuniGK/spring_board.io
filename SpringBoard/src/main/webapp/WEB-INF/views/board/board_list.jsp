<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- reset.css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
<!-- normalize.css -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />

<!-- bootstrap  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/basic.css">

<meta http-equiv="Content-Type" content="text/html;">
<script language="JavaScript">
	function insert_form() {
		if ('${empty user}' == 'true') {
			
			//로그인이 안된 경우
			if (confirm("로그인 하신 후 글쓰기가 가능합니다.\r\n로그인 하시겠습니까?") == false) {
				return;
			}
			
			location.href="../member/login_form.do";
			return;
			
		}
		
		location.href="insert_form.do";
		
	}
	
	/* 검색기능 --------------------------------------------------------- */
	$(document).ready(function(){
		/* ajax가 아니기에 페이지가 새롭게 로딩되어 검색어가 사라진다. 
		   검색어를 uri에서 떼와서 넣어줘야 한다.
		   
		   파라미터 값이 없을 경우 전체보기가 나오도록 설정해준다. */
		$("#search").val("${empty param.search ? 'all' : param.search}");
		
		//전체검색 일 시 검색어를 비운다.
		if ('${param.search}' == "all") {
			$("#search_text").val("");
		}
		
		//검색 버튼이 눌리면
		$("#btnFind").click(function () {
			
			let search = $("#search").val();
			let search_text = $("#search_text").val();
			
			//검색카테고리가 전체가 아닌데 검색어가 비어있을 경우
			if (search != 'all' && search_text == '') {
					alert("검색어를 입력해주세요.");
					
					return;
			}
						
			//조회요청
																	//encodeURIComponent 서버로 내용을 보내기전에 인코딩해서 보낸다.
			location.href = "list.do?search="+search+"&search_text="+ encodeURIComponent(search_text, "utf-8");
						   //list.do 생략 가능 - 자기가 자신을 불러왔기에 가능한 부분이다.
					   
		});
		
	});	
</script>

<style type="text/css">
	#login{text-align: right; margin: 40px 0 80px}
	
	.writer{margin: 40px 0 0}
	
	.table td,
	.table th{text-align:center;}
	
	.table th.content a{text-align: left; width: 100%; display: inline-block;}
	
	.table td.red{color:red;}
	
	.form-group{overflow: hidden;}
	
	.floatLeft{float: left; width: 30%;}
	.floatLeft.center{float: left; width: 50%; box-sizing: border-box; padding:0 0 0 10px;}
	.floatLeft.right{text-align: right; width: 20%;}
</style>

</head>

<body>

	<div id="box" class="inner">
		<h2 id="title" class="text-center">게시글 목록</h2>
	
		<div id="login">
			<!-- 로그인이 안된 경우 -->
			<c:if test="${empty user}">
				<input type="button" class="btn" value="로그인" onclick="location.href='../member/login_form.do'">
				<!-- 
				<input type="button" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/login_form.do'">
				-->			
			</c:if>
			
			<!-- 로그인이 된 경우 -->
			<c:if test="${not empty user}">
				${user.m_name}님, 환영합니다.
				<input type="button" class="btn" value="로그아웃" onclick="location.href='../member/logout.do'">
			</c:if>
		</div>
	
		<table class="table">
			<colgroup>
				<col width="10%" />
				<col width="auto" />
				<col width="10%" />
				<col width="20%" />
				<col width="10%" />
			</colgroup>
		
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<!-- 데이터가 있는 경우 -->
				<!-- for(BoardVo vo : list) -->
				<c:forEach var="vo" items="${list}">
				<tr>
					<th>${vo.no} (${vo.idx})</th>
					
					<!-- 삭제되지 않은 게시물 -->
					<c:if test="${vo.use_state eq 'y'}">
						<th class="content">
							<a href="view.do?idx=${vo.idx}&page=${(empty param.page) ? 1 : param.page}&search=${empty param.search ? 'all' : param.search}&search_text=${search_text}" class="num">
								<!-- 답글이면 들여쓰기 -->
								<c:forEach begin="0" end="${vo.depth}">
									&nbsp;
								</c:forEach>
								
								<c:if test="${vo.depth ne 0}">
								 └ 
								</c:if>
								 ${vo.subject}
							</a>
						</th>
					</c:if>	
					
					<!-- 삭제된 게시물 -->
					<c:if test="${vo.use_state eq 'n'}">
						<td class="red">
							삭제된 게시물 입니다.
						</td>
					</c:if>
					
					<th>${vo.name}</th>
					<th>${fn:substring(vo.regdate, 0, 10)}</th>
					<th>${vo.readhit}</th>
				</tr>
				</c:forEach>
								
				<!-- 데이터가 없는 경우 -->
				<c:if test="${empty list}">
					<tr>
						<td colspan="5">현재 등록된 글이 없습니다.</td>
					</tr>
				</c:if>
				
				<!-- 페이지 메뉴 -->
				<tr>
					<td colspan="5">
						<ul class="pagination">
							${pageMenu}
						</ul>
					</td>
				</tr>
				
				<!-- 검색메뉴 -->
				<tr>
					<td colspan="5">
						<div class="form-group">
						  <div class="left floatLeft">
						  	<select class="form-control" id="search">
							    <option value="all">전체보기</option>
							    <option value="name">이름</option>
							    <option value="subject">제목</option>
							    <option value="content">내용</option>
							    <option value="name_subject_content">이름 + 제목 + 내용</option>
							  </select>
						  </div>
						  <div class="center floatLeft">
						  	<!--  ajax가 아니기에 페이지가 새롭게 로딩되어 검색어가 사라진다. 검색어를 uri에서 떼와서 넣어줘야 한다.  -->
						  	<input type="text" id="search_text" class="form-control" value="${param.search_text}">
						  </div>
						  <div class="right floatLeft">
						  	<input type="button" id="btnFind" class="btn" value="검색">
						  </div>
						</div>
						<!-- //검색메뉴 -->
					</td>
				</tr>
			</tbody>
		</table>
		
		<input class="writer btn" type="button" onClick="insert_form();" value="글쓰기">
	</div>

</body>

</html>