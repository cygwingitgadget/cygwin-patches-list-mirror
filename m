Return-Path: <cygwin-patches-return-1834-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8412 invoked by alias); 2 Feb 2002 03:23:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8389 invoked from network); 2 Feb 2002 03:23:26 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: For the curious: Setup.exe char-> String patch
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Fri, 01 Feb 2002 19:23:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014AB8@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: For the curious: Setup.exe char-> String patch
Thread-Index: AcGrlaB0vAygHvZKQDuKWF7Di73MUwAA0GEg
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R Van Sickle" <tiberius@braemarinc.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00191.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com
> > > > geturl.cc:
>
> > Weeel, yes it would, yet another typo. Fortunately String copies are
> > very lightweight :}.
> > (One addition, one subtraction, and if test and 4 bytes of storage)
>=20
> ??? You're doing some sort of ref counting?  Isn't that a bit=20
> ambitious for our current needs?

Ref counting is pretty trivial in most cases, and yes, I am.

Rob
