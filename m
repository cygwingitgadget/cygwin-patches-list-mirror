Return-Path: <cygwin-patches-return-2073-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8796 invoked by alias); 18 Apr 2002 11:31:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8731 invoked from network); 18 Apr 2002 11:31:17 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] minor pthread fixes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2002 04:31:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E67@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00057.txt.bz2

Hi Thomas! It's great to see someone else also interested in pthreads. I
look forward to your work on cancellation - that's been in my TODO list
for far too long.

re: 1. Good catch, this definitely needs fixing. Also an excellent catch
on pthread_join (pthread_self(),...)

Regarding 2:, again  a good catch.=20

I'll commit this to CVS this weekend, I've a bit of spare time coming
up.

Rob

> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net]=20
> Sent: Thursday, April 18, 2002 8:11 PM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH] minor pthread fixes
>=20
>=20
>=20
> This patch contains some small pthread fixes:
>=20
> 1. the pthread class allocated in __pthread_create never was=20
> freed. This
>    resulted in a memory leak and an unclosed handle.
>    Depending on the state of of the thread it is deleted now in
>    __pthread_exit or __pthread_join
> 2. The InterlockedIncrement (&MT_INTERFACE->threadcount) in
>    __pthread_create is misplaced. If the newly created thread=20
> terminates
>    fast enough the threadcount will be decremented before it was
>    incremented, which will result in an exit from=20
> __pthread_exit instead
>    of an ExitThread.
>=20
> Comments are very welcome, because i like to add more patches=20
> regarding cancellation which is incomplete, a better mutex=20
> implementation (the current one has only recursive mutexes=20
> and is slow on win9x) ... .
>=20
> Thanks,
> Thomas
>=20
>=20
> 2002-04-18  Thomas Pfaff  <tpfaff@gmx.net>
>=20
>  	* thread.h (pthread::joiner): New member.
>  	* thread.cc (pthread::pthread): Initialize joiner to NULL
> 	(pthread::create): Increment of thread counter moved from
> 	__pthread_create to this location.
> 	(__pthread_create): Increment thread counter removed.
> 	(thread_init_wrapper): Set joiner to self when thread=20
> was created
> 	detached.
> 	(__pthread_exit): delete thread when it is detached and not
> 	joined.
> 	(__pthread_join): Check for deadlock and delete thread=20
> when it has
> 	terminated.
> 	(__pthread_detach): Set joiner to self when thread state
> 	changed to detached.
>=20
>=20
