Return-Path: <cygwin-patches-return-2137-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32187 invoked by alias); 2 May 2002 12:32:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32128 invoked from network); 2 May 2002 12:32:10 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] dtors run twice on dll detach (update)
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Thu, 02 May 2002 05:32:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5F90@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00121.txt.bz2



> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> Sent: Wednesday, May 01, 2002 1:49 AM

> If we just avoid setting up the destructor calls using atexit=20
> then the destructors will only run once.  So, in the normal=20
> case, the destructor will run after much cleanup has occurred=20
> in the cygwin DLL (specifically in the do_exit function).=20=20
> This means that the destructor may not be able to use all of=20
> the facilities of cygwin when it is finally executed.

Yup. That is why I don't think that the atexit call is obsolete.
=20
> This won't be an issue for the problem below, but I wonder if=20
> it is a problem for other destructors.  I'm not sure what=20
> kind of environment a global destructor is guaranteed to have=20
> but I suspect that it should be a completely normal environment.
>=20
> Anyone know for sure?  Is there an online reference for this=20
> kind of thing?

It'll be in the C++ standard, which is proprietary :[. Anyone here have
the standard and care to check for us?

Rob
