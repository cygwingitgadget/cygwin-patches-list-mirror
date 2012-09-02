Return-Path: <cygwin-patches-return-7713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4924 invoked by alias); 2 Sep 2012 17:51:49 -0000
Received: (qmail 4914 invoked by uid 22791); 2 Sep 2012 17:51:47 -0000
X-SWARE-Spam-Status: No, hits=-4.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-pb0-f43.google.com (HELO mail-pb0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 02 Sep 2012 17:51:30 +0000
Received: by pbbrq2 with SMTP id rq2so6418626pbb.2        for <cygwin-patches@cygwin.com>; Sun, 02 Sep 2012 10:51:30 -0700 (PDT)
Received: by 10.66.77.229 with SMTP id v5mr28710950paw.60.1346608290009;        Sun, 02 Sep 2012 10:51:30 -0700 (PDT)
Received: from [192.168.1.2] ([119.201.52.168])        by mx.google.com with ESMTPS id uu6sm8087558pbc.70.2012.09.02.10.51.28        (version=SSLv3 cipher=OTHER);        Sun, 02 Sep 2012 10:51:29 -0700 (PDT)
Message-ID: <50439CAE.6080603@gmail.com>
Date: Sun, 02 Sep 2012 17:51:00 -0000
From: Jin-woo Ye <jojelino@gmail.com>
Reply-To: 20120902102718.GC13401@calimero.vinschen.de
User-Agent: Mozilla/5.0 (Windows NT 5.2; rv:18.0) Gecko/18.0 Thunderbird/18.0a1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de>
In-Reply-To: <20120902102718.GC13401@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00034.txt.bz2

On 2012-09-02 PM 7:27, Corinna Vinschen wrote:
> Hi Jin-woo,
>
> On Aug 26 10:59, Jin-woo Ye wrote:
>> This patch fixes the problem making pseudo-reloc too slow when there
>> is many pseudo-reloc entries in rdata section by deciding when not
>> to call Virtual{Query,Protect} to save overhead.
>> I tested this patch and time taken for pseudo-reloc reduced 1800ms
>> to 16ms for 3682 entries.
>> Please review this patch.
>
> Done.  The idea is good, but I wasn't quite happy with your code.  It's
> hard to read and it's more complicated than necessary.  For instance,
> you only handle one page at a time, but your code keeps an array for two
> page information entries around for no good reason.
>
> I checked in a simplified version of your patch.  Please have a look.
> Since the code in question is in the public domain, it doesn't require
> a Cygwin copyright assignment.
>
>
> Thanks,
> Corinna
>
Now it is clear that this patch would be needed other relevant projects 
such as mingw, mingw-w64. thanks for your effort on simplified one.

-- 
Regards.
