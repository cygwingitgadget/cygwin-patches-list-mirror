Return-Path: <cygwin-patches-return-1879-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29930 invoked by alias); 24 Feb 2002 08:26:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29884 invoked from network); 24 Feb 2002 08:26:05 -0000
Subject: RE: [PATCH] Percent complete in Setup.exe window title.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 Feb 2002 02:07:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014AE7@itdomain003.itdomain.net.au>
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
content-class: urn:content-classes:message
Thread-Topic: [PATCH] Percent complete in Setup.exe window title.
Thread-Index: AcG9BO3nQ7l89hUQRuGP97AStPLFDgAB86Ug
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
Cc: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00236.txt.bz2

Looks nice. I'll commit to HEAD shortly.

Why the discardable stringtable?

Rob

> -----Original Message-----
> From: Gary R. Van Sickle [mailto:g.r.vansickle@worldnet.att.net]
> Sent: Sunday, February 24, 2002 6:29 PM
> To: Cygwin-Patches
> Subject: [PATCH] Percent complete in Setup.exe window title.
>=20
>=20
> This one goes good with the new minimizeability of Setup.exe:
>=20
> 2002-02-24  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>
>=20
> 	* res.rc (STRINGTABLE): Add IDS_CYGWIN_SETUP and
> 	IDS_CYGWIN_SETUP_WITH_PROGRESS strings.
> 	* resource.h: Add IDS_CYGWIN_SETUP and
> 	IDS_CYGWIN_SETUP_WITH_PROGRESS IDs.
>=20
> 	* splash.cc (OnInit): Qualify SetWindowText() call with=20
> global scope
> 	operator (::SetWindowText()).
>=20
> 	* threebar.cc: Run indent.
> 	(cistring.h): Add include.
> 	(SetText1, SetText2, SetText3): Qualify SetWindowText()=20
> call with
> 	global scope operator.
> 	(SetBar2): Add logic for writing percent complete into=20
> window title.
>=20
> 	* window.h: Run indent.
> 	(SetWindowText): New function.
> 	(String): Add forward declaration.
> 	* window.cc: Run indent.
> 	(String++.h): Add include.
> 	(SetWindowText): New function.
>=20
> --=20
> Gary R. Van Sickle
> Brewer.  Patriot.=20
>=20
