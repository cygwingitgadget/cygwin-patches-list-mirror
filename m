Return-Path: <cygwin-patches-return-2090-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7041 invoked by alias); 20 Apr 2002 00:17:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6987 invoked from network); 20 Apr 2002 00:17:33 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] dtors run twice on dll detach (update)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2002 17:17:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E8C@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00074.txt.bz2



> -----Original Message-----
> From: Robert Collins=20
> Sent: Saturday, April 20, 2002 8:05 AM
>
> Ookay. I don't think that either function is obsolete... and=20
> neither you nor Corinna had commented.=20=20

I should enlarge on this.

The reason that I don't think that either function is obsolete is as
follows:
Once trigger is via atexit - when the program exits. The other is at dll
detachment.

Now the double-dtor run does not occur under gdb or strace. This
suggests to me that the dll detachment does not occur in these
situations (or that atexit does not run).

Also, atexit will call all the dtors before any dll's detach, which
could be important. So that should stay.

Conversely, dlopened dll's should have their dtors called when they are
dlclosed, so the dll_detach invocation should stay.

Rob
