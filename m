Return-Path: <cygwin-patches-return-1722-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20319 invoked by alias); 17 Jan 2002 02:52:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20301 invoked from network); 17 Jan 2002 02:52:35 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A3B@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: FW: fnmatch
Date: Wed, 16 Jan 2002 18:52:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00079.txt.bz2

I would, but it'd be kinda incomplete.  As I said, I would need some
guidance on getting locale specific strings.  At the moment, about 4-5
locations (if memory serves) have hard coded strings whereas in OpenBSD
their locale specific.  

If we use yours, or I finish mine...I don't mind either way.  I didn't pipe
up to push what I'd done.  

Mark

> -----Original Message-----
> From: Robert Collins [mailto:robert.collins@itdomain.com.au]
> Sent: Wednesday, January 16, 2002 7:47 PM
> To: Mark Bradshaw; 'Corinna Vinschen'
> Subject: Re: fnmatch
> 
> 
> Just to be clear:
> 
> I wanted to get patchutils going, which is why I implemented
> the two fn's I did. Total time, about 2.5 hours - probably 
> about the same for porting and looking up locale stuff etc.
> 
> I think it'd be great if Mark can contribute his _already
> ported_ strptime instead of my partial implementation, and 
> I've no ego involved in a replacement fnmatch either.
> 
> Rob
> 
> ===
> ----- Original Message -----
> From: "Robert Collins" <robert.collins@itdomain.com.au>
> To: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>; "'Corinna
> Vinschen'" <cygwin-patches@cygwin.com>
> Sent: Thursday, January 17, 2002 10:37 AM
> Subject: Re: fnmatch
> 
> 
> >
> > ===
> > ----- Original Message -----
> > From: "Mark Bradshaw" <bradshaw@staff.crosswalk.com>
> > To: "'Corinna Vinschen'" <cygwin-patches@cygwin.com>
> > Sent: Thursday, January 17, 2002 10:07 AM
> > Subject: RE: fnmatch
> >
> >
> > > Thanks Corinna.  I just ported the openbsd version of
> strptime over
> > > yesterday for utmpdump and had the link for strptime handy.  I
> wasn't
> > sure
> > > how to get locale strings from cygwin, so I ended up removing some
> > locale
> > > generic stuff and hardcoding English values.  Otherwise,
> I would've
> > offered
> > > to pitch in.
> >
> > Why not just contribute the ported strptime you used?
> >
> > Rob
> >
> >
> 
