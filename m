Return-Path: <cygwin-patches-return-2086-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8028 invoked by alias); 19 Apr 2002 12:46:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7989 invoked from network); 19 Apr 2002 12:46:29 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] dtors run twice on dll detach (update)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2002 05:46:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E79@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00070.txt.bz2



> -----Original Message-----
> From: Thomas Pfaff [mailto:tpfaff@gmx.net]=20
> Sent: Wednesday, April 17, 2002 5:08 PM

> > Since i can not judge which function is obsolete (i guess
> > dll_global_dtors
> > is) i have attached a small patch that will make sure that=20
> the dtors run
> > only once.

I'm not sure that either function is obsolete - I'll let Chris/Corinna
comment on that.. Your patch looked good, and corrected a test case I
happened to have hanging around, so I've checked this in as an
appropriate solution. Thanks for the patch.

Rob
