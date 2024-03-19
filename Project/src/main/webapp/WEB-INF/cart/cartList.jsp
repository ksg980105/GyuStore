<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css">
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
                	<c:if test="${not empty cartList}">
                		<c:set var="totalPrice" value="0"/>
						<c:forEach var="cart" items="${cartList}">
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
	                    <c:set var="totalPrice" value="${totalPrice + (cart.price * cart.pqty)}" />
	                    </c:forEach>
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
						<input type="text" name="using_point" value="0" size="10" onkeyup="checkPoint(this, ${loginInfo.point}, ${productBean.price * pop_out})" onblur="fillZero(this); updatePrice();"> 
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
					<td id="price">${productBean.price * pop_out} 원</td>
				</tr>
			</table>
            
            <div style="display: flex; justify-content: flex-end; gap: 20px;">
			    <a href="#" class="btn btn-success" style="padding-right: 10px;">결제하기</a>
			    <a href="view.product" class="btn btn-Info">쇼핑 계속하기 &raquo;</a>
			</div>
        </div>
        <hr/>
    </div>
    
</body>
</html>
