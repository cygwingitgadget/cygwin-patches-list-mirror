Return-Path: <cygwin-patches-return-2175-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 557 invoked by alias); 12 May 2002 01:41:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 486 invoked from network); 12 May 2002 01:41:22 -0000
Subject: RE: [PATCH] pthread_join fix
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 May 2002 18:41:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C606C@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00159.txt.bz2

Glup. I will get these reviewed this weekend. Honest.

Rob

> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> Sent: Sunday, May 12, 2002 11:40 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] pthread_join fix
>=20
>=20
> What's the status of these patches?
>=20
> I've been holding off on releasing 1.3.11 based on these=20
> patches, the potential for fixing socket problems, and the=20
> ever-crucial EISDIR problem in the cygwin mailing list.
>=20
> cgf
>=20
> On Wed, Apr 24, 2002 at 12:18:19PM +0200, Thomas Pfaff wrote:
> >Rob,
> >
> >this is an incremental update to my pthread patches. It will fix a=20
> >problem when a thread is joined before the creation completed.
> >
> >BTW, i have not added any locks yet (the actual=20
> implementation had no),=20
> >but IMHO they are required in the exit,join,cancel code. I will add=20
> >locks if you agree.
> >
> >Greetings,
> >Thomas
> >
> >2002-04-24  Thomas Pfaff  <tpfaff@gmx.net>
> >
> >	* thread.cc (thread_init_wrapper): Check if thread is alreay
> >	joined
> >	(__pthread_join): Set joiner first.
> >	(__pthread_detach): Ditto.
> >
> >
>=20
>=20
>=20
