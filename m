Return-Path: <cygwin-patches-return-1937-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18212 invoked by alias); 28 Feb 2002 20:22:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18163 invoked from network); 28 Feb 2002 20:22:32 -0000
content-class: urn:content-classes:message
Subject: RE: Thread.h failure on
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Feb 2002 12:43:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AAE0@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Thread.h failure on
Thread-Index: AcHAeCZxYuxio0aKRYOoIi5UwZqUZgAHXC9Q
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00294.txt.bz2



> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> >They can be ignored, as the shm and ipc functions aren't=20
> exported yet.=20
> >(Remember: they are incomplete implementations).
>=20
> Well, yeah, but I'd rather not have any warnings in cygwin=20
> compilations.

I'll fix these up to not warn during the weekend if that's soon enough?

Rob
