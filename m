Return-Path: <cygwin-patches-return-2117-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21814 invoked by alias); 26 Apr 2002 09:43:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21767 invoked from network); 26 Apr 2002 09:43:48 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] Fixed race in __pthread_mutex_init
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2002 02:43:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5F11@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00101.txt.bz2



> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net]=20
> Sent: Friday, April 26, 2002 7:08 PM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH] Fixed race in __pthread_mutex_init
>=20
>=20
> __pthead_mutex_init had a race condition if the mutex is=20
> initialized with PTHREAD_MUTEX_INITIALIZER (the mutex could=20
> be initialized by two threads simultanously). The patch wraps=20
> a mutex around mutex creation.
>=20
> This is will be the last patch for a while. The feedback for=20
> the previous ones was a little low, i do not know if no one=20
> (except Rob) is interested in pthreads for cygwin or my=20
> patches are not welcome. I will wait for comments now.

I'm the pthread maintainer, so you only need my interest :}.

I'm reviewing your other patches at the moment.. I'll have some feedback
for you before too much longer.

Rob
