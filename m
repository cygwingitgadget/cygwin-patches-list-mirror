Return-Path: <cygwin-patches-return-8534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91675 invoked by alias); 1 Apr 2016 15:09:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91648 invoked by uid 89); 1 Apr 2016 15:09:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1255, earth, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Apr 2016 15:09:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0CC48A8060E; Fri,  1 Apr 2016 17:09:09 +0200 (CEST)
Date: Fri, 01 Apr 2016 15:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
Message-ID: <20160401150909.GF16660@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com> <20160401121318.GA16660@calimero.vinschen.de> <56FE73D7.8030306@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <56FE73D7.8030306@cygwin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00009.txt.bz2


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1239

On Apr  1 08:12, Yaakov Selkowitz wrote:
> On 2016-04-01 07:13, Corinna Vinschen wrote:
> >On Mar 31 12:18, Peter Foley wrote:
> >>G++ 6.0 asserts that the "this" pointer is non-null for member function=
s.
> >>Refactor methods that check if this is non-null to be static where
> >>necessary, and remove the check where it is unnecessary.
> >
> >No, sorry, but now.  Converting all affected functions to static
> >functions just because this might be null is much too intrusive for my
> >taste.  *If* that's really a problem going forward, I'd rather see the
> >pointer test moved into the caller.  But don't waste your time on a
> >patch yet.
> >
> >Let's please take a step back and look at what happens.  So, here's the
> >question:  What error message does G++ 6 generate in case of an `if
> >(this)' test in a member function, and why on earth should it care and
> >do that?
>=20
> See https://gcc.gnu.org/gcc-6/porting_to.html, section named "Optimizatio=
ns
> remove null pointer checks for this".

Oh well.  I kind of start to miss the K&R times...

Just kidding.  I think.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW/o8UAAoJEPU2Bp2uRE+gJ6EP/0AUEFY77c3dBTkJhakXMMMy
4xqVVmCtJQJcOteiX0oRbiHPMDETrUMdwrVqpzLrXzAalXDsAq71aoU7CWf7Mu6x
4tQ3cdA0JF2KOiWe4nGtTCl6y6f0nZN6srTCs5C352NPiFgOLYNXogmARfU3vWYo
x4sdnxBxcngvM/NV+YlTE9xghtx4B2bSyOg55eODnFxa8p5I6tACrj7B6Dsu97sN
oCxuis8m6Zq+KMQWl7r3AoCWdoxMRV7qzHpIQqrs8nQczGYs1BixAXQfA2BHWlEk
S1xW6q5lYb4SLUx5t+Cy8obvt4e+W1NlY3HjQADAv91Xt3re2vv5IUSenhP9vRJQ
/8sjkFNu5fVHZAJjgzVoj1xAq9lTrQEEhpX9LW6KDa2YlAM43FWHhgqP/v13tUcH
KfTD7xBXLYuZrrEWh1IEyQitkpeaHDIghRSZgUPW6FFdPldWnxca79J8a6wa1WIs
5IOqjxu/GVkw0iCkV2Z76cNF03qB+q6h3gkxKsLCq0YWBaPC5FLni0SFEkpbX6aV
1zWXPpMucgp4YviL6kGsvCZyUikOfPzk5lzaD+KWUiFvdJnp/ygpK4hNLendt8WT
kD4UrXWbYhhjOsOMeJsOwV9vxtm3o3/vbQuskYeOXWaSXDQS/Prf6wmrRrfHrXvB
f9iw/o+6A49XlBgkuI4T
=eFC7
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
