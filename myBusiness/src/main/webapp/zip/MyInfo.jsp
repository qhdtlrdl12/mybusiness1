<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberBean" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<% 
    String id = (String)session.getAttribute("idKey");
    MemberBean info = mMgr.getMember(id);
    String jobname = mMgr.getJobname(info.getJob());
    
    String gen;
    if(info.getGender().equals("1")){
    	gen = "남성";
    }else {
    	gen = "여성";    
    	}
%>
<%
   String hobby[] = info.getHobby();
   String lists[] = {"인터넷","여행","게임","영화","운동"};
   String hobbyin = "";
   for(int i = 0; i < hobby.length; i++){
	   if(hobby[i].equals("1"))
		 hobbyin += "/" + lists[i];
   }
   hobbyin = hobbyin.replaceFirst("/"," ");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#ffffcc">
<h1>회원정보</h1>
<table bordercolor="#0000ff" border="1">
<tr>
   <td><strong>ID</strong></td>
   <td><strong>PWD</strong></td>
   <td><strong>NAME</strong></td>
   <td><strong>GENDER</strong></td>
   <td><strong>BIRTHDAY</strong></td>
   <td><strong>EMAIL</strong></td>
   <td><strong>ZIPCODE</strong></td>
   <td><strong>ADDRESS</strong></td>
   <td><strong>HOBBY</strong></td>
   <td><strong>JOB</strong></td>
   <td><strong>country</strong></td>
</tr>
<tr>
   <td><strong><%=info.getId() %></strong></td>
   <td><strong><%=info.getPwd() %></strong></td>
   <td><strong><%=info.getName() %></strong></td>
   <td><strong><%=gen%></strong></td>
   <td><strong><%=info.getBirthday() %></strong></td>
   <td><strong><%=info.getEmail() %></strong></td>
   <td><strong><%=info.getZipcode() %></strong></td>
   <td><strong><%=info.getAddress() %></strong></td>
   <td><strong><%=hobbyin%></strong></td>
   <td><strong><%=jobname %></strong></td>
   <td><strong><%=info.getCountry() %></strong></td>
</tr>
</table>
</body>
</html>