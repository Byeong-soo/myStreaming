<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A상세보기</title>
<jsp:include page="/WEB-INF/views/layout/Header.jsp"/>

<link href="../resources/css/board.css" type="text/css" rel="stylesheet" media="screen,projection"/>
</head>
<body id="boay-pd">
	
	<jsp:include page="/WEB-INF/views/layout/sidebar.jsp" />
	<jsp:include page="/WEB-INF/views/layout/carousel.jsp" />

	<div class="container">
	<h3 class="text-center board-title">Q&A 상세보기</h3>
	
	<table class="table">
		
				<tr>
					 <th class="text-center">작성자</th>
					<td>${ board.mid }</td>
				</tr>
				<tr>
					 <th class="text-center">제목</th>
					<td>${ board.subject }</td>
				</tr>
				<tr>
					 <th class="text-center">작성일</th>
					<td><fmt:formatDate value="${ board.regDate }" pattern="yyy.MM.dd HH:mm:ss"/></td>
				</tr>
				<tr>
					 <th class="text-center">조회수</th>
					<td>${ board.readcount }</td>
				</tr>
				<tr>
					 <th class="text-center">내용</th>
					<td colspan="10">
						${board.content}
					</td>
				</tr>
				<tr>
					 <th class="text-center">첨부파일</th>
					<td>
					<%--첨부파일이 있으면 --%>
					<c:choose>
						<c:when test="${ fn:length(attachList) gt 0 }"><%--attach > 0 --%>
						 
						 <c:forEach var="attach" items="${ attachList }">
						 	<c:if test="${attach.filetype == 'O' }"><%--일반파일일 경우--%>
						 	<%--다운로드할 파일 경로입니다. --%>
						 	 <c:set var="filepath" value="${attach.uploadpath }/${ attach.uuid }_${ attach.filename }" />
						 		<li>
						 			<a href="/board/download?fileName=${filepath }">
						 			<i class="bi bi-download"></i>
						 			${attach.filename}
			
						 			</a>
						 		</li>
						 
						 	</c:if>
						 	<c:if test="${attach.filetype == 'I' }"><%--이미지 파일일 경우 --%>
						 	<%--썸네일 이미지 파일 경로--%>
						 	<c:set var="filepath" value="${ attach.uploadpath }/s_${ attach.uuid }_${ attach.filename }" />
						 	<%--원본 이미지 파일 경로 --%>
						 	<c:set var="fileOringn" value="${ attach.uploadpath }/${ attach.uuid }_${ attach.filename }" />
						 	<li>
						 		<a href="/board/display?fileName=${fileOringn }">
						 			<img src="/board/display?fileName=${filepath}">
						 		</a>
						 	</li>
						 	</c:if>
						 </c:forEach>
						</c:when>
						<c:otherwise>
							첨부파일이 없습니다.
						</c:otherwise>
					</c:choose>
					
					</td>
				</tr>
		</table>
	 <div class="my-5 text-center">
	 <%--로그인 했을때 --%>
	   <c:if test="${ not empty sessionScope.id }">
	 	<%--로그인 아이디와 글 작성자 아이디가 같을때 --%>
	 	   	<c:if test="${ sessionScope.id eq board.mid  or sessionScope.id eq 'admin'}">
	 
	 	 <button type="button" class="btn ml-3 background-purple text-white" onclick="location.href='/board/modify?num=${ board.num }&pageNum=${ pageNum }';">
            <i class="bi bi-pencil-square"></i>
           글수정
        </button>
	 	
       <button class="btn ml-3 background-purple text-white" type="button" onClick="remove(event)"><i class="bi bi-trash"></i>글삭제</button>
        	</c:if>
       <button type="button" class="btn ml-3 background-purple text-white" onclick="location.href='/board/reply?reRef=${ board.reRef }&reLev=${ board.reLev }&reSeq=${board.reSeq}&pageNum=${ pageNum }';">
            <i class="bi bi-reply"></i>
           답글
        </button>
           </c:if>
                  
         <button type="button" class="btn ml-3 background-purple text-white" onclick="location.href='/board/list?pageNum=${ pageNum }';">
            <i class="bi bi-card-checklist"></i>
         글목록
        </button>
      
      </div>
      
	
	</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>

<script>
//글삭제 버튼을 클릭하면 호출 되는 함수
function remove(event){
	
	var isRemove = confirm('이 글을 삭제하시겠습니까?');//turn/false 리턴
	
	if(isRemove == true){
		location.href='/board/remove?num=${ board.num }&pageNum=${ pageNum }';
	}
}


</script>
</body>
</html>