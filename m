Return-Path: <cygwin-patches-return-1719-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16394 invoked by alias); 16 Jan 2002 23:08:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16377 invoked from network); 16 Jan 2002 23:08:35 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A39@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: fnmatch
Date: Wed, 16 Jan 2002 15:08:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00076.txt.bz2

Thanks Corinna.  I just ported the openbsd version of strptime over
yesterday for utmpdump and had the link for strptime handy.  I wasn't sure
how to get locale strings from cygwin, so I ended up removing some locale
generic stuff and hardcoding English values.  Otherwise, I would've offered
to pitch in.

Mark

> -----Original Message-----
> From: Corinna Vinschen [mailto:cygwin-patches@cygwin.com]
> Sent: Wednesday, January 16, 2002 6:04 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: fnmatch
> 
> 
> On Wed, Jan 16, 2002 at 05:50:57PM -0500, Mark Bradshaw wrote:
> > http://www.openbsd.org/cgi-bin/cvsweb/src/lib/libc/time/
> 
> That's a pointer to strptime().
> 
> A fnmatch() implementation is in
> 
> http://www.openbsd.org/cgi-bin/cvsweb/src/lib/libc/gen/
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Developer                                
> mailto:cygwin@cygwin.com
> Red Hat, Inc.
> 
