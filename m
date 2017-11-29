Return-Path: <cygwin-patches-return-8945-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64243 invoked by alias); 29 Nov 2017 12:38:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64223 invoked by uid 89); 29 Nov 2017 12:38:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 12:38:09 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 26AB3721E281A	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:38:07 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 219D35E0754	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:38:04 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 88C34A8072C; Wed, 29 Nov 2017 13:38:06 +0100 (CET)
Date: Wed, 29 Nov 2017 12:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171129123806.GF547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com> <20171129120437.GC547@calimero.vinschen.de> <20171129123610.GE547@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <20171129123610.GE547@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00075.txt.bz2


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1001

On Nov 29 13:36, Corinna Vinschen wrote:
> On Nov 29 13:04, Corinna Vinschen wrote:
> > - If you do async IO, you have to handle STATUS_PENDING gracefully:
> >=20
> >   - The IO_STATUS_BLOCK given to NtWriteFile *must* exist for the
> >     entire time the operation takes after NtWriteFile returned
> >     STATUS_PENDING.  An IO_STATUS_BLOCK fhandler member comes to mind,
> >     maybe fhandler_base_overlapped::io_status can be reused.
>=20
> No, wait.  There can be more than one outstanding aio operations on the
> same descriptor.  Therefore the IO_STATUS_BLOCK must be connected to the
> aiocb struct one way or the other, becasue only that struct is local to
> the aio operation.

I guess that's what the Linux man page aio(7) subsumes under

  struct aiocb {
    [...]

    /* Various implementation-internal fields not shown */
  };


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHqouAAoJEPU2Bp2uRE+gTA4P/131ybcIvs0HiGi1VyikH1VL
un5X8eI2kIeJjXMa3lQ4Qn4wj8qFcUwkNLF7pL6h8gRIGsEzeZQ+lyr5OW7A5dMF
xeVmA9qgf7kDi1/XuDh1/5Oy7Yh5Y+ijVtch451PrYBSceILVYiTNkJTcjlp4DQu
wt1RplBIJFOiccK2Gt17dW1vhxqTdP9g4pNeWjU2YsbTLDdnzqg4lh9XiUEgGfGU
eytO+nCyh3YXJ/qhe80s/dAKvqwEQQudYcc/3zN0kwlGRxuu7XEkQN3WKFpupU25
V0N4dJQxvcVRyBWx5kVxUH9XQk4Ga85bMw5LKq5ipvej/qkcSDlaH9ceiQ3w+CgQ
Pqszud8YTrH4K0vk5JS5KGFOTWDPgj/c6eI3FRL+tKkJ0fw6BgtHn7UYq0MlQbpP
ynAMKSUqXOornUuoiT4j//yr1oeD+dZdfrP76aNLJuWd2WXlxjx9QxR9gJCGIr8X
DpzYnYhFwmNnJVax+24zpU1FKyltcmNAhm5st/fJiRSUz3Xr7igrwvPPfba00Zhd
tQmdqXyBxUN7vlNob43SXYJjleuoC5kEPTZJTJyIMFgYz1wIzUNETQZgMsOgwUpN
nQq2yy+kpMIPg4Vsyu0JR6hzZimh949ah2Z7UaHiMJ7j6yjoUl1ABFK/tcmh99zQ
3Y6UXW0mxgCc0+S7mTgt
=ONEY
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--
