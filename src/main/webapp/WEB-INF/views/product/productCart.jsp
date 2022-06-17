<%--
  Created by IntelliJ IDEA.
  User: taeyeonlee
  Date: 2022/06/13
  Time: 11:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>장바구니</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<table class="table table-bordered" style="width: 1000px; text-align: center; margin: auto;">
    <tr>
        <th style="border: none;font-size: 30px;text-align: left;">장바구니</th>
    </tr>
</table>
<table class="table table-bordered" style="width: 1000px; text-align: center; margin: auto;">
    <tr>
        <th style="vertical-align: center"><input type="checkbox" style="vertical-align: middle" name="selectall"
                                                  onclick="selectAll(this)" checked>
        </th>
        <th>상품사진</th>
        <th>상품이름</th>
        <th>주문수량</th>
        <th>담은시간</th>
        <th>판매가</th>
        <th>총가격</th>
    </tr>
    <c:forEach items="${productList}" var="product" varStatus="status">
        <c:forEach items="${cartList}" var="cart">
            <c:if test="${product.product_Id eq cart.product_Id}">
                <tr style="vertical-align: middle;" id="${cart.cart_Id}">
                    <td><input type="checkbox" id="productSelect${status.index}" name="productSelect"
                               onclick="checkSelectAll(${status.index})" checked><input type="hidden"
                                                                                        value="${cart.cart_Id}"
                                                                                        id="cartId${status.index}"></td>
                    <td><img style="height: 100px; width: 100px;"
                             src="${pageContext.request.contextPath}/productupload/${product.productFileName}"
                             onclick="productDetail(${product.product_Id})"></td>
                    <td>${product.productName}</td>
                    <td>
                        <input type="text" value="${cart.cartProductNum}" style="width: 50px; text-align: center;"
                               onchange="priceNum(${product.productPrice},this.value,${cart.cart_Id},${status.index},${product.productQuantity})"
                               id="cartProductNumber${status.index}"
                               onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
                        <button class="btn ui-icon-plus" style="font-weight: bold; vertical-align: initial;"
                                onclick="plus(${status.index},${product.productPrice},${cart.cart_Id},${product.productQuantity})">
                            +
                        </button>
                        <button class="btn ui-icon-plus" style="font-weight: bold; vertical-align: initial;"
                                onclick="minus(${status.index},${product.productPrice},${cart.cart_Id})">-
                        </button>
                    </td>
                    <td><fmt:formatDate pattern="yyyy년MM월dd일 hh시mm분"
                                        value="${cart.cartDateTime}"></fmt:formatDate></td>
                    <td><fmt:formatNumber value="${product.productPrice}"
                                          pattern="#,### 원"/></td>
                    <td style="font-size: medium;font-weight: bold;">
                        <div style="width: 100px; contain: size;" id="productPrice${status.index}"><fmt:formatNumber
                                value="${product.productPrice*cart.cartProductNum}"
                                pattern="#,### 원"/></div>
                        <div style="text-align-last: end;"><input type="button" value="X"
                               style="border: none; background: white; font-weight: bold; vertical-align: inherit;"
                               onclick="cartDelete(${cart.cart_Id},${status.index})"></div>
                        <input type="hidden" value="${product.productPrice*cart.cartProductNum}"
                               id="productNumber${status.index}">
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </c:forEach>
</table>
<table class="table table-bordered" style="width: 1000px; text-align: center; margin: auto;">
    <tr>
        <td style="text-align: -webkit-right">
            <div style="width: 100px;text-align: -webkit-right;vertical-align: middle;font-weight: bold">총 구매가격</div>
            <c:set var="TotalPrice" value="0"></c:set>
            <c:forEach items="${productList}" var="product">
                <c:forEach items="${cartList}" var="cart">
                    <c:if test="${product.product_Id eq cart.product_Id}">
                        <c:set var="TotalPrice"
                               value="${TotalPrice+(product.productPrice*cart.cartProductNum)}"></c:set>
                    </c:if>
                </c:forEach>
            </c:forEach>
            <input type="hidden" value="${TotalPrice}" id="TotalPriceHidden">
            <div style="width: 100px;text-align: -webkit-right;vertical-align: middle;font-weight: bold"
                 id="TotalPrice">
                <fmt:formatNumber
                        value="${TotalPrice}"
                        pattern="#,### 원"/>
            </div>
        </td>
    </tr>
</table>
<table class="table table-bordered" style="width: 1000px; text-align: center; margin: auto;">
    <tr style="border: none">
        <td style="text-align:center; border: none;">
            <input type="button" class="btn btn-lg btn-outline-danger" onclick="checkSelectDelete()" value="선택삭제">
            <input type="button" class="btn btn-lg btn-outline-primary" onclick="selectOrder()" value="구매하기">
        </td>
    </tr>
</table>
<div style="display: none;">
    <form action="/product/productOrder" method="post" id="cartProductOrderForm">
        <input type="text" id="cartProductOrder" name="cart_Id[]">
    </form>
</div>
</body>
<script>
    function checkSelectAll(index) {
        const checkboxes = document.querySelectorAll('input[name="productSelect"]');
        const checked = document.querySelectorAll('input[name="productSelect"]:checked');
        const selectAll = document.querySelector('input[name="selectall"]');
        if (checkboxes.length === checked.length) {
            selectAll.checked = true;
        } else {
            selectAll.checked = false;
        }
        if ($("#productSelect" + index).is(':checked') == false) {
            let price1 = Number(document.getElementById("TotalPriceHidden").value - document.getElementById("productNumber" + index).value);
            let sub = Number(document.getElementById("TotalPriceHidden").value - document.getElementById("productNumber" + index).value);
            let len1, point1, str1;
            price1 = price1 + "";
            point1 = price1.length % 3;
            len1 = price1.length;
            str1 = price1.substring(0, point1);
            while (point1 < len1) {
                if (str1 != "") str1 += ",";
                str1 += price1.substring(point1, point1 + 3);
                point1 += 3;
            }
            str1 = str1 + ' 원';
            document.getElementById("TotalPrice").innerHTML = str1;
            document.getElementById("TotalPriceHidden").value = sub;
        } else if ($("#productSelect" + index).is(':checked') == true) {
            let price1 = Number(document.getElementById("TotalPriceHidden").value) + Number(document.getElementById("productNumber" + index).value);
            let sub = Number(document.getElementById("TotalPriceHidden").value) + Number(document.getElementById("productNumber" + index).value);
            let len1, point1, str1;
            price1 = price1 + "";
            point1 = price1.length % 3;
            len1 = price1.length;
            str1 = price1.substring(0, point1);
            while (point1 < len1) {
                if (str1 != "") str1 += ",";
                str1 += price1.substring(point1, point1 + 3);
                point1 += 3;
            }
            str1 = str1 + ' 원';
            document.getElementById("TotalPrice").innerHTML = str1;
            document.getElementById("TotalPriceHidden").value = sub;
        }
    }

    function selectAll(selectAll) {
        const checkboxes = document.getElementsByName('productSelect');
        const checkboxes1 = document.querySelectorAll('input[name="productSelect"]');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = selectAll.checked;
        });
        document.getElementById("TotalPriceHidden").value = Number(0);
        for (let i = 0; i < checkboxes1.length; i++) {
            if ($("#productSelect" + i).is(':checked') == false) {
                let price1 = Number(0);
                let sub = Number(0);
                let len1, point1, str1;
                price1 = price1 + "";
                point1 = price1.length % 3;
                len1 = price1.length;
                str1 = price1.substring(0, point1);
                while (point1 < len1) {
                    if (str1 != "") str1 += ",";
                    str1 += price1.substring(point1, point1 + 3);
                    point1 += 3;
                }
                str1 = str1 + ' 원';
                document.getElementById("TotalPrice").innerHTML = str1;
                document.getElementById("TotalPriceHidden").value = sub;
            } else if ($("#productSelect" + i).is(':checked') == true) {
                let price1 = Number(document.getElementById("TotalPriceHidden").value) + Number(document.getElementById("productNumber" + i).value);
                let sub = Number(document.getElementById("TotalPriceHidden").value) + Number(document.getElementById("productNumber" + i).value);
                let len1, point1, str1;
                price1 = price1 + "";
                point1 = price1.length % 3;
                len1 = price1.length;
                str1 = price1.substring(0, point1);
                while (point1 < len1) {
                    if (str1 != "") str1 += ",";
                    str1 += price1.substring(point1, point1 + 3);
                    point1 += 3;
                }
                str1 = str1 + ' 원';
                document.getElementById("TotalPrice").innerHTML = str1;
                document.getElementById("TotalPriceHidden").value = sub;
            }
        }
    }

    const priceNum = (productPrice, number, cart_Id, index, productQuantity) => {
        if ($("#productSelect" + index).is(':checked') == true) {
            if (number < productQuantity && number >= 1) {
                let price = (productPrice * number);
                let len, point, str;
                price = price + "";
                point = price.length % 3;
                len = price.length;
                str = price.substring(0, point);
                while (point < len) {
                    if (str != "") str += ",";
                    str += price.substring(point, point + 3);
                    point += 3;
                }
                str = str + ' 원';
                document.getElementById("productPrice" + index).innerHTML = str;
                let price1 = Number((document.getElementById("TotalPriceHidden").value) - document.getElementById("productNumber" + index).value) + ((productPrice * number));
                let sub = Number((document.getElementById("TotalPriceHidden").value) - document.getElementById("productNumber" + index).value) + ((productPrice * number));
                let len1, point1, str1;
                price1 = price1 + "";
                point1 = price1.length % 3;
                len1 = price1.length;
                str1 = price1.substring(0, point1);
                while (point1 < len1) {
                    if (str1 != "") str1 += ",";
                    str1 += price1.substring(point1, point1 + 3);
                    point1 += 3;
                }
                str1 = str1 + ' 원';
                document.getElementById("TotalPrice").innerHTML = str1;
                document.getElementById("TotalPriceHidden").value = sub;
                document.getElementById("productNumber" + index).value = (productPrice * number);
                const price2 = Number(document.getElementById("productNumber" + index).value);
                $.ajax({
                    type: "get",
                    url: "/product/cartUpdate",
                    data: {"cartProductNum": number, "cart_Id": cart_Id,"productPrice":price2},
                    dateType: "text",
                    success: function (result) {
                    },
                    error: function () {
                        alert("틀렸음.")
                    }
                });
            } else if (number >= productQuantity) {
                alert("최대" + productQuantity + "개 구매하실수 있습니다.");
                document.getElementById("cartProductNumber" + index).value = productQuantity;
            } else if (number < 1) {
                alert("최소 1개 이상 구매가 가능합니다.");
                document.getElementById("cartProductNumber" + index).value = 1;
            }
        } else {
            alert("체크 후 수량변경이 가능합니다.");
            document.getElementById("cartProductNumber" + index).value = ${cartList.get(index).cartProductNum};
        }
    }
    const plus = (index, productPrice, cart_Id, productQuantity) => {
        if ($("#productSelect" + index).is(':checked') == true) {
            let numberCheck = document.getElementById("cartProductNumber" + index).value;
            if (numberCheck < productQuantity) {
                document.getElementById("cartProductNumber" + index).value = ++document.getElementById("cartProductNumber" + index).value;
                let number = document.getElementById("cartProductNumber" + index).value;
                let subprice = productPrice * number;
                let len, point, str;
                subprice = subprice + "";
                point = subprice.length % 3;
                len = subprice.length;
                str = subprice.substring(0, point);
                while (point < len) {
                    if (str != "") str += ",";
                    str += subprice.substring(point, point + 3);
                    point += 3;
                }
                str = str + ' 원';
                document.getElementById("productPrice" + index).innerHTML = str;
                document.getElementById("productNumber" + index).value = (productPrice * number);
                number1 = document.getElementById("TotalPriceHidden").value;
                subprice = productPrice + Number(number1);
                let sub = productPrice + Number(number1);
                subprice = subprice + "";
                point = subprice.length % 3;
                len = subprice.length;
                str = subprice.substring(0, point);
                while (point < len) {
                    if (str != "") str += ",";
                    str += subprice.substring(point, point + 3);
                    point += 3;
                }
                str = str + ' 원';
                document.getElementById("TotalPrice").innerHTML = str;
                document.getElementById("TotalPriceHidden").value = sub;
                const price = Number(document.getElementById("productNumber" + index).value);
                $.ajax({
                    type: "get",
                    url: "/product/cartUpdate",
                    data: {"cartProductNum": number, "cart_Id": cart_Id,"productPrice":price},
                    dateType: "text",
                    success: function (result) {
                    },
                    error: function () {
                        alert("틀렸음.")
                    }
                });
            } else {
                alert("최대" + productQuantity + "개 구매가 가능합니다.")
            }
        } else {
            alert("체크 후 수량변경이 가능합니다.");
        }
    }
    const minus = (index, productPrice, cart_Id) => {
        if ($("#productSelect" + index).is(':checked') == true) {
            let numberCheck = document.getElementById("cartProductNumber" + index).value;
            if (numberCheck > 1) {
                document.getElementById("cartProductNumber" + index).value = --document.getElementById("cartProductNumber" + index).value;
                let number = document.getElementById("cartProductNumber" + index).value;
                let minusPrice = productPrice * number;
                let len, point, str;
                minusPrice = minusPrice + "";
                point = minusPrice.length % 3;
                len = minusPrice.length;
                str = minusPrice.substring(0, point);
                while (point < len) {
                    if (str != "") str += ",";
                    str += minusPrice.substring(point, point + 3);
                    point += 3;
                }
                str = str + ' 원';
                document.getElementById("productPrice" + index).innerHTML = str;
                document.getElementById("productNumber" + index).value = (productPrice * number);
                if ($("#productSelect" + index).is(':checked') == true) {
                    number1 = document.getElementById("TotalPriceHidden").value;
                    minusPrice = Number(number1) - productPrice;
                    let minus = Number(number1) - productPrice;
                    minusPrice = minusPrice + "";
                    point = minusPrice.length % 3;
                    len = minusPrice.length;
                    str = minusPrice.substring(0, point);
                    while (point < len) {
                        if (str != "") str += ",";
                        str += minusPrice.substring(point, point + 3);
                        point += 3;
                    }
                    str = str + ' 원';
                    document.getElementById("TotalPrice").innerHTML = str;
                    document.getElementById("TotalPriceHidden").value = minus;
                }
                const price = Number(document.getElementById("productNumber" + index).value);
                $.ajax({
                    type: "get",
                    url: "/product/cartUpdate",
                    data: {"cartProductNum": number, "cart_Id": cart_Id,"productPrice":price},
                    dateType: "text",
                    success: function (result) {
                    },
                    error: function () {
                        alert("틀렸음.")
                    }
                });
            } else {
                alert("1개보다 작을수 없습니다.")
            }
        } else {
            alert("체크 후 수량변경이 가능합니다.");
        }
    }
    const productDetail = (id) => {
        location.href = "/product/productDetail?product_Id=" + id;
    }
    const cartDelete = (id, index) => {
        let number1 = document.getElementById("TotalPriceHidden").value;
        let minusPrice = Number(number1) - Number(document.getElementById("productNumber" + index).value);
        let minus = Number(number1) - Number(document.getElementById("productNumber" + index).value);
        minusPrice = minusPrice + "";
        point = minusPrice.length % 3;
        len = minusPrice.length;
        str = minusPrice.substring(0, point);
        while (point < len) {
            if (str != "") str += ",";
            str += minusPrice.substring(point, point + 3);
            point += 3;
        }
        str = str + ' 원';
        document.getElementById("TotalPrice").innerHTML = str;
        document.getElementById("TotalPriceHidden").value = minus;
        $.ajax({
            type: "post",
            url: "/product/cartDelete",
            data: {"cart_Id": id},
            dateType: "json",
            success: function (result) {
                if (result == 1) {
                    document.getElementById(id).remove();
                }
            },
            error: function () {
                alert("틀렸음.")
            }
        });
    }
    const checkSelectDelete = () => {
        const checkboxes = document.querySelectorAll('input[name="productSelect"]');
        for (let i = 0; i < checkboxes.length; i++) {
            if ($("#productSelect" + i).is(':checked') == true) {
                let number1 = document.getElementById("TotalPriceHidden").value;
                let minusPrice = Number(number1) - Number(document.getElementById("productNumber" + i).value);
                let minus = Number(number1) - Number(document.getElementById("productNumber" + i).value);
                minusPrice = minusPrice + "";
                point = minusPrice.length % 3;
                len = minusPrice.length;
                str = minusPrice.substring(0, point);
                while (point < len) {
                    if (str != "") str += ",";
                    str += minusPrice.substring(point, point + 3);
                    point += 3;
                }
                str = str + ' 원';
                document.getElementById("TotalPrice").innerHTML = str;
                document.getElementById("TotalPriceHidden").value = minus;
                const cartId = document.getElementById("cartId" + i).value;
                $.ajax({
                    type: "post",
                    url: "/product/cartDelete",
                    data: {"cart_Id": cartId},
                    dateType: "json",
                    success: function (result) {
                        if (result == 1) {
                            document.getElementById(cartId).remove();
                        }
                    },
                    error: function () {
                        alert("틀렸음.")
                    }
                });
            }
        }
    }
    const selectOrder = () => {
        console.log("호출됨1")
        const checkboxes = document.querySelectorAll('input[name="productSelect"]');
        let cartIdList = [];
        for (let i = 0; i < checkboxes.length; i++) {
            let cartId = Number(document.getElementById("cartId" + i).value);
            if ($("#productSelect" + i).is(':checked') == true) {
                cartIdList.push(cartId);
            }
        }
        console.log(cartIdList)
        $.ajax({
            type: "get",
            url: "/product/productOrder",
            data: {"cart_Id": cartIdList},
            dataType: "text",
            success:function (result){
                if(result == "ok"){
                    console.log("호출됨")
                    document.getElementById("cartProductOrder").value = cartIdList;
                    console.log(document.getElementById("cartProductOrder").value)
                    cartProductOrderForm.submit();
                }
            },


            error: function (){
                alert("주문가능한 상품이 없습니다.")
            }
        });


    }
</script>
</html>
