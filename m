Return-Path: <cygwin-patches-return-2104-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17033 invoked by alias); 25 Apr 2002 03:09:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17013 invoked from network); 25 Apr 2002 03:08:57 -0000
content-class: urn:content-classes:message
Subject: RE: [PATCH] dtors run twice on dll detach (update)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2002 20:09:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA7600C5EF0@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00088.txt.bz2



> -----Original Message-----
> From: Christopher Faylor [mailto:cgf@redhat.com]=20
> Sent: Thursday, April 25, 2002 1:07 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] dtors run twice on dll detach (update)
>=20
>=20
> On Thu, Apr 25, 2002 at 12:34:33PM +1000, Robert Collins wrote:
> >So... as this has been contentious: Chris/Corinna - any=20
> objection to my=20
> >recommitting it?
>=20
> No:
>=20
> On Fri, Apr 19, 2002 at 10:42:21AM -0400, Christopher Faylor=20
> wrote: *>If one of the functions is obsolete, it should be=20
> deleted.  That means *>that the patch does *not* look good.=20=20
> It needs to be reviewed.

I replied to that explaining why I don't think *either* function is
obsolete.

http://cygwin.com/ml/cygwin-patches/2002-q2/msg00074.html

Rob
