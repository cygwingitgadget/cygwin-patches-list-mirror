Return-Path: <cygwin-patches-return-2082-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12865 invoked by alias); 19 Apr 2002 11:19:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12851 invoked from network); 19 Apr 2002 11:19:22 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH]setup.exe mklink2.cc some function arguments need to be pointers
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2002 04:19:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E74@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<bkeener@thesoftwaresource.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00066.txt.bz2



> -----Original Message-----
> From: Michael A Chase [mailto:mchase@ix.netcom.com]=20
> Sent: Friday, April 19, 2002 11:19 AM
> To: Robert Collins; bkeener@thesoftwaresource.com;=20
> cygwin-patches@cygwin.com
> Subject: Re: [PATCH]setup.exe mklink2.cc some function=20
> arguments need to be pointers
>=20
>=20
> It looks like you are building in a branch.  The version of=20
> mklink2.cc I have from the main branch is

No, I've realised that I haven't committed it... I've some smei-invasive
changes I've been mulling over in HEAD, and I'd forgotten about that.

I will commit my patch to HEAD along with a couple of other fixes from
setup200202 shortly - hopefully this weekend.

Until then, simply use the mklink2.cc from the setup200202 branch.=20

Sorry about the confusion.

Rob
