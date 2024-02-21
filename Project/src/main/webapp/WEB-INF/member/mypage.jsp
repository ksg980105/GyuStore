<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	th {
        width: 25%;
        text-align: center;
        background-color: gray; /* 헤더 배경색 */
        color: white;
        padding: 10px;
    }

    td {
        padding: 10px;
    }
	body, html {
	  margin: 0;
	  font-family: Arial;
	}
	
	.tablink {
	  background-color: #555;
	  color: white;
	  float: left;
	  border: none;
	  outline: none;
	  cursor: pointer;
	  padding: 14px 16px;
	  font-size: 17px;
	  width: 25%;
	}
	
	.tablink:hover {
	  background-color: #777;
	}
	
	.tabcontent {
	  color: white;
	  display: none;
	  padding: 100px 20px;
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
        margin-top: 10px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
var cert = false;
var delcert = false;
var registercheck = false;
var delregistercheck = false;

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

function updateCheck(){
	if(f.nickname.value == ""){
		alert('닉네임을 입력하세요.');
		return false;
	}
	if(f.password.value == ""){
		alert('비밀번호를 입력하세요.');
		return false;
	}
	if(f.email.value == ""){
		alert('이메일을 입력하세요.');
		return false;
	}
	if(f.address1.value == ""){
		alert('주소를 입력하세요.');
		return false;
	}
	if(f.address2.value == ""){
		alert('상세주소를 입력하세요.');
		return false;
	}
}

function searchAddress(){
	new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address1").value = data.address;
        }
    }).open();
}

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("defaultOpen").click();
});

function openPage(pageName, elmnt, color) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }
    document.getElementById(pageName).style.display = "block";
    elmnt.style.backgroundColor = color;
}

function isValidEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

$(document).ready(function() {
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
		if(!cert){
        	alert('인증번호를 받으세요');
        	return false;
        	
        }
		if(!registercheck){
        	alert('인증번호를 확인하세요');
        	return false;
        }
        if(nickuse == "impossible"){
        	alert('이미 사용중인 닉네임입니다.');
        	return false;
        	
        }else if(pwerror == "error"){
        	alert('비밀번호 형식이 맞지않습니다.');
        	return false;
        	
        }
    });
    
    $('#delsub').click(function(event){ // submit 클릭
		if(!delcert){
        	alert('인증번호를 받으세요');
        	return false;
        	
        }
		if(!delregistercheck){
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

<body>
	<button class="tablink" onclick="openPage('Tab1', this, 'black')" id="defaultOpen">내정보</button>
	<button class="tablink" onclick="openPage('Tab2', this, 'black')">정보수정</button>
	<button class="tablink" onclick="openPage('Tab3', this, 'black')">구매상품</button>
	<button class="tablink" onclick="openPage('Tab4', this, 'black')">회원탈퇴</button>
	
	<div id="Tab1" class="tabcontent">
	  <table class="table table-bordered border-success" style="width: 600px; margin: auto;">
		  <tr>
		  	<th>아이디</th>
		  	<td>${loginInfo.member_id}</td>
		  </tr>
		  <tr>
		  	<th>닉네임</th>
		  	<td>${loginInfo.nickname}</td>
		  </tr>
		  <tr>
		  	<th>이름</th>
		  	<td>${loginInfo.name}</td>
		  </tr>
		  <tr>
		  	<th>비밀번호</th>
		  	<td>${loginInfo.password}</td>
		  </tr>
		  <tr>
		  	<th>휴대폰번호</th>
		  	<td>${loginInfo.phone}</td>
		  </tr>
		  <tr>
		  	<th>이메일</th>
		  	<td>${loginInfo.email}</td>
		  </tr>
		  <tr>
		  	<th>주소</th>
		  	<td>${loginInfo.address1}</td>
		  </tr>
		  <tr>
		  	<th>상세주소</th>
		  	<td>${loginInfo.address2}</td>
		  </tr>
	  </table>
	</div>
	
	<div id="Tab2" class="tabcontent">
	  <form name="f" action="update.member" method="post" onsubmit="return updateCheck()">
	  	<input type="hidden" name="member_id" value="${loginInfo.member_id}">
	  	<input type="hidden" name="name" value="${loginInfo.name}">
	  	<table class="table table-bordered border-success" style="width: 600px; margin: auto;">
		  <tr>
		  	<th>아이디</th>
		  	<td>${loginInfo.member_id}</td>
		  </tr>
		  <tr>
		  	<th>닉네임</th>
		  	<td>
		  		<input type="text" id="nickname" name="nickname" size="9" value="${loginInfo.nickname}">
		  		<span id="nickmessage" style = "display: none;"></span>
			</td>
		  </tr>
		  <tr>
		  	<th>이름</th>
		  	<td>${loginInfo.name}</td>
		  </tr>
		  <tr>
		  	<th>비밀번호</th>
		  	<td>
		  		<input type="password" id="password" name="password" size="9" value="${loginInfo.password}" onkeyup="pwcheck()">
		  		<span id="pwcheckmessage"></span>
			</td>
		  </tr>
		  <tr>
		  	<th>이메일</th>
		  	<td>
				<input type="text" id="email" name="email" size="17" value="${loginInfo.email}">
				<span id="emailmessage"></span>
			</td>
		  </tr>
		  <tr>
		  	<th>주소</th>
		  	<td>
		  		<input type="text" id="address1" name="address1" size="9" value="${loginInfo.address1}">&nbsp;
		  		<button type = "button" class="btn btn-dark" onclick = "searchAddress()">주소찾기</button>
		  	</td>
		  </tr>
		  <tr>
		  	<th>상세주소</th>
		  	<td>
		  		<input type="text" name="address2" size="9" value="${loginInfo.address2}">
		  	</td>
		  </tr>
		  <tr>
		  	<th>휴대폰번호</th>
		  	<td>
		  		<input type="text" id="phone" name="phone" maxlength="11" size="9" value="${loginInfo.phone}">
		  		<input type = "button" class="btn btn-dark" id="phoneVerificationButton" value = "인증번호 요청" onclick = "sendSMS($('#phone').val())">
		  	</td>
		  </tr>
		  <tr>
		  	<th>휴대폰인증</th>
		  	<td>
		  	  <input type="text" id="verificationCode" name="verificationCode" size="9">&nbsp;
	          <input type="button" class="btn btn-dark" value="인증하기" onClick="verify()">
		  	</td>
		  </tr>
		  <tr>
		  	<td colspan="2" align="center">
		  		<input type="submit" id="sub" class="mybutton" value="수정">
		  		<input type="button" class="mybutton" value="취소">
		  	</td>
		  </tr>
	   </table>
	  </form>
	</div>
	
	<div id="Tab3" class="tabcontent">
	  <h3>구매상품</h3>
	</div>
	
	<div id="Tab4" class="tabcontent">
	  <form action="delete.member" method="post">
	  	<input type="hidden" name="member_id" value="${loginInfo.member_id}">
	  	<input type="hidden" name="name" value="${loginInfo.name}">
	  	<table class="table table-bordered border-success" style="width: 600px; margin: auto;">
		  <tr>
		  	<th>아이디</th>
		  	<td>${loginInfo.member_id}</td>
		  </tr>
		  <tr>
		  	<th>닉네임</th>
		  	<td>${loginInfo.nickname}</td>
		  </tr>
		  <tr>
		  	<th>이름</th>
		  	<td>${loginInfo.name}</td>
		  </tr>
		  <tr>
		  	<th>휴대폰번호</th>
		  	<td>
		  		<input type="text" id="phone" name="phone" maxlength="11" size="9" value="${loginInfo.phone}">
		  		<input type = "button" class="btn btn-dark" id="phoneVerificationButton" value = "인증번호 요청" onclick = "sendSMS($('#phone').val())">
		  	</td>
		  </tr>
		  <tr>
		  	<th>휴대폰인증</th>
		  	<td>
		  	  <input type="text" id="verificationCode" name="verificationCode" size="9">&nbsp;
	          <input type="button" class="btn btn-dark" value="인증하기" onClick="verify()">
		  	</td>
		  </tr>
		  <tr>
		  	<td colspan="2" align="center">
		  		<input type="submit" id="delsub" class="mybutton" value="회원탈퇴">
		  		<input type="button" class="mybutton" value="취소">
		  	</td>
		  </tr>
	   </table>
	  </form>
	</div>
</body>