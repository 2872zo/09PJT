<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function(){
		var tranNoList = [${tranNoList}];
		var prodNoList = [${prodNoList}];
		
		$("tr.ct_list_pop td:nth-child(5)").css("color","red");
		$("tr.ct_list_pop td:nth-child(5)").on("click",function(){
			location.href = "/product/getProduct?prodNo="+prodNoList[$($("td",$(this).parent())[0]).text()-1];
		});	
		
		$("tr.ct_list_pop td:nth-child(1)").css("color","red");
		$("tr.ct_list_pop td:nth-child(1)").on("click",function(){
			location.href = "/purchase/getPurchase?tranNo="+tranNoList[$(this).text()-1];
		});	
		
		$("a:contains('배송출발')").on("click",function(){
			fncUpdatePurchaseCode(${resultPage.currentPage},tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 2);
		});
		$("a:contains('수취확인')").on("click",function(){
			fncUpdatePurchaseCode(${resultPage.currentPage},tranNoList[$($("td",$(this).parent().parent())[0]).text()-1], 3)
		});
		
		$(".sort").on("click",function(){
			fncSortList(${resultPage.currentPage},$(".sort").index($(this)));
		});
		
		$("select[name=pageSize]").on("change",function(){
			fncGetList(${resultPage.currentPage});
		});
		
		$("#reset").on("click",function(){
			fncResetSearchCondition();
		});
		
		$("#unHidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},false);
		});
		$("#hidding").on("click",function(){
			fncHiddingEmptyStock(${resultPage.currentPage},true);
		});
		
		$("#prePage").on("click",function(){
			fncGetList(${resultPage.beginUnitPage-1});
		});
		$(".page").on("click",function(){
			fncGetList($(this).text());
		});
		$("#nextPage").on("click",function(){
			fncGetList(${resultPage.endUnitPage+1});
		});
	});
	
	function fncGetList(currentPage){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");

		$("form[name=detailForm]").submit();
	}
	
	function fncUpdatePurchaseCode(currentPage,tranNo,tranCode){		
		var URI = "/purchase/updateTranCode?page="+currentPage+"&tranNo="+tranNo+"&tranCode="+tranCode;
		
		console.log(URI);
		
		location.href = URI;
	}

	function fncSortList(currentPage, sortCode){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=menu]").val("${param.menu}");
		$("input[name=sortCode]").val(sortCode);

		$("form").submit();
	}

	function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
		$("input[name=currentPage]").val(currentPage);
		$("input[name=hiddingEmptyStock]").val(hiddingEmptyStock);

		$("form").submit();
	}

	function fncResetSearchCondition(){
		location.href = "/purchase/listPurchase";
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<%-- list출력 부분 --%>
<c:import url="../common/listPrinter.jsp">
	<c:param name="domainName" value="Purchase"/>
</c:import>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		 <input type="hidden" id="menu" name="menu" value=""/>
		 <input type="hidden" id="sortCode" name="sortCode" value="${search.sortCode}"/>
		 <input type="hidden" id="hiddingEmptyStock" name="hiddingEmptyStock" value="${search.hiddingEmptyStock}"/>
		
		 <c:import url="../common/pageNavigator.jsp">
			<c:param name="domainName" value="Purchase"/>
		</c:import>	
			
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" class="sort"></a>
			<a class="sort">배송 준비중인 상품</a>
			&nbsp;
			<a  class="sort">배송중인 상품</a>
			&nbsp;
			<a  class="sort">거래 완료된 상품</a>
			&nbsp;
			<a  class="sort">구매 취소된 상품</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a  id="hidding">거래중인 상품만 보기</a>
			&nbsp;
			<a  id="unHidding">모든 상품 보기</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a  id="reset">검색 조건 초기화</a>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>