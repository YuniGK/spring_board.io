<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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

<title>Insert title here</title>

<script type="text/javascript">

	function login(f) {
		let m_id = $("#m_id").val().trim();
		let m_pwd = $("#m_pwd").val().trim();
		
		if (m_id == '') {
			alert("아이디를 입력해주세요.");
			
			$("#m_id").val("");
			$("#m_id").focus();
			
			return;
		}
		
		if (m_pwd == '') {
			alert("비밀번호를 입력해주세요.");
			
			$("#m_pwd").val("");
			$("#m_pwd").focus();
			
			return;
		}
		
		$.ajax({
			//----------- 수신 -----------
			//MemgerLoginAaction
			url:'login.do',
			//parameter
			data :{"m_id" : m_id, "m_pwd" : m_pwd},
			//전송방식 POST / GET
			type : "POST",
			//----------- 응답 -----------
			//결과 타입
			dataType : "json",
			//성공시
			success: function(resData){
				/*
				resData = {"result" : "success"}
				resData = {"result" : "fail_id"}
				resData = {"result" : "fail_pwd"}
				*/
				
				if (resData.result == 'fail_id') {
					alert('아이디가 존재하지 않습니다.');
					
					return;
				}
				
				if (resData.result == 'fail_pwd') {
					alert('비밀번호가 틀립니다.');
					
					return;
				}
				
				//로그인 성공 - 메인페이지로 이동
				if ('${empty param.url}' == 'true') {
					location.href = '../board/list.do';
				}else {
					location.href = '${param.url}';
				}
				
			}
		});
		
	}

</script>

<style type="text/css">
	html,
	body,
	#box{height:100%;}
	
	#box{position: relative; margin: 0 auto;}
	
	#box from{position: absolute; top: 45%; width: 200px; left: 50%; margin: 0 -100px;}
</style>

</head>
<body>

	<div id="box">
		<from>
			<div class="input-group">
			    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
			    <input id="m_id" type="text" class="form-control" name="m_id" value="HONG">
			  </div>
			  <div class="input-group">
			    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			    <input id="m_pwd" type="password" class="form-control" name="m_pwd" value="1234">
			  </div>
			  <div class="btnBox">
				  <div class="btn-group">
				 	<input type="button" class="btn" value="로그인" onclick="login(this.form)">
					<input type="button" class="btn del" value="가입"  onclick="location.href='insert_form.do'">
					<input type="button" class="btn" value="목록" onclick="location.href='../board/list.do'">
				</div>
			</div>
		</from>
	</div>

</body>
</html>