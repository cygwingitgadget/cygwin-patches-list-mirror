Return-Path: <cygwin-patches-return-4974-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22849 invoked by alias); 22 Sep 2004 14:01:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22647 invoked from network); 22 Sep 2004 14:01:30 -0000
Subject: RE: dinput.h and ddraw.h from Wine with trivial modifications (fwd)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Sep 2004 14:01:00 -0000
Content-class: urn:content-classes:message
Message-ID: <90459864DAD67D43BDD3D517DEFC2F7D7154@axon.Axentia.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Peter Ekberg" <peda@axentia.se>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2004-q3/txt/msg00126.txt.bz2

Corinna wrote:
> On Sep 17 13:39, Peter Ekberg wrote:
>> Hello!
>>=20
>> This is the ddraw.h and dinput.h files from Wine, with some trivial
>> modification by me to make them work in the cygwin environment.
>>=20
>> They are "Copyright (C) the Wine project" according to their headers
>> and under the LGPL. I think it is polite to keep them under LGPL
>> rather than converting to the GPL so that changes can flow freely
>> between the two projects. [...]
>=20
> Doesn't this collide with the public domain-ness of w32api?

Well, winsock.h, winsock2.h, ws2tcpip.h, gl.h, glext.h and glu.h
are not public domain (according to README.w32api), so I figured
that two more files was not a major collision. Not my decision
though...

Cheers,
Peter
