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

	String pageNumber_ = request.getParameter("pageNumber");
	if(pageNumber_ == null || pageNumber_.trim().equals("")) {
		pageNumber_ = "1";
	}
	int pageNumber = Integer.parseInt(pageNumber_);
	int pageSize = 10;
	int blockSize = 10;
	int totalRecord = dao.getTotalRecord(searchGubun, searchData);
	int block = (pageNumber - 1) / pageSize;
	int jj = totalRecord - pageSize * (pageNumber - 1);
	
	double totalPageDou = Math.ceil(totalRecord / (double)pageSize);
	int totalPage = (int)totalPageDou;
	
	int startRecord = pageSize * (pageNumber - 1) + 1;
	int lastRecord = pageSize * pageNumber;
	
	ArrayList<MemoDTO> list = dao.getSelectAll(searchGubun, searchData, startRecord, lastRecord);         
%>


<form name="chugaTopForm">
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
			String memo = listDto.getMemo();
			memo = memo.replace("\n", "<br>");
		%>
		<tr>
			<td><%=jj %></td>
			<td><%=listDto.getName() %></td>
			<td><a href="#" onClick="move('view', '<%=listDto.getNo() %>', '', '', '');"><%=listDto.getMemo() %></a></td>
			<td><%=listDto.getRegiDate() %></td>
		</tr>
		<% 
			jj--;
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
				<button type="button" onClick="move('list', '', '', '', '');">초기화</button>
			</td>
		</tr>
		</form>
		
		
		
	<% if(totalRecord > 0) { %>
		<tr>
			<td colspan="6" align="center" style="padding: 10px 0px;">
				<a href="#" onClick="move('list', '','<%=searchGubun %>', '<%=searchData %>', '1');">[첫페이지]</a> &nbsp;
				
				
				<%
					if(block > 0) {
						int imsiPage = (block - 1) * blockSize + 10;
				%>
					<a href="#" onClick="move('list', '','<%=searchGubun %>', '<%=searchData %>', '<%=imsiPage %>');">[이전10개]</a>
				<% } else { %>
						[이전10개]
				<% } %>
				&nbsp;
				<%
					for(int goPage=1; goPage<=blockSize; goPage++) {
						int imsiValue = block * blockSize + goPage;
						if(totalPage - imsiValue >= 0) {
							if(imsiValue == pageNumber) {
				%>
								[<%=imsiValue %>]
				<%				
							} else {
				%>				
								<a href="#" onClick="move('list', '','<%=searchGubun %>', '<%=searchData %>', '<%=imsiValue %>');"><%=imsiValue %></a>
				<%			
							}
							out.println("&nbsp;");
						}
					}
				%>
				&nbsp;
				
				<%
					int totalBlock = totalPage / blockSize;
					double value1 = (double)totalBlock;
					double value2 = totalPage / blockSize;
					if(value1 - value2 == 0) {
						totalBlock = totalBlock - 1;
					}
					
					if(block - totalBlock < 0) {
						int yyy = (block + 1) * blockSize + 1;
						int zzz = block + 1;
				%>
						<a href="#" onClick="move('list', '','<%=searchGubun %>', '<%=searchData %>', '<%=yyy %>');">[다음10개]</a>
				<%	} else { %>
						[다음10개]
				<% } %>
				&nbsp;
				<a href="#" onClick="move('list', '','<%=searchGubun %>', '<%=searchData %>', '<%=totalPage %>');">[끝페이지]</a>
			</td>
		</tr>
	<% } %>
	</table>
		</td>
	</tr>
</table>


<script>
	function chuga() {
		document.chugaTopForm.action = "chugaProc.jsp?";
		document.chugaTopForm.method = "post";
		document.chugaTopForm.submit();
	}
	
	function search() {
		document.searchForm.action = "list.jsp";
		document.searchForm.method = "post";
		document.searchForm.submit();
	}
	
	function move(value1, value2, value3, value4, value5) {
		var imsi = "";
		imsi += value1;
		imsi += '.jsp'
		imsi += '?no=' + value2;
		imsi += '&searchGubun=' + value3;
		imsi += '&searchData=' + value4;
		imsi += '&pageNumber=' + value5;
		location.href = imsi;
	}
</script>

