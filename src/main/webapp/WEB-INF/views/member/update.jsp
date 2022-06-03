<%--
  Created by IntelliJ IDEA.
  User: taeyeonlee
  Date: 2022/06/03
  Time: 10:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="/resources/js/jquery.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<style>
    header {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
    }
    body {
        display: flex;
        /*align-items: center;*/
        padding-top: 100px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
    }
</style>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>

<div class="container text-center">
        <h1>*******회원정보 수정*******</h1>
    <form action="/member/update" class="container" method="post"  style="width: 400px" name="updateResult" enctype="multipart/form-data">
        <div class="mt-0 mb-0">
            <input type="hidden" value="${updateMember.id}" class="form-control" name="id" id="memberNum" readonly><br>
        </div>
        <div class="mt-1">
            <label for="memberId" class="form-label">아이디</label><br>
            <input type="text" value="${updateMember.memberId}" class="form-control" name="memberId" id="memberId"
                   readonly><br>
        </div>
        <div class="mt-1">
            <label for="memberPwd" class="form-label">비밀번호</label><br>
            <input type="password" class="form-control" name="memberPassword" id="memberPwd"><br>
        </div>
        <div class="mt-1">
            <label for="memberName" class="form-label">이름</label><br>
            <input type="text" value="${updateMember.memberName}" class="form-control" name="memberName" id="memberName"
                   readonly><br>
        </div>
        <div class="mt-1">
            <label for="memberMobile" class="form-label">전화번호</label><br>
            <input type="text" value="${updateMember.memberMobile}" class="form-control" name="memberMobile"
                   id="memberMobile"><br>
        </div>

        <div class="mt-1">
            <label class="form-label">프로필사진</label><br>
            <img src="${pageContext.request.contextPath}/upload/${updateMember.memberProfileName}" alt="" height="200"
                 width="200"><br>
        </div>

        <div class="input-group mb-3" style="width: 400px;">
            <input type="file" class="form-control" id="memberProfile" name="memberProfile">
        </div>

        <div style="margin: auto">
            <input type="text" class="ms-5" id="sample4_postcode" name="postcode" value="${updateMember.postcode}" placeholder="우편번호">
            <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
            <input type="text" id="sample4_roadAddress" name="roadAddress" value="${updateMember.roadAddress}" placeholder="도로명주소">
            <input type="text" id="sample4_jibunAddress" name="jibunAddress" value="${updateMember.jibunAddress}" placeholder="지번주소">
            <span id="guide" style="color:#999;display:none"></span>
            <input type="text" id="sample4_detailAddress" name="detailAddress" value="${updateMember.detailAddress}" placeholder="상세주소">
            <input type="text" id="sample4_extraAddress" name="extraAddress" value="${updateMember.extraAddress}" placeholder="참고항목">
        </div>

        <div class="btn-group mt-3" role="group" aria-label="Basic outlined example">
            <input type="button" class="btn btn-lg btn-outline-primary" onclick="update()" value="회원수정">
            <input type="button" class="btn btn-lg btn-outline-primary" onclick="memberDelete()" value="회원탈퇴">
            <input type="button" class="btn btn-lg btn-outline-primary" onclick="index()" value="돌아가기">
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
    const memberDelete = () => {
        Swal.fire({
            title: '회원을 정말 탈퇴 하실건가요?',
            text: "탈퇴를 하시면 되돌릴수 없습니다.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '회원탈퇴',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result) {
                Swal.fire('Deleted!',
                    '회원이 탈퇴되엇습니다.',
                    'success',{
                    closeOnClickOutside: false,
                        closeOnEsc: false,
                        button : {
                        confirm : {
                            text : '확인',
                            value : true
                        }
                        }
                    }).then((result) => {
                        if(result){
                            location.href="/member/delete?id=${updateMember.id}";
                        }
                })

            }
        })


    }
    const update = () => {
        const password = document.getElementById("memberPwd").value;
        const passwordFocus = document.getElementById("memberPwd") ;
        const pwDB = '${updateMember.memberPassword}';
        if (pwDB == password) {
            updateResult.submit();
            passwordFocus.focus();
        } else {
            alert("비밀번호가 일치하지않아요!");
            const passwordNo = document.getElementById("memberPwd");
            passwordNo.focus();
        }
    }

    const index = () => {
        location.href = "/index";
    }
</script>
</html>
