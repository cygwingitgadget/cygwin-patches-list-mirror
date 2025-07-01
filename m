Return-Path: <SRS0=2UDU=ZO=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 7CA14385772F
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 12:01:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7CA14385772F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7CA14385772F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751371308; cv=none;
	b=N1ERjrFuwf/IX52PQ+nxrh+puYkgS2FM4LEia+MYyiTtzrTXhbXH9V2KexK0i/3BLTsiSyi1xsmDgANJVbenDRYiasWY1PNiHqhdPvfX9oUE9ZPlXQP7gE6iUTnmc0IZp3vAhjHPaByRm+4NAVRA4pkbSYpxTSi6WZST0NxF3YI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751371308; c=relaxed/simple;
	bh=wg6zhgZ1RF3z/CrQGCv+x29dzEt8HtguRQvL+ptR0/E=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=htLCYXd8HKSPukcCiz3yBOUC7mMF/W3BDlPU5dIGrzuyqP5hHZvnIZLoM5OUq20tlRVaLovKwKyJe3vZEfRW7zj7Bfc5Hks2nOEftQaf6AwBJ4VD+8A3qAKcix4MeBCxkL/pEy6HAhTQ/FPF97NZ9g1zhDzogz2Byub03ToDtG8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7CA14385772F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=k+FL++2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751371307; x=1751976107;
	i=johannes.schindelin@gmx.de;
	bh=VsPq4LWP9p4VuZihuD9P5RxJb7x1x1ulhAOUW+MmFf4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k+FL++2EXCcEDWHkUP5P32SeGXM52c05vk8YgcyF787GdAZvscrRZ35AwpwfI2qg
	 mAFSsIBXdON3i7Pw1UTiV8yy7A7ri1Ujdx7+1K22YhtE8MEYcdFPPM3XA2GyliVlX
	 vqyCfmyvoKKal4o7sfqnRMKlqXDvuAxEi0WBMgVNFco1kXZ8kuq2D8H7QXGVpPjG7
	 et6K5G+SkAmtguCCGhigIAb3tXzlCBEt6ooPdl9iPT3y0MVkvoWLEsA1Pta3SwJZF
	 +vOB3/pRod/rCMq+kDXjgEAm+94HTyLcoEXhgLDdCkk9yUUxnbsL3LIuKrwcHJ/o2
	 /0J6/jlCHWR8REI7sA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1uEuJ03w5w-00TBse; Tue, 01
 Jul 2025 14:01:46 +0200
Date: Tue, 1 Jul 2025 14:01:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
Message-ID: <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CyrVLkZtvOaBpv02P8/vOEVd52LSgEb0jbLYkHY0HkX8NCxGn0Q
 93f841w9yD+HLX2RA5UbZHeEh8V4ThGyKUpp1P7GGxSEj3dyuP49KumYLFJKMnpv6CxTB0g
 7uV3PPnI4qcZOokQJAsfstBpj8YKe6GdoSKl6NgKUGCjQLLvdL9l34YSw88er/8y/EKoO4P
 yC22QdLqL8D+LVPpfAsPg==
UI-OutboundReport: notjunk:1;M01:P0:5bUtJc5DiI8=;2HSknL3rKLr+q8U72mtPvbeSlKI
 NYErrLzM87vYmSCNox4yH79tQVZTq9CBv7jVloDKlK0MWJpa1UPnAxt9yNCvJ5NWhENEjT7Fa
 H58aOPZcGeRz1pBf18zAV9MmGFpDYAMxVTlAJcabbspEerHjHtLfxncwzgx2323cv8QcH2lgR
 O/excu4Y8Gz0MoXGX2hRDksBAReWUny8PCZwD9GSDl0CDclJkMp+/bhzJ9B0DeqnvOQR75Dcm
 w+B7Bfseul5hoxxLagJkLsXa7yOqPtLfAv0Ttf3GVk//0VjfdZYMCX7vOhXesIjo3f38RK0uU
 KmsxgftAeOgFTtIk3hWVWdFuQiseiWc4vzwwmsedlItkeRhYSrPwT0t5taDr6pB2k2iXY/vVZ
 2LE5w5zO+cVBBMpaELC8bCsg+JP1U1rhJij4DGkqCALml0qlSkLT0Hg1vY7p/SN3BrqswfAZ1
 OsqB68acdOT4+HMZfI30kBklm2VwxGFy1B5aRBZHcLPqE6tsyo0+/jN8UNVV+5tTWhHQXlOE7
 Gbwp+P4OktgLA8tLwsRS5uN1WCDJW04HYP421Ef9m4nA6LQBzB4KteW32cUxJWKOgDW7oE5wx
 S/7MDkdvtyn/VG7cbiXAqAy4/SXOkbOd0+6kIwiZeiSjqhtDSRyG5R5xUip++XnOGJGHBfepd
 ZR2EOb0SpkiiQY+2avAnRvHta1+iwcveHGbik6NNpMIXP5I0DAv/HBcFbfhYnb92Jwa1720qk
 6icgoHIPxZggYJTSMrzyHbH0den2Q5sKGgQJvDyYtGr/DQ0gpHhDty7Ilu5p+P4JfbCeYALyG
 qmyUYZI8eMft88bYk/mxLhqKxx5aP1m/d5CUXI7kOMav/6+mC7UyxlDV0HzVnAifDb45Ri3io
 dx76wSAryWV1AY/dzMzoaKLEEYc6Xg51gGwTy9mG/26qk7VNjDNUcpQn0CYuuV2FYhughuDh/
 Mr9UZRG6jB2d5YMfj3aLPVbdrhXlNrbm1ZOgN4ivLQgmmTPPylHk3JcR15ZN3uL5YexGnDv0F
 b0UQEIp2Ky1AKbwnKR91K9Az1MZyrPrnsyQtIawzv5yyzDzBnwR4KFKS5gqCrQTaQ881xgaHb
 Ri7+Zc9d8m7gMzvqFbmOdAFLX4C173B+mTv2jpkVwEXTMPDNCdDv7I0MHQv3llVAK5iqLUaZt
 1mB7tVr7/DEly5Rotpxs1JOt0cDjO1DDO1wAkQUf0QbwguscPl2bC3PUmrAwoLhtgY5wEhfXY
 7JzfA+DmhPqmiNu0xByRpv0h2lXwxJIIvk0jPNV+bkIqnGPfanMB/9B1Kmh6fwltXq8AWk5zQ
 q9MXHZcKZQEjVd/6bTM/+98MSJHDnJCtujwa9HhuHXnMzeqoHgGQiyf5lMKMfUcVEL9jAYmvE
 v4a0qGryXrIrEzrjXl5Y9YD7tqMajCRptuTB5qsSbUMLRl9iGrnIuu+dSSNRSZSXSd4YhI/B4
 M3wlmp8rX9pyIFUKjAyXy578Gwc3gNokieu5RCC+LNcPV/vIWrXmlGV6X+6vBqjjNrA9AfbJr
 dKWIZuZkLJ/OhVEDl+V/LMnt8fg6tyz3MRfCmYGEHetD0r43ntbY233ChkdudZ/caXFAqr93Q
 ulDCihKtTW7tUUfVABW3K8nNeYwI+JdgwCe9M2PhXNxWb7QKRRgjJoHTdOyBhBPF1Bj4nqDRY
 ObwV4O2eCI7IsAIOWNtYn8rN/3+zcCw2rNO4IiTYGl0l9kzPeTsB7eAdAXcrN/8HDvKFF1pDS
 /0kD7gcWSTUy+qEyhJgu2ooIkMTqScR8HfEJsfzT0rCzojM0BXJQgmBwSqWqIDGplIRQYiQ4h
 z8psRd0ReZEHRtvkC4l9yKY4W6etg+1ymeabELzn2UVPfT9+xm3LQsy+bVuzVSNYGJKEU3Etg
 rpgKNXfBIpUT4F/BZpt7fVI7qFTET2dwS/4+iX3nwDcLeXLpvHopvNQy82lnk2l6sNYy6m1Ku
 GTnWa8+lBWcb1kMruiX6tUpojOj4kL/UCEz/rLYme9qRLH3+psW1gS5Reysy0mxtZASCjDBuf
 nuwBg9EA4aXw2rka8oP8/8J64gLdfCkYcQmo2eyRpvzduy6prse0aq7fn6QxqwoOrqrXfZ7by
 HWd1w+8UyvbiRRhZeC5tU69NRyXyDTLKI9f3o64nzqlMkYDNIv15v/ZSfXEyQpEA6ynYeGOH6
 IgkNmmPrRdT8KoY7vWhInDToyrUf6zMT46F+P7hK8Exzclq+8HNNkzH4r+jnOWrklkMQT+Lkz
 6RP88JtvE7MnSDdZOVjY+o9iA8DgA7Bg93s7UL3HP5ucsbnYhAq/5/x2iIqclwFwMPMsYq9s1
 nCoCvf8YAZpZnjL+3Z/aZa0+UZN5u71eC7y178x22qLpqdn7oGNA2ab0ZDb54y6Vp1F0I51g5
 zWRsj2psiSOtIZjDyX75Rpmii+4o1iovJbKRbnHIghx5vV37+Js3HDXGh8wfdEQxK80U3SvcB
 fDIBG4aIzUu3yMSnAYNzTYU62eYahqbAL5/u2wpMXcJzEX7rz8ivLPrybFlUmeShqBM7gMVUr
 5eb+zA5zKhYmkytAL2+QET3UBN0OJ3Urfz0Cs9xyEIxnyVKjX6Nk/gABZQ/im1te3OHvSFos6
 gzSmZpv0LPouCtSv2LDxgiQruRy5kexAThivtA+Varx2WMcH7EfiFK5h/0RGyuZ2SMC6fPc3O
 aVOEHGR3v+AghOOe0IBNkDXHMBJvwLcpFtlgNHq5Y9KSiAF26lWePKGGytEn9Opp+HKIXrgYC
 GBNsoiR/p1x9beogUmgknul8Rf5/8B/v1Dc2+wZ8gweCT/eh0VP6RoL3TfCbPmyFUj8cyUuad
 sXqkcfCcwvoBpy4cJNzYqDxPfDM6+GGs6P37dVG3K1Ms+rPQULobxI/VUW2pT6MmYeJLq1qID
 1ZOmPBnVVr+EoZ2AtJM1SPbLILEdQMMrqaRxCZKoJklGioDfMz0wcK1bCHjKb3gzNRN+kUKiA
 HBn46G19nT49avqi+wjqtBTBIZdJzY/CpOIuZ7Zu9gUv13076xjf3MRddzylnBGwZPC+dHtAO
 ysU0qcCdH3aAmdHu1Mx9AmWbXqJLwYAK3J2YxwhySpDWAeJUDkax7+hIp8EP9Y3dr6EbilR7a
 Hgt8yHTSn45nji8B3SM9MrBWKjBj2SilYqTGxDThFq2E5TDOz9twm2DKEcNl5595Oz7NYag+i
 USAlr/OOoYVUSJt1nM0CUcG7jyyTE+sZOP3RzErvvKuiEpUek0IMpQvG2iFuBcn2xJoJCGcX/
 4caULPS7nHVKl4tCN8rSFscdFhSPqqhmteq78DS/ZRhyYQE9b3oAvy6XQ+EcBrzdhGX55FLXN
 eouQ0hhwEiwETB9Aas4ZaPBJykQM/LvK/rer0qgn+EcC1ipo29eggR/oYP6yFadH4c8axd7jR
 +lNw9JwJ17qMI9zIBgLHqlHjIbSd/kc9GEBJlWgD8zYweqyo3GWvrNtF+iBmeZ
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

thank you so much for this patch! I released a new Git for Windows version
including it:
https://github.com/git-for-windows/git/releases/tag/v2.50.0.windows.2

Thanks,
Johannes

On Tue, 1 Jul 2025, Takashi Yano wrote:

> Currently, ENABLE_PROCESSED_INPUT is set in set_input_mode() if
> master_thread_suspended is true. This enables Ctrl-C handling when
> cons_master_thread is suspended, since Ctrl-C is normally handled
> by cons_master_thread.
> However, when disable_master_thread is true, ENABLE_PROCESSED_INPUT
> is not set, even though this also disables Ctrl-C handling in
> cons_master_thread. Due to this bug, the command
>   C:\cygwin64\bin\sleep 10 < NUL
> in the Command Prompt cannot be terminated with Ctrl-C.
>=20
> This patch addresses the issue by setting ENABLE_PROCESSED_INPUT
> when either disable_master_thread or master_thread_suspended is true.
>=20
> This bug also affects cases where non-Cygwin Git (Git for Windows)
> launches Cygwin SSH. In such cases, SSH also cannot be terminated
> with Ctrl-C.
>=20
> Addresses: https://github.com/git-for-windows/git/issues/5682#issuecomme=
nt-2995983695
> Fixes: 746c8116dd4f ("Cygwin: console: Allow pasting very long text inpu=
t.")
> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/console.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 5a55d122e..1ae4c639a 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -831,7 +831,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>        break;
>      case tty::cygwin:
>        flags |=3D ENABLE_WINDOW_INPUT;
> -      if (con.master_thread_suspended)
> +      if (con.master_thread_suspended || con.disable_master_thread)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
>  	flags |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> --=20
> 2.45.1
>=20
>=20
