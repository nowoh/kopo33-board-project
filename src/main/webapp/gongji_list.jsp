<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo33.service.*"%>
<%@ page import="kr.ac.kopo.kopo33.domain.*"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List_MVC</title>
<style>
html {
	background-color: #F0F0F0;
	font-family: 'Jua', 'Playfair Display', sans-serif, serif;
}

table, tr, td {
	border: 0px;
	border-collapse: collapse;
	border-bottom: 1px solid lightgrey;
}

td {
	padding: 4px;
}

tr#title {
	text-align: center;
	border-top: 2px solid black;
	border-bottom: 2px solid black;
}

.numbering {
	text-align: center;
}

span {
	position: absolute;
	top: 40%;
	left: 50%;
	transform: translate(-50%, -50%);
}

a:link {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

a:visited {
	color: black;
	text-decoration: none;
}

a.contents:visited {
	color: grey;
	text-decoration: none;
}

#button {
	float: right;
	margin: 5px 5px;
	border: 1px solid black;
	font-size: medium;
	font-family: 'Jua', 'Playfair Display', sans-serif, serif;
}

#btt {
	margin: 5px 5px;
	font-size: medium;
}

.search {
	float: left;
	margin: 5px 5px;
	border: 1px solid black;
	font-size: medium;
	font-family: 'Jua', 'Playfair Display', sans-serif, serif;
	background-color: transparent;
}

#search {
	height: 25px;
}



button {
	background-color: transparent;
}

button:hover {
	cursor: pointer;
	background-color: #9cbed4;
}

#select {
	margin: 5px 0px;
	height: 25px;
	font-family: 'Jua', 'Playfair Display', sans-serif, serif;
}

#Pages {
	text-align: center;
}

#currentPage {
	font-size: 20px;
}
</style>
</head>
<body>
	<% 
	String pages = request.getParameter("pages");
	//String board_title = request.getParameter("board_title");
	//if (board_title == null || board_title.equals("")) {
	//	board_title = "";
	//}
	//int fk_board_id = Integer.parseInt(request.getParameter("fk_board_id"));
	BoardItemService boardItemService = new BoardItemServiceImpl();
	List<Integer> pagesCal = boardItemService.pageCal(pages);
	/* 
	0. ??? ????????? ???			1. ??? ?????????		2. ???????????? ?????????
	3. ??? ?????? ????????? ????????? ???	4. ?????? ?????????		5. ????????? ?????? ??????(limit??? ?????? ??????)
	6. ??? ?????????				7. ?????? ?????????
	*/
	List<BoardItem> boardItems = boardItemService.selectAll(pagesCal.get(5));
	
    try { 
 %>

<form method="post" name="form">
	<span>
		<h1>
			MVC?????? ????????? ????????? <i class="far fa-keyboard"></i>
		</h1>
		<table>
			<tr id="title">
				<td class="numbering" width=50>??????</td>
				<td width=400>??????</td>
				<td width=80>?????????</td>
				<td width=80>?????????</td>
				<td width=100>?????????</td>
			</tr>
			<%
			for (BoardItem boardItem : boardItems) {
			%>
			<tr>
				<td class='numbering'><%=boardItem.getId()%></td>
				<td><a href='gongji_view.jsp?id=<%=boardItem.getId()%>'
						class='contents'><%=boardItem.getTitle()%></a></td>
				<td class='numbering'><%=boardItem.getWriter()%></td>
				<td class='numbering'><%=boardItem.getViewcount()%></td>
				<td class='numbering'><%=boardItem.getDate()%></td>
			</tr>
			<%
			}
			%>
		</table> 
		<select name="select" id="select" class="search">
		<option value="??????" selected>??????</option>
		<option value="??????">??????</option>
		<option value="?????????">?????????</option>
		</select> 
		<input type="text" name="search" id="search" class="search"	maxlength="50" value="" required>
		<button class="search" id="btt"	onclick="javascript: form.action='gongji_search.jsp';">?????? <i class="fas fa-search"></i></button>
		
		<button type=button id="button"	onclick="location.href='gongji_insert.jsp'">????????? <i class="fas fa-pen"></i></button>
		<br><br>
		<div id="Pages">
			<a href="?pages=<%=1%>">??????</a>
			<a href="?pages=<%=pagesCal.get(4) - 1%>">??????</a>
			<%
			for (int iCount = pagesCal.get(7); iCount <= pagesCal.get(6); iCount++) {
			  if (iCount == pagesCal.get(4)) {
			    out.println("<b id='currentPage'>" + iCount + "</b>");
			  } else {
			    out.println("<a href='?pages=" + iCount + " '>" + iCount + "</a>");
			  }
			}
			%>
			<a href="?pages=<%=pagesCal.get(4) + 1%>">??????</a> 
			<a href="?pages=<%=pagesCal.get(1) %>">???</a>
		</div>
	</span>
</form>
<% 
	} catch (Exception e) { 
	  out.println(e);
	  out.println("???????????? ???????????? ????????????."); 
	} 
%>
</body>
</html>