Return-Path: <cygwin-patches-return-2077-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31926 invoked by alias); 18 Apr 2002 22:31:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31912 invoked from network); 18 Apr 2002 22:31:53 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] minor pthread fixes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2002 15:31:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E6B@itdomain003.itdomain.net.au>
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jason Tishler" <jason@tishler.net>
Cc: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00061.txt.bz2



> -----Original Message-----
> From: Jason Tishler [mailto:jason@tishler.net]=20
> Sent: Thursday, April 18, 2002 9:58 PM
> To: Robert Collins
> Cc: Thomas Pfaff; cygwin-patches@cygwin.com
> Subject: Re: [PATCH] minor pthread fixes
>=20
>=20
> Rob,
>=20
> On Thu, Apr 18, 2002 at 09:31:15PM +1000, Robert Collins wrote:
> > Regarding 2:, again  a good catch.
>=20
> Could #2 have caused the problem that we saw with Python's=20
> test_threadedtempfile regression test?

I don't think so. python isn't creating and killing very short lived
threads is it?

ROb
