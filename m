From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New terminal capability in fhandler_console.cc
Date: Sat, 31 Mar 2001 02:59:00 -0000
Message-id: <20010331125911.C8711@cygbert.vinschen.de>
References: <20010330131541.P16622@cygbert.vinschen.de> <20010330104728.E12718@redhat.com> <20010330192244.X16622@cygbert.vinschen.de> <20010330170201.A29301@redhat.com> <20010331015252.A16622@cygbert.vinschen.de> <20010330193658.F31805@redhat.com> <20010331113118.A8711@cygbert.vinschen.de> <20010331114154.B8711@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00279.html

On Sat, Mar 31, 2001 at 11:41:54AM +0200, Corinna Vinschen wrote:
> BTW, I added some keycodes to the cygwin terminal emulation.
> 
> On xterms, the cursor block and the control key block behave
> slightliy different from what was set in fhandler_console.cc.
> 
> The same keycodes are returned without modifier with shift and
> control keys. With Alt, it returns the keycode with another
> ESC prepended. I have added that behaviour to keytable. That
> allows convenient keybindings like (tcsh):
> 
> 	bindkey "^[^[[D"   word-left
			   s/word-left/backward-word
> 	bindkey "^[^[[C"   word-right
			   s/word-right/forward-word

Corinna
