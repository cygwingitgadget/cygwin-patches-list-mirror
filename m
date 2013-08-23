Return-Path: <cygwin-patches-return-7894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13689 invoked by alias); 23 Aug 2013 20:11:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13676 invoked by uid 89); 23 Aug 2013 20:11:30 -0000
X-Spam-SWARE-Status: No, score=-3.7 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,SPF_PASS autolearn=ham version=3.3.2
Received: from mail-ie0-f170.google.com (HELO mail-ie0-f170.google.com) (209.85.223.170)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 23 Aug 2013 20:11:29 +0000
Received: by mail-ie0-f170.google.com with SMTP id 17so1623482iea.1        for <cygwin-patches@cygwin.com>; Fri, 23 Aug 2013 13:11:28 -0700 (PDT)
X-Received: by 10.50.25.39 with SMTP id z7mr2762976igf.59.1377288688226;        Fri, 23 Aug 2013 13:11:28 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id w4sm5075206igb.5.1969.12.31.16.00.00        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Fri, 23 Aug 2013 13:11:27 -0700 (PDT)
Message-ID: <5217C1EC.9010606@users.sourceforge.net>
Date: Fri, 23 Aug 2013 20:11:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygcheck -p
References: <announce.20130823172713.GA6948@ednor.casa.cgf.cx> <20130823192251.GA3454@ednor.casa.cgf.cx> <5217BC12.9040601@users.sourceforge.net>
In-Reply-To: <5217BC12.9040601@users.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q3/txt/msg00001.txt.bz2

On 2013-08-23 14:46, Yaakov (Cygwin/X) wrote:
> On 2013-08-23 14:22, Christopher Faylor wrote:
>> On Fri, Aug 23, 2013 at 01:27:13PM -0400, Christopher Faylor wrote:
>>> I'm working on bringing Cygwin's package search into the multi-arch
>>> world so it will be down for a while while I tweak things.
>>
>> This went much faster than I expected.  The new package interface allows
>> you to switch between x86 and x86_64 when searching for or displaying
>> packages.
>>
>> This interface now uses javascript to control which arch is displayed.
>
> Patch to adapt 'cygcheck -p' for this change attached.

Never mind, cgf fixed this already.


Yaakov
