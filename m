Return-Path: <cygwin-patches-return-8845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106736 invoked by alias); 30 Aug 2017 00:09:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106623 invoked by uid 89); 30 Aug 2017 00:09:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=enjoy, invest, Attached, Enjoy
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Aug 2017 00:09:54 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id mqZtdNZxKM9gtmqZudGcGA; Tue, 29 Aug 2017 18:09:54 -0600
X-Authority-Analysis: v=2.2 cv=a+JAzQaF c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=7vT8eNxyAAAA:8 a=N8syjIP81lwrT-VZvmQA:9 a=QEXdDO2ut3YA:10 a=Mzmg39azMnTNyelF985k:22
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de> <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca> <20170825094756.GN7469@calimero.vinschen.de> <20170829073520.GI16010@calimero.vinschen.de> <04edcc3e-3270-5a0b-14b8-cddaa80e006f@SystematicSw.ab.ca> <20170829191415.GL16010@calimero.vinschen.de>
Message-ID: <f348ed5a-3d07-eb63-3c32-6565fc752924@SystematicSw.ab.ca>
Date: Sat, 02 Sep 2017 07:45:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170829191415.GL16010@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAkugk31qu+fC7A8DyaMYL+r8qztrjcKrsaqg8rTfMwDfyo0lJ3BJ8PgW8X66Z8Nlgp7hw6A1NOWhxbYc0o9kWGhn1GMUN1OBQCRjB7Wk9EDHnxXaKC0 sz/iTVC4VkkK4qRpMQtK/a3ySF4alKP5SnOm8LIEsg5UXVlOdpf72sHw4ud354L9+Lj2v27gOTXa+UAmGnOWKTDf+hdmg5O/E6k=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00047.txt.bz2

On 2017-08-29 13:14, Corinna Vinschen wrote:
> On Aug 29 11:56, Brian Inglis wrote:
>> On 2017-08-29 01:35, Corinna Vinschen wrote:
>>> On Aug 25 11:47, Corinna Vinschen wrote:
>>>> On Aug 24 11:11, Brian Inglis wrote:
>>>>> On 2017-08-24 03:40, Corinna Vinschen wrote:
>>>>>> On Aug 24 11:32, Corinna Vinschen wrote:
>>>>>>> On Aug 23 13:25, Brian Inglis wrote:
>>>>>>>> Cygwin strptime(3) (also strptime(1)) fails with default width, without an
>>>>>>>> explicit width, because of the test in the following code:
>>>>>>>>
>>>>>>>> case 'F':	/* The date as "%Y-%m-%d". */
>>>>>>>> 	{
>>>>>>>> 	  LEGAL_ALT(0);
>>>>>>>> 	  ymd |= SET_YMD;
>>>>>>>> 	  char *tmp = __strptime ((const char *) bp, "%Y-%m-%d",
>>>>>>>> 				  tm, era_info, alt_digits,
>>>>>>>> 				  locale);
>>>>>>>> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
>>>>>>>> 	    return NULL;
>>>>>>>> 	  bp = (const unsigned char *) tmp;
>>>>>>>> 	  continue;
>>>>>>>> 	}
>>>>>>>>
>>>>>>>> as default width is zero so test fails and returns NULL.
>>>>>>>>
>>>>>>>> Simple patch for this as with the other cases supporting width is to change the
>>>>>>>> test to:
>>>>>>>>
>>>>>>>> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
>>>>>>>>
>>>>>>>> but this does not properly support [+0] flags or width in the format as
>>>>>>>> specified by glibc (latest POSIX punts on %F) for compatibility with strftime(),
>>>>>>>> affecting only the %Y format, supplying %[+0]<w-6>F, to support signed and zero
>>>>>>>> filled fixed and variable length year fields in %F format.
>>>>>> Btw., FreeBSD's _strptime only calls _strptime recursively, without any
>>>>>> checks for field width:
>>>>> As did Cygwin, which just did a goto recurse, before it was changed to support
>>>>> explicit width. Your call and option to go back and ignore it, patch bug, or
>>>>> forward and support flags and width based on strftime documentation.
>>>>
>>>> Well, I guess it depends on how much time you're willing to invest here.
>>>> If you're inclined to fix this per POSIX, you're welcome, of course.
>>>
>>> [...]
>>> Would it make sense, perhaps, if you just send the quick fix
>>> so we can get 2.9.0 out?
>> Attached - got diverted during strptime testing due to time functions gmtime,
>> localtime, mktime, strftime not properly handling struct tm->tm_year == INT_MAX
>> => year == INT_MAX + 1900 so year needs to be at least long in Cygwin 64, also
>> affecting tzcalc_limits, and depending on what is required to properly handle
>> time_t in Cygwin 32.
> 
> Sounds like you're busy with time functions for a while ;)

If either long or long long will fix both Cygwin 64 and 32 time_t and struct tm,
patches should not be long coming to a bunch of newlib time functions, although
testing it all, and redoing part of mktime, will extend that.

Running make check seems to lack support on Cygwin, so are there any buildbots
for other newlib platforms to check the patches will work there, or anyone who
could run a largish STC on some platforms?

>> From 19a3c20c705a576fee0f0e71a31f0c3ac553e612 Mon Sep 17 00:00:00 2001
>> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> Date: Tue, 29 Aug 2017 11:25:43 -0600
>> Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) fix %F width
>>
>> ---
>>  winsup/cygwin/libc/strptime.cc | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Pushed.

Thanks. Enjoy your vacay.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
