Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 4A85A4BA2E1A
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 16:18:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A85A4BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A85A4BA2E1A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774628339; cv=none;
	b=f4J3YDASwTa51bZ0en3EVwplIbPXlK5/kkWn9lV5gBcf0zY7wytC7bvN3ftUVwNqCL5OkgasaWqwK09KauGmmzNlLNIBFuAPeacd9WMA5H4+TgFvzhr5sS+g+MEGpiiATWMcp6ejIw67iN73yCH0F2E0TGJ5VE/ClzbTo0Vbl5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774628339; c=relaxed/simple;
	bh=LENaey/0CGGdlSAHCkOse7wi1361w8YSge/mLVfNevM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vL/pi5OERU48kDD/ffFuXOiRDatIuQ47AfqhfUbrrnO2jl6uCNCmloXorug+RPdigVhbFwACS9atcPK0gf+bpsPiEe/FNNJn4DucmKJfxLN/g5WOwwfIcr/qsx/5OHw+q2rZNJJZ37klny0GXEoihV4wNbUH3MVyY7sWp9YYYlA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A85A4BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=M7ANxB06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774628331; x=1775233131;
	i=johannes.schindelin@gmx.de;
	bh=LENaey/0CGGdlSAHCkOse7wi1361w8YSge/mLVfNevM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M7ANxB06bWNNBOnI+NRYQR6QGB9nCwxSG6R35OT1uYSoSEu5Z6+5onPm7kzL1LaJ
	 /8nOUohw/ZwJ0GtbC/FQa3cOJi5/1+OUz8cxznLi8TxnVBtjrazjSpDsQD/bR0PnQ
	 YsWibeQooibgR7NtHgqFOaNas18bQuEyt/hDz3f5FOUiMeI9meFnSD86y5KEbrCrY
	 bbCC1Uz8CaurIDsQlAqvxstN49ryiyxVuT/+x4EQFpoc2sP/2p4+2FfoQHt3I6oB/
	 Qx+xLJxPGW0oIj1KQsmUgEXFizWnNjGO9Rw8pViIFaJtSNFZtsMKPheOLzgo6TGlc
	 4uPrXmy0bv9Pd2hgHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1w2tgV1p2y-00RlZQ; Fri, 27
 Mar 2026 17:18:51 +0100
Date: Fri, 27 Mar 2026 17:18:49 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/7] Fix out-of-order keystrokes
In-Reply-To: <85e4fc6c-0d00-906e-67b3-94bb7e03c72f@gmx.de>
Message-ID: <414565bd-99c7-a044-eba8-94c11e6e3c91@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <85e4fc6c-0d00-906e-67b3-94bb7e03c72f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ESmyful0Uoz6wCazwwyGyNDAyTJZv+UWgXSzBJJj/dQ0O1y3zF3
 MKNeuIQSjedKzao1SZRQgxaOLc9iIrHXaxwwJMTOtfouqprAdqi4SwUchefAzrJfOXem627
 n8TFPFF4uTMG2fIpgbCUvb3H4W/y26EijFdvv9eqrbqNwtOJAbUH89VuVCDUh60j7yUdzmt
 8bp+i8YEh3sXmN06+/6PA==
UI-OutboundReport: notjunk:1;M01:P0:2witcM0ofHc=;qQtjOcwW/i4iNN/xOTtsK0vbal4
 PK+gLIBbwzpirJbwLdnvXdBbbHNLVeSJargqbbsNLid4CWzN3UrN6jhkfwM3lOce1jYJu//73
 vTaMbSalM8MfWTcaKH7AwEMNM4kYGzw09kegZUcmpeqtFsFEFXj0yjOIwakdbgZw5Zkgp+nPm
 E0z4xbm/rW6+NrOxlOI2gDmX6mNpiRsRT719D3gbtl8yTDIB70YAB4RPzI3BZ6vrbDNxF3uRN
 y5rPU5lBsWhu9XPStpm0aDLgowXkltqQkx+i52yvZc/aqOZ3QYLotx5Wei7+0LHoBhLzGJkYs
 d06jCfXpVTtKXv3AKsNfYmOz5qfI2M94e0oQhvqN9IVW9FM8RAaJANG/hAphZ0fcYE9bZ8ymW
 ow80dMwSsp32yZwWN9XI3MDUXkQUOcLLq7c6bfzA93tSozLrqApmeB05+j8MNXYKFckBAHrKT
 wzHURqYHyaP95Lk1hafRCNnrM7vBIHtYb9PfGOX3P/795vKnNgJDIvO3wF2UNGhMyRuRuVBHF
 tAfJQMbMQwD/VLv8o3PuBOhomRnHbyNRgc6deZx35jGsLDQpBW3DWztsAdlAgmbGBB2fMaynR
 ZHEnX9+qdlCWNlblLaLgOfhLVPgZ3hlLal0xrWLQt+33tBYKpNdwVfUWAJXuyu5Gd0L250mt4
 riKlL0vdR+9yESXDCOPnUqEroTAQLe1eWtqueogYjHxXxfIz0mXWoZzdfEC8I7c/0ZRQQywFA
 Hg+6le3gsN1mmm4HkMXwlht/wsobD/utim8PdHCWyx8Nt85FaMIOs2FVlVVZPqBAzA92A/Uf3
 IIilmXuK2MlqnJ4IESglsJ9+VfSSeET9RebtAdQg40qwM99g0QcFzPFdKgJ+F4kdWr30w/ie7
 D0QIJlXkTKDHkqWIQm2yvKwnZb1TRfqIfywxr8luw7bZoxgoZzXSPs1La7rv7EhsxU949b5kX
 Fr3gz29xmXJgktWrBZ+isVFe9XgxAsrzsFuJywfoAyAmpkAjpLsV+uz+WY3UTptI8YRGzdBuM
 6rNl4ZOAvqRdFkIuuqYOYO4CT89w+cc+OCxN7OK5a2OFYRftEtRcUyGO7/oVKrlljM5oF+AOo
 gW+Ytww0zmExFazR6EDA4fbMYOMkE5RgE5zuzEOMgeF+xVsGKY7tpxEgFUhRyxnvyp7XG9QEs
 NxydBDDpfgMAzodjLy+6QAGgHVE4jKhUkYlRZ/DZ3JuO6G3ltrxa/6m3RgOUY/vKhGtbU8ZzT
 dhWBGaSH67YRNpQBpIaZxZRlETmLu+yPC6cBmESIItSh6BZECEUwoOKMpEfNXHS4mcIMbFr4D
 g+BA7yfxbf/Lw4Z1HIdmqLGUsW1lqhFkBHI4Lt+fqkoZpzgBYPC0fuE5+urTCcD7EXlRRs6jL
 ne8VlbGyvvHdORwzMBVbCJeCgaX3+vPUD19vELji8qnGLLbpdvHxLC5JOEy72yNhjHeiOY3Y1
 MiNIXt6nLnSvRqqfBy9w422CM6uVbPMekwpPmf+uOW4zPbddkzruR9TXKKajONLGaiQA1SwIQ
 J+AKBuW2D59FN6roeXEA1+F+GklobXy8vLgSJbxemT0cg5ZPNClFNBd87TSrZVhJgNvdZ6aFf
 4STEeqIgRWx3gxU13bENRhlkI6ShjoruJJanuJ1uUH/a+oyHtwc8Z6xbr7sFd0Mj2LvtHM5o8
 foq+8apk9gbiZdS+mo5zTF4hpag726GCehtJRdsH1HMM3ZX90t9FyVjc8ceqmjqLIxCLTfaqN
 /t34Zq/LgjV3BfhTdYDz0zcn7L+zn5lwE7q3tBUfSN1s8sX/rCG1vBes+uaymdxK8sHhFtRYp
 R1d5Jo4lXAr/dIfrW45XMPCjMfz1iWJmWDFBfwL2EZVga1OerDACprKXY74BBaA8OsswWkYNc
 QMIqcFNkMMaDFPzC2CAEKOYgw4uVNoF+/5iaIaKG92FLpx60ZEyGN9k5XfX/bgf+Sso16nZeI
 VC9FAePdr5M0QiH2bLgXmcU/VzrvH4fIgPF5GehR4EvjPoXBuKi/NQ9eJM3URPhd/DLLy4oc8
 oMhhTqO4x06JpnP1lZ3VPw3YotMWOd0BMkikKhFONeSZKTtvYvJ4hY+mhWUZvE+6WdoztKVb9
 mW7esWEa7blEzr6E3PSoSacrrop8E23Ker5FxwXFNOnP/KTrPM/UCK12cUmZVvr8f6JhvqaNJ
 NUm2gjO9QrX95cWuqpcLYTVmnhwwZGiNC4xCvLL/bP2ZSbn/L3kmKqbLwOU5pkoRPwXWLMDRc
 54RcdCez23SBPY7gcvSNuJp17GMl3Qnz4pY0OANqcJYbfWplDXj69OomAxmasa30W5GSG4Xsr
 RtYxMis7torh5UxtGcacXCfyT+AEss4fPyym4x0ZvVLbnmswmdFt8J/ARLVbdWuZO2UjSDJWw
 YmeRNsmfBEKLg7j1h7yOEA1c4C9VdiuMOPgQW43Fj6IUwpJDjAX4qKT78qGzciV2BLmoh8R2k
 RlICDsaZ695rcV8Ub/4Jf8bOkh6LP8T/aMU5/3xYo09QOxViBrHAbTouKSEj8wQ2VBh2lEfng
 5iMUL0ds4LDXpkhw/2C07gCRcNyCEHLVsRXvzsCHKaSQU68D4pz7w4I883aNrL4J4VFDqtOxG
 5SbKpcxhmybcJCA6Tr2N5yFxHTs79VZJ7KunV6e77zyeLSgR36kbturW+G7/rlFsVeq7oSdVW
 FtxFKWFqgVhEHgKoEikMS6597HFJH5I1Cg16o4pXda54GODCB82NBY7Qz0Fvf5fx5cfmTFJrO
 BsHuS8nFcnOUqTK5Z5aEhOut2PCeRvy5NIETabshmHtIu/INL3Y8rza2tVEZIS4y5kaJydebw
 RU3J/1NeV/xsZtEGi1iGLOZXH+6yZUzeuYpRiCAzaAjtorbh47EjVepKTpMEx3hDrTOdyYabF
 RuMI0qRwupne7U6zZ7+B44AzsjGzIUCtPWK6jfKVKcrHLQYOnDelogUKe9cYxGLcn1EEQNO+y
 yj7YqLNXAxChlAMYti1RWIhoxDzZCQGeLWRT3flU7+/dy/ZCJgkf1b9yunF3OhcYJlh8u4h/O
 MEyhO5QNc4tmblOlWg1edBAK4kzTbk57lseSNsdLAP0I3d4/pPTJd/afzMimB7+p5jxcVSMlb
 cX/aKg7W1HXe9j+2PxsLCHyaT3zGysYGb583/GUskmB5hJ/QDj2n1z836dv+YKVFKMse/vpKK
 oP8tWYXYIVZjZe1NxwYpQM7KjC2ghUJGmy8Xqx3mDUdg4ZEVLH/Fxcw+1TjwMm5WIiDTCTqL5
 T8jwDjaKL1aLkTm+gf5BnuHwk/EPzo0dhUVhABJ3cF0LjTLmVXk8NvrurA3QbKcZkWojc4ejl
 1X+DWw39PIR/kyc4TNaO3MqpqOlSQPT4Uq1h4uBEKYwo+e9CEw7tQQEUS7dp4piWpmCYunKeO
 BbhQnW7Ea62J3YuDaL+toUyq6jM+Rem7AjdjNheblXLERLnVFx+yqt7RXFI/uaItSk3U37p8w
 ji+LJx1cWd20eUJH1oBdvIjb09c8ZxnFMHkVRfz3bVCsGCjXpha2YCAVRAtT04jjZTXGZ7JV3
 Tr9OTqIm/uyILi6u13hetJdRAhT0v3W2BDVI+PptaW2Sl/Y0R/zob6AyQtxKvWfmUTr3IJWbK
 ILkGzVAxIJxQEwjHTzqUE1DetGV5D7y7HJ0HSNxWJb0voiUYvfVhB4l+U/2O/7bC9NH2Scuy9
 m2gxA24G3O50gq7n4ry3bNKkuN5IqfeLVrcAqJSoMH6skRUgp2nCYudWzyKV0+1vAnE5RaLJ1
 HgedRCa8zs4NZLg6R2t3JNPzhlY+1rlPeQaxt7I7t402iXzN4FprVvZjnAb/MNyMrVQ4y98wO
 BKeIAw8BVNoj4i7BHkbBnMfMBzN+wAHTBBbGDz9lGtA89b+vm90eOkgosUmdQAkFoxq9c6IvI
 N2hsojA+OZVWwvqiplg3YAiJ5jFLBi25U274UYEL1kA9BPIwy/1yCtgTPODFrVNjGYenGsmIM
 zAbS6BqtbBsOmiK1Nm16Mq+rTn5AtDg4iL0amq/Fn8vBaanwXkG/wz2XLP2x+LndRMYjsaXjK
 sJLBzB9ThnBMnvNCgddTleZecycLDCzztV3elDkyBBhu+hUCHzDRKgMJroSFZrI7uUBEMk/Gt
 chFIg9Ti6f9oXWWNwufLIZUKQxbDdZ+XpH1F3MNaAYxIJxtVC7WKa4c307+MCIQamE3hQGtck
 LXsPenUtBWA6agwkCex31F69ICCf5tF3o/cDXbV3+Skpw/8QpmiEbfSNomgKPN30Ax4f/1AEm
 /6P2nUbZzAlLC0e6I0L56s6eZyQ2RrKFErv2+Nwvydo+Y/4pgSCZE/zi8JnxmrQ9K5Bs1S2QR
 PhZa/JgQzV7ZZemkCLWlbprBoW+KlgXSkv3K1PPJ8TCfxC9OvE12nfbNakb/0yF2H1omhaiGw
 vi0Od7ybQXtEfagclq79/mcx4sE1Qsv0+MPDxl2DjfOAcrp4uea8EwA9fCoPJFp6SLFeZJYj6
 /2XeCOAH7DrmBa6buF6LMRwJFpsbUM97hWbXAg7yYij3LDGN8NeT1wxw4X1Ufpt3hlZaXcsBx
 4VNmlQFHKGqFAyfeYJtvSzDx0WiaMl6/YAshq8lByxF5zSks1zsUycKba5oWkqFmxd7QZHqXg
 Vmc8hLpDpGPsohpNvvX/Hv+A4Vt5QWBwch8hHgQJys6eUn6sDkkjI0O7p0fEFHDejTpb597Go
 wATV/Kl6uwgUgG2PVWg9xbXP4F9miHVVnAyh7KPVyeb7QpfAshpHMEBTXfwr1KVCuKmg6FidF
 Z/78BO0PuJU1MSC59nBMde7XxHzbhbobJ2IIL0exM0Qj102qxQcabwe8PwotdUvRxzxQcINYK
 OQmyVu+0VGU6GY3s40chkJx/sEScaE/5aPx3p+P+icq88x5xJn5Jfgq/GatqqwNPAPez6gYMV
 m/grf/f+q6bdySKI34e1rCauiS9xP2HTdKklXjJJJgkdiXMymVrjSWgujld2P2pPS/VIqQlBO
 OTBTdruI91k7f7GYL88+7xGJHermWiRwXmEbZreymfOajAUI/qv88U74omdiOyxQn/5a6apMr
 m07Y2xISuGUYe/KJztj7WuACSesvDACaImFsO12krTMH1eOMz7TdE+VPsiXPF/9pybx5FT6xw
 n0mRv1/j5OnZJM2K/KG4DIaNvZweABmJEgy4kXgT9LSHkW+d9aKf+52uxn6zzg6br43jnjrKl
 hFHAeTw1OqbqfoOhEZpFrA/em0LgTI68EeikLQ+Jne9W5mPvhsN9JR6JtRqo2IO2Ns+OmzOSa
 /AfhSMhhclCA1gmifVyCFWOTVtfTlNplaTaBiiwrJAhNk0KwqBZsX+F634NnFIYlTqXmrzZWM
 F/iNfFul2Th
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 27 Mar 2026, Johannes Schindelin wrote:

> On Wed, 25 Mar 2026, Takashi Yano wrote:
>=20
> > The reproducer that uses AutoHotKey provided by Johannes:
> > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > uncovered several issues regarding input transfer between nat-
> > pipe and cyg-pipe. Most of the issues happen when non-cygwin
> > shell start cygwin-app. This patch series addresses these issues.
> >=20
> > [...]
>=20
> Thank you for your hard work, and also: Thank you for figuring out a way
> to drop the Backspace handling via WriteConsoleInputW() I objected to.
>=20
> I tested this patch series (which required cherry-picking 699c6892f1
> (Cygwin: pty: Fix nat pipe hand-over when pcon is disabled, 2026-03-03)
> and applying
> https://inbox.sourceware.org/cygwin-patches/20260310085139.113-1-takashi=
.yano@nifty.ne.jp/
> ("Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist")
> before the 7 patches would apply cleanly.
>=20
> I can confirm that the AutoHotKey-based test now finishes.
>=20
> However, I have some concerns about the commit messages, and also about
> some coding patterns (such as introducing an expensive `OpenProcess()`
> into a potentially hot code path).
>=20
> I haven't managed to finish a full review yet, but hope to send out at
> least my finalized feedback for v7 patch 1/7 today, still.

I unexpectedly got some time this afternoon and was able to finish the
review of all 7 patches, with big help of Claude Opus (whenever I had a
"dumb question", it really helped to lean on Opus' quick reading skills).

It's too bad that we cannot "fix this for real", which would be to buffer
the input in a single queue and only deliver it to the consumer on demand,
whether that be a Cygwin or a native process. But there's not really any
way to be notified when a pseudo console's foreground process wants to
consume input. So there is no actual alternative to the current approach:
routing the input preemptively.

For the record, I integrated your v7 patches (with my proposed commit
messages) into https://github.com/git-for-windows/msys2-runtime/pull/124
(which also has an updated AutoHotKey test that now verifies the `cmd.exe`
side of things). The PR build demonstrates the fixes work!

Thank you so much for all your effort to fix these bugs,
Johannes
