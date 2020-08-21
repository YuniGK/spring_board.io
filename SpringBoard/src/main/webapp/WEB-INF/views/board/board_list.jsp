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
</script>

<style type="text/css">
	#login{text-align: right; margin: 40px 0 80px}
	
	.writer{margin: 40px 0 0}
	
	.table td,
	.table th{text-align:center;}
	
	.table th.content a{text-align: left; width: 100%; display: inline-block;}
	
	.table td.red{color:red;}
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
					<th>${vo.no}</th>
					
					<!-- 삭제되지 않은 게시물 -->
					<c:if test="${vo.use_state eq 'y'}">
						<th class="content">
							<a href="view.do?idx=${vo.idx}&page=${(empty param.page) ? 1 : param.page}" class="num">
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
			</tbody>
		</table>
		
		<input class="writer btn" type="button" onClick="insert_form();" value="글쓰기">
	</div>

</body>

</html>