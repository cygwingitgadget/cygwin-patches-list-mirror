Return-Path: <cygwin-patches-return-8556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56543 invoked by alias); 5 Apr 2016 18:47:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56523 invoked by uid 89); 5 Apr 2016 18:47:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=D*towo.net, towotowonet, towo@towo.net, U*towo
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Apr 2016 18:46:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DAE5BA8097D; Tue,  5 Apr 2016 20:46:49 +0200 (CEST)
Date: Tue, 05 Apr 2016 18:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fwd: Re: [PATCH] Be truthful about reporting whether readahead is available
Message-ID: <20160405184649.GA4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de> <20160405135549.GE26281@calimero.vinschen.de> <748397985.175721.a41cd152-02d9-4741-9845-0d01439e7852.open-xchange@email.1und1.de> <5703ECD7.1080502@towo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <5703ECD7.1080502@towo.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00031.txt.bz2


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1881

On Apr  5 18:50, Thomas Wolff wrote:
>=20
> >>Von: Corinna Vinschen <corinna-cygwin@cygwin.com>
> >>An: cygwin-patches@cygwin.com
> >>Cc: Thomas Wolff <towo@towo.net>
> >>Datum: 5. April 2016 um 15:55
> >>Betreff: Re: [PATCH] Be truthful about reporting whether readahead is
> >>available
> >>
> >>Thomas?
> >>
> >>Any input?
> >>
> Yes, let's fix the patch so. Sorry for the flaw.

No worries.

> Thomas
>=20
> >>
> >>On Apr 5 10:52, Johannes Schindelin wrote:
> >>
> >>>In 7346568 (Make requested console reports work, 2016-03-16), code was
> >>>introduced to report the current cursor position. It works by using a
> >>>pointer that either points to the next byte in the readahead buffer, or
> >>>to a NUL byte if the buffer is depleted, or the pointer is NULL.
> >>>
> >>>These conditions are heeded in the fhandler_console::read() method, but
> >>>the condition that the pointer can point at the end of the readahead
> >>>buffer was not handled properly in the get_cons_readahead_valid()
> >>>method.
> >>>
> >>>This poses a problem e.g. in Git for Windows (which uses a slightly
> >>>modified MSYS2 runtime which is in turn a slightly modified Cygwin
> >>>runtime) when vim queries the cursor position and immediately goes on =
to
> >>>read console input, erroneously thinking that the readahead buffer is
> >>>valid when it is already depleted instead. This condition results in an
> >>>apparent freeze that can be helped only by pressing keys repeatedly.
> >>>
> >>>The full Git for Windows bug report is here:
> >>>
> >>>https://github.com/git-for-windows/git/issues/711
> >>>
> >>>Let's just teach the get_cons_readahead_valid() method to handle a
> >>>depleted readahead buffer correctly.

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXBAgZAAoJEPU2Bp2uRE+gtJEQAJq2XyY5jNMqMuIdxzTQ9ifM
R/V0sQeiQqwyugqKuunau2nsHFlA2b4IOHq0DNYui1cv2iv8sKJI3CiwAA1uiBdr
q7zW8PFBNUsSZdkXFJvJD3KuFyv1V13oP6LABSTVMlBbunXiBRGvhfF0UObaDcHt
MTKamxo8g9Cgs64BtIQfzrRlfQA46yDqnYgtUOaomHJpOJygVIsf1epXSlLyr2GX
IPbjKqGx2YA5sT2RQYYQZyufFe9nEf58qai73D3ruNGzLXo6Nvk4B6e0BCOa3lxV
N2gBFq+9fEwPJzoRLgmCRXSxVtRx86H4/WvwN3Myek751ST+b+M0D0ez0/F9eCD5
a4o8KrntkFLb+VRt7OQTA0sAzCkVwZLRycn9f9gdbjBT8nUKA9kbui7tQvW9Guk4
JZa8QD7t+taJ3BrmZeJo3UCr+/WPkNoPKs09mD9VadychvC80/3z84bR7bV1EWqv
dttbuf0wlZjfKuWMQxKbM1qUAySOs+oqE3nRy49l4KeU9NZNkkcaWkdBfl1vX0f7
wKtFzDwbdO3DT/0v/Sj4HVXues2r+aBd/s/E6uRB6niO0FGBL2iegiwOR3ZmNcXU
txQq3xfiJIx4SLdBg1J3lzA2rew5IrJYKwQVUuvo6m8FshSs215hfyuP5gsrmNVN
mCvO5P69QtGuof4mE8r9
=bcQm
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
