Return-Path: <cygwin-patches-return-1622-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24679 invoked by alias); 21 Dec 2001 11:54:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24661 invoked from network); 21 Dec 2001 11:54:21 -0000
Subject: RE: src/winsup/w32api ChangeLog include/wingdi.h
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Nov 2001 15:29:00 -0000
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014AAF@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: src/winsup/w32api ChangeLog include/wingdi.h
Thread-Index: AcGJ9YESXgHBD/W2SoWpEFOOU1dwEQAIIjAA
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>,
	"cygwin-patches" <cygwin-patches@cygwin.com>,
	<rbcollins@cygwin.com>
X-SW-Source: 2001-q4/txt/msg00154.txt.bz2

> Robert. I know your intentions were good, but please there is=20
> no need to
> submit to the patch tracker page at mingw SourceForge site as=20
> well. That is
> for submission of new patches needing review.  Unless you=20
> make clear that
> you have comitted this patch to winsup CVS, it may lead to=20
> someone else
> (like myself) checking in your patch to the SourceForge CVS (perhaps
> modified) leading to conflicts at merging.

Ok. So does this sound right:
If I commit to cygwin, don't submit to sourceforge, if I don't checkin
myself, post to sourceforge?
=20
> Also, in future, keeping to the general layout of existing=20
> w32api headers
> (defines, then typedefs, then prototypes) would be good.=20=20
> This makes it
> easier to protect typedefs and prototypes against RC_INVOKED,=20
> while leaving
> the constants visible to windres.

Ok. I was following the MS header arrangement - I wasnt' aware of a
particular layout in the headers for w32api. Will follow in the future.

Rob
