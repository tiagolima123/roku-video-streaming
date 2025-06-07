
sub init() 
	findNodes()
	settings()
	loadData()
	
	m.top.setFocus(true)
	
	m.video.audioFormat = "aac"
end sub





'----------DATA-------
sub saveData(section="default")
	sec=CreateObject("roRegistrySection",section)

	sec.Write("host", m.hostInput.text)
	sec.Write("port", m.portInput.text)
	sec.Write("path", m.pathInput.text)

	sec.Write("hostS", m.hostInputS.text)
	sec.Write("portS", m.portInputS.text)
	sec.Write("pathS", m.pathInputS.text)

	sec.Flush() 'commit it
end sub

sub getData(sec, key, default) as Dynamic
	if sec.Exists(key)
		return sec.Read(key)
	end if
	return default
end sub

sub loadData(section="default")
	sec=CreateObject("roRegistrySection", section)
	
	m.hostInput.text=getData(sec, "host", "")
	m.portInput.text=getData(sec, "port", "")
	m.pathInput.text=getData(sec, "path", "")

	m.hostInputS.text=getData(sec, "hostS", "")
	m.portInputS.text=getData(sec, "portS", "")
	m.pathInputS.text=getData(sec, "pathS", "")
end sub





'----------MOVE CURSOR ANIMATION---------
sub moveCursor(obj as Object)
	toPosition = [obj.translation[0], obj.translation[1]+45]
	toWidth = obj.width
	m.translationAnimC.keyValue = [m.cursor_position,toPosition]
	m.widthAnimC.keyValue = [m.cursor_widh,toWidth]

	m.cursor_position = toPosition
	m.cursor_width = toWidth

	m.myAnimC.control = "start"
end sub



sub setCursorFocus(focus as String)
	m.cursor_focused = focus

	if m.cursor_focused = "host"
		moveCursor(m.hostInput)
	elseif m.cursor_focused = "port"
		moveCursor(m.portInput)
	elseif m.cursor_focused = "path"
		moveCursor(m.pathInput)

	elseif m.cursor_focused = "hostS"
		moveCursor(m.hostInputS)
	elseif m.cursor_focused = "portS"
		moveCursor(m.portInputS)
	elseif m.cursor_focused = "pathS"
		moveCursor(m.pathInputS)

	elseif m.cursor_focused = "connect"
		moveCursor(m.connect)
	end if

	if m.input_nodes_index < 1 or m.input_nodes_index > 6 
		hideKeyboard()
	else
		showKeyboard()
	end if
end sub


sub moveCursorRight()
	if m.input_nodes_index = 3
		m.input_nodes_index = 7
	else
		m.input_nodes_index += 1
		if m.input_nodes_index > 7
			m.input_nodes_index = 4
		end if
	end if

	setCursorFocus(m.input_nodes[m.input_nodes_index])
end sub

sub moveCursorLeft()
	if m.input_nodes_index = 4
		m.input_nodes_index = 7
	else
		m.input_nodes_index -= 1
		if m.input_nodes_index < 1
			m.input_nodes_index = 3
		end if
	end if

	setCursorFocus(m.input_nodes[m.input_nodes_index])
end sub


sub moveCursorUp()
	if m.input_nodes_index = 7
		m.input_nodes_index = 3
	else
		m.input_nodes_index -= 3
		if m.input_nodes_index < 1
			m.input_nodes_index += 6
		end if
	end if
	
	setCursorFocus(m.input_nodes[m.input_nodes_index])
end sub


sub moveCursorDown()
	if m.input_nodes_index < 7
		m.input_nodes_index += 3
		if m.input_nodes_index > 6
			m.input_nodes_index -= 6
		end if
	end if
	
	setCursorFocus(m.input_nodes[m.input_nodes_index])
end sub





'--------------KEYBOARD---------
sub showKeyboard()
	if m.keyboardState = "hide"
		m.translationAnimK.keyValue = [[100,800],[100,450]]
		m.keyboardState = "visible"
		m.myAnimK.control="start"
	end if
end sub

sub hideKeyboard()
	if m.keyboardState = "visible"
		m.translationAnimK.keyValue = [[100,450],[100,800]]
		m.keyboardState = "hide"
		m.myAnimK.control="start"
	end if	
end sub


sub setKeyboardFocus()
	if m.keyboardState = "visible" and not m.keyboard_focus
		if m.cursor_focused = "host"
			m.keyboard_editing = m.hostInput
		elseif m.cursor_focused = "port"
			m.keyboard_editing = m.portInput
		elseif m.cursor_focused = "path"
			m.keyboard_editing = m.pathInput

		elseif m.cursor_focused = "hostS"
			m.keyboard_editing = m.hostInputS
		elseif m.cursor_focused = "portS"
			m.keyboard_editing = m.portInputS
		elseif m.cursor_focused = "pathS"
			m.keyboard_editing = m.pathInputS
		end if


		m.keyboard.text = m.keyboard_editing.text
		m.keyboard_editing.active = true

		m.keyboard.textEditBox.cursorPosition = len(m.keyboard.text)
		m.keyboard_editing.cursorPosition = m.keyboard.textEditBox.cursorPosition

		m.keyboard_focus = true
		m.keyboard.setFocus(true)
		m.cursor.opacity = 0.5
	end if
end sub

sub removeCursorFocus()
	if m.keyboard_focus
		m.keyboard_editing.active = false
		m.keyboard.setFocus(false)
		m.top.setFocus(true)
		m.cursor.opacity = 1.0
		m.keyboard_focus = false
	end if
	
end sub

sub changetext()
	if m.keyboard_editing.text <> m.keyboard.text and m.keyboard_editing.active
		m.keyboard_editing.text = m.keyboard.text
	end if
end sub

sub onCursorPostionChanged()
	m.keyboard_editing.cursorPosition = m.keyboard.textEditBox.cursorPosition
end sub


	


'-------------FIND NODES--------------------
sub findNodes()
	m.video = m.top.findNode("video")
	
	m.myAnimC = m.top.findNode("myAnimC")
	m.widthAnimC = m.top.findNode("widthAnimC")
	m.translationAnimC = m.top.findNode("translationAnimC")

	m.keyboard=m.top.findNode("keyboard")
	m.myAnimK=m.top.findNode("myAnimK")
	m.translationAnimK=m.top.findNode("translationAnimK")
	
	m.hostInput = m.top.findNode("hostInput")
	m.portInput = m.top.findNode("portInput")
	m.pathInput = m.top.findNode("pathInput")

	m.hostInputS = m.top.findNode("hostInputS")
	m.portInputS = m.top.findNode("portInputS")
	m.pathInputS = m.top.findNode("pathInputS")

	m.connect = m.top.findNode("connect")
	m.cursor = m.top.findNode("cursor")

	m.popupIndex = m.top.findNode("popupIndex")
	m.popupTimer = m.top.findNode("popupTimer")

	m.errorBox = m.top.findNode("errorBox")
end sub




'-------------SETTINGS--------------
sub settings()
	m.server = "http://192.168.0.123:4567"
	m.videoContent = createObject("RoSGNode", "ContentNode")
	m.keyboardState = "visible"


	m.downloader = CreateObject("RoSGNode", "Downloader")
	m.downloader.ObserveField("error", "onDownloadError")
	m.downloader.ObserveField("list", "onDownloadCompleted")

	m.cursor_position=[200,240]
	m.cursor_width=300
	m.cursor_focused = "host"
	m.keyboard_focus = false
	m.movie_focus = false

	m.keyboard.ObserveField("text", "changetext")	
	m.keyboard.textEditBox.ObserveField("cursorPosition", "onCursorPostionChanged")	


	m.input_nodes = CreateObject("roList")

	m.input_nodes.addTail("none")
	m.input_nodes.addTail("host")
	m.input_nodes.addTail("port")
	m.input_nodes.addTail("path")
	m.input_nodes.addTail("hostS")
	m.input_nodes.addTail("portS")
	m.input_nodes.addTail("pathS")

	m.input_nodes.addTail("connect")
	m.input_nodes_index=1

	m.list = []
	m.listIndex = 0
	m.listSize = 0

	m.popupTimer.ObserveField("fire", "hidePopupIndex")
end sub


'-----------POPUP-------------
sub showPopupIndex()
	m.popupIndex.text = Str(m.listIndex+1)+"/"+Str(m.listSize)
	m.popupIndex.visible = true
	m.popupTimer.duration = 2
	m.popupTimer.control = "start"

end sub

sub hidePopupIndex()
	m.popupIndex.visible = false
end sub

'-----------DOWNLOAD-----------
sub onDownloadError()
	m.errorBox.error = m.downloader.error
end sub


sub onDownloadCompleted()
	m.list = m.downloader.list
	m.listIndex = 0
	m.listSize = m.list.Count()
	
	if m.listSize <> 0
		playCurrentIndex()
	end if

end sub



'------------CONNECT-----------
sub getText(obj, default) as String
	if Len(obj.text) < 1
		return default
	end if
	return obj.text
end sub


sub connect()
	if m.cursor_focused = "connect"
		saveData()

		uri = "http://"
		uri += getText(m.hostInput, "192.168.0.123")
		uri += ":"+getText(m.portInput, "4567")
		uri += "/"+getText(m.pathInput, "movie.mp4")

		urlS = "http://"
		urlS += getText(m.hostInputS, "192.168.0.123")
		urlS += ":"+getText(m.portInputS, "4567")
		urlS += "/"+getText(m.pathInputS, "subtitle.srt")


		m.downloader.error = ""
		m.downloader.uri = uri
		m.downloader.control = "run"
		
		setSubtitle(urlS)
	end if

end sub



'------------GO TO-------------
sub goPrev()
	if m.listSize = 0
		return
	end if

	if m.listIndex = 0
		m.listIndex = m.listSize-1
	else
		m.listIndex = m.listIndex-1
	end if

	playCurrentIndex()
end sub


sub goNext()
	if m.listSize = 0
		return
	end if

	if m.listIndex = m.listSize-1
		m.listIndex = 0
	else
		m.listIndex = m.listIndex+1
	end if

	playCurrentIndex()
end sub





'--------------SET SUBTITLE AND VIDEO URL AND PLAY---------
sub playCurrentIndex()
	url=m.list[m.listIndex]
	m.videoContent.url = url
	playMovie()
	showPopupIndex()
end sub


sub playMovie()
	m.video.visible = true
	m.video.content = m.videoContent
	m.video.setFocus(true)
	m.video.control = "play"
	m.movie_focus = true

end sub

sub stopMovie()
	m.video.control = "stop"
	m.video.setFocus(false)
	m.video.content = ""
	m.top.setFocus(true)
	m.movie_focus = false
	m.video.visible = false
	m.listSize = 0
end sub

sub setSubtitle(url)
	m.videoContent.SubtitleTracks = [
	{ 
		TrackName: url, 
		Language:"eng", 
		Description:"English" 
	}]
end sub





sub handleInput(key) as Boolean
	if key = "left"
		moveCursorLeft()
	elseif key = "right"
		moveCursorRight()
	elseif key = "OK"
		setKeyboardFocus()
		connect()
	elseif key = "up"
		if m.keyboard_focus
			removeCursorFocus()
		else
			moveCursorUp()
		end if
	else if key = "down"
		if not m.keyboard_focus
			moveCursorDown()
		end if
	elseif key = "back"
		removeCursorFocus()
	else
		return false
	end if
	return true
end sub



function onKeyEvent(key as String, press as Boolean) as Boolean
	if press then
		if not m.movie_focus
			return handleInput(key)
		elseif key = "channelup"
			goNext()
	  elseif key = "channeldown"
			goPrev()
		elseif key = "back"
			stopMovie()
			return true
		end if

	end if	

  return false
end function


