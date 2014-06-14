%#template for editing an item
%#the template expects to receive a value for "rowitem"
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
.text{
	font-size: 20px;
	color: #293EDB;
	margin:20px;
	padding:5px;
	background-color: #B4BFED;
}
.combobox{
	margin:20px;
	height:28px;
	font-size:20px;
}
.button{
	margin: 20px;
	height:28px;
	font-size: 20px;
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

<div class="titulo">Edit the task:</div>

<form action="/edititem" method="get">
	<input class="text" type="text" name="task" value="{{rowitem[0][3]}}" size="100" maxlength="100">
	%if rowitem[0][2]==1:
		<select class="combobox" name="user">
			<option value="1" selected>James Stofel</option>
			<option value="2">Richard Bolwart</option>
			<option value="3">Rose Riverside</option>
			<option value="4">Catherine Climber</option>
		</select>	
	%elif rowitem[0][2]==2: 
		<select class="combobox" name="user">  			
			<option value="1">James Stofel</option>
			<option value="2" selected>Richard Bolwart</option>
			<option value="3">Rose Riverside</option>
			<option value="4">Catherine Climber</option>
		</select>		  			
	%elif rowitem[0][2]==3:
		<select class="combobox" name="user">
			<option value="1">James Stofel</option>
			<option value="2">Richard Bolwart</option>
			<option value="3" selected>Rose Riverside</option>
			<option value="4">Catherine Climber</option>
		</select>		  			
	%elif rowitem[0][2]==4:
		<select class="combobox" name="user">
			<option value="1">James Stofel</option>
			<option value="2">Richard Bolwart</option>
			<option value="3">Rose Riverside</option>
			<option value="4" selected>Catherine Climber</option>
		</select>		  			
	%end
	<input type="hidden" name="iditem" value="{{rowitem[0][0]}}" size="10" maxlength="3">	
	<br/>
	<input class="button" type="submit" name="save" value="save">
</form>
		

