Return-Path: <cygwin-patches-return-2079-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5535 invoked by alias); 18 Apr 2002 22:45:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5506 invoked from network); 18 Apr 2002 22:45:43 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2002 15:45:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E6D@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00063.txt.bz2

Well if you recall I had the opposite code in place (as far as I can
tell without an actual patch), and that didn't compile for a different
set of users. I completely rebuild my OS the other day, and after that
I've needed the patch. That seemed a strong indication that the w32api
was the culprit..

Rob

> -----Original Message-----
> From: Brian Keener [mailto:bkeener@thesoftwaresource.com]=20
> Sent: Friday, April 19, 2002 8:46 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe mklink2.cc some function=20
> arguments need to be pointers
>=20
>=20
> Not to be a pain about this - but this have been reported=20
> several times in the=20
> past and I am running Win2000 and have the W32api-1.3-2=20
> installed.  I haven't=20
> seen any other w32api come down the pike so that appears to=20
> be the most recent.=20
> I have the patch - just took it out and no compile - put it=20
> back and it does=20
> compile.
>=20
> Not sure what Mike's OS or yours Robert or if it even makes a=20
> difference but I=20
> thought I would point out mine is Win2k.  I also have my just=20
> updated my CVS=20
> for cinstall so it is current.
>=20
> I know this is a me2 but I thought I would add what I could.
>=20
> Bk
>=20
>=20
>=20
