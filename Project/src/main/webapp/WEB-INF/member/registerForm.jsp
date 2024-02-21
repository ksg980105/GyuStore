<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.col-sm-10{
		display: flex;
	}
	.container{
		background-image: url("../../images/man.jpg");
		background-repeat: no-repeat;
		background-position: right;
		background-size: 350px;
	}
	body{
 		position: static;
 		width: 100%;
 		height: 100%;
 		margin: 0;
 		padding: 0;
 	}
 	.background-overlay{
 		position: absolute;
 		top: 0;
 		right: 0;
 		bottom: 0;
 		left: 0;
 		background-repeat: no-repeat;
 		background-attachment: fixed;
 		background-size: cover;
 		opacity: 0.3;
 		z-index: -1;
 	}
 	.container{
 		position: static;
 		z-index: 100;
 		background-color: rgba(255,255,255,0.0);
 		padding: 10px;
 	}
 	.form-horizontal{
 		padding-left: 300px;
 	}
 	.err{
      color: red;
      font-weight: bold;
      font-size: 9pt;
   }
   .mybutton {
        background-color: gray; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
var cert = false;
var registercheck = false;

function sendSMS(phone) {
    alert('인증번호를 요청했습니다.');
    // Ajax 요청
    $.ajax({
        type: "GET",
        url: "sendSms.member?phone="+phone,
        data: { phone: phone },
        success: function(response) {
            // 서버에서 받은 응답(response)을 처리
            console.log(response);

            // 이 부분에서 필요한 로직을 추가하여 처리 결과를 사용자에게 보여줄 수 있습니다.
            document.getElementById('verificationSection').style.display = 'flex';
            // 받은 랜덤 값(response)을 전역 변수에 저장
            window.randomValue = response;
			cert = true;
        },
        error: function(error) {
            console.error(error);
            // 에러가 발생했을 경우에 대한 처리를 추가할 수 있습니다.
            alert('전화번호가 일치하지 않습니다.');
        }
    });
}

function verify() {
    var verificationCode = document.getElementById('verificationCode').value;

    // 인증번호가 비어 있으면 알림창을 띄우고 함수를 종료
    if (verificationCode.trim() === '') {
        alert('인증번호를 입력하세요.');
        return;
    }

    // 사용자가 입력한 값
    var userInput = document.getElementById('verificationCode').value;

    // 전역 변수에 저장된 랜덤 값과 사용자가 입력한 값 비교
    if (userInput == window.randomValue) {
        // 일치할 경우, 여기에 원하는 동작 추가
        registercheck = true;
        alert('인증 성공!');
        
    } else {
        // 불일치할 경우, 여기에 원하는 동작 추가
        alert('인증번호가 일치하지 않습니다. 다시 시도하세요.');
    }
}

function searchAddress(){
	new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address1").value = data.address;
        }
    }).open();
}

function isValidEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}
 
function repasswordCheck(){
	if($("input[name=password]").val() == $("input[name=repassword]").val()){
		$("#pwmessage").html("<font color = blue>비밀번호 일치</font>");
		pwuse = "same";
	} else {
		$("#pwmessage").html("<font color = red>비밀번호 불일치</font>");
		pwuse = "nosame";
	}
}

function pwcheck(){
pvalue = $("input[name=password]").val();
	
	var regexp = /^[a-z0-9]{8,16}$/;
	
	if(pvalue.search(regexp) == -1){
		$("#pwcheckmessage").html("<font color = red>길이는 8~16사이여야 합니다.</font>");
		pwerror = "error";
		setTimeout(function(){               
			f.password.select();             
		}, 10);
		return false;
	}
	
	var chk_eng = pvalue.search(/[a-z]/i);
	var chk_num = pvalue.search(/[0-9]/);
	if(chk_eng<0 || chk_num<0){
		$("#pwcheckmessage").html("<font color = red>영문 소문자, 숫자 조합이 아닙니다.</font>");
		pwerror = "error";
		setTimeout(function(){               
			f.password.select();             
		}, 10);
		return false;
	} else {
		$("#pwcheckmessage").html("<font color = blue>올바른 형식</font>");
		pwerror = "noterror";
	}
}

$(document).ready(function() {
    $('#member_id').keyup(function(){ // 아이디 중복체크

        $.ajax({
            url : "idduplicate.member", // 요청url
            data : ({
                inputid : $('input[name="member_id"]').val()
            }),
            success : function(data){
               if(jQuery.trim(data)=='YES'){
                    $('#idmessage').html("<font color=blue>사용 가능합니다.</font>")
                    use = "possible";
                    $('#idmessage').show();
                } else {
                    $('#idmessage').html("<font color=red>이미 사용중인 아이디입니다.</font>")
                    use = "impossible";
                    $('#idmessage').show();
                }
            }
        });
    });
	    
    $('#nickname').keyup(function(){ // 닉네임 중복체크

        $.ajax({
            url : "nickduplicate.member", // 요청url
            data : ({
                inputnick : $('input[name="nickname"]').val()
            }),
            success : function(data){
               if(jQuery.trim(data)=='YES'){
                    $('#nickmessage').html("<font color=blue>사용 가능합니다.</font>");
                    nickuse = "possible";
                    $('#nickmessage').show();
                } else {
                    $('#nickmessage').html("<font color=red>이미 사용중인 닉네임입니다.</font>")
                    nickuse = "impossible";
                    $('#nickmessage').show();
                }
            }
        });
    });
    
    $('#sub').click(function(event){ // submit 클릭
        if(use == "impossible"){
            alert('이미 사용중인 아이디입니다.');
            return false;
            
        } else if(nickuse == "impossible"){
        	alert('이미 사용중인 닉네임입니다.');
        	return false;
        	
        }else if(pwerror == "error"){
        	alert('비밀번호 형식이 맞지않습니다.');
        	return false;
        	
        }else if(pwuse == "nosame"){
        	alert('비밀번호가 일치하지 않습니다');
        	return false;
        	
        }else if(!cert){
        	alert('인증번호를 받으세요');
        	return false;
        	
        }else if(!registercheck){
        	alert('인증번호를 확인하세요');
        	return false;
        }
    });
    
    $('#email').keyup(function () {
        var enteredEmail = $(this).val();

        if (isValidEmail(enteredEmail)) {
            $('#emailmessage').hide();
        } else {
            $('#emailmessage').html("<font color='red'>형식이 올바르지 않습니다.</font>");
            $('#emailmessage').show();
        }
    });
    
 });

</script>
</head>
<body>
	<div class="background-overlay"></div>
	<div class="container" style="margin-top: 0; margin: auto;">
	  <h2 align="center">회원가입</h2><hr>
	  <form:form commandName="memberBean" class="form-horizontal" action="register.member" method="post">
	  	<div class="form-group">
	      <label class="control-label col-sm-2" for="id">아이디:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="Enter id" id="member_id" name="member_id" value="${memberBean.member_id}">&nbsp;
	        <span id="idmessage" style = "display: none;"></span>
	      	<form:errors cssClass="err" path="member_id"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="name">닉네임:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px; opacity: 1;" placeholder="Enter name" id="nickname" name="nickname" value="${memberBean.nickname}">&nbsp;
	      	<span id="nickmessage" style = "display: none;"></span>
	      	<form:errors cssClass="err" path="nickname"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="name">이름:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px; opacity: 1;" placeholder="Enter name" name="name" value="${memberBean.name}">
	      	<form:errors cssClass="err" path="name"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="password">비밀번호:</label>
	      <div class="col-sm-10">
	        <input type="password" class="form-control" style="width:200px;" placeholder="영문 소문자 + 숫자 8~16자리" name="password" value="${memberBean.password}" onkeyup="pwcheck()">
	      	<span id="pwcheckmessage" ></span>
	      	<form:errors cssClass="err" path="password"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="repassword">비밀번호 확인:</label>
	      <div class="col-sm-10">
	        <input type="password" class="form-control" style="width:200px;" placeholder="Enter repassword" name="repassword" value="${memberBean.repassword}" onkeyup="repasswordCheck()">
	        &nbsp;
	        <span id="pwmessage" ></span>
	        <form:errors cssClass="err" path="repassword"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="address1">주소:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="주소를 입력하세요" id="address1" name="address1" value="${memberBean.address1}">&nbsp;
	        <button type = "button" class="btn btn-dark" onclick = "searchAddress()">주소찾기</button>
	      	<form:errors cssClass="err" path="address1"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="address2">상세주소:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="상세주소를 입력하세요" name="address2" value="${memberBean.address2}">
	      	<form:errors cssClass="err" path="address2"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="ssn">핸드폰 번호:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="숫자만 입력해주세요." name="phone" maxlength="11" value="${memberBean.phone}">&nbsp;
	        <input type = "button" class="btn btn-dark" id="phoneVerificationButton" value = "인증번호 요청" onclick = "sendSMS($('#phone').val())">
	      	<form:errors cssClass="err" path="phone"/>
	      </div>
	    </div>
	    <div class="form-group" style="margin-left: 4px;">
		    <div class="col-sm-10" id="verificationSection" style="display: none;">
	          <!-- 이곳에 텍스트 상자 및 기타 요소 추가 -->
	          <label for="verificationCode" class="control-label col-sm-2">인증번호:</label>&nbsp;
	          <input type="text" class="form-control" style="width:200px; margin-left: 9px;" id="verificationCode" name="verificationCode">&nbsp;
	          <input type="button" class="btn btn-dark" value="인증하기" onClick="verify()">
	        </div>
        </div>
	    <div class="form-group">
	      <label class="control-label col-sm-2" for="email">이메일:</label>
	      <div class="col-sm-10">
	        <input type="text" class="form-control" style="width:200px;" placeholder="Enter email" id="email" name="email" value="${memberBean.email}">&nbsp;
	        <span id="emailmessage"></span>
	        <form:errors cssClass="err" path="email"/>
	      </div>
	    </div>
	    <hr>
	    <div class="form-group">        
	      <div class="col-sm-offset-2 col-sm-10">
	        <input type="submit" id="sub" class="mybutton" value="가입하기">&nbsp;
	        <a href="login.member">
	        	<input type="button" class="mybutton" value="취소">
	        </a>
	      </div>
	    </div>
	  </form:form>
	</div>
</body>
</html>