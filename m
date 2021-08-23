Return-Path: <schn27@gmail.com>
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by sourceware.org (Postfix) with ESMTPS id 74B99385842C
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 15:48:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 74B99385842C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-x535.google.com with SMTP id s11so17037556pgr.11
 for <cygwin-patches@cygwin.com>; Mon, 23 Aug 2021 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=XdbEKqOIklCGPEf7k40BXAnWsnyC+OtC5Zm0tSuWKbs=;
 b=MVWXLnlUsay6SC6EQw1q5Oj6YDRsi1EvDLdr1ZLOVY3+fYV1KluvbeNVYR/XBjPdhv
 y49oTjhuI5R7PJ05HZ8JhS7hYQ6IprB3SbUxgN8ZZKLKkDTLZYrzeLRk4PFI+EL2wvJj
 4RysuJ09fuL+qcnFqF4deWJro9ka1lT2QmH9QAylrqgUPtQr7vXgEOuqjbfoi3Y4sk/a
 +2vdsSvqkDPP9XdJucO0WJzAwMNm0BSYmOc4PFn7PmPxHbS+6SBj6JB6fVmuW1xFkdSb
 CAPY3F5kHohq8dhKs24wKtQ08To8hZuwStd0JkQUygEawDjjW+rlAq406ijHuS3VQpDZ
 RmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=XdbEKqOIklCGPEf7k40BXAnWsnyC+OtC5Zm0tSuWKbs=;
 b=O3Te1a9yh6oupR9eS17rLTPqS5RDTXJj5sjJ7rR2igOhoccigpVe5jlbiuBo+IO67S
 nxztARPFvOVUkc7nlL9VwI8EXt28kXKcw4HPrlwu2FY7iWJiaRbzGaSAwZuIRIKkE0j9
 1Esp04rt4SSNBYFGhOx/VJCs0Y9nAHf3ZbcyK7Ddf8pHEOcz74SsoFCjQVN+6zIlSFf2
 70MGB1f9pBIZWEsZdYb8Q+hNDW9Fj44Ua+RWKhzfjicWAJ4HzjZLfxpNEqipCYCQt5C0
 1hf8/yhK/6iceBjHU8neS2NQjh/1orS7iky7Ae2LGRI7SOmV5P4hUi4W/yQ2CdWJAIZ6
 Gfpw==
X-Gm-Message-State: AOAM532BYtxNTKCCToQAq3NnpjIP5UznPCMHLs/FuGVgeYv2F9DGvJrf
 hU/JMdsPqVlBydmCC1YXqvjryvePAQp8ZIUKmOXC2hLM/VcqYQ==
X-Google-Smtp-Source: ABdhPJxr1dGUzDeXE/EG9AC94ZX67xGa13V56OotgF7mX1QWtDxGiVOBGvIoBfLH9DImow4Iiih116YbwGk3CZObA2o=
X-Received: by 2002:a62:78c1:0:b0:3e2:bdc:6952 with SMTP id
 t184-20020a6278c1000000b003e20bdc6952mr33839517pfc.45.1629733712255; Mon, 23
 Aug 2021 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210823142748.1012-1-schn27@gmail.com>
 <YSO4hmZcdL/5w44q@calimero.vinschen.de>
In-Reply-To: <YSO4hmZcdL/5w44q@calimero.vinschen.de>
From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?=
 <schn27@gmail.com>
Date: Mon, 23 Aug 2021 18:48:21 +0300
Message-ID: <CAGdYWrY=tydw+Bu_dYVef_enUh-_ndBC4kQGUgfL=D6AZuqb+Q@mail.gmail.com>
Subject: Re: [PATCH] fix race condition in List_insert
To: cygwin-patches@cygwin.com, Aleksandr Malikov <schn27@gmail.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, HTML_MESSAGE, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 23 Aug 2021 15:48:44 -0000

https://gist.github.com/schn27/23b47563b429aaaad5ac315d05a43a11

The test is failed if "Thread #X timeout" is printed and -1 returned. This
happens on my laptop in about several minutes.
The test is passed if it runs infinitely.


=D0=BF=D0=BD, 23 =D0=B0=D0=B2=D0=B3. 2021 =D0=B3. =D0=B2 18:02, Corinna Vin=
schen <corinna-cygwin@cygwin.com>:

> Hi Aleksandr,
>
>
> thanks for the patch.
>
> On Aug 23 17:27, Aleksandr Malikov wrote:
> > From: Aleksand Malikov <schn27@gmail.com>
> >
> > Revert mx parameter and mutex lock while operating the list.
> > Mutex was removed with 94d24160 informing that:
> > 'Use InterlockedCompareExchangePointer to ensure race safeness
> > without using a mutex.'
> >
> > But it does not.
> >
> > Calling pthread_mutex_init and pthread_mutex_destroy from two or
> > more threads occasionally leads to hang in pthread_mutex_destroy.
>
> Do you have a simple testcase in plain C, by any chance?
>
> > To not change the behaviour of other cases where List_insert was called=
,
> > List_insert_nolock is added.
>
> LGTM.  Can you please provide a copyright waiver per
> https://cygwin.com/contrib.html.  See the winsup/CONTRIBUTORS file.
>
>
> Thanks,
> Corinna
>
