Return-Path: <cygwin-patches-return-2012-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1351 invoked by alias); 27 Mar 2002 14:11:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1295 invoked from network); 27 Mar 2002 14:11:05 -0000
content-class: urn:content-classes:message
Subject: RE: Patch for Setup.exe problem and for mklink2.cc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2002 06:48:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008ABCB@itdomain003.itdomain.net.au>
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Ton van Overbeek" <tvoverbe@cistron.nl>,
	<cygwin-apps@cygwin.com>,
	<cygwin-patches@cygwin.com>
Cc: <jonas_eriksson@home.se>
X-SW-Source: 2002-q1/txt/msg00369.txt.bz2



> -----Original Message-----
> From: Ton van Overbeek [mailto:tvoverbe@cistron.nl]=20
> Sent: Thursday, March 28, 2002 1:03 AM
> To: cygwin-apps@cygwin.com; cygwin-patches@cygwin.com
> Cc: jonas_eriksson@home.se
> Subject: Patch for Setup.exe problem and for mklink2.cc
>=20
>=20
> Found the problem causing the segment violation and probably=20
> causing Jonas Eriksson's problem. It is a typical case of=20
> 'off by 1'. In PickView::set_headers the loop filling the=20
> window header does one iteration too much, resulting in a=20
> call to DoInsertItem with a NULL string pointer and hence a=20
> crash following. While debugging this I could not compile the=20
> new mklink2.cc ( the
> c++ version of the original mklink2.c). It seems three & (address of=20
> c++ operator)
> have disappeared in the transition. Putting them back made=20
> the compiler happy. Is this OK Robert ?

I'll check the off-by-one fix in tomorrow, as I'm off to bed now.=20

As for the &'s, I wonder if it's a w32api reference issue? The compiler
complains if they are present for me.

I have the latest-and-greatest w32api headers on my system - what do you
have?

Thanks for finding the off-by-one... blush.

Rob
