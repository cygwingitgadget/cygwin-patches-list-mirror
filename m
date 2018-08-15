Return-Path: <cygwin-patches-return-9174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44340 invoked by alias); 15 Aug 2018 14:53:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44309 invoked by uid 89); 15 Aug 2018 14:53:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham version=3.3.2 spammy=hereby
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 14:53:35 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue105 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MXGy5-1fKLOg375x-00WGXY for <cygwin-patches@cygwin.com>; Wed, 15 Aug 2018 16:53:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 16801A805A5; Wed, 15 Aug 2018 16:53:31 +0200 (CEST)
Date: Wed, 15 Aug 2018 14:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
Message-ID: <20180815145331.GI3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl> <20180815115216.GG3747@calimero.vinschen.de> <b864099bfc8463f205b585ba89a6d507@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YZa61AII3s1sGKYx"
Content-Disposition: inline
In-Reply-To: <b864099bfc8463f205b585ba89a6d507@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00069.txt.bz2


--YZa61AII3s1sGKYx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1281

On Aug 15 16:22, Houder wrote:
> On 2018-08-15 13:52, Corinna Vinschen wrote:
> > Hi J.H.,
> >=20
> > thanks for the patch.  Only problem, this patch is non-trivial
> > enough to require the BSD waiver per https://cygwin.com/contrib.html,
> > see the "Before you get started" section.  I add you to the
> > winsup/CONTRIBUTORS file then.  That ok with you?
>=20
> My patch is non-trivial? (I will hide my surprise from this point on!)

I didn't make the rule, sorry :}

> Ok, I have read https://cygwin.com/contrib.html, that is, the "Before you
> get
> started" section.
>=20
> "To do this, just make a public statement that you provide your patches to
> the
>  Cygwin sources under the 2-clause BSD license." ...
>=20
> I hereby provide my patch under said 2-clause BSD license. Is this enough?

Yes, thanks!

> "You can do that with your first patch submission. After your first patch
>  has been approved and applied, your name and email address will be added
>  to the new winsup/CONTRIBUTORS file." ...
>=20
> Sigh ... Go ahead. (yes, sigh. Usually, I attempt not to reveal my name, =
but
> is ok this time).

I know what you mean... OTOH I think it's an important part of Open
Source to know who contributed a patch.  It's also nice to know you be
name :)


Thanks,
Corinna

--YZa61AII3s1sGKYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt0PmoACgkQ9TYGna5E
T6Dhog//UUHCP6vRX1SkbHWK8+mNG1IqSkvhQsBblWl29ivkxStnVCzELkQoXCTT
Hf6maT7gIdEzRqf5HzbcN+orhsQYLn5NQ/Pac1dt2mF+LPSKCZazZTRX3LcbFlXt
/Inc+5gI3tiXJWjFylWd5nzWlo6anwGHDpTBL7kCN0D0+ZdL7q8d+NLUZGf3iEVC
AUu04J0wRZdwmZeg8FiycUE14ZHSXdRodvWRaOjU6Ot+SC7Ypr94sg1loPEHNz2l
K2gNkbnf5Qpyey7r5ovpAVE2Pyh0WaGI8l6Z8RGbtgmRctvwQytfo2MW1gKwa4qM
d7t7YBxrNc+PsRZEr9ro1KwLOrLoOBr0gzGILfItjlgmo7JfoHHTxyU7a33NkefY
4jCd2dHe0BkNRvAMWx2bmHf4ELKWC4LvHjD74m4cveul3du/NexILdtUQY7D44Wo
9q4ESGTrRQjumtCZ9ky7aUleOg9ADrFpHWmvk+/aNjWCA/CrGeyB1cqFY+gAIMcq
fkSm0lRRo9jmvzCMSUGgewzvKH7saA89HbglBZBsMtmvWTaiOrgE5PIuZK1fNdXp
NxQnKzFH1PcBP6Jto/9189ijmZ5FsRhKjGueF13wruIAJ/xhVuTL4cO1dO889cDp
/8KxWArxe9yi3TnkanZtxP2VMsYSwUD5G0Nf1syNNZ1CagUc9cE=
=urYw
-----END PGP SIGNATURE-----

--YZa61AII3s1sGKYx--
