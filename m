From: Glen Coakley <gcoakley@mqsoftware.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: FW: Bash Prompt Here?
Date: Mon, 23 Apr 2001 13:44:00 -0000
Message-id: <E1B42CFD544FD31193EE0000E87C5CE799B51E@mailserver2.mqsoftware.com>
X-SW-Source: 2001-q2/msg00137.html

I have updated my version of this to incorporate Ross Smith's .inf idea,
thus allowing it to be used on Windows <whatever>. There is also an install
script that will locate your cygwin root directory. It does not run bash
twice like Ross' solution but it does require changes to our .bashrc but it
wraps them in an 'if cygwin' check so that they will only be invoked if you
are running under cygwin. (I share my .bashrc with my Unix box.) The changes
are also designed to insulate you from cygwin upgrades by not modifying any
of the distributed files nor making any assumptions about them except for
the existence of certain tools (regtool, cygpath, cut, cat, grep, sed and,
of course bash).

http://www.users.qwest.net/~weissj/BashPromptHere.tar.gz

________________________________
Glen Coakley, Sr. Software Engineer
MQSoftware Inc., (763) 543-4845
