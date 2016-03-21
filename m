Return-Path: <cygwin-patches-return-8471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62960 invoked by alias); 21 Mar 2016 20:00:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62948 invoked by uid 89); 21 Mar 2016 20:00:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=alright, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, person
X-HELO: mail-ob0-f194.google.com
Received: from mail-ob0-f194.google.com (HELO mail-ob0-f194.google.com) (209.85.214.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:00:32 +0000
Received: by mail-ob0-f194.google.com with SMTP id e7so15737910obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=QtDV+4zEvWXSHp831OSQWLg621LcoggRHy/0mQUz314=;        b=jLjvRSucnRQAwFs/AONQfwMM1HnAJZqjn5oMVqqv/SjxJ+ZZoe5qQJ6zjz/Hul6kkU         p5j15g6TUbJY0QAI3AB8kzmL/95XCJTaf4jPjyvbI1gCX2VD3aa9ZSKwlLpn02nKBaKL         74wmaPZy3RQFdWcr8pY7On1fVRMS2ra2nlH4zv+PFQ9M9Ov0PhtLKOcvcm2ObWo3YbHf         5I89q7L2vBVy3kksq1bJMgIbMtNTehiE4DBOyGdr/Z2vQ2Z4tkrMmLa/IGPaOBi3hOsZ         sjzBw4dX9SZJT0yl9cXVzZ2XoKXB4IXoKFNZ6hqfGaeKZ9jizU1O2P/AfXMNClvTRvbM         pprw==
X-Gm-Message-State: AD7BkJL/JhuTxbv0iQHNQGF5vQLSn3LJKdbIl1QMF6FtoJItTVC6CRf5t3YcXpaE+FWXvk2yF7e7q/PRgYBJpA==
X-Received: by 10.60.178.202 with SMTP id da10mr18150779oec.11.1458590430638; Mon, 21 Mar 2016 13:00:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:00:11 -0700 (PDT)
In-Reply-To: <20160321195845.GL14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:00:00 -0000
Message-ID: <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com>
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00177.txt.bz2

On Mon, Mar 21, 2016 at 3:58 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Again, I'm cross compiling all the time since I build Cygwin on Linux
> for development and package building, and I'm certianly not the only
> person doing that.  This is the default case.  Not building utils and
> lsaauth is the exception.  Therefore this scenario should be handled
> explicitely by a configure flag, not the other way around.

Alright, I'll rework this patch to that effect.

Thanks,

Peter
