import sqlite3
from bottle import route, run, debug, template, request, static_file, error


# only needed when you run Bottle on mod_wsgi
from bottle import default_app

@route('/todo')
def todo_list():

    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT t.id, p.name, p.id, t.task, t.id FROM todo t \
                LEFT JOIN people p \
                    ON t.user=p.id \
                WHERE t.status=1 \
                ORDER BY t.id DESC;")
    result = c.fetchall()
    c.execute("SELECT t.id, p.name, p.id, t.task FROM todo t \
                LEFT JOIN people p \
                    ON t.user=p.id \
                WHERE t.status=0 \
                ORDER BY t.id DESC;")
    result2 = c.fetchall()

    c.close()

    output = template('make_table', rows=result, rows2=result2)
    return output

@route('/new', method='GET')
def new_item():

    if request.GET.get('save','').strip():

        new = request.GET.get('task', '').strip()
        user = request.GET.get('user', '').strip()
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()

        c.execute("INSERT INTO todo (task,status,user) VALUES (?,?,?)", (new,1,user))
        new_id = c.lastrowid

        conn.commit()
        c.close()

        #return '<p>The new task was inserted into the database, the ID is %s</p>' % new_id
        return todo_list()
    else:
        return template('new_task.tpl')

@route('/done', method='GET')
def done():
    if request.GET.get('done','').strip():
        idupdate=request.GET.get('done','').strip()
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE todo SET status = ? WHERE id LIKE ?", (0,idupdate))
        conn.commit()
        c.close()        
        return todo_list()
    else:
        return "error"

@route('/undone', method='GET')
def done():
    if request.GET.get('undone','').strip():
        idupdate=request.GET.get('undone','').strip()
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE todo SET status = ? WHERE id LIKE ?", (1,idupdate))
        conn.commit()
        c.close()        
        return todo_list()
    else:
        return "error"

@route('/edititem', method='GET')
def edititem():
	if request.GET.get('edit','').strip():
		itemupdate=request.GET.get('edit','').strip()
		conn = sqlite3.connect('todo.db')
		c = conn.cursor()
		c.execute("SELECT t.id, p.name, p.id, t.task FROM todo t \
                LEFT JOIN people p \
                    ON t.user=p.id \
                WHERE t.id=" + itemupdate + ";")
		result = c.fetchall()

		output = template('edit_item', rowitem=result)
		return output
	else:
		if request.GET.get('save','').strip():
			task = request.GET.get('task', '').strip()
        	user = request.GET.get('user', '').strip()
        	iditem = request.GET.get('iditem', '').strip()        	

        	conn = sqlite3.connect('todo.db')
        	c = conn.cursor()
        	c.execute("UPDATE todo SET task = ?, user = ? WHERE id LIKE ?", (task, user, iditem))
        	conn.commit()
        	c.close()        
        	return todo_list()

@route('/edit/:no', method='GET')
def edit_item(no):

    if request.GET.get('save','').strip():
        edit = request.GET.get('task','').strip()
        status = request.GET.get('status','').strip()

        if status == 'open':
            status = 1
        else:
            status = 0

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("UPDATE todo SET task = ?, status = ? WHERE id LIKE ?", (edit,status,no))
        conn.commit()

        return '<p>The item number %s was successfully updated</p>' %no

    else:
        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT task FROM todo WHERE id LIKE ?", (str(no)))
        cur_data = c.fetchone()

        return template('edit_task', old = cur_data, no = no)

@route('/item:item#[0-9]+#')
def show_item(item):

        conn = sqlite3.connect('todo.db')
        c = conn.cursor()
        c.execute("SELECT task FROM todo WHERE id LIKE ?", (item))
        result = c.fetchall()
        c.close()

        if not result:
            return 'This item number does not exist!'
        else:
            return 'Task: %s' %result[0]

@route('/help')
def help():

    static_file('help.html', root='.')

@route('/json:json#[0-9]+#')
def show_json(json):

    conn = sqlite3.connect('todo.db')
    c = conn.cursor()
    c.execute("SELECT task FROM todo WHERE id LIKE ?", (json))
    result = c.fetchall()
    c.close()

    if not result:
        return {'task':'This item number does not exist!'}
    else:
        return {'Task': result[0]}


@error(403)
def mistake403(code):
    return 'There is a mistake in your url!'

@error(404)
def mistake404(code):
    return 'Sorry, this page does not exist!'


debug(True)
run(reloader=True)
#remember to remove reloader=True and debug(True) when you move your application from development to a productive environment

