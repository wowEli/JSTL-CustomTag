<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mDAO" class="member.MemberDAO" />
<jsp:useBean id="mVO" class="member.MemberVO" />
<jsp:setProperty property="*" name="mVO" />
<%
	String action=request.getParameter("action");
	System.out.println("로그: "+action);
	if(action.equals("insert")){
		System.out.println("로그: 회원가입 액션으로 진입");
		if(mDAO.insert(mVO)){
			out.println("<script>alert('회원가입 완료!');window.close();</script>");
		}
		else{
			out.println("<script>alert('회원가입 실패!');history.go(-1);</script>");
		}
	}
	else if(action.equals("login")){
		System.out.println("로그: 로그인 액션으로 진입");
		mVO=mDAO.selectOne(mVO);
		if(mVO!=null){
			System.out.println("로그: 로그인 정보를 세션에 저장 ");
			session.setAttribute("mid", mVO.getMid());
			response.sendRedirect("ctrlB.jsp?action=main");
		}
		else{
			out.println("<script>alert('로그인 실패!');history.go(-1);</script>");
		}
	}
	else if(action.equals("logout")){
		session.invalidate();
		response.sendRedirect("ctrlB.jsp?action=main");
	}
%>