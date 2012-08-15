Return-Path: <cygwin-patches-return-7697-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8986 invoked by alias); 15 Aug 2012 05:11:43 -0000
Received: (qmail 8974 invoked by uid 22791); 15 Aug 2012 05:11:40 -0000
X-SWARE-Spam-Status: No, hits=-7.0 required=5.0	tests=AWL,BAYES_00,KHOP_PGP_SIGNED,KHOP_THREADED,SPF_HELO_PASS,TW_YG,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 15 Aug 2012 05:11:28 +0000
Received: from c-76-22-66-162.hsd1.wa.comcast.net ([76.22.66.162] helo=edith.local)	by dancol.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)	(Exim 4.72)	(envelope-from <dancol@dancol.org>)	id 1T1Vt9-00076O-Ig	for cygwin-patches@cygwin.com; Tue, 14 Aug 2012 22:11:27 -0700
Message-ID: <502B2F77.2010204@dancol.org>
Date: Wed, 15 Aug 2012 05:11:00 -0000
From: Daniel Colascione <dancol@dancol.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: New modes for cygpath that terminate path with null byte, nothing
References: <50124C62.9080405@dancol.org> <20120727093245.GB30208@calimero.vinschen.de> <502AC7DD.5060003@dancol.org> <20120815050205.GA28917@ednor.casa.cgf.cx>
In-Reply-To: <20120815050205.GA28917@ednor.casa.cgf.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig1C10ABE751F6C0A6319396B1"
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
X-SW-Source: 2012-q3/txt/msg00018.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C10ABE751F6C0A6319396B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1248

On 8/14/12 10:02 PM, Christopher Faylor wrote:
> On Tue, Aug 14, 2012 at 02:49:17PM -0700, Daniel Colascione wrote:
>> On 7/27/2012 2:32 AM, Corinna Vinschen wrote:
>>> There's just the problem of the copyright assignment.  If you want to
>>> provide a non-obvious patch, or if the patch adds new functionality, we
>>> need a copyright assignment from you.  Please see the section "Before
>>> you get started" on http://cygwin.com/contrib.html and the assignment
>>> form http://cygwin.com/assign.txt
>>>
>>> As soon as my manager has the assignment, I'll apply your patch.
>>
>> Do you guys still want the patch (and papers that go with it)? If so, co=
uld I
>> discuss the particulars of the assignment off-list somewhere?
>=20
> As I mentioned, it seems like you can easily get the functionality
> you're looking for by using standard Cygwin tools so, IMO, we don't need
> your patch.

I didn't know what the final decision was; that's why I asked. Corinna
said she wanted the patch. As for the feature itself: piping through
tr is fine, but having cygpath output paths in the desired way in the
first place keeps error information around (without pipefail, $? is
tr's exit status) and involves fewer forks. There's precedent in "echo
-n" too.


--------------enig1C10ABE751F6C0A6319396B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 235

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlArL3gACgkQ17c2LVA10Vt9GgCfTlAtnMdb+cjsrLd7KpgiGgQ0
9AsAn2N06dWX1KcD1YMCqHYjUBsG3V7l
=BvmI
-----END PGP SIGNATURE-----

--------------enig1C10ABE751F6C0A6319396B1--
