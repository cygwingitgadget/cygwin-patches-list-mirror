Return-Path: <SRS0=+fqX=DZ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id CCD864BA540B
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 13:43:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CCD864BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CCD864BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779975826; cv=none;
	b=XUnbFGH9MOOP49KbnRZFMKzX264oqwc9L+2SywZT0Il+C4vLK8RT/PmR3aPw9Y8AKT0ul9YG1qFFBy1vkrVoYtp7cNeihLOtFpRS4Upe+nA8X/dtRAtPdFOk7DLT/akJhRJ6U9cddRzq1F4nQcuBDPgm5G/hu61qDq1KaHUzuhA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779975826; c=relaxed/simple;
	bh=H2MBhjfShZdWvKq2B62B2w9sStfZ/WimE+1IRe10Ac4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mzd/rA8BXIvdcRawCEwkr/S3MlVjYkGGb8tyDZuxIaqIiVGX/hyTIjbIf0mSui2o8ks9yyIfBkpuXH7zIV2OGfawVcsZ/6k/BTfUPNZi5iVHiH1QvyFIawUuw3vZhrYDYnNewHC4zAHboWyP+v8P8NEvfBoAURkqxhgtQkSBAx4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UqkZhWp3
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CCD864BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UqkZhWp3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779975819; x=1780580619;
	i=johannes.schindelin@gmx.de;
	bh=YrSiJbLI5QPawo4CUDlVSkRSOPeXHvL0g5Ev4Omgdpg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UqkZhWp39PhjtU90al2c8ZKeXpIYNj6pvHl//o+3seIuDiCaUX2g5IzSIoIOBn7c
	 Hcn1orhEE8F5To5c2upBF69kt0l0n1XhYjOu+fq1GHA+7/zCx5DbayuqiDhG1Aqi+
	 WDCZQtxCFLlKKgeYQOtF860CC9LOyBfLQfELIGwptkhUMHi9HkVPihzgG3EjDTLuB
	 5KaXwdsbSXLhQMthggpPP35raHuPmEG3MBuBpZ3P36W9uejG6eLlA+Fg/6R8MGt/W
	 c/UnG3LmJNGTSR6Q9WMIdDmxCZp1hBjDN8zEmq3gyjBQ+2mqEzUVcQAFTsiKDSuZO
	 AKy0afLzHp0VvS+vow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1x2Tjl2C5i-00jcQr; Thu, 28
 May 2026 15:43:39 +0200
Date: Thu, 28 May 2026 15:43:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: fork: Call pthread::atforkprepare() in
 lock_pthread()
In-Reply-To: <20260519235133.19276-1-takashi.yano@nifty.ne.jp>
Message-ID: <42c9c420-416a-d532-af07-4e37d81f8a35@gmx.de>
References: <20260519235133.19276-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hCruK7NYDFMqmJyxWEGFuhNo/GCnN7GHq0rlWKMt6BHlF2r3wKI
 qF0SjZVuoYkIh6ziefECVSjktZUuIik9j/8DFD/IjuJPR9J6EQBd8aKQyBKwVvfBivPFNoR
 R81DeBQqVLdDXnOtqXEBg3OUGXgbFxAeBxOd6z4/Qk2vlRfXJKHUdvGGY/oEOe084xsI3oc
 +51JQEocVo+oRGP5Fm4ZQ==
UI-OutboundReport: notjunk:1;M01:P0:KZ/l6Tis0iA=;m1GtpRX+GW3cVvEqohkf0KoiCEa
 I66LYOs6Qy7awt3ymLy1iHVee22OT0D43RGcjq37Xmbddk7OBAvGmg3ppkLd8cEvgRPASKHMC
 2mXWbod36Z7x/jh/iEokmEQRMRreTAugqUNuwxhzoyWwnPeSpxEdbRr/gRpQNDG0O8mKOgQgp
 +bsYdrWj0bpueCFhoJoM74Bp+dmSdQgH16tOWJ61vbi/Hqvmwoqq/n/1PcNy+pd/0VVWvQOZt
 RqVcp3HlYJAx/eXbg2ywN8cEeVzkyuMEM/cRXC9IRFFzrw4e74hZ+H8WfNEC5U0ltiw0xdSKU
 4nEgd8fhqa/rMgO32nP5ejhRgoaGdYcskq84iFP/6Z4ifAo0Z8HEG8rRmA5Pwy8UZw/C29+AU
 jqXD/4crj9iAyT6JTRgcn9t5Oo3W80x6JfXC/5eOls81FU4SKu956QSOHAdDiWFXzBWu+UYFM
 WSgRaciOVBTk8spxFzSm7qc980+MVRZsXJtBPmSzoeVjDHqzayKMVTfAR3qGi6QniNFvT32Sc
 yGqTzPqZYVtqR9KnyjebrU8VF+ny4LM0sK1blin6RLpQfLt8Ll/I6Xrgl60MDajda+B2MZ+7x
 OF8quOFMWAogq7DNHNMaaAE6gT91ELOD2or10VyfLwnVtBuoe0a1jWhaEI1hyeimMCtFsIU2e
 BPp/rKEtikNmNm1b7gysonR/xNYt++Kzl1m3Kr7QhVqqQo4G4siacfpm2UJXT431FdKtB6a+C
 1riH+/IujKD4Xm2JBhIMrjqvE+d1pea3+xD6yW4rJJzZGFSG179YvqwqtgCLDzI4aWY0ikfHi
 S3Fe9jg1mM8IxAYa/Qh9AhPSkpKkFh9aBOam5LVDdZnMi9PKAY04ypS0ac0290qzU2g/e1FEq
 CVni5YWSNFCNxtjmijfkBXFoNKFha+PCrmC6rANJlqE4xO/QLLqQhW83HhOM+sVptMi0s11z5
 GnVwNrOp3d4b11784J0l2958tnXuGItkn9vArNVSD7Lnq2tvjYGvPA1lM6mfmpyBBMzfkPlNt
 4IH1L5Mzvt9FCi0lEL7OIVW+ieafeXF/jKkHAeJaZQ+/8OIM53iodUL/CNGfOTdSmBNplEaar
 ZCKccIPic4Z/R5BXQ46K4H64ibL30nPRHAtlxGLhs4blrN+si5/0AGOFnAPKETZkqW3zs/lop
 MXMSMc8+vOYhtyhKOvj1/YBGAY7DpMH5nTwMyUHai1GBA1ZAC/wtyf5MVguTZ5KS6AvmnzJZW
 Q193sZXSXII2xaX9lmZNilT46TP2oMyQSz9BXkaM9RvzbDM4+1FnquwuDho8tlSL0nEpBARAT
 KzlrVuxx9cD4amn5OwkxC1iA6gHvU43eOiQ30pMzfJI3N/Zb5ZQwY1sYbT+C8xlqraD/mh07R
 /KQmAhBAQB1N0HsKkvakF74lshNxptsNlW2tkGUBQ1nSCMZhELeHi+cq6Tp91pqNImTSZouZT
 P3NwyO3KDfusxTdAIOljNQq5M2/0ulqeM2lSfXN1jIjERlu5oXBt13MPNdonqWtTjMgDEtSot
 xbIvFV0A0FJZ6dW49xwl8TKrwhXW8elwOovlqZbEC+3b3w2w8AmHz2sti/XMB1oRefzBow+AJ
 zw4zJjOL5vNUfbubyR6nQ0lRkk5RQz5B8I1EIT6BEkBShjNKHvZwqB1ZSI57aVHFqdHpyes3/
 plFVGKkZmguwY03Puyq4XuEIQJERE4TUolmlBnoAYk49vBjVeJCxchLsA34iqZNV9HcJ28plw
 QexT1bnQ9EZPfcY/WzzJiWhaoxr3HwBxcS95unMDwscOj2b/5Joyan0pdV50telYQ+fKZysfS
 PLnTM0xx3FjcbEtUaTcMpC53qD2siXI0CYPRkf3DP2yssagwcBPfJi4tX7PII+VVCUhGlG20Q
 5giUxOYtB7NZQkktzPL2TE3DhyuSZeld5zPRW/T8UbkDexo66p4dv/ZWJVtF9m1dzhqJUKkJD
 nZwbUS1lu15E1O20DAU69Qw7xtHlBkqlDD33AjK1/ZJWe4MufhPj+Yo05nYcc7IqCL71deRIw
 Cdi8BrM6B3qIKTKOCQy5y8O6q/Sdi6lF5fFG8XTgnDi7547PZ8qQgw09oJnLYOm5UUGFO164h
 yNVt8HUMXaEn8hhvrtQtDifm8vVgFEAaO5VzQcSpk7Jn1MRWrJARdIXbzLVspQdIx98h3MAEA
 vJ9Pf7EjEf4FAR0aqeW5EFs4mV3BYjx7q4k58eGcwywbU5DZxcmFRwl+7xaPYbBKDbiUBrs02
 SlRMKipzIqU1XU8I1eJZ9w07unHCu+/jNIo0sIa8VrdKXxSnqHuinGE6ZXZMPRCfs9tSV+2r0
 V1kVuK26hsH949d2QH3DwQ1QdgRhEsgtg1Xog9X5COV4ua9mgJNQ088Q3XW7tW+nNu4wvtI4m
 xplyHRiy4iJxI9GBrI5DGJOdCUmYZtuWpbuLBbgy+Tfk2CLIkhJjTw68/TLg+g49VxGdhnuV6
 N9Nf8WFjv0qp7VB8GgUCqJ/hm7zMW2kR1APHTNMXRsaft53ltw0gjKeNNWP+ce8yOZ6824Dob
 uY/2zikcii+9cW2xPNUCe21ZwgfY+Ydw/DH4APN/c2gbk/50Y3hlUhrxT4iKQbPjfHyKDCgt3
 PMxL5NE8Gx/LjFVxlRJ9ZUDXzQY8+qebrffh/4BCk+UC2a2Pzaw8V2Rl2O7cKQPd2CMMCSMGu
 /3eWIBVIzcIZ7QFM0xFVUdvX8u6nH0YCqNNSNrTESRH79iD5Eigzjdu+upBFLsdqLVVRjUKyQ
 Z1LOmdFcAyZbtuMmO73o5PMuqDgjF75wa2nri1yOblew2DDyIyz2+agVt2kQugD1rVjmhGaKA
 4lRLEvWXJC9IOLkpJP95cXZRckSml1DeETf1PWOuCKPg2uxKJ8sBUOGnJZrwkNVZ9OhtPxaAs
 6W4geEsjSWDDYdtbkg7VVhCRaq6LhGe+6pPNi+ok18MbOXjW+mLvJXDnOynRwsRNGRFg8sAO8
 bydRonY8QmAk9BPc26384EaR3QN/gUAj6Y/n38Aj3/HH1F05zLM84tIOyu4tgmKUfx7wegwnN
 FYyg+/bSW5TBG1UHR7S4fslt9Wx3cKRZrc+GBhb4doVUjauNYqhd2YaPRJDckC+tMNosWK9/r
 uLZVkBahhz/jwlZtpCB9vMpkQEufteJLwcuGEWqbvovbSxYbAqVoXslvQ+oF1dez/KhJ6cG/6
 QA4Ioid2jdMqfNBchfqFZRFtgvunnBksFxaVKr5qtYnVGpA0e+w6HhpUaClKqIB1Cnb7gh2Bv
 xQGm5Rm0Y6QduXC+arHZ1KJwYOg+jRhS7qyiXXCGtThrgpIcSvZN4w1PaiR6zz4akAgPyJeV/
 +Kin7bTYakR7mEjvObEpfKYOpCuVYqLfr+nG05G0ExQSxodAmjgiNQWdc3tpoTlBFuGpx2ni4
 aYJCG+d1riEIULh/nYT6pCs55ZJ1yVOB+cdJ17QCBqJiXFhCEUhwn+y25YNpl6NmSMEJNrJGU
 5pdQzQ2u+0DfnVSoMfbSRD3D8J8RyDWvFKYIsQQYoIoKqusEZY4qP7ZEc/M2zP/ZjAT0cvVHW
 W5R+Yy+Kbwpaq8ZMU0dxAvedPu4W3jXQp30x2Sy/8m0jrl2sMXU2lOW653xkoBNKS2/85d0VN
 jmfzNmpbn3P3RFl/MhQ4vWEC5D5qBQajMX0WVjXi4Rx7ki1W3tkfAiY/jgYkydHTPDr6A8R6M
 fz/7mmXc6lppQOyC6IYaBYnnUdCe+4NKCoH1H1x9frfK5tjeEN1YkRb2xVbgK+ziUDp+COAdt
 MXgKV2wAykE6ELz/2++ji0gfdchD6j0xWomhYJ3ZpnrOuMGLzaFwufKTXj0pj2xmktZkrYmxn
 +U5ISph4ySD1e9ZPgya1a4DDuS1xO0k3C2kqnU0xDig685XuOPQgk5rELg+l06sihc2uzb/hb
 ZA89HJwtEsMWutxdqWCG3F/fwpINKnWbHiC+jS8Dg329/A0S3heBwiYTCbSQY7J+1lYtEbrAT
 smwDQoJoi3VUGGUmeyRxhfXAUkaBkAvAQSuQEbAF6ERYsr1vHpjssUXo77KMHxX0MakiXTejB
 VII1aJR3RQkC8Bu8jpGgvy0tY4UWql6MG4DZ/Ew98HONjzlU2J1POAslEb/5ye4/qb9sqnUKg
 omo4jOC9YBDqGWSzrjLSpz6c8LsxI83AuBBDQRLSyaeBugEjaaz8qAjp29oYIkQ6dgNY7Yg8A
 ciczjW3KMdFztIpzb8wpcydxAYTJYtwwgtDMGijie5evzMgyXAR7dhqayEOB/p+WZMCNVGsC3
 kMZAoLSwdLmbYaz3YjoLdlIUb5FMojW8Qy85RlazsKab24OY39FeoB2Rb0SaCzx6pyTV0M289
 +dDiu/bQsdrcYix7g34HGR4vzZm3n8o6nVlczX1IK4cMmd5v0/DCuajWexn/cEvhxU7rsIwuq
 O7zzV5yYZ7QyfyKh2zV8s6y9IHWqCWcxWKC+zFV5xgBtb0w+qcb+qA2V5T+xHUkPKTo1LMLkO
 aPlYYX/2jCVrwrAoyurjENe8TzcO4d3wmNb6DmBzRKMrA1TjmLHFPjeR7VGn3qmKfM7dhOtSn
 M2cKimI12R9tyHljxViPQ7bhgnuLsGU6nwgwMLrhKp5878GxIpOXoTD2FoFvTPy9MTdS33YhV
 dfxH/5tzlb2LuDBp6zZBZHAKpmdnLjSkQDy8o4H61r79w8YExRQOqpyHLERdQIfApxjJUVbdg
 SAWpQGvs+4xGMeIltFECARhAFpG6gRhSVn53ywmCWLKV27Aqcl00YKdiENq9XPwk5kVNB5hlx
 23MD9bmHcc6O7vqKqOYCdPdwz1F6Ebk2l6jMN4IpZJdf8uaCY5lg0bgM0mS9y/tMRObJaUJ9b
 +ve2kX3JCnaaon6TMaBeVv8EDVx+4gdxoHslYhx/SHb8uuvpmx36jP99JyXF8ScgpW3QXcbTe
 BxWLAkPs7Rxq0ehDznS/f06Yo/pbaiiANFBBnN2dnaqElcF4K6b4EzzUjJey/vboNVoG9d7hs
 TlRvxNbPWbCm8WiZaaeKog+ag9BFACRKggIotKbDC8ZpU1fBKEIterenOKS9PZizUfznjWFcA
 2MOTnDF6VAm5n+q9DQ8yh+TSIxR2bHormkr5QJSoqLfa6nR0yxYs5bwm/s8kMwDOVw4sFbEn1
 SRUA0HVh8k+prV9KfkFzsoxYt/FXd1XisykzEihE0M/9evSkeObLaSz13K+25QAbqWDhJrzUh
 tnQPTRltv9PWUREXin+dKzV7jntwSBLLJcIbLbJ/2wx1SvgIH3yeWDHcze2R2ZvOEdO6FxrV2
 CDGbvUTYGKWREMt7Xu6XB6WI/AGzYFxJB7AeVWzMOizwXTDp1X7oHJ8S2SY4xcvtjxMYyvYJ3
 vcsG80cROASM0PNr1ADQ9j6WF4HlGROu1cDzMtflFrLzuAaRIyxQL/d9PfFPsPxO95K1QlWcx
 0w+H0leUM7fK2ffs0d8Ll/QG2k4OE/uAdyS4Td+yAJteOeitn831vN13XWbZH0O+IaYLuq9AJ
 qSZinB0DJZ4tYHGpaHvEPjVBBCDk0M4tKlIUBwgj3s1iYrTP3Zy5Zgs3RP+J5ysVWXnq5NGXr
 8gH+ptG4jdEktxWl0pJBvQ0gGC+zToykQOg6oA37XkQGJJYQdlI83DObrN7DTxZfD8dD78ePQ
 E6OiY70PGJsiFGjbKo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 20 May 2026, Takashi Yano wrote:

> Since the commit 5f515cf3d6e3, if one thread calls fclose() while
> another thread calls fork(), a deadlock can occur. The mechanism
> is as follows.
>   1) fclose() first calls __sfp_lock_acquire() and, then calls
>      lock_process::locker.acquire() via cygheap_fdget().
>   2) fork() first calls lock_process::locker.acuire() via the
>      constructor of the lock_process class in the hold_everything
>      class, and then calls __sfp_lock_acquire() via __fp_lock_all()
>      in atforkprepare().
>   3) As a result, the thread calling fclose() tries to acquire the
>      lock_process lock while holding __sfp_lock, and the thread
>      calling fork() tries to acquire __sfp_lock while holding the
>      lock_process lock.
> This leads to a deadlock. Before the commit 5f515cf3d6e3, __sfp_lock
> was acquired in the constructor of the lock_pthread class in the
> hold_everything class, and since lock_pthread is defined before
> lock_process, this deadlock did not occur.
>=20
> This patch moves the atforkprepare() call back into the constructor
> of the lock_pthread class, restoring the previous lock qcquisition
> order.

I am not super familiar with this part of the code, which is why this
commit message is really helpful. From my point of view, this patch is
good to go.

Thanks,
Johannes

P.S.: You may want to s/qcquisition/qcquisition/ before applying, even if
this typo cannot harm the clarity of the commit message.

>=20
> Fixes: 5f515cf3d6e3 ("Cygwin: add _Fork() system call per POSIX.1-2024")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Fix the commit title
>=20
>  winsup/cygwin/local_includes/sigproc.h | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/loca=
l_includes/sigproc.h
> index 92cda94dc..21367877c 100644
> --- a/winsup/cygwin/local_includes/sigproc.h
> +++ b/winsup/cygwin/local_includes/sigproc.h
> @@ -131,7 +131,15 @@ class lock_pthread
>  {
>    bool bother;
>  public:
> -  lock_pthread (): bother (1) {}
> +  lock_pthread (bool do_atfork_handlers): bother (1)
> +  {
> +    /* POSIX.1-2024: _Fork() does not call any handler established
> +		     by pthread_atfork(). */
> +    if (do_atfork_handlers)
> +      dont_bother ();
> +    else
> +      prepare ();
> +  }
>    void prepare ()
>    {
>      pthread::atforkprepare ();
> @@ -166,15 +174,8 @@ class hold_everything
>    lock_process process;
> =20
>  public:
> -  hold_everything (bool& x, bool do_atfork_handlers): ischild (x)
> -  {
> -    /* POSIX.1-2024: _Fork() does not call any handler established
> -		     by pthread_atfork(). */
> -    if (do_atfork_handlers)
> -      pthread.dont_bother ();
> -    else
> -      pthread.prepare ();
> -  }
> +  hold_everything (bool& x, bool do_atfork_handlers): ischild (x),
> +  pthread (do_atfork_handlers) {}
>    operator int () const {return signals;}
> =20
>    ~hold_everything()
> --=20
> 2.51.0
>=20
>=20
