From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 17:34:00 -0000
Message-id: <200102080133.UAA03084@envy.delorie.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com> <200102080056.TAA02750@envy.delorie.com> <20010207201149.A20901@redhat.com> <3A81F6A4.BC89B7A@yahoo.com>
X-SW-Source: 2001-q1/msg00062.html

> BTW, I just remembered.  The rest of the Makefile.in uses the source
> includes and not the installed includes so this patch would make it
> consistent anyway.

Yeah, I know, I was just curious why it suddenly needs to be fixed.

Go ahead and check in the Makefile.in change; the configure.in change
is superfluous.
