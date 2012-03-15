%%%%%%%%%%%%%TRON%%%%%%%%%%%%%
%%%%%%%%%VERSION 8.6%%%%%%%%%%
%By: Alex Kidd & Ryan Frohlich

%%%%%%%%%%SETUP GAME%%%%%%%%%%
import GUI
setscreen ("graphics:950;650,offscreenonly,nocursor")
colorback (black)
colour (brightgreen)
randomize
cls

var compleft : int := 0
var continue : boolean := false
var speed : int := 10
var time3 : string
var time1, time2 : int
var teamint : int
var font1 : int := Font.New ("serif:12")
var font2 : int := Font.New ("serif:40")
var font3 : int := Font.New ("Palatino:15")
var font4 : int := Font.New ("serif:118")
var z : int := 398
var upwall, downwall, leftwall, rightwall, farup, fardown, farleft, farright : boolean := false
var slider, sliderb, text, numteam : array 1 .. 4 of int
var slider2, slider3, slider4, slider5, button, button2, checkbox, checkbox2, checkbox3, checkbox4,
    radio1, radio2, radio3, radio4, radio5, radio6, textbox, helpbox : int
var teamgame : boolean
var key : array char of boolean
var players : int := 4
var computers : int := 0
var remaining : int := 4
var teams : int := 0
var winner : string
var alive, hit : flexible array 1 .. players of boolean
var compalive, comphit : array 1 .. 20 of boolean
var player, explode : flexible array 1 .. players of string
var computer, compexplode : array 1 .. 20 of string
var x, y, col : flexible array 1 .. players of int
var size : flexible array 1 .. players of real
var compsize : flexible array 1 .. 20 of real
var compx, compy, compcol, changedir : flexible array 1 .. 20 of int
var teamleft, team, teamcol, teamcomps, compteam, teamplace : flexible array 0 .. 20 of int
var minu, sec, randdir : int := 0
var null : string (1)
var tie : boolean
var usedcomps : int
var ai : string := 'smart'
var turboactive : boolean := false
var turbolength : int := 75
var turboused : array 1 .. 4 of boolean
var turboleft : array 1 .. 4 of real
var infinite : boolean := false
var dirdelay : array 1 .. 4 of int
var pscore : array 1 .. 4 of int
var cscore : array 1 .. 20 of int
var tscore : flexible array 0 .. 20 of int
var place : array 1 .. 24 of int
var placename : array 1 .. 24 of string
var explodesize : real := 5
var sidewalls, watchcomps : boolean := true
var xfill, yfill : int
var compsleft, playersleft, totalteams, placecounter : int

col (1) := 41
col (2) := 47
col (3) := 55
col (4) := yellow
for i : 1 .. 4
    pscore (i) := 0
end for
for i : 1 .. 20
    cscore (i) := 0
end for
for i : 0 .. 20
    tscore (i) := 0
    team (i) := 0
    teamleft (i) := 0
    teamcomps (i) := 0
end for

procedure variables
    for i : 1 .. 20
	compexplode (i) := ' '
	randint (randdir, 1, 4)
	if randdir = 1 then
	    computer (i) := 'up'
	elsif randdir = 2 then
	    computer (i) := 'down'
	elsif randdir = 3 then
	    computer (i) := 'left'
	else
	    computer (i) := 'right'
	end if
	compalive (i) := false
	changedir (i) := 50
	compcol (i) := white
	comphit (i) := false
	compteam (i) := 0
    end for
    for i : 1 .. 17 by 4
	compx (i) := 175 + (28 * i)
	compy (i) := 200
	compx (i + 1) := (maxx - 175) - (28 * i)
	compy (i + 1) := maxy - 180
	compx (i + 2) := maxx - 203
	compy (i + 2) := 182 + (14 * i)
	compx (i + 3) := 203
	compy (i + 3) := (maxy - 165) - (14 * i)
    end for
    for i : 1 .. players
	turboused (i) := true
	turboleft (i) := turbolength
	explode (i) := ' '
	alive (i) := false
	hit (i) := false
	dirdelay (i) := 12
    end for
    teamcol (0) := white
    player (1) := "up"
    player (2) := "right"
    player (3) := "left"
    player (4) := "down"
    x (1) := 50
    y (1) := 50
    x (2) := 50
    y (2) := 600
    x (3) := 850
    y (3) := 50
    x (4) := 850
    y (4) := 600
    tie := true
    sec := 0
    minu := 0
end variables
variables

procedure procbutton
    continue := true
end procbutton

procedure splash
    var x1, x2, y1, y2 : int := 0
    for i : 1 .. 317 by 2
	y1 := i
	y2 := i
	drawfilloval (50, y1, 5, 5, 41)
	drawfilloval (50, maxy - y2, 5, 5, 47)
	View.Update
    end for
    for i : 1 .. 400 by 2
	x1 := 50 + i
	x2 := 50 + i
	drawfilloval (x1, 317, 5, 5, 41)
	drawfilloval (x2, maxy - 317, 5, 5, 47)
	View.Update
    end for
    for i : 1 .. 50 by 2
	x1 := x1 + 4
	x2 := x2 + 2
	drawfilloval (x1 - 1, 317, 5, 5, 41)
	drawfilloval (x1, 317, 5, 5, 41)
	drawfilloval (x2, maxy - 317, 5, 5, 47)
	View.Update
    end for
    for i : 1 .. 35 by 2
	y1 := y1 + 4
	x2 := x2 + 2
	drawfilloval (x1, y1 - 1, 5, 5, 41)
	drawfilloval (x1, y1, 5, 5, 41)
	drawfilloval (x2, maxy - 317, 5, 5, 47)
	View.Update
    end for
    drawfill (50, maxy - 5, black, black)
    for i : 1 .. 5 by 2
	x1 := x1 + 2
	drawfilloval (x1, y1, 5, 5, 41)
	drawfilloval (x2, maxy - y2, i, i, i)
	View.Update
    end for
    drawfilloval (x2, maxy - y2, 5, 5, black)
    for decreasing i : 5 .. 0 by 2
	x1 := x1 + 2
	drawfilloval (x1, y1, 5, 5, 41)
	drawfilloval (x2, maxy - 317, i, i, i)
	View.Update
	drawfilloval (x2, maxy - 317, i, i, black)
    end for
    for i : 1 .. 400 by 2
	x1 := x1 + 2
	drawfilloval (x1, y1, 5, 5, 41)
	View.Update
    end for
    Font.Draw ("TRON", 95, maxy - 318, font4, darkgrey)
    Font.Draw ("TRON", 90, maxy - 313, font4, grey)
    View.Update
    delay (1000)
    Font.Draw ("By: Alex Kidd", 572, maxy - 320, font2, grey)
    View.Update
    button := GUI.CreateButton (400, 50, 0, "Continue", procbutton)
    View.Update
    loop
	exit when GUI.ProcessEvent or continue = true
    end loop
    GUI.Dispose (button)
    continue := false
    cls
end splash

procedure help
    Font.Draw ("TRON", 375, maxy - 75, font2, darkgrey)
    Font.Draw ("TRON", 372, maxy - 72, font2, grey)
    Font.Draw ("Instructions", 320, maxy - 132, font2, brightblue)
    helpbox := GUI.CreateTextBox (250, 200, 400, 250)
    GUI.SetScrollOnAdd (helpbox, false)
    GUI.AddLine (helpbox, "                            GAME PLAY INFORMATION")
    GUI.AddLine (helpbox, " ")
    GUI.AddLine (helpbox, "    PLAYER 1: Use the Arrow Keys                          Ctrl(Turbo)")
    GUI.AddLine (helpbox, "    PLAYER 2: W(Up)   A(Left)   S(Down)   D(Right)  E(Turbo)")
    GUI.AddLine (helpbox, "    PLAYER 3:  I(Up)    J(Left)   K(Down)   L(Right)  O(Turbo)")
    GUI.AddLine (helpbox, "    PLAYER 4:  5(Up)    1(Left)   2(Down)    3(Right)   6(Turbo)")
    GUI.AddLine (helpbox, " ")
    GUI.AddLine (helpbox, "                  PLAYER 4 USES THE NUM PAD")
    GUI.AddLine (helpbox, "      IF YOU USE PLAYER 4 YOU NEED TO HAVE THE,")
    GUI.AddLine (helpbox, "                 NUM LOCK ON FOR IT TO WORK")
    GUI.AddLine (helpbox, "       Turbo can only be used if activated on settings page.")
    GUI.AddLine (helpbox, " ")
    GUI.AddLine (helpbox, "When you move you leave a trail that is the same color as your cycle.")
    GUI.AddLine (helpbox, "  If you hit your oppenents trail or your own trail then you will die.")
    GUI.AddLine (helpbox, "              The winner is the last player or team alive.")

    button := GUI.CreateButton (400, 50, 0, "Continue", procbutton)
    View.Update
    loop
	exit when GUI.ProcessEvent or continue = true
    end loop
    GUI.Dispose (button)
    continue := false
    cls
end help

procedure procslider3 (value : int)
    computers := value
    drawfillbox (649, 100, 680, 130, black)
    Font.Draw (intstr (value), 650, 105, font1, grey)
end procslider3

procedure procslider4 (value : int)
    speed := value
end procslider4

procedure procslider5 (value : int)
    explodesize := value
end procslider5

procedure proccheck (status : boolean)
    for i : 1 .. 4
	GUI.Hide (text (i))
    end for
    drawfillbox (220, 245, 260, 430, black)
    if status = true then
	teamgame := true
	for i : 1 .. players
	    GUI.Show (text (i))
	end for
    else
	teamgame := false
    end if
end proccheck

procedure procslider2 (value : int)
    if value >= 2 then
	Font.Draw ("Player 2", 280, 353, font1, brightgreen)
	GUI.Show (slider (2))
	drawfilloval (568, 355, 5, 5, col (2))
    else
	GUI.Hide (slider (2))
	drawfillbox (280, 345, 580, 380, black)
    end if
    if value >= 3 then
	Font.Draw ("Player 3", 280, 303, font1, brightgreen)
	GUI.Show (slider (3))
	drawfilloval (568, 305, 5, 5, col (3))
    else
	GUI.Hide (slider (3))
	drawfillbox (280, 295, 580, 330, black)
    end if
    if value >= 4 then
	Font.Draw ("Player 4", 280, 253, font1, brightgreen)
	GUI.Show (slider (4))
	drawfilloval (568, 255, 5, 5, col (4))
    else
	GUI.Hide (slider (4))
	drawfillbox (280, 245, 580, 280, black)
    end if
    players := value
    if GUI.GetCheckBox (checkbox) = true then
	proccheck (true)
    else
	proccheck (false)
    end if
end procslider2

procedure procslider (value : int)
    if GUI.GetEventWidgetID = slider (1) then
	drawfilloval (568, 405, 5, 5, value)
	col (1) := value
    elsif GUI.GetEventWidgetID = slider (2) then
	drawfilloval (568, 355, 5, 5, value)
	col (2) := value
    elsif GUI.GetEventWidgetID = slider (3) then
	drawfilloval (568, 305, 5, 5, value)
	col (3) := value
    elsif GUI.GetEventWidgetID = slider (4) then
	drawfilloval (568, 255, 5, 5, value)
	col (4) := value
    end if
end procslider

procedure proctext (textinput : string)
    for i : 1 .. 4
	if GUI.GetEventWidgetID = text (i) then
	    team (i) := strint (textinput)
	end if
    end for
end proctext

procedure procradio
    if GUI.GetEventWidgetID = radio1 then
	ai := 'smart'
    else
	ai := 'dumb'
    end if
end procradio

procedure proccheck2 (status : boolean)
    if status = true then
	turboactive := true
	drawfillbox (690, 70, 830, 180, white)
	drawbox (690, 70, 830, 180, brightgreen)
	Font.Draw ("Turbo Length", 700, 160, font3, black)
	GUI.Show (radio3)
	GUI.Show (radio4)
	GUI.Show (radio5)
	GUI.Show (radio6)
    else
	turboactive := false
	GUI.Hide (radio3)
	GUI.Hide (radio4)
	GUI.Hide (radio5)
	GUI.Hide (radio6)
	drawfillbox (690, 70, 840, 180, black)
    end if
end proccheck2

procedure proccheck3 (status : boolean)
    if status = true then
	sidewalls := false
    else
	sidewalls := true
    end if
end proccheck3

procedure proccheck4 (status : boolean)
    if status = true then
	watchcomps := false
    else
	watchcomps := true
    end if
end proccheck4

procedure procradio2
    if GUI.GetEventWidgetID = radio3 then
	infinite := true
    else
	infinite := false
    end if
    if GUI.GetEventWidgetID = radio4 then
	turbolength := 300
    elsif GUI.GetEventWidgetID = radio5 then
	turbolength := 150
    elsif GUI.GetEventWidgetID = radio6 then
	turbolength := 70
    end if
    for i : 1 .. 4
	turboleft (i) := turbolength
    end for
end procradio2

procedure settings
    Font.Draw ("TRON", 375, maxy - 75, font2, darkgrey)
    Font.Draw ("TRON", 372, maxy - 72, font2, grey)
    Font.Draw ("Settings", 360, maxy - 132, font2, brightblue)
    slider4 := GUI.CreateVerticalScrollBar (130, 100, 300, 0, 50, 5, procslider4)
    Font.Draw ("Speed", 150, 260, font1, brightgreen)
    Font.Draw ("Slow", 150, 370, font1, darkgrey)
    Font.Draw ("Fast", 150, 120, font1, darkgrey)

    slider5 := GUI.CreateVerticalScrollBar (30, 100, 300, 5, 50, 5, procslider5)
    Font.Draw ("Explosion", 50, 260, font1, brightgreen)
    Font.Draw ("Size", 68, 240, font1, brightgreen)
    Font.Draw ("Large", 50, 370, font1, darkgrey)
    Font.Draw ("Small", 50, 120, font1, darkgrey)

    Font.Draw ("# of Players", 240, 140, font1, brightgreen)
    slider2 := GUI.CreateHorizontalScrollBar (230, 100, 100, 1, 4, 2, procslider2)
    Font.Draw ("# of Computers", 543, 140, font1, brightgreen)
    slider3 := GUI.CreateHorizontalScrollBar (540, 100, 100, 0, 20, 0, procslider3)
    drawfillbox (690, 290, 830, 380, white)
    drawbox (688, 288, 832, 382, brightgreen)
    Font.Draw ("Computer AI", 700, 360, font3, black)
    radio1 := GUI.CreateRadioButton (700, 327, "Less Stupid", 0, procradio)
    radio2 := GUI.CreateRadioButton (700, 300, "Stupid", radio1, procradio)
    z := 398
    for i : 1 .. 4
	text (i) := GUI.CreateTextField (230, z, 20, '1', proctext)
	z := z - 50
    end for
    Font.Draw ("Team Game", 390, 105, font1, brightgreen)
    checkbox := GUI.CreateCheckBox (370, 105, "", proccheck)
    Font.Draw ("Player 1", 280, 403, font1, brightgreen)
    Font.Draw ("Colour", 445, 430, font1, grey)
    slider (1) := GUI.CreateHorizontalScrollBar (400, 398, 150, 25, maxcol, 40, procslider)
    drawfilloval (568, 405, 5, 5, col (1))
    slider (2) := GUI.CreateHorizontalScrollBar (400, 348, 150, 25, maxcol, 47, procslider)
    slider (3) := GUI.CreateHorizontalScrollBar (400, 298, 150, 25, maxcol, 55, procslider)
    slider (4) := GUI.CreateHorizontalScrollBar (400, 248, 150, 25, maxcol, 31, procslider)
    button := GUI.CreateButton (400, 50, 0, "Continue", procbutton)
    checkbox2 := GUI.CreateCheckBox (700, 200, "", proccheck2)
    Font.Draw ("Activate Turbo", 720, 200, font1, brightgreen)
    checkbox3 := GUI.CreateCheckBox (700, 250, "", proccheck3)
    Font.Draw ("Disable Side Walls", 720, 250, font1, brightgreen)
    checkbox4 := GUI.CreateCheckBox (700, 225, "", proccheck4)
    Font.Draw ("Stop When No Humans Left", 720, 225, font1, brightgreen)
    radio5 := GUI.CreateRadioButton (730, 100, "Medium", 0, procradio2)
    radio3 := GUI.CreateRadioButton (730, 140, "Infinite", radio5, procradio2)
    radio4 := GUI.CreateRadioButton (730, 120, "Long", radio3, procradio2)
    radio6 := GUI.CreateRadioButton (730, 80, "Short", radio4, procradio2)
    procslider2 (2)
    procslider3 (0)
    proccheck2 (false)
    setscreen ('nooffscreenonly')
    loop
	var xmouse, ymouse, mousebutton : int
	mousewhere (xmouse, ymouse, mousebutton)
	if xmouse > maxx - 20 and xmouse < maxx and ymouse > maxy - 20 and ymouse < maxy and mousebutton not= 0 then
	    GUI.SetSliderMinMax (slider5, 5, 150)
	    Font.Draw ("Large", 50, 203, font1, darkgrey)
	    drawfillbox (49, 362, 90, 380, black)
	    Font.Draw ("HUGE", 50, 370, font1, darkgrey)
	    Font.Draw ("Explosion Size Scrollbar Modified", 340, maxy - 20, font1, darkgrey)
	end if
	exit when GUI.ProcessEvent
	if continue = true then
	    if teamgame = true then
		for i : 1 .. players
		    if (strint (GUI.GetText (text (i)))) < 1 then
			continue := false
			Font.Draw ("Team Number must be 1 or greater!!!", 340, 10, font1, darkgrey)
		    end if
		end for
	    end if
	    for i : 1 .. players - 1
		for i2 : 2 .. players
		    if col (i) = col (i2) and i not=i2 then
			continue := false
			Font.Draw ("Can't have Two or more players with same color!!!", 300, 30, font1, darkgrey)
		    end if
		end for
	    end for
	end if
	exit when continue = true
    end loop
    setscreen ('offscreenonly')
    continue := false

    if teamgame = true then
	if computers not= 0 then
	    teams := teams + 1
	end if
	for i : 1 .. players
	    team (i) := (strint (GUI.GetText (text (i))))
	    teamint := team (i)
	    if teamint > upper (teamleft) then
		z := upper (teamleft) + 1
		new teamleft, teamint
		new teamcomps, teamint
		for i2 : 0 .. upper (teamcomps)
		    teamcomps (i2) := 0
		end for
		for i2 : z .. upper (teamleft)
		    teamleft (i2) := 0
		end for
		new teamcol, teamint
		new tscore, teamint
		new teamplace, teamint
		tscore (teamint) := 0
	    end if
	    if teamleft (teamint) = 0 then
		teams := teams + 1
	    end if
	    teamleft (teamint) := teamleft (teamint) + 1
	end for
    end if

    for i : 1 .. 4
	GUI.Dispose (slider (i))
	GUI.Dispose (text (i))
    end for
    GUI.Dispose (slider2)
    GUI.Dispose (slider3)
    GUI.Dispose (slider4)
    GUI.Dispose (checkbox)
    GUI.Dispose (button)
    GUI.Dispose (radio1)
    GUI.Dispose (radio2)

    remaining := players + computers
    compsleft := computers
    playersleft := players
    cls
end settings

procedure procteam (value : int)
    if GUI.GetEventWidgetID = slider (1) then
	drawoval (568, 405, 5, 5, value)
	teamcol (numteam (1)) := value
    elsif GUI.GetEventWidgetID = slider (2) then
	drawoval (568, 355, 5, 5, value)
	teamcol (numteam (2)) := value
    elsif GUI.GetEventWidgetID = slider (3) then
	drawoval (568, 305, 5, 5, value)
	teamcol (numteam (3)) := value
    elsif GUI.GetEventWidgetID = slider (4) then
	drawoval (568, 255, 5, 5, value)
	teamcol (numteam (4)) := value
    end if
end procteam

procedure procteamcomp (value : int)
    for i : 1 .. z
	if GUI.GetEventWidgetID = sliderb (i) then
	    teamcomps (numteam (i)) := value
	    compleft := computers
	    for i2 : 1 .. z
		compleft := compleft - teamcomps (numteam (i2))
	    end for
	    drawfillbox (799, 200, 900, 500, black)
	    for i2 : 1 .. z
		GUI.SetSliderMinMax (sliderb (i2), 0, teamcomps (numteam (i2)) + compleft)
		Font.Draw (intstr (teamcomps (numteam (i2))), 800, 450 - (50 * i2), font1, darkgrey)
	    end for
	end if
    end for
end procteamcomp

procedure teamsetup
    Font.Draw ("TRON", 375, maxy - 75, font2, darkgrey)
    Font.Draw ("TRON", 372, maxy - 72, font2, grey)
    Font.Draw ("Team Setup", 320, maxy - 132, font2, brightblue)
    z := 0
    for i : 0 .. upper (teamleft)
	if teamleft (i) > 0 then
	    z := z + 1
	    Font.Draw ("Team", 280, 453 - (50 * z), font1, brightgreen)
	    Font.Draw (intstr (i), 330, 453 - (50 * z), font1, brightgreen)
	    slider (z) := GUI.CreateHorizontalScrollBar (400, 448 - (50 * z), 150, 25, maxcol, z * 27, procteam)
	    sliderb (z) := GUI.CreateHorizontalScrollBar (630, 448 - (50 * z), 150, 0, computers, 0, procteamcomp)
	    teamcol (i) := z * 27
	    drawoval (568, 455 - (50 * z), 5, 5, teamcol (i))
	    numteam (z) := i
	end if
    end for
    Font.Draw ("Team Trail Colour", 415, 430, font1, grey)
    Font.Draw ("# of Computers on Team", 630, 430, font1, grey)
    button := GUI.CreateButton (400, 50, 0, "Continue", procbutton)
    setscreen ('nooffscreenonly')
    loop
	exit when GUI.ProcessEvent or continue = true
    end loop
    setscreen ('offscreenonly')
    for i : 1 .. z
	GUI.Dispose (slider (i))
    end for
    continue := false
    cls

    usedcomps := 1
    for i : 1 .. z
	for i2 : usedcomps .. usedcomps - 1 + teamcomps (numteam (i))
	    compteam (i2) := numteam (i)
	    teamint := compteam (i2)
	    teamleft (teamint) := teamleft (teamint) + 1
	    usedcomps := usedcomps + 1
	end for
    end for
    totalteams := teams
end teamsetup

procedure setup
    for i : 1 .. players
	alive (i) := true
    end for
    for i : 1 .. computers
	compalive (i) := true
    end for
end setup

%%%%%%%%%%GAME PROCEDURES%%%%%%%%%%
procedure back
    if sidewalls = true then
	drawfillbox (0, 0, maxx, 15, brightblue)
	drawfillbox (0, 0, 15, maxy, brightblue)
	drawfillbox (0, maxy - 15, maxx, maxy, brightblue)
	drawfillbox (maxx - 15, 0, maxx, maxy, brightblue)
    end if
end back

procedure draw
    for i : 1 .. players
	if alive (i) = true then
	    drawfilloval (x (i), y (i), 5, 5, col (i))
	    if teamgame = true then
		drawoval (x (i), y (i), 5, 5, teamcol (team (i)))
	    end if
	end if
    end for
    for i : 1 .. computers
	if compalive (i) = true then
	    drawfilloval (compx (i), compy (i), 5, 5, compcol (i))
	    if teamgame = true then
		drawoval (compx (i), compy (i), 5, 5, teamcol (compteam (i)))
	    end if
	end if
    end for
end draw

procedure turbomove (i : int)
    if alive (i) = true then
	if player (i) = 'up' then
	    y (i) := y (i) + 1
	elsif player (i) = 'down' then
	    y (i) := y (i) - 1
	elsif player (i) = 'left' then
	    x (i) := x (i) - 1
	elsif player (i) = 'right' then
	    x (i) := x (i) + 1
	end if
    end if
end turbomove

procedure pmove
    for i : 1 .. players
	if alive (i) = true then
	    if player (i) = 'up' then
		y (i) := y (i) + 1
		if y (i) >= maxy + 4 then
		    y (i) := -4
		end if
	    elsif player (i) = 'down' then
		y (i) := y (i) - 1
		if y (i) <= -4 then
		    y (i) := maxy + 4
		end if
	    elsif player (i) = 'left' then
		x (i) := x (i) - 1
		if x (i) <= -4 then
		    x (i) := maxx + 4
		end if
	    elsif player (i) = 'right' then
		x (i) := x (i) + 1
		if x (i) >= maxx + 4 then
		    x (i) := -4
		end if
	    end if
	end if
    end for
end pmove

procedure compmove
    for i : 1 .. computers
	if compalive (i) = true then
	    if computer (i) = 'up' then
		compy (i) := compy (i) + 1
		if compy (i) >= maxy + 4 then
		    compy (i) := -4
		end if
	    elsif computer (i) = 'down' then
		compy (i) := compy (i) - 1
		if compy (i) <= -4 then
		    compy (i) := maxy + 4
		end if
	    elsif computer (i) = 'left' then
		compx (i) := compx (i) - 1
		if compx (i) <= -4 then
		    compx (i) := maxx + 4
		end if
	    elsif computer (i) = 'right' then
		compx (i) := compx (i) + 1
		if compx (i) >= maxx + 4 then
		    compx (i) := -4
		end if
	    end if
	end if
    end for
end compmove

procedure dirp1
    Input.KeyDown (key)
    if dirdelay (1) = 12 then
	if key (KEY_UP_ARROW) and player (1) not= 'down' then
	    player (1) := 'up'
	    dirdelay (1) := 0
	elsif key (KEY_DOWN_ARROW) and player (1) not= 'up' then
	    player (1) := 'down'
	    dirdelay (1) := 0
	elsif key (KEY_LEFT_ARROW) and player (1) not= 'right' then
	    player (1) := 'left'
	    dirdelay (1) := 0
	elsif key (KEY_RIGHT_ARROW) and player (1) not= 'left' then
	    player (1) := 'right'
	    dirdelay (1) := 0
	end if
    end if
    if dirdelay (1) < 12 then
	dirdelay (1) := dirdelay (1) + 1
    end if
    if turboactive = true then
	if key (KEY_CTRL) and turboused (1) = true then
	    if infinite = false then
		turboleft (1) := turboleft (1) - 1
	    end if
	    turbomove (1)
	    draw
	    if turboleft (1) = 0 then
		turboused (1) := false
	    end if
	else
	    if turboleft (1) < turbolength then
		turboleft (1) := turboleft (1) + 0.5
		if turboleft (1) = turbolength then
		    turboused (1) := true
		end if
	    end if
	end if
    end if
end dirp1

procedure dirp2
    Input.KeyDown (key)
    if dirdelay (2) = 12 then
	if key ('w') and player (2) not= 'down' then
	    player (2) := 'up'
	    dirdelay (2) := 0
	elsif key ('s') and player (2) not= 'up' then
	    player (2) := 'down'
	    dirdelay (2) := 0
	elsif key ('a') and player (2) not= 'right' then
	    player (2) := 'left'
	    dirdelay (2) := 0
	elsif key ('d') and player (2) not= 'left' then
	    player (2) := 'right'
	    dirdelay (2) := 0
	end if
    end if
    if dirdelay (2) < 12 then
	dirdelay (2) := dirdelay (2) + 1
    end if
    if turboactive = true then
	if key ('e') then
	    if turboused (2) = true then
		if infinite = false then
		    turboleft (2) := turboleft (2) - 1
		end if
		turbomove (2)
		draw
		if turboleft (2) = 0 then
		    turboused (2) := false
		end if
	    end if
	else
	    if turboleft (2) < turbolength then
		turboleft (2) := turboleft (2) + 0.5
		if turboleft (2) = turbolength then
		    turboused (2) := true
		end if
	    end if
	end if
    end if
end dirp2

procedure dirp3
    Input.KeyDown (key)
    if dirdelay (3) = 12 then
	if key ('i') and player (3) not= 'down' then
	    player (3) := 'up'
	    dirdelay (3) := 0
	elsif key ('k') and player (3) not= 'up' then
	    player (3) := 'down'
	    dirdelay (3) := 0
	elsif key ('j') and player (3) not= 'right' then
	    player (3) := 'left'
	    dirdelay (3) := 0
	elsif key ('l') and player (3) not= 'left' then
	    player (3) := 'right'
	    dirdelay (3) := 0
	end if
    end if
    if dirdelay (3) < 12 then
	dirdelay (3) := dirdelay (3) + 1
    end if
    if turboactive = true then
	if key ('o') and turboused (3) = true then
	    if infinite = false then
		turboleft (3) := turboleft (3) - 1
	    end if
	    turbomove (3)
	    draw
	    if turboleft (3) = 0 then
		turboused (3) := false
	    end if
	else
	    if turboleft (3) < turbolength then
		turboleft (3) := turboleft (3) + 0.5
		if turboleft (3) = turbolength then
		    turboused (3) := true
		end if
	    end if
	end if
    end if
end dirp3

procedure dirp4
    Input.KeyDown (key)
    if dirdelay (4) = 12 then
	if key ('5') and player (4) not= 'down' then
	    player (4) := 'up'
	    dirdelay (4) := 0
	elsif key ('2') and player (4) not= 'up' then
	    player (4) := 'down'
	    dirdelay (4) := 0
	elsif key ('1') and player (4) not= 'right' then
	    player (4) := 'left'
	    dirdelay (4) := 0
	elsif key ('3') and player (4) not= 'left' then
	    player (4) := 'right'
	    dirdelay (4) := 0
	end if
    end if
    if dirdelay (4) < 12 then
	dirdelay (4) := dirdelay (4) + 1
    end if
    if turboactive = true then
	if key ('6') and turboused (4) = true then
	    if infinite = false then
		turboleft (4) := turboleft (4) - 1
	    end if
	    turbomove (4)
	    draw
	    if turboleft (4) = 0 then
		turboused (4) := false
	    end if
	else
	    if turboleft (4) < turbolength then
		turboleft (4) := turboleft (4) + 0.5
		if turboleft (4) = turbolength then
		    turboused (4) := true
		end if
	    end if
	end if
    end if
end dirp4

procedure compdir
    if ai = 'dumb' then
	for i : 1 .. computers
	    if compalive (i) = true then
		upwall := false
		downwall := false
		leftwall := false
		rightwall := false
		changedir (i) := changedir (i) + 1
		if whatdotcolor (compx (i) + 8, compy (i) + 12) not= black
			or whatdotcolor (compx (i) - 8, compy (i) + 12) not= black
			or whatdotcolor (compx (i), compy (i) + 13) not= black then
		    if computer (i) = 'up' then
			changedir (i) := 100
		    end if
		    upwall := true
		end if
		if whatdotcolor (compx (i) + 12, compy (i) + 8) not= black
			or whatdotcolor (compx (i) + 12, compy (i) - 8) not= black
			or whatdotcolor (compx (i) + 13, compy (i)) not= black then
		    if computer (i) = 'right' then
			changedir (i) := 100
		    end if
		    rightwall := true
		end if
		if whatdotcolor (compx (i) + 8, compy (i) - 12) not= black
			or whatdotcolor (compx (i) - 8, compy (i) - 12) not= black
			or whatdotcolor (compx (i), compy (i) - 13) not= black then
		    if computer (i) = 'down' then
			changedir (i) := 100
		    end if
		    downwall := true
		end if
		if whatdotcolor (compx (i) - 12, compy (i) + 8) not= black
			or whatdotcolor (compx (i) - 12, compy (i) - 8) not= black
			or whatdotcolor (compx (i) - 13, compy (i)) not= black then
		    if computer (i) = 'left' then
			changedir (i) := 100
		    end if
		    leftwall := true
		end if

		if upwall = true and downwall = true then
		    if computer (i) = 'left' or computer (i) = 'right' then
			changedir (i) := 0
		    end if
		elsif leftwall = true and rightwall = true then
		    if computer (i) = 'up' or computer (i) = 'down' then
			changedir (i) := 0
		    end if
		elsif upwall = true and rightwall = true then
		    if computer (i) = 'right' or computer (i) = 'up' then
			if computer (i) = 'right' then
			    computer (i) := 'down'
			elsif computer (i) = 'up' then
			    computer (i) := 'left'
			end if
			changedir (i) := 0
		    end if
		elsif downwall = true and rightwall = true then
		    if computer (i) = 'down' or computer (i) = 'right' then
			if computer (i) = 'down' then
			    computer (i) := 'left'
			elsif computer (i) = 'right' then
			    computer (i) := 'up'
			end if
			changedir (i) := 0
		    end if
		elsif upwall = true and leftwall = true then
		    if computer (i) = 'up' or computer (i) = 'left' then
			if computer (i) = 'up' then
			    computer (i) := 'right'
			elsif computer (i) = 'left' then
			    computer (i) := 'down'
			end if
			changedir (i) := 0
		    end if
		elsif downwall = true and leftwall = true then
		    if computer (i) = 'down' or computer (i) = 'left' then
			if computer (i) = 'down' then
			    computer (i) := 'right'
			elsif computer (i) = 'left' then
			    computer (i) := 'up'
			end if
			changedir (i) := 0
		    end if
		end if

		if changedir (i) >= 100 then
		    farleft := true
		    farright := true
		    farup := true
		    fardown := true
		    if whatdotcolor (compx (i) - 25, compy (i)) = black then
			farleft := false
		    end if
		    if whatdotcolor (compx (i) + 25, compy (i)) = black then
			farright := false
		    end if
		    if whatdotcolor (compx (i), compy (i) + 25) = black then
			farup := false
		    end if
		    if whatdotcolor (compx (i), compy (i) - 25) = black then
			fardown := false
		    end if
		    randint (randdir, 1, 2)
		    if computer (i) = 'up' or computer (i) = 'down' then
			if farleft = false and farright = false or farleft = true and farright = true then
			    if randdir = 1 and leftwall = false then
				computer (i) := 'left'
			    elsif randdir = 2 and rightwall = false then
				computer (i) := 'right'
			    end if
			elsif farleft = false then
			    computer (i) := 'left'
			elsif farright = false then
			    computer (i) := 'right'
			end if
		    elsif computer (i) = 'left' or computer (i) = 'right' then
			if farup = false and fardown = false or farup = true and fardown = true then
			    if randdir = 1 and upwall = false then
				computer (i) := 'up'
			    elsif randdir = 2 and downwall = false then
				computer (i) := 'down'
			    end if
			elsif farup = false then
			    computer (i) := 'up'
			elsif fardown = false then
			    computer (i) := 'down'
			end if
		    end if
		    changedir (i) := 0
		end if
	    end if
	end for

    elsif ai = 'smart' then
	for i : 1 .. computers
	    if compalive (i) = true then
		changedir (i) := changedir (i) + 1
		if changedir (i) > 20 then
		    randint (changedir (i), 20, 50)
		    changedir (i) := changedir (i) * 2
		end if
		if computer (i) = 'up' then
		    if whatdotcolor (compx (i) + 8, compy (i) + 9) not= black
			    or whatdotcolor (compx (i) - 8, compy (i) + 9) not= black
			    or whatdotcolor (compx (i), compy (i) + 10) not= black then
			changedir (i) := 100
		    end if
		end if
		if computer (i) = 'right' then
		    if whatdotcolor (compx (i) + 9, compy (i) + 8) not= black
			    or whatdotcolor (compx (i) + 9, compy (i) - 8) not= black
			    or whatdotcolor (compx (i) + 10, compy (i)) not= black then
			changedir (i) := 100
		    end if
		end if
		if computer (i) = 'down' then
		    if whatdotcolor (compx (i) + 8, compy (i) - 9) not= black
			    or whatdotcolor (compx (i) - 8, compy (i) - 9) not= black
			    or whatdotcolor (compx (i), compy (i) - 10) not= black then
			changedir (i) := 100
		    end if
		end if
		if computer (i) = 'left' then
		    if whatdotcolor (compx (i) - 9, compy (i) + 8) not= black
			    or whatdotcolor (compx (i) - 9, compy (i) - 8) not= black
			    or whatdotcolor (compx (i) - 10, compy (i)) not= black then
			changedir (i) := 100
		    end if
		end if
		if changedir (i) >= 100 then
		    z := 0
		    upwall := false
		    downwall := false
		    leftwall := false
		    rightwall := false
		    loop
			z := z + 10
			if computer (i) = 'up' or computer (i) = 'down' then
			    if whatdotcolor (compx (i) - z, compy (i)) not= black then
				leftwall := true
			    end if
			    if whatdotcolor (compx (i) + z, compy (i)) not= black then
				rightwall := true
			    end if
			elsif computer (i) = 'left' or computer (i) = 'right' then
			    if whatdotcolor (compx (i), compy (i) + z) not= black then
				upwall := true
			    end if
			    if whatdotcolor (compx (i), compy (i) - z) not= black then
				downwall := true
			    end if
			end if
			exit when upwall = true or downwall = true or leftwall = true or rightwall = true
		    end loop
		    if computer (i) = 'up' or computer (i) = 'down' then
			if leftwall = true and rightwall = true then
			    randint (randdir, 1, 2)
			    if z = 10 then
			    elsif randdir = 1 then
				computer (i) := 'left'
			    else
				computer (i) := 'right'
			    end if
			elsif leftwall = true then
			    computer (i) := 'right'
			elsif rightwall = true then
			    computer (i) := 'left'
			end if
		    else
			if upwall = true and downwall = true then
			    randint (randdir, 1, 2)
			    if z = 10 then
			    elsif randdir = 1 then
				computer (i) := 'up'
			    else
				computer (i) := 'down'
			    end if
			elsif upwall = true then
			    computer (i) := 'down'
			elsif downwall = true then
			    computer (i) := 'up'
			end if
		    end if
		    changedir (i) := 0
		end if
	    end if
	end for
    end if
end compdir

procedure teamnum (died : int)
    teamint := team (died)
    teamleft (teamint) := teamleft (teamint) - 1
    if teamleft (teamint) = 0 then
	tscore (teamint) := tscore (teamint) + ((totalteams) div 2) - teams + 1
	teams := teams - 1
    end if
end teamnum

procedure compteamnum (died : int)
    teamint := compteam (died)
    teamleft (teamint) := teamleft (teamint) - 1
    if teamleft (teamint) = 0 then
	tscore (teamint) := tscore (teamint) + ((totalteams) div 2) - teams + 1
	teams := teams - 1
    end if
end compteamnum

procedure timer
    if sidewalls = true then
	drawfillbox (19, 634, 65, 645, brightblue)
	time1 := Time.Elapsed div 1000
	sec := (time1 - time2) - (60 * minu)
	if sec >= 60 then
	    minu := minu + 1
	end if
	time3 := intstr (minu) + ' : ' + intstr (sec)
	Font.Draw (time3, 20, 635, font1, 0)
    end if
end timer

procedure collision
    for i : 1 .. players
	if alive (i) = true then
	    hit (i) := false
	    if x (i) > maxx - 7 and player (i) = 'right' or y (i) < 7 and player (i) = 'down'
		    or y (i) > maxy - 7 and player (i) = 'up' or x (i) < 7 and player (i) = 'left' then
		dirdelay (i) := -3
	    else
		if whatdotcolor (x (i) + 6, y (i) + 6) not= black then
		    if player (i) = 'up' or player (i) = 'right' then
			hit (i) := true
		    end if
		end if
		if whatdotcolor (x (i) - 6, y (i) + 6) not= black then
		    if player (i) = 'up' or player (i) = 'left' then
			hit (i) := true
		    end if
		end if
		if whatdotcolor (x (i) - 6, y (i) - 6) not= black then
		    if player (i) = 'left' or player (i) = 'down' then
			hit (i) := true
		    end if
		end if
		if whatdotcolor (x (i) + 6, y (i) - 6) not= black then
		    if player (i) = 'right' or player (i) = 'down' then
			hit (i) := true
		    end if
		end if
		if whatdotcolor (x (i), y (i) + 7) not= black and player (i) = 'up' or
			whatdotcolor (x (i), y (i) - 7) not= black and player (i) = 'down' or
			whatdotcolor (x (i) - 7, y (i)) not= black and player (i) = 'left' or
			whatdotcolor (x (i) + 7, y (i)) not= black and player (i) = 'right' then
		    hit (i) := true
		end if
	    end if
	end if
    end for

    for i : 1 .. computers
	if compalive (i) = true then
	    comphit (i) := false
	    if compx (i) > maxx - 7 and computer (i) = 'right' or compy (i) < 7 and computer (i) = 'down'
		    or compy (i) > maxy - 7 and computer (i) = 'up' or compx (i) < 7 and computer (i) = 'left' then
		changedir (i) := -3
	    else
		if whatdotcolor (compx (i) + 6, compy (i) + 6) not= black then
		    if computer (i) = 'up' or computer (i) = 'right' then
			comphit (i) := true
		    end if
		end if
		if whatdotcolor (compx (i) - 6, compy (i) + 6) not= black then
		    if computer (i) = 'up' or computer (i) = 'left' then
			comphit (i) := true
		    end if
		end if
		if whatdotcolor (compx (i) - 6, compy (i) - 6) not= black then
		    if computer (i) = 'left' or computer (i) = 'down' then
			comphit (i) := true
		    end if
		end if
		if whatdotcolor (compx (i) + 6, compy (i) - 6) not= black then
		    if computer (i) = 'right' or computer (i) = 'down' then
			comphit (i) := true
		    end if
		end if
		if whatdotcolor (compx (i), compy (i) + 7) not= black and computer (i) = 'up' or
			whatdotcolor (compx (i), compy (i) - 7) not= black and computer (i) = 'down' or
			whatdotcolor (compx (i) - 7, compy (i)) not= black and computer (i) = 'left' or
			whatdotcolor (compx (i) + 7, compy (i)) not= black and computer (i) = 'right' then
		    comphit (i) := true
		end if
	    end if
	end if
    end for
end collision

procedure dying
    for i : 1 .. players
	if hit (i) = true and alive (i) = true then
	    if explodesize = 5 then
		drawfill (x (i), y (i), black, black)
	    else
		xfill := 0
		yfill := 0
		loop
		    xfill += 8
		    if xfill > maxx then
			yfill += 8
			xfill := 0
		    end if
		    if whatdotcolor (xfill, yfill) = col (i) then
			drawfill (xfill, yfill, black, black)
		    end if
		    exit when yfill > maxy
		end loop
	    end if
	    explode (i) := 'out'
	    size (i) := 0
	    alive (i) := false
	end if
    end for

    for i : 1 .. 20
	if comphit (i) = true and compalive (i) = true then
	    drawfill (compx (i), compy (i), black, black)
	    compexplode (i) := 'out'
	    compsize (i) := 0
	    compalive (i) := false
	end if
    end for
end dying

procedure explosion
    for i : 1 .. players
	if explode (i) = 'out' then
	    size (i) := size (i) + 0.5
	    drawfilloval (x (i), y (i), round (size (i)), round (size (i)), round (size (i)))
	    drawoval (x (i), y (i), round (size (i)), round (size (i)), black)
	    if size (i) >= explodesize then
		explode (i) := 'in'
	    end if
	elsif explode (i) = 'in' then
	    drawfilloval (x (i), y (i), round (size (i)), round (size (i)), black)
	    size (i) := size (i) - 0.1
	    drawfilloval (x (i), y (i), round (size (i)), round (size (i)), round (size (i)))
	    drawoval (x (i), y (i), round (size (i)), round (size (i)), black)
	    if size (i) <= 0 then
		explode (i) := ' '
		if teamgame = true then
		    teamnum (i)
		end if
		remaining := remaining - 1
		playersleft := playersleft - 1
		if remaining <= ((players + computers) div 2) then
		    pscore (i) := pscore (i) + ((players + computers) div 2) - remaining
		end if
	    end if
	end if
    end for

    for i : 1 .. computers
	if compexplode (i) = 'out' then
	    compsize (i) := compsize (i) + 0.5
	    drawfilloval (compx (i), compy (i), round (compsize (i)), round (compsize (i)), round (compsize (i)))
	    drawoval (compx (i), compy (i), round (compsize (i)), round (compsize (i)), black)
	    if compsize (i) >= explodesize then
		compexplode (i) := 'in'
	    end if
	elsif compexplode (i) = 'in' then
	    drawfilloval (compx (i), compy (i), round (compsize (i)), round (compsize (i)), black)
	    compsize (i) := compsize (i) - 0.5
	    drawfilloval (compx (i), compy (i), round (compsize (i)), round (compsize (i)), round (compsize (i)))
	    drawoval (compx (i), compy (i), round (compsize (i)), round (compsize (i)), black)
	    if compsize (i) <= 0 then
		compexplode (i) := ' '
		if teamgame = true then
		    compteamnum (i)
		end if
		remaining := remaining - 1
		compsleft := compsleft - 1
		if remaining <= (players + computers) div 2 then
		    cscore (i) := cscore (i) + ((players + computers) div 2) - remaining
		end if

		if compsleft = 0 and explodesize not= 5 then
		    xfill := 0
		    yfill := 0
		    loop
			xfill += 8
			if xfill > maxx then
			    yfill += 8
			    xfill := 0
			end if
			if whatdotcolor (xfill, yfill) = compcol (i) then
			    drawfill (xfill, yfill, black, black)
			end if
			exit when yfill > maxy
		    end loop
		end if
	    end if
	end if
    end for
end explosion

%%%%%%%%%%RUN GAME%%%%%%%%%%
%splash
%help
settings
if teamgame = true then
    teamsetup
end if

loop
    setup
    back
    draw
    Font.Draw ("3", 450, 330, font2, 0)
    View.Update
    delay (1000)
    drawfillbox (400, 300, 600, 400, black)
    Font.Draw ("2", 450, 330, font2, 0)
    View.Update
    delay (1000)
    drawfillbox (400, 300, 600, 400, black)
    Font.Draw ("1", 450, 330, font2, 0)
    View.Update
    delay (1000)
    drawfillbox (400, 300, 600, 400, black)
    Font.Draw ("GO!!!", 410, 330, font2, 0)
    View.Update
    delay (1000)
    drawfillbox (400, 300, 600, 400, black)
    time2 := Time.Elapsed div 1000

    loop
	if alive (1) = true then
	    dirp1
	end if
	if alive (2) = true then
	    dirp2
	end if
	if alive (3) = true then
	    dirp3
	end if
	if alive (4) = true then
	    dirp4
	end if
	compdir
	pmove
	compmove
	collision
	dying
	explosion
	draw
	back
	timer
	View.Update
	exit when remaining <= 1
	if teamgame = true then
	    exit when teams <= 1
	end if
	if watchcomps = false then
	    exit when playersleft = 0
	end if
	delay (speed)
    end loop

    if watchcomps = false then
	for i : 1 .. computers
	    exit when compsleft = 1
	    if compalive (i) = true then
		if teamgame = true then
		    compteamnum (i)
		end if
		remaining := remaining - 1
		compsleft := compsleft - 1
		compalive (i) := false
		if remaining <= (players + computers) div 2 then
		    cscore (i) := cscore (i) + ((players + computers) div 2) - remaining
		end if
	    end if
	end for
    end if

    if teamgame = true then
	for i : 1 .. players
	    teamint := team (i)
	    if teamleft (teamint) not= 0 then
		winner := 'Team ' + intstr (teamint) + ' Wins!'
		tscore (teamint) := tscore (teamint) + ((totalteams) div 2) - teams + 1
		tie := false
	    end if
	end for
	for i : 1 .. computers
	    teamint := compteam (i)
	    if teamleft (teamint) not= 0 then
		winner := 'Team ' + intstr (teamint) + ' Wins!'
		tscore (teamint) := tscore (teamint) + ((totalteams) div 2) - teams + 1
		tie := false
	    end if
	end for
    else
	for i : 1 .. players
	    if alive (i) = true then
		winner := 'Player ' + intstr (i) + ' Wins!'
		tie := false
		pscore (i) := pscore (i) + ((players + computers) div 2) - remaining + 1
	    end if
	end for
	for i : 1 .. computers
	    if compalive (i) = true then
		winner := 'Computer ' + intstr (i) + ' Wins!'
		tie := false
		cscore (i) := cscore (i) + ((players + computers) div 2) - remaining + 1
	    end if
	end for
    end if
    if tie = true then
	winner := 'Everybody Loses!!!'
    end if

    Font.Draw (winner, 290, 430, font2, brightgreen)
    textbox := GUI.CreateTextBox (300, 160, 300, 200)
    if teamgame = false then
	for i : 1 .. players
	    place (i) := pscore (i)
	    placename (i) := "Player " + intstr (i) + "          |"
	end for
	for i : players + 1 .. computers + players
	    place (i) := cscore (i - players)
	    if i - players < 10 then
		placename (i) := "Computer " + intstr (i - players) + "    |"
	    else
		placename (i) := "Computer " + intstr (i - players) + "  |"
	    end if
	end for
    else
	for i : 1 .. upper (teamplace)
	    teamplace (i) := 0
	end for
	placecounter := 0
	for i2 : 1 .. players
	    teamint := team (i2)
	    teamplace (teamint) := 1
	end for
	for i2 : 1 .. computers
	    teamint := compteam (i2)
	    teamplace (teamint) := 1
	end for
	for i : 0 .. upper (teamplace)
	    if teamplace (i) = 1 then
		placecounter += 1
		place (placecounter) := tscore (i)
		placename (placecounter) := "Team " + intstr (i) + "            |"
	    end if
	end for
    end if
    var tempplace : int
    var tempplacename : string
    if teamgame = false then
	for i : 1 .. players + computers - 1
	    for j : i + 1 .. players + computers
		if place (j) < place (i) then
		    tempplace := place (j)
		    tempplacename := placename (j)
		    place (j) := place (i)
		    placename (j) := placename (i)
		    place (i) := tempplace
		    placename (i) := tempplacename
		end if
	    end for
	end for
    else
	for i : 1 .. totalteams - 1
	    for j : i + 1 .. totalteams
		if place (j) < place (i) then
		    tempplace := place (j)
		    tempplacename := placename (j)
		    place (j) := place (i)
		    placename (j) := placename (i)
		    place (i) := tempplace
		    placename (i) := tempplacename
		end if
	    end for
	end for
    end if

    GUI.AddLine (textbox, "Rank   | Contestant       | Score")
    if teamgame = false then
	z := computers + players
	for decreasing i : players + computers .. 1
	    if computers + players + 1 - z > 9 then
		GUI.AddLine (textbox, intstr (computers + players + 1 - z) + "        |   " + placename (z) + "   " + intstr (place (z)))
	    else
		GUI.AddLine (textbox, intstr (computers + players + 1 - z) + "          |   " + placename (z) + "   " + intstr (place (z)))
	    end if
	    z := z - 1
	end for
    else
	z := totalteams
	for decreasing i : totalteams .. 1
	    if totalteams + 1 - z > 9 then
		GUI.AddLine (textbox, intstr (totalteams + 1 - z) + "        |   " + placename (z) + "   " + intstr (place (z)))
	    else
		GUI.AddLine (textbox, intstr (totalteams + 1 - z) + "          |   " + placename (z) + "   " + intstr (place (z)))
	    end if
	    z := z - 1
	end for
    end if
    button := GUI.CreateButton (400, 50, 0, "Continue", procbutton)
    View.Update
    setscreen ('nooffscreenonly')
    delay (100)
    loop
	if hasch then
	    getch (null)
	end if
	exit when not hasch
    end loop
    loop
	exit when continue=true or GUI.ProcessEvent
    end loop

    continue:=false
    setscreen ('offscreenonly')
    GUI.Dispose (textbox)
    GUI.Dispose (button)
    View.Update
    cls
    variables
    remaining := players + computers
    if teamgame = true then
	teams := 0
	for i : 1 .. players
	    teamint := team (i)
	    teamleft (teamint) := 0
	end for
	for i : 1 .. players
	    teamint := team (i)
	    if teamleft (teamint) = 0 then
		teams := teams + 1
	    end if
	    teamleft (teamint) := teamleft (teamint) + 1
	end for
    end if
end loop
