<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	/* 상품평 컨테이너 스타일링 */
	.review-container {
	    max-width: 900px;
	    margin: 20px auto;
	    background-color: #f8f8f8;
	    padding: 20px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
	    border-radius: 8px;
	}
	
	/* 리뷰 박스 스타일링 */
	.review {
	    padding: 15px;
	    border-bottom: 1px solid #eee;
	    margin-bottom: 10px;
	    border-radius: 5px;
	    background-color: #f8f8f8;
	}
	
	.review:last-child {
	    border-bottom: none;
	}
	
	/* 리뷰 내용 스타일링 */
	.review h3, .review h2 {
	    color: #333;
	}
	
	.review p {
	    color: #666;
	    line-height: 1.5;
	}
	
	/* 사용자 ID 및 작성 날짜 스타일링 */
	.review h3 {
	    display: inline;
	    font-size: 1rem;
	}
	
	.review h2 {
	    display: inline;
	    font-size: 0.8rem;
	    color: #999;
	    margin-left: 10px;
	}
	
	/* 평점 스타일링 */
	.review p:last-child {
	    font-weight: bold;
	    color: #007bff;
	}
	
	/* 별 스타일 */
	.star-rating {
	    color: #ffc107; /* 노란색 */
	    font-size: 1.25rem;
	}
	
	/* 리뷰 내용에서 평점 숫자를 숨깁니다. */
	.review p.rating {
	    display: none;
	}
	

</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">

	window.addEventListener('DOMContentLoaded', (event) => {
	    document.querySelectorAll('.rating').forEach(function(ratingElem) {
	        const ratingValue = parseInt(ratingElem.textContent);
	        let stars = '';
	        for (let i = 0; i < 5; i++) {
	            if (i < ratingValue) {
	                stars += '★'; // 별 표시
	            } else {
	                stars += '☆'; // 별 표시되지 않음
	            }
	        }
	        
	        const starsSpan = document.createElement('span');
	        starsSpan.innerHTML = stars;
	        starsSpan.classList.add('star-rating');
	        ratingElem.parentNode.insertBefore(starsSpan, ratingElem.nextSibling);
	    });
	});
    
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
                <img src="<%=request.getContextPath()%>/resources/productImage/${productBean.pimage}" style="width:300px; height:300px; margin-left: 100px;">
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
                
                    <c:if test="${empty loginInfo and loginInfo.member_id ne 'admin'}">
                        <a href="login.member" class="btn btn-info" onclick="goLogin()">바로구매&raquo;</a>
                        <a href="login.member" class="btn btn-warning" onclick="goLogin()">장바구니 담기&raquo;</a>
                    </c:if>
                    <c:if test="${not empty loginInfo and loginInfo.member_id ne 'admin'}">
                        <a href="javascript:void(0);" onclick="goToOrder(${productBean.pnum});" class="btn btn-info">바로구매&raquo;</a>
                        <a href="javascript:void(0);" class="btn btn-warning" onclick="addToCart('${productBean.pname}', '${productBean.price}');">장바구니 담기&raquo;</a>
                    </c:if>
                    <c:if test="${not empty loginInfo and loginInfo.member_id ne 'admin'}">
                        <a href="view.product?pageNumber=${pageNumber}" class="btn btn-success">상품목록&raquo;</a>
                    </c:if>
            </div>
        </div>
    </div>
    <hr>
    <h3 style="padding-left: 260px;">상품평</h3>
    <div class="review-container">
	    <div class="review-list">
	        <!-- 상품평 리스트 -->
	        <c:if test="${empty reviewList}">
	        	<div class="review">
	        		<p>아직 등록된 리뷰가 없습니다.</p>
	        	</div>
	        </c:if>
	        <c:if test="${not empty reviewList}">
		        <c:forEach var="review" items="${reviewList}">
		        <div class="review">
		            <h3>${review.user_id}</h3> <h2>${review.write_date}</h2>
		            <p class="rating">${review.rating}</p>
		            <p>${review.content}</p>
		        </div>
		        </c:forEach>
	        </c:if>
	    </div>
	</div>
    <br><br><br><br>
</body>
</html>
