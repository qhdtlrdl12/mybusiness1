<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
	  request.setCharacterEncoding("UTF-8");
	  String id = (String)session.getAttribute("idKey");
	  String pwd = request.getParameter("pwd");
	  String url = "pwdcheck.jsp";
	  String msg = "비밀번호를 틀렸습니다.";
	  
	  boolean result = mMgr.loginMember(id,pwd);
	  if(result){ 
	         url = "MyInfo.jsp";
%>	         
	    
	  <%}else{%>
	      <script>
	      alert("<%=msg%>");
	      </script>
<%} %>
<script>	
	location.href="<%=url%>";
</script>