From: Earnie Boyd <earnie_boyd@yahoo.com>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Setup.exe "other URL" functionality
Date: Fri, 28 Dec 2001 06:39:00 -0000
Message-ID: <3C2C8436.9C672C84@yahoo.com>
References: <NCBBIHCHBLCMLBLOBONKGEBKCIAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00362.html
Message-ID: <20011228063900.OHvngnqvDU3WomfhxKY60m4wpQV17XBcGXMiqrG_sS4@z>

"Gary R. Van Sickle" wrote:
> 
> > Thanks. BTW: If you can identify what made that huge patch (my money is
> > on indent 2.2.7 inserting ^M's)'s that would be handy.
> >
> > Rob
> 
> It's highly bizarre, but AFAICT it's not indent but rather something wrong with
> "cvs diff".  Here's my investigation so far, I'm on all text mounts:
> 

That would be the problem.  You need to switch to binary mounts or
modify the CVS code to do the right thing.


> So I guess I'm out of WAGes now, unless cvs is tracking the file-moving and
> claiming that a file with, say, the same contents but a different creation date
> or something is completely different, regardless of contents.  But I don't think
> that would explain the initial problem because I never moved any files.
> 

There's nothing to WAG, \n to \r\n conversion is happening because of
your text mounts and now CVS or rather `cvs diff' sees the differences.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

