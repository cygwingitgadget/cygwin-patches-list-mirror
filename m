Return-Path: <cygwin-patches-return-8821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70405 invoked by alias); 18 Aug 2017 14:33:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68671 invoked by uid 89); 18 Aug 2017 14:33:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Aug 2017 14:33:23 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 79DBA13A8F	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 14:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 79DBA13A8F
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx05.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=eblake@redhat.com
Received: from [10.10.122.167] (ovpn-122-167.rdu2.redhat.com [10.10.122.167])	by smtp.corp.redhat.com (Postfix) with ESMTP id 191B16BC0D	for <cygwin-patches@cygwin.com>; Fri, 18 Aug 2017 14:33:20 +0000 (UTC)
Subject: Re: renameat2
To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <7394aca1-ce7d-2a35-7d79-905da33cc100@redhat.com>
Date: Fri, 18 Aug 2017 22:25:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="vOwhc2dRriDWh5o9tLT76iOqPJNN92Xs2"
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00023.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOwhc2dRriDWh5o9tLT76iOqPJNN92Xs2
Content-Type: multipart/mixed; boundary="5aoKenAcXIeioveJRdSHn3hLAbbnPF1eX";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Message-ID: <7394aca1-ce7d-2a35-7d79-905da33cc100@redhat.com>
Subject: Re: renameat2
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>
In-Reply-To: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu>


--5aoKenAcXIeioveJRdSHn3hLAbbnPF1eX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Content-length: 1885

On 08/18/2017 08:21 AM, Ken Brown wrote:
> Linux has a system call 'renameat2' which is like renameat but has an
> extra 'flags' argument.  In particular, one can pass the
> RENAME_NOREPLACE flag to cause the rename to fail with EEXIST if the
> target of the rename exists.  See
>=20
>  http://man7.org/linux/man-pages/man2/rename.2.html
>=20
> macOS has a similar functionality, provided by the function
> 'renameatx_np' with the flag RENAME_EXCL.
>=20

>=20
> Define the RENAME_* flags in <cygwin/fs.h> as defined on Linux in
> <linux/fs.h>, but support only RENAME_NOREPLACE.
> ---

> +++ b/winsup/cygwin/include/cygwin/fs.h
> @@ -19,4 +19,9 @@ details. */
>  #define BLKPBSZGET   0x0000127b
>  #define BLKGETSIZE64 0x00041268
>=20=20
> +/* Flags for renameat2, from /usr/include/linux/fs.h. */
> +#define RENAME_NOREPLACE (1 << 0)
> +#define RENAME_EXCHANGE  (1 << 1)
> +#define RENAME_WHITEOUT  (1 << 2)

Please only define RENAME_NOREPLACE for now; that way, software can
probe what is defined to know what will work (defining a flag that will
always be an error is not as useful as leaving it undefined - and while
we may add RENAME_EXCHANGE support, I don't see how we can ever do
RENAME_WHITEOUT).

> +
>  #endif
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index efd4ac017..7640abfad 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -481,12 +481,14 @@ details. */
>    314: Export explicit_bzero.
>    315: Export pthread_mutex_timedlock.
>    316: Export pthread_rwlock_timedrdlock, pthread_rwlock_timedwrlock.
> +  317: Export renameat2.  Add RENAME_NOREPLACE, RENAME_EXCHANGE,
> +       RENAME_WHITEOUT.

This needs tweaks to match.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5aoKenAcXIeioveJRdSHn3hLAbbnPF1eX--

--vOwhc2dRriDWh5o9tLT76iOqPJNN92Xs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmW+rAACgkQp6FrSiUn
Q2ptWwf7BZljrkBPB8DlgnmF/rt42I354lZl3CG6GVRXA5VKcgmcrDpuaV6JmNFq
w8kC3bElJqAa99pHTBNr+I1I8dQrfttpoT3lvczPwV9aFh0MvyBO+VFNdL5RVxq1
cy9ZJ4C4Ur7/b3pvo5w3Dc8hUptEyIVO6zoX07EdTE4WkcYDESJy0uSLfI00VVda
izrdntTf86Jf3F8zDzVob31qaA2d7G7fDlTnLmavN9VPnN+bU5FLhQe+JvzAM4S+
LBQ2+Ln0/2P1qEVnx0I/LPm9XSa9G0ZMSUawHvlSxZh82K3Vu/bT16KVv1UtXEnZ
oHmWpPXMkmVPEmfiKa5LU+SuyzIKOQ==
=C4Iu
-----END PGP SIGNATURE-----

--vOwhc2dRriDWh5o9tLT76iOqPJNN92Xs2--
