<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>환불 신청</title>
	    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
		<style>
		    body {
		        font-family: 'Noto Sans KR', sans-serif;
		        background-color: #f5f5f5;
		        margin: 0;
		        padding: 20px;
		        color: #333;
		    }
		    h2 {
		        text-align: center;
		        color: #333;
		    }
		    #refundForm {
		        background-color: #fff;
		        max-width: 500px;
		        margin: 20px auto;
		        padding: 20px;
		        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		        border-radius: 8px;
		    }
		    .form-group {
		        margin-bottom: 20px;
		    }
		    .form-label {
		        display: block;
		        margin-bottom: 10px;
		        font-weight: 700;
		    }
		    .radio-group {
		        display: flex;
		        justify-content: space-between;
		    }
		    .radio-button {
		        display: inline-block;
		        position: relative;
		        padding-left: 25px;
		        cursor: pointer;
		        font-size: 16px;
		        user-select: none;
		    }
		    .radio-button input {
		        position: absolute;
		        opacity: 0;
		        cursor: pointer;
		    }
		    .checkmark {
		        position: absolute;
		        top: 0;
		        left: 0;
		        height: 20px;
		        width: 20px;
		        background-color: #eee;
		        border-radius: 50%;
		    }
		    .radio-button:hover input ~ .checkmark {
		        background-color: #ccc;
		    }
		    .radio-button input:checked ~ .checkmark {
		        background-color: #4CAF50;
		    }
		    .checkmark:after {
		        content: "";
		        position: absolute;
		        display: none;
		    }
		    .radio-button input:checked ~ .checkmark:after {
		        display: block;
		    }
		    .radio-button .checkmark:after {
		        top: 6px;
		        left: 6px;
		        width: 8px;
		        height: 8px;
		        border-radius: 50%;
		        background: white;
		    }
		    #refundForm input[type="button"] {
		        width: 100%;
		        padding: 12px;
		        background-color: #4CAF50;
		        color: white;
		        border: none;
		        border-radius: 4px;
		        cursor: pointer;
		        font-size: 16px;
		    }
		    #refundForm input[type="button"]:hover {
		        background-color: #45a049;
		    }
		</style>
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <script>
	    function submitRefundForm() {
	    	// 환불 사유가 선택되었는지 확인
	        var reasonValue = $("input[name='reason']:checked").val();
	        if (!reasonValue) {
	            alert("환불 사유를 선택해주세요.");
	            return;
	        }
	    	
	    	var formData = {
	    		order_id: $("#order_id").text(),
    	        member_id: $("#member_id").text(),
    	        pname: $("#productName").text(),
    	        pop_out: $("#productQuantity").text(),
    	        reason: $("input[name='reason']:checked").val()
	    	};
	
	        $.ajax({
	            type: "POST",
	            url: "refund.member", // 서버의 환불 처리 컨트롤러 경로
	            data: formData,
	            success: function(response) {
	                alert("환불 신청이 접수되었습니다.");
	                window.close(); // 환불 신청이 성공적으로 완료되면 창을 닫음
	            },
	            error: function() {
	                alert("환불 신청 중 문제가 발생했습니다.");
	            }
	        });
	    }
	    
	    </script>
	</head>
	<body>
	    <h2>환불 신청</h2>
		<form id="refundForm">
			<div class="form-group">
		        <span class="form-label">주문 번호:</span> 
		        <span id="order_id">${orderBean.order_id}</span>
		    </div>
			<div class="form-group">
		        <span class="form-label">신청자:</span> 
		        <span id="member_id">${orderBean.name}</span>
		    </div>
		    <div class="form-group">
		        <span class="form-label">환불 상품:</span>
		        <span id="productName">${orderBean.pname}</span>, <span id="productQuantity">${orderBean.pop_out}</span>
		    </div>
		    <div class="form-group">
		        <span class="form-label">환불 사유:</span>
		        <div class="radio-group">
		            <label class="radio-button">단순 변심
		                <input type="radio" name="reason" value="단순 변심">
		                <span class="checkmark"></span>
		            </label>
		            <label class="radio-button">상품에 이상이 있음
		                <input type="radio" name="reason" value="상품에 이상이 있음">
		                <span class="checkmark"></span>
		            </label>
		            <label class="radio-button">다른상품으로 구매
		                <input type="radio" name="reason" value="다른상품으로 구매">
		                <span class="checkmark"></span>
		            </label>
		        </div>
		    </div><br>
		    <input type="button" value="환불 신청" onClick="submitRefundForm()">
         </form>
	</body>
</html>
