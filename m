Return-Path: <cygwin-patches-return-2092-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28809 invoked by alias); 22 Apr 2002 07:22:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28732 invoked from network); 22 Apr 2002 07:22:10 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Apr 2002 00:22:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5EBA@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gerrit P. Haase" <gp@familiehaase.de>
Cc: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00076.txt.bz2



> -----Original Message-----
> From: Gerrit P. Haase [mailto:gp@familiehaase.de]=20
> Sent: Monday, April 22, 2002 4:34 PM
> To: Robert Collins
> Cc: cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe mklink2.cc some function=20
> arguments need to be pointers
>=20
>=20
> Hallo Robert,
>=20
> >> It looks like you are building in a branch.  The version of=20
> >> mklink2.cc I have from the main branch is
>=20
> > No, I've realised that I haven't committed it... I've some=20
> > smei-invasive changes I've been mulling over in HEAD, and I'd=20
> > forgotten about that.
>=20
> > I will commit my patch to HEAD along with a couple of other=20
> fixes from=20
> > setup200202 shortly - hopefully this weekend.
>=20
> > Until then, simply use the mklink2.cc from the setup200202 branch.
>=20
> Is it in now?
> I cannot build because mklink2.cc fails...

Use this:
cvs -z3 update -Pdrsetup200202 mklink2.cc=20
to get a copy that will build.

Rob
