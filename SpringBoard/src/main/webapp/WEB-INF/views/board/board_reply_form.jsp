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
	
<script type="text/javascript">
	function send(f) {
		var subject = f.subject.value.trim();
		var content = f.content.value.trim();
		
		if (subject == "") {
			alert("제목을 입력하세요.");
			
			f.subject.value = "";
			f.subject.focus();
			
			return;
		}
		
		if (content == "") {
			alert("내용을 입력하세요.");
			
			f.content.value = "";
			f.content.focus();
			
			return;
		}
		
		f.action = "reply.do";
		f.submit();
		
	}
</script>

<style type="text/css">
	.btn-box{text-align: center; padding: 80px 0;}
</style>

</head>

<body>
	
	<div id="box" class="inner">
		<h2 id="title" class="text-center">댓글 쓰기</h2>
	
		<form>
			<input type="hidden"  name="idx"  value="${ param.idx }">
			<input type="hidden"  name="page"  value="${ param.page }">
			<table class="table">
				<colgroup>
					<col width="20%" />
					<col width="auto" />
				</colgroup>
				
				<tr>
					<th>제 목</th>
					<td>
						<input name="subject" type="text" class="search" style="width: 100%;">
					</td>
				</tr>
				
				<tr>
					<th>작 성 자</th>
					<td>
						<input name="name" type="text" class="search" style="width: 100%;" value="${user.m_name}" readonly="readonly">
					</td>
				</tr>
				
				<tr>
					<th>내 용</th>
					<td>
						<TEXTAREA NAME='content' rows="9" cols="65" style="width: 100%; resize:none;"></TEXTAREA>
					</td>
				</tr>
				
				<tr class="btn-box">
					<td colspan="2">
						<input type="button" class="btn" onclick="send(this.form);" value="등록">
						<input type="button" class="btn" onclick="location.href='list.do?page=${param.page}'" value="목록">
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>

</html>