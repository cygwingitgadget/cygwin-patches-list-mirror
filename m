Return-Path: <alves.ped@gmail.com>
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by sourceware.org (Postfix) with ESMTPS id B9AB43858414
	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2022 15:29:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B9AB43858414
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-x435.google.com with SMTP id h9so7613343wrt.0
        for <cygwin-patches@cygwin.com>; Fri, 04 Nov 2022 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVjkRYIcrrDLfuQwYmR3N5p1UxsCiu3f0wzE6ymq4bY=;
        b=kN1hXFsHpZH8WmlfBAVrTEp7LaaMdR6vJjB3jTKGmJFp6VuSZ8NSqiNX2eW8mEDGq5
         4Sy/fVxrqZgOQA91q36bC46+I6bucEOjzcZnACTgHOksLun7jw5kc3jodSHm5M9yD3+y
         x/f7qUVmTH7B8az1LrljSri5spCTar3Zj/j0RY+9nTrk/eNTO482pDw9ckIGxEJw8A1R
         HXcu51oUEMgxVPjBB5aF9PabsKPUYzhtprb2IB2FpkkF9AU47VIsFBYqRA2ksK+/+83T
         oJrPb97ubyvDdQjZsMA9qbC0m0huRgtmYCz3gnBw7QlPPvWiysnu8SCiMq5B79Bmn78C
         dLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVjkRYIcrrDLfuQwYmR3N5p1UxsCiu3f0wzE6ymq4bY=;
        b=G9vLeyzF2dpBEKc91CRN1ExDRKMzIzGV5CkjTV2LI8tg+5/hlPgFXOsmewVqCC8TAL
         HeuRCB101WBZ3uxCAFTiUz2+yu9ekL65wzI26X6f/lmmvptGku9jgwqRXH2DkgI+Y158
         5cRvj0IXa+WaI6ZMUh5xGNCqQZcF11L8vE4rRYaYSoURmcm7N/PXGMa3jgy0Zjd5BA1q
         8nCSqT4yJfmW8dd+0H/9Ca0fS+vvYmH/FGvbrfpT0uDjPTQrLM9gu18zp2FNL5tHad03
         NaxeWFqLZTgrawvsaOj8F/skJEHT02qWnM6uYbzSbooavLs9zj/hJrjCbqUfOjYB3zNz
         Z+PQ==
X-Gm-Message-State: ACrzQf2LXvnDs8lM0+aEUxg+e1fApsx5vDJ35uK56UWtUbduf4Q0EOBw
	HV4gLlo2vlyh2M/icWC/97I=
X-Google-Smtp-Source: AMsMyM6OpO4zaaRhnSrZrQhVV5J91YiHKqhJYFlf4Tf8r9P0tXlJw+J610p0qVeC5M8tH/JyTKl1Qw==
X-Received: by 2002:a5d:534b:0:b0:236:73ff:3605 with SMTP id t11-20020a5d534b000000b0023673ff3605mr22237720wrv.521.1667575781169;
        Fri, 04 Nov 2022 08:29:41 -0700 (PDT)
Received: from ?IPv6:2001:8a0:f93a:3b00:e038:5cdc:b8bf:4653? ([2001:8a0:f93a:3b00:e038:5cdc:b8bf:4653])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b0023662d97130sm3609850wrv.20.2022.11.04.08.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 08:29:40 -0700 (PDT)
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
To: Jon Turney <jon.turney@dronecode.org.uk>,
 Cygwin Patches <cygwin-patches@cygwin.com>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
From: Pedro Alves <alves.ped@gmail.com>
Cc: pedro@palves.net
Message-ID: <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
Date: Fri, 4 Nov 2022 15:29:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2022-11-04 12:53 p.m., Jon Turney wrote:
> +<para>
> +  (It may be necessary to use the <command>gdb</command> command <command>set
> +  disable-randomization on</command> to turn off ASLR for the debugee to
> +  prevent the base address getting randomized.)
> +</para>
>  </answer></qandaentry>
>  

Typo: debugee -> debuggee

Note that "on" is the default.
