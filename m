Return-Path: <cygwin-patches-return-7683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9088 invoked by alias); 18 Jul 2012 20:24:05 -0000
Received: (qmail 9069 invoked by uid 22791); 18 Jul 2012 20:24:04 -0000
X-SWARE-Spam-Status: No, hits=-5.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_TM
X-Spam-Check-By: sourceware.org
Received: from mail-gh0-f171.google.com (HELO mail-gh0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Jul 2012 20:23:47 +0000
Received: by ghy10 with SMTP id 10so2152221ghy.2        for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2012 13:23:46 -0700 (PDT)
Received: by 10.43.46.194 with SMTP id up2mr1408323icb.22.1342643026688;        Wed, 18 Jul 2012 13:23:46 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id bo7sm834igb.2.2012.07.18.13.23.45        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 18 Jul 2012 13:23:46 -0700 (PDT)
Message-ID: <50071B5D.3070600@users.sourceforge.net>
Date: Wed, 18 Jul 2012 20:24:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <4FCEC079.2090802@users.sourceforge.net> <20120606073305.GA18246@calimero.vinschen.de> <50068E29.6060302@users.sourceforge.net> <20120718111729.GI31055@calimero.vinschen.de>
In-Reply-To: <20120718111729.GI31055@calimero.vinschen.de>
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
X-SW-Source: 2012-q3/txt/msg00004.txt.bz2

On 2012-07-18 06:17, Corinna Vinschen wrote:
> On Jul 18 05:21, Yaakov (Cygwin/X) wrote:
>> On 2012-06-06 02:33, Corinna Vinschen wrote:
>>> In case of Cygwin this is not needed since we don't read from the file
>>> but from the internal datastructure.  There's no reason to create
>>> garbage in buf just because this is by chance the layout the buffer gets
>>> when operating under Linux.
>>>
>>> The *important* thing is that buf contains the strings the members of
>>> mntbuf points to.
>>
>> OK, revised patch attached.
>
> Thanks.  Applied with a tweak:  It's really not necessary at all to
> create strings for mnt_freq and mnt_passno in buf.  Just copy them
> over from mnt to mntbuf and be done with it.

In that case, we don't need opts_len, and AFAICS it will introduce a 
warning with GCC 4.6 [-Wunused-but-set-variable].  OK to remove?


Yaakov
