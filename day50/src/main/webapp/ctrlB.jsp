<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,board.*" %>
<jsp:useBean id="bDAO" class="board.BoardDAO" />
<jsp:useBean id="bVO" class="board.BoardVO" />
<jsp:setProperty property="*" name="bVO" />
<jsp:useBean id="rVO" class="board.ReplyVO" />
<jsp:setProperty property="*" name="rVO" />
<%
	String action=request.getParameter("action");

	if(bVO.getCnt()==0){ // request.getP
		bVO.setCnt(2);
	//	-> 향후, 초기화 매개변수로 설정도 가능!
	}
	System.out.println("cnt: "+bVO.getCnt());

	if(action.equals("main")){ // 모든게시글과 모든 댓글 
		ArrayList<BoardSet> datas=bDAO.selectAll(bVO);
		request.setAttribute("datas", datas);
		request.setAttribute("cnt", bVO.getCnt());
		pageContext.forward("main.jsp");
	}
	else if(action.equals("insertB")){ // 게시글 추가
		if(bDAO.insertB(bVO)){
			response.sendRedirect("ctrlB.jsp?action=main");
		}
		else{
			throw new Exception("insertB 오류");
		}
	}
	else if(action.equals("insertR")){ // 댓글 추가
		if(bDAO.insertR(rVO)){
			pageContext.forward("ctrlB.jsp?action=main");
		}
		else{
			throw new Exception("insertR 오류");
		}
	}
	else if(action.equals("deleteB")){
		if(bDAO.deleteB(bVO)){
			response.sendRedirect("ctrlB.jsp?action=main");
		}
		else{
			throw new Exception("deleteB 오류");
		}
	}
	else if(action.equals("deleteR")){
		if(bDAO.deleteR(rVO)){
			pageContext.forward("ctrlB.jsp?action=main");
		}
		else{
			throw new Exception("deleteR 오류");
		}
	}
	else if(action.equals("fav")){
		if(bDAO.update(bVO)){
			pageContext.forward("ctrlB.jsp?action=main");
		}
		else{
			throw new Exception("fav 오류");
		}
	}
%>