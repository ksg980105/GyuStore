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
    $('#low_price').click(function () {
        updatePriceOrder('low');
    });

    // 높은가격순 텍스트 클릭 시
    $('#high_price').click(function () {
        updatePriceOrder('high');
    });

    function updatePriceOrder(order) {
        var isSearch = $('select[name="whatColumn"]').val() !== 'all' || $('input[name="keyword"]').val() !== '';

        if (isSearch) {
            // 현재 검색 중인 경우에만 추가
            $('input[name="price_order"]').remove(); // 기존 input 삭제
            form.append('<input type="hidden" name="price_order" value="' + order + '">'); // 새로운 input 추가
        } else {
            // 현재 검색 중이 아닌 경우에는 URL의 'price_order' 파라미터만 변경
            var currentUrl = window.location.href;
            var urlParts = currentUrl.split('?');

            if (urlParts.length > 1) {
                // URL에 파라미터가 있을 경우
                var params = urlParts[1].split('&');

                for (var i = 0; i < params.length; i++) {
                    if (params[i].startsWith('price_order=')) {
                        params.splice(i, 1); // 기존 'price_order' 파라미터 삭제
                        break;
                    }
                }

                params.push('price_order=' + order); // 새로운 'price_order' 파라미터 추가
                window.location.href = urlParts[0] + '?' + params.join('&');
            } else {
                // URL에 파라미터가 없을 경우
                window.location.href = currentUrl + '?price_order=' + order;
            }

            return;
        }

        form.submit(); // form 제출
    }
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