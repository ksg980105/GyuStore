<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<script type="text/javascript">
	/* 장바구니에 추가하기 위한 헨들러 함수 */
	function addToCart() {
		if(confirm('해당 상품을 장바구니에 추가하겠습니까?')) {
			document.addForm.submit();
		}
		else {
			document.addForm.reset();
		}
	}
	
	function plusCount(pqty, price) {
		  var currentCount = document.getElementById("pop_out").value;
		  document.getElementById("pop_out").value = parseInt(currentCount) + 1;
		  if(currentCount < pqty) {
		    document.getElementById("pop_out").value = parseInt(currentCount) + 1;
		    document.getElementById("price").innerText = (parseInt(currentCount) + 1) * price + " 원";
		  }else{
			alert('재고수량 부족!');
			document.getElementById("pop_out").value = pqty;
		  }
	}
	
	function minusCount(pqty, price) {
		  var currentCount = document.getElementById("pop_out").value;
		  if(currentCount > 1 && currentCount <= pqty) {
			    document.getElementById("pop_out").value = parseInt(currentCount) - 1;
			    document.getElementById("price").innerText = (parseInt(currentCount) - 1) * price + " 원";
		  }
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
				<img alt="" src="<%=request.getContextPath()%>/resources/productImage/${productBean.pimage}" style="width:100%; height:50%; margin-left: 100px;">
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
		        </p>
				<h4 id="price">${productBean.price} 원</h4>
				
				<p><form name="addForm" action="./addCart.jsp?id=" method="post">
					<a href="#" class="btn btn-info">상품 주문&raquo;</a>
					<a href="./cart.jsp" class="btn btn-warning" onclick="addToCart()">장바구니&raquo;</a>
					<a href="view.product?pageNumber=${pageNumber}" class="btn btn-secondary">상품 목록&raquo;</a>
				</form>
			</div>
		</div>
		<hr>
	</div>
	 
</body>
</html>