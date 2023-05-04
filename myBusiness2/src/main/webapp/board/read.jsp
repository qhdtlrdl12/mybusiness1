<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="board.BoardBean"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />
<jsp:useBean id="mMgr" class="member.MemberMgr" />
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
String pass = bMgr.getPass(num);
String repass = request.getParameter("pswd");
String nowPage = request.getParameter("nowPage");
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");
bMgr.upCount(num);//조회수 증가
BoardBean bean = bMgr.getBoard(num);//게시물 가져오기
String id = (String) session.getAttribute("idKey");
String name = mMgr.getName(id);
//	  String name = bean.getName();
String subject = bean.getSubject();
String regdate = bean.getRegdate();
String content = bean.getContent();
String filename = bean.getFilename();
int filesize = bean.getFilesize();
String ip = bean.getIp();
int count = bean.getCount();
session.setAttribute("bean", bean);//게시물을 세션에 저장
%>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function list(){
	    document.listFrm.submit();
	 } 
	
	function down(filename){
		 document.downFrm.filename.value=filename;
		 document.downFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<br />
	<br />
	 <%
	if (pass.equals("")) {
	%> 
	<table align="center" width="600" cellspacing="3">
		<tr>
			<td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
		</tr>
		<tr>
			<td colspan="2">
				<table cellpadding="3" cellspacing="0" width="100%">
					<tr>
						<td align="center" bgcolor="#DDDDDD" width="10%">작성자</td>
						<td bgcolor="#FFFFE8"><%=name%></td>
						<td align="center" bgcolor="#DDDDDD" width="10%">등록날짜</td>
						<td bgcolor="#FFFFE8"><%=regdate%></td>
					</tr>
					<tr>
						<td align="center" bgcolor="#DDDDDD">제 목</td>
						<td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
					</tr>
					<tr>
						<td align="center" bgcolor="#DDDDDD">첨부파일</td>
						<td bgcolor="#FFFFE8" colspan="3">
							<%
							if (filename != null && !filename.equals("")) {
							%> <a
							href="javascript:down('<%=filename%>')"><%=filename%></a>
							&nbsp;&nbsp;<font color="blue">(<%=filesize%>KBytes)
						</font> <%
 } else {
 %> 등록된 파일이 없습니다.<%
 }
 %>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br />
						<pre><%=content%></pre><br /></td>
					</tr>
					<tr>
						<td colspan="4" align="right"><%=ip%>로 부터 글을 남기셨습니다./ 조회수 <%=count%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<hr /> [ <a href="javascript:list()">리스트</a> | <a
				href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수 정</a> | <a
				href="reply.jsp?nowPage=<%=nowPage%>">답 변</a> | <a
				href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> ]<br />
			</td>
		</tr>
	</table>

	<form name="downFrm" action="download.jsp" method="post">
		<input type="hidden" name="filename">
	</form>

	<form name="listFrm" method="post" action="list.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<%
		if (!(keyWord == null || keyWord.equals(""))) {
		%>
		<input type="hidden" name="keyField" value="<%=keyField%>"> <input
			type="hidden" name="keyWord" value="<%=keyWord%>">
		<%
		}
		%>
	</form>
	 <%
	} else {
	%>
	<table width="600" cellpadding="3" align="center">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">사용자의 비밀번호를
					입력해주세요. <input type="password" name="pswd"> 
					<input type="button" value="확인" onclick="">
				</td>
			</tr>
		</table>
	<%
	}
	%> 
</body>
</html>