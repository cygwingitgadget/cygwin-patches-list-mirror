Return-Path: <kasper93@gmail.com>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 by sourceware.org (Postfix) with ESMTPS id D3110386F44C
 for <cygwin-patches@cygwin.com>; Sun, 17 May 2020 23:21:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D3110386F44C
Received: by mail-lf1-x142.google.com with SMTP id c21so6430513lfb.3
 for <cygwin-patches@cygwin.com>; Sun, 17 May 2020 16:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=QYN4hSfOgkDdPRCpVIVfNl52X8yBSgZXbxwtNwQKt6s=;
 b=dn9ot63XaOCygqhlHNHgqgE5F9C+F9Wf9ucYspuPKYeHphQBoyySGSZTybq6JNN5Zj
 A1iD0NjVRENNwEdR1NCKsCovXDs3eq9RcdlNfiX/e6HrevF3cGTKgmJWmKJINVGMAz1j
 bX3f/ARE9ggaZCsSV8rkNO2oJp+xAO5iLaZt3tmfkAhIedZ/iw3oS+0z0WWH9e2hlusm
 LzyahxRZRO/KNwLffKhK/aMfe+/REfB+OMkKw4IWRfIYTOnILV04SLL/oFxo4maLLyG0
 Uzh2Vs49PRXRMkCkS8d2FFjJIv9iC1CAOT+dL7yANEDkoo3y9oem77OmTWPR5q4aY5fc
 9cRA==
X-Gm-Message-State: AOAM533RSJxT+RiLU4N8XAEg0BpliKUzqckEvQ83poWHXbfxbzqlF1Ef
 gZQlvArL/HI/BcVm1bUBP76IIfRHYY4/SfKMJ4OIww==
X-Google-Smtp-Source: ABdhPJxL0ohc22+8Mx2TQykaqkmC5R7phVw0Z81EDs0sZ2gPqcGTUVeT5WsfQa11S6b+Zc2Mh4prrTZ8IEV61ptlfUA=
X-Received: by 2002:a19:2250:: with SMTP id i77mr3425496lfi.133.1589757685370; 
 Sun, 17 May 2020 16:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200517023444.286-1-takashi.yano@nifty.ne.jp>
From: Kacper Michajlow <kasper93@gmail.com>
Date: Mon, 18 May 2020 01:21:07 +0200
Message-ID: <CABPLASQozh_iBkLA-hGpQ88dQ6BHB0m=U_VBSotuM4zFXS3Piw@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: termios: Set ECHOE, ECHOK,
 ECHOCTL and ECHOKE by default.
To: cygwin-patches@cygwin.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, HTML_MESSAGE, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
X-List-Received-Date: Sun, 17 May 2020 23:21:28 -0000

On Sun, 17 May 2020 at 04:53, Takashi Yano via Cygwin-patches <
cygwin-patches@cygwin.com> wrote:

> - Backspace key does not work correctly in linux session opend by
>   ssh from cygwin console if the shell is bash. This is due to lack
>   of these flags.
>
>   Addresses: https://cygwin.com/pipermail/cygwin/2020-May/244837.html.
> ---
>  winsup/cygwin/fhandler_termios.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/fhandler_termios.cc
> b/winsup/cygwin/fhandler_termios.cc
> index b6759b0a7..b03478b87 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -33,7 +33,8 @@ fhandler_termios::tcinit (bool is_pty_master)
>        tc ()->ti.c_iflag = BRKINT | ICRNL | IXON | IUTF8;
>        tc ()->ti.c_oflag = OPOST | ONLCR;
>        tc ()->ti.c_cflag = B38400 | CS8 | CREAD;
> -      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN;
> +      tc ()->ti.c_lflag = ISIG | ICANON | ECHO | IEXTEN
> +       | ECHOE | ECHOK | ECHOCTL | ECHOKE;
>
>        tc ()->ti.c_cc[VDISCARD] = CFLUSH;
>        tc ()->ti.c_cc[VEOL]     = CEOL;
> --
> 2.21.0
>
>
Maybe also set  IXANY | IMAXBEL? For reasonable set of default values.

- Kacper
