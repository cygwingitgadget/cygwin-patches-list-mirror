Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 754E94BA2E0F
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 11:03:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 754E94BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 754E94BA2E0F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774609429; cv=none;
	b=SKt4gf0sB6Zi1KSuuTOsv+BhPKayCaZZnIf4LMiAKspRFnxqPoEL17tFb0rzZHdj0SZa0Kyub/n/LbsUUCSeCCBBfxr0YXTK6R5M20QwrsBiBebr55Yamq2yAdktRywAx1A6VCg8iAJBP+l/yUjkEV1hdK0cgz0vkNsfJRBvBuU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774609429; c=relaxed/simple;
	bh=Hnz3CnWDEyuM2Q0KDzWu4x9UkmdUA5cEEzWm6qdR0QM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=a/s5LXQ5aESFv3te7+T6OTN4sEerfMMMWUDu9CrSlAPyQxnadXTBYmOkOOR5zqA2XXGZcZ2UCHnwe78WtgAfocLnV1CBqfWxBzf8+vOi2s4HnjRgaT2nhxLUHxWIpAMtFAPjvFCZYZYePko8e5PXGTmrgu2NZrLa1yhSJwEIwZ0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 754E94BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Vbsdx3+R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774609421; x=1775214221;
	i=johannes.schindelin@gmx.de;
	bh=L2EohQfRqnVAm3NOQ+LJyYh6MW2p1q3x/z/lt1uOHT4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vbsdx3+RrE12SWGzJ/dZGUo+GQAuRkQbvK0Yta/VA6YxBXeYDL9CWfwgTFKS22BZ
	 9q6oHDPz1s376wEk5lLLZlm+6wWL9ExvqDA2ZMw7L6yVXCmBFwchUjjVblh9cTAGn
	 sMOtZon+x3OWB21cLeCsdBWOsWdVTSgN6lDWgeObc7j/uxD1hXIuZN115QbR1QVc1
	 945aQj3HXOrRMEZcXDPP1QEts8vWOCtTc2m86jqCZPRFYzG0YYtDpuLT2ltbc7Si1
	 9n+X77/zyi9t1ZbfoCgUb3lY9bFw6P40CNJQ2IcQA2cGsNwOYaH25nSzsRSxr8ZRV
	 erZw2K1aaI4glgtdlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1wADyo2Bvf-003BeK; Fri, 27
 Mar 2026 12:03:41 +0100
Date: Fri, 27 Mar 2026 12:03:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix input transfer when multiple non-cygwin
 apps exist
In-Reply-To: <20260310085139.113-1-takashi.yano@nifty.ne.jp>
Message-ID: <6b675ac3-a25e-6126-56ba-a1fe6c13194c@gmx.de>
References: <20260310085139.113-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1iDy4oBLT4o/UoRh0bWSvuqp/5ojtXmhGXEZlcKn1pX8ww1k06J
 ii6rLHYC2jOC/Fj6uWemREWDkH0+5cZs8PCcCzQBChplPM5j+7FhLQt9DA2AEmXQBVCitsX
 seS7cQYJmuLSRYR1lR1d0RIoHjvs1WnPvZfrsl+bDiyn3svP5YoKABFqzvagaZUfKvrMBEx
 2pr0oW3G4ttcXbbEBwsHQ==
UI-OutboundReport: notjunk:1;M01:P0:q2JbgkvRJEo=;4YO4NrHo22I4qgPEVellGhta1oN
 SunPNG8ds/kgAzNFsGTx6r8pzJeXlEhxKWL/SaadiKisWrSjJvAj57yIdWggU5VPZJuT9hyNr
 QskdRLeoCLI2NC2clHfd7MAFAheNCvlzMhHreL6vlx3B2SywllQx2Uha8yPjh2FEh7Otjvxx0
 g63DCuNEs9Iww3/kI74rjYuILMMG3B01nCjBAbrkYqnOkw5m36H4riiZiLxVHPF2c3K7dLYVz
 PhQBYymg+qa2+OJ3k6TDGB6blAwUgrck4mk/YjvBDnVWSJ6BtHNAmQHjtUWN+4kWj7mkUcE4Y
 GMh/xii0UH9dZSuR2ZtT7E8Ghs7kksvdnR5TSq9sNY3cgzr0UCqWeWRvKrYvrAHsEQ1pEANLL
 H6kR1FLBunhRnZh++fAJNozWZ6ZXADhX9JiaXLmtmHasswT6SsNlf5fUDLrYITOWJ2yRmpSpB
 48FqT47ffKa8kgzhTb61r+CI5Y9WwHP2Smwytb+xOGXzNORO/jfWdU/gCKYu5Wjnxyds0tIYE
 g4Qb4xChqGpfxCgP1GprlLaZ0jUtXP4mllGZi2tlLCXqZ0FjwozobFuyPN0AvOitE01PXDUJm
 Xt0V5d0DNt0B9UWulBw1Cle5JZhKfFJXcf9JE8MkNnxgjdGD2Kp+cdSRtkefuLQf0mkuE9TPT
 4slnkVxWa+6PktPlSfiUQmJmKJsfxk7lfwf4Dx8CRTTUENcAkICNQP7GzyAoKw/S2RZ5ogW0d
 1xnvaca1I+52WTo+fWDkXEPuEX88IM+NMOmcqZOoL0W6d87Ofj1OhN3pTX7pC8wsr5K5+aAaF
 7GAUVHKmSpHh1MM4+zpocth0hQeVn3qFxGxJXdJJ9EvcEzQWkLLkdTCkTaDfdB0Y2iy0Dpr0E
 WebfTL49mq6JiRCrUMhsJHfpvopK+RU7eWmsqDUxgfvPQXCyxl4b1DQUWYoO6f9FNUZZm0J0n
 Cwe/nlioZ8oGB9X/g8gkPDLBl5rA0o5NFynSSQTUwqBemKvxe3CVu3kQrHyqaU+NmytMgFu0r
 GL5dHtmdii7Q4cTgfVLq/HSKlOLyvdDyniqYq3T84HpkpUrH4+IVDY1+3gV3BWnTogzz8rlVb
 U5rg5noLAD8vR0h5Uzl0vWSqE6JyeiomIr7EWTBcqqpbFYZpSY+ys/UxqNdEG7hmZlsyD6Lih
 4xPmGVtLoZDwN22LIz1+Rzgo93b2OzPiqIgXotbFLK5iL/En0d7LpMvfeag0P6R6F3Ucek+8e
 NaxsO/6qECBnd5DgsBou/An/01zl7+oc8+jaLWCmK4cowioMz/eOJvWGKU9x97C22jXvTZ3C2
 DLilx5odSZS94Dxnf/OFL3s2yISp0SpLnMsQzteZRn1U1cWMTdj2MjVqKmKHyajr/JaTmxeGB
 olpdL87uWi4SyrsW/q83gqg9RnCNFafJKU1TTUBlrXzdrdwVdTMsiVhrvz2EowjOtmRvqHG6x
 nwZ8Hw8SNmhwIS0pgYfgFNnzuSPa70RqtGetqj2dkdBlqqUsSXDCyjudHQffMzokSqijsohDD
 /d8rujtOeNHrrv9xIYDtvaXbt5J6KjoqyQo782w7O39VuFGrNc0RdS01zoSjU8vQCs6gdpWQA
 m/UYaTvtgxBwoCG5d7wkSxC3a49/U/Ql1eXxwgTkveYI8UCE2VTf9J8f3nxf/9oLU1zFoP16o
 5V7T5lHZtEfKgS+DsPxkIMBmAIFLIRMQsNaJB73ojaW9YIpCSSiRJAdOYPynka550sQEefKYJ
 C+T2rel0/xIU5J0xKCkGlurV+B84GIDLDK2vSmNnrQ1jE//TVocU9pWk8TgZd/LgJ1/kbzVKD
 bCljpni+C4hXyzHklPV1RVW0Qac7A00EOPQRC3TnlyCoV182Rw3a9nXOKMQEPms4gOYQmJYq/
 ara3qwuNTkMa8LRVs+UkVFzvQVYQSHzMNkN6lfiZMlUUXFgVdDJZxhtXrX83W7i8+pDlQNmUy
 oX2OTuM2Lj6MTRqj2U0UpA+HCaDvHCy+M4ku7cA9ExZ8vr4UKb+XF8VWvnUbmoweYoPVlMl4S
 0bWKkqN7mLVNYSK3OGzO+GA02+LIkFv1JwaC+lPbypgHUf0ewTRYCK0cdpTCnk3bHk6iS7iwP
 rQdt4y7bq32KVyH8SG563gyJlgUkCsCWYzaSfhi68MzPrwk4ujAf5i3xjHQo7xvKAYgQDiB1L
 C7AidocOrGGzcyZhivFXpc59fuprdH5eiYD/ryhWH/puZvYyKGL0M3XZA1Eom4BOEcL3hvWV7
 ctQd4OlgjVKeQs8duFNTur56lZKQvh0xQwGbKxM6/NcAyqWKSvrm8iFSKSRu4n+fhfW8QzKlf
 9b0LawvAEDaNl8nORMUHkhu5i65kduBoJGds8dZ0qL4jPSSj4qT/SM/0Qk0mg+edQcX0D0zz8
 IkeBuRBbjB8SgIg0JKrM8gF4XtcFuBZCixEaKK/CW6df2Oyt3ixQj5wC5rJMXTe98+yLXFOFf
 LSjHQ8WTiJ7nRLE8xXaj9fqtWgkjXXpMiJ2itSD8GPn7ZeItm1m83OXezN+za+lPz9doq+zH8
 J105BnYmPg0tbO6fgjhuHj4/f0EVEDb96qCDSU4jvP0fa0STUDbMuPaYAZ1jrjQF1/wWoqwp0
 G14rFmO/eLUyEgGwOMjraLoYfVfF5J2noY24ZddZc+9dc11/hgFknMiUmqlv1Y178uLXD2eSx
 AE3Jz9ww/fzHl9cK+UYDCXHLFQzsCVLceToOppqoMcGCJ1J8xL4mF9ANQfYTBtcz1bUUJlZZY
 DpOVPE1sUpKa/S0+x3mNcWgEoQax4+sgbY1En1j+GhuDGh3ZlUPXXtZrAgFPGOkjErNfOJcqo
 Sz0sVZ7/1nLPKd04RTIhZH+jMrOZc7OQLWVSDN/Motl+/U78pDME1y9uEVqc+Zmf6Pk88IT8h
 RDdrUHz6TOUSshcD1alOc+p9mtt2WvAwlSfxakYa5piZo0KpLDhc4mcCW2qrIU/XWeNPMS1ly
 Tj02dx9o7NOR+N26oVonNGLo6YFYkFbgeHr8TbeGGYUJv2gTeBPnSyQgHhuU0wrn7U9b7q64o
 U5PSfJnxCBwsQx3nUsjhwMqAsNQQ9zfWniH9UOmxJiCCFw3AwocDIMCsuhCgW75isfex70Vuk
 7w0BXjPwjprQgm+aqhwpqwSUp4FVizVRDyXlF04Z9ZVC2pUdAQI7BsURstzTS37pY7FW59Oh8
 vQYlK3RYxVgmvCBYpTtGAZavDwBRSHOEZqDeen9nT3KYrOhgZ5q6isD6hnRTwYZzAUT8byC9v
 0DafHROqXlEMVY7hOTFto3/VFvf9/k/AwFI7AHVnChnSAsAp1DxB7XYuI+n27vpqzh1eEgXTU
 0/6HHz/8AcTHCxnTnoxsZKnyrzuymQpThZ7l+IpkNKvXmC0RpAyz1Rsi420m80Ktp+6vCbe6L
 lbcYZx5RUNkfqmj2ZNXtOs6nB94PmFw5Q/V8y/xpiiz14P8gPuvWjg7rXYymAPmklQbxjUnEQ
 wwSgT1kZeZiLYGW1UMJrIq8VZOlk4b0M2TAuY0+gi9cWEVsVOXiYita1ERn4vxQRGbl/wAnZH
 ybVDklMLZc/8ZybVEd/4NJYQDOMFRZ5AqVidHzcb2gkW2OMusN2Bbo+5OzMXaPUYWTIiNivFR
 gJNv4XQMm6d58mO1XzuT0JS2Or6XrIOQwyECkFbpL3t0qTAi77pavCLBf5wYS2s6+p7UHGHQg
 VzFzjZmYwb7362JL1VWbjhLPGiszMCkD0SDmNhqS5b09ApnpTxlBZCWX0/FatohIpVL7ZJxPn
 0psrP8sQWV+GGvLbU5zM3nejZc2WJzYZxj0w5fCjlLZPqAVu57AQdsEGSdEN6zy3oOBIoFPaK
 JW1iN31WOHYLRzcekaJyo1YZMUAlRUJl0D0IRFmG3K9iU4NOpePc0Iamtu3jBlXPwCeZ8hfRW
 twVnZ6UV2ZHXrv+Ka/Igkmxh9XEerhm8zsRuylx3mS+lHNsoqE9e33VFD9MAkBzwBvwt2rYQL
 M3oAU7jvNfYpa4ShmbemJ75lDVZJc5CLwp9aN97PVRu/77vpAwPcwC1CWDPd1dLyPfmDN818T
 n3Twpx2xeNawJH1pC9lZU46XSxlwX1VRlzBLKgVhJTAzcmS8IquPNPMDo3X3MtQNkgOueGDB8
 6p7jBMgwXbbK/dfvE6Cm+E9+C4ngG3pzvjfbciSUDmlUxjW3e0G7KhskPhcxbl95ejuHnZMp7
 rJ85fZPC2uFjKUpbW+XRMKJEXFB/7KdzzXl5VTABhFVUKV9FLNvvZ9Js7+j+7GjZw1leDWLH8
 jUNpBFTT58pRjz5U7aQuQPvrISNePBr0Pqmx8ey9Me1XFo6FubrnKGxt7MTqeO6JjNKnumHxr
 s3ahtaHHHcKRQ7agPpRqEsb3sqNgpY29Qdn+IFnYkjwbapMPo145ns9wejHR9x9eZJIIjN1Rb
 vbPtkPuBr1UrAomX/CxkKMjDxk0zyQ8cBLfrcZQbSM1NH5s74/z6Fary64OdQEiFswJINmaGb
 hQeF7qzw851i1t/PKTnamuKA/WDqFnlr313GzzrdUQhPNk9pdowYKDfGlcxmsY5LtfHPhkGws
 WIzvBESro4itZ0b2Hz2SPblSoN/kMVnUfxSVKQLobj/75FVJ8QFJqRN5t9+AI6Rmby+I2YBfu
 gLp7QF/lWgQgZmr6Jq7ACXQWVDwLW7Aly1qi96QaKSEMAA5no1CpcPQ80jPxsqc/WxTkMUGD9
 c3YuEaYVN79zAoF6qGnyI8LOyM2NSYetysTt8Q/afxOM4tkjC4YADBNwqD+F/S3TUMmGUC3Tp
 lW0lBkxOGfOBv1pcYbcd1U/7zZZifxSi+DPRnAEO3/bwI86EFu7AhIwMwr6bsuXq6fD2ri3TA
 JCpbOoao6Ar27EgLFyLCghfptg0WEyt/Aw1hbLbJZbtWezsjJ6rLle6iW0bgOl9X0N9VA5JGT
 5x4nJiSqyusqrUMbpqSvVcqiVDsFrHO2XHJU3FbhkcE508vobOyWoDMHVIxyn+iUqsuRWdDhB
 tTyvJhHS97URrIRUBbMAgaVItu/JVW2Qe0O6PV80KC9suhDRL2Vyo6ugMx7sxS2QG6D6xu4Xq
 TKg6b6pWNDUTLv6H3FAIameNQkHLIHzXPpGfQfVphO9fLiLLxGAPAwkdsdb+bZDjmdEg/B33J
 tVLGcogY6vsBDe94dlC5oPD9Kzxs6YPzvlVctfZKg5L6MoU7xRZkjalCSFzqkHJ3HA/kMg80g
 4m7s3WPCFE7YaOGdwx3PId8xgMw8LuFXBnyoqOr/jpfzoGKQ98qAEnu726U07a9mY6hS0bYue
 y303cmI0asOBi9UHLeg85jTccY4Zb5IGkndmrPF9VcOKRy6ix5ZtF+EkzGQkhcAdaRIJfaYog
 Xp8ooBDu3ERJ7TDakHtB0GCAdbAGzMBsjOqsA0R4qUm9jiO5bHtoOo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 10 Mar 2026, Takashi Yano wrote:

> Currently, if two non-cygwin process exist, one is nat pipe owner
> and the other is not, and if the second process (not a nat pipe
> owner) is terminated first, the first process (the nat pipe owner)
> looses the input. This is because transfer_input() is wrongly called
> in cleanup_for_non_cygwin_app().
>=20
> With this patch, in cleanup_for_non_cygwin_app(), transfer_input()
> is called only when the current process is a nat pipe owner to
> solve this problem.
>=20
> Fixes: f9542a2e8e75 ("Cygwin: pty: Re-fix the last bug regarding nat-pip=
e.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:

The patch is clean and as far as I can tell correct, but we need to talk
about the commit message. It might be correct in what it says, yet I
consider it incomplete because it leaves too many questions open that I,
for one, had a grand old time figuring out after scratching my head
bloody. So I would like to propose the following commit message instead:

=2D- snip --
Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist

Cygwin maintains POSIX line discipline for its own processes: input
goes through `line_edit()` before reaching the reading process. Native
(non-Cygwin) processes must not receive line-edited input; they expect
raw console input instead. To support both, the PTY keeps two
independent pipe pairs for input: a "cyg" pipe for Cygwin processes
and a "nat" pipe for native ones. The runtime switches between the two
as the foreground process changes.

The PTY tracks which process "owns" the nat pipe session via the
shared-memory field `nat_pipe_owner_pid`. Only one process is the
owner at any time. When `setup_for_non_cygwin_app()` finds that the
current owner is still alive, it leaves ownership with that process
rather than claiming it for the new one.

This means that a Cygwin-spawned native process can go through
`cleanup_for_non_cygwin_app()` without being the nat pipe owner.
Before this fix, that cleanup called `transfer_input(to_cyg)`
unconditionally, draining the pseudo console's input buffer even
though another process still owned the session. Keystrokes that the
user had typed were moved to the cyg pipe prematurely, so the actual
owner found an empty console input buffer and appeared to lose all
input.

When looking for the next owner of the console in
`cleanup_for_non_cygwin_app()` (via `get_winpid_to_hand_over()`), and
when transferring the input back to the cyg pipe, guard both with a
`nat_pipe_owner_self()` check so that only the actual owner performs
these operations. Non-owner processes skip straight to detaching from
the pseudo console without disturbing the input buffer.

Fixes: f9542a2e8e75 ("Cygwin: pty: Re-fix the last bug regarding nat-pipe.=
")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
=2D- snap --

What do you think?

Ciao,
Johannes

> ---
>  winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 56b573c8d..aaad47ca9 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -4575,16 +4575,19 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (=
handle_set_t *p, tty *ttyp,
>  {
>    ttyp->wait_fwd ();
>    WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
> -  DWORD switch_to =3D get_winpid_to_hand_over (ttyp, force_switch_to);
> -  if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
> -      && ttyp->pty_input_state_eq (tty::to_nat))
> +  if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
>      {
> -      WaitForSingleObject (p->input_mutex, mutex_timeout);
> -      acquire_attach_mutex (mutex_timeout);
> -      transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> -		      p->input_available_event);
> -      release_attach_mutex ();
> -      ReleaseMutex (p->input_mutex);
> +      DWORD switch_to =3D get_winpid_to_hand_over (ttyp, force_switch_t=
o);
> +      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
> +	  && ttyp->pty_input_state_eq (tty::to_nat))
> +	{
> +	  WaitForSingleObject (p->input_mutex, mutex_timeout);
> +	  acquire_attach_mutex (mutex_timeout);
> +	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> +			  p->input_available_event);
> +	  release_attach_mutex ();
> +	  ReleaseMutex (p->input_mutex);
> +	}
>      }
>    if (ttyp->pcon_activated)
>      close_pseudoconsole (ttyp, force_switch_to);
> --=20
> 2.51.0
>=20
>=20
