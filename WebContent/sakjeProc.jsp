<%@page import="memo.model.dao.MemoDAO"%>
<%@page import="memo.model.dto.MemoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String no_ = request.getParameter("no");
	int no = Integer.parseInt(no_);

	MemoDTO arguDto = new MemoDTO();
	arguDto.setNo(no);
	
	MemoDAO dao = new MemoDAO();
	int result = dao.setDelete(arguDto);
	
	if(result > 0) {
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.');");
		out.println("location.href='list.jsp';");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('삭제중 오류가 발생했습니다.');");
		out.println("location.href='view.jsp?no=" + no + "';");
		out.println("</script>");		
	}
	
%>