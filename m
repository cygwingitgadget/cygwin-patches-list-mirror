Return-Path: <cygwin-patches-return-1890-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13774 invoked by alias); 25 Feb 2002 05:34:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13693 invoked from network); 25 Feb 2002 05:34:37 -0000
Subject: RE: help/version patches
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Feb 2002 06:45:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA76062A5@itdomain003.itdomain.net.au>
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-Has-Attach: 
content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
Thread-Topic: help/version patches
Thread-Index: AcG9vFQDHzfKiFSYRvGPjaTQvCFTawAAQgCQ
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Joshua Daniel Franklin" <joshuadfranklin@yahoo.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00247.txt.bz2



> -----Original Message-----
> From: Joshua Daniel Franklin [mailto:joshuadfranklin@yahoo.com]
> Sent: Monday, February 25, 2002 4:22 PM
> To: cygwin-patches@cygwin.com
> Subject: help/version patches
>=20
>=20
> I've got patches for each of the utils to add/correct the help and
> version output options. There are 13 in all. I incremented the
> version number 0.01 from the ones in CVS/Entries with the
> exception of cygpath. I also added a line based on one found in
> strace that imbeds the compile date into the version output:

Some confusion here: I was meaning that having something like:
const char *revision=3D"$Revision: $ ";
in the file allows you to then use:
const char *version =3D revision[11];
to obtain the correct version number.

Rob
