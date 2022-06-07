<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="memo.model.dto.MemoDTO"%>
<%@page import="memo.model.dao.MemoDAO"%>

<%@page import="java.util.ArrayList"%>

<%  
	request.setCharacterEncoding("UTF-8");

	String no_ = request.getParameter("no");
	int no = 0;
	if(!(no_ == null || no_.trim().equals(""))) {
		no = Integer.parseInt(no_);
	}
	
	MemoDAO dao = new MemoDAO();
	ArrayList<MemoDTO> list = dao.getSelectAll();         
%>


<form name="chugaForm">
<table border="1" style="margin: 10px;">
	<tr>
		<td colspan="2"><h2>메모장</h2></td>
	</tr>

	<tr>
		<td>이름</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>메모</td>
		<td>
			<input name="memo" style="width: 500px;"></input>&nbsp;
			<button type="button" onClick="chuga();">등록하기</button>
		</td>
	</tr>
</form>
	<tr>
	 	<td colspan="20">
			<table border="1" style="width: 90%; margin: 30px;">
				<tr>
					<td>순번</td>
					<td>이름</td>
					<td>메모</td>
					<td>등록일</td>
				</tr>
				<% 	for(int i=0; i<list.size(); i++) {
					MemoDTO listDto = list.get(i);
				%>
				<tr>
					<td><%=listDto.getNo() %></td>
					<td><%=listDto.getName() %></td>
					<td><a href="#" onClick="move('view', '<%=listDto.getNo() %>');"><%=listDto.getMemo() %></a></td>
					<td><%=listDto.getRegiDate() %></td>
				</tr>
				<% 
					}
				%>
			</table>
		</td>
	</tr>
</table>


<script>
	function chuga() {
		document.chugaForm.action = "chugaProc.jsp?";
		document.chugaForm.method = "post";
		document.chugaForm.submit();
	}
	
	function move(value1, value2) {
		var imsi = "";
		imsi += value1;
		imsi += '.jsp'
		imsi += '?no=' + value2;

		location.href = imsi;
	}
</script>

