Return-Path: <cygwin-patches-return-4995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18381 invoked by alias); 24 Sep 2004 09:13:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18359 invoked from network); 24 Sep 2004 09:13:05 -0000
Subject: RE: dinput.h and ddraw.h from Wine with trivial modifications
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Sep 2004 09:13:00 -0000
Content-class: urn:content-classes:message
Message-ID: <90459864DAD67D43BDD3D517DEFC2F7D7168@axon.Axentia.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Peter Ekberg" <peda@axentia.se>
To: "Danny Smith" <dannysmith@users.sourceforge.net>,
	<cygwin-patches@cygwin.com>,
	<earnie@users.sourceforge.net>
X-SW-Source: 2004-q3/txt/msg00147.txt.bz2

Danny Smith wrote:
> From: "Corinna Vinschen"
> > Let's ask the MingW folks.  Danny, Earnie, any problem with a header
> > file being LGPL'ed?
>=20
> I dislike the introduction of  LGPL into the w32api.

Ok, fair enough. I'll bring it up on the Wine list and see if it
might be possible to dual license the files. Before I do that, it
would be good to know what I should be begging for. If public
domain isn't acceptable for the copyright holders, which of the
more popular open source licenses are acceptable for files in
w32api?

Another way forward would be to try out the ReWind version of
the files. Those are under the MIT/X11 license, but they are
not as complete as the Wine versions. So, specifically, is a
MIT/X11 license acceptable?

Cheers,
Peter
