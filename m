Return-Path: <cygwin-patches-return-9060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105831 invoked by alias); 29 May 2018 16:48:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103152 invoked by uid 89); 29 May 2018 16:45:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=sk:status_, sk:STATUS_, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 29 May 2018 16:44:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MgJKE-1fjF2U45UU-00Nh7x for <cygwin-patches@cygwin.com>; Tue, 29 May 2018 18:44:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 703E8A8192C; Tue, 29 May 2018 18:44:56 +0200 (CEST)
Date: Tue, 29 May 2018 16:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fixing the math behind rounding down ch.stacklimit to page size
Message-ID: <20180529164456.GJ3501@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAA9Bwxb2bzBMha_QYRQkVx0pSpY989P7DNM8hikPFeezpn796Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <CAA9Bwxb2bzBMha_QYRQkVx0pSpY989P7DNM8hikPFeezpn796Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:8N9kw5ZGbPM=:1hNHbeQcCHb1593xDoUbj1 OiRaqswyuhMmkPaU3XFiGX6s+Y0JfQzuKNaJerN6nEirBcr2odi/9xChc/Kfc6IM3LC+lXfXH ALU93W6Tfhzo3UzDMLGsa8wahA6r0U0OhRFeF5B6hLdZXkKxVgGk2N3YRo6apndrT2PdxQ/8p oynK5I8KqkLF+E1q7Ddui2RXqnI1mk4FIVkAY8rCu9xskcKp5lpvQedPI2rHy3YJz5QgyPWJ3 HB9NKKy0fHmx14jAr8hemss0UzpateZD3WE4vJHpCj+3YPeFHBzN151eip23Zi4oOtKLS6xjt e5LR8qhev93SHO1BaeUkS7FW8Mb9BaftHij8JcW+TcLnsMyZR2U5taOiYV6ASpryoSW8KRw+Z 7aGx8rCzRCX8llwN+d7aDDWeLReBBKV/5g3smFC9+EytdUIIG/LrXye2KBcp++9tJ8LE3uZ1c 2alS8UVMBLRhVJaefU+0R0l1RJNanbl40sg+BYsK2fPEFQjTI/qlFyHMTerAgwZL5AEr8s/I4 rlohc1KgWa9Qp67B0PmT1VOVA9gznA9MIEPKFwzXbx73V7JxrH84kvnJ8cgD9dFT9VHlSmfXo XVcSBVAT6ATaiA92jwqTYuZjQVw+CFv630IF6Y238dV2V2XZtbTbxiHLxFUfGoZ835G48w6Hy lL3d/GnzaHYwCboccLRGtuwlU/7MKlinrZ/m299nUr/sgRNmDCSTKFGD+IvI9vKOJyX8=
X-SW-Source: 2018-q2/txt/msg00017.txt.bz2


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1394

Hi Sergejs,

On May 25 17:43, Sergejs Lukanihins wrote:
> Hello,
>=20
> Looks like ch.stacklimit wasn't being page-aligned correctly in
> fork.cc; you need to subtract 1 from page_size to do it correctly (see
> the attached patch).
>=20
> As a result, this was causing stack-overflow exceptions whenever the
> stack needed to grow beyond the stacklimit value. When the stack grows
> beyond stacklimit value, Windows uses ntdll!_chkstk() function to
> check the stack and map in additional stack pages. However, it expects
> stacklimit to be page aligned, and the function does not work
> correctly if it is not (it triggers STATUS_STACK_OVERFLOW, even if
> there is enough stack space).
>=20
> Normally, this was not causing any issues, as the stack never really
> needs to grow, but it was causing issues when AV software was being
> injected into the process (specifically, HitmanPro.Alert being
> injected into git=E2=80=99s sh.exe process). Due to function hooks, it le=
ad to
> a bigger callstack, and more stack space being required. Making the
> change specified in the patch actually resolves the issue.
>=20
> I am providing my patches to the Cygwin sources under the 2-clause BSD li=
cense.

Good catch!  Patch pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsNg4gACgkQ9TYGna5E
T6DDBQ/6A5zIbjEhhXIniivq9QQZ0H6re3Qs8hobhQKngW0wSniZoVPVSuwppM0F
+AVaZxhsLAe055mGKCiMHxMZZrJUMDWnrneF/dAujfQxvOnlAuUIs7yFbUR0cJIV
CNY97iKMlbdGeVUdL7guOg3goqfZMkoEhoaeJCb3JZ0CWK2pipM8e4MpC6YtNGqz
tDjOTOZvIFLOW2j8Y9GUjfG3xcR05OV5+Jd4LxnG7ne+k83XC47R+eeq36FF4IIc
Vk4u4yNWXeg3HvwQvm1y38DmiGW288iJB3W1WVYv2P4QPCEgu9tw1FCJrjhIx+qt
bL8B8IDS/9YG/IY3pJq2qxRSowY+lQLIfg8bKyyN6NgR8gKRV6Ti3cCwWWtmmnRw
6FfNcKjnzCF/IbGcElqqzknjGChh2wK/ZTgOYaDkwy6H7u9KucAYwZGFJBJwAMaw
5pnYtmAvLC7XKwIpb+zvLlbF0U/855zZMXEkO2wYL4VKdewpLwHbb6w8BsDG4w68
VhX8zqYSvy0cQv+69CVwO7riumT3aNe4xRKJ4nSOrWKszB/ExFUOt9nRLAUWKYam
lwUcHVs4DMO20Mo9tnguc6ghZcIpy1EmgxHaCWNbCei88WmaUwSt36JTIXZHQIvE
djY306uF+Xeoz+5CN9cJyiQX4vwNJpnuFIfvZ6m7y5MXIAhhVPc=
=DNyN
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
