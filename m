Return-Path: <cygwin-patches-return-7717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12977 invoked by alias); 3 Sep 2012 11:02:41 -0000
Received: (qmail 12963 invoked by uid 22791); 3 Sep 2012 11:02:40 -0000
X-SWARE-Spam-Status: No, hits=-8.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_PGP_SIGNED,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-pb0-f43.google.com (HELO mail-pb0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 03 Sep 2012 11:02:27 +0000
Received: by pbbrq2 with SMTP id rq2so7170463pbb.2        for <cygwin-patches@cygwin.com>; Mon, 03 Sep 2012 04:02:27 -0700 (PDT)
Received: by 10.66.76.130 with SMTP id k2mr33309177paw.19.1346670147330;        Mon, 03 Sep 2012 04:02:27 -0700 (PDT)
Received: from [219.92.162.192] (pbz-162-192.tm.net.my. [219.92.162.192])        by mx.google.com with ESMTPS id hr1sm9709997pbc.23.2012.09.03.04.02.25        (version=TLSv1/SSLv3 cipher=OTHER);        Mon, 03 Sep 2012 04:02:26 -0700 (PDT)
Message-ID: <50448E3E.208@users.sourceforge.net>
Date: Mon, 03 Sep 2012 11:02:00 -0000
From: JonY <jon_y@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net> <20120903103518.GK13401@calimero.vinschen.de>
In-Reply-To: <20120903103518.GK13401@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigFFFA0F7254B9DA3BBC7CE174"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00038.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFFA0F7254B9DA3BBC7CE174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1042

On 9/3/2012 18:35, Corinna Vinschen wrote:
> On Sep  3 17:34, JonY wrote:
>> On 9/3/2012 11:05, Charles Wilson wrote:
>>> On 9/2/2012 1:51 PM, Jin-woo Ye wrote:
>>>> Now it is clear that this patch would be needed other relevant projects
>>>> such as mingw, mingw-w64. thanks for your effort on simplified one.
>>>
>>> Yes, while it is not required that all of those systems stay exactly in
>>> sync, there has been some effort in ensuring that the pseudo-reloc
>>> implementation used by all three remains very similar if not identical.
>>>
>>> Please bring this patch to the attention of the mingw.org and
>>> mingw64.sf.net people, if it's not too much trouble.
>>>
>>> --
>>> Chuck
>>>
>>>
>>>
>>
>> Original message already forwarded to mingw-w64 devel list. Thanks
>> Jin-woo Ye.
>=20
> Do you want the patch I eventually applied, too?
>=20
>=20
> Corinna
>=20

Yeah, that will be good too.

I forwarded the CVS commit message too. I'm not sure if anybody else is
more suited to comment on it than Kai, he is still on vacation though.


--------------enigFFFA0F7254B9DA3BBC7CE174
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 196

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iEYEARECAAYFAlBEjj4ACgkQp56AKe10wHdHawCbBWvUKlA2EsHGB4212EXS3nqt
2OcAniSk3ohfcJaINSSVNUwI4YiU8ZXM
=v58f
-----END PGP SIGNATURE-----

--------------enigFFFA0F7254B9DA3BBC7CE174--
