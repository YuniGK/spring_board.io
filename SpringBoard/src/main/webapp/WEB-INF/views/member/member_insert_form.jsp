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
		
		/* ID에 대한 정규식 ============================= */
		let regularID = /^[a-zA-Z0-9]{4,8}$/
		
		/* 중복체크 ============================= */
		//keyup - 키보드가 눌렀다 떨어졌을 때
		$("#m_id").keyup(function(e) {
			//console.log("-----"+e.keyCode);
			
			let m_id = $(this).val();
			
			if (!regularID.test(m_id)) {
				//alert("영문/숫자를 조합하여 작성해주세요.");
				
				$("#id_msg").text("영문/숫자를 이용해 작성해주세요.");
				$("#id_msg").css("color", "red");
				
				//회원가입 버튼 비활성화
				$("#btnReg").attr("disabled", true);
								
				return;
			}
			
			/* 
			중복체크한다. 
			
			ajax가 아닌 페이지 이동으로 체크할 경우 페이지가 새롭게 로딩 되는 부분으로
			페이지가 비어져있다.
			*/
			$.ajax({
				
				//MemberCheckIdAction
				url : 'check_id.do',
				//파라미터값
				data : {"m_id" : m_id},
				/* ↑ 전달인자 
								↓ 응답 */
				//수신데이터 타입
				dataType : "json",
				//성공시
				success : function(resData) {
					//resData = {"result": true}
					
					if(!resData.result){
						
						$("#id_msg").text("사용중인 아이디입니다.");
						$("#id_msg").css("color", "red");
						
						$("#btnReg").attr("disabled", true);
						
						retrun;
					}
					
					$("#id_msg").text("사용가능한 아이디입니다.");
					$("#id_msg").css("color", "blue");
					
					//회원가입 버튼 활성화
					$("#btnReg").attr("disabled", false);
					
				}
				
			});
			
		});		
		/* //중복체크 =========================== */
		
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
		<h2 id="title" class="text-center" onclick="location.href='insert_form2.do'">회원가입</h2>
		
		<form action="insert.do" >
		  <!-- 
		  	   name는 서버에 넘어가는 이름이다. 
		       id는 html에서 사용되는 내용이다. 
		  -->
		  <div class="input-group">
		    <span class="input-group-addon">이름</span>
		    <input id="m_name" type="text" class="form-control" name="m_name" placeholder="이름">
		  </div>
		  <p id="name_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">아이디</span>
		    <input id="m_id" type="text" class="form-control" name="m_id" placeholder="아이디">
		    <span id="id_msg"></span>
		  </div>
		  
		  <div class="input-group">
		    <span class="input-group-addon">비밀번호</span>
		    <input id="m_pwd" type="password" class="form-control" name="m_pwd" placeholder="비밀번호">
		  </div>
		  <p id="pwd_text"></p>
		  		  
		  <div class="input-group">
		    <span class="input-group-addon">우편번호</span>
		    <input id="m_zipcode" type="text" class="form-control floatL" name="m_zipcode" placeholder="우편번호">
		    
		    <input type="button" class="btn floatR" value="검색" id="btn_find_addr"> 
		  </div>
		  <p id="zipcode_text"></p>
		  
		  <div class="input-group">
		    <span class="input-group-addon">주소</span>
		    <input id="m_addr" type="text" class="form-control" name="m_addr" placeholder="주소">
		  </div>
		  <p id="addr_text"></p>
		  
		  <input type="hidden" name="m_grader" value="일반">
		  
			<div class="btnBox">
				<div class="btn-group">
					<!-- 중복체크가 완료시 활성화 시킨다. -->
				 	<input id="btnReg" type="button" class="btn" value="등록" onclick="send(this.form);" disabled="disabled">
					<input type="button" class="btn" value="목록" onclick="location.href='../shop/list.do'">
				</div>
			</div>
		</form>
	
	</div>

</body>
</html>