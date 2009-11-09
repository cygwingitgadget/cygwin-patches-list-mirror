Return-Path: <cygwin-patches-return-6821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27230 invoked by alias); 9 Nov 2009 13:36:08 -0000
Received: (qmail 27218 invoked by uid 22791); 9 Nov 2009 13:36:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Nov 2009 13:36:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 45B006D41A0; Mon,  9 Nov 2009 14:35:51 +0100 (CET)
Date: Mon, 09 Nov 2009 13:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events
Message-ID: <20091109133551.GA10130@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AF73FEC.2050300@towo.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00152.txt.bz2

On Nov  8 23:02, towo@towo.net wrote:
> Corinna Vinschen schrieb:
> >signed copyright assignment form (http://cygwin.com/assign.txt) in place.
> It's in the envelope.

Cool.

> >Open the console properties dialog and disable QuickEdit.
> I had checked the properties and nothing worked. QuickEdit enabled
> would disable mouse control for applications altogether; it is
> disabled so mouse click and move events can be processed but the
> mouse wheel still scrolls the window instead, on that machine.

Weird.  It works for me.  Andy seems to be right about drivers.  

> >For backward compatibility, I'd prefer if ESC[9m would still do the same.
> >As long as ESC[9m isn't desparately needed for something else...
> I thought there might be this objection as it is in theory an
> incompatible change but it's not in practice since dim mode doesn't
> work anyway; so I think this change towards the standard assignment
> should be done before someone in the future may fix dim mode to work
> after which it would actually be an incompatible change.
> 
> >>* Maybe the escape sequences of shifted function keys should be
> >>modified   to comply with those of the Linux console?
> >Aren't they compatible with xterm?  I don't think it's a terrible good
> >idea to change that.
> No, they are not:
> 
> Linux console
> F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~
> ^[[20~ ^[[21~ ^[[23~ ^[[24~
> shift-F1..F8    ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~ ^[[32~ ^[[33~ ^[[34~
> 
> cygwin console
> F1..F12         ^[[[A ^[[[B ^[[[C ^[[[D ^[[[E ^[[17~ ^[[18~ ^[[19~
> ^[[20~ ^[[21~ ^[[23~ ^[[24~
> shift-F1..F10   ^[[23~ ^[[24~ ^[[25~ ^[[26~ ^[[28~ ^[[29~ ^[[31~
> ^[[32~ ^[[33~ ^[[34~
> [...]
>  Furthermore, xterm and mintty also support
> Control- and Alt-modified F-keys and combinations of the modifiers.
> So if your preference would be to follow xterm here anyway, I would
> welcome this change and provide a patch; I think this change can be
> done without compatibility trouble in "mainstream applications"
> since the shifted F-keys are not listed in the cygwin terminfo
> entry.

Ooookey, if they aren't listed in terminfo anyway, I have no problems
to change them.  But we should stick to following the Linux console,
I guess.

> >Except for one of them, this doesn't work with a german keyboard and
> >german keyboard layout.  In this case, the respective keysequences
> >C+^, C+AltGr+sz, C+AG+8, C+AG+9 return nothing at all.  Only the
> >C+S+- key returns ^_, as expected.
> Thanks Andy for pointing to the part of mintty code handling this.
> However, the whole function there looks too complex for a quick
> copy-paste-patch. Maybe later...

No copy-paste, please.  Mintty is under GPL, so we can't just take
the code, unless Andy gives us explicit permission to do so.

> or Andy might like to factor out
> the mapping part in a way directly reusable for the cygwin console?
> (Or should it be left as is because it's "just the console"...?)

Well, it works in some way.  I played around with ToUnicode over the
weekend, and I didn't get it working as expected.  Take, for instance,
this (simplified):

  if (input_rec.Event.KeyEvent.dwControlKeyState
      & (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
    {
      GetKeyboardState (state);
      state[VK_CONTROL] = state[VK_LCONTROL] = state[VK_RCONTROL] = 0;
      if (ToUnicode (input_rec.Event.KeyEvent.wVirtualKeyCode,
		     input_rec.Event.KeyEvent.wVirtualScanCode,
		     state, wcbuf, 8, 0) > 0)
      	switch (wcbuf[0])
	  {
	  case L'[' ... L'_':
	    got_one = true;
	    break;
	  [...]
	  }
      [...]

When I pressed Strg-^ on a german keyboard layout (left of the "1"
key), I constantly got Ctrl-\ instead of Ctrl-^.  Weird.

> >>  - Pressing something like Alt-ö on a German keyboard leaves an
> >>illegal UTF-8     sequence (the second byte of the respective
> >>sequence) in input, apparently     because Alt-0xC3 is handled
> >>somehow. Don't know, though, whether this is     a cygwin
> >>console issue or maybe a readline issue.
> >Alt is converted to a leading ESC.  I don't know how to fix that for
> >non-ASCII chars, yet.
> For non-ASCII it works fine, thanks to Andy for clarifying; I could

Erm... sorry, but do we really talk about the same?  If you press
Alt-ö, the console generates the sequence ESC 0xc3 0xb6.  That's not
desired so I'm contemplating the idea to skip the keypress if the
resulting multibyte char is > 1 byte.  This restricts ESC-somekey
either to explicit function key sequences (ESC-[-foo, etc), or
to just two byte sequences like ESC-A, ESC-0, ESC-;, etc.

> have checked this myself, even within bash, by simply typing
> Control-V Alt-ö. It does not work however, even for ASCII
> characters, for characters produced with AltGr, e.g. Alt-AltGr-Q
> where AltGr-Q is @ (German keyboard). Andy got this to work in
> mintty (I think with some other subtle trick after I challenged him
> for it IIRC); it does not work in xterm either.

That's potentially too tricky for the current code.  And, whatever
super-duper change we make to this essential console code in future,
let's wait until after 1.7.1, please.

> >>* I intended to implement cursor position reports and noticed
> >>that their   request ESC[6n is already handled in the code; it
> >>does not work, however,   so I started to debug it:
> >This needs some more debugging, I guess.
> Do you have an opinion about my theory that the wrong read-ahead
> buffer is being filled here (stdout vs. stdin)? If so, I still have
> no clue how to proceed; maybe you'd kindly give a hint how to access
> the stdin buffer / stdin fhandler?

I have no opinion yet, since I don't know this part of the code good
enough.  IIUC you think that the readahead buffer of the wrong
fhandle_console is filled, the one connected with stdout, not the
one connected with stdin, right?


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
