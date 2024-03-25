<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    <style>
        .cart-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }
        .cart-body {
            padding-top: 20px;
        }
        .cart-footer {
            padding-top: 20px;
            padding-bottom: 20px;
        }
        .total-price {
            font-weight: bold;
        }
        .clearfix::after {
            content: "";
            clear: both;
            display: table;
        }
        #tb th{
        	width: 20%;
        }
    </style>
    
    <script type="text/javascript">
	    var point = 0;
		var check = false;
		var usePointtotalPrice = 0;
		var totalPrice = ${totalPrice};
		var productNamesString = "";
		var productPqtyHidden = "";
		
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
	        usePointtotalPrice = totalPrice - point; // 상품가격에서 포인트를 차감하여 총 가격 계산
	        if(check == true){
	        	document.getElementById('price').innerHTML = usePointtotalPrice + ' 원';
	        }else{
	        	document.getElementById('price').innerHTML = totalPrice + ' 원';
	        }
	    }
		
		function payment(){
		    var requestOrder = document.querySelector('input[name="requestOrder"]:checked');
			
		    if (!requestOrder) {
		        alert("배송 요청사항을 선택하세요.");
		        return false;
		    }
		    
		    if (totalPrice == 0){
		    	alert("장바구니에 상품이 없습니다.");
		    	return false;
		    }
		    
		    var amount = check ? usePointtotalPrice : totalPrice;

		    IMP.init('imp07511880');
		    
		    productNamesString = document.getElementById('productNamesHidden').value;
		    productPqtyHidden = document.getElementById('productPqtyHidden').value;

		    //결제시 전달되는 정보
		    IMP.request_pay({
		        pg: 'html5_inicis',
		        pay_method: 'card',
		        //merchant_uid: "order_no_0002",
		        name: productNamesString,
		        amount: amount, // 변경된 변수 사용
		        buyer_email: '${loginInfo.email}',
		        buyer_name: '${loginInfo.name}',
		        buyer_tel: '${loginInfo.phone}',
		        buyer_addr: '${loginInfo.address1} ${loginInfo.address2}',
		        //buyer_postcode: '123-456',a
		        m_redirect_url: '{모바일에서 결제 완료 후 리디렉션 될 URL}',
		        escrow: true,
		        vbank_due: 'YYYYMMDD'    
		        // ... (기타 아임포트 설정)
		    }, function(rsp) {
		        var result = '';
		        if ( rsp.success ) {
		            // 결제 성공 시 처리
		            alert('결제가 완료되었습니다.');
		            
		            // 서버로 결제 성공 정보 전송
		            payInfo(rsp, productNamesString, productPqtyHidden);
		            //페이지 이동
		            window.location.href = "view.main";
		        } else {
		            // 결제 실패 시 처리
		            alert('결제에 실패하였습니다.\n에러 메시지: ' + rsp.error_msg);
		        }
		    });
		}
		
		// 결제 성공 정보를 서버로 전송하는 함수
	    function payInfo(rsp, productNamesString, productPqtyHidden) {
		    $.ajax({
		        type: "POST",
		        url: "order.product",
		        data: {
		            name: '${loginInfo.name}',
		            email: '${loginInfo.email}',
		            pop_out: productPqtyHidden,
		            address1: '${loginInfo.address1}',
		            address2: '${loginInfo.address2}',
		            phone: '${loginInfo.phone}',
		            pimage: 'null',
		            pname: productNamesString,
		            point: ${totalPoint},
		            productPrice: '${totalPrice}',
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

    </script>
</head>
<body>
    <div class="jumbotron jumbotron-fluid">
        <div class="container">
            <h3 class="display-4" align="center">장바구니</h3>
        </div>
    </div>
    <br><br>
    <div class="container" style="width: 800px;">
        <div class="row clearfix">
            <table class="table">
                <thead class="cart-header">
                    <tr>
                        <th scope="col" style="text-align: center;">상품명</th>
                        <th scope="col" style="text-align: right;">수량</th>
                        <th scope="col" style="text-align: right;">가격</th>
                        <th scope="col" width="20%;" style="text-align: right;">작업</th>
                    </tr>
                </thead>
                <tbody>
                	<c:if test="${empty cartList}">
                		<tr>
                			<td colspan="4" align="center">장바구니가 비어있습니다.</td>
                		</tr>
                		<c:set var="totalPrice" value="0" />
                	</c:if>
                	
                	<!-- 상품명을 누적할 변수를 추가 -->
					<c:set var="productNames" value="" scope="request"/>
					<c:set var="productPqty" value="" scope="request"/>
					
					<c:if test="${not empty cartList}">
					    <c:forEach var="cart" items="${cartList}" varStatus="status">
					        <!-- 상품 정보 표시 -->
					        <tr>
					            <td align="center">${cart.product_name}</td>
					            <td align="right">${cart.pqty}</td>
					            <td align="right">
					                <b><fmt:formatNumber pattern="###,###,###" value="${cart.price * cart.pqty}"/> ₩</b>
					            </td>
					            <td align="right">
					                <a href="delete.cart?product_name=${cart.product_name}" class="btn btn-danger btn-sm">삭제</a>
					            </td>
					        </tr>
					        
					        <!-- 상품명을 문자열로 누적 -->
					        <c:choose>
					            <c:when test="${not status.last}">
					                <!-- 마지막 요소가 아닌 경우, 상품명 뒤에 쉼표를 추가 -->
					                <c:set var="productNames" value="${productNames}${cart.product_name}, " />
					            </c:when>
					            <c:otherwise>
					                <!-- 마지막 요소인 경우, 상품명만 추가 -->
					                <c:set var="productNames" value="${productNames}${cart.product_name}" />
					            </c:otherwise>
					        </c:choose>
					        
					        <!-- 상품수를 문자열로 누적 -->
					        <c:choose>
					            <c:when test="${not status.last}">
					                <!-- 마지막 요소가 아닌 경우, 상품명 뒤에 쉼표를 추가 -->
					                <c:set var="productPqty" value="${productPqty}${cart.pqty}, " />
					            </c:when>
					            <c:otherwise>
					                <!-- 마지막 요소인 경우, 상품명만 추가 -->
					                <c:set var="productPqty" value="${productPqty}${cart.pqty}" />
					            </c:otherwise>
					        </c:choose>
					    </c:forEach>
					    <input type="hidden" id="productNamesHidden" value="<c:out value='${productNames}'/>" />
					    <input type="hidden" id="productPqtyHidden" value="<c:out value='${productPqty}'/>" />
					</c:if>
                    <!-- 상품 행 끝 -->
                    <tr class="cart-footer">
                        <td colspan="3"></td>
                        <td class="total-price">
                        	<b>총액 : <fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/> ₩</b>
                        </td>
                    </tr>
                </tbody>
            </table>
            
            <h3>주문 정보</h3>
			<table class="table" id="tb">
				<tr>
					<th class="cart-header">이름</th>
					<td>${loginInfo.name}</td>
				</tr>
				<tr>
					<th class="cart-header">이메일</th>
					<td>${loginInfo.email}</td>
				</tr>
				<tr>
					<th class="cart-header">휴대폰번호</th>
					<td>${loginInfo.phone}</td>
				</tr>
				<tr>
					<th class="cart-header">배송주소</th>
					<td>${loginInfo.address1} ${loginInfo.address2} 
						<font color="red" size="1"> &nbsp;&nbsp;*배송지 변경은 마이페이지 주소 변경 후 가능합니다.</font>
					</td>
				</tr>
				<tr>
					<th class="cart-header">배송 요청사항</th>
					<td>
						<input type="radio" name="requestOrder" value="빠른배송 해주세요.">빠른배송 해주세요.<br>
						<input type="radio" name="requestOrder" value="경비실에 맡겨주세요.">경비실에 맡겨주세요.<br>
						<input type="radio" name="requestOrder" value="문앞에 놔주세요.">문앞에 놔주세요.<br>
					</td>
				</tr>
			</table>
			
			<table class="table" id="tb">
				<tr>
					<th class="cart-header">총상품가격</th>
					<td><fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/> 원</td>
				</tr>
				<tr>
					<th class="cart-header">포인트 사용</th>
					<td>
						<input type="text" name="using_point" value="0" size="10" onkeyup="checkPoint(this, ${loginInfo.point}, ${totalPrice})" onblur="fillZero(this); updatePrice();"> 
						<font color="blue" size="2"><b>(사용 가능 포인트: ${loginInfo.point} p)</b></font>
					</td>
				</tr>
				<tr>
					<th class="cart-header">배송비</th>
					<td>0 원</td>
				</tr>
				<tr>
					<th class="cart-header">적립 포인트</th>
					<td>
						<font color="blue">${totalPoint}</font> point
					</td>
				</tr>
				<tr>
					<th class="cart-header">총결제금액</th>
					<td id="price"><fmt:formatNumber pattern="###,###,###" value="${totalPrice}"/> 원</td>
				</tr>
			</table>
            
            <div style="display: flex; justify-content: flex-end; gap: 20px;">
			    <input type="button" id="paymentButton" class="btn btn-success" style="padding-right: 10px;" value="결제하기" onclick="payment()">
			    <a href="view.product" class="btn btn-Info">쇼핑 계속하기 &raquo;</a>
			</div>
        </div>
        <hr/>
    </div>
</body>
</html>
