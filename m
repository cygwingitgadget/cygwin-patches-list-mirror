Return-Path: <cygwin-patches-return-8839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6923 invoked by alias); 24 Aug 2017 17:11:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6071 invoked by uid 89); 24 Aug 2017 17:11:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 17:11:04 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id kvend8eTpDJTWkveodqHek; Thu, 24 Aug 2017 11:11:02 -0600
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=uZvujYp8AAAA:8 a=LCnpV2UyYzdK9kjhCY8A:9 a=QEXdDO2ut3YA:10 a=n78XAzC8_qoA:10 a=SLzB8X_8jTLwj6mN0q5r:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca>
Date: Fri, 25 Aug 2017 09:48:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170824094028.GK7469@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNDaGfpOzEuCeVzHlx07alsHpNo1KMVfdXCCwjDQGQt8p5j6GnR5BDOd6CHcI9xYzwL2E3zL0LA+ZMB3JMkQqKd9tMUrSydEg3qPcs2c6Im+DQZ6u/EQ JuNuAyXcK53oI76UREG0w0rSe2Vj6UZ0P6JDfZwjs4fF6Rfp4hV79QaHQbKiiDfqJS93rORZE8bjKNq248gcoF7waEMCvgRA/oo=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00041.txt.bz2

On 2017-08-24 03:40, Corinna Vinschen wrote:
> On Aug 24 11:32, Corinna Vinschen wrote:
>> On Aug 23 13:25, Brian Inglis wrote:
>>> Cygwin strptime(3) (also strptime(1)) fails with default width, without an
>>> explicit width, because of the test in the following code:
>>>
>>> case 'F':	/* The date as "%Y-%m-%d". */
>>> 	{
>>> 	  LEGAL_ALT(0);
>>> 	  ymd |= SET_YMD;
>>> 	  char *tmp = __strptime ((const char *) bp, "%Y-%m-%d",
>>> 				  tm, era_info, alt_digits,
>>> 				  locale);
>>> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
>>> 	    return NULL;
>>> 	  bp = (const unsigned char *) tmp;
>>> 	  continue;
>>> 	}
>>>
>>> as default width is zero so test fails and returns NULL.
>>>
>>> Simple patch for this as with the other cases supporting width is to change the
>>> test to:
>>>
>>> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
>>>
>>> but this does not properly support [+0] flags or width in the format as
>>> specified by glibc (latest POSIX punts on %F) for compatibility with strftime(),
>>> affecting only the %Y format, supplying %[+0]<w-6>F, to support signed and zero
>>> filled fixed and variable length year fields in %F format.
>>
>> Ok, I admit I didn't understand this fully.  What is '<w-6>'?
>> Can you give a real world example?

Width prefix for %F minus six for "-mm-dd" to get the width for %Y.
Look at POSIX strftime %F handling
	http://pubs.opengroup.org/onlinepubs/9699919799/functions/strftime.html
or
	man 3p strftime | less +/\ F\
for what strftime allows and strptime should handle for symmetry and consistency.

>>> So do you want compatible support or just the quick fix?
>>
>> Quick and then right?  Fixing this in two steps is just as well.
> 
> Btw., FreeBSD's _strptime only calls _strptime recursively, without any
> checks for field width:
> 
>       case 'F':
> 	      buf = _strptime(buf, "%Y-%m-%d", tm, GMTp, locale);
> 	      if (buf == NULL)
> 		      return (NULL);
> 	      flags |= FLAG_MONTH | FLAG_MDAY | FLAG_YEAR;
> 	      break;

As did Cygwin, which just did a goto recurse, before it was changed to support
explicit width. Your call and option to go back and ignore it, patch bug, or
forward and support flags and width based on strftime documentation.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
