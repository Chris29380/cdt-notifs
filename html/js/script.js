var typeN = "success"
var newSvg 

window.addEventListener('message', function(event) {
    if (event.data.type == "sendNotif") {
						
		typeN = event.data.typeN
		types = event.data.types
		msg = event.data.msg
		timer = event.data.timer
		idn = event.data.idn
		showNotification()
		
    }
})

function showNotification() {
    // Create a new notification div
	let id = idn
    const notification = document.createElement('div');
    notification.className = 'boxnotif';

	let color = ""
	let timerN = 0

	for (let typesIndex = 0; typesIndex < types.length; typesIndex++) {
		const elementType = types[typesIndex]
		let typeT = elementType.type
		if (typeT == typeN) {
			color = elementType.color	
			svgdata = elementType.svg
			timerN = timer || elementType.timer
		}
	}

    notification.style = "border: 1.3px solid " +color+ ";"

	const svgblock = document.createElement('div')
	svgblock.className = 'svgp'	
	svgblock.innerHTML = svgdata
    notification.appendChild(svgblock);

    const notifcontent = document.createElement('div');
	notifcontent.className = 'contentnotif'
    notifcontent.innerHTML = msg;
	notifcontent.style = "border-left: 1px solid " +color+ ";"
    notification.appendChild(notifcontent);

    // Append the notification to the container
    const container = document.getElementById('content');
    container.appendChild(notification);

    // Automatically remove the notification after timer
    setTimeout(() => {
        notification.classList.add('slide-out');
        notification.addEventListener('animationend', () => {
            container.removeChild(notification);
        });
		delnotifid(id)
    }, timer);
}

function delnotifid(idnotif) {
	$.post(`https://${GetParentResourceName()}/delnotifidn`, JSON.stringify({idnotif}))
}
