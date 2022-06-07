<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");	

	String no_ = request.getParameter("no");
	int no = 0;
	if(no_ == null || no_.trim().equals("")) {
		out.println("<script>");
		out.println("alert('해당 내용이 없습니다.');");
		out.println("location.href='list.jsp';");
		out.println("</script>");	
	} else {
		no = Integer.parseInt(no_);
	}

	MemoDTO arguDto = new MemoDTO();
	arguDto.setNo(no);

	MemoDAO dao = new MemoDAO();
	MemoDTO dto = dao.getSelectOne(arguDto);
%>
    
<table border="1">
	<tr>
		<td>순번</td>
		<td><%=dto.getNo() %></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<td>메모</td>
		<td><%=dto.getMemo() %></td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=dto.getRegiDate() %></td>
	</tr>
</table>

<hr>
|
<a href="#" onClick="move('list', '');">목록</a>
|
<a href="#" onClick="move('sakjeProc', '<%=dto.getNo() %>');">삭제</a>
|

<script>
	function move(value1, value2) {
		location.href = value1 + '.jsp?no=' + value2;
	}
</script>
