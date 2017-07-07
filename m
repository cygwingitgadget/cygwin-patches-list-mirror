Return-Path: <cygwin-patches-return-8802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115803 invoked by alias); 7 Jul 2017 14:46:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115777 invoked by uid 89); 7 Jul 2017 14:46:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jul 2017 14:46:20 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 9FE057F417;	Fri,  7 Jul 2017 14:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 9FE057F417
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx01.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=vinschen@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 9FE057F417
Received: from calimero.vinschen.de (ovpn-116-16.ams2.redhat.com [10.36.116.16])	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CC307F558;	Fri,  7 Jul 2017 14:46:18 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BE9C8A805A4; Fri,  7 Jul 2017 16:46:17 +0200 (CEST)
Date: Fri, 07 Jul 2017 14:46:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: newlib@sourceware.org, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Rename __in and __out in headers to avoid collision with Windows APIs
Message-ID: <20170707144617.GH12696@calimero.vinschen.de>
Reply-To: newlib@sourceware.org, cygwin-patches@cygwin.com
Mail-Followup-To: newlib@sourceware.org, cygwin-patches@cygwin.com
References: <20170707002450.00007720@gmail.com> <20170707104702.00003877@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <20170707104702.00003877@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q3/txt/msg00004.txt.bz2


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 740

On Jul  7 10:47, David Macek wrote:
> * string.h: Local variables in expansion of strdupa and strndupa
> * sys/wait.h: Fields in anonymous union in expansion of __wait_status_to_=
int
> ---
> Reposting to the newlib ML.
>=20
> There should be no API nor ABI changes, as the changed names are private =
to the macros.
>=20
> The new "s" in string.h comes from the __s parameter. The new "s" in wait=
.h comes from "status".  I'm not sure what the naming conventions are, so I=
'm open to corrections.
>=20
>  newlib/libc/include/string.h     | 18 +++++++++---------
>  winsup/cygwin/include/sys/wait.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer
Red Hat

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZX565AAoJEPU2Bp2uRE+gpoMP/iIRzELferSPBtisGY2PUWp3
HkK0mCtv79Bt+XepnlgXxB10zpvi8BC5DyUFSsGA9NPJaDSgG4Io32QHAJWTeWlS
OBr8zUwoNtN9Z2kIP9wFcGEpo6PgjTj03GdZ+lHe1R7xGbW3jHoLoh5VONtrdxxT
JFTM20eeHM6cMS8/JfuA+kTmJnmccPIg7r1RHLMKs6OR4w+cPtUPS7zzHJx93CpO
RvrNjKT85A91L9HavwX79SZBsKrQYFMDdhdH5bcyGd5DFZ6Lh/1dXQNRE55xTwTS
mQ4yq6HpNQeUyZLOLuFd0UcI/Laz4em8JpxSes9RrzrdXDw/+atBl2FWK6ADgZPI
AKvKoDZiQFXqFqvIq4S85DJIvhs5HYyRR2cG3WB/XXjI16xugq8H0zpm/eq7oa83
qlHViyr6QJ9OxpM4DEcw1j6WShibUSSjELQ95XX3GZXFvrFqfkPTNgu+VmNF76QQ
eavlJBLbyMQB2kpyA0VaDuh9x7RsFnZfyVKj7yp98F34+WPZJk0Bq3QGhl04nX14
Y7Q+TUYy6zEvFrD6cd17kTs0LoL0NvDRcllougt7Etuk7qNMsiIXr9FnekhbmkkD
oo4VZmyX1P0dtLOK2Cr2b02W2Pr74SRPDBRdE7DOcC0fwYfkzfN5gaR8wekCGLee
Xkde4hD+gs8nvugrCBr5
=P5+U
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
