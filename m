From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Mar 2001 08:10:00 -0000
Message-id: <20010306171013.I7734@cygbert.vinschen.de>
References: <VA.0000066f.003b71be@thesoftwaresource.com> <VA.00000689.004d571c@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00149.html

On Tue, Mar 06, 2001 at 12:34:52AM -0500, Brian Keener wrote:
> Trying again - still have the file as an attachment but this time using diff -up
> 
> 2001-02-05  Brian Keener <bkeener@thesoftwaresource.com>
> [...]
>    Also leaves Source Action set to N/A if the source file does not exist 
>    and installing from local directory.

This doesn't work AFAICS. Even if I install from internet, when
choosing the "Full" view, I'm getting "n/a" for every  package
which doesn't need update.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
