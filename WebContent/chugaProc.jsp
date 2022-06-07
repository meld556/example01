<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%>

<%
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String memo = request.getParameter("memo");
	
	MemoDTO dto = new MemoDTO();
	dto.setName(name);
	dto.setMemo(memo);
	
	MemoDAO dao = new MemoDAO();
	int result = dao.setInsert(dto);
	
	if(result > 0) {
		out.println("<script>");
		out.println("location.href='list.jsp';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('등록중 오류가 발생했습니다.');");
		out.println("location.href='list.jsp';");
		out.println("</script>");		
	}
	
%>