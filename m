From: Christopher Faylor <cgf@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Mouse support
Date: Mon, 11 Dec 2000 09:36:00 -0000
Message-id: <20001211123552.A1066@redhat.com>
References: <F10D23B02E54D011A0AB0020AF9CEFE999EE92@lynx.ceddec.com>
X-SW-Source: 2000-q4/msg00044.html

On Mon, Dec 11, 2000 at 10:48:12AM -0500, Town, Brad wrote:
>Attached is a patch to fhandler_console.cc that allows enabling and
>disabling the mouse based on ^[[?1000h/l.  It's not perfect, but it works
>well.  Included is a ChangeLog entry.
>
>Also, terribly minor point:  It seems that the mouse code I submitted has
>been included in the CVS sources, but my ChangeLog entry hasn't yet
>appeared.

Sorry.  That was a mistake.  I'll revert the code until I have a chance to
analyze your new patch.

cgf
