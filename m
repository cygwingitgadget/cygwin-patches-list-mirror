Return-Path: <cygwin-patches-return-6445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15153 invoked by alias); 13 Mar 2009 22:08:47 -0000
Received: (qmail 15140 invoked by uid 22791); 13 Mar 2009 22:08:46 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=BAYES_00
X-Spam-Check-By: sourceware.org
Received: from axentia.se (HELO axentia.se) (87.96.186.132)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 22:08:41 +0000
Subject: RE: errno.h: ESTRPIPE
Date: Fri, 13 Mar 2009 22:08:00 -0000
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Message-ID: <BF8A7E40A996804A81035E1D83DD64FF34F79F@saxon.Axentiatech.local>
In-Reply-To: <49BACC94.9040801@etr-usa.com>
Content-class: urn:content-classes:message
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com> <BF8A7E40A996804A81035E1D83DD64FF34F79E@saxon.Axentiatech.local> <49BACC94.9040801@etr-usa.com>
From: "Peter Rosin" <peda@axentia.se>
To: "Cygwin Patches" <cygwin-patches@cygwin.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00043.txt.bz2

Warren Young skrev:
> Peter Rosin wrote:
> > Consider code like this:
> >=20
> > switch (errno) {
> > case -ESTRPIPE:
> > 	capers();
> > 	break;
> > case -EFOOBAR:
> > 	cucumber();
> > 	break;
> > }
>=20
> The core assumption is that neither can happen.  Not now, not ever.
>=20
> If that's true, the worst you can say against it is that gcc=20
> will bitch=20
> about the duplicate switch case.  If it's not true, that=20
> kicks the legs=20
> out from under the recommendation, so of course it shouldn't be done=20
> that way.

Your core assumption doesn't matter. The worst I can say against it is
indeed that gcc will bitch about it, that was my whole point. gcc will
bitch about the above code regardless of the values cygwin will
assign to errno, as it's a compile time problem.

I should stress here that "gcc bitching" is in this case generating an
error and not finishing building whatever is being built.

Adding comptibility defines to help porting code should help porting,
and not require patching the package, that would just be silly.

> It would also be fine with me if the first "can't happen" value were=20
> 9999, then the next 9998, etc.  I do like starting below 10000, as an=20
> old Winsock hand.  Yes, I know, errno and WSAGetLastError() don't=20
> overlap, but somehow it appeals to me to behave as if they could.

But that was not what I protested against. I don't care what numbers
are selected as long as they are unique.

Cheers,
Peter
