Return-Path: <cygwin-patches-return-1716-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12619 invoked by alias); 16 Jan 2002 22:51:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12605 invoked from network); 16 Jan 2002 22:51:11 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A37@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Robert Collins' <robert.collins@itdomain.com.au>, 
	cygwin-patches@cygwin.com
Subject: RE: fnmatch
Date: Wed, 16 Jan 2002 14:51:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-SW-Source: 2002-q1/txt/msg00073.txt.bz2

http://www.openbsd.org/cgi-bin/cvsweb/src/lib/libc/time/

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Wednesday, January 16, 2002 5:45 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: fnmatch
> 
> 
> 
> ===
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> To: <cygwin-patches@cygwin.com>
> Sent: Thursday, January 17, 2002 9:42 AM
> Subject: Re: fnmatch
> 
> 
> > On Thu, Jan 17, 2002 at 09:28:43AM +1100, Robert Collins wrote:
> > >Hopefully this is self-explanatory.
> >
> > I appreciate the work but I have the same reservations as 
> my previous
> > comments.  Isn't there an existing version of this function that we
> > could grab?
> 
> Possibly, but I dont' have BSD library source handy.
> 
> My implementation is complete barring the [] functionality, and it
> passes the four tests used by AC_FUNC_FNMATCH.
> 
> Rob
> 
