Return-Path: <cygwin-patches-return-2084-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17888 invoked by alias); 19 Apr 2002 11:37:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17864 invoked from network); 19 Apr 2002 11:37:06 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] minor pthread fixes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2002 04:37:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E75@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Jason Tishler" <jason@tishler.net>
Cc: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00068.txt.bz2



> -----Original Message-----
> From: Jason Tishler [mailto:jason@tishler.net]=20
> Sent: Friday, April 19, 2002 9:38 PM
> To: Robert Collins
> Cc: Thomas Pfaff; cygwin-patches@cygwin.com
> Subject: Re: [PATCH] minor pthread fixes
>=20
>=20
> Rob,
>=20
> On Fri, Apr 19, 2002 at 08:31:52AM +1000, Robert Collins wrote:
> > > -----Original Message-----
> > > From: Jason Tishler [mailto:jason@tishler.net]
> > > Sent: Thursday, April 18, 2002 9:58 PM
> > >=20
> > > Could #2 have caused the problem that we saw with Python's
> > > test_threadedtempfile regression test?
> >=20
> > I don't think so. python isn't creating and killing very=20
> short lived=20
> > threads is it?
>=20
> Recall that test_threadedtempfile spawns many threads (IIRC, at least
> 26) -- maybe they are short lived?  See the following to refresh your

From memory - no. Alsothe symptoms are wrong - the test hangs, not
prematurely exiting. Anyway, it shouldn't be too hard to build a test
.dll and give it a try. If you want I can shoot such a  beast over to
you.

Rob
