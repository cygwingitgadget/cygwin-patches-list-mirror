Return-Path: <SRS0=st34=CW=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id E21A2385771F
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 15:45:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E21A2385771F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688485536; x=1689090336; i=johannes.schindelin@gmx.de;
 bh=oeGBawcCqjAA64CgvSFGPwzZJjuDdRmhrJmqcuX0H+w=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=EmxoHMmh+63lnXKSJDgLJcRrO/2rn+9Nk4OnJKWCyU1c+zBY0bCcXIcGKLd7Obw9D8DZe0/
 gx/UyP9d8hfs3ciaobu4n8pmVmYZPhvD0tfGD3sdK6SrQRbETVmmuexTmS1GoikYsRu+8tAar
 KvSGeNuFyb7qPHqSsYpeHRWEEcYyrLbCuiQH8VxMkItEzUTT06qLoWqrZRHiQ1dbRfWiH6vaL
 nr0lp7/YMOoF6xrdtLEZvZtH0lzOtq27FJTqX1RMRmh7CJ+Zgz1nfmEJQImwWhXmZUkwpRbEw
 TLxSpskYue+E9yLYi18Djt+T9d6L582lnX00yh/Yi4SEEwP/Z8Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1pyUVx2oKr-00sKPl for
 <cygwin-patches@cygwin.com>; Tue, 04 Jul 2023 17:45:36 +0200
Date: Tue, 4 Jul 2023 17:45:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
In-Reply-To: <ZKKo8Ez3nIf7klxz@calimero.vinschen.de>
Message-ID: <d983003d-b8e6-e312-2197-499cc7f29306@gmx.de>
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de> <ZKKo8Ez3nIf7klxz@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DNvXVTLWLygVSBt+5QLUS8iNW/y2zwxjV3KyVZwl45uII5S1KMQ
 +MepYj3xW/bQ8yCAMfDCilEfp53Udx2z61maBMykbB8J4WSNLe0ill6XX/4PRKzX7IS7QMh
 yHdDrSS5BOiKFl252+c0IFBTFu3HjQVlHkMEDRX+RkXE6/pBQ8WgP8HQ77JptFupOdSa/kf
 yZsvcxMjCRCEXGVh1924Q==
UI-OutboundReport: notjunk:1;M01:P0:tHaN9vXUvBI=;wBH6GgUAh6UpTQNHtEwpjo46zZQ
 bMx3pJvCXoUAgwsUiAhF9N24RnNFxJ1ZHsPMrBPUnMtVcfUcmy301opLJ2QF40srQvbKSmSO4
 aYJh7vMLyPKl8EInonuDSYjoU9PrXlTCL48KYcKbnx+w8LlJDflmwEOfTc/wEi5LTIVgMH9/P
 5Hc4seSQ8iNlICjFZBC3r6I4L9i39N9hd9Wuy0VYN3+dQ5o2jPXlyXHF/JFC49YLz0+J780m4
 0vunXsJkbmTBhU90d/CHgtcd/8ycFa9pzEiFHTdJ5DR6JqnBMh1Nl1Mm3VpUNXiyfjFFxoxAk
 OEPuxnANF8Tz896nTxI75Z7Poj9LhL+EOK0AH6M5spC7wI9tTHehR8c3yriU0+z4klZVVOc/f
 63Mg7obscNBakhIq5QJYUrzztRXg7Gzd02A8+qMrLrDjVy70BlfY7tHDgVy8aXBWCMJ1CiqLy
 aG9rpLJCjIM4AaMcCqaQHo6pFKYFrrh3T0bm/V6EXBRGaXuS6jfadmDuV8tGIuJJ1FiR4hsbl
 4GSJCJIUQ1MOhHiLUDqWh1wFHg04TphbTtLkeWjD6delMF4tHQw/k+LjyQlWghlzBlyyutPEo
 bkTJqbJ/bImsvTdT9y5KWguyzy+/50FFvT3BU+c+WL0n4KXxXiGs4LTK5+hnrsd1QnRP9agwZ
 OGbzp9W4M8VrOvuDV9/00kMMaMuXfamCPQ16M2U2T8/TwSfUVWAjwJJ9qbPvF7KSkuEKjwN7V
 mSbH+2qtN8dMp3L78tEY+cZOK2qMhMki/dx7X8ZXz0FBj3hMtL7KaWUpFfR/RFVItIG4pdT2w
 IqyxMc+F7jW73ebzl6VP9tQHp49GG5ZtFl+shEBnXKyVng3u9Rnc8Fszo8kU+rxqAK6tzuAXN
 QaacFwJ6bw8awxMs6gYadsO60vB3478a1hyH4ZzCs4SfBAxPR3btDB29N7t397TeMzKdFMco3
 7HdZpmaXWnNjWMCEgeS4Q7kREuM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Jul 2023, Corinna Vinschen wrote:

> Hi Johannes,
>
> On Jun 27 22:51, Johannes Schindelin wrote:
> > In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
> > the code of `readlinkat()` was adjusted to align the `errno` with Linu=
x'
> > behavior.
> >
> > To accommodate for that, the `gen_full_path_at()` function was modifie=
d,
> > and the caller was adjusted to expect either `ENOENT` or `ENOTDIR` in
> > the case of an empty `pathname`, not just `ENOENT`.
> >
> > However, `readlinkat()` is not the only caller of that helper function=
.
> >
> > And while most other callers simply propagate the `errno` produced by
> > `gen_full_path_at()`, two other callers also want to special-case empt=
y
> > `pathnames` much like `readlinkat()`: `fchmodat()` and `fstatat()`.
> >
> > Therefore, these two callers need to be changed to expect `ENOTDIR` in
> > case of an empty `pathname`, too.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Looks like a good catch. Can you please also add a "Fixes:" tag line
> and move the tar error description up into the commit message?

Done.

BTW a colleague and I were wondering whether we really want to set
`errno=3DENOTDIR` in `gen_full_path_at()` for empty paths when
`AT_EMPTY_PATH` is _not_ specified. As far as we can tell, Linux sets
`errno=3DENOENT` in that instance.

Ciao,
Johannes
