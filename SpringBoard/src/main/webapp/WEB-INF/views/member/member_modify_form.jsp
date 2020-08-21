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

<!-- 주소검색 라이브러리 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 

<script type="text/javascript">

	/* jQuery 초기화 */
	$(document).ready(function() {
		/* 주소검색 ============================= */
		$("#btn_find_addr").click(function() {
			var themeObj = {
			   searchBgColor: "#0B65C8", //검색창 배경색
			   queryTextColor: "#FFFFFF" //검색창 글자색
			};
			
			//http://postcode.map.daum.net/guide
			//우편번호 서비스
			new daum.Postcode({
				//테마 -------------------------------------------------------
				//theme: {searchBgColor: "#0B65C8", queryTextColor: "#FFFFFF"},
		        theme: themeObj,
				oncomplete: function(data) {
		            /* 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            예제를 참고하여 다양한 활용법을 확인해 보세요.
		            data = {'zonecode' : 12345, 'address' : '서울시 ...'} */
		            
		            $("#m_zipcode").val(data.zonecode);
		            $("#m_addr").val(data.address);
		            
		        }
		    }).open();
			
		});
		/* //주소검색 =========================== */
		
		/* 라디오 버튼 ========================== */
		
		if ('${vo.m_grader}' == '일반') {
			$("#radioMember").attr("checked", true);
		}else{
			$("#radioAdmin").attr("checked", true);
		}
		
		/*//라디오 버튼 ========================= */
		
	});
	
	/* 전송 =============================== */
	function send(f) {
		var reg = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		
		let m_name = $("#m_name").val().trim();
		let m_pwd = $("#m_pwd").val().trim();
		let m_zipcode = $("#m_zipcode").val().trim();
		let m_addr = $("#m_addr").val().trim();
		
		if (m_name == "") {
			$("#name_text").text("이름을 입력하세요.");
			
			$("#m_name").val("");
			$("#m_name").focus();
			
			return;
		}
		
		if (!reg.test(m_name)) {
			$("#name_text").text("이름을 입력하세요.");
			
			$("#m_name").val("");
			$("#m_name").focus();
			
			return;
		}
		
		$("#name_text").text("");
		
		if (m_pwd == "") {
			$("#pwd_text").text("비밀번호를 입력하세요.");
			
			$("#m_pwd").val("");
			$("#m_pwd").focus();
			
			return;
		}
		
		$("#pwd_text").text("");
		
		if (m_zipcode == "") {
			$("#zipcode_text").text("우편번호를 입력하세요.");
			
			$("#m_zipcode").val("");
			$("#m_zipcode").focus();
			
			return;
		}
		
		$("#m_zipcode").text("");
		
		if (m_addr == "") {
			$("#addr_text").text("주소를 입력하세요.");
			
			$("#m_addr").val("");
			$("#m_addr").focus();
			
			return;
		}
		
		$("#m_addr").text("");
		
		//전송
		f.submit();
		
	}	

</script>

</head>
<body>

	<div id="box" class="inner">
		<h2 id="title" class="text-center" onclick="location.href='modify_form.do?m_idx=${vo.m_idx}'">회원수정</h2>
		
		<form action="modify.do" >
		  <!-- 
		  	   name는 서버에 넘어가는 이름이다. 
		       id는 html에서 사용되는 내용이다. 
		  -->
		  <div class="input-group">
		    <span class="input-group-addon">이름</span>
		    <input id="m_name" type="text" class="form-control" name="m_name" value="${vo.m_name}">
		  </div>
		  <p id="name_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">아이디</span>
		    <input id="m_id" type="text" class="form-control floatL" name="m_id" value="${vo.m_id}" readonly="readonly">
		  </div>
		  <p id="id_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">비밀번호</span>
		    <input id="m_pwd" type="password" class="form-control" name="m_pwd" value="${vo.m_pwd}">
		  </div>
		  <p id="pwd_text"></p>
		  		  
		  <div class="input-group">
		    <span class="input-group-addon">우편번호</span>
		    <input id="m_zipcode" type="text" class="form-control floatL" name="m_zipcode" value="${vo.m_zipcode}">
		    
		    <input type="button" class="btn floatR" value="검색" id="btn_find_addr"> 
		  </div>
		  <p id="zipcode_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">주소</span>
		    <input id="m_addr" type="text" class="form-control" name="m_addr" value="${vo.m_addr}">
		  </div>
		  <p id="addr_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">회원구분</span>
		  	
		  	<label><input type="radio" name="m_grader" class="form-control radioBtn" value="일반" id="radioMember">일반</label>
	  		<label><input type="radio" name="m_grader" class="form-control radioBtn" value="관리자" id="radioAdmin" >관리자</label>		
		  </div>
		  
		  <input type="hidden"  name="m_idx" value="${vo.m_idx}"> 
		  
			<div class="btnBox">
				<div class="btn-group">
					<!-- 중복체크가 완료시 활성화 시킨다. -->
				 	<input id="btnReg" type="button" class="btn" value="수정" onclick="send(this.form);">
					<input type="button" class="btn" value="목록" onclick="location.href='list.do'">
				</div>
			</div>
		</form>
	
	</div>

</body>
</html>