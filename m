Return-Path: <cygwin-patches-return-8739-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17194 invoked by alias); 16 Apr 2017 10:21:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17142 invoked by uid 89); 16 Apr 2017 10:21:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=H*Ad:D*org.uk, HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 16 Apr 2017 10:21:30 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id B364120A14;	Sun, 16 Apr 2017 06:21:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Sun, 16 Apr 2017 06:21:30 -0400
X-ME-Sender: <xms:qkXzWEmeWUzYV6SoH8f5Qs7MnYXihMLqIIwr57OsV-Y8S5-8SRo1zA>
Received: from [192.168.1.102] (host86-141-129-28.range86-141.btcentralplus.com [86.141.129.28])	by mail.messagingengine.com (Postfix) with ESMTPA id 4ECB0244D9;	Sun, 16 Apr 2017 06:21:30 -0400 (EDT)
Subject: Re: [PATCH] strace: Fix crash caused over-optimization
References: <20170415222750.28067-1-daniel.santos@pobox.com>
Cc: Daniel Santos <daniel.santos@pobox.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <201db532-9a76-7358-d12a-469a1f5e7d71@dronecode.org.uk>
Date: Sun, 16 Apr 2017 10:21:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170415222750.28067-1-daniel.santos@pobox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q2/txt/msg00010.txt.bz2

On 15/04/2017 23:27, Daniel Santos wrote:
> Recent versions of gcc are optimizing away the TLS buffer allocated in
> main, so we need to tell gcc that it's really used.
> ---
>  winsup/utils/strace.cc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
> index beab67b90..1e581b4a4 100644
> --- a/winsup/utils/strace.cc
> +++ b/winsup/utils/strace.cc
> @@ -1192,6 +1192,8 @@ main (int argc, char **argv)
>    char buf[CYGTLS_PADSIZE];
>
>    memset (buf, 0, sizeof (buf));
> +  /* Prevent buf from being optimized away.  */
> +  __asm__ __volatile__("" :: "m" (buf));

wouldn't adding volatile to the definition of buf be a better way to 
write this?

>    exit (main2 (argc, argv));
>  }
>
>
