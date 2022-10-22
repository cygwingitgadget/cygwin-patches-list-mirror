Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id DDADE3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 05:58:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DDADE3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666418320;
	bh=sbCxBYvvWsfOCObmp5bWQalK8VRzzLNPUwSb2PqmHSg=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=IGX6NCA66XIm37xMcnzlDzSnS3J/s8DJVCSn7bR1dJ2+Or8grnNuAS3nuX/gys8P0
	 SFoo7q5ZXVuGfGlmOgjHEWHDjR9P/JHqN/B192M04ombrKSX2n8uZp9tVcqXYkZDEu
	 vCGE2pvx729PNaQwjY8FxZune+e2Oafr3GKLliUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [127.0.0.1] ([213.196.212.100]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1odQNj3jW4-00QTgI; Sat, 22
 Oct 2022 07:58:39 +0200
Date: Sat, 22 Oct 2022 07:58:37 +0200
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_Cygwin=3A_pty=3A_Fix_=27Bad_addre?= =?US-ASCII?Q?ss=27_error_when_running_=27cmd=2Eexe_/c_dir=27?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
Message-ID: <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZT5unV2sng5fwWQ763dyeVvJ25x9k6oWBCzyrv8MZUutTMzAWv1
 bLfl8E4DVQx+J7D3E91sRao9fGOiTwzYUH9rPR6KxzLe9LtJXBq84Wivfmsn7HNlTgrxJjH
 /7EZj+AwDGu79Hq1FHW4buus826xefGxzKoH+tChhWdcEnuYs2IMWACQFhx4P1LmYvwK5oq
 xlsFkg1dFxzna8LNy14eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Knerituvg8I=:RsH6Tpd1w/bwrZdannrYv6
 HtR0BSFoDKRwZ1aBmIQMWl0rTa1sk+eVOEgCUbBpnkvKXR+93qLtSVKBIuyeOwM0jgAai0LXC
 uDowezV0pcqzuPHYtFw0CTIUtTlzQAZADhEnb0uaa7064Gry3CZHRSETenluREJTumrjSGpv1
 xNkZoO97knPd+jKun5CQu3aMpimuhM/EFxjS4o+sbY4yqJ/7zspxTpjjFmE/Qt81js24hZUcx
 PaaCPHi5qb01TxjJttAdnph5UhV7OuKbkrFIenadXmWI6Sa2FA4qJm/31nQ1E6Z34iDQHnonN
 fRGNAKq+h1rpIZT9Fp4kGl3OMhgSvDyQBTgAr8VJCwrRKrWNGpC+5uexGPZ+heOT6clfxTEnR
 tPe3ZhWOtiV35AgPQbuc/mDlG4suR3vix2VRIJSP0PuoF91xpz8n4BQ6OpFeO+Z52epHbDiMR
 fd3KV1Pn88y5D5TQJlhLtLXPMzjkue2jFlXjUA+eSK9jUJVwQrzvh4cG+/aRibpaVSBLe+0/e
 8MtkWtv+6Bjw7tA/XgizZFrzfpRojafU5vAGsRuOHY2yzKIDtSgYBPjJ0AWKou6VngVV8whzu
 tqNh32oWaxZDgGNxoA9080FNcwDBXf7PhQA+GcM2ukYyFxEJQMH9fd9bzQduLJ4+3eUYIcnGU
 E0TRIAS7b5u1oryg7VA8CwTTYjpiABnRHcOZnwoW0weh0ZLQ//ffZa9jRQG02A63aKEKXj9pw
 rwAWuMJGqO1iuSXNI6r8Faz+oRSgvGf0jvH7pLvwmMr8sDwh4vnGzsEEm0JfcG1Z76ZFsrKXg
 vn9yKwB7dWY6VKqDTzAEUf5G0+Psthx1dX/NsRu+dDhbTx6IjSYBJ4KGutTlT2tzvI+SrOpqO
 EgiHPYSYQnGkg2nOTrbFn9nf2HDqbACrMDJylSGFbcETowzVZ4LZAuw8hjGSfSJJYkZ9bhbAx
 OWZ69GnxpHb3cqPYz1zQsh9IZEdL6r5Voc51R/yYoqthw+ksEj3V9kzwN5kkMoS7TNKAyY0Az
 QzGxPKuNiJwspXEe2IPw2EzS7axAVHFi+5WvK5L9/89lA6jNngtc0/YAiejx3AQbt10xz7hTK
 jUfVzQXOxor5IKgFK39TlGrgW+ZOtnlejr/GrKWGwf1ptxGYNyd2trKZ6lqrZPi/6D21jbBYo
 vLksaCe4K5/RlU6EB4D78K0nqu3yDMpCQNI4FH7mIAgTFHoh05rc29nMqZO7rDMuyQdE0hsJ6
 W8woT2IGoAYAkmNbyDDPtuyZviFKOzBPInYQD4CAEPLSPr4glPO0CpWSW8IY5qj4uNGGTVTm8
 +gOtyKWY21xlm8gOl9HP5+FgXkEcB4Y79JMjDSOtuhhTCzRtDVwZace9MQ4cRhHAZV5QmfqZI
 I4+2ynhSgRnPed6zuPMigGkZ/lp7xNhCwrdwZHxje5dxe74CHOTZqCZ2GFVzJK/9McQckBTR2
 GR+7Eoy34SZ6qFPxiTWl13/FSgA7kRr6HVJpcGyFLCTAHDfFG7xtAKdf0o/rp1E0PwM8Ok/Z7
 kTtmyW8TMf6HLybcOcM+FV9XMp1auFJHiJQlFSxHwcgu5C8z8jpvhkgqnv6fOPq9akw==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On October 22, 2022 7:34:20 AM GMT+02:00, Takashi Yano <takashi=2Eyano@nift=
y=2Ene=2Ejp> wrote:
>- If the command executed is 'cmd=2Eexe /c [=2E=2E=2E]', runpath in spawn=
=2Ecc
>  will be NULL=2E In this case, is_console_app(runpath) check causes
>  access violation=2E This case also the command executed is obviously
>  console app=2E, therefore, treat it as console app to fix this issue=2E
>
>  Addresses: https://github=2Ecom/msys2/msys2-runtime/issues/108
>---
> winsup/cygwin/spawn=2Ecc | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/winsup/cygwin/spawn=2Ecc b/winsup/cygwin/spawn=2Ecc
>index 5aa52ab1e=2E=2E4fc842a2b 100644
>--- a/winsup/cygwin/spawn=2Ecc
>+++ b/winsup/cygwin/spawn=2Ecc
>@@ -215,6 +215,8 @@ handle (int fd, bool writing)
> static bool
> is_console_app (WCHAR *filename)
> {
>+  if (filename =3D=3D NULL)
>+    return true; /* The command executed is command=2Ecom or cmd=2Eexe=
=2E */
>   HANDLE h;
>   const int id_offset =3D 92;
>   h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,

The commit message of the original patch was substantially clearer and off=
ered a thorough analysis=2E This patch lost that=2E
