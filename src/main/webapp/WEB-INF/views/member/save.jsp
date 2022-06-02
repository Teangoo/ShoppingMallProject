<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="/resources/js/jquery.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<style>
    div {
        width: 400px;
    }
</style>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="text-center container">
    <h1>*******회원가입*******</h1>
</div>
<div class="container text-center">
    <form action="/member/save" method="post" name="memberSave" enctype="multipart/form-data" class="container">
        <div class="form-floating mb-1" style="margin: auto">
            <input type="text" name="memberId" class="form-control" id="memberId" onblur="memberIdCheck()"
                   placeholder="아이디 입력">
            <label for="memberId">아이디 입력</label>
        </div>
        <span id="memberIdCheck" style="display:none"></span>
        <%--        <label id="memberIdCheck"></label>--%>

        <div class="form-floating mb-1" style="margin: auto">
            <input type="password" name="memberPassword" class="form-control" id="memberPassword"
                   onblur="passwordCheck()"
                   placeholder="비밀번호 입력">
            <label for="memberPassword">비밀번호 입력</label>
        </div>
        <label id="passwordResult"></label>

        <div class="form-floating mb-1" style="margin: auto">
            <input type="password" class="form-control" id="memberPasswordCheck" onblur="passwordResultCheck()"
                   placeholder="비밀번호 재확인">
            <label for="memberPasswordCheck">비밀번호 재확인</label>
        </div>
        <label id="passwordResult2"></label>


        <div class="form-floating mb-1" style="margin: auto">
            <input type="text" class="form-control" name="memberName" id="memberName" onblur="NameCheck()"
                   placeholder="이름">
            <label for="memberName">이름</label>
        </div>
        <label id="nameResult"></label>

        <div class="form-floating mb-1" style="margin: auto">
            <input type="text" class="form-control" name="memberMobile" id="memberMobile" onblur="MobileCheck()"
                   placeholder="전화번호">
            <label for="memberMobile">전화번호</label>
        </div>
        <label id="mobileResult"></label>
        <div class="container">
            <span style="color: darkblue"># 프로필사진 추가 #</span>
        </div>
        <div class="input-group mb-3" style="width: 400px; margin: auto">
            <input type="file" class="form-control" id="memberProfile" name="memberProfile">
        </div>

        <div style="margin: auto">
            <input type="text" class="ms-5" id="sample4_postcode" name="postcode" placeholder="우편번호">
            <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소">
            <input type="text" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번주소">
            <span id="guide" style="color:#999;display:none"></span>
            <input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소">
            <input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목">
        </div>

        <div class="btn-group mt-3" role="group" aria-label="Basic outlined example">
            <input type="button" class="btn btn-outline-primary" onclick="MemberSave()" value="회원가입">
            <input type="button" class="btn btn-outline-primary" onclick="memberReturn()" value="회원가입 취소">
        </div>
    </form>
</div>
</body>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraRoadAddr !== '') {
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if (roadAddr !== '') {
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if (data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if (data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>
    let idPass = false;
    let pwdPass = false;
    let pwdPass1 = false;
    let namePass = false;
    let mobilePass = false;

    const memberIdCheck = () => {
        const memberId = document.getElementById("memberId").value;
        const memberIdCheck = document.getElementById("memberIdCheck");
        const memberIdLength = memberId.length;
        $.ajax({
            type: "post",
            url: "/member/duplicate-check",
            data: {"memberId": memberId}, // 전송하는 파라미터
            dataType: "text", // 리턴받을 데이터 형식
            success: function (result) {
                if (memberIdLength == 0) {
                    memberIdCheck.innerHTML = "필수입력사항입니다.";
                    memberIdCheck.style.color = "red";
                    memberIdCheck.style.display = 'block';
                } else if (result == "ok") {
                    memberIdCheck.innerHTML = "사용가능한 아이디입니다.";
                    memberIdCheck.style.color = "green";
                    memberIdCheck.style.display = 'block';

                    idPass = true;
                } else {
                    memberIdCheck.innerHTML = "이미사용중인 아이디입니다.";
                    memberIdCheck.style.color = "red";
                    memberIdCheck.style.display = 'block';

                }
            },
            error: function () {
                alert("어디가 틀렸을까");
            }
        });
    }

    const passwordCheck = () => {
        const exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+-=~`]{8,10}$/;
        const passwordResult = document.getElementById("memberPassword").value;
        const pwdResult = document.getElementById("passwordResult");
        const passwordLength = passwordResult.length
        console.log(passwordResult);
        if (passwordLength === 0) {
            pwdResult.innerHTML = "필수입력사항입니다.";
            pwdResult.style.color = "red";
        } else if (!passwordResult.match(exp)) {
            pwdResult.innerHTML = "8~10이하의 비밀번호를 입력하세요.<br>대소문자/숫자/특수문자가 포함되어야합니다.";
            pwdResult.style.color = "red";
        } else {
            pwdResult.innerHTML = "사용가능한 비밀번호입니다.";
            pwdResult.style.color = "green";
            pwdPass = true;
        }
    }

    const passwordResultCheck = () => {
        const password1 = document.getElementById("memberPassword").value;
        const password2 = document.getElementById("memberPasswordCheck").value;
        const password2Length = password2.length;
        const passwordCheck = document.getElementById("passwordResult2");
        if (password2Length == 0) {
            passwordCheck.innerHTML = "비밀번호를 입력하세요!"
            passwordCheck.style.color = "red";
        } else if (password1 == password2) {
            passwordCheck.innerHTML = "비밀번호가 일치합니다."
            passwordCheck.style.color = "green";
            pwdPass1 = true;
        } else {
            passwordCheck.innerHTML = "비밀번호가 일치하지않습니다."
            passwordCheck.style.color = "red";
        }

    }

    const NameCheck = () => {
        const exp = /^[가-힣]{2,4}$/;
        const memberName = document.getElementById("memberName").value;
        const nameResult = document.getElementById("nameResult");
        const memberNameLength = memberName.length;
        if (memberNameLength === 0) {
            nameResult.innerHTML = "필수입력사항입니다.";
            nameResult.style.color = "red";
        } else if (memberName.match(exp)) {
            nameResult.innerHTML = "멋진이름이네요.";
            nameResult.style.color = "green";
            namePass = true;
        } else {
            nameResult.innerHTML = "한글만 입력가능합니다.<br>2~4자리로 입력하세요.";
            nameResult.style.color = "red";
        }
    }


    const MobileCheck = () => {
        const MobileCheck = document.getElementById("memberMobile").value;
        const MobileLength = MobileCheck.length;
        const MobileResult = document.getElementById("mobileResult");
        const exp = /^\d{3}-\d{3,4}-\d{4}$/;
        if (MobileLength == 0) {
            MobileResult.innerHTML = "필수사항입니다.";
            MobileResult.style.color = "red";
        } else if (MobileCheck.match(exp)) {
            MobileResult.innerHTML = "사용가능한 전화번호입니다.";
            MobileResult.style.color = "green";
            mobilePass = true;
        } else {
            MobileResult.innerHTML = "잘못된 형식의 전화번호입니다.<br> 000-000(0)-0000 형식으로 입력하세요."
            MobileResult.style.color = "red";
        }

    }
    const MemberSave = () => {
        if (pwdPass && pwdPass1 && namePass && mobilePass && idPass) {
            memberSave.submit();
        } else {
            alert("잘못된입력이 있어요!");
        }
    }

    const memberReturn = () => {
        location.href = "/";
    }

</script>
</html>
