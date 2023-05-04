<%@ page contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.time.LocalDate" %>
<jsp:useBean id="pMgr" class="survey.PollMgr"/>
<jsp:useBean id="plBean" class="survey.PollListBean"/>
<jsp:setProperty property="*" name="plBean"/>
<jsp:useBean id="piBean" class="survey.PollItemBean"/>
<jsp:setProperty property="*" name="piBean"/>
<%
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		LocalDate Sdate = LocalDate.parse(sdate);
		LocalDate Edate = LocalDate.parse(edate);
		String msg = "설문 추가에 실패 하였습니다.";
		String url = "pollInsert.jsp";
		if(Sdate.isAfter(Edate)){ %>
          <script>
              alert("<%=msg%>");
              location.href="<%=url%>";
          </script>
<% 	    }else{	
		plBean.setSdate(sdate);
		plBean.setEdate(edate);
		
		
		boolean flag = pMgr.insertPoll(plBean,piBean);
		if(flag){
			msg = "설문이 추가 되었습니다.";
			url = "pollList.jsp";
		}
%>
<script>
   alert("<%=msg%>");
   location.href="<%=url%>";
</script>
<%}%>