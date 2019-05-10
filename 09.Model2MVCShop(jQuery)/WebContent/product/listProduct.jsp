<%@ page language="java"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 자신이 산 물건은 현재 상태 알수있게 -->
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>구매 목록 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
$(function(){
	var prodNoList = [${prodNoList}];
	
	$("tr.ct_list_pop td:nth-child(3)").css("color","red");
	$("tr.ct_list_pop td:nth-child(3)").on("click",function(){
		location.href = "/product/getProduct?prodNo="+prodNoList[$($("td",$(this).parent())[0]).text()-1];
	});	
	
	$("#searchKeyword").keydown(function(key){
		if( key.keyCode==13 ){
			fncGetList(${resultPage.currentPage});
		}
	});
	$("#search").on("click",function(){
		fncGetList(${resultPage.currentPage});
	});
	
	$(".sort").on("click",function(){
		fncSortList(${resultPage.currentPage},$(".sort").index($(this)));
	});
	
	$("#unHidding").on("click",function(){
		fncHiddingEmptyStock(${resultPage.currentPage},false);
	});
	$("#hidding").on("click",function(){
		fncHiddingEmptyStock(${resultPage.currentPage},true);
	});
	
	$("#reset").on("click",function(){
		fncResetSearchCondition();
	});
	
	$("select[name=pageSize]").on("change",function(){
		fncGetList(${resultPage.currentPage});
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

function fncValidationCheck(){
	var result = true;
	
	if(document.detailForm.searchCondition.value != 1 && document.detailForm.searchKeyword.value != null){
		var splitSearchKeyword = document.detailForm.searchKeyword.value.split(',');
		
		if(splitSearchKeyword.length > 2){
			alert(" ','를 이용하여 2개의 범위값을 지정해 주십시오");
		}
		for(var i = 0; i < splitSearchKeyword.length; i++){
			if(isNaN(splitSearchKeyword[i])){
				alert("숫자만 가능합니다.")
				result = false;
				break;
			}
			
		}
	}
	
	return result;
}

function fncGetList(currentPage){
// 	document.detailForm.currentPage.value = currentPage;
	$("input[name=currentPage]").val(currentPage);
// 	document.detailForm.menu.value = "${param.menu}";
	$("input[name=menu]").val("${param.menu}");
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

// 	document.detailForm.submit();
	$("form[name=detailForm]").submit();
}

function fncSortList(currentPage, sortCode){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	$("input[name=sortCode]").val(sortCode);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").submit();
}

function fncHiddingEmptyStock(currentPage, hiddingEmptyStock){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	$("input[name=hiddingEmptyStock]").val(hiddingEmptyStock);
	
	//검색 조건 Validation Check
	if(!fncValidationCheck()){
		return;
	}

	$("form").submit();
}


function fncResetSearchCondition(){
	location.href = "/product/listProduct?menu=${param.menu}";
}



function fncUpdateTranCodeByProd(currentPage, prodNo){
	$("input[name=currentPage]").val(currentPage);
	$("input[name=menu]").val("${param.menu}");
	
	//검색 조건 Validation Check
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

<form name="detailForm" action="/product/listProduct" method="post">

<c:import url="../common/listPrinter.jsp"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage"/>
			<input type="hidden" id="menu" name="menu" value=""/>
			<input type="hidden" id="sortCode" name="sortCode" value="${search.sortCode}"/>
			<input type="hidden" id="hiddingEmptyStock" name="hiddingEmptyStock" value="${search.hiddingEmptyStock}"/>
			
			<c:import url="../common/pageNavigator.jsp"/>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" class="sort">상품 번호 오름차순</a>
			&nbsp;
			<a href="#" class="sort">상품 번호 내림차순</a>
			&nbsp;
			<a href="#" class="sort">상품 이름 오름차순</a>
			&nbsp;
			<a href="#" class="sort">상품 이름 내림차순</a>
			&nbsp;
			<a href="#" class="sort">가격 낮은순</a>
			&nbsp;
			<a href="#" class="sort">가격 높은순</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" id="hidding">재고없는 상품 숨기기</a>
			&nbsp;
			<a href="#" id="unHidding">모든 상품 보기</a>
		</td>
	</tr>
	<tr>
		<td align="center">
			<a href="#" id="reset">검색 조건 초기화</a>
		</td>
	</tr>
</table>
</form>

</div>
</body>
</html>
