<%@ page import = "test001.DBConnection"%>
<%@page import = "java.util.ArrayList" %>
<%@ page import = "test001.getfeed"%>
<%@ page import = "test001.comment_Con"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "ko">
<!--폰트나 여러가지 링크 head에 적을 것-->
    <head>
        <meta charset = "utf-8"/><html>
        <title>솔방울</title>
        
        <!--css 연동하는 거 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="comcon.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>

    	<!-- Link Bootstrap's CSS -->
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
        
    </head>

    <!--자바스크립트 id로 찾아서 가져옴!!!!-->
    <!--대충 제목이랑 내용 경계선-->
    <body>
        <div id = "wrapper">
        
            <div id ="main_row1">
                <div class = "logo_box">
                <button class = "logo" type="button" onclick="location.href='main.jsp'"><img src = "pic/솔방울.png"></button>
                </div>
                <div class = "search">
                    <input class = "input" type="text" placeholder="검색어를 입력하세요.">
                    <img class = "searchpic" src="pic/돋보기.png">
                </div>
                <!--로그인 전과 후의 차이 어찌 해결함-->
				<div class = "main_btn">
                	<button class = "login_btn"><a href = "signup_new.jsp">회원가입</a></button>
                	<%
					String UserId = null;
                	if(session.getAttribute("UserId") != null){
                		UserId = (String)session.getAttribute("UserId");
                	}
                	if(UserId != null){
               		%>
                    <button class = "login_btn" ><a href = "logout.jsp">로그아웃</a></button>
                    
                 	<%
                    }else {
                	%>
                	<button class = "login_btn"><a href = "login.jsp">로그인</a></button>
                	<%
                    }
                	DBConnection best5 = new DBConnection();
                	String best[] = new String[5];
                	best = best5.best5();
                	%>
				</div>
            </div>

            <nav class="navbar navbar-expand-lg navbar-light bg-white">
				<div class="container-fluid">
    				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
      					<span class="navbar-toggler-icon"></span>
    				</button>
    				<div class="collapse navbar-collapse" id="navbarScroll">
      					<ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px; width:100%">
        					<li class="nav-item">
          						<a class="nav-link" href = "main.jsp#certi_list" >자격증</a>
								  <!--다른 페이지는 자격증 누르면 메인페이지로 이동할 예정-->
        					</li>
        					<li class="nav-item">
								<a class="nav-link" href="feedList.jsp">자유 게시판</a>
						  </li>
        					<li class="nav-item">
					<%
                    if(UserId != null){
               		%>
          						<a class="nav-link" href="Mypage.jsp">마이페이지</a>
					<%
                    }else{
                    %>
								<a class="nav-link" href="login.jsp">마이페이지</a>
					<% } %>
        					</li>
      					</ul>
    				</div>
  				</div>
			</nav>

            <div class="uploadbox">
                <form action="#">
                <%
                
                String title = null;
                if(request.getParameter("title") != null){
                	title = request.getParameter("title");
                }
        		
                DBConnection Getfeed_DB = new DBConnection();
                ArrayList<getfeed> list = Getfeed_DB.getfeed(title);
                
                DBConnection getComment_DB = new DBConnection();
                ArrayList<comment_Con> list_2 = getComment_DB.GetComment(title);
                
                
                %>
                    <label for="title" class="labeltitle" style = "font-size:x-large"><%= list.get(0).getTitle() %></label>
                    <hr style="color: #74613f">
                    <label id="contentbox" style="width:90%; height: 250px; resize:none; border: white; font-size:large;"><%= list.get(0).getContentbox() %></label><br/> <br/>
                	
                </form>
                <form action = "good.jsp"> 
                		<input type="submit" id="recombtn" value="추천">
                   		<input type = "text" name = "title" value = "<%=title %>" style="display:none";>
                	</form>
                
            </div>
            
            <div class="commentbox">
                <h1>댓글</h1>
                <%
			if(UserId != null){
			%>
                <form action="comment_action.jsp">
                <%}
			else {
			%>
			     <form action="login.jsp">
                <%}%>
                
					<label for="comment" class="labelcomment"></label>   
                    <textarea id="commentbox" name = "comment" style="width:650px; height: 10px; resize:none; margin-left: 100px;
     				   padding: 25px 15px;" ></textarea><br/> <br/>  
                   	<input type="submit" id="commentbtn" value="댓글등록">
                   	<input type = "text" name = "title" value = "<%=title %>" style="display:none";>
                </form>
            </div>   
             <div class="comment"  style="width:850px; margin-left:100px; border-top: 1px solid #5c3a07">
                <form action="#">
                <%
                for(int i = 0; i < list_2.size(); i++){
                %>
					<br/>
                    <label for="title" class="labeltitle" style = "font-size:20px"><%= list_2.get(i).getWriter() %></label>
                    <br/>
                    <label for="title" class="labeltitle"><%= list_2.get(i).getContent() %></label>
                    <br/>
                    <label for="title" class="labeltitle" style = "font-size:12px"><%= list_2.get(i).getDate() %></label>
                    <br/>
                    <br/>
                    <hr>
                 <% } %>
                </form>
            </div>   
        </div> 

            
        
    </body>
</html>
