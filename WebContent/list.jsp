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
	
	
	String searchGubun = request.getParameter("searchGubun");
	String searchData = request.getParameter("searchData");

	if(searchGubun == null || searchGubun.trim().equals("")) {
		searchGubun = "";
	}
	
	if(searchData == null || searchData.trim().equals("")) {
		searchData = "";
	}
	
	if(searchGubun.equals("") || searchData.equals("")) {
		searchGubun = "";
		searchData = "";
	}
	
	
	MemoDAO dao = new MemoDAO();
	ArrayList<MemoDTO> list = dao.getSelectAll(searchGubun, searchData);         
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
					<td><a href="#" onClick="move('view', '<%=listDto.getNo() %>', '', '');"><%=listDto.getMemo() %></a></td>
					<td><%=listDto.getRegiDate() %></td>
				</tr>
				<% 
					}
				%>
				
				
		<form name="searchForm">
		<tr>
			<td colspan="4" style="padding: 10px 0px;">
				<select name="searchGubun">
					<option value="" <% if(searchGubun.equals("")) { out.println("selected"); } %>>-- 선택 --</option>
					<option value="name" <% if(searchGubun.equals("name")) { out.println("selected"); } %>>이름</option>
					<option value="memo" <% if(searchGubun.equals("memo")) { out.println("selected"); } %>>메모</option>
					<option value="name_memo" <% if(searchGubun.equals("name_memo")) { out.println("selected"); } %>>이름+메모</option>
				</select>
				<input type="text" name="searchData" value="<%=searchData %>">
				<button type="button" onClick="search();">검색</button>
				<button type="button" onClick="move('list', '', '', '');">초기화</button>
			</td>
		</tr>
		</form>
				
				
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
	
	function search() {
		document.searchForm.action = "list.jsp";
		document.searchForm.method = "post";
		document.searchForm.submit();
	}
	
	function move(value1, value2, value3, value4) {
		var imsi = "";
		imsi += value1;
		imsi += '.jsp'
		imsi += '?no=' + value2;
		imsi += '&searchGubun=' + value3;
		imsi += '&searchData=' + value4;

		location.href = imsi;
	}
</script>

