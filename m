Return-Path: <SRS0=bLel=FB=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 490BA4BA2E18
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 10:27:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 490BA4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 490BA4BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783420021; cv=none;
	b=drxew+8o41QcOGVMIVRckZTq3vM3MoZHECXhaKqxU/i8OyAMM0YttyyNAIGuv0m/AhN+i5+ZsmdyBYojXhTCl+TluT9vMwlxXIeduSnXl4cEgVZV1crHog6uE04zHIgH52+FJ+2HvHZvHop4Xa1QJnD+H6WAMJsaLm3PGBFLx8s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783420021; c=relaxed/simple;
	bh=P9a/+7cQRQGOC86pvnTE5SjEWAd9WMFEsXR97fiuD9o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=SUPScJZHtu880Y0of8AbmL8Ub0gN9bUIMWSwegMnbiub0yS3/7jc/4JqVWFIXfRs0/aS6OtPfdgd6yU2FnJAtHQyHMzcUJfAw+rR1LYllLKzC1qJm/wfYbDUyRoVi7w61YFSqYBt8j3znr7t8R+aFJ0sjsbJUg3TG6JQWTrrMMI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mnUZQgrG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 490BA4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mnUZQgrG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783420015; x=1784024815;
	i=johannes.schindelin@gmx.de;
	bh=P9a/+7cQRQGOC86pvnTE5SjEWAd9WMFEsXR97fiuD9o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mnUZQgrGoXVcP3MkG89EmK875Y/aATFt/dCQgZs6QAXTI0tfbUkO6obcZU1PUSYL
	 QGTk34dlYatS6QESPJ/AH7M8+urf91JmNZJE1XmhcuMVG0+Wi1itW0c/pKmdo31Sy
	 Hfn98JEIy3qIc5wmnthVcuCEJdsSPMJGbJbps0ZhrgkDfM0+SuINjsLclQXVPkiIe
	 f9QvvuAmDjK9mjG1JZ3JzRRmwgSkk2Lxj1aAzhsEaSoNBmdH+9/duHg9YxjAHCAAD
	 h37QUXkAqCeCQBtuShF2og41N9EFJgfRMHVKBi/Hvq3P29FQ8tF7WkPUo+OwfI1v5
	 SdVrZ331Zqxj/46G9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1wpbaL47LL-006guT; Tue, 07
 Jul 2026 12:26:55 +0200
Date: Tue, 7 Jul 2026 12:26:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
In-Reply-To: <20260630213547.e66059127f8007b244c09ca0@nifty.ne.jp>
Message-ID: <06447147-dce8-0172-9523-a9dcd2a3ec25@gmx.de>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp> <20260610163533.10187-3-takashi.yano@nifty.ne.jp> <d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de> <20260629233017.5e6eef4020915f0154623954@nifty.ne.jp> <20260630011456.ffd645885e56f7d33b4d1412@nifty.ne.jp>
 <20260630131135.e6996786a3b3ab8316d0ae3e@nifty.ne.jp> <20260630213547.e66059127f8007b244c09ca0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:1vwjbKDkE/iMh9p7eg1Hq4vlNWQegXVDPnE8EARvG4/XF/flSrZ
 xHbaex6TyFS+d/GkTSgdJNRISj6FMNaDcXcUq4vnMrSlbMCIgkTyILR4KU9MmndkxfNo5nM
 f8q+HgeeUoAJndLYBRuN4BfA91KikvkL5HF9uj0fm7QLo11FSX/OhA1ZQfMWxhorwFtNprb
 sJpIoSWnrpqWQQTIAql8w==
UI-OutboundReport: notjunk:1;M01:P0:iLf+GowVN5c=;+QPCISD3XIGQlDKcdCe8XtPZMSS
 p8/x+Jkg6ySS1+UXKAE0vi3Pb6Aq3q3veDSvfX03oI1QJmqIeOtWtXhKC6bLT10mucXUv8J4o
 q13U1vI4r6GjZd4E2HT8gpa+75onam7VFr6s+da22+wP5MOxM5LHNcowH0vW8qYOnRz9zmIGq
 H7g8HCAwN1H3KJJbbRdTz4sKuKc4NNDqctOf5Px3ZLWfjnIb5Jsmbla8CL8MV+G5AzwSnoiiF
 PAU6tZeZvv4aloeGrYkW+D7ITfSTxpjb9tyzdge4seP1qxTsK0cYVV+cw5WpyDdIAgg2sCK2w
 ilQfz+HOx6JtouyAUfDpp/BhQYiwfZRQfk4nhyGPFJ2i0fSV7J1X4xEkap0gRmzt+kaYp/XBT
 xn08Qz6AN6L2ixVa6ZsC4o7I9H3fWCz0ouoyp3MUYGV+C48aJnF3Hk4b1YFmxseNTH+PdIpEa
 KXywVxNG/7+YSOd2WR//4HY5KOrFgP9yBcjtm04MBlnTx1KurINOy4ijHummHQKptuBa/4wWI
 PIxvxKDtA2o50MZVCaMJ22aQuc94eCFLgKwDeJrCJlu+2qZWewnjCF36A4ahF8m0jtC0fmCpp
 HT8s9uBJk+BBQ5EcbdzL3Tn/1cWpM+ZC0FJTsB2gW02svcXV12eeHqO4uWi62ZdvfyT96Ehlf
 ddHueVDTkfpqqQZeCV2eDP+CKkg7OEXrQqheYtuDLUMdsgNFw86YA2iNMol4iH5UZXFJBkyWu
 D79NqYtT0a1dCeR6PAIdY3OpYfpJjUmb9JcI7Uf246a+WAUBxy96WpXdud1AyE6KcYRGMFGZS
 DC6d7MK7SGOELKwVkWqJs5dEasyqDIYOmxU8fcssd4oXvv97Rgq+CPJHbRWeitFdji7etVZ0j
 a0DL3t3UlhQE+I6NgnogrrJEuaBVVW3jRv/ExjiL07a5OFbNrGFyBDrOoeoRhVb80SjkxbitP
 12WJPkJgQYyHBYd7NerLV6fFPDi0ijzrtP5JHRsMPFtPDS+0iAUQWEZ0gf56phQAMkOv1MhlW
 eTBoRvlW3+VSoysJVp8YFQRxC8lKwYZYcB8g5I6WzECA3ymG5tar88qIiKn/FPvJkXU+BBZAP
 5l/mOtdbh8T/QXfXVVmpdi5Nf89jlwtoSN9TnQW91MaVZxaWfEzXIiN9/5ogYg/2uFzAwroNr
 dO2NnhsOmO9KMEQLou9SulcTjlsxOplSEd/CG64c/WJD6J4gnVZuQmWY8LyGnlHl38569pMkM
 greL50gcn1nWDNGaSHquGwbpT0xDYXrOUj9AILJ4zZsOE7JDtsEPtcsxF3hDq71OgQRqiR31D
 0jTWx05Lx3EM9duqFjzAO/wp7Dnc6NkosuXL0wLTaw5PGCLmVYlEGpbqF9n8Ieml2KyB8A4Tl
 yfWlWTsiijKhr+lN6S9trfzr8YxhSxp37aw7dOFgK+CXSEWUtTkk46wEkxuUteSpMYKqn4CaV
 tpSAQ7N2KqMFCHQV7hmKabWnlDvd2nrsK87svVe7zHz8qiWqHp2EYlCT7aBs4HdCNMjT+yWhq
 p5TqBTul0bRQsa6i8v/JTmtm8c6u7vhWPQ1AMxI9r4B7Tgq1BSAKm2FNnR7ItF9pPVQdq4fyE
 /vIFF7DBGaaZrX7Z+ldlScppKawed8ouN98QJZjLGNeEyMFLS1EXofSPi4ZJGG1/7RXn7aIc/
 Us7it3KI4URTsU91a8TNSozCHOFBXvLUOvELTFHovOYi/qj+BwUTmp8HCO+6ufM8653ncsjuN
 5KLEr1mNQipboLaL91/PODdO+wFyOSnmhMxitAaTMPKjGZ0R+qrPHpCQptof/ct/oLekw6s3U
 Go4tO6h0ngjj7A2cPk/071R1JTSAcoq3sWi4jnwVV0ABegyW/nqIK2UkWW5E/AK9Ep8iqdioO
 LDRgKpXFpDyCA0D9UwBMIDjOgIaMmvKaS9ABEw+ky1b0D0HZtK+oMZ7cHaRPtqWJjXmmH5rrP
 H5R6R9UOBPUT3GXSmq5VfC+dMaI/l+ntj0sUWucFebL+Yg1WYcxrJwFGxJ21XWcb5xNMR3V4S
 kIpBSEp06hBCNsiWYkmjtDAsQyJiluzP0jk4s8FF0+Z5f0fq2dlj86sQ5m+PbHr3CrG0bp7b/
 ba/6fvGvAlcWS/BXXM1EL7dhaPj+VVWtPUPkkZqaPkSiM6P/QYDtSzxTlkKqU9EVrgSjyJuBT
 bPWSDAvL3Xdpu3QyiButWQc4PgnxFMBJB8paZ/IHdQlLOY37kKrmO6Wwniof1Shrz0O3P0K44
 gD3pzO/3Kt9+S00uKwNURVTALGrGMj/a3FUpFIWCQg+QPAA82y1wcK7os/rLW28yHpGCLIkTy
 HQ07bHI3VNLpD5Rc3QoOi2H2vWa/Tr+4G5UXtJjgvPhBk/6rq7rjErZfvSnrcrVQKl5fsBsdZ
 ehrXYCKocp19n9u88t0eGXA1YsA0cS6b4dUnLdcg77z3wqgjnFPYt+Ky9c1Sa62r2Tm/PmwyV
 BCzGMKJlLuF38b1+ZqyvprjITx9fPAhqq5HAoJxIY9cifhny++ewRbgYhU0EV0l719mppaY5+
 3dO8tNyUCyLfw0XQTeC2SNIZC6e7P/jQvY1A4DXlVbaAGZE/eh/W5sGIGO+RHFfgSfEiciNvt
 DTzpsypZPjoNEN1+35pI6JKviVbgHKMO/Rl85ZvJnsVnCU4T614NwB9gPOoj7iRFqtaQ802t/
 KOB1VOX0lT6AVwLpjYSKzWuRdPxD0BvHe525ibLOXxh3t+MWdhYr/hSR/1C9RyEAY5BYtSX7b
 PP4JLDDSS1Y4AthlxvTivV1/ojN7o+QMUmMQhCsOwDoTN88YHYgPUM5kmGeMsrScwO0ks6mJm
 OOLFAD+IWRRRXvDL+qaMGPw4QFbn+qPl9xYw5GFhGeL7l7iz0y7jPYkXOVUa6vdQG1H7Dn2dA
 i5nf0UzzH9IlgwywH6lycrR+660NPfugInJH6TTTQmPaSARmxJ3rS0QrnFoec3Aa9oO3VsAvM
 LZ3+eNvbIdqMfZSruT4vcjbSlRTQ8cdu4Fn1eKN8Ffur263lf8/FOel6M6W9yWJcYPyygp1gH
 Z/cdzP5gZmpHR2+XH+pBNFGRkqFDGFV2EnvFrX64M8iPvfPfDqFBv2Au3RSoBo9XsE3wDlPdD
 +X5e08GDhsGGfVFhYVEGXdh/ukXMmbDPTLj9FP6sP3OkA6cvn3YPwivdh3KOb4+pUAufypZOj
 rgjPpab9ukrBnfX8zsYQh1lE+NQLiZK6SdpvM2iMyoEiEI8Q3dYKUgkw6biinbKwfTjcPkXBi
 ceLZhDKykIxK6e/sc3n9TmqiNSP2rAwuCWC/uZdWXkPT6fLdMHCNcDx7vufelwD/AIfkVFyTx
 GmRy0wE9px6mX3W6e6G6RnZHwR8EutzthkBujKKMo0QZOMdqMTZvszxoPYioPXaxcbDlnIj4W
 ojhdUmw+ye7cVBrqfZHwPooZjB5szqW0Ze6E0DJpVyjubaEkK19QhL6b031to2I08DcBEuruR
 qNX9zNVtyQ+jV9MbvF3Pf9AqHKH/MieqeLKNDy71T8Gk+KzlwL/Ry2PpMXAMNvIlxqu0DU6ZL
 /gG71VvVqw3b5/WhDK9pD3/6dkGygV7syDIi7s0Rwoqo/vElnAjYBRPeymZwHcaUW/mE4leS/
 5DL+EPC07FKGaOTu5Z3tvdz+WpMbZ5aWpR+Cxm1JcYECllNo9oFdsHaNR+zAyCJJw5uiLNmmL
 ZhUXmr5/Aqtpttx9IdsyLMGPgMU7EDit5Peqa5A2avH2Io76OE2KeuzTYkQr5xgNMeSKe7Yhi
 V/VjiywSPEPeMMjz0k+HJmQQpfrMQyAb13vkITEM6FNt6c/5ujTg7wh0ZDkqmdzdIt4wW7v2H
 oMSKMjOo7nXZ8J3J3BGatMFX8EOTxFvfs+HGm3MGZaRnOT/hY/2f8UHgdM4XIvtZjBL76NYAD
 Fp7992Sp+JNetwqqMwf7suAdgFNNsdqrUiFH5WnPUQkeAVF57wrSUvsXXj/PAqDs8ktjjyi11
 2jWxL7luorAamyS3gMDFSgEccyqQV4uatB32ahrg/lCkkV4vNDxg1d+wUq+K3DC3C0XoyMCeU
 aD+xPmNHssFL8XIC2YkS08omKhREG3Ci1Ta/oYGaCJYAt5FV6MGlOfKTDBSWaO9EBMlzx7ASu
 XpJ52FRkN1WdzpxBhMu7cKhA+6vGr7dxCeoDuegulbauhcb2ZNPUlWbh+omI1VA0cFFzVHS7c
 ZW4EPP0To1nVH7AWgBuGYvkshKSNofK05ltUjfLbniQXtjIm/RDJl2zvQEBa/O6e9QPhOEUec
 tMRAVKKqUGEVFPe31aGZGsVDpKFoZOuCbxIVrbwuFIyV/8Svd2yGgr1DPTa/+4yg1rBYFTht1
 UEnv733BQwZuoTpICHMfzn0h2QE3PChsFXgCs6/XiRsCIY8dXTt+7Ac5SIC+snZ+ZExTSZ1nW
 YbOJ0W7gfnGvIWRdW1ZZ9wXD6p5glbiKuEUi9YSwhjjHCj2jDVwZ5zMObUUMiaa2jwct4QK5c
 gtpoSSeuHASifknCo1c2BM4fa7K5U3Gq35mihjZxxGAISaNpMtc6BzuLYQxecM5Fc8KhPKsKk
 S9C9N3CfsoBhKylYeHlfscyRZQO/t5fyKbgxUnFK8Kp4HOLktmp4L+miSCuE6NMW3C06Wxgb5
 zKISlZPVM4G8wXusbzEhZFgVN2oURx7Rcx2gtV7gd8aSWyRdhOmr11Lo/0Nacd16TtVN4B07i
 ZJQvTbx4UZfpKbXErPA+M/z1a9kmR55WZZ6Q6rzfwimexnoHYwN5oTYXkBtnBuQxdxIQxIj5B
 NEr7Om/7jfJn4kD7Z5WgKBkoI+hYangZjfWPJ4dJkxiLDJj0arKDug24bmXsp1RJQGq8G/Wg1
 2m3sDS+lzzBWP8xJZNWzQZL4ySkb+BZ3jwPF488LBw4rSZZJ4ZRxLTBCLFQN7hHMKuWinlA9z
 pBIg+/AadcIFAEvtG+Tv5k/zuN3ZEynMaVcqLjD1Kc6q0vLq0uWrlr2f5P80mnN41/kz+DC9W
 4AlcIcd02noLKzLUaTLKaMbVuruUdCiKHyVLPe1RHL880I81Ln++vTlT8AhtY5GSFlVOKVIET
 DwHPAU+sTWgtIUgTgKarcNKtIUT/gBgkB45AXMQthf1NyWPKX1ftKI0FzoPWLh3Tzqpm1xh0m
 D8CdZqAQvrsQTYPy2h+AeKDQCKzP1TBUgT/P29l6SFID29xk784QfxlELb7hHpV7zPCDNdmjr
 26Sr0gHEKXoBPU5gHEMWDMNlfKAObiEfwqhPf3+agpz5Xt7HoH+5MpN9ZbXU29i6W6TqXaGr2
 tt/prrg3nUGe1BNJZlUwofheeVV+Hz7Skt+OKXBnJ+nrhqMTnYncwGMQHzYFqvJoN2YmoL22h
 IcI7Vti3lCT1e+4S0Mq+efvgSpqjc87yKceCRUcRiQTaG+PMY6n2gMDA5uUSprkHWmzHZvdow
 j1/DLfVFR34VMKGCyogh3bUih7qu5AhyBZ+rPlYalS6shW7MEnu3iWKMUkaeGGQUbUGpcU0pk
 qs7sjqVnEzymMRau1I/l7rYh2leDtjRkRUi8Pf3x76kdyTv4B9P/inpVy6gKWv5XeyhxmTNWv
 0qe8yIb+5prtn8UWs7oavyP5OwErHOJl4iYhJvFkZPvCYhz8Bc0QrIXR4ogxGfT5sfDp4w==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 30 Jun 2026, Takashi Yano wrote:

> Although you kindly reviewed my patches and even provided a proposed
> fix, I have suggested an alternative patch.
> https://cygwin.com/pipermail/cygwin-patches/2026q2/015129.html
>=20
> I apologize for having wasted your efforts. However, your analysis was
> extremely helpful, and I am also making good use of your commit
> messages.

For the record: I have no objection against coming up with better patches
(or any hard feelings about my suggestions not being accepted as-are). If
I could help with those reviews to end up with something better than what
I proposed, I am quite happy.

Ciao,
Johannes
