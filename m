Return-Path: <cygwin-patches-return-8854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13197 invoked by alias); 14 Sep 2017 12:42:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10811 invoked by uid 89); 14 Sep 2017 12:42:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: mail-io0-f195.google.com
Received: from mail-io0-f195.google.com (HELO mail-io0-f195.google.com) (209.85.223.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Sep 2017 12:41:59 +0000
Received: by mail-io0-f195.google.com with SMTP id 93so3761143iol.4        for <cygwin-patches@cygwin.com>; Thu, 14 Sep 2017 05:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:subject:to:references:reply-to:from:message-id         :date:user-agent:mime-version:in-reply-to:content-language         :content-transfer-encoding;        bh=023zahTLx61LF/axdMonAzU91dU0P51kAR+HY411ghU=;        b=FBH0ZM63VacXJGCuFG3N+ONlex+TGp1NWCOaRbsaS7yOxc+1EiyyGglG/clYPeSwWs         b+S7N8Rliz4E+e/oqPjrPfx7ldox0Ol88rqCTz6nMMVb8YZhLN+cxVex3dL4dcbG2rf2         NCchGDViVmyF4cvj/sUnFpQQwJLTpDSsoFytzsRuSs9mzbZPnSzE1ryS0fCdKCXAriih         3q88QQK1W4GAzzhOOYyVRR8/jUrRGQ/PBhxdE+R9Tv7D0qzu+SPQynqQ9GfJFaczTKKl         t8sHni3R8DmIUUClOZnxk0t4Oq+t08ESS3x8JLGlG2izY1FtCrO0F3BQPL534QsBqvA3         Qa8A==
X-Gm-Message-State: AHPjjUiXpWI8ipWR5v4grOiImfxqipzhiB1vwcCKVez6F6GTG2O/2eyM	w2IkFBLvqHpSlqlP
X-Google-Smtp-Source: AOwi7QCmDkICPQA69UM63JgBTbCKuBQnJSmakUpxT80377ZIi+/VzDS3WQ15A6VkN+5uX7UDEuKEcQ==
X-Received: by 10.107.201.84 with SMTP id z81mr2659676iof.96.1505392917459;        Thu, 14 Sep 2017 05:41:57 -0700 (PDT)
Received: from [192.168.0.6] (d4-50-42-50.try.wideopenwest.com. [50.4.50.42])        by smtp.gmail.com with ESMTPSA id s2sm1001167itb.20.2017.09.14.05.41.56        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 14 Sep 2017 05:41:56 -0700 (PDT)
Subject: Re: [PATCH] Fix possible segmentation fault in strnstr() on 64-bit systems
To: cygwin-patches@cygwin.com
References: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de> <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
Reply-To: cygwin@cygwin.com
From: cyg Simple <cygsimple@gmail.com>
Message-ID: <57205380-19d8-5be2-1594-ed8733d920c2@gmail.com>
Date: Sun, 17 Sep 2017 02:04:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00056.txt.bz2

On 9/13/2017 5:55 PM, Yaakov Selkowitz wrote:
> On 2017-09-13 10:44, Johannes Schindelin wrote:
>> As of f22054c94d (Modify strnstr.c., 2017-08-30), the strnstr()
>> implementation was replaced by a version that segfaults (at least
>> sometimes) on 64-bit systems.
>>
>> The reason: the new implementation uses memmem(), and the prototype of
>> memmem() is missing because the _GNU_SOURCE constant is not defined
>> before including <string.h>. As a consequence its return type defaults
>> to int (and GCC spits out a warning).
>>
>> On 64-bit systems, the int data type is too small, though, to hold a
>> full char *, hence the upper 32-bit are cut off and bad things happen
>> due to a bogus pointer being used to access memory.
>>
>> Reported as https://github.com/Alexpux/MINGW-packages/issues/2879 in
>> the MSYS2 project.
> 
> As this is part of newlib, the proper place for this is on the newlib
> list.  Others have already proposed similar patches, so please feel free
> to follow the discussion there.

This begs the question as to why _GNU_SOURCE isn't defined by default
for Cygwin?

-- 
cyg Simple
