Return-Path: <cygwin-patches-return-2050-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21407 invoked by alias); 10 Apr 2002 23:03:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21393 invoked from network); 10 Apr 2002 23:03:08 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH]setup.exe: delete called for NULL pointer
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2002 16:03:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5DF0@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	"Pavel Tsekov" <ptsekov@gmx.net>
Cc: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00034.txt.bz2



> -----Original Message-----
> From: Michael A Chase [mailto:mchase@ix.netcom.com]=20
> Sent: Thursday, April 11, 2002 7:51 AM
> To: Pavel Tsekov
> Cc: cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe: delete called for NULL pointer
>=20
>=20
> I don't know, but many other places where it is called, it's=20
> protected by
>    if (var)
>       delete[] var;

That was before I had read up on certain aspects of the C++ spec.

Rob
