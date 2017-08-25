Return-Path: <cygwin-patches-return-8838-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57293 invoked by alias); 24 Aug 2017 16:52:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56886 invoked by uid 89); 24 Aug 2017 16:52:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Attached, H*F:D*ca, HTo:U*cygwin-patches, H*R:D*ca
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 16:52:11 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id kvMWd8XTYDJTWkvMXdqC8h; Thu, 24 Aug 2017 10:52:09 -0600
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=7vT8eNxyAAAA:8 a=vGp-FAc-fQK3CzKdMnIA:9 a=QEXdDO2ut3YA:10 a=Mzmg39azMnTNyelF985k:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <20170824092535.GH7469@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <731aed6f-af6e-2f4f-0aa4-fd79e060d221@SystematicSw.ab.ca>
Date: Fri, 25 Aug 2017 09:41:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170824092535.GH7469@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAUBam8OxpEYmPp5DKRRT9IcL9fpIT1CZnrdz7wqninFhb9p8RzrwkAU1HTVqyvA0xP7cU5X9i7XrOR9JtcBe9HTBW7yU9yW0v44QcqgM47bvd+N55iq JWr0J3Qzm+eCd21/C+7VYS+cPf3fyTLkpH3x8e9YtHOTk4niAfED+SVYHaZvTuXbuRqwn1P5KY8/s6ZXKqCyg3kVrLQljbTfquU=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00040.txt.bz2

On 2017-08-24 03:25, Corinna Vinschen wrote:
> On Aug 23 12:51, Brian Inglis wrote:
>> Attached patch to support %s in Cygwin winsup libc strptime.cc __strptime().
>>
>> This also enables support for %s in dateutils package strptime(1).
>>
>> In case the issue comes up, if the user wants to support %s as in date(1) with a
>> preceding @ flag, they just have to include that verbatim before the format as
>> in "@%s".
>>
>> Testing revealed a separate issue with %F format which I will follow up on in a
>> different thread.
>>
>> Similar patch coming for newlib.
>>
>> -- 
>> Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
> 
>> From 11f950597e7f66132a2ce6c8120f7199ba02316f Mon Sep 17 00:00:00 2001
>> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> Date: Tue, 22 Aug 2017 15:10:27 -0600
>> Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
>>
>> ---
>>  winsup/cygwin/libc/strptime.cc | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/winsup/cygwin/libc/strptime.cc b/winsup/cygwin/libc/strptime.cc
>> index 62dca6e5e..a7fef4985 100644
>> --- a/winsup/cygwin/libc/strptime.cc
>> +++ b/winsup/cygwin/libc/strptime.cc
>> @@ -573,6 +573,29 @@ literal:
>>  			bp = conv_num(bp, &tm->tm_sec, 0, 61, ALT_DIGITS);
>>  			continue;
>>  
>> +		case 's' :	/* The seconds since Unix epoch - GNU extension */
>> +		    {
>> +			long long sec;
>> +			time_t t;
>> +			int errno_save;
>> +			char *end;
>> +
>> +			LEGAL_ALT(0);
>> +			errno_save = errno;
> 
> Funny enough, in other places in Cygwin we call this temp variable
> "save_errno" :)
> 
> 
> Alternatively, since you're in C++ code, you can use the save_errno
> class, like this:
> 
>   {
>     save_errno save;
> 
>     [do your thing]
>   }
> 
> The destructor of save_errno will restore errno.
> 
> Since the code as such is fine, it's your choice if you want to stick
> to it or use one of the above.  Just give the word.

Useful - wish I'd known - stick to your standards and keep it clean - thanks.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
