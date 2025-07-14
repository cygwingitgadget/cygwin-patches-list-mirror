Return-Path: <SRS0=V7dz=Z3=gmail.com=reiter.christoph@sourceware.org>
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by sourceware.org (Postfix) with ESMTPS id 2854D3858D37
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 06:25:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2854D3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2854D3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::102c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752474310; cv=none;
	b=axVDofGXPibEO/Uv7F+QyQ6ffmiTIcL6dJ0QexTGcdGoYa8mH2eEAmW6tPcuweS93h/rVdZ9LiZWL4SNbYmPhJFiUwcO9D2IJeaZrX7pME/YY7k3szzE11Q6bIoXJqoPXB7wTsh3BdHDSFT+QCdacbZf2p+eFNOfyyBmBPqJWeI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752474310; c=relaxed/simple;
	bh=1yiK2SoTGCQLGGOX65C+kYP2yd+ck68u98KkE9xolNE=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=bBAhByfuK8RRRX70hOjbRVuesGxHUs0B80RPrnWtJ3k00u/+IKsNGtIgdaY5rrWxSUO+nmqzmaB6NEoRjz9yY+VKP9QV8xB/3fp/yegY5G1YE4qb889caSSYJXxpX7EoA84GkI1/KbCZpTTdzC9UkM2lrYp/7BwSVkiuCt3BurI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2854D3858D37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X9K5UP7R
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso3188097a91.1
        for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752474309; x=1753079109; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yiK2SoTGCQLGGOX65C+kYP2yd+ck68u98KkE9xolNE=;
        b=X9K5UP7RX0GTt34ZspCeDgKYGmU+xRwSp0mA/OjEaAZYYUP7fBc3lfUB8RNfefTp2C
         nf/romzoP7sFTRQ/jbZXFRKf0bPTSDHUhPtaHmKV4ksoIujmrmXxOYnxonTifFFZy9Op
         j0DK6PNiLWKj+TO0nujal6lSyiqyg5KlxVmAY4fXDQ5xRVTymQvVRSt4+qPgebIav6K4
         f0eiGpNYK7PlD1wEcfOwzgUYcZ4NpV3pvWj/bBIXRra/Z6ZpoVLbUMm4q7lk9dS060Ri
         BkFY7B1NIPgIK7TAqxZrI97tdT4lLo3v2Yv1I3FHvpWrQkZDI++YKT1OgtKMY3jNT3lf
         FbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752474309; x=1753079109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yiK2SoTGCQLGGOX65C+kYP2yd+ck68u98KkE9xolNE=;
        b=Pij7O1rvO20yn0XiCHTmQ79IW6Zh9oKXj7bSmw0A8r4DMxil4D9MzG9IA4dUY/X62a
         Xp94NWRecRb64zQfveK+9CHpVBx3XwPaTfkVvunJOMyiaMiLa3bUoEodc3U9KGrpBZXo
         +rKwMqsg/MAH+qurLdw0yhjaSllfxPo/VtVlpaaaRBWQJXjxDQFu0MbGuL3ra0qV742Y
         yArtvrLqAmiPEZjzxgIM61tNUMrICAitHfY6qpAFN5eWdmMUlprQ0a9wxcnALXXP8E/7
         MbIs6PvtWBvTONu5DqU8IHcXJtTWgbym4k/ae1IuqD8UrfD6Hd2OkAE0Bu3GULaC4u/l
         FBzA==
X-Gm-Message-State: AOJu0Yy9+xXEJKb/cZgUEU23Ocfd0YSJkc7RBhQ2842CoIuJcY2Swcip
	IKsa8lUFplfYOr4/D9u0eeWi3fiUT61Z8lPo5YwSW9aUd5kZDR4k4Wwl4OdCXVm9aw67INYiL+7
	qY7QEBZewns7OaKso2cp1AKwEr+CBY+QhGA==
X-Gm-Gg: ASbGncvy6UfSbTFcxy1l7tVWqml0GVCJUrC5lrGmsX05MMUkWckkDQebUvF2I3jz9xw
	RCeOsAOg1po1AHiw6CtQKouScBuUCjwuVtZU37Hy4vaUw8cySrjrvsOa3CEB3GeSQUA7ttT4URw
	6NSVhatHpM9mqg8yPJNrSKzoXjBoTHa5/1hju7xCzvH2d0XS+SMsVMg5XKLbPRkPkMhYWDWFO8i
	CFUu2kfZUfCKGMEMQ==
X-Google-Smtp-Source: AGHT+IEIcNc163wVCU8OEIgTTJgNmLc5VINHEMd0PoIIXqvRvZvvFb5J5Xk+s+G9PG56v2i7iZ2puHydffwnk3Mqv00=
X-Received: by 2002:a17:90b:580b:b0:312:26d9:d5a7 with SMTP id
 98e67ed59e1d1-31c4cd62fa1mr18487930a91.20.1752474309075; Sun, 13 Jul 2025
 23:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250714021442.1828-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20250714021442.1828-1-takashi.yano@nifty.ne.jp>
From: Christoph Reiter <reiter.christoph@gmail.com>
Date: Mon, 14 Jul 2025 08:24:57 +0200
X-Gm-Features: Ac12FXwmiME2y4h8dzbzMxduDRjfqw44pWFof-V52pmgh0uIYyw2vbPcCRk9hTo
Message-ID: <CAE6_+UddWgKvsqRzGMz6i5nFxeCzw7m+D5CPyqc9uo=4UHYP4Q@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: pty: TCIFLUSH also clears readahead buffer in the master
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks! I can confirm that this fixes things.
