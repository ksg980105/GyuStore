<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 페이지</title>
    <link href="/assets/css/star.css" rel="stylesheet"/>
    <style>
        #myform fieldset {
            display: inline-block;
            direction: rtl;
            border: 0;
        }

        #myform fieldset legend {
            text-align: right;
        }

        #myform input[type=radio] {
            display: none;
        }

        #myform label {
            font-size: 3em;
            color: transparent;
            text-shadow: 0 0 0 #f0f0f0;
        }

        #myform label:hover {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #myform label:hover ~ label {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #myform input[type=radio]:checked ~ label {
            text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
        }

        #reviewContent {
            width: 100%;
            height: 150px;
            padding: 10px;
            box-sizing: border-box;
            border: solid 1.5px #D3D3D3;
            border-radius: 5px;
            font-size: 16px;
            resize: none;
        }
        .button-container {
        display: flex; /* Flexbox 사용 */
        justify-content: flex-end; /* 요소들을 오른쪽으로 정렬 */
	    }
	
	    button {
	        background-color: #4CAF50; /* 녹색 배경 */
	        color: white; /* 흰색 글자 */
	        padding: 14px 20px; /* 상하 좌우 패딩 */
	        margin: 8px 0; /* 상하 마진 */
	        border: none; /* 테두리 없음 */
	        border-radius: 4px; /* 모서리 둥글게 */
	        cursor: pointer; /* 마우스 오버시 커서 변경 */
	        transition: all 0.3s ease; /* 호버 효과를 위한 전환 효과 */
	    }
	
	    button:hover {
	        background-color: #45a049; /* 호버시 색상 변경 */
	        box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19); /* 호버시 그림자 효과 */
	    }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function submitReview() {
            $.ajax({
                type: "POST",
                url: "insert.review",
                data: {
                    product_number: "${pnum}",
                    user_id: "${member_id}",
                    rating: $('input[name="rating"]:checked').val(),
                    content: $('#reviewContent').val(),
                    order_id: "${order_id}"
                },
                success: function (response) {
                    alert('리뷰 등록 성공!');
                    window.opener.location.reload(); // 부모 창 새로고침
                    window.close();
                },
                error: function (xhr, status, error) {
                    alert('리뷰 등록 실패');
                }
            });
        }
    </script>
</head>
<body>
<h1>리뷰 작성 페이지</h1>

<form class="mb-3" name="myform" id="myform" method="post">
    <div>
        상품명 : ${pname}
    </div>
    <fieldset>
        <span class="text-bold">별점을 선택해주세요</span>
        <input type="radio" name="rating" value="5" id="rate1"><label
                for="rate1">★</label>
        <input type="radio" name="rating" value="4" id="rate2"><label
                for="rate2">★</label>
        <input type="radio" name="rating" value="3" id="rate3"><label
                for="rate3">★</label>
        <input type="radio" name="rating" value="2" id="rate4"><label
                for="rate4">★</label>
        <input type="radio" name="rating" value="1" id="rate5"><label
                for="rate5">★</label>
    </fieldset>
    <div>
        <textarea class="col-auto form-control" type="text" id="reviewContent" placeholder="리뷰를 남겨주세요."></textarea>
    </div>
</form>

<div class="button-container">
    <button onclick="submitReview()">리뷰 등록</button>
</div>
</body>
</html>
