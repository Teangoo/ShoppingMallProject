<%--
  Created by IntelliJ IDEA.
  User: taeyeonlee
  Date: 2022/06/03
  Time: 3:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="/resources/js/jquery.js"></script>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container text-center mb-3" style="margin: auto;">
    <div class="btn-group mt-3" role="group" aria-label="Basic outlined example">
        <input type="button" class="btn btn-outline-primary" id="memberList" value="회원리스트">
        <input type="button" class="btn btn-outline-primary" onclick="productSave()" value="상품등록">
        <input type="button" class="btn btn-outline-primary" onclick="categorySave()" id="categorysave" value="카테고리등록">
        <input type="button" class="btn btn-outline-primary" onclick="orderList()" id="orderList" value="구매리스트">
    </div>
</div>
<div style="display: none;" id="category-write" class="adminArea input-group mb-3">
    <div class="form-floating">
        <input type="text" id="categoryName" class="form-control" placeholder="카테고리이름" onkeyup="enterkey()">
        <label for="categoryName">카테고리이름</label>
        <button id="category-save-btn" onclick="categorySaveClick()"  class="btn btn-lg btn-primary mt-2" style="display: inline-block">추가</button>
    </div>
</div>
<div style="display: none; text-align: center;" id="productList">
    <form action="/product/productSave" method="post" name="Save" enctype="multipart/form-data">
        <div id="productCategoryList"></div>
        <label for="productName">상품이름</label>
        <div class="form-floating">
            <input type="text" name="productName" id="productName" placeholder="상품이름 입력">
        </div>
        <label for="productPrice">상품 가격</label>
        <div class="form-floating">
            <input type="text" name="productPrice" id="productPrice" placeholder="상품가격">원
        </div>
        <label for="productQuantity">수량</label>
        <div class="form-floating">
            <input type="text" name="productQuantity" id="productQuantity" placeholder="수량">개
        </div>
        <label>상품사진</label>
        <div class="input-group mb-3" style="width: 400px; margin: auto">
            <input type="file" class="form-control" name="productFile" id="productFile">
        </div>
        <input type="submit" class="btn btn-lg btn-primary mt-2" style="display: inline-block" value="상품등록">

    </form>

</div>

<div class="adminArea" id="member-list"></div>
</body>
<script>

    const productSave = () => {
        document.getElementById("productList").style.display = "block";
        $('#category-write').hide();
        $('.adminArea').hide();
        $.ajax({
            type: "get",
            url: "/admin/categoryList",
            dateType: "json",
            success: function (result) {
                let output = "<select name='category_Id'>";
                for (let i in result) {
                    output += "<option value=" + result[i].category_Id + ">" + result[i].categoryName + "</option>";
                }
                output += "</select>";
                document.getElementById('productCategoryList').innerHTML = output;
            }

        });
    }

    const categorySave = () => {
        $('#productList').hide();
        const btn = document.getElementById("category-write");
        btn.style.display = "block";
        btn.style.width = "400px";
        btn.style.textAlign = "center";
        btn.style.margin = "auto";
        $.ajax({
            type: "get",
            url: "/admin/categoryList",
            dateType: "json",
            success: function (result) {
                let output = "<table class='table table-bordered' style='width: 600px; margin: auto; text-align: center' >";
                output += "<tr><th style='width: 104px'>카테고리 번호</th>";
                output += "<th>카테고리 이름</th>";
                output += "<th>삭제</th></tr>";
                for (let i in result) {
                    output += "<tr id=" + result[i].category_Id + " class='memberRow'>";
                    output += "<td>" + result[i].category_Id + "</td>";
                    output += "<td>" + result[i].categoryName + "</td>";
                    output += "<td>" + "<a type='button' class='btn btn-outline-primary' onclick='deleteCG(" + result[i].category_Id + ");'>" + "삭제" + "</a>" + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('member-list').innerHTML = output;
                const btn = document.getElementById("member-list");
                btn.style.display = "block";

            },
            error: function () {
                alert("어디가 틀렸을까?");
            }
        });
    }
    function enterkey(){
        if (window.event.keyCode == 13){
            categorySaveClick();
        }
    }
    const categorySaveClick = () => {
        const categoryName = document.getElementById("categoryName").value;
        $.ajax({
            type: "post",
            url: "/admin/categorySave",
            data: {"categoryName": categoryName},
            dateType: "json",
            success: function (result) {
                let output = "<table class='table table-bordered' style='width: 600px; margin: auto'>";
                output += "<tr><th>카테고리 번호</th>";
                output += "<th>카테고리 이름</th>";
                output += "<th>삭제</th></tr>";
                for (let i in result) {
                    output += "<tr id=" + result[i].category_Id + " class='memberRow'>";
                    output += "<td>" + result[i].category_Id + "</td>";
                    output += "<td>" + result[i].categoryName + "</td>";
                    output += "<td>" + "<a type='button' class='btn btn-outline-primary' onclick='deleteCG(" + result[i].category_Id + ");'>" + "삭제" + "</a>" + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('member-list').innerHTML = output;
                document.getElementById("categoryName").value = '';

            }
        });
    }
    // $("#category-save-btn").click(function () {
    //     const categoryName = document.getElementById("categoryName").value;
    //     $.ajax({
    //         type: "post",
    //         url: "/admin/categorySave",
    //         data: {"categoryName": categoryName},
    //         dateType: "json",
    //         success: function (result) {
    //             let output = "<table class='table table-bordered' style='width: 600px; margin: auto'>";
    //             output += "<tr><th>카테고리 번호</th>";
    //             output += "<th>카테고리 이름</th>";
    //             output += "<th>삭제</th></tr>";
    //             for (let i in result) {
    //                 output += "<tr id=" + result[i].category_Id + " class='memberRow'>";
    //                 output += "<td>" + result[i].category_Id + "</td>";
    //                 output += "<td>" + result[i].categoryName + "</td>";
    //                 output += "<td>" + "<a type='button' class='btn btn-outline-primary' onclick='deleteCG(" + result[i].category_Id + ");'>" + "삭제" + "</a>" + "</td>";
    //                 output += "</tr>";
    //             }
    //             output += "</table>";
    //             document.getElementById('member-list').innerHTML = output;
    //             document.getElementById("categoryName").value = '';
    //
    //         }
    //     });
    // });
    const deleteCG = (category_id) => {
        if (confirm("정말삭제하실건가요?")) {
            $.ajax({
                type: "post", // http request method
                url: "/admin/CGDelete", // 요청주소(컨트롤러 주소값)
                data: {category_id: category_id}, // 전송하는 파라미터
                dataType: "json", // 리턴받을 데이터 형식
                success: function (result) {
                    if (result == 1) {
                        document.getElementById(category_id).remove();
                    }
                }
            });
        }
    }
    $("#memberList").click(function () {
        $('#productList').hide();
        $.ajax({
            type: "get", // http request method
            url: "/admin/memberList", // 요청주소(컨트롤러 주소값)
            dataType: "json", // 리턴받을 데이터 형식
            success: function (result) {
                let output = "<table class='table table-bordered'>";
                output += "<tr><th>회원번호</th>";
                output += "<th>회원 아이디</th>";
                output += "<th>회원 이름</th>";
                output += "<th>회원 전화번호</th>";
                output += "<th>회원 주소</th>";
                output += "<th>삭제</th></tr>";
                for (let i in result) {
                    output += "<tr id=" + result[i].id + " class='memberRow'>";
                    output += "<td>" + result[i].id + "</td>";
                    output += "<td>" + result[i].memberId + "</td>";
                    output += "<td>" + result[i].memberName + "</td>";
                    output += "<td>" + result[i].memberMobile + "</td>";
                    output += "<td>" + result[i].postcode + result[i].roadAddress + result[i].detailAddress + result[i].extraAddress + "</td>";
                    output += "<td>" + "<a type='button' class='btn btn-outline-primary' onclick='deleteASD(" + result[i].id + ");'>" + "삭제" + "</a>" + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                const btn = document.getElementById("member-list");
                $('.adminArea').hide();
                document.getElementById('member-list').innerHTML = output;
                btn.style.display = "block";
            },
            error: function () {
                alert("어디가 틀렸을까");
            }
        });
    });
    const deleteASD = (id) => {
        if (confirm("정말삭제하실건가요?")) {
            $.ajax({
                type: "post", // http request method
                url: "/admin/delete", // 요청주소(컨트롤러 주소값)
                data: {id: id}, // 전송하는 파라미터
                dataType: "json", // 리턴받을 데이터 형식
                success: function (result) {
                    if (result == 1) {
                        document.getElementById(id).remove();
                    }
                }
            });
        }
    }
</script>
</html>
