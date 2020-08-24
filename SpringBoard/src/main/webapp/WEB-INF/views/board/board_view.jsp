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
	function del(f) {
		//삭제 취소 시, 종료된다.
		if (!confirm("삭제 하시겠습니까?")) return;
		
			f.action = "delete.do?page=${param.page}";

			f.submit();
	}
	
	function modify(f) {
		if (!confirm("수정 하시겠습니까?")) return;
		
		f.action = "modify_form.do";

		f.submit();
	}
	
	function reply(f) {
		//로그인된 유저만 글을 쓸 수 있다.
		if ('${empty user}' == 'true') {
			if(!confirm("로그인 하시겠습니까?"))
				return;
													//현재 경로를 보내준다.
			location.href="../member/login_form.do?url="+location.href;
			return;
		}
		
		//로그인이 된 경우
		location.href = "reply_form.do?idx=${vo.idx}&page=${(empty param.page) ? 1 : param.page}";
		
	}
</script>

<style type="text/css">
.table td { text-indent: 10px;}

input[type="image"]{border:none;}

.content td {word-wrap: break-word; word-break: break-all;}
</style>

</HEAD>

<BODY>
	
	<div id="box" class="inner">
		<h2 id="title" class="text-center">게시글 상세</h2>
	
		<form>
			<table class="table">
				<colgroup>
					<col width="20%" />
					<col width="auto" />
				</colgroup>
				
				<tr>
					<th>제 목</th>
					<td>
						${vo.subject}
					</td>
				</tr>
				
				<tr>
					<th>작 성 자</th>
					<td>
						${vo.name}
					</td>
				</tr>
				
				<tr>
					<th>작 성 일</th>
					<td>
						${fn:substring(vo.regdate, 0, 10)}
					</td>
				</tr>
				
				<tr class="content">
					<th>내 용</th>
					<td>
						<pre>${vo.content}</pre>
					</td>
				</tr>
				
				<tr class="btn-box">
					<td colspan="2">
						<!-- 
						<input type="image" /> 
						<button>
						
						기본적으로 onsubmit()이 동작된다.  
						
						submit 막는 방법 onclick="return false;"
						submit 취소를 요청한다.
						-->
						<input type="button" class="btn" value="목록" onClick="location.href='list.do?page=${param.page}&search=${param.search}&search_text=${search_text}'; return false;">
						
						<%--
							<c:if test="${vo.depth eq 0}">
							
							댓글을 달 수 있는 범위를 지정해둔다.
							<c:if test="${vo.depth lt 2}"> depth < 2
							<c:if test="${vo.depth le 2}"> depth <= 2
						--%>
						<c:if test="${(vo.depth lt 2) and ((param.search eq 'all') or (empty param.search))}">
							<input type="button" class="btn" value="댓글" onClick="reply(this.form); return false;"> 
						</c:if>
						
						<!-- 본인 또는 관리자만 수정 / 삭제 -->
						<c:if test="${(user.m_idx eq vo.m_idx) or (user.m_grader eq '관리자')}">
							<input  type="button" class="btn" value="수정"  onClick="modify(this.form); return false;">
							<input type="button" class="btn" value="삭제"  onClick='del(this.form); return false;'>
						</c:if>
					</td>
				</tr>
			</table>
			
			<input type="hidden" name="page" value="${(empty param.page) ? 1 : param.page}">
			<input type="hidden" name="idx" value="${vo.idx}"> 
			<input type="hidden" name="ref" value="${vo.ref}"> 
		</form>
	</div>
	
</BODY>
</HTML>