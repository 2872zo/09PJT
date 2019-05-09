<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- �ڽ��� �� ������ ���� ���� �˼��ְ� -->
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>���� ��� ��ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncValidationCheck(){
	var result = true;
	
	if(document.detailForm.searchCondition.value != 1 && document.detailForm.searchKeyword.value != null){
		var splitSearchKeyword = document.detailForm.searchKeyword.value.split(',');
		
		if(splitSearchKeyword.length > 2){
			alert(" ','�� �̿��Ͽ� 2���� �������� ������ �ֽʽÿ�");
		}
		for(var i = 0; i < splitSearchKeyword.length; i++){
			if(isNaN(splitSearchKeyword[i])){
				alert("���ڸ� �����մϴ�.")
				result = false;
				break;
			}
			
		}
	}
	
	return result;
}

function fncGetProductList(currentPage){
	document.detailForm.currentPage.value = currentPage;
	document.detailForm.menu.value = "${param.menu}";
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}

	document.detailForm.submit();
}

function fncSortList(currentPage, sortCode){
	document.detailForm.currentPage.value = currentPage;
	document.detailForm.menu.value = "${param.menu}";
	document.detailForm.sortCode.value = sortCode;
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}

	document.detailForm.submit();
}

function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
	document.detailForm.currentPage.value = currentPage;
	document.detailForm.menu.value = "${param.menu}";
	document.detailForm.hiddingEmptyStock.value = hiddingEmptyStock;
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}

	document.detailForm.submit();
	
}


function fncResetSearchCondition(){
	location.href = "/product/listProduct?menu=${param.menu}";
}



function fncUpdateTranCodeByProd(currentPage, prodNo){
	document.detailForm.currentPage.value = currentPage;
	document.detailForm.menu.value = "${param.menu}";
	
	//�˻� ���� Validation Check
	if(!fncValidationCheck()){
		return;
	}
	
	var URI = "/purchase/updateTranCodeByProd?page=" + currentPage + "&menu=" + "${param.menu}" + "&prodNo=" + prodNo + "&tranCode=2";
	
	if("${empty search.searchKeyword}" != "true"){
		URI += "&searchCondition=" + "${search.searchCondition}" + "&searchKeyword=" + "${search.searchKeyword}";
	}
	
	location.href = URI;
}


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct" method="post" onsubmit="return false">

<c:import url="../common/listPrinter.jsp">
	<c:param name="domainName" value="Product"/>
</c:import>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<input type="hidden" id="menu" name="menu" value=""/>
			<input type="hidden" id="sortCode" name="sortCode" value="${search.sortCode}"/>
			<input type="hidden" id="hiddingEmptyStock" name="hiddingEmptyStock" value="${search.hiddingEmptyStock}"/>
			
			<c:import url="../common/pageNavigator.jsp">
				<c:param name="domainName" value="Product"/>
			</c:import>	
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="javascript:fncSortList(${resultPage.currentPage},0)">��ǰ ��ȣ ��������</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},1)">��ǰ ��ȣ ��������</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},2)">��ǰ �̸� ��������</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},3)">��ǰ �̸� ��������</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},4)">���� ������</a>
			&nbsp;
			<a href="javascript:fncSortList(${resultPage.currentPage},5)">���� ������</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="javascript:fncHiddingEmptyStock(${resultPage.currentPage},true)">������ ��ǰ �����</a>
			&nbsp;
			<a href="javascript:fncHiddingEmptyStock(${resultPage.currentPage},false)">������ ��ǰ ����</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="javascript:fncResetSearchCondition();">�˻� ���� �ʱ�ȭ</a>
		</td>
	</tr>
</table>
</form>

</div>
</body>
</html>
