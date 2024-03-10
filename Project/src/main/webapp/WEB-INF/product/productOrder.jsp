<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <style>
	th{
		width: 25%;
		background-color: #E2E2E2;
		text-align: right;
	}
	
	.btn-secondary:hover {
	    color: #fff !important;  // 글자색을 흰색으로 변경
	}
  </style>
	
  <script type="text/javascript">
		var point = 0;
		var check = false;
	
		//포인트 초과, 문자 입력시 초기화
		function checkPoint(input, availablePoint, total) {
		    if (input.value === '') {
		        return;  // 입력 값이 비어있으면 검사를 건너뜁니다.
		    }
		
		    var inputValue = parseInt(input.value);
		    if (isNaN(inputValue)) {
		        input.value = 0;
		        alert('숫자만 입력해주세요.');
		        check = false;
		    } else if (inputValue > availablePoint) {
		        input.value = 0;
		        alert('사용 가능한 포인트를 초과할 수 없습니다.');
		        check = false;
		    } else if (inputValue > total){
		    	input.value = 0;
		    	alert('상품가격을 초과한 포인트를 사용할 수 없습니다.');
		    	alert(total);
		    	check = false;
		    } else {
	            point = inputValue;
	            check = true;
	        }
			updatePrice();
		}
		
		// 입력 값이 비어있으면 0으로 설정
		function fillZero(input) {
		    if (input.value === '') {
		        input.value = '0';
		    }
		}
		
		// 포인트 입력시 총결제금액에 반영
		function updatePrice() {
			var productPrice = ${productBean.price * pop_out};
	        var totalPrice = productPrice - point; // 상품가격에서 포인트를 차감하여 총 가격 계산
	        if(check == true){
	        	document.getElementById('price').innerHTML = totalPrice + ' 원';
	        }else{
	        	document.getElementById('price').innerHTML = productPrice + ' 원';
	        }
	        
	     // 아임포트에서 사용할 결제 정보 설정
            var iamportInfo = {
	    		pg: 'html5_inicis',
	    		pay_method: 'card',
                //merchant_uid: "order_no_0002",
                name: '${productBean.pname}',
                amount: totalPrice, // 변경된 변수 사용
                buyer_email: '${loginInfo.email}',
                buyer_name: '${loginInfo.name}',
                buyer_tel: '${loginInfo.phone}',
                buyer_addr: '${loginInfo.address1} ${loginInfo.address2}',
                //buyer_postcode: '123-456',
                m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}',
                escrow: true,
                vbank_due: 'YYYYMMDD'
                // ... (기타 아임포트 설정)
            };
	     
            $('#paymentButton').on('click', function (event) {
                event.preventDefault();

                // 아임포트 결제 화면 열기
                IMP.init('imp07511880'); // 본인의 아임포트 키로 교체
                IMP.request_pay(iamportInfo, function (rsp) {
                    if (rsp.success) {
                        // 결제 성공 시 처리
                        alert('결제가 완료되었습니다.');
                        
                     	// 서버로 결제 성공 정보 전송
                        payInfo(rsp);
                     	//페이지 이동
                        window.location.href = "view.main";
                    } else {
                        // 결제 실패 시 처리
                        alert('결제에 실패하였습니다.\n에러 메시지: ' + rsp.error_msg);
                    }
                });
            });
	    }
		
		// 결제 성공 정보를 서버로 전송하는 함수
	    function payInfo(rsp) {
	        $.ajax({
	            type: "POST",
	            url: "order.product",
	            data: {
	                name: '${loginInfo.name}',
	                email: '${loginInfo.email}',
	                pop_out: '${pop_out}',
	                address1: '${loginInfo.address1}',
	                address2: '${loginInfo.address2}',
	                phone: '${loginInfo.phone}',
	                pimage: '${productBean.pimage}',
	                pname: '${productBean.pname}',
	                point: '${productBean.point}',
	                productPrice: '${productBean.price * pop_out}',
	                requestOrder: $('input[name="requestOrder"]:checked').val(),
	                using_point: $('input[name="using_point"]').val()
	            },
	            success: function (response) {
	                // 서버 응답을 처리하려면 필요한 경우 처리
	                console.log("결제 정보가 서버로 전송되었습니다.");
	            },
	            error: function (error) {
	                // 요청이 실패한 경우 에러를 처리
	                console.error("서버로 결제 정보 전송 중 오류 발생", error);
	            }
	        });
	    }
		
		// 상품페이지로 이동
		function goList(){
			location.href = "view.product";
		}
	</script>
</head>
<body>
	<div class="container" style="width: 1000px;">
		<div class="row">
			<h2><b>주문/결제</b></h2>
			<hr>
			
			<h3>구매자 정보</h3>
			<table border="1" class="table" style="width: 100%;">
				<tr>
					<th>이름</th>
					<td>${loginInfo.name}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${loginInfo.email}</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td>${loginInfo.phone}</td>
				</tr>
			</table>
			
			<br>
			<h3>받는사람 정보</h3>
			<table border="1" class="table" style="width: 100%;">
				<tr>
					<th>이름</th>
					<td>${loginInfo.name}</td>
				</tr>
				<tr>
					<th>배송주소</th>
					<td>${loginInfo.address1} ${loginInfo.address2} 
						<font color="red" size="1"> &nbsp;&nbsp;*배송지 변경은 마이페이지 주소 변경 후 가능합니다.</font>
					</td>
				</tr>
				<tr>
					<th>휴대폰번호</th>
					<td>${loginInfo.phone}</td>
				</tr>
				<tr>
					<th>배송 요청사항</th>
					<td>
						<input type="radio" name="requestOrder" value="빠른배송 해주세요.">빠른배송 해주세요.<br>
						<input type="radio" name="requestOrder" value="경비실에 맡겨주세요.">경비실에 맡겨주세요.<br>
						<input type="radio" name="requestOrder" value="문앞에 놔주세요.">문앞에 놔주세요.<br>
					</td>
				</tr>
			</table>
			
			<h3>상품 정보</h3>
			<table border="1" class="table" style="width: 100%;">
				<tr>
					<th>상품이미지</th>
					<td>
						<img src="<%=request.getContextPath()%>/resources/productImage/${productBean.pimage}" style="width:100px; height:100px;">
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>${productBean.pname}</td>
				</tr>
				<tr>
					<th>주문 갯수</th>
					<td>${pop_out}</td>
				</tr>
				<tr>
					<th>적립 포인트</th>
					<td>
						<font color="blue">${productBean.point}</font> point
					</td>
				</tr>
			</table>
			
			<h3>결제 정보</h3>
			<table border="1" class="table" style="width: 100%;">
				<tr>
					<th>총상품가격</th>
					<td>${productBean.price * pop_out} 원</td>
				</tr>
				<tr>
					<th>포인트 사용</th>
					<td>
						<input type="text" name="using_point" value="0" size="10" onkeyup="checkPoint(this, ${loginInfo.point}, ${productBean.price * pop_out})" onblur="fillZero(this); updatePrice();"> 
						<font color="blue" size="2"><b>(사용 가능 포인트: ${loginInfo.point} p)</b></font>
					</td>
				</tr>
				<tr>
					<th>주문 수량</th>
					<td>${pop_out}</td>
				</tr>
				<tr>
					<th>배송비</th>
					<td>0 원</td>
				</tr>
				<tr>
					<th>적립 포인트</th>
					<td>
						<font color="blue">${productBean.point * pop_out}</font> point
					</td>
				</tr>
				<tr>
					<th>총결제금액</th>
					<td id="price">${productBean.price * pop_out} 원</td>
				</tr>
			</table>
			
			<br>
			<table style="margin: auto;">
				<tr>
					<td>
						<input type="button" id="paymentButton" class="btn btn-secondary btn-lg" value="결제하기"> &nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-secondary btn-lg" onClick="goList()">취소</button>
					</td>
				</tr>
			</table>
			
			<br><br><br><br><br>
		</div>
	</div>
	</body>
</html>