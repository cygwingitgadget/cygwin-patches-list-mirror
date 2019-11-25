Return-Path: <cygwin-patches-return-9857-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98914 invoked by alias); 25 Nov 2019 08:46:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98905 invoked by uid 89); 25 Nov 2019 08:46:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 25 Nov 2019 08:46:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MEmAV-1iaZ3B1On5-00GFkc for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2019 09:46:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A9919A80670; Mon, 25 Nov 2019 09:46:33 +0100 (CET)
Date: Mon, 25 Nov 2019 08:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: newlib/libc/include/sys/features.h: Cygwin Unicode level
Message-ID: <20191125084633.GC13501@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d9b6d93-eb25-5f08-015a-ec3675232201@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <9d9b6d93-eb25-5f08-015a-ec3675232201@SystematicSw.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00128.txt.bz2


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 386

On Nov 23 08:09, Brian Inglis wrote:
> Should the Unicode version setting of Cygwin feature macro __STDC_ISO_106=
46__ at
> the tail of {newlib/libc,/usr}/include/sys/features.h be updated to refle=
ct
> Thomas Wolff's and any subsequent updates of the encoding tables to Unico=
de
> version 10/11/12:

Sure, please go ahead!


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3blOkACgkQ9TYGna5E
T6DJAA/+Mzc8sWw/TImsHb21h15YThSLPzpYsLtAI/zVtrgowXtof+3rhOQduTG/
wYOjeJMyTBFvvsFRpOgzgeD+J7Vl93HrlsCzrkAVNQ39FfvpPHJG0qb+rrFZ+3zq
QOQ01hoIIZdezTLL53SMFoviHZGeIdx6Sva4GQKFYYJOxkxhi4FQsqWJFPK5JYUR
n8arlcFbHDioaOrBrUo7Fvxv0cs1OUF+NUBjVTL+mq/vhP83Jieh+b8iXOlfL03W
aRkNBiexpqXAWTWPfZDxuDjkDBNbT59kF9X+iaGYw98BZL7s95arOpxC62xySwoI
zSeybJTUcyE4GKAIn5jVg/ImLATIlj6k3MNihyE27P5e0C7TfuLTBx3deDWzTH+Y
itQJF7tktRaqUQr66NaDZzJTfij3O6bt54rkwxoXSXCs3M91KRHGNbLt7w/GTbwc
Kztgim6ECURqt2yqRV8iXXkrEeusS6QEpG/9mf6T0I316ItLnxt04ae9EYfLmPxg
dHXr04cUOv+AJ2vlshlzoLUgXTrtX/1WiM16A5pRdqXG/qqFqBnAgGUiaLI9CisK
xcRRJAa4RVzvD6/UOz2tPoJGEpmcSe8wipZay9xHRTI7vngiVSiuBQJD5rwd3YRF
Eb3qPDbJ670PxIXUL2Wqu0bgmdBHeUg7W9ChE7NWPsHf2Eezijc=
=dYe/
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
