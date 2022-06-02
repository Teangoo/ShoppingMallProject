<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="/resources/js/jquery.js"></script>

</head>

<style>
    div {
        width: 400px;
    }
</style>

<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<h1 class="container mb-3">로그인</h1>
<form action="/member/login" method="post" name="loginResult" class="container">
    <div class="mb-3">
        <input type="text" name="memberId" class="form-control-lg" id="memberId" placeholder="아이디 입력">
        <input type="password" name="memberPassword" autoComplete="on" class="form-control-lg" id="memberPassword"
               placeholder="비밀번호 입력">
    </div>
    <div class="btn-group" role="group" aria-label="Basic outlined example">
        <input type="button" class="btn btn-outline-primary" onclick="loginCheck()" value="로그인">
        <input type="button" class="btn btn-outline-primary" onclick="MemberSave()" value="회원가입">
    </div>
</form>
</body>
<script>
    const MemberSave = () => {
        location.href = "/member/save";
    }

    const loginCheck = () => {
        const memberId = document.getElementById("memberId").value;
        const memberPassword = document.getElementById("memberPassword").value;
        const memberIdLength = memberId.length;
        const memberPwdLength = memberPassword.length;
        $.ajax({
            type: "post",
            url: "/member/loginCheck",
            data: {"memberId": memberId, "memberPassword": memberPassword}, // 전송하는 파라미터
            dataType: "text", // 리턴받을 데이터 형식
            success: function (result) {
                if (memberIdLength == 0) {
                alert("아이디를 입력하세요!");
                } else if (memberPwdLength == 0) {
                    alert("비밀번호를 입력하세요!");
                } else if (result == "ok") {
                    loginResult.submit();
                } else if (result == "no") {
                    alert("아이디 또는 비밀번호가 틀립니다.")
                }
            },
            error: function () {
                alert("어디가 틀렸을까");
            }
        });
    }
</script>

</html>
