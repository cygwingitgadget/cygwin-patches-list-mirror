Return-Path: <cygwin-patches-return-2102-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5022 invoked by alias); 25 Apr 2002 02:34:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5008 invoked from network); 25 Apr 2002 02:34:45 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] dtors run twice on dll detach (update)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2002 19:34:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5EEF@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00086.txt.bz2



> -----Original Message-----
> From: Robert Collins=20
> Sent: Saturday, April 20, 2002 10:18 AM
> To: Robert Collins; cygwin-patches@cygwin.com
> Subject: RE: [PATCH] dtors run twice on dll detach (update)
>=20
>=20
>=20
>=20
> > -----Original Message-----
> > From: Robert Collins
> > Sent: Saturday, April 20, 2002 8:05 AM
> >
> > Ookay. I don't think that either function is obsolete... and
> > neither you nor Corinna had commented.=20=20
>=20
> I should enlarge on this.
>=20
> The reason that I don't think that either function is obsolete is as
> follows:
> Once trigger is via atexit - when the program exits. The=20
> other is at dll detachment.
>=20
> Now the double-dtor run does not occur under gdb or strace.=20
> This suggests to me that the dll detachment does not occur in=20
> these situations (or that atexit does not run).
>=20
> Also, atexit will call all the dtors before any dll's detach,=20
> which could be important. So that should stay.
>=20
> Conversely, dlopened dll's should have their dtors called=20
> when they are dlclosed, so the dll_detach invocation should stay.

So... as this has been contentious: Chris/Corinna - any objection to my
recommitting it?

Rob
