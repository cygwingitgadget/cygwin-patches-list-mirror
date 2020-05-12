Return-Path: <david.macek.0@gmail.com>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by sourceware.org (Postfix) with ESMTPS id B9C32386F80F
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 20:57:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B9C32386F80F
Received: by mail-oi1-x242.google.com with SMTP id b18so19508243oic.6
 for <cygwin-patches@cygwin.com>; Tue, 12 May 2020 13:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=mGXciPqBlqkfZJLw+8wXStDvn+rrOvztCdC6FMKQpiQ=;
 b=T96al18OazT/V/+9J6eKELp3QXC1aM5eJA4K/ECKwuxRAf02h5s+KcDS4+b5bPBQKj
 TiA+8mnTjeS/HQJw+NW8SoNGysNGFSLIQoURjqO3X1D9/78PFojKSLUzt1E7cGSCaUwJ
 0ZG+Wcd8fUmKguQBCwhQsxWeiFMvh50JhW9r/uq30/j9bHfjtvsQtmcqXyv+P80aZDP3
 JUdlKmEaifW+TRnCCRepdU9nqcQaTQ27c8Wj5I4ijrzaQv2hBF8BmXIgpVBRyMcIZ2Wr
 2fKQM+jpY/lf/xP7tP6PlQIFWYqiIMuMiKgofreZdSzUC3uCpaaf4I3lVw5NYSb1mWlt
 uiYQ==
X-Gm-Message-State: AGi0PuZD0Hh94mZzOPoHBA/3DEicR+QgyJVGiy4rWQkUUeF0Q3mfiQPu
 5frYmGOmdtyhjl+dFodAXKVVbRkhCEV7bWYMeEPliBR9rP0=
X-Google-Smtp-Source: APiQypJyUe5AI66dsN41eOiTXdY6VAHvLF6QXeQFsTTU+mwenX3fpPrU3sEa5ewQuk/LK5wFmuSwy7kDtpjKj7CUYsw=
X-Received: by 2002:a54:4e09:: with SMTP id a9mr15961174oiy.43.1589317076924; 
 Tue, 12 May 2020 13:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200512224910.0000040e@gmail.com>
In-Reply-To: <20200512224910.0000040e@gmail.com>
From: David Macek <david.macek.0@gmail.com>
Date: Tue, 12 May 2020 22:57:45 +0200
Message-ID: <CAH2Hv8KL6N2wWCvr+P3DbYvywpOvgFnUye8a8OT0XsiwSq5Fgw@mail.gmail.com>
Subject: Re: [PATCH] cygwin: doc: Add keywords for ACE order issues
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 12 May 2020 20:58:00 -0000

> +warning says "The permissions on ... are incorrectly orderer, which may

Oof. Please fix "orderer" to "ordered" if accepted.

-- 
David Macek
