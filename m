Return-Path: <cygwin-patches-return-8285-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8351 invoked by alias); 14 Dec 2015 13:38:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8328 invoked by uid 89); 14 Dec 2015 13:37:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-io0-f178.google.com
Received: from mail-io0-f178.google.com (HELO mail-io0-f178.google.com) (209.85.223.178) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 14 Dec 2015 13:37:57 +0000
Received: by iofq126 with SMTP id q126so33467548iof.2        for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2015 05:37:55 -0800 (PST)
X-Received: by 10.107.137.23 with SMTP id l23mr11276941iod.102.1450100275698;        Mon, 14 Dec 2015 05:37:55 -0800 (PST)
Received: from [192.168.0.9] (d27-96-48-76.nap.wideopenwest.com. [96.27.76.48])        by smtp.gmail.com with ESMTPSA id p125sm12017174ioe.13.2015.12.14.05.37.55        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Mon, 14 Dec 2015 05:37:55 -0800 (PST)
Subject: Re: Trivial fix to last change
To: cygwin-patches@cygwin.com
References: <566B4AB2.1000905@cornell.edu> <20151214092507.GD3507@calimero.vinschen.de>
From: cyg Simple <cygsimple@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <566EC64D.5060802@gmail.com>
Date: Mon, 14 Dec 2015 13:38:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20151214092507.GD3507@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00038.txt.bz2

On 12/14/2015 4:25 AM, Corinna Vinschen wrote:
> On Dec 11 17:14, Ken Brown wrote:
>> cygwin1.dll doesn't build on x86 after the last commit (eed35ef).  The
>> trivial patch attached fixes it.
>>
>> Ken
> 
>> From 1cd61c54994b2ba6c6ec1d1f8f1249f5f8fd4af3 Mon Sep 17 00:00:00 2001
>> From: Ken Brown <kbrown@cornell.edu>
>> Date: Fri, 11 Dec 2015 17:08:28 -0500
>> Subject: [PATCH] Fix regparm attribute of fhandler_base::fstat_helper
>>
>> * winsup/cygwin/fhandler_disk_file.cc (fhandler_base::fstat_helper):
>> Align regparm attribute to declaration in fhandler.h.
>> ---
>>  winsup/cygwin/ChangeLog             | 5 +++++
>>  winsup/cygwin/fhandler_disk_file.cc | 2 +-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
>> index 3c9804b..7079baa 100644
>> --- a/winsup/cygwin/ChangeLog
>> +++ b/winsup/cygwin/ChangeLog
>> @@ -1,3 +1,8 @@
>> +2015-12-11  Ken Brown  <kbrown@cornell.edu>
>> +
>> +	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Align
>> +	regparm attribute to declaration in fhandler.h.
>> +
>>  2015-12-10  Corinna Vinschen  <corinna@vinschen.de>
>>  
>>  	* path.h (class path_conv_handle): Use FILE_ALL_INFORMATION instead of
>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>> index fe9dd03..1dd1b8c 100644
>> --- a/winsup/cygwin/fhandler_disk_file.cc
>> +++ b/winsup/cygwin/fhandler_disk_file.cc
>> @@ -428,7 +428,7 @@ fhandler_base::fstat_fs (struct stat *buf)
>>    return res;
>>  }
>>  
>> -int __reg3
>> +int __reg2
>>  fhandler_base::fstat_helper (struct stat *buf)
>>  {
>>    IO_STATUS_BLOCK st;
>> -- 
>> 2.6.2
>>
> 
> Applied.  I really should build on *both* architectures before applying
> a patch :-P
> 

Would it have made more sense to test for architecture target?

-- 
cyg Simple
