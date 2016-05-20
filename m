Return-Path: <cygwin-patches-return-8565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63087 invoked by alias); 20 May 2016 09:16:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63070 invoked by uid 89); 20 May 2016 09:16:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:2104, CVS, sk:emaila, trusted
X-HELO: calimero.vinschen.de
Received: from ipbcc04766.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.71.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 May 2016 09:15:53 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 96693A805D2; Fri, 20 May 2016 11:15:49 +0200 (CEST)
Date: Fri, 20 May 2016 09:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
Message-ID: <20160520091549.GA15115@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org> <56EADD32.4010802@redhat.com> <56EDD62E.3040309@glup.org> <20160320150034.GE24954@calimero.vinschen.de> <20160329124939.GB3793@calimero.vinschen.de> <b45c2cb3-4c76-7213-cfc7-de4e2af79eb4@glup.org> <20160518192310.GB5252@calimero.vinschen.de> <e20dfb4f-1a63-f8e7-0120-02c422bf2a7b@glup.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <e20dfb4f-1a63-f8e7-0120-02c422bf2a7b@glup.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00040.txt.bz2


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2113

On May 18 20:02, john hood wrote:
> On 5/18/16 3:23 PM, Corinna Vinschen wrote:
> > Hi John,
> >=20
> > On May  8 16:43, john hood wrote:
> >> On 3/29/16 8:49 AM, Corinna Vinschen wrote:
> >>> John, ping?
> >>
> >> Sorry it took so long to reply, but I finally got around to cleaning up
> >> the patchset, I've mailed it separately.
> >=20
> > I don't see the patchset anywhere.  Did I miss your mail or did it
> > fail to make it to this list?!?
>=20
> It never made it to the list.  Some aspect of my network's email config
> (I still haven't figured out what) caused email sent directly by my
> workstation to be dropped by the sourceware.org mail server.  I changed
> it to use my mail server instead and that worked.

Probably some trusted server test.  I don't remember how the method is
called but it's used by quite a lot of mail servers (and equally quite
a lot don't...)

> >> I was pretty frustrated at my
> >> slow Windows machine and the friction in dealing with the project,
>=20
> > What friction?  Was there anything I or others did to alienate you?
> > If there's some problem, please also feel free to discuss on the
> > #cygwin-developers IRC channel @Freenode.  You're apparently lurking
> > anyway.
>=20
> The slow Windows machine is probably the larger part of that.  It's a
> netbook-class machine.  It's very slow; development on it was rather
> unpleasant.  I just set up a VM with a Windows 10 preview on a fast
> machine-- it's around four times faster.
>=20
> But also, working with the email-and-patches style of work that you have
> here is really considerably more work than working with projects on
> GitHub (I'm a maintainer of a project there) or GitLab.

Linux kernel development works the same way and it works pretty well.
Also, git makes it very easy to create and send patches and patchsets
via git format-patch and git send-email.  It's an improvement on an
almost excessive scale compared to CVS 'til early 2015 :)


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPtXFAAoJEPU2Bp2uRE+gM/gQAI+ystaFubqh/K9sl/tXCQ05
NK9wTq9gbnB9A2VqfollpHVQCOYTSKgRas/CexbZmCMuJYy9O831jMBzS7YBaYqq
4mF9fjkJvdZZmWX3ofWWDUCtCtEYU8l+uOsdhYpmkVnFdWjbpPTOn3FYmXyZzeWB
rbhbQbEfHvNqRO82/PKmlsI1J00zz8fORO5R1t4Cehuo1vnQCmyRDkSscqDcyLwM
utZdTi+BDTnYKepS4D8mBCIOfpXtcBwA0gmn2aQUD+uHM+mX5VJjIyxfMrEgZGgA
+MceEGnhhJyxBwHKjZ8Tu905u7kA15ECHTVTRITYxMXIpfPdaesyMW+WD3kLIDBd
x0SNoXEvv+iRbuKzZMTXwaqr17fjKE8JfuWrMRPrRhcBUDCCwHdNICS6xAtwjFFt
Ie+WaCWpkMyyMvs2prU0k2bqf4sl4Lz44I4I8GNKourU4yeiqBrB3T2zl9ofHvT1
TdTOdd8lPX7+RNyTHYoNxo28bXZSHKN7yDtBLK7H6InXESN2Wi0QFL0ZAzjL0N9X
GsNhkrUWu7Jez8/KNJKi2p+xowb/aJKCJxUW4UVaJ6dFVvR9PdBXTOvWTAYg18XG
XPY2MVPrh3+0vFGs4QjGfRLe102he4fs5+b2fDj8ly3OY2mXPvOfaG3YGa7IKWvP
RkMbz6t+Nkddet7XehNJ
=zRc3
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
