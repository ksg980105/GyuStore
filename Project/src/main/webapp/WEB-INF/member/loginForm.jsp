<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

<style>
	.mybutton {
        background-color: gray; /* 버튼 배경색 */
        color: white;
        border: none;
        padding: 5px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-top: 3px;
        cursor: pointer;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    }
</style>

<script type="text/javascript">
	function loginCheck(){
		if(f.member_id.value == ""){
			alert('아이디를 입력하세요.');
			return false;
		}
		if(f.password.value == ""){
			alert('비밀번호를 입력하세요.');
			return false;
		}
	}
</script>

<div class="background-overlay"></div>
<div class="container" align="center">
  <h2>로그인</h2>
  <br>
  <form name="f" action="login.member" method="post" onsubmit="return loginCheck()">
    <div class="form-group">
      <label for="member_id">ID</label>
      <input type="text" class="form-control" style="width:200px;" placeholder="Enter id" name="member_id">
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" class="form-control" style="width:200px;" placeholder="Enter password" name="password">
    </div>
    <button type="submit" style="width:200px;" class="mybutton">로그인</button><br><br>
    <input type="button" value="회원 가입" style="width:200px;" class="mybutton" onClick="location.href='register.member'"><br><br>
    <input type="button" value="아이디찾기" style="width:200px;" class="mybutton" onClick="location.href='findId.member'"><br><br>
    <input type="button" value="비밀번호찾기" style="width:200px;" class="mybutton" onClick="location.href='findPw.member'">
  </form>
</div>