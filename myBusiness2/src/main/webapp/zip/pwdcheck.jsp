<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<%
	  request.setCharacterEncoding("UTF-8");
      String pwd = request.getParameter("pwd");
	  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.pwd.value == "") {
			alert("��й�ȣ�� �Է��� �ּ���.");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>
</head>
<body bgcolor="#ffffcc">
<div align="center"><br/><br/>
		<form name="loginFrm" method="post" action="pwdProc.jsp">
			<table>
				<tr>
					<td>��й�ȣ</td>
					<td>
					<input type="password" name="pwd">
					<input type="button" value="Ȯ��" onclick="loginCheck()">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>