Return-Path: <SRS0=IJIq=HA=gmail.com=thirumalaicse2020@sourceware.org>
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com [IPv6:2607:f8b0:4864:41::10])
	by sourceware.org (Postfix) with ESMTPS id 1B6244BB8F77
	for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2026 04:52:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B6244BB8F77
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B6244BB8F77
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2607:f8b0:4864:41::10
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1788843139; cv=pass;
	b=xMUpDpBpRalUh5vTZ7f8CyyCsbdczqBOdfehcm+kd6nNXA7aanYDQfxSWk8gSXPdbiukJShDqAr3+sK4idJ79eyG+icoGEWEo2hCQZ+S7+bEC5vie07hJccfdfFVowKxCo2x7wwx89WDuC6hR1xeiY79jSBqlNgxxL8S0k7u2jM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788843139; c=relaxed/simple;
	bh=u6IYY04zlJ5dwRbYTzpf3W7PmR6BF63Rj8g5PK6GxQo=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=HEUM8wPI178+x61/fqc+M9/ygRQQlm16xSk34FBaABWEWpSksvShhOtb/DwotuIOFHPoQccQV759L6nu1rh44QKZ527i/ftDpcS1G9vx8lTIVQy7OsPAIbuPtPvmNzJIBJj6ahF+pXymGbNUd9fW4VwP0fVnkyA9oZdV4leBRfw=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZb6bQos
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B6244BB8F77
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZb6bQos
Received: by mail-yx2-x10.google.com with SMTP id 956f58d0204a3-66fb7ba702eso560760d50.0
        for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2026 21:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788843138; cv=none;
        d=google.com; s=arc-20260327;
        b=NJ5cEJeVQadAdt034s9T/RzwunFkcear0UE/xLghq6UhyhzgHLsifc+xEwVKKpy6MZ
         52aRes1I0XXog+M9NAMvFO17VdaZWgLIYDPmOOFkH1pwqKnKvDEEo5G6eaaygRofOGB0
         6gHahNTYfApPOtbLmUuxHkAQ2aBULXpGeyfWr2zrODxD1yxFS8C0r0J+5dw31QlkO8WC
         C83TAwOrR/vQyDjba6u1JkhsnwKC3Tyx/2dGBWynjKkJaYglaFOsIi/JMVnDPOEWreWc
         iWoemSzZRKZIZ/xdzt6Y8/V4r19ljItSm0cjV0lZ78vxa/M8CA2AWI/rSRk3pq6qAOSA
         TDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u6IYY04zlJ5dwRbYTzpf3W7PmR6BF63Rj8g5PK6GxQo=;
        fh=dnYhfB7TbtRg6DZLkE4O4OTHCWpcXl9Jdr7b8wFufac=;
        b=QY9smswuXfsdcVLi3OC354yOrhivnPUsRAv8XMzqXvfgUEWR6qRlvwss8/Al5JkIuI
         roY7ZFe4NNGCuGTx+HdNfdox0/NC1+jiQkdBi7iRTPeAx8Kz5Vblk0Lz9AxvhGoKFlZq
         RljqErtKejsJPZXC+FJMv5wlo1bNrYHOzVV6I29Ne14beQ9VQ1vpJkablZkRdswR2idk
         o2yk0IOcdc1F9Gt0nZQk7dGA7lr6K73gCsQ1+xutuK2JDLVuwf97/hz+bGtQIgaSqZdK
         oaKTFHLBLvUwK8rduqo9mC/qeAHD36vtbgpmmtuiiWKsPBIvMEiTIsWhbrBfA5MsFLPP
         WZFA==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788843138; x=1789447938; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6IYY04zlJ5dwRbYTzpf3W7PmR6BF63Rj8g5PK6GxQo=;
        b=RZb6bQosLuj+ofH3cd/IeEwxrp2ebAFmELC86EYSGdA68/CB9pKgrH6CxIhGlZboCC
         JSxTNtJPd5sZzneZRcQpcNfxudMFlYcn1IPODPnc/g5SH/ML7VHLltXTKky1n7tqtQJD
         k2QPIEr7S7GMFtVUKEvUwJiwT9Tqi8no80LvmF9ZfbEbS1p3Q9obel0GbmdPSyu9NnGw
         DZbQZVqJaGxj/b00KJRzWc89b61+CkyI3y58YVWfJw7LUtcOvH6cTfVLOTgdQ6DuMiTX
         2aBbyNg2Ufd9ci21/r3uohhyySi9nzWSkldXj3cYcMSzD/8pfJbu00jwEn0qYoSI/b9Z
         8d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788843138; x=1789447938;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6IYY04zlJ5dwRbYTzpf3W7PmR6BF63Rj8g5PK6GxQo=;
        b=Hmvu/Xbolga7sKUwo5PJlRNmmZK7VqTqs9pwbp8xDHQxUPNxV2idyHjMw65nlMNmWo
         SeuP2dT5WFUTLc5vtl4hZmwZjtgK0jcbZxGH0p8K0Q/aJLan/GS9FLzxFUou9JY5KTx0
         D3QR8v9dObzGkCVUY32An6Uk33Yw8Nw+QV5KjQmCWsrPvCHkGXw/aFeiTYLJEM5pQA6X
         VXoo4Uo0MhqzkFlzLquOxx6kZ9yfOOSy0B/I4WkqNZuFkUw9ps7w8CI3w2/HXvRWNZG/
         R6JHNAMvozV129RzhWbb/FHEIhLbJi9hu1EwoMOwsfkVafdAQIOjbKrMeRlUFigZPoal
         pgpw==
X-Gm-Message-State: AFuF++nJp5jgS67OR8HETkqHLHvFIBFxdekREPbwB++whYGd6R1miDaP
	e5o+TwbJ5aEXl5Q8G0zhGegHxSa7bfGbub9nIGYIhjJ18qoeqjR4ntRFZPS1TCWY5BCp3BUYNtj
	W5yOc/tfOlAoXgl7wlfbyyIexRvWN8l2amA==
X-Gm-Gg: AYBFou259bHYLi/0wYiTuHiW4fZEVb4avVw0k81WuJ3qnAjP14FdYWE7/BwW75g6Rsn
	UWtGJljnSPSy3Ru+CkNOBzlR7u7tw17VTp8MuVXVJxZ/athpCtCNmrq+BzvW3PX2e9cuUTgSQLg
	655BurhTlI7Y6rV+B5WQ/tIqV3uYJ6lvTzIZMCEc1e0ZDwAUwJy9XZ+gmdbpmz1cEKP//l/oqyl
	7LjvXvPl5YLKKi8AEg2qJeFiqIDkzlHyQZf/CHhuCyuBshksjQELHBWeIdgqbxfiQGeCGeL/+sk
	uZ3iL2ZAJ/k5/l7c/k1W0cEqeDd0czlbgAhXSWPijzjXkWNLXWGF2vWq5Y9vdjlQ7vZFI/zI4S4
	5kxNTnhEr29SmzCycU7DP+0fp7vTux6ue
X-Received: by 2002:a05:690c:3582:b0:870:48aa:472e with SMTP id
 00721157ae682-87171651665mr100539147b3.0.1788843138433; Mon, 07 Sep 2026
 21:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <MA0P287MB3082786039509EE4071456959F372@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB3082786039509EE4071456959F372@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
From: Thirumalai Nagalingam <thirumalaicse2020@gmail.com>
Date: Tue, 8 Sep 2026 10:22:16 +0530
X-Gm-Features: AcwNN1U6f4FeGz3QA-FXrjEsVBvI9aevZGhQOl9CFNZLDRDWdKX7DGi2G8tFbHI
Message-ID: <CADiGZiHEUYJ-+Acp4sGLFM3h-ggN_12ivDjCXAF6OcpvDPy0Cw@mail.gmail.com>
Subject: [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS initialization
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: multipart/alternative; boundary="000000000000d347af065af17f35"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--000000000000d347af065af17f35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

I saw your email regarding [PATCH] Cygwin: gendef: add_sigfe_maybe for TLS
initialization on the mailing list.

I realized that I had missed sharing the earlier context with everyone. To
keep the mailing list informed, I'm forwarding below the email I sent to
Corinna on April 28, 2026, while transitioning out of my previous role.

Adding it here for reference.

Thanks for your guidance & support always.

Thanks,
Thirumalai Nagalingam



On Tue, 28 Apr, 2026, 3:54=E2=80=AFpm Thirumalai Nagalingam, <
thirumalai.nagalingam@multicorewareinc.com> wrote:

> Hi Corinna,
>
>
>
> quick heads-up that I=E2=80=99ll be moving on from my current role so my =
colleague
> Chandru [chandru.kumaresan@multicorewareinc.com] from our team will be
> taking over and will follow up on ongoing discussions and any pending
> queries.
>
>
>
> Also, a few pieces of our extended work are nearing completion and
> currently under internal review. These include patches around aarch64
> support (autoload stubs, SSP enablement, exceptions.cc [make-context]) and
> an initial CPU ID implementation.
>
> Patches will be sent upstream once it is ready.
>
>
>
> Thanks for the support so far :)
>
>
>
> Thanks & regards
>
> Thirumalai Nagalingam
>

--000000000000d347af065af17f35--
