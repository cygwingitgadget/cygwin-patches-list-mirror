Return-Path: <marco.atzeri@gmail.com>
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by sourceware.org (Postfix) with ESMTPS id 6CB003857C5F
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 10:44:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6CB003857C5F
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=marco.atzeri@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 n11-20020a05600c4f8bb029010e5cf86347so2441842wmq.1
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=++CYoVNHLTrcT3eL9tlvkQsyZVAEztByBSGX9v1kC4s=;
 b=YuB4U8+8HBDBm0NHy8gSKSSNMOrJRo1JZRcD/HI+3YQCNjiJtHsXmA11YLlcss3WRv
 CF60QjWtuSoVAXua+xuAanaH0CU2QO+X27PfRb7B7EL7wBxU3LYm8rig08w0ybHD3ABr
 18Dc292/nOktsH81L3pp+PWEtSRgTKUsgGmaCqxQMRgVO4U3S24YwfbgMyC3j5kgSCtr
 NYqOaNstRDCJwZWfM0QY+Z0fOEYGmOEeGA7D2XMXfel2cTTB0APJ4kdkubo8Cw/AvA5I
 jxH+7XLDlPMg6vc556I5yvzJBHlYzUgnh1B6MPn/SUkM5GLiXt5p4zVpK/uHXtslxA+M
 082A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=++CYoVNHLTrcT3eL9tlvkQsyZVAEztByBSGX9v1kC4s=;
 b=cfK7OGm5mvk/72ccvKFlJaycjd1VvrIz6VtGekZS+IdcVtCv8WDlF2kqbgCJgsxSsO
 l14jdSOmTRkXfuFK563KnzN+ZtzHK6iP66AnXh26vQTVymz41AJ1jKhiFXTXtlhdEwmF
 4Uk1Hb7YAd5idZTCC5W4NCCbky+1FG4YJ1sJ83Jz6oEuxHl2TjekgkG8Zqq/+jyCPB+l
 tmgSybsut197e1s009gH9ohwSA0IgdRuZUD+aq2cW5vibTLrnIeelwS2oO1CFkFEjNQu
 CT/dQJcyEuakDHh6RIbJ0wyEXQR8i8B+H3xN3qqYeWOLpqgZuTgTgr1uO6c0LHiVOulF
 X+bQ==
X-Gm-Message-State: AOAM532zmAYasRLJ5daUKVj1lpkL1crkzLy8QX/fTFHVTn+17xVCt+rA
 ATrLaADytEDBfsCJ6Be/L2Y=
X-Google-Smtp-Source: ABdhPJxNUHL/JOSAVPFqiRzAs/T/AsuiKezcz62/LdK5R/ulE4z1aJreg7Wdd//nGopRu/NGFC7m4g==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr2270347wmf.106.1616582639510; 
 Wed, 24 Mar 2021 03:43:59 -0700 (PDT)
Received: from ?IPv6:2003:cc:9f36:b81f:4064:ed2d:d1f8:5bd3?
 (p200300cc9f36b81f4064ed2dd1f85bd3.dip0.t-ipconnect.de.
 [2003:cc:9f36:b81f:4064:ed2d:d1f8:5bd3])
 by smtp.gmail.com with ESMTPSA id c6sm2501118wri.32.2021.03.24.03.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Mar 2021 03:43:58 -0700 (PDT)
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
To: cygwin-patches@cygwin.com, Jan Nijtmans <jan.nijtmans@gmail.com>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <78ac1b6e-c933-8b3a-9603-14d031f38b64@gmail.com>
Date: Wed, 24 Mar 2021 11:43:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
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
X-List-Received-Date: Wed, 24 Mar 2021 10:44:02 -0000

On 23.03.2021 11:10, Corinna Vinschen wrote:
> [CC Marco, CC Jan]
> 
> 
>> Out of curiosity, I took a quick glance at the cmake code.  It appears that
>> this code is designed to support running cmake in a Console.  I don't think
>> that should be needed any more, if it ever was.
>> [...]
>> I think the following might suffice (untested):
>>
>> --- a/Source/kwsys/Terminal.c
>> +++ b/Source/kwsys/Terminal.c
>> @@ -10,7 +10,7 @@
>>   #endif
>>
>>   /* Configure support for this platform.  */
>> -#if defined(_WIN32) || defined(__CYGWIN__)
>> +#if defined(_WIN32)
>>   #  define KWSYS_TERMINAL_SUPPORT_CONSOLE
>>   #endif
>>   #if !defined(_WIN32)

noted.
cmake was always annoying, we remove this type of define and they add
somewhere else


> Looks right to me.  If we patch cmake to do the right thing, do we still
> need this patch, Takashi?
> 
> 
> Thanks,
> Corinna

Regards
Marco

