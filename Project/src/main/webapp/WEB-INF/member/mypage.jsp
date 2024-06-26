<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	#Tab1 th, #Tab2 th, #Tab4 th {
        width: 20%;
        text-align: center;
        background-color: gray; /* 헤더 배경색 */
        color: white;
        padding: 10px;
    }
    
    #Tab3 th {
    	text-align: center;
        background-color: gray; /* 헤더 배경색 */
        color: white;
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
	  padding: 10px 12px;
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
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	$('.order_id').each(function() {
        var orderId = $(this).val();
        checkRefundStatus(orderId);
    });
	
	function checkRefundStatus(orderId) {
	    // Ajax를 이용하여 서버에 상태 확인 요청
	    $.ajax({
	        url: "refundCheck.member",
	        type: "GET",
	        data: ({ order_id: orderId }),
	        success: function(response) {
	        	if(response === "0"){
	        		$('#reviewButton_' + orderId).hide();
	        		$('#cancelButton_' + orderId).hide();
	        		$('#payStatus_' + orderId).text('결제 완료').css('color','green');
	        	}else if (response === "1") {
	                // 환불이 완료되었을 경우 버튼을 숨기고 대신 환불 완료 메시지를 표시
	                $('#refundButton_' + orderId).hide();
	                $('#checkButton_' + orderId).hide();
	                $('#reviewButton_' + orderId).hide();
	                $('#refundStatus_' + orderId).text('환불신청 완료').css('color','red');
	            }else if (response === "2"){
	            	$('#refundButton_' + orderId).hide();
	            	$('#checkButton_' + orderId).hide();
	            	$('#reviewButton_' + orderId).hide();
	            	$('#cancelButton_' + orderId).hide();
	                $('#refundStatus_' + orderId).text('환불 완료').css('color','red');
	            }else if (response === "3"){
	            	$('#refundButton_' + orderId).hide();
	            	$('#checkButton_' + orderId).hide();
	            	$('#cancelButton_' + orderId).hide();
	                $('#refundStatus_' + orderId).text('구매 확정').css('color','blue');
	            }else if (response === "4"){
	            	$('#payStatus_' + orderId).text('결제 완료').css('color','green');
	            	$('#refundButton_' + orderId).hide();
	            	$('#reviewStatus_' + orderId).text('리뷰작성 완료').css('color','blue');
	            	$('#checkButton_' + orderId).hide();
	            	$('#cancelButton_' + orderId).hide();
	            	$('#reviewButton_' + orderId).hide();
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	}
    
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
 
 //환불신청버튼 클릭시
 function cancelPay(order_id){
	 window.open("refund.member?order_id="+order_id, "_blank", "width=500, height=500, left=450, top=150");
 }
 
 function reviewSub(pname,member_id,order_id){
	 if (pname.indexOf(",") === -1) {
		 window.open("insert.review?pname="+pname+"&&member_id="+member_id+"&&order_id="+order_id, "_blank", "width=500, height=500, left=450, top=150");		 
	 }else{
		 window.open("cartInsert.review?pname="+pname+"&&member_id="+member_id+"&&order_id="+order_id, "_blank", "width=500, height=500, left=450, top=150");
	 }
 }
 
 function confirmBuy(order_id){
	 $.ajax({
         type: "GET",
         url: "confirm.member", // 서버의 환불 처리 컨트롤러 경로
         data: {
         	order_id: order_id
         },
         success: function(response) {
             alert("구매확정이 완료되었습니다.");
             location.reload();
         },
         error: function() {
             alert("구매확정중 문제가 발생했습니다.");
         }
     });
 }
 
 function cancelRequest(order_id){
	 $.ajax({
         type: "GET",
         url: "cancel.member", // 서버의 환불 처리 컨트롤러 경로
         data: {
         	order_id: order_id
         },
         success: function(response) {
             alert("환불취소가 완료되었습니다.");
             location.reload();
         },
         error: function() {
             alert("환불취소중 문제가 발생했습니다.");
         }
     });
 }
 
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
		  <tr>
		  	<th>보유포인트</th>
		  	<td><font color="blue">${loginInfo.point}</font> point</td>
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
	  <table class="table table-bordered border-success" style="width: 1000px; margin: auto;">
	  	<c:if test="${loginInfo.member_id != 'admin'}">
		  	<c:if test="${empty orderList}">
		  	  <tr>
			  	<th>상품이미지</th>
			  	<th>상품명</th>
			  	<th>수량</th>
			  	<th>가격</th>
			  	<th>적립포인트</th>
			  	<th>구매현황</th>
			  </tr>
			  <tr>
			  	<td colspan="6" align="center">구매한 상품이 없습니다.</td>
			  </tr>
		  	</c:if>
		  	<c:forEach var="order" items="${orderList}">
			  <tr>
			  	<th>상품이미지</th>
			  	<th>상품명</th>
			  	<th>수량</th>
			  	<th>가격</th>
			  	<th>적립포인트</th>
			  	<th>구매현황</th>
			  </tr>
			  <tr align="center">
			    <!-- 장바구니로 여러 책 담아서 구매했을 경우 -->
			  	<c:if test="${order.pimage == 'null'}">
			  		<td><img src="resources/img/books.jpg" width="200" height="10"></td> 
			  	</c:if>
			  	<!-- 책 한권만 구매했을 경우 -->
			  	<c:if test="${order.pimage != 'null'}">
			  		<td><img src="<%=request.getContextPath()%>/resources/productImage/${order.pimage}" width="200" height="10"></td>
			  	</c:if>
			  	<td>${order.pname}</td>
			  	<td>${order.pop_out}</td>
			  	<td>${order.productPrice - order.using_point} 원</td>
			  	<td>${order.point} p</td>
			  	<td>
			  		<span id="payStatus_${order.order_id}"></span><br>
			  		<button id="refundButton_${order.order_id}" onclick="cancelPay('${order.order_id}')">환불신청</button><br>
			  		<button id="checkButton_${order.order_id}" onclick="confirmBuy('${order.order_id}')">구매확정</button>
			  		<span id="refundStatus_${order.order_id}"></span><br>
			  		<button id="cancelButton_${order.order_id}" onclick="cancelRequest('${order.order_id}')">환불취소</button><br>
			  		<button id="reviewButton_${order.order_id}" onclick="reviewSub('${order.pname}','${loginInfo.member_id}','${order.order_id}')">리뷰작성</button><br>
			  		<span id="reviewStatus_${order.order_id}"></span><br>
			  	</td>
			  </tr>
			  <input type="hidden" class="order_id" value="${order.order_id}">
			</c:forEach>
		</c:if>
	  </table>
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