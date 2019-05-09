<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetPurchaseList(currentPage) {
		document.detailForm.currentPage.value = currentPage;
		document.detailForm.menu.value =  "${param.menu}";
		
		document.detailForm.submit();
	}
	
	function fncUpdatePurchaseCode(currentPage,tranNo,tranCode){		
		var URI = "/purchase/updateTranCode?page="+currentPage+"&tranNo="+tranNo+"&tranCode="+tranCode;
		
		console.log(URI);
		
		location.href = URI;
	}
	
	function fncSortList(currentPage, sortCode){
		document.detailForm.currentPage.value = currentPage;
		document.detailForm.menu.value = "${param.menu}";
		document.detailForm.sortCode.value = sortCode;

		document.detailForm.submit();
	}

	function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
		document.detailForm.currentPage.value = currentPage;
		document.detailForm.hiddingEmptyStock.value = hiddingEmptyStock;

		document.detailForm.submit();
		
	}


	function fncResetSearchCondition(){
		location.href = "/purchase/listPurchase";
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<%-- list��� �κ� --%>
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
			<a href="javascript:fncSortList(${resultPage.currentPage},4)">���� ��ҵ� ��ǰ</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},1)">��� �غ����� ��ǰ</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},2)">������� ��ǰ</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},3)">�ŷ� �Ϸ�� ��ǰ</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="javascript:fncHiddingEmptyStock(${resultPage.currentPage},true)">�ŷ����� ��ǰ�� ����</a>
			&nbsp;
			<a href="javascript:fncHiddingEmptyStock(${resultPage.currentPage},false)">��� ��ǰ ����</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="javascript:fncResetSearchCondition();">�˻� ���� �ʱ�ȭ</a>
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>