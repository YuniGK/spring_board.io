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

<script type="text/javascript">
	function del(m_idx) {
		if (confirm("삭제 하시겠습니까?") == false)
			return;
		
		location.href = "delete.do?m_idx="+m_idx;
	}
	
	function modify(m_idx) {
		location.href = "modify_form.do?m_idx="+m_idx;
	}
		
	/* ============================================ */
	
	if ("${user.m_grader ne '관리자'}" == "true") {
		alert("관리자 페이지 입니다.");
		
		location.href = "../board/list.do";
	}
	
</script>

<title>Insert title here</title>
</head>
<body>

	<div id="box">
		
		<h2 id="title" class="text-center">회원목록</h2>
		
		<div class="joinBox box">
			<input class="btn join-btn" type="button" value="회원가입" onclick="location.href='insert_form.do'">
			<input type="button" class="btn" value="상품 목록" onclick="location.href='../board/list.do'">
		</div>
		
		<table class="table table-striped">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>아이피</th>
				<th>가입일자</th>
				<th>등급</th>
				<th></th>
			</tr>
			
			<c:if test="${empty list}">
				<tr>
					<td colspan="9" class="text-center empty">아직 회원정보가 없습니다.</td>
				</tr>
			</c:if>
			
			<!-- for(MemberVo vo : list) -->
			<c:forEach items="${list}" var="vo">
				<tr>
					<td>${vo.m_idx}</td>
					<td>${vo.m_name}</td>
					<td>${vo.m_id}</td>
					<td>${vo.m_pwd}</td>
					<td>${vo.m_zipcode}</td>
					<td>${vo.m_addr}</td>
					<td>${vo.m_ip}</td>
					<td>${fn:substring(vo.m_regdate,0,10)}</td>
					<td>${vo.m_grader}</td>
					<td>
						<div class="btn-group">
						 	<input type="button" class="btn" value="수정" onclick="modify('${vo.m_idx}');">
							<input type="button" class="btn del" value="삭제"  onclick="del('${vo.m_idx}');">
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
	
	</div>

</body>
</html>