Return-Path: <cygwin-patches-return-8944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62894 invoked by alias); 29 Nov 2017 12:36:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62876 invoked by uid 89); 29 Nov 2017 12:36:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 12:36:14 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id A8161721E281A	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:36:11 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 7868C5E0418	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:36:08 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DEE89A81808; Wed, 29 Nov 2017 13:36:10 +0100 (CET)
Date: Wed, 29 Nov 2017 12:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171129123610.GE547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com> <20171129120437.GC547@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oYAXToTM8kn9Ra/9"
Content-Disposition: inline
In-Reply-To: <20171129120437.GC547@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00074.txt.bz2


--oYAXToTM8kn9Ra/9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 779

On Nov 29 13:04, Corinna Vinschen wrote:
> - If you do async IO, you have to handle STATUS_PENDING gracefully:
>=20
>   - The IO_STATUS_BLOCK given to NtWriteFile *must* exist for the
>     entire time the operation takes after NtWriteFile returned
>     STATUS_PENDING.  An IO_STATUS_BLOCK fhandler member comes to mind,
>     maybe fhandler_base_overlapped::io_status can be reused.

No, wait.  There can be more than one outstanding aio operations on the
same descriptor.  Therefore the IO_STATUS_BLOCK must be connected to the
aiocb struct one way or the other, becasue only that struct is local to
the aio operation.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--oYAXToTM8kn9Ra/9
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHqm6AAoJEPU2Bp2uRE+g2AkP/2YcdxgwsWH0fBSYQAmPHOSt
7kYtXX258PCMuBHm8adagCsf4tGz6A/r2VNK3/ydn7XRIRkb4GPIUjaImrB+WPgY
LWKuEraLNIYxnK6HY8HGSBcT2Isesn0Y/wmpNbu1CtP1MuCvGmshkQK6US2qu9IW
Zi61NrcaBrDCD0lzmtmwuasLi96lLl67ZooKjbJqg/ICRxJQWiQp6gFGMAeDzg+y
TmPL3LCxpvgfjrhoiIV7vOQ+mMLpocud0oXF7VO9rnjY0ckva1kJrFpY8y/Y0vtj
e22zVdKowwOYJGnvoFg+xjOygggOEe+v6P2+/ozFOmhvEvCi9AZdxwuhWlsgnDSr
sVTsaVpT1/P5s/1AbWyZGZlxupnsKzkY0wW4+gG1v4GE6+KzRWwGrUuZB2dI06l4
i27UgGVhgFxzYYkeGXMKCWQ+yoXwLRsez6c3OqNo0gMBr1bV5C+LnHcaH77NHN+t
J8qSngtwbYUF/eI6wWsSjc2CTohGXybpCWceLgXDIg/1/zYE9HgAWiEgWw+5+qQe
oyGvxDXMRaSNJYvy8z+4woh+s+Rw3CoHgfPDPG6E661oQSROMOUfuyBZQ2cpufqC
uP6dDqdlMpthbl3MDOpfIiOzAqbJS4DwYV7x7y6/Tk1ThRLhIX+EVzQRFi5uwNLr
WjsPddV+N1twPe7lnoGH
=ab0y
-----END PGP SIGNATURE-----

--oYAXToTM8kn9Ra/9--
