Return-Path: <cygwin-patches-return-7911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28595 invoked by alias); 23 Nov 2013 13:19:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28558 invoked by uid 89); 23 Nov 2013 13:19:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.0 required=5.0 tests=AWL,BAYES_00,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no version=3.3.2
X-HELO: mx1.redhat.com
Received: from Unknown (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 23 Nov 2013 13:19:36 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rANDJTVo026698	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2013 08:19:29 -0500
Received: from [10.3.113.132] (ovpn-113-132.phx2.redhat.com [10.3.113.132])	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rANDJSfn020625	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2013 08:19:28 -0500
Message-ID: <5290AB60.7010401@redhat.com>
Date: Sat, 23 Nov 2013 13:19:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
References: <52437121.1070507@redhat.com> <20131015140652.GA2098@ednor.casa.cgf.cx>
In-Reply-To: <20131015140652.GA2098@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="Pg5jS43vC05BGNFWhhMl3skt6g0xHwnL0"
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00007.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pg5jS43vC05BGNFWhhMl3skt6g0xHwnL0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 871

On 10/15/2013 08:06 AM, Christopher Faylor wrote:
> On Wed, Sep 25, 2013 at 05:26:25PM -0600, Eric Blake wrote:
>> Solves the segfault here: http://cygwin.com/ml/cygwin/2013-09/msg00397.h=
tml
>> but does not address the fact that we are still screwy with regards to
>> rlimit.
>=20
> Corinna reminded me about this.
>=20
> Sorry for the delay in responding.  I was investigating if setdtablesize
> should set an errno on error but it is difficult to say if it should
> since it seems not to be a POSIX or Linux.  So, I guess we can just say
> that it should set EINVAL.  Would you mind making that minor change and
> checking this in?

Yikes, I still haven't done this (and was reminded by today's
announcement to test snapshots).  I'll try to get to it pronto.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Pg5jS43vC05BGNFWhhMl3skt6g0xHwnL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 621

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSkKtgAAoJEKeha0olJ0NqJZMIAIJsPuGBb4gJZCNyWopQLcTB
6BF8jZi75mfqGZZCk7ZFLrSPog0T5HRHMNeH/5VRKJ9SR2qN+lkTqqATEp9oDQnY
iMlR0Zyla8dBjSepFClc4265A+norss1P5nvEraG0NevM2bmCbCB3Tl/upSysAX+
5EHcOQaj3I6zQCHxqW573C5OV4t97BVVcpz9zZ9I10L32g2CbFa9eJEYkcEWWsie
05PfPmRXyRoA6CeU8fXNP7lnGb0rsfsNHek9+Konh5JKjExXbIWs9Kxx661xght2
O50GfFxO8uhd4ayFskwq7ML3bZSwIkDQnRaPYMDAdEmrX+LrkJu1vWX3TgfzQN8=
=f10d
-----END PGP SIGNATURE-----

--Pg5jS43vC05BGNFWhhMl3skt6g0xHwnL0--
