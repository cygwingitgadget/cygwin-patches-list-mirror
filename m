Return-Path: <cygwin-patches-return-8404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97482 invoked by alias); 15 Mar 2016 10:55:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97441 invoked by uid 89); 15 Mar 2016 10:55:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-lb0-f171.google.com
Received: from mail-lb0-f171.google.com (HELO mail-lb0-f171.google.com) (209.85.217.171) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 15 Mar 2016 10:55:50 +0000
Received: by mail-lb0-f171.google.com with SMTP id bc4so17160328lbc.2        for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2016 03:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:date         :message-id:subject:from:to;        bh=iL6tWBdsLlZoyieAH4ffYql76oprApcPnCkZKK8uzdk=;        b=WlOqAtTRRUz3KHM2gyUXf3/huhcUZbchPh0DHmcC2HeKhLJ9RQDCbYm/TlYnEnmjqq         QgAofaSSCW3/FDrHKfrNInKJwzv3QzqcuDc5huG4/yTiAQ67iM8wKi2gElHPTMkDLgkJ         DunvZB0YEag5Dl4bfXuDK9ZtCNLXdMhhZo3sz8qf6iB1XfH1ZZwfVmuxEwfoD9QaxGZ6         v8ufAI4VAcqQNjYUwSsTfuHWjefl7b58HjFzuVizfg1FboQiLLJplGk8NPJJNQd+3NGd         Xw70I9+hQ6EoTOLG+/A5NRWLO1zhyySUEZf9oDk0N9AnDu6mKeqxJexMps6k0Lp9a7l0         WMxA==
X-Gm-Message-State: AD7BkJIXFelg7q4TxZYrMIjlqjjwLYXodxP449HOosAzWxO03pZhGYKUv5Xtdi4JwzeKp9YCY8/HyZnvbjUl/g==
MIME-Version: 1.0
X-Received: by 10.25.35.87 with SMTP id j84mr9840127lfj.119.1458039346826; Tue, 15 Mar 2016 03:55:46 -0700 (PDT)
Received: by 10.25.205.82 with HTTP; Tue, 15 Mar 2016 03:55:46 -0700 (PDT)
In-Reply-To: <1458011636-8548-1-git-send-email-yselkowi@redhat.com>
References: <1458011636-8548-1-git-send-email-yselkowi@redhat.com>
Date: Tue, 15 Mar 2016 10:55:00 -0000
Message-ID: <CAKw7uVg7QZyVJCO0miU1HXwn6PF-8yxSwzMn7s_t6CkUb2ts5w@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: define byteswap.h inlines as macros
From: =?UTF-8?Q?V=C3=A1clav_Haisman?= <vhaisman@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00110.txt.bz2

On 15 March 2016 at 04:13, Yaakov Selkowitz <yselkowi@redhat.com> wrote:
> The bswap_* "functions" are macros in glibc, so they may be tested for
> by the preprocessor (e.g. #ifdef bswap_16).
>
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/byteswap.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/byteswap.h
> index cd5a726..9f73c5a 100644
> --- a/winsup/cygwin/include/byteswap.h
> +++ b/winsup/cygwin/include/byteswap.h
> @@ -16,23 +16,27 @@ extern "C" {
>  #endif
>
>  static __inline unsigned short
> -bswap_16 (unsigned short __x)
> +__bswap_16 (unsigned short __x)
>  {
>    return (__x >> 8) | (__x << 8);
>  }
>
>  static __inline unsigned int
> -bswap_32 (unsigned int __x)
> +__bswap_32 (unsigned int __x)
>  {
> -  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
> +  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
>  }
>
>  static __inline unsigned long long
> -bswap_64 (unsigned long long __x)
> +__bswap_64 (unsigned long long __x)
>  {
> -  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) | (bswap_32 (__x >> 32));
> +  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32) | (__bswap_32 (__x >> 32));
>  }
>
> +#define bswap_16(x) __bswap_16(x)
> +#define bswap_32(x) __bswap_32(x)
> +#define bswap_64(x) __bswap_64(x)
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.7.0
>

Would it not be better to leave the original functions as they were
and simply use these defines?

#define bswap_16 bswap_16
#define bswap_32 bswap_32
#define bswap_64 bswap_64

I believe this is valid C and C++. Untested.

-- 
VH

On 15 March 2016 at 04:13, Yaakov Selkowitz <yselkowi@redhat.com> wrote:
> The bswap_* "functions" are macros in glibc, so they may be tested for
> by the preprocessor (e.g. #ifdef bswap_16).
>
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/byteswap.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/winsup/cygwin/include/byteswap.h b/winsup/cygwin/include/byteswap.h
> index cd5a726..9f73c5a 100644
> --- a/winsup/cygwin/include/byteswap.h
> +++ b/winsup/cygwin/include/byteswap.h
> @@ -16,23 +16,27 @@ extern "C" {
>  #endif
>
>  static __inline unsigned short
> -bswap_16 (unsigned short __x)
> +__bswap_16 (unsigned short __x)
>  {
>    return (__x >> 8) | (__x << 8);
>  }
>
>  static __inline unsigned int
> -bswap_32 (unsigned int __x)
> +__bswap_32 (unsigned int __x)
>  {
> -  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
> +  return (__bswap_16 (__x & 0xffff) << 16) | (__bswap_16 (__x >> 16));
>  }
>
>  static __inline unsigned long long
> -bswap_64 (unsigned long long __x)
> +__bswap_64 (unsigned long long __x)
>  {
> -  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) | (bswap_32 (__x >> 32));
> +  return (((unsigned long long) __bswap_32 (__x & 0xffffffffull)) << 32) | (__bswap_32 (__x >> 32));
>  }
>
> +#define bswap_16(x) __bswap_16(x)
> +#define bswap_32(x) __bswap_32(x)
> +#define bswap_64(x) __bswap_64(x)
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.7.0
>



-- 
VH
