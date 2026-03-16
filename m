Return-Path: <SRS0=IhUf=BQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 5B9CA4BC89BE
	for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2026 09:32:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B9CA4BC89BE
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B9CA4BC89BE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773653537; cv=none;
	b=Jgf/uvMhhJtZmRDzGv+zwbYl53LFUEKrgndFnwvD1SFeRS0hwHILHLPZnG0RGLXHWOBc+vV9K+E7hgCMmMGG+mmTTHMbJ1LYKA4pM2DBaOE+pr30eUhLeVJqPoS+YXlWPWXmMKCvaM+CoYIe1KJ2gtHLayz42nJsJSZHHW/i990=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773653537; c=relaxed/simple;
	bh=fb1eR1rFyw+AaUjhFkPzEdMxbR1GsRZUER4wTkTr+T0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ufc/mcAeWg7VLi1vrTYgmTj3IbpUy1ZB9OB8CBStLE0Esis47mh5hayOODnwFZN9c7c5ca3YZJLJ7gA5w4zgQaMq4+zCc+hZlXbvCbz4oCcJS11QnPINRcKZQNJIwZGrRkLxe1Kbc4MGV84pljItTD15ZYLe1o8CqSn/LXSvJBM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B9CA4BC89BE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UQYFwrHP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773653530; x=1774258330;
	i=johannes.schindelin@gmx.de;
	bh=gOAuQpXNvGPhbfUvTfp3tVceLnLc6ik8BWXqXGUNwEU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UQYFwrHPf1ab3gNl33/c80cyuTOyeK0TrrZ9M/d0XAChCr9Ie59a2skSUZsVocXv
	 MeGbyM2ds2neVgAEG7ynE4PjWrX4Eyd+w/HaddgsHRETq30uwbzTmIXgQXLY9eQ/J
	 Pqi8l4sN/qR2Avba/SUMP9eLvpoy7szzA0gGQ8Rbdm+cDJJ8NgE2or7GUTOgmcc1m
	 DioGFw3SHnBGKax715UYiaaSQOk8GVMLqhbU9L77As9Vp4L6i+ZJJmGGYDQKU/iOv
	 2jIdqD1ADla0B2jy5mrX3iF0heNNVP2yk89UI7GiKvklpjRLlfuMEcAh26UZ66WAJ
	 hxCf41Va9YiI/0z/sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1vXeSN3ox4-017luL; Mon, 16
 Mar 2026 10:32:09 +0100
Date: Mon, 16 Mar 2026 10:32:07 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 0/3] Add support for OpenConsole.exe
In-Reply-To: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
Message-ID: <ef0c2255-c78f-7318-2489-0f3b90fed95f@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hSfgKN5yK+lWZtA1g7pfvrheHgXdunh5qjdPf33IYm85Eo2m2QS
 rpP38HJZ271JaRF9jvQXCmFrH4yghh+90ezETNodbSenTjAP34/W4ttAu0KxxC1jBD+vHF4
 rqRWSSpyWWR5XyBuyLSfYJomrbvs73aNQuD73NEOfVvyGxTi8a+dQK++/5XlJ/+zkijt2y0
 HnCqiApD/6Kgmjp/XmF9A==
UI-OutboundReport: notjunk:1;M01:P0:uQs0TZpJr5c=;mF5V9UL4hXW4tNjYh/kpguQRoUd
 U36atZJ1WC2cnegzd5goox933Mkrw8W7JhSk0pnUtFAt5PgtWuHfSQ8YX53fZRwRbwQgTsgIF
 V6ubR/F5ch+IbIXKv5DjjMJAC5xUy8/ssYU7I0ApYfv6/ws40EY3khorqmo2MxeLebbRTt3iN
 1sBrYOJnvTGU8R5iAJNiV77AOkdei8esy59bljhapoQFp+zhfnJ6VIuZ/jfizQl8j3e/zftHK
 1EZAAVDl2Tdd2uEpOqPuHijsripsu2D0UbhnzxkfPcF1wbl5W2anutzfehzUU1JVgqtrVqTOw
 xoL3I5UvYF5Ie3+aTOZjwUrqZbTjcJBrKSGJv3xEchAWN/3wI+ZFjW/0TMQL4zJn6bjooRtft
 rrskXGl87+BKH9qPB0PnQiuUlEIW8pprPkEoFVhCA3l/vBnzKO+ejbfADAXy64qDvFRFObX8w
 duvUsH6qDfD+hZiC6sp26V97nv4jTCq5EIdaHkE8bvTq9nc5DLWF7wTIRw553Pa8YWkWXQScy
 e6vk+VymZUTB9evFtzECwkzqNnJv3IaQFhS8CJFSOT5fOOwim4hNy+o+ryO+gYDBu/BBbqm5T
 5XKG08pzphwQj9iu+SHqSMcYZkURd+Q+zs9uAmfXFFhFLlW3GRoeDLL3ny5M3f9k6rMnmxIVu
 36X0m+Ixf5FwensvNF1BQvIZB4C8jP9ER92yS63+9kVktC6ACWAcfbX4S1EUyxpDajxlkfpBn
 BqoS9nskV/n4KI4ngIn7GVZYQse1Jepb/NVELD5LoIXexn3GzrJSGReX3vIosJAER8EY3wJz8
 /ailpZEaTB0NTkKgQkpjVJ8+EXiN+rsVQkwiD/BJDNgDYWNqShRvwnTUK6PYxqfsxD5DJQ5Q2
 xkFrQcoTr8vyAxuEVwq/tOGHrwd5gdGd84MqJs776akzOIE7GJdKrpU0G0HDGED0YyUwemOnT
 mt72nL7YhYBtpOsjyCaO8vMtXWNbs7EoqwYL2+CIcW09DbC4KwKfBseMp0qgqYsDZSuRCc3sr
 W3W15MX/emhiwSdVIR+uFtRkpnp6ealyw1zMY6wxj5iS/0rRDZZtr3GMnDXsx0ezSF1+h5iTq
 YGA6138DnKSt+KgKNqM4oCmSG2jdirO9Mbe17EgU9HFEq3WcxKRJb8d1yKy11B4l13Kc3kADR
 OFtlLDct5RsobX9O5gPgfZw8c+p9zoX+5EbexAUdN9z1ZXlSppy/4JfmMzmvseJvsy/LXXjCg
 N06kpDam5m+xsOnWAIj1gfqbIaryHPWmBGlGiES7WhqWkU4w7kDKuotNwHxYCt7eC5fWMKAYJ
 6QJ9r4UjK67Iqz9jL2Rk8mt03rLoi4Y7JIwobz+O1fVer0213jrLu16e6sMx0ccmEQl+Xc1Z/
 eSR8NiZHobmvvuPsA9Y2junxhX18pvpP4XwI2mkEuMrG5wwQiRET/HJS0uywxKXiDjSwMUkFy
 JP0ZFY+6V76E3FfXfNmDep2YGNuF1aU6OwZBdUPLdjzOVIVG4HKIJqKFqEVPkoek9SaVH9ArR
 YTMf5jEdQskQzaE0SYV2v8cgQABETWuXQ9aLN4Iqpx3ggAqAz4zjjh1SVwBmLjSaCadkcoJfZ
 ppLKv1LtJbj/+hg4EWEVp2ho9vuiNKn/cpWpva4hRd+p8nXX3ezJ0GRHAGQS7yQv3SwxDaZyt
 k8BLUijZgyw5TjeNGeZ/+PJH/T0rnVVYH4AdDfLGl4Cn52tARinTVSDFhuoHnZAXEq+iyfnBM
 njZlDB8o6G8OMJO6yJL4s9krRBS5uIGCCYC+kc5sxKTItWC4kJVe4IdF/EYdxc+9O6JQAW8Xr
 jREou2+JjGpyhJKuO9EX9qCRGYEQpCKUt7a8t2v/DX+dXw0YblIUuBLQ5rnmpl78Ahowyw5l7
 tat0kV3albJrqY45BZZMDvaSkk7cLADCSOr6QUGms8GlPRXnYG/magXO80Ud2IiGB57Q1r8yV
 K5YUnJofBqEHk6taO1yjjW7b9oQF+C1uWQcCE/KAd61ByJ8ndk+CQWLnx76Qqu96b0bclPvAe
 gj6GO+eid+EQHH1/ryJmn6odrparchlcgeIsv79kN5j2BfosQ6WiaMp2rHynCy2KAz8avBqOJ
 /2wiJh1CuMfYADShr9k4efoIPsWAsGuCivIvPd4uwr3V2N/q9KBlq4wP6b0JWDKb/GU0cwXp3
 k7AYTYLqyiHSHZy1+Oml92nkI9DCrF3HSS8Hvxboe8rzd93gn3gr1QWeuwcvouyc8aOaeZ91p
 qrEUea3ulaJCifEUHJZhFFG16/yIbNcJZGCnjw4rP5jBMXOTYA+ARCCCmpNqSGjA+99mcYQjL
 3NZM6sgYC2eb3ZiZzfEaZMbS40ASnJjBXflX162d60wxu8x5KVAHYcvZADlyhTt3v8aOoqIH4
 lLVs8qXNe5ujToApmrtjWMqwdV/ib8ssGXIe+k2GjvcLBUIokDFSNCC4EuiX+sm1ytO1hKz0S
 /zAvv554cLEUF6U4P2tWmBEfGmiQFNM4mryCez0gc3iveT1n2Ko4pI3e3Masrg/+Xh4i+pG3S
 vnZW6ZzK3odNNKju0NfqyKDhmt3rwH0GSqpjGiXKsLe7W64Gpcl+K5WEGj0GO73KYA+etpqIx
 Msxpkkjn8HOgpQgqJQ1sLmqBxCZ/sNBTudZUlQyTz78Cjog7L9DdZcoENRFBhWiHPWUEnXb3G
 WtpfJIy43so1jX8b5UE/xZtUdUI8kb9ZDlTvgTrXX5SNBtVQaKX2fyxl9GiAoR+ez5OGnL3gI
 ETxOBMUhCuUaX6VCIrITnuNkJrlReIE+Z5/K59ua4w+4xcd/wD0g2o6wnVTifrFaJ8stq4hVh
 I8jwfWM3PNUX75ep0gmxhZpPFzjWE0LVXlilNrNE0TjBpmSli2YMYtZoVXVzWWM8iKuOCEfuU
 2zoyyL+CmO4SYWlVjj9f0xpQ8DsIWbgGFHcLuygAqytaztkGCZu6/QfQl+fa7gVplMnk24SnD
 K8UQvR4ecCzAq4b0CvvxC7sBZ9yrxZmvW5YNlPkxioXg/HLbx1rrsxAJc3w97jffy4DwiQvre
 CmQm51zX7e+Swx95xLaResmmQTOso005RdikpBjxnwjSbXcTqxifBCOFHt+uLc0sOSV2V2pLO
 FLZX9x1J32RhuqUGuGmgORaBoONbOlzhmDAAQJ5wIAUAzNsJWKnEV1pd302j7BFsziX59d1P0
 e91r40beCvz42LEEDVuXDJjMFlAK0sbcUOwzRkjYpKo0J4vpA0vJ2j7bekNNtgmrW7Dzzsc+b
 gm2I0VXnuaQI8OjBJr0WyNlnKSA2ERf2T7dzt5bZWCu11VnHRdn6LCxW8r87/N9rxH+Yi3Zd3
 af2ni/Wr6I+08kGQqVTiYTwhb97ZCGx0VlIB6oh2Okqw+6N48j/32Np/DLn8q/Psk+YAJY7Oe
 20RIuyq52jX+roXV/NOBIoAYkJUWgZ9y8mWcjL4gfKGNN4uI20/xfiDjZh5q5xmBnz+fRQwHL
 +BTulAczLAzgq+ghJypI7CAEo7D7p0ueph8etxEdl6mIWbHFYNPxJglfF1i9CFNHTVhhZoYhu
 NtyVwh2ao/uMQBfg3OCA9PHZP2ePH1E5R4/oBtmsMnCGVHH82khPe5cOgnrMqg4Gy6PSjdqGT
 CkB32IkDoPMgDS1hxmLZ1/c7igxbztSt8Ukqbqt1EUgfNt/LiMNzAZq189PBvMKMN3OGYtFz0
 C4Cji64J+oOUdhdX36pqDNc9VrFq81yzIgI3vlVWIkD/lWkyt7T2v1ndJeSAClHn5lUce0J24
 zLMzWU7JxoaswPGsUBdapOlXCkIgZYDf4FlhstG8fIXUM2101jxDiru6zH13Sib8IY4FHMQG5
 94YKOzGLjJE+O6rzfRqc5DWIkco+R1m2ZPccFM9+s1PCRZDIKnc189TWMptdL3NIzdmUqFt7m
 uqRIxgHmku2InJKdooEi+4sy5RR+YMQTC1lqHjiDQRJKH+hDAaJK6m61YTTr2L4WbTGWEDBdR
 B6JsuK808h9EQWKCZKZRy63EF0M3RUVIQ6hQWOIu8RgDv5rpW4CSWBOiBQhYLHjRPmkaUoprJ
 Py+JODEPeVL4OLGWb45+ad8X+qvaBWBew+/NIm3k5wLVLYE+1lUN1aB6K6XOUid+diEES3ZZx
 LtpQ9u/euP/w6LG6EwlufW0/qsz18n94wE3j2S/x0JCJkH1iWkz3RwnMrGbq7UFHGrYy5A5ef
 2H4wnnL12UYPh5YtfvemZ1+YpGlZNt2RarDxGDpnQpwyYg/k2eWPydEDVwczmeBO7UyiG4cDW
 nNH+DRqvZnbVugMZ6B66AQkG7evelFpBZqFPh4P2u50qTWihMyICul4f844xgtCLDspSZkD9l
 6TO37GWdSF7Msya24dR+M6rm5qU645wefCmm14ZCr4ApCm0Xd2JJngOfNr6HfNoK/w7D17CsN
 utlV7tAuLxuKZfSpgp9h3LLisgaCqtaDxa4pVsAnVkiSNaBjSWV9x9gTbMB3j7Q+ltyzWKGmx
 PmaF5fYTxvUNoR4GI01ZmhX02YUfaBwqSd/OZ65CMixa2F0Tt+JwIVof9pBjY7H4yaPRWdflf
 tNzbWQGr59QMILQD4EIJPfSnJ56HZZtN621J5br9z2wBOF3dNrKtsasQg53CiySKmI8gYquVB
 88nfvzJ2mMWBQceko66k+VSneT5BDkTn1/wyjRtwgDyjZQq8gw+sAQS9hHhBm9/TjJhESp1SI
 yDSN64SbqWwu9Y2D5kWW71PSxMc2Nz+qFEsQv8YNWH+DF/E16HJDmjbptan+I6ofdk9RmfZLS
 F0Lc1usMowG+DQWDPllAny9wSBiKEusmE5EZ+Hv0IHyxWXYOkXY2Tg83Uwiw00QdgbYCKg6EV
 OvhvKI2cwVwdn1itqeWka8bmOPYa7xoGZxj+W67h7HIkxjkuWA0gHKZM44jsPY/+pZcXO+StA
 NCMqSuzqzdSo+iGx7hGRgegxQoTTc2KM+73hCbzFYd95BzgBBw5XFKaTFdNPboPIHXzmsQsRW
 ftRv3FXzcgMS9gZjUO0SuKvQp63m0MPKdWuMBPsKjcHndZ7HxeYn1uM3uzEgzzfUHvgfc86ou
 tCujFrhdipfvdJSZYjGifh4sUnb++pwbDzYJSJlia1pzQq8RFR+QFL9hNkjj1EZQvT/GfttFQ
 QLKPcn9YeyJuDF1WSC0VMOf7jFxQYuOgf74194yeUZVTU/EChuvs+FpPxJFcxVOT1SIJddBJF
 XBXkYiw0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 12 Mar 2026, Takashi Yano wrote:

> v5: Revise "Cygwin: pty: Update workaround for rlwrap for pseudo console=
"

It would probably make sense to describe to readers in what way the patch
was revised, and especially: why.

Ciao,
Johannes

>     Drop workaround for "CSI?1004h"
>=20
> Takashi Yano (3):
>   Cygwin: pty: Use OpenConsole.exe if available
>   Cygwin: pty: Update workaround for rlwrap for pseudo console
>   Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
>=20
>  winsup/cygwin/fhandler/pty.cc           | 410 ++++++++++++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |   1 +
>  winsup/cygwin/local_includes/tty.h      |   1 +
>  winsup/cygwin/tty.cc                    |   1 +
>  4 files changed, 383 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.51.0
>=20
>=20
