Return-Path: <cygwin-patches-return-8416-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67345 invoked by alias); 17 Mar 2016 16:37:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66736 invoked by uid 89); 17 Mar 2016 16:37:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1637, friend, HTo:U*cygwin-patches, perfect
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 17 Mar 2016 16:37:08 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	by mx1.redhat.com (Postfix) with ESMTPS id 47784711F7	for <cygwin-patches@cygwin.com>; Thu, 17 Mar 2016 16:37:07 +0000 (UTC)
Received: from [10.3.113.69] (ovpn-113-69.phx2.redhat.com [10.3.113.69])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2HGb6rB009540	for <cygwin-patches@cygwin.com>; Thu, 17 Mar 2016 12:37:07 -0400
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de> <56EA78DC.3040201@glup.org>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <56EADD32.4010802@redhat.com>
Date: Thu, 17 Mar 2016 16:37:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56EA78DC.3040201@glup.org>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="vUVWKAUnDKOcktkXpsFGxqotJA7XDF4Mb"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00122.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vUVWKAUnDKOcktkXpsFGxqotJA7XDF4Mb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1598

On 03/17/2016 03:29 AM, John Hood wrote:
> On 3/14/2016 6:12 AM, Corinna Vinschen wrote:
>> Hi John,
>>
>> On Mar 13 17:37, john hood wrote:
>>> On 3/4/16 3:58 AM, Corinna Vinschen wrote:
>>>> John,
>>>>
>>>>
>>>> Ping?  I'd be interested to get your patches into Cygwin.  select
>>>> really needs some kicking :)
>>> Sorry to be so slow responding.  Here's a rebased, squashed,
>>> changelog-ified patch,
>> Thank you.  Uhm... I just don't understand why you squashed them into a
>> single big patch.  Multiple independent smaller patches are better to
>> handle, especially when looking for potential bugs later.
>>
>> Would you mind terribly to split them again?
> i just looked at this, but I'm going to leave the patch as a single
> patch.  The patches in the original series are not completely
> independent of each other, it has a bug or two in the middle, and also
> some reversed edits.  The endpoint is known tested and working, but some
> of the intermediate commits aren't that well tested.  It *is* too big as
> a single commit-- but I think that's better than the original patch
> series from my development work, which I never intended to submit as-is
> anyway.

But that's where 'git rebase' is your friend. Just because your original
series wasn't perfect doesn't mean you can avoid cleaning things up and
posting an improved version.  The goal of patch submissions is to make
the reviewer's job easier, even if it makes it longer for you to post
the perfect patch series.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vUVWKAUnDKOcktkXpsFGxqotJA7XDF4Mb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJW6t0yAAoJEKeha0olJ0Nq8xgIAJa6nbrSva6tfIkLZa9sR9eR
ewsMaxIjhOq9jJaddBPzFncMhNvBCn+s23v+Akn98aUM5a3q0Ee3RIVTYXKvmTLG
9gEK0HmTMjRTkGp6WKmOWdUtKhmF1Kopva8wtz7iBQFhrlijTVlFp4moUgJFHGVx
t4Z89twL81/xirpG6gRMterbNpHM4E2co6zXXS7LbF2L+Kcaxu1Blm33ufBN2SmP
DlD2yAiorr3ZljHQjBema35V4xXsuVniXB7hma3/ic/IecX1aGwBvCMJBnUGhK+k
WiOw/g9tlLb05l0TUWBBKWpmtwug8NmFUDqJq06qqDY0NDDBF1zUsTJAP9Rc1eY=
=dgjn
-----END PGP SIGNATURE-----

--vUVWKAUnDKOcktkXpsFGxqotJA7XDF4Mb--
