From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin/Makefile.in and cinstall/Makefile.in
Date: Tue, 26 Dec 2000 15:21:00 -0000
Message-id: <200012262321.SAA25080@envy.delorie.com>
References: <20001218204418.12970.qmail@web117.yahoomail.com> <20001225222322.A7249@redhat.com>
X-SW-Source: 2000-q4/msg00064.html

> I'll let DJ decide if the cinstall changes are desirable.

I added his patch as-is.  There's nothing in cinstall/autoload.c that
would benefit from inlining anyway.
