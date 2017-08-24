Return-Path: <cygwin-patches-return-8834-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11492 invoked by alias); 23 Aug 2017 19:25:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10595 invoked by uid 89); 23 Aug 2017 19:25:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 23 Aug 2017 19:25:27 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id kbHId38eDDJTWkbHJdn2EA; Wed, 23 Aug 2017 13:25:25 -0600
X-Authority-Analysis: v=2.2 cv=B4DJ6KlM c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=IkcTkHD0fZMA:10 a=o2A5A5UTUE4NVVSS9SoA:9 a=QEXdDO2ut3YA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca>
Date: Thu, 24 Aug 2017 09:40:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAG+EwtMmeGyvNTFkQ3W74eZ6Wiuw0K5RPFmkganVO6QjQQbSwP311b/xGuuRFSFliSFBoUGEW3VsV0nmfUzi3kV64YnL0gF8f1ajrDs3AC7l2BxV+2m XfFif9Zq8kAVqPhU43uxoXroKYCWA33KAUuLfRlTyAh/CtEixOPJzpunprAqckJ0HyAfXMlgJYCrmepZd0U3im//jt8QPC8fFzY=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00036.txt.bz2

On 2017-08-23 12:51, Brian Inglis wrote:
> On 2017-07-23 22:07, Brian Inglis wrote:
>> On 2017-07-23 20:09, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
>>>> But that's just scanning a decimal integer to time_t.
>>> It's not a question of whether I can or can't convert a string into an 
>>> integer, rather it's a question about portability of code that uses %s
>>> for both functions and expects it to work unchanged in the Cygwin
>>> environment.
>>> Also, strptime() was designed to be a reversal to strftime() (from the 
>>> man-pages: the strptime() function is the converse function to
>>> strftime(3)) so both are supposed to "understand" the same basic set of
>>> formats. Because of Cygwin's strptime() missing "%s", the following also
>>> does not work even from command line:
>>> $ date +"%s" | strptime "%s"
> Testing revealed a separate issue with %F format which I will follow up on in
> a different thread.
Actually same thread, different subject.

Cygwin strptime(3) (also strptime(1)) fails with default width, without an
explicit width, because of the test in the following code:

case 'F':	/* The date as "%Y-%m-%d". */
	{
	  LEGAL_ALT(0);
	  ymd |= SET_YMD;
	  char *tmp = __strptime ((const char *) bp, "%Y-%m-%d",
				  tm, era_info, alt_digits,
				  locale);
	  if (tmp && (uint) (tmp - (char *) bp) > width)
	    return NULL;
	  bp = (const unsigned char *) tmp;
	  continue;
	}

as default width is zero so test fails and returns NULL.

Simple patch for this as with the other cases supporting width is to change the
test to:

	  if (tmp && width && (uint) (tmp - (char *) bp) > width)

but this does not properly support [+0] flags or width in the format as
specified by glibc (latest POSIX punts on %F) for compatibility with strftime(),
affecting only the %Y format, supplying %[+0]<w-6>F, to support signed and zero
filled fixed and variable length year fields in %F format.

So do you want compatible support or just the quick fix?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
