<%--
  Created by IntelliJ IDEA.
  User: taeyeonlee
  Date: 2022/05/30
  Time: 2:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>

<head>
    <title>쇼핑몰</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/album/">
</head>
<style>
    .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
    }

    .bi {
        vertical-align: -.125em;
        fill: currentColor;
    }

</style>

<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>

<div class="album py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="input-group" style="display: inline;width: auto;margin-left: 280px">
                <select class="form-select form-select-lg"
                        style="display: inline; width: 150px; font-size: inherit;height: 50px;"
                        aria-expanded="false" id="categoryType">
                    <option value="">전체 검색</option>
                    <c:forEach items="${categoryList}" var="categorySearchList">
                        <c:if test="${category.categoryName eq categorySearchList.categoryName}">
                            <option value="${categorySearchList.category_Id}" selected>${categorySearchList.categoryName}</option>
                        </c:if>
                        <c:if test="${category.categoryName ne categorySearchList.categoryName}">
                        <option value="${categorySearchList.category_Id}">${categorySearchList.categoryName}</option>
                        </c:if>
                    </c:forEach>
                </select>

                <input type="text" class="form-control"
                       style="display: inline; width: 500px; height: 50px; text-align: center; opacity: 0.7; color: grey;"
                       aria-label="Text input with dropdown button" placeholder="어떤상품을 찾으시나요?" id="q" onkeyup="enterkey()">
            </div>
            <button style="height: 47px; width:50px; border: none; margin-left: -64px; z-index: 1; margin-top: 2px;"
                    type="button" class="btn btn-outline-secondary" onclick="searchproduct()">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
                     viewBox="0 0 16 16">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                </svg>
            </button>

            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example"
                    style="width: 150px; margin-right: 15px; margin-left: auto; text-align: center;display: inline;"
                    name="selectNum"
                    id="selectNum"
                    onchange="productSelect()">
                <c:if test="${selectNum eq '10'}">
                    <option selected>10개씩 보기</option>
                    <option value="20">20개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="40">40개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </c:if>
                <c:if test="${selectNum eq '20'}">
                    <option value="10">10개씩 보기</option>
                    <option selected>20개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="40">40개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </c:if>
                <c:if test="${selectNum eq '30'}">
                    <option value="10">10개씩 보기</option>
                    <option value="20">20개씩 보기</option>
                    <option selected>30개씩 보기</option>
                    <option value="40">40개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </c:if>
                <c:if test="${selectNum eq '40'}">
                    <option value="10">10개씩 보기</option>
                    <option value="20">20개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option selected>40개씩 보기</option>
                    <option value="50">50개씩 보기</option>
                </c:if>
                <c:if test="${selectNum eq '50'}">
                    <option value="10">10개씩 보기</option>
                    <option value="20">20개씩 보기</option>
                    <option value="30">30개씩 보기</option>
                    <option value="40">40개씩 보기</option>
                    <option selected>50개씩 보기</option>
                </c:if>
            </select>
        </div>
    </div>
</div>
<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
    <c:forEach items="${productList}" var="product">
        <div class="col">
            <div class="card shadow-sm">
                <img class="bd-placeholder-img card-img-top" width="100%" height="225"
                     src="${pageContext.request.contextPath}/productupload/${product.productFileName}"
                     role="img" aria-label="Placeholder: Thumbnail"
                     preserveAspectRatio="xMidYMid slice" focusable="false">
                <title>Placeholder</title>
                <rect width="100%" height="100%" fill="#55595c"/>
                <div style="text-align: center">
                    <text x="50%" y="50%" fill="#eceeef" dy=".3em">상품명 : ${product.productName}</text>
                </div>
                </img>
                <div class="card-body">
                    <p class="card-text" style="text-align: end">가격 : <fmt:formatNumber
                            value="${product.productPrice}" pattern="#,### 원"/></p>

                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <button type="button" onclick="productDetail(${product.product_Id})"
                                    class="btn btn-sm btn-outline-secondary">상세보기
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">장바구니담기</button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">구매</button>
                        </div>
                        <small class="text-muted">남은수량 :${product.productQuantity}개</small>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<div class="container">
    <ul class="pagination justify-content-center">

        <c:choose>
        <c:when test="${paging.page<=1}">
        <li class="page-item disabled">
            <a class="page-link">[이전]</a>
        </li>
        </c:when>

        <c:otherwise>
        <li class="page-item">
            <a class="page-link" href="/product/list?page=${paging.page-1}&selectNum=${selectNum}&category_Id=${category.category_Id}">[이전]</a>
        </li>
        </c:otherwise>

        </c:choose>

        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
        <c:choose>
        <c:when test="${i eq paging.page}">
        <li class="page-item active">
            <a class="page-link">${i}</a>
        </li>
        </c:when>

        <c:otherwise>
        <li class="page-item">
            <a class="page-link" href="/product/list?page=${i}&selectNum=${selectNum}&category_Id=${category.category_Id}">${i}</a>
        </li>
        </c:otherwise>

        </c:choose>
        </c:forEach>

        <c:choose>
        <c:when test="${paging.page>=paging.maxPage}">
        <li class="page-item disabled">
            <a class="page-link">[다음]</a>
        </li>
        </c:when>

        <c:otherwise>
        <li class="page-item">
            <a class="page-link" href="/product/list?page=${paging.page+1}&selectNum=${selectNum}&category_Id=${category.category_Id}">[다음]</a>
        </li>
        </c:otherwise>

        </c:choose>

</div>
</body>
<script>

    const productSelect = () => {
        const selectNum = document.getElementById("selectNum").value;
        location.href = "/product/list?category_Id=${category.category_Id}"+"&selectNum=" + selectNum;
    }

    const productDetail = (product_Id) => {
        location.href = "/product/productDetail?product_Id=" + product_Id;
    }

    const searchproduct = () => {
        const categoryType = document.getElementById("categoryType").value;
        const q = document.getElementById("q").value;
        location.href = "/product/search?c_id="+categoryType+"&q="+q;
    }

    function enterkey(){
        if (window.event.keyCode == 13){
            searchproduct();
        }
    }
</script>
</html>
