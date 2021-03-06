<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo33.service.*" %>
<%@ page import="kr.ac.kopo.kopo33.domain.*" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Search_MVC</title>
<style>
    html {
      background-color: #F0F0F0;
      font-family: 'Jua', 'Playfair Display', sans-serif, serif;
    }

    table,
    tr,
    td {
      border: 0px;
      border-collapse: collapse;
      border-top: 1px solid black;
      border-bottom: 1px solid grey;
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

    a:link { color:black; text-decoration: none; }
    a:hover { color:black; text-decoration: underline; }
    a:visited { color:black; text-decoration: none; }
    a.contents:visited { color:grey; text-decoration: none; }
  
    #button {
      float: right;
      margin: 5px 5px;
      border: 1px solid black;
      font-size: medium;
      font-family: 'Jua', 'Playfair Display', sans-serif, serif;
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

    #btt {
      margin: 5px 5px;
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
<% 
    String search = request.getParameter("search");		//????????? ??????
    String select = request.getParameter("select");		//????????? ???????????? (??????, ??????)
%>
</head>
<body>
  <% 
  	
    try {
    	String pages = request.getParameter("pages");
    	BoardItemService boardItemService = new BoardItemServiceImpl();
    	List<Integer> pagesCal = boardItemService.searchPageCal(search, select, pages);
    	/* 
    	0. ??? ????????? ???			1. ??? ?????????		2. ???????????? ?????????
    	3. ??? ?????? ????????? ????????? ???	4. ?????? ?????????		5. ????????? ?????? ??????(limit??? ?????? ??????)
    	6. ??? ?????????				7. ?????? ?????????
    	*/
    	List<BoardItem> boardItems = boardItemService.searchView(search, select, pagesCal.get(5));
    	
  %>
    <form method="post" name="form">
      <span>
        <h1>????????????</h1>
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
	       	<td class='numbering'><%=boardItem.getId() %></td>
	       	<td><a href='gongji_view.jsp?id=<%=boardItem.getId()%>' class='contents'><%=boardItem.getTitle() %></a></td>
	       	<td class='numbering'><%=boardItem.getWriter() %></td>
	       	<td class='numbering'><%=boardItem.getViewcount() %></td>
	       	<td class='numbering'><%=boardItem.getDate() %></td>
       	  </tr>
       	  <%
          }
       	  %>
        </table>
        <button type=button id="button" onclick="location.href='gongji_list.jsp'">???????????? <i class="fas fa-backspace"></i></button>
        <br><br>
        <div id="Pages">
      	<a href="?pages=<%=1 %>&select=<%=select%>&search=<%=search%>">??????</a>
      	<a href="?pages=<%=pagesCal.get(4)-1 %>&select=<%=select%>&search=<%=search%>">??????</a>
      	<%
      	for (int iCount = pagesCal.get(7); iCount <= pagesCal.get(6); iCount++) {
      		if (iCount == pagesCal.get(4)) {
      			out.println("<b id='currentPage'>" + iCount + "</b>");
      		} else {
      			out.println("<a href='?pages=" + iCount + "&select=" + select + "&search=" + search +"'>" + iCount + "</a>");
      		}
      	}
      	%>
      	<a href="?pages=<%=pagesCal.get(4)+1 %>&select=<%=select%>&search=<%=search%>">??????</a>
      	<a href="?pages=<%=pagesCal.get(1) %>&select=<%=select%>&search=<%=search%>">???</a>
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