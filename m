Return-Path: <cygwin-patches-return-1935-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28714 invoked by alias); 28 Feb 2002 15:29:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28641 invoked from network); 28 Feb 2002 15:29:28 -0000
content-class: urn:content-classes:message
Subject: RE: Thread.h failure on
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Feb 2002 08:00:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AADD@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Thread.h failure on
Thread-Index: AcHAbJPO/OmZvPlsT5OcPoCxlfFvnwAAAt8Q
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00292.txt.bz2



> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> >Yah, my newlib wasn't new enough.
>=20
> Hah.  Neither was mine.  I'm still getting some warnings from=20
> glob.c, though.
>=20
> How about these warnings, though, Robert:
>=20
> /cygnus/src/uberbaum/winsup/cygwin/shm.cc: In function `void*=20
> shmat(int, const void*, int)':
> /cygnus/src/uberbaum/winsup/cygwin/shm.cc:232: warning:=20
> unused variable ` shmid_ds*shm'
> /cygnus/src/uberbaum/winsup/cygwin/shm.cc: In function `int=20
> shmdt(const void*)':
> /cygnus/src/uberbaum/winsup/cygwin/shm.cc:281: warning:=20
> control reaches end of non-void function

They can be ignored, as the shm and ipc functions aren't exported yet. (Rem=
ember: they are incomplete implementations).

Rob
