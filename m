Return-Path: <cygwin-patches-return-8756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83907 invoked by alias); 22 Apr 2017 13:59:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83888 invoked by uid 89); 22 Apr 2017 13:59:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 22 Apr 2017 13:59:11 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C87AE721E280D	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 15:59:10 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 228395E03A9	for <cygwin-patches@cygwin.com>; Sat, 22 Apr 2017 15:59:10 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 04C97A80C20; Sat, 22 Apr 2017 15:59:10 +0200 (CEST)
Date: Sat, 22 Apr 2017 13:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix stat.st_blocks for files compressed with CompactOS method
Message-ID: <20170422135909.GC26402@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <81896c1a-a5c8-1f96-c478-5e24f7c1eb56@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <81896c1a-a5c8-1f96-c478-5e24f7c1eb56@t-online.de>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00027.txt.bz2


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1362

Hi Christian,

On Apr 22 14:50, Christian Franke wrote:
> Cygwin 2.8.0 returns stat.st_blocks =3D 0 if a file is compressed with
> CompactOS method (at least on Win10 1607):
> [...]
> This is because StandardInformation.AllocationSize is always 0 for theses
> files. CompressedFileSize returns the correct value.
>=20
> This is likely related to the interesting method how these files are enco=
ded
> in the MFT:
> The default $DATA stream is a sparse stream with original size but no
> allocated blocks.
> An alternate $DATA stream WofCompressedData contains the compressed data.
> An additional $REPARSE_POINT possibly marks this file a special and lets
> accesses fail on older Windows releases (and on Linux, most current foren=
sic
> tools, ...).
>=20
> With the attached patch, stat.st_blocks work as expected:
> [...]
> -  else if (::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
> -					| FILE_ATTRIBUTE_SPARSE_FILE)
> +  else if ((pfai->StandardInformation.AllocationSize.QuadPart =3D=3D 0LL
> +	    || ::has_attribute (attributes, FILE_ATTRIBUTE_COMPRESSED
> +					  | FILE_ATTRIBUTE_SPARSE_FILE))

Are you saying these files actually have no FILE_ATTRIBUTE_COMPRESSED
bit set???


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+2GtAAoJEPU2Bp2uRE+gsCwP/31kUwtk0gxMg3Cea2lHt9Hp
zJgA0ZcDCKPTs9kbNMjRnpOsre6nT0I6OFkxO6wTKU00DMPQ8tfcXIzltDqBXHLi
r2d0B++VxfKMAhO+eIuXger3lSH4FBWHHshH1nfRCfaJiZAESMyagfCH5HmnfbmG
j9jRUi/reliOlYFiMOg1Ui/+FnQXn9l68LalwRLNO6QpzNGla2B+Jjhy0+naJfef
qvDmXvV+PC4zRrmhQah4/A4+FyKO5Zv0Me7FhujOJS60F2rTIx24QshK9e84IBdV
ZuHjk7jMdmVxJiOHgxroY8Pp1qbfwgL4IvKMYs7RUj0rKXNerJl46vkm8fq/ZOh2
HdmI27P/0GmqgcAadA2Oa9wQ8RhjWGxwkIlB6hMm99lIjQpYW2MRMXlac/xPeJWo
7JCmRwE1PHCtUaSZDJq3sK8nzE9A6OaJBjbgqumGa+bRy5SmQ6uc1gmMBrqL/EEI
8uyAZ38ZXyszBa0nz5fbx7D8NwJCXf785XWi0k3Nsgzic6NGPC8sz2ecoKr1Y9aP
zV8U8P23wbRJJbnAvkT4+VDcQGZiugOh19kOR/H7EmOrZ54LXX7CT0ctjv8BAS2R
U5aL9AQhqJr8mLHJlM0Ij2yUih5RDMFUvMCZ1qDjIP8trn4NBMsWmTn6z/qvw8Y1
13yLzJCaz/UbYPDyRQoP
=sB88
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
