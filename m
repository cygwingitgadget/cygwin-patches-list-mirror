Return-Path: <cygwin-patches-return-1731-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3795 invoked by alias); 17 Jan 2002 16:17:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3762 invoked from network); 17 Jan 2002 16:17:36 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A4A@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: FW: fnmatch
Date: Thu, 17 Jan 2002 08:17:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00088.txt.bz2

Oops.  Chuck caught a licensing problem with the openbsd version of
strptime...

Bad news.  The stuff you took from OpenBSD is licensed under the BSD 
w/advertising clause.  And, since it is owned by Klaus Klein and/or "The 
NetBSD Foundation" it does NOT fall under the blanket changeover (from 
w/advert clause to NO advert clause) issued by the UCalBerkeley folks.

Darn.  I checked FreeBSD and I think it has similar issues.  If someone
would look at the following URLs and verify that the copyright on the
freebsd/netbsd stuff is bad as well, I'd appreciate it.

FreeBSD:
http://www.freebsd.org/cgi/cvsweb.cgi/src/lib/libc/stdtime/strptime.c?rev=1.
17.2.2&content-type=text/x-cvsweb-markup

NetBSD:
http://cvsweb.netbsd.org/bsdweb.cgi/basesrc/lib/libc/time/strptime.c?rev=1.2
2&content-type=text/x-cvsweb-markup

Hmm...   What about this:
http://ftp.uninett.no/pub/OpenBSD/src/kerberosIV/src/lib/roken/strptime.c
Seems to be clear of any advert clause.

Mark

> -----Original Message-----
> From: Mark Bradshaw 
> Sent: Thursday, January 17, 2002 8:21 AM
> To: 'Corinna Vinschen'
> Subject: RE: FW: fnmatch
> 
> 
> Yes.  I'll try to get to that today.
> 
> > -----Original Message-----
> > From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com] 
> > Sent: Thursday, January 17, 2002 5:47 AM
> > To: cygwin-patches@cygwin.com
> > Subject: Re: FW: fnmatch
> > 
> > 
> > On Wed, Jan 16, 2002 at 09:58:25PM -0500, Mark Bradshaw wrote:
> > > All right.  With blessings all around I'll do so.
> > 
> > So, if I understood correctly, you're going to contribute 
> strptime().
> > 
> > I've just added fnmatch() from OpenBSD to Cygwin.  The only 
> > change needed was adding a
> > 
> >   #include "winsup.h"
> > 
> > at the beginning to correctly use symbols from <ctype.h>.
> > 
> > Corinna
> > 
> > -- 
> > Corinna Vinschen                  Please, send mails 
> > regarding Cygwin to
> > Cygwin Developer                                
> > mailto:cygwin@cygwin.com
> > Red Hat, Inc.
> > 
> 
