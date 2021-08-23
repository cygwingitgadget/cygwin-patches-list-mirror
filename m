Return-Path: <schn27@gmail.com>
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by sourceware.org (Postfix) with ESMTPS id E9181385781C
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 19:05:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E9181385781C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x529.google.com with SMTP id 17so17510481pgp.4
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=IGSYOyw3bk+7nxSEQgyYiEdh8ORllN3RyD/34eNrMrE=;
 b=d8M02wAJA9Ea1A4QrNxuimO/c+sekXLEpZThKLTlYwwDoRNi0BV6y9fVyKTcwEGhQ2
 gzNc4/GC28pkGT8UfvHdxDyFecH/+63rY3/5WZ/T5PEiGRxLHH7/7MD7gTmReoLZGQT1
 +3C1n05U1y8XYw95cP1mKfcC+4FYzOf1efoznon6nY5qWi32SLuiWhtn/FvR8/mBadLx
 OFe1B1pKgfNgq/HFaYPuz7Fj3ZNOWhvjCyZyN6+/VX0ouGTsNL8yAkSaYONY2UGOVJ/q
 55zHPJxb0ebUPlNHej72otPF7RNyUcH6phf/hDKOuEbzkwG8BzaMr9Ts46JHfRuQVZ6/
 4nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=IGSYOyw3bk+7nxSEQgyYiEdh8ORllN3RyD/34eNrMrE=;
 b=E0gp6U/Lp9M9Eygv1DO8dUITeaHmekYNjddMdtVNMKRwR9R/v+3kW4ArhqwVFI7G1p
 vKMYE/1eR1m2mcb7+vR0GmIJ8VY4V939Yuhe5NKNH4+W3tYEI6nTnhQ2tK+mvMKfY9w+
 rKSqjvkHzdLRTB2g7gURZmBByB3GUTDBbDdRqNPSVy5l8hfji0JzXxUWypVaxJEzemU/
 6ndY29Y5rXHhbk91SEXZaF1k4MeywEij+EG2TOKgk6aPy5UdA8qundTXZvdclYhIEudk
 LtGjh5u52yv6JPrC/L1EkreQGkkeqQSrZWS0jLEYlWx6jfLNHXXkM/vgyQywjjl/3VgD
 RSHg==
X-Gm-Message-State: AOAM5301btv0iFr3LLjaZZ3BcgGmLa1onLu9Nbwcg224PsYYqyowhAAk
 ZFahyopkuEGgTjRqq7hBu13F0H4bUDJlXs6ZW5EwgiGROaxBfw==
X-Google-Smtp-Source: ABdhPJyM1mb3nWi+azfAYtqIvh/9t/FrkX0WTlcxKZhrn7CyQhAcfSXttyTiwyLQXU6jPvaPGKEinYjyneRbN8nS5tk=
X-Received: by 2002:a62:7890:0:b0:3ea:ee67:d99d with SMTP id
 t138-20020a627890000000b003eaee67d99dmr18082068pfc.29.1629745531852; Mon, 23
 Aug 2021 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210823142748.1012-1-schn27@gmail.com>
 <YSO4hmZcdL/5w44q@calimero.vinschen.de>
 <CAGdYWrY=tydw+Bu_dYVef_enUh-_ndBC4kQGUgfL=D6AZuqb+Q@mail.gmail.com>
 <YSPkOY8WbIppas+R@calimero.vinschen.de>
In-Reply-To: <YSPkOY8WbIppas+R@calimero.vinschen.de>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?=
 <schn27@gmail.com>
Date: Mon, 23 Aug 2021 22:05:20 +0300
Message-ID: <CAGdYWra=w_t=5sDTRmPLswmp7dgAYV+U+yfgEdjEbc=e3WGtdA@mail.gmail.com>
Subject: Re: [PATCH] fix race condition in List_insert
To: cygwin-patches@cygwin.com, 
 =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?= <schn27@gmail.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF,
 FREEMAIL_ENVFROM_END_DIGIT, FREEMAIL_FROM, HTML_MESSAGE, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 23 Aug 2021 19:05:43 -0000

I'm completely new to all this BSD-2 stuff etc... What exactly should I do
to 'provide my BSD-2 waiver'?
This patch is licenced under 2-clause BSD.
Is it enough?

=D0=BF=D0=BD, 23 =D0=B0=D0=B2=D0=B3. 2021 =D0=B3. =D0=B2 21:08, Corinna Vin=
schen <corinna-cygwin@cygwin.com>:

> Hi =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80,
>
> On Aug 23 18:48, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =
=D0=9C=D0=B0=D0=BB=D0=B8=D0=BA=D0=BE=D0=B2 wrote:
> > https://gist.github.com/schn27/23b47563b429aaaad5ac315d05a43a11
> >
> > The test is failed if "Thread #X timeout" is printed and -1 returned.
> This
> > happens on my laptop in about several minutes.
> > The test is passed if it runs infinitely.
>
> Yup, that shows the problem nicely.
>
> > > LGTM.  Can you please provide a copyright waiver per
> > > https://cygwin.com/contrib.html.  See the winsup/CONTRIBUTORS file.
>
> Just provide your BSD-2 waiver and I'll push your patch.
>
>
> Thanks,
> Corinna
>
