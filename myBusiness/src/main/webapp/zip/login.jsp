<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
	  request.setCharacterEncoding("UTF-8");
	  String id = (String)session.getAttribute("idKey");
	  String name = (String)session.getAttribute("namekey");
	  
%>
<html>
<head>
<title>로그인</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.id.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>
</head>
<body bgcolor="#ffffcc">
<div align="center"><br/><br/>
		<%if (id != null) {%>
		<b><%=name%></b>님 환영 합니다.
		<p>제한된 기능을 사용 할 수가 있습니다.<p/>
		    <a href="pwdcheck.jsp">내정보조회</a><br/><br/>
		    <a href="../board/list.jsp">게시판</a><br/><br/>
		    <a href="../survey/pollList.jsp">투표함</a><br/><br/>
			<a href="logout.jsp">로그아웃</a>
			<%} else {%>
		<form name="loginFrm" method="post" action="loginProc.jsp">
			<table>
				<tr>
					<td align="center" colspan="2"><h4>로그인</h4></td>
				</tr>
				<tr>
					<td>아 이 디</td>
					<td><input name="id"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="button" value="로그인" onclick="loginCheck()">&nbsp;
							<input type="button" value="회원가입" onClick="javascript:location.href='../member/member.jsp'">
						</div>
					</td>
				</tr>
				<tr>
				  <td>
				     <a href="../board/list.jsp">게시판</a>
				  </td>
				</tr>
			</table>
		</form>
		<%}%>
	</div>
</body>
</html>