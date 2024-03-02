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

<script type="text/javascript" src="../../resources/js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    var form = $('form[action="view.product"]');

    // 낮은가격순 텍스트 클릭 시
    $('#low_price').click(function() {
        form.append('<input type="hidden" name="price_order" value="low">'); // hidden input 추가
        form.submit(); // form 제출
    });

    // 높은가격순 텍스트 클릭 시
    $('#high_price').click(function() {
        form.append('<input type="hidden" name="price_order" value="high">'); // hidden input 추가
        form.submit(); // form 제출
    });
});


</script>

<br>
<div class="container-fluid bg-3 text-center" style="width: 80%;">
  <span id="low_price" style="cursor: pointer;">낮은가격순</span> | 
  <span id="high_price" style="cursor: pointer;">높은가격순</span>
  
  <c:if test="${empty productList}">
	    <br><font size="5"><b>등록된 상품이 없습니다.</b></font>
  </c:if>

  <div class="row">
      <c:forEach var="product" items="${productList}" varStatus="loop">
	    <c:if test="${loop.index%4 == 0}">
	    	</div><div class="row"><hr>
	    </c:if>
	    <div class="col-sm-3" align="center">
	      <a href="detail.product?pnum=${product.pnum}&pageNumber=${productPageInfo.pageNumber}">
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