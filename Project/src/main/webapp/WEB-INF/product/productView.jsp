<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
.product-image {
    width: auto;
    height: 130px;
    object-fit: cover;
}
</style>


<br>
<div class="container-fluid bg-3 text-center" style="width: 80%;">
  <div id="product_order_list" align="right" style="margin-bottom: 5px;">
		  <a href="low.product">낮은가격</a>&nbsp&nbsp|&nbsp&nbsp
		  <a href="high.product">높은가격</a>
  </div>
  
  <c:if test="${empty productList}">
	    <font size="5"><b>등록된 상품이 없습니다.</b></font>
  </c:if>

  <div class="row">
      <c:forEach var="product" items="${productList}" varStatus="loop">
	    <c:if test="${loop.index%4 == 0}">
	    	</div><div class="row"><hr>
	    </c:if>
	    <div class="col-sm-3" align="center">
	      <a href="detail.product?pnum=${product.pnum}">
	      	<img src="<%=request.getContextPath()%>/resources/productImage/${product.pimage}" class="img-responsive product-image">
	      </a>
	      <font size="3"><b>${product.pname}</b></font><br>
	      <font size="2"><b>${product.price} 원 </b></font>
	    </div>
	    
      </c:forEach>
    
  </div>
</div><br>

<center>
	${productPageInfo.pagingHtml}
</center>

<center>
	<form action="view.product" method="get">
		<select name="whatColumn">
			<option value="all">전체검색
			<option value="pname">제목
			<option value="pcategory">카테고리
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
	</form>
</center>