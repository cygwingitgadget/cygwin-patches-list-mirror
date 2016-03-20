Return-Path: <cygwin-patches-return-8440-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96862 invoked by alias); 20 Mar 2016 13:09:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95638 invoked by uid 89); 20 Mar 2016 13:09:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Background, Programs, H*R:D*cygwin.com, services
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 13:09:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C1042A8039E; Sun, 20 Mar 2016 14:09:40 +0100 (CET)
Date: Sun, 20 Mar 2016 13:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin select() issues and improvements
Message-ID: <20160320130940.GD24954@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20160215125703.GE8374@calimero.vinschen.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00146.txt.bz2


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 925

Sidenote from the past:

On Feb 15 13:57, Corinna Vinschen wrote:
> On Feb 14 03:09, john hood wrote:
> > Windows scheduling in general seems to be rather poor for Cygwin
> > processes, and there are scheduling differences between processes run in
> > Windows console (which are seen as interactive by the scheduler) and
> > processes run in mintty (which are not).  There doesn't seem to be any
> > priority promotion for I/O as you see on most Unix schedulers.
>=20
> I'm not aware of such a feature.

On a hunch, do you see a difference when swiching the machine's process
scheduling from "Adjust for best performance of Programs" to "Adjust for
best performance of Background services"?

You can do this in the performance options in the advanced system
settings.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7qEUAAoJEPU2Bp2uRE+gXt4P/ilOo0APa2Ru6H8uBrYDP3C6
POOT6YL/YdpZxy8FjgSEYGanbH5Nse4D86Gbde3UHzceRv4LuJfULWNWl8kyDpeh
Ko8DbURYbAd5BdgImAG6bUqRifh5YK7FbLIKahG6gjjanHc8QhrbJlEvShG9c/YV
DFqgy1xb9w8iL/tbZrk1CfH0qlZ58KJ0WnEHIyB3CgNCdikh/wRGGBVqSQga6EA5
ywZnOZQq8WM+bzYoVBl5e2mRf82J0HwO+mDrGcfAFJs5kqIthipA3HY4byk2tyvl
4UUckuwQaBwtX6NqWI9zupBPngokSFAyhxd8wzNU++p7NZfDrfjN9bZCIdQz+KT5
90R5WTEmunLacMeo14HZ07Z7jCJceTTUVrsjMrVmkQcZoP9TzF7Se9xa8VbhuTgJ
dFCVybyO4vpkwJpEZmml0vQlC4SD+q3HTq6KA2iGRqJEBAGCHvS8TRFSI+UJ3hcH
p0Em/VZ5+HzjmQfrfamFhvYxxnMPYKxIRb+lUeyGc2kKs5JPNfhxLH1HuG6MMO5F
TWVwnM2JsqMd84k5g3jgHt5QX2NiCWKaSdsDDiw0awjU8xPy7WbEuoMY47QEd2hw
Fta/6rw61XrBa3zmlqAVexAalCueGXPiZ0SN53ub637C28ZsiinbfQ5KQuTzvVkH
grXKNk75L/R54bU1asMX
=s4aV
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
