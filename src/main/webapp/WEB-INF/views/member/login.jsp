력<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">
    <script src="/resources/js/jquery.js"></script>

</head>
<style>

    header {
        position: fixed;
        top: 0;
        /* width: 100% */
        left: 0;
        right: 0;
    }
    .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
    }
    html,
    body {
        height: 100%;
    }

    body {
        display: flex;
        align-items: center;
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
    }

    .form-signin {
        max-width: 330px;
        padding: 15px;
    }

    .form-signin .form-floating:focus-within {
        z-index: 2;
    }

    .form-signin input[type="text"] {
        margin-bottom: -1px;
        border-bottom-right-radius: 0;
        border-bottom-left-radius: 0;
    }

    .form-signin input[type="password"] {
        margin-bottom: 10px;
        border-top-left-radius: 0;
        border-top-right-radius: 0;
    }
</style>
<%--<body>--%>
<%--<div class="text-center container">--%>
<%--    <h1 class="container mb-3">로그인</h1>--%>
<%--</div>--%>
<%--<div class="container text-center" style="width: 400px">--%>
<%--    <form action="/member/login" method="post" name="loginResult" class="container">--%>
<%--        <div class="mb-3">--%>
<%--            <input type="text" name="memberId" class="form-control-lg" id="memberId" placeholder="아이디 입력">--%>
<%--            <input type="password" name="memberPassword" autoComplete="on" class="form-control-lg" id="memberPassword"--%>
<%--                   placeholder="비밀번호 입력">--%>
<%--        </div>--%>
<%--        <div class="btn-group" role="group" aria-label="Basic outlined example">--%>
<%--            <input type="button" class="btn btn-outline-primary" onclick="loginCheck()" value="로그인">--%>
<%--            <input type="button" class="btn btn-outline-primary" onclick="MemberSave()" value="회원가입">--%>
<%--        </div>--%>
<%--    </form>--%>
<%--</div>--%>
<%--</body>--%>
<body class="text-center">
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<main class="form-signin w-100 m-auto">
    <form action="/member/login" method="post" name="loginResult">
        <h1 class="h3 mb-3 fw-normal">로그인</h1>

        <div class="form-floating">
            <input type="text" class="form-control" id="memberId" name="memberId" placeholder="아이디 입력">
            <label for="memberId">아이디 입력</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" id="memberPassword" name="memberPassword" placeholder="비밀번호 입력">
            <label for="memberPassword">비밀번호 입력</label>
        </div>
        <div class="btn-group" role="group" aria-label="Basic outlined example">
            <input type="button" class=" w-100 btn btn-lg btn-outline-primary" onclick="loginCheck()" value="로그인">
            <input type="button" class=" w-100 btn btn-lg btn-outline-primary" onclick="MemberSave()" value="회원가입">
        </div>
<%--        <button class="w-100 btn btn-lg btn-primary" type="submit">Sign in</button>--%>
        <p class="mt-5 mb-3 text-muted">&copy; 쇼핑몰 2022</p>
    </form>
</main>
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
