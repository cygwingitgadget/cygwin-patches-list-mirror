Return-Path: <cygwin-patches-return-2089-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20187 invoked by alias); 19 Apr 2002 22:05:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20075 invoked from network); 19 Apr 2002 22:05:00 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] dtors run twice on dll detach (update)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2002 15:05:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5E7F@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00073.txt.bz2



> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> Sent: Saturday, April 20, 2002 12:42 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] dtors run twice on dll detach (update)
>=20
>=20
> On Fri, Apr 19, 2002 at 10:46:28PM +1000, Robert Collins wrote:
> >
> >
> >> -----Original Message-----
> >> From: Thomas Pfaff [mailto:tpfaff@gmx.net]
> >> Sent: Wednesday, April 17, 2002 5:08 PM
> >
> >> > Since i can not judge which function is obsolete (i guess=20
> >> > dll_global_dtors
> >> > is) i have attached a small patch that will make sure that
> >> the dtors run
> >> > only once.
> >
> >I'm not sure that either function is obsolete - I'll let=20
> Chris/Corinna=20
> >comment on that.. Your patch looked good, and corrected a=20
> test case I=20
> >happened to have hanging around, so I've checked this in as an=20
> >appropriate solution. Thanks for the patch.
>=20
> If one of the functions is obsolete, it should be deleted.=20=20
> That means that the patch does *not* look good.  It needs to=20
> be reviewed.
>=20
> That plus the fact that you don't have global checkin=20
> privileges for cygwin =3D=3D cgf reverts the patch.

Ookay. I don't think that either function is obsolete... and neither you
nor Corinna had commented.=20=20

Anyay, I'v reviewed, given feedback, it's in your court.

Rob
