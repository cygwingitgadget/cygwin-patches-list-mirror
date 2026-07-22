Return-Path: <SRS0=jZxs=FQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 5FDAF4BA2E1B
	for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 20:44:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5FDAF4BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5FDAF4BA2E1B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784753086; cv=none;
	b=hx6vgGfind61eEaptKF+OwJD91TF4ndx8fuMt9Z9541j0f12SUZXs/lpx09rvGz1JtCi2aDbqtOvL/HsLP434rulJ8bINfeOij+xDC0vcahx8MabQv55I1jCblBmhj4yXjMuGPSocDcerNN5yQN/Kvzt29BehJ88rS9Su1ZPjZg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784753086; c=relaxed/simple;
	bh=qwUTGlJp7MnpheXVa8s62DwWwwLy2m8x98EyUiU2sQM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=oP/B+LH/70g/nyCHKzVuyAQ3bOKKbL4icw6QXEeHpEXMdXXkj7dTzaltiMuYUVPez5s83x7P6jT/vGAuQdYBwTOiMsWr6VM5lZ9LlCfhoN4KVEsrskcpMrfh6poGSd/zhtu1Ye4kWB59aRVT6UA4NsHSwKcbd6QAJD0kzrW++eQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dEbGGjQq
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FDAF4BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dEbGGjQq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784753078; x=1785357878;
	i=johannes.schindelin@gmx.de;
	bh=VhIdc9KuF7kO+lWNx10t2Kv+BBc+XX5gw3G2vHEMEzE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dEbGGjQqCp3djPVpFEK165eYxNxDb5Y1mNUVKLfZ+x926/NKkat7MK+UEwTrH8hA
	 CN6mtn46akXztkh4G4iTcYSUFJGWlrGEdNJixkERYQt0EL/c3DvxU+xrXnrwO1ZmL
	 t1wrn2Fwv6bvLXQ4aqL/FoWCABI/JTGNZZOfC2yY5XO2ePJeuNO/ZFKXGkVIY5n7V
	 COGnbGoES6iTYvGljWytWRpcdRdUicYhNqiyyA2o8j17Pzcv3/HmLqfBRS1/au6zU
	 0HrW/sQoeEVdz7jSx9MHZHRr+OOaKr3DfvEIIkZVmPDJQ1jLSVnlubEaFsCv7+VHC
	 U3zLm7NZppzWDHYHnw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7GM-1wgXvQ3FjW-00AVNs; Wed, 22
 Jul 2026 22:44:38 +0200
Date: Wed, 22 Jul 2026 22:44:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v11] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260720195832.400-1-takashi.yano@nifty.ne.jp>
Message-ID: <68ad32a2-a464-115e-fd4a-e3eda91c5403@gmx.de>
References: <20260720195832.400-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Jo0pu6P9D930UzgENbD3TO/89gCMl2Mjfj7yP3yyF58PueyLquZ
 OORwjWTNgkb+Ido9kFH+u5qn0m9j5acUIJgs3iocnVTxjz9szpX8tJ5ZlTkfNUY0BN0rCVt
 LznM1yi9c+fEpzSABmoEMq92HUv8w/wMjkjq3yW81MBN8HrAms3a5dVG9kd/5Ru2zwt+7B3
 B0N5Frh8FOjVE9OU4Cawg==
UI-OutboundReport: notjunk:1;M01:P0:yy88cKdZ7Z4=;GS8dz0LWKvpIjwt5XEBTb8L1pTh
 er6enZB4xYp7/TKGeJlFaDebItygSg+5jWGVTSL5thzKO9TMqY2lWVCK05JtOfui+xPXwI+rW
 +KgsL/J8NUhbw0dWA7ZNmcFlWbN2DMnIzRS09s6GMWvqOnM0opvq/5u8peZMqhGsQCQacSYWm
 Og6dxvNyOy68ujGQB0RYb3J36MENec+9ZH0zeCYvV370Uza3m5IBgCjK8jcCRgw/dNcGF1XLz
 dE5H75FFHZ5hFXeie26MIpV15ws3DDHnNMVb5peeQvd9HBSqzrqWl/PmDc3FnC0zy/Jw2k6OK
 Slt4Cl0Lyy34dlbWzLDo8v1CIYOb03/JhyRzmTuzi2lQgq4ykMi9p02kdJOFeNigrJpx7tTRm
 /z6KSirC3ukwZqz1UVVRH81ycbGC7suAuWjkqGjeY6BXh1hsxy+4y5TUnut0MsJsl+R6G2DXT
 xlh8Od1OtGRZ1ZNpHacqFzzar6c8b3s3LKh09fpMdCH4JTLK7BfDJjXP4fW89iMk/YDnLyCYb
 hDuTvnjTjVlQM0cmKSf6ZWe0jvJK3GvctM8wrycn4S9dfHfG2PR8MUbH2at+Kmmr3yszy5P8D
 3qH+JrfvY2qHAnDcZuLVJ9a7c9xFeDO5a54Zx6vPUggjQ2XlMXjSM/I5x8mHLl4eSmk7YH+Zb
 9spL6rsY69ruWGMDKEx8RtvoBp//I1bA0XEouvIFhpdNB04UNLs5SQei5kjfqHnlI5KxHOG48
 GjyjjAxg09WvtBOcP9g0ICN8tYuIUuo2byI460JiOqu3w4sbKGC2s/KkwreibHm9h6vGwDnEE
 +s/HMtMae5tauk2cWl9rj4DgmcJ6csjz4EyJA3ffVxhZsr2C9QOeytHC2Jf6Gnv6uBE1lpZaG
 tPspQeuFy0kaQ3eEh36L+dT4HmYKevIbWVp5qZUvozf5Cs1fS8xD5FWAIDhSysq5Uq6deGJJp
 bgf4gpYJrOHhtO3nGzWn1b+XDEk0C3doyNo9kwTHTfdSmfwgcdq140felBZwFQm6CbIlQppM5
 KovKXBaPowpYlRphLqoUNrgTxjIP3TKzqmO0aS1eB6b3EUWJzm5VGtaFJnhZcrc5roZetDjjU
 7kSaj4FjcEIRfPf5GgmEmXcuHbSb88ZXdooh/STcvxHFg0QbWQuN9MyrmeQ/THuKQjp6/2CfL
 2yoamaYlO+U1/ULM8my5TBQmxUwgxuRXaYV18MENrlg6LyBSTKTpVnbCNvsuUfDbC2dr9Ib1K
 axy17WbB5SpaseeF+5hhTWjau4rq9pH1FLZ4vMAVUBc8Un1rtAjxNMUhBDa9sIU7r6PL0QQpb
 IiXatxLkAohpXfOsyuDXl+kngenh2oOA0Gz4kIF1vZgyKfKNqVD8Hz8K8YamRVK8ZICQA3oJ1
 CYCjt3EaSJaaGgzMaLf7Rp3fN9V+pdZDI82PI0wZU9q/ycYEOCh280MSejOKrEh4dN3lIFWax
 n9UPqd0TezijicZ4jk+aHLAP3r985robgMF3N8c/wXa+Ry/jj+8rs24PthSoDAK2vztFey+xJ
 MCAhMB7tPrBl5wAt/VL8fhWYB/dz51DB6EvQf/XsqrvoasW3AWxqJDn3geKWMNYxisqyZ2rrD
 ab5V8QXI+gsii4PVVjQBftsv9qldFmVjGwkt53fyogVNTw8vOGSMN4CFTylycW/ViOgedbRZO
 fdPvoTkKDqy9/ZzxpqZJbFOlVSdl92VJvm+K+hOZ4qkA7v7bPl2g/vhRt9Fi1EIDGTzNF89Of
 YdDcqs8FoX/KnqubCKw63FahDucQKm/iaZjRVVVnlNu9aeiPI+UgvX+0z3giyrJ1xyI4AZh1F
 HwVzgky5JCvENJaKRndPNkR4C+3IMUvgv9euwH1xMFTT8Isv64dhhTq/Q5+5MIUUCDapMRyxe
 es6Zv+9Itt/X2kFQM/T5l5nob8n3Bz2lWD2ZpxTLHssN856r93spKOv55/9uYIMBfvJnQdbkN
 PAQ16gMOID8c9oYREvKjW0VsfTieWMja+9UJheX9t3Tf9htZo6VN9ylqeCk5ytu3E/bA2Bb7+
 8z0ShuC+zFk6Eu2JhyX1uwcbPEbJfyxdLWl4ZTJEUPZmciYmK0UzYYag0SX+aeiDoB79yw+Cg
 fBjfDtXNXicgkj+Um8HMnl7keS4aALVAR1AmnrLZRHPXwK0qeke2Z6JI3C+t5/x30eeLwb41P
 poKYGN5AG8kPLlRE/FaKc2R2/1z6MYo6BtjEiGPcq2TZnMmVhEteXsBSm877kTvJsO6RMk0Fv
 yJ6U0/e8LANZwytYFCht5UkDwXxaeHPMDuZLLaFTiEKeP6Aqr+tGkGchbveZOTOE5hr8U69iZ
 3bJqrrxuv3mqRG9jJwjOi4xf5y95ZYtgFRut9x4g3OYhAZQQbG89U3I9mWSF5uPbTsINmNU2l
 V0zVgvPAUTpwld0tzx6erBqhjuCVALSWOV0VRJ15E670rr6M2sw9w3MQOlt/CaoW3vpva8BpN
 CTpMqW5mkqzG92UjShdH65vMQ3x0bkakfFG2oKfYeemDtONevAI55jIiV2TtJ6AshTZMvI0XF
 iSW2+0vhPUO/lcBkYubpqhSfrVGaPk8wja5w8qb26K1lIh2L3ut9FKv08M6QvuUzILmuFFOu4
 HeBAzNPwbm8ZyLVNfg0FEi6XHSvgk65c28bzQTE2BPv2PEehBAzo7fTBI7JTWVvV7YvkoGlsl
 jL53DRgULQ6d3FCChZ/pcBwkN20tnuo/B4+9IPRcXF/5MnydBlTOBE6E1eUlh7a6nnsd/PHMq
 sePpqwttsuYgzUHi5FKzXzYGoEPtxb/71zM+4ECE6Jku+l8vACFPUALkR9dbnNY8iFg8KXpRa
 OxfJDhoMp04K1fURjhwFubz3HtfZG4hedjrPaNzeGzFco8XgnqjW6Ab8GhUhr122qBifLnZeM
 4qUH8pqu0vDxGdZbhy8Nva3IRaJqwMesf1ZgQyhdgrIAbAiI+aW4gjxKacSl7dxAbjNWLozfm
 Ff0JN/EkaiKHZ2fBoXob3Kr6UaYZk5/4DlVI2dHTwZ2u5AaFIOR1ECbRs9FGvS3Gnt6JJ7s5C
 pA5TsnvCbBoQiAkj3VTQFdouIAQWqddQqfbCDwTFd43lWlBJBHLp0Dqv7lh2cjHFdpw+Xxkdc
 CpC4b52JtyJapgOfP3kN2kbypqXb7UIcTi3HmYZ0VC+koozh0dVjs/AwaifY+o9akFQo5l+OZ
 dBK5jfycAZdA6BvnS83B3C9tEPFDM1762tEdZUYji6Ge8XINek1u/EIfWBCr2DEMscFBTLrxo
 hbTy6NlMt5tiinplVuqKbACm+JMFw2pmfH5QpyrGRS0o0pCMwHzJs2w3N4V2z2c+rThvdc+5w
 vyLeJBM76/m4qpGJp7VVKZrrfoLHCDzo+6T5JoNPsGcn8b/Vi03edY3ReP+Wju+LWU+D13pNk
 9y0sAxWgT7vjY7CsyxiMU2XxAiCJLqcw76/QXz6lFegmA5XTaJPih2aK65Q9fOsZojlZG/xrz
 YmuGkiH5u5S3Otoq8HWPv4bRZYp+0yX6xxexe7rYLZU5mNFTvLnb+5jAlwtVJHj22r9ouSXWs
 2YAiXrgZz7MyEMMtutIYIBNgtCQ6uhpsqjgJxNnuuIXWeCmH7E3Z9/yD9XudnPY/dQ+ynBlb8
 PI1FqAAXZNNyAlCLFQi+8y/Gbk80j2wHqUSng+BgVswVaqK289qv99pFb2bkjlUJrXjd2Nom8
 1cudj+v8Kt46fMJHEAw84a4UYUmrMSNPJUXAnOwwzI4isKxjkPigRSdfPn4wbWljTrDGn10Sd
 Qh/+D3ZL7WN2IER+WEFb1BxyRWFwC89bgwk7lNhHLJYgOT5LeyL7MRe91itNSERKcAp4+0TVU
 aASL+KZInWVkfQ1hbo+RzoMUvyIDVvqGQsXy8HQg9BbevxReJEnL3yOwrYcRDXORmUhbfrzjd
 29pMnPJcR3+0Oj9UHJcIsrRJnW3B+Mb1IRNuQ7ZJG64OV4ss/A2cceVwEOD1sh6aufCgjbk0G
 Em0vx9h9O/vkDE7xp485T6ZSC3b0ntjYlgmdCzXVQIwhW5A6uUdf02lMrPOWlrlsEukQhUnSE
 KpokkC5EpHsZvG8H/PXiTFmJLyLMQ5tAn+j1Iw1y0GxMQyFe34lhKJvaVuhJP+9bhRm8QIqYZ
 epj++zVvFFBhlIwlJRzkBj9Cr6l3saVbcLC53d633SgavLWGFCu3p4NRixjVdCOE35hFZldnm
 kWXu13J9G3HzOFWI4xtY9lkrpFGHXI8arnd1sPEgyJx2dlQjJ8Mf12er78MEIJiJnw4D+0QqR
 KCe3PQM4VjydJ7MD2WxnxZrHbsjoe3CdhYVEq7oUtLzQDg5uoSoeBVx1xZwYwNhu1UEYdm2QN
 9AnlvayRlC/cleq+m180X0Yco4oWcHV/QgOOkJSZBhLdsg0bXbU1hKpruHQYaSh8EWBHv7vP4
 u76ZXeapHa+Voo3pVlb+5tG6NxOnMeexozXP/8XX2vH2fK8tNcyWqq1Bgpst9DLNmR4gkl7x8
 xPGwLRysmSul7C37RyvWPOw+YEWqZQuZZ+VPUZDKVbz4KKdqVp/BRO1b0TUjpV0rnb4fhHGom
 sK+AnGwc4dAfrn6lxMiYLVGRnoEzN2j56T7lC83kAQBcsnwEMKVhtsvqeXwgKo/83aFP5g2dJ
 P7out2uNjPpfspsMcsWZWX3AnYk2+79TZRN32Jn3ob7dmuiZGkKVLVVqK5EfHWzU5QAW/Z24s
 Bt8XDYPpoAE+N+s9eO+eYHz9kb6VZiirkZjx7kJwjCcKf1N7yCAKuYvNKX/EIVjVQAfN15nuZ
 1YheAUKPA/qb/LYPMeGK0/K/mCoE2YQ0wKBb2TjPGyZa0VHAe2ztS6s+UmI0NlZGf3Ok/GrHg
 H8cPwTRwU0KVvlJKg8ARWl7wIm+tQSW0qscinj4UFza/yfPL5OQUrGHFwXXnhMwSYlhsmdFQP
 XQ5LPgXyNuv0jPM/MnjRv1aLBrEw6YoC3XLTGjBkzphgbRX84MDfQofBae7ah/VnJKVcl9gmw
 1sU9NjNumrAMSGCtnT8UFJMDfKaAs8wa5bZ1qnFeJ9Ogiy21A2ZAsIl5Mr8mJgU2T7vr0X1lL
 zTzjysCruh0O2DoatTTLx4eX4xoIHkaDg4KRX6aPWGWFozyzsfaC6P05GwXw9ogIS0z+RvzcM
 i+YZnrQ/DseXurbn0cs1M9oNg+n8cluRtgpRvicncPbJG5xlTz1G4h6UI5FZpNsak0E8dQujp
 larTsFNKpw2nWc0K0DJzLcq0wPSVZcsXuIYDMD7gYO3I+dSvO4q2Cj2zqA/Z3C0Bo7w4KnC2m
 3E7EKFNrWIEtVCHtJKuIGjoACkX04mU9GHn+EtDVUpmjwLjPHg/w5LDMP18NS2vD+9185ZTba
 0+tPX0zEgotr82/CQ/GdBGbSC5JA3Fnad62dXGE829ycroiw8I9PcTGL4j1jgVVpC7NLG5WKe
 XEtW8oZjyCqsbkOkGWBLKPdRIcWukQkoUjECLOecmjLjOBVAyXWHC41z9ff6O8T+raLRh3XII
 QP5iBIGQR9j1/GdLwD+gbBhNCAl3Re9Gw9XawANhTXuzlZdvi5muYvQdH3Eucjvxy+qXf02MO
 LBY/F3L9ZL2qi2Gs8gBvBTVwx/zqib1JU5k/Y5FBfPz9sK5WTcFXZ1v9faF5WANl5L1tDKbhn
 IIhq5P6HmiWGDcffDkfGcQEXWaIQB2YrR2O+ink3gtHS71Eu86Y7V71+DKO8KkrVv+T+N42Zr
 ZJz7hVDRQMLZWM1cKbwXmLlrHuLr8SGSi3VM0y6kmpd2sziE/vr8X5CN6ALBA/RQWt5eQAWpw
 af4uXfN7e23HlpQzlqT3b8rW20JcpBQHipcNH1gXUIzy97/aIYVAihJRndNmz46le6ie7OG74
 ky5XwG3HmsG07dmyhMXNVSjTlZqgo8sY5Q==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v11. The v4 lock-ordering deadlocks are resolved: every
mode-changing site now takes `cons_mode_mutex` before the input/output
mutex, and the v10 `TIOCSWINSZ` path releases `output_mutex` before
calling `bg_check()`. Verified both.

On Tue, 21 Jul 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.
>=20
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
> v5: Fix the issue of mutex acquisition order.
>     Fix the race window around the process creation.
>     Improve latency of checking existence of non-cygwin apps.
>     Handle errors in checking existence of non-cygwin apps.
> v6: Match the conditions for incrementing and decrementing the counter.
> v7: Decrement the counter only if it was incremented by myself.
> v8: Symlify the conditions for incrementing and decrementing the counter
>     a bit.
> v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> v10: Set process_state before calling spawn_worker::setup() rather than
>      using the counter. In addition, resume non-cygwin app before
> 	 modifying process table. These make things much simpler.
>      Narrowing the period of acquiring input_mutex in peek_console()
>      in select.cc.
> v11: Release output_mutex before calling bg_check() in ioctl().
>      Suppress unecessary console-mode change attempts.
>=20
>  winsup/cygwin/fhandler/console.cc       | 141 ++++++++++++++++++++++--
>  winsup/cygwin/fhandler/termios.cc       |  29 +++--
>  winsup/cygwin/local_includes/fhandler.h |   5 +-
>  winsup/cygwin/select.cc                 |  14 +--
>  winsup/cygwin/spawn.cc                  |  46 ++++----
>  5 files changed, 184 insertions(+), 51 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index d4c87f29f..0219a37ef 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -977,16 +977,85 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);
>      }
>  }
> =20
> +/* Return values
> +   0: not exist
> +   1: exist
> +  -1: error */
> +int
> +fhandler_console::active_non_cygwin_apps_exist (pid_t pgid)
> +{
> +  tmp_pathbuf tp;
> +  DWORD *list =3D (DWORD *) tp.c_get ();
> +  const DWORD buf_size =3D NT_MAX_PATH / sizeof (DWORD);
> +
> +  DWORD buf_size1 =3D 1;
> +  DWORD num;
> +  /* The buffer of too large size does not seem to be expected by new c=
ondrv.
> +     https://github.com/microsoft/terminal/issues/18264#issuecomment-25=
15448548
> +     Use the minimum buffer size in the loop. */
> +  while ((num =3D GetConsoleProcessList (list, buf_size1)) > buf_size1)
> +    {
> +      if (num > buf_size)
> +	return -1;
> +      buf_size1 =3D num;
> +    }
> +  if (num =3D=3D 0)
> +    return -1;
> +
> +  /* Last one is the oldest. */
> +  /* https://github.com/microsoft/terminal/issues/95 */
> +  /* Assuming that newer processes are more likely to be non-cygwin. */
> +  for (DWORD i =3D 0; i < num; i++)
> +    {
> +      DWORD my_pid =3D myself->exec_dwProcessId ? : myself->dwProcessId=
;
> +      if (list[i] =3D=3D my_pid)
> +	continue;
> +      pid_t pid =3D cygwin_pid (list[i]);
> +      if (pid =3D=3D 0)
> +	continue;
> +      pinfo p (pid);
> +      if (!!p && p->pgid =3D=3D pgid && ISSTATE (p, PID_NOTCYGWIN))
> +	return 1;
> +    }
> +  return 0;
> +}
> +
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
>    const _minor_t unit =3D p->unit;
> +  pid_t pgid =3D shared_console_info[unit] ?
> +    shared_console_info[unit]->tty_min_state.getpgid () : 0;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> +  tty::cons_mode conmode =3D cons_mode_on_close (p);
> +  if (con.curr_input_mode =3D=3D conmode && con.curr_output_mode =3D=3D=
 conmode
> +      && con.disable_master_thread =3D=3D (con.owner =3D=3D GetCurrentP=
rocessId ()))
> +    {
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    }
> +  switch (active_non_cygwin_apps_exist (pgid))
> +    {
> +    case 1: /* Exist */
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    case 0: /* Not exist */
> +      break;
> +    case -1: /* Error */
> +    default:
> +      system_printf("Checking for existence of non-cygwin app failed.")=
;
> +      break;
> +    }

`active_non_cygwin_apps_exist()` returns -1 when `GetConsoleProcessList()`
fails, including the zero-count and buffer-overflow cases the helper
guards against (condrv buffer-size flakiness). But `case -1` prints and
falls through to the restore below, restoring `tty::cygwin` anyway, the
opposite of the v4 request for a distinct unavailable/error result so the
caller could decline to restore when the count is untrustworthy.
Concretely: two native processes share the console (same pgid, native
mode), one exits and runs cleanup just as `GetConsoleProcessList()`
transiently fails, and the survivor loses native mode, the exact
regression this patch targets. If restoring on failure is deliberate
(prioritising Cygwin apps), fine, but it contradicts the v4 request and
should be stated, not buried in a fall-through.

The fix moves the non-Cygwin resume ahead of the process-table update, and
for the `exec`/`_P_OVERLAY` path marks the spawning process non-Cygwin
early (`InterlockedOr` of `PID_NOTCYGWIN | PID_NEW_PG` onto
`myself->process_state`, guarded by `mode =3D=3D _P_OVERLAY`), covering th=
at
path against the restore race. But for non-overlay spawns the spawned
process's pinfo carrying `PID_NOTCYGWIN` is published only after the
busy-wait, while native console mode was set before `CreateProcessW()`. In
that window a concurrent `cleanup_for_non_cygwin_app()` for another
exiting native process in the same pgid can count zero and restore Cygwin
mode, the same window you acknowledged in v4 (`we cannot fully address
this problem`). Either represent the pending native-mode acquisition
across both creation and publication, or document it as a known limitation
in the commit message.

Honestly, I'm not quite sure how to proceed from here. This is all super
complicated to me.

Ciao,
Johannes

> +
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> @@ -994,11 +1063,11 @@ fhandler_console::cleanup_for_non_cygwin_app (han=
dle_set_t *p)
>    set_disable_master_thread (con.owner =3D=3D GetCurrentProcessId ());
>    /* conmode can be tty::restore when non-cygwin app is
>       exec'ed from login shell. */
> -  tty::cons_mode conmode =3D cons_mode_on_close (p);
>    if (con.curr_output_mode !=3D conmode)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode !=3D conmode)
>      set_input_mode (conmode, ti, p);
> +  ReleaseMutex (p->cons_mode_mutex);
>  }
> =20
>  /* Return the tty structure associated with a given tty number.  If the
> @@ -1055,6 +1124,10 @@ fhandler_console::setup_io_mutex (void)
>    if (res =3D=3D WAIT_OBJECT_0)
>      release_output_mutex ();
> =20
> +  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
> +  if (!cons_mode_mutex)
> +    cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +
>    extern HANDLE attach_mutex;
>    if (!attach_mutex)
>      attach_mutex =3D CreateMutex (&sec_none_nih, FALSE, NULL);
> @@ -1189,6 +1262,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>    /* Setting-up console mode for cygwin app. This is necessary if the
>       cygwin app and other non-cygwin apps are started simultaneously
>       in the same process group. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
>        set_disable_master_thread (false, this);
> @@ -1196,6 +1270,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -2010,6 +2085,7 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
>      {
>        prev_input_mode_backup =3D con.prev_input_mode;
> @@ -2022,6 +2098,7 @@ fhandler_console::open (int flags, mode_t)
>        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
>        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
> @@ -2105,6 +2182,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2114,6 +2192,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2121,6 +2200,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2130,18 +2210,20 @@ fhandler_console::close (int flag)
>  {
>    debug_printf ("closing: %p, %p", get_handle (), get_output_handle ())=
;
> =20
> -  acquire_output_mutex (mutex_timeout);
> -
>    if (shared_console_info[unit] && (dev_t) myself->ctty =3D=3D get_devi=
ce ()
>        && cons_mode_on_close (&handle_set) =3D=3D tty::restore)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        if (con.curr_output_mode !=3D tty::restore)
>  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
>        if (con.curr_input_mode !=3D tty::restore)
>  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> +      ReleaseMutex (cons_mode_mutex);
>      }
> =20
> +  acquire_output_mutex (mutex_timeout);
> +
>    if (shared_console_info[unit] && con.owner =3D=3D GetCurrentProcessId=
 ())
>      {
>        if (master_thread_started)
> @@ -2196,6 +2278,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2245,8 +2329,8 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  	release_output_mutex ();
>  	return 0;
>        case TIOCSWINSZ:
> -	bg_check (SIGTTOU);
>  	release_output_mutex ();
> +	bg_check (SIGTTOU);
>  	return 0;
>        case KDGKBMETA:
>  	*(int *) arg =3D (con.metabit) ? K_METABIT : K_ESCPREFIX;
> @@ -2369,10 +2453,12 @@ int
>  fhandler_console::tcsetattr (int a, struct termios const *t)
>  {
>    get_ttyp ()->ti =3D *t;
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (con.curr_input_mode =3D=3D tty::cygwin)
>      set_input_mode (tty::cygwin, t, &handle_set);
>    if (con.curr_output_mode =3D=3D tty::cygwin)
>      set_output_mode (tty::cygwin, t, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
>    return 0;
>  }
> =20
> @@ -3140,10 +3226,24 @@ fhandler_console::char_command (char c)
>  		    con.cursor_key_app_mode =3D (c =3D=3D 'h');
>  		  if (con.args[i] =3D=3D 9001) /* win32-input-mode (https://github.co=
m/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard=
%20handling%20in%20Conpty.md) */
>  		    {
> -		      set_disable_master_thread (c =3D=3D 'h', this);
> -		      if (con.curr_input_mode =3D=3D tty::cygwin)
> -			set_input_mode (tty::cygwin,
> -					&tc ()->ti, get_handle_set ());
> +		      /* The correnct order of acquiring mutex should be
> +			 cons_mode_mutex first, then output_mutex.
> +			 However, here, output_mutex is already acquired.
> +			 So, to avoid deadlock, if another mode change is
> +			 on going concurrently, that one takes precedence,
> +			 and do not change the mode here. Even if we manage
> +			 to get the mutex acquisition order right, which
> +			 one ends up taking precedence is still a matter
> +			 of luck. The later one overwrites the earlier one. */
> +		      DWORD wret =3D WaitForSingleObject (cons_mode_mutex, 0);
> +		      if (wret =3D=3D WAIT_OBJECT_0)
> +			{
> +			  set_disable_master_thread (c =3D=3D 'h', this);
> +			  if (con.curr_input_mode =3D=3D tty::cygwin)
> +			    set_input_mode (tty::cygwin,
> +					    &tc ()->ti, get_handle_set ());
> +			  ReleaseMutex (cons_mode_mutex);
> +			}

This is the win32-input-mode (`?9001`) handler, reached from
`fhandler_console::write()`, which already holds `output_mutex` before
calling `char_command()`. Since `cons_mode_mutex` must precede
`output_mutex`, it can only try-lock with timeout 0, and on `WAIT_TIMEOUT`
skips both `set_disable_master_thread()` and `set_input_mode()`. The base
applied both unconditionally, so under contention v11 drops the requested
win32-input-mode transition: `con.disable_master_thread` and the console
input mode are left not reflecting the request. This is the
master-thread/input-mode area that has produced keyboard regressions
before. The comment concedes `which one ends up taking precedence is still
a matter of luck`, but this is not benign last-writer-wins: the update is
lost outright, not overwritten.

>  		    }
>  		}
>  	      /* Call fix_tab_position() if screen has been alternated. */
> @@ -4475,10 +4575,13 @@ fhandler_console::set_console_mode_to_native ()
>  	fhandler_console *cons =3D (fhandler_console *) (fhandler_base *) cfd;
>  	if (cons->get_device () =3D=3D cons->tc ()->getntty ())
>  	  {
> +	    const fhandler_console::handle_set_t *p =3D cons->get_handle_set (=
);
> +	    WaitForSingleObject (p->cons_mode_mutex, INFINITE);
>  	    set_disable_master_thread (true, cons);
>  	    termios *cons_ti =3D &cons->tc ()->ti;
> -	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
> -	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
> +	    set_input_mode (tty::native, cons_ti, p);
> +	    set_output_mode (tty::native, cons_ti, p);
> +	    ReleaseMutex (p->cons_mode_mutex);
>  	    break;
>  	  }
>        }
> @@ -4535,8 +4638,17 @@ ContinueDebugEvent_Hooked
>  static FARPROC
>  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
>  {
> -  if (strcmp(n, "RequestTermConnector") =3D=3D 0)
> -    fhandler_console::set_disable_master_thread (true);
> +  if (cygheap->ctty && strcmp(n, "RequestTermConnector") =3D=3D 0)
> +    {
> +      char buf[MAX_PATH];
> +      const _minor_t unit =3D cygheap->ctty->get_minor ();
> +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> +      HANDLE cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> +      fhandler_console::set_disable_master_thread (true);
> +      ReleaseMutex (cons_mode_mutex);
> +      CloseHandle (cons_mode_mutex);
> +    }
>    return GetProcAddress_Orig (h, n);
>  }
> =20
> @@ -4817,6 +4929,9 @@ fhandler_console::get_duplicated_handle_set (handl=
e_set_t *p)
>    DuplicateHandle (GetCurrentProcess (), output_mutex,
>  		   GetCurrentProcess (), &p->output_mutex,
>  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> +		   GetCurrentProcess (), &p->cons_mode_mutex,
> +		   0, FALSE, DUPLICATE_SAME_ACCESS);
>    p->unit =3D unit;
>  }
> =20
> @@ -4833,6 +4948,8 @@ fhandler_console::close_handle_set (handle_set_t *=
p)
>    p->input_mutex =3D NULL;
>    CloseHandle (p->output_mutex);
>    p->output_mutex =3D NULL;
> +  CloseHandle (p->cons_mode_mutex);
> +  p->cons_mode_mutex =3D NULL;
>  }
> =20
>  bool
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index ee576a0a8..dcd5472cc 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -830,20 +830,24 @@ void
>  fhandler_termios::spawn_worker::cleanup ()
>  {
>    if (ptys_need_cleanup)
> -    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> -						    ptys_ttyp, stdin_is_ptys);
> +    {
> +      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> +						      ptys_ttyp, stdin_is_ptys);
> +      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> +      ptys_need_cleanup =3D false;
> +    }
>    if (cons_need_cleanup)
> -    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> -  close_handle_set ();
> +    {
> +      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> +      fhandler_console::close_handle_set (&cons_handle_set);
> +      cons_need_cleanup =3D false;
> +    }
>  }
> =20
> -void
> -fhandler_termios::spawn_worker::close_handle_set ()
> +bool
> +fhandler_termios::spawn_worker::is_attaching (DWORD pid)
>  {
> -  if (ptys_need_cleanup)
> -    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> -  if (cons_need_cleanup)
> -    fhandler_console::close_handle_set (&cons_handle_set);
> +  return !!fhandler_termios::get_console_process_id (pid, true);
>  }
> =20
>  void
> @@ -916,7 +920,10 @@ fhandler_termios::get_console_process_id (DWORD pid=
, bool match,
>  	  }
>  	else
>  	  {
> -	    pinfo p (cygwin_pid (list[i]));
> +	    pid_t cygpid =3D cygwin_pid (list[i]);
> +	    if (cygpid =3D=3D 0)
> +	      continue;
> +	    pinfo p (cygpid);
>  	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
>  	      continue;
>  	    if (!!p && p->exec_dwProcessId)
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..eb96435bd 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2023,6 +2023,7 @@ class fhandler_termios: public fhandler_base
>      HANDLE output_handle;
>      HANDLE input_mutex;
>      HANDLE output_mutex;
> +    HANDLE cons_mode_mutex;
>      _minor_t unit;
>    };
>    class spawn_worker
> @@ -2042,7 +2043,7 @@ class fhandler_termios: public fhandler_base
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanu=
p; }
>      void cleanup ();
> -    void close_handle_set ();
> +    bool is_attaching (DWORD pid);
>    };
>  };
> =20
> @@ -2199,6 +2200,7 @@ private:
>    static console_state *shared_console_info[MAX_CONS_DEV + 1];
>    static bool invisible_console;
>    HANDLE input_mutex, output_mutex;
> +  HANDLE cons_mode_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
>    size_t num_input_events_processed;
> @@ -2379,6 +2381,7 @@ private:
>    void setup_pcon_hand_over ();
>    static void pcon_hand_over_proc ();
>    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> +  static int active_non_cygwin_apps_exist (pid_t pgid);
> =20
>    friend tty_min * tty_list::get_cttyp ();
>  };
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index b72083447..592f6d14d 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1154,23 +1154,23 @@ peek_console (select_record *me, bool)
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
> -  fh->acquire_input_mutex (mutex_timeout);
>    while (!fh->input_ready && !fh->get_cons_readahead_valid ())
>      {
>        if (fh->bg_check (SIGTTIN, true) <=3D bg_eof)
> -	{
> -	  fh->release_input_mutex ();
> -	  return me->read_ready =3D true;
> -	}
> +	return me->read_ready =3D true;
>        else
>  	{
> +	  fh->acquire_input_mutex (mutex_timeout);
>  	  acquire_attach_mutex (mutex_timeout);
>  	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
>  	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
>  	  fh->detach_console (resume_pid, fh->get_owner ());
>  	  release_attach_mutex ();
>  	  if (!r || !events_read)
> -	    break;
> +	    {
> +	      fh->release_input_mutex ();
> +	      break;
> +	    }
>  	}
>        if (fhandler_console::input_winch =3D=3D fh->process_input_messag=
e (0)
>  	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> @@ -1180,8 +1180,8 @@ peek_console (select_record *me, bool)
>  	  fh->release_input_mutex ();
>  	  return -1;
>  	}
> +      fh->release_input_mutex ();
>      }
> -  fh->release_input_mutex ();
>    if (fh->input_ready || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 8f976b9a0..8fcd89735 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -559,6 +559,14 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  			 PROCESS_QUERY_LIMITED_INFORMATION))
>  	sa =3D &sec_none_nih;
> =20
> +      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> +	{
> +	  LONG pidflags =3D PID_NOTCYGWIN;
> +	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> +	    pidflags |=3D PID_NEW_PG;
> +	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> +	}
> +
>        int fileno_stdin =3D in__stdin < 0 ? 0 : in__stdin;
>        int fileno_stdout =3D in__stdout < 0 ? 1 : in__stdout;
>        int fileno_stderr =3D 2;
> @@ -586,14 +594,6 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  	 up on ruid. The new process will have ruid =3D=3D euid. */
>        ::cygheap->user.deimpersonate ();
> =20
> -      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> -	{
> -	  LONG pidflags =3D PID_NOTCYGWIN;
> -	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> -	    pidflags |=3D PID_NEW_PG;
> -	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> -	}
> -
>        cygpid =3D (mode !=3D _P_OVERLAY) ? create_cygwin_pid () : myself=
->pid;
> =20
>        cygheap->lock ();
> @@ -737,6 +737,20 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>        /* Name the handle similarly to proc_subproc. */
>        ProtectHandle1 (pi.hProcess, childhProc);
> =20
> +      /* Start the child running for non-cygwin process*/
> +      if (!iscygwin () && (c_flags & CREATE_SUSPENDED))
> +	{
> +	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> +	     can accurately track when the child exits without keeping this
> +	     process waiting around for it to exit.  */
> +	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
> +			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
> +	  ResumeThread (pi.hThread);
> +	  if (term_spawn_worker.is_attaching (myself->dwProcessId))
> +	    while (!term_spawn_worker.is_attaching (pi.dwProcessId)
> +		   && WaitForSingleObject (pi.hProcess, 0) =3D=3D WAIT_TIMEOUT);
> +	}

This is an unbounded busy-wait, empty body, no yield. `is_attaching(pid)`
holds exactly while `pid` is in `GetConsoleProcessList()` and alive, so
the loop exits only when the child attaches or dies. A native process that
never attaches (GUI-subsystem, `FreeConsole()` at start-up, or started
`DETACHED`) spins for its entire lifetime, and the loop runs on every
non-Cygwin spawn from a console where the spawner is itself attached, so
launching a GUI program from a console shell hits it for that program's
whole run.

Reproducer (`spin.c`):

#include <windows.h>
#include <stdio.h>

static int attaching (DWORD p) {
  DWORD l[4096], n =3D GetConsoleProcessList (l, 4096);
  for (DWORD i =3D 0; i < n; i++) if (l[i] =3D=3D p) return 1;
  return 0;
}

int main (int argc, char **argv) {
  STARTUPINFOA si =3D { sizeof si };
  PROCESS_INFORMATION pi;
  CreateProcessA (argv[1], 0, 0, 0, TRUE, CREATE_SUSPENDED, 0, 0, &si, &pi=
);
  ResumeThread (pi.hThread);
  unsigned long long it =3D 0; DWORD t =3D GetTickCount ();
  if (attaching (GetCurrentProcessId ()))
    while (!attaching (pi.dwProcessId)
           && WaitForSingleObject (pi.hProcess, 0) =3D=3D WAIT_TIMEOUT) it=
++;
  printf ("spun %llu times in %lu ms\n", it, GetTickCount () - t);
  return 0;
}

Point it at any GUI program (`notepad.exe` spins until you close it); a
console child returns at once. A console `Sleep(3000)` child prints `spun
109 times in 16 ms` (it attaches immediately); a GUI child prints `spun
86543 times in 3000 ms`, spinning for the child's full lifetime.
Instrumented, the no-yield loop burns roughly a third of a CPU core (about
1.1 s of CPU time for a 3 s child) and issues tens of thousands of
`GetConsoleProcessList()`/`OpenProcess()` calls, achieving nothing since
the child never attaches; corroborate the CPU figure with
`GetProcessTimes()` or Task Manager.

Second cost, same hunk: the loop sits inside the cygheap allocator lock.
`cygheap->lock()`/`unlock()` is a single critical section spanning most of
`child_info_spawn::worker()` (the process-local `cygheap_protect` SRWLOCK
guarding `_cmalloc`/`_cfree`/`_crealloc`), and the busy-wait runs within
it, stalling unrelated cygheap allocations on other threads for the
child's whole lifetime on top of the core burn. Directions: yield in the
loop (`cygwait()`/`Sleep()`), or wait on an event with a bounded timeout
instead of polling, and reconsider whether the wait needs
`cygheap->lock()` at all.

> +
>        if (mode =3D=3D _P_OVERLAY)
>  	{
>  	  myself->dwProcessId =3D pi.dwProcessId;
> @@ -810,18 +824,11 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>  	    }
>  	}
> =20
> -      /* Start the child running */
> -      if (c_flags & CREATE_SUSPENDED)
> +      /* Start the child running for cygwin process*/
> +      if (iscygwin () && (c_flags & CREATE_SUSPENDED))
>  	{
> -	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> -	     can accurately track when the child exits without keeping this
> -	     process waiting around for it to exit.  */
> -	  if (!iscygwin ())
> -	    DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess, =
NULL,
> -			     0, false, DUPLICATE_SAME_ACCESS);
>  	  ResumeThread (pi.hThread);
> -	  if (iscygwin ())
> -	    strace.write_childpid (pi.dwProcessId);
> +	  strace.write_childpid (pi.dwProcessId);
>  	}
>        ForceCloseHandle (pi.hThread);
> =20
> @@ -868,7 +875,6 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>  		prev_sigExeced =3D
>  		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
>  	      term_spawn_worker.cleanup ();
> -	      term_spawn_worker.close_handle_set ();
>  	    }
>  	  /* Make sure that ctrl_c_handler() is not on going. Calling
>  	     init_console_handler(false) locks until returning from
> @@ -906,7 +912,7 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>        res =3D -1;
>      }
>    __endtry
> -  term_spawn_worker.close_handle_set ();
> +  term_spawn_worker.cleanup ();
>    this->cleanup ();
>    if (envblock)
>      free (envblock);
> --=20
> 2.51.0
>=20
>=20
