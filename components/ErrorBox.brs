

sub init()
	m.background1=m.top.findNode("background1")
	m.background2=m.top.findNode("background2")
	m.errorText=m.top.findNode("errorText")

	m.errorAnimation = m.top.findNode("errorAnimation")
	m.errorAnimIn = m.top.findNode("errorAnimIn")
	m.errorAnimInC = m.top.findNode("errorAnimInC")
	m.errorAnimOut = m.top.findNode("errorAnimOut")
	m.errorAnimOutC = m.top.findNode("errorAnimOutC")
	m.errorAnimPopupIn = m.top.findNode("errorAnimPopupIn")
	m.errorAnimPopupOut = m.top.findNode("errorAnimPopupOut")
	

	m.errorText.observeField("text", "onErrorTextChanged")
	m.background1.observeField("width", "onBackgroudWidthChanged")

end sub

sub onErrorTextChanged()
	sz=Len(m.errorText.text)
	if sz = 0
		return
	end if

	m.background1.width = 4
	
	sw=1280		 'Screen size
	ew=sz*14.0 'Destination size
	ey=50			 'Error position y
	em=5			 'Error margin from screen right

	
	m.errorAnimIn.keyValue  = [[sw+5, ey], [sw-10, ey]]
	m.errorAnimInC.keyValue  = [[sw-10, ey], [sw-(ew+em), ey]]
	
	m.errorAnimOutC.keyValue  = [[sw-(ew+em), ey], [sw-10, ey]]
	m.errorAnimOut.keyValue = [[sw-10, ey], [sw+5, ey]]

	m.errorAnimPopupIn.keyValue = [4, ew]
	m.errorAnimPopupOut.keyValue = [ew, 4]
	m.errorAnimation.control = "start"

end sub

sub onBackgroudWidthChanged()
	if m.background1.width < 5
		m.background2.width=0
		m.errorText.width=0
		if m.errorText.visible
			m.errorText.visible = false
		end if
	else
		m.background2.width=m.background1.width-4
		m.errorText.width=m.background1.width-4
		if not m.errorText.visible
			m.errorText.visible = true
		end if
	end if
end sub



