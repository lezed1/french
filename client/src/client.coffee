text = ''
socket = io.connect document.domain
socket.on 'news', (data) ->
	console.log document.getElementById('text').innerHTML 
	text += JSON.stringify(data) + '<br/>'
	document.getElementById('text').innerHTML = text
	socket.emit 'my other event', { my: 'data' }