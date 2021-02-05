// Use firefox plugin: https://addons.mozilla.org/en-US/firefox/addon/javascript/ to run this code.
function update() {
	// US coloring:
	document.querySelectorAll('.ghx-summary').forEach((e)=>{
		const colors = {
			'FPGA': '#DDF',
			'BIGO': '#DFD',
			'TET': '#FDD',
			'NSD570': '#DFF',
			'OPIC2': '#FFD',
			'TEGO1': '#FDF',
			'BTAF': '#DDD'
		}
		for (const [k, v] of Object.entries(colors)) {
			if(e.innerText.startsWith(k)) {
				e.style.backgroundColor=v
				e.style.borderRadius="3px"
				e.style.padding="0px 3px"
				break
			}
		}
	})
	// partial sums:
	document.querySelectorAll(".my-partial-sum").forEach((e)=>{
		e.parentNode.removeChild(e)
	})
	document.querySelectorAll('.ghx-backlog-container,.ghx-column').forEach((e)=>{
		let t = 0
		e.querySelectorAll('[title="Story Points"]').forEach((e)=>{
			const n = parseFloat(e.innerText)
			if (n>0) { t+=n }
			else e.style.backgroundColor = "orange"
			newEl = document.createElement("div")
			newEl.style.cssText = "margin:.4em 0 0 .5em; font-weigth:bold; font-size:11px; color:darkgray; display:block; float:right; min-width:3em; text-align:right;"
			newEl.innerText = t
			newEl.setAttribute("title","Partial Story Points Sum")
			newEl.classList.add("my-partial-sum")
			e.parentNode.append(newEl)
		})
	})
	// blink Critical:
	document.querySelectorAll('.ghx-priority[title="Critical"]').forEach((e)=>{
		e.style.visibility = e.style.visibility == "hidden" ? "visible" : "hidden"
	})
	// re-trigger self:
	setTimeout(update, 800)
}
update()
