Return-Path: <cygwin-patches-return-6441-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32436 invoked by alias); 13 Mar 2009 19:48:32 -0000
Received: (qmail 31991 invoked by uid 22791); 13 Mar 2009 19:48:31 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=BAYES_00
X-Spam-Check-By: sourceware.org
Received: from axentia.se (HELO axentia.se) (87.96.186.132)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Mar 2009 19:48:25 +0000
Subject: RE: errno.h: ESTRPIPE
Date: Fri, 13 Mar 2009 19:48:00 -0000
MIME-Version: 1.0
Message-ID: <BF8A7E40A996804A81035E1D83DD64FF34F79E@saxon.Axentiatech.local>
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49BA4D48.1030705@etr-usa.com>
Content-class: urn:content-classes:message
References: <49B8A1F8.1030306@users.sourceforge.net> <20090312085748.GE14431@calimero.vinschen.de> <49B98AC4.1040202@users.sourceforge.net> <20090313103036.GA13010@calimero.vinschen.de> <49BA4D48.1030705@etr-usa.com>
From: "Peter Rosin" <peda@axentia.se>
To: <cygwin-patches@cygwin.com>
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
X-SW-Source: 2009-q1/txt/msg00039.txt.bz2

Warren Young skrev:
> Corinna Vinschen wrote:
> > This is very Linux device specific and this never occurs on Cygwin.
> > What about just defining this error code to some arbitrary=20
> value like
> >=20
> >   #ifdef __CYGWIN__
> >   #define ESTRPIPE 9999
> >   #endif
>=20
> I like it.  If there are any other errno constants supported by Linux=20
> but not Cygwin, you could also define them with the same value.  It=20
> would effectively be the "this never happens" value.

That a bad suggestion.

Consider code like this:

switch (errno) {
case -ESTRPIPE:
	capers();
	break;
case -EFOOBAR:
	cucumber();
	break;
}

If both ESTRPIPE and EFOOBAR are defined to 9999 that doesn't work too
well, and you end up having cygwin specific patches in any case.

Cheers,
Peter
