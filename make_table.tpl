%#template to generate a HTML table from a list of tuples (or list of lists, or tuple of tuples or ...)

<style type="text/css">

.page_header{
  background-color:#B4BFED;
  color:#293EDB;
  padding: 3px 0px 3px 30px;
}
.menu{
  background-color: #0D1C8E;
  height: 32px;
  padding-left:50px;
  padding-top:5px;
  border:white solid 1px;
}
.menu a, .menu a:visited, .menu a:active, .menu a:hover {
  color:white;
  text-decoration:none;
  font-size: 20px;
}
.menu_item{
  float: left;
  padding-right: 15px;
}
.titulo{
	background-color: #FF9010;
	font-family: Georgia;
	font-size: 30px;
	color:white;
	padding:10px;
}
.celda{
	background-color: #0D1C8E;
	font-family: Arial;
	font-size: 20px;
	color:white;
	padding:10px;
}
.table_header{
	background-color: #A69305;
	font-family: Arial;
	font-size: 20px;
	color:white;
}
.table_header th{
	padding: 10px;
}	
	
</style>

<div class="page_header">
  <h1>Task Group Reminder<h1>
  <h3>keep all duties on schedule...</h3>
</div>

<div class="menu">
  <div class="menu_item"><a href="http://localhost:8080/todo">main</a></div>
  <div class="menu_item"><a href="http://localhost:8080/new">new</a></div>
</div>

<div class="titulo">Pending tasks:</div>
<table border="0">
	<tr class="table_header">
  		<th>Status</th>
  		<th>User</th>
  		<th>Image</th>
  		<th>Task</th> 
  		<th>Edit</th>
	</tr>	

%for row in rows:
%xcol=0
  <tr>
  	%for col in row:
  		%xcol+=1
    	<td class="celda">
    	%if xcol==3:
    		<img src="http://silanet.org/sites/default/files/{{col}}.jpg" alt="" style="width:auto; height:auto;">
		%elif xcol==1:
			<form action="/done" method="GET"><button class="button" type="submit" name="done" value="{{col}}">Done</button></form>
		%elif xcol==5:
			<form action="/edititem" method="GET"><button class="button" type="submit" name="edit" value="{{col}}">Edit</button></form>
    	%else:
    		{{col}}	
    	%end	
    	</td>    	
  	%end
  </tr>
%end
</table>

<div class="titulo">Completed tasks:</div>
<table border="0">
	<tr class="table_header">
  		<th>No.</th>
  		<th>User</th>
  		<th>Image</th>
  		<th>Task</th> 
	</tr>	

%for row in rows2:
%xcol=0
  <tr>
  	%for col in row:
  		%xcol+=1
    	<td class="celda">
      %if xcol==1:
        <form action="/undone" method="GET"><button class="button" type="submit" name="undone" value="{{col}}">Undone</button></form>      
    	%elif xcol==3:
    		<img src="http://silanet.org/sites/default/files/{{col}}.jpg" alt="" style="width:auto; height:auto;">
    	%else:
    		{{col}}	
    	%end	
    	</td>    	
  	%end
  </tr>
%end
</table>

