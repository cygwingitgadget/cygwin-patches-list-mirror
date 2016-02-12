Return-Path: <cygwin-patches-return-8310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38964 invoked by alias); 12 Feb 2016 20:32:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38946 invoked by uid 89); 12 Feb 2016 20:32:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=virtualization, blake, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 20:32:36 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])	by mx1.redhat.com (Postfix) with ESMTPS id 502878EA3B	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 20:32:35 +0000 (UTC)
Received: from [10.3.113.62] (ovpn-113-62.phx2.redhat.com [10.3.113.62])	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CKWYuo008206	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 15:32:35 -0500
Subject: Re: [PATCH] cygwin: update child info magic
To: cygwin-patches@cygwin.com
References: <1455244717-12688-1-git-send-email-yselkowi@redhat.com> <20160212093359.GC19968@calimero.vinschen.de> <56BE0DFC.7000702@cygwin.com> <20160212171815.GA21562@calimero.vinschen.de> <56BE3B05.1030108@cygwin.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
X-Enigmail-Draft-Status: N1110
Message-ID: <56BE4162.3000806@redhat.com>
Date: Fri, 12 Feb 2016 20:32:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <56BE3B05.1030108@cygwin.com>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="P4aX0diihoo7u70V8i0JCAjpGk600kJbl"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00016.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P4aX0diihoo7u70V8i0JCAjpGk600kJbl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1365

On 02/12/2016 01:05 PM, Yaakov Selkowitz wrote:

>> Off the top of my head, I don't know.  Usually only a change to
>> child_info.h should affect CHILD_INFO_MAGIC.  Unless the preprocessed
>> output of gcc differs for some reason.
>=20
> It turns out it does.  Anything that is substituted by preprocessor is
> placed on its own line with gcc-5, e.g. with NULL and _SYMSTR:

Does the use of -P during preprocessing, to inhibit line markers, force
gcc to quit adding extra lines?

In my quick testing with Fedora's gcc 5.3.1:

$ printf '#include <stddef.h>\nstart NULL end\n' \
  | gcc -E    - | sed -n '/start/,$ p'
start
# 2 "<stdin>" 3 4
     ((void *)0)
# 2 "<stdin>"
          end

$ printf '#include <stddef.h>\nstart NULL end\n' \
  | gcc -E -P - | sed -n '/start/,$ p'
start ((void *)0) end

> -extern child_info_spawn *spawn_info asm ("_" "child_proc_info");
> -extern child_info_fork *fork_info asm ("_" "child_proc_info");
> +extern child_info_spawn *spawn_info asm (
> +                                        "_"

If it were merely a case of more vs. less whitespace, we could
postprocess (turn all newlines and space sequences into a single space);
but this is a case of introducing whitespace, making the problem
trickier, if -P doesn't work.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--P4aX0diihoo7u70V8i0JCAjpGk600kJbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJWvkFiAAoJEKeha0olJ0NqopYH/RtLVhkluwJ1wEb6ttKgfbou
zFQJaKT+6N8tkxWlM+/W5hd9TddmZPJFW1LVPKTgX5z5SQoUkvanTGZqBsO+wCSr
gsl7shSaYDZCwYNE6fIhZEQfosfsukf4pBrZVjfo0fvrxSgN37CartsXUCRj2ggP
BhWI1oswLMuFj8JmxjnT5TOBnWX0bltl/XSXyf33DX7PUWr8jAwNpPzbnChs8JzL
xDttROm32cEwTbA7gdKZZGKK+D7szVZYis10pkTvXQq/rkuSpsKcPcAXngvpirv/
xcfVnpvtje/6NzansXpdrI2bhI0vdvpy7H1o6KNk6r7QaCScqPrYRhLu/Wxi5HU=
=v2KU
-----END PGP SIGNATURE-----

--P4aX0diihoo7u70V8i0JCAjpGk600kJbl--
