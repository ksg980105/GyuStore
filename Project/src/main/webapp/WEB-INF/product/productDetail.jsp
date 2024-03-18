<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
	
	function plusCount(pqty, price) {
	    var currentCount = parseInt(document.getElementById("pop_out").value);
	    if (currentCount < pqty) {
	        document.getElementById("pop_out").value = currentCount + 1;
	        updateTotalPrice(currentCount + 1, price);
	    } else {
	        alert('재고수량 부족!');
	    }
	}
	
	function minusCount(pqty, price) {
		  var currentCount = document.getElementById("pop_out").value;
		  if(currentCount > 1 && currentCount <= pqty) {
			  document.getElementById("pop_out").value = currentCount - 1;
	          updateTotalPrice(currentCount - 1, price);
		  }
	}
	
    // Total 가격을 업데이트하는 함수
	function updateTotalPrice(quantity, price) {
	    var totalPrice = quantity * price;
	    // 숫자를 원하는 형식으로 형식화하여 문자열로 변환
	    var formattedPrice = new Intl.NumberFormat('ko-KR').format(totalPrice);
	    // Total 가격을 출력하는 요소에 업데이트된 가격을 설정
	    document.getElementById("price").innerHTML = "<b>Total : " + formattedPrice + " 원</b>";
	}

	
	function goLogin(){
		alert('로그인 후 이용해주세요.');
	}

	//장바구니 추가
	function addToCart(pname, price) {
		if(confirm('해당 상품을 장바구니에 추가하겠습니까?')) {
			var popOut = document.getElementById('pop_out').value;
			
		    $.ajax({
	            type: "GET",
	            url: "insert.cart",
	            data: {
	                pname: pname,
	                pqty: popOut,
	                price: price
	            },
	            success: function(response) {
	                console.log(response);
	            	if (confirm('장바구니에 추가가 완료되었습니다. \n 장바구니로 이동하시겠습니까?')) {
	            	    window.location.href = "list.cart"; // 장바구니 목록 페이지로 이동
	            	}
	            },
	            error: function(error) {
	                //에러 처리
	                console.error("장바구니 추가 에러:", error);
	                alert("장바구니 추가에 실패했습니다.");
	            }
	        });
		}
	}
	
	// 주문 누르면 상품번호, 주문갯수 넘김
	function goToOrder(pnum) {
	    var popOut = document.getElementById('pop_out').value;
	    location.href = "order.product?pnum=" + pnum + "&pop_out=" + popOut;
	}
</script>

<html>
<head>
  <meta charset="UTF-8">
  <title>상품 상세 정보</title>
</head>
<body>
	<br><br>
	<div class="container" align="center">
		<div class="row">
			<div class="col-md-5">
				<img src="<%=request.getContextPath()%>/resources/productImage/${productBean.pimage}" style="width:100%; height:50%; margin-left: 100px;">
			</div>
			<div class="col-md-6">
				<h3>${productBean.pname}</h3>
				<p><b>카테고리 : </b><span class="badge badge-danger">${productBean.pcategory}<span></p>
				<p><b>출판사 : </b>${productBean.publisher}</p>
				<p><b>줄거리 : </b>${productBean.summary}</p>
				<p><b>재고 수 : </b>${productBean.pqty} 권</p>
				<p><b>포인트 : </b>${productBean.point} p</p><br>
				<p><b>수량 : </b>
					<button type="button" onclick="minusCount(${productBean.pqty}, ${productBean.price})">-</button>
			        <input type="text" name="pop_out" id="pop_out" value="1" readonly="readonly" style="text-align:center; width: 50px;"/>
			        <button type ="button" onclick="plusCount(${productBean.pqty}, ${productBean.price})">+</button>
		        </p><hr>
				<h4 id="price">
					<b>Total : <fmt:formatNumber pattern="###,###,###" value="${productBean.price}"/> 원</b>
				</h4>
				
				    <c:if test="${empty loginInfo}">
						<a href="login.member" class="btn btn-info" onclick="goLogin()">바로구매&raquo;</a>
						<a href="login.member" class="btn btn-warning" onclick="goLogin()">장바구니 담기&raquo;</a>
					</c:if>
					<c:if test="${not empty loginInfo}">
						<a href="javascript:void(0);" onclick="goToOrder(${productBean.pnum});" class="btn btn-info">바로구매&raquo;</a>
						<a href="javascript:void(0);" class="btn btn-warning" onclick="addToCart('${productBean.pname}', '${productBean.price}');">장바구니 담기&raquo;</a>
					</c:if>
					<a href="view.product?pageNumber=${pageNumber}" class="btn btn-success">상품목록&raquo;</a>
			</div>
		</div>
		<hr>
	</div>
	 
</body>
</html>