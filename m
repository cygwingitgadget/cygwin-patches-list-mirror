Return-Path: <cygwin-patches-return-8843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14485 invoked by alias); 29 Aug 2017 17:57:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14435 invoked by uid 89); 29 Aug 2017 17:57:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=w6, H*Ad:D*ab.ca, invest, Attached
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 29 Aug 2017 17:56:58 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with SMTP	id mkkxdDKqI8LPZmkkydy6RT; Tue, 29 Aug 2017 11:56:56 -0600
X-Authority-Analysis: v=2.2 cv=e552ceh/ c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=r77TgQKjGQsHNAKrUKIA:9 a=OCiNEaIkcPi8lqH4MFsA:9 a=QEXdDO2ut3YA:10 a=7vT8eNxyAAAA:8 a=Oy6YgKlgl6jR6k9gOZMA:9 a=CdiWusdWvyIA:10 a=Mzmg39azMnTNyelF985k:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: winsup/cygwin/libc/strptime.cc(__strptime) strptime %F issue
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca> <f0595b42-8982-f192-9f60-f559d4de3879@SystematicSw.ab.ca> <20170824093255.GI7469@calimero.vinschen.de> <20170824094028.GK7469@calimero.vinschen.de> <7d34bb5d-ecc3-4593-32ed-b3f69c680260@SystematicSw.ab.ca> <20170825094756.GN7469@calimero.vinschen.de> <20170829073520.GI16010@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <04edcc3e-3270-5a0b-14b8-cddaa80e006f@SystematicSw.ab.ca>
Date: Wed, 30 Aug 2017 13:07:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170829073520.GI16010@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------F9740A478F32883F8CF74303"
X-CMAE-Envelope: MS4wfPFCOI3MkgW3PWO/XpnAEsOWPpT217v4gfYaurpZnkcmLOh71662DjfIMyuFteiCIoRjROEscTHuWMpOPxoSgo8sLKQOOysSwHxdU/y3Jdfv2NlJ33pP zG95KIRmXrJOIO3KDkYkG5XKS+i7kciBJ+1CFnnP0Sx5MluZRQMrmPhpwQEjGmMhAThi1vHZp3/JvejEgquGC6lPhmCx5xz9cYw=
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00045.txt.bz2

This is a multi-part message in MIME format.
--------------F9740A478F32883F8CF74303
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 2541

On 2017-08-29 01:35, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Aug 25 11:47, Corinna Vinschen wrote:
>> On Aug 24 11:11, Brian Inglis wrote:
>>> On 2017-08-24 03:40, Corinna Vinschen wrote:
>>>> On Aug 24 11:32, Corinna Vinschen wrote:
>>>>> On Aug 23 13:25, Brian Inglis wrote:
>>>>>> Cygwin strptime(3) (also strptime(1)) fails with default width, without an
>>>>>> explicit width, because of the test in the following code:
>>>>>>
>>>>>> case 'F':	/* The date as "%Y-%m-%d". */
>>>>>> 	{
>>>>>> 	  LEGAL_ALT(0);
>>>>>> 	  ymd |= SET_YMD;
>>>>>> 	  char *tmp = __strptime ((const char *) bp, "%Y-%m-%d",
>>>>>> 				  tm, era_info, alt_digits,
>>>>>> 				  locale);
>>>>>> 	  if (tmp && (uint) (tmp - (char *) bp) > width)
>>>>>> 	    return NULL;
>>>>>> 	  bp = (const unsigned char *) tmp;
>>>>>> 	  continue;
>>>>>> 	}
>>>>>>
>>>>>> as default width is zero so test fails and returns NULL.
>>>>>>
>>>>>> Simple patch for this as with the other cases supporting width is to change the
>>>>>> test to:
>>>>>>
>>>>>> 	  if (tmp && width && (uint) (tmp - (char *) bp) > width)
>>>>>>
>>>>>> but this does not properly support [+0] flags or width in the format as
>>>>>> specified by glibc (latest POSIX punts on %F) for compatibility with strftime(),
>>>>>> affecting only the %Y format, supplying %[+0]<w-6>F, to support signed and zero
>>>>>> filled fixed and variable length year fields in %F format.
>>>> Btw., FreeBSD's _strptime only calls _strptime recursively, without any
>>>> checks for field width:
>>> As did Cygwin, which just did a goto recurse, before it was changed to support
>>> explicit width. Your call and option to go back and ignore it, patch bug, or
>>> forward and support flags and width based on strftime documentation.
>>
>> Well, I guess it depends on how much time you're willing to invest here.
>> If you're inclined to fix this per POSIX, you're welcome, of course.
> 
> My vacation is approaching, so I'd like to get out the 2.9.0 release
> next week.  Naturally I wonder if and how you're proceeding on this
> issue.  Would it make sense, perhaps, if you just send the quick fix
> so we can get 2.9.0 out?
Attached - got diverted during strptime testing due to time functions gmtime,
localtime, mktime, strftime not properly handling struct tm->tm_year == INT_MAX
=> year == INT_MAX + 1900 so year needs to be at least long in Cygwin 64, also
affecting tzcalc_limits, and depending on what is required to properly handle
time_t in Cygwin 32.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

--------------F9740A478F32883F8CF74303
Content-Type: text/plain; charset=UTF-8;
 name="0001-winsup-cygwin-libc-strptime.cc-__strptime-fix-F-width.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-winsup-cygwin-libc-strptime.cc-__strptime-fix-F-width.p";
 filename*1="atch"
Content-length: 1448

RnJvbSAxOWEzYzIwYzcwNWE1NzZmZWUwZjBlNzFhMzFmMGMzYWM1NTNlNjEy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCcmlhbiBJbmdsaXMg
PEJyaWFuLkluZ2xpc0BTeXN0ZW1hdGljU1cuYWIuY2E+CkRhdGU6IFR1ZSwg
MjkgQXVnIDIwMTcgMTE6MjU6NDMgLTA2MDAKU3ViamVjdDogW1BBVENIXSB3
aW5zdXAvY3lnd2luL2xpYmMvc3RycHRpbWUuY2MoX19zdHJwdGltZSkgZml4
ICVGIHdpZHRoCgotLS0KIHdpbnN1cC9jeWd3aW4vbGliYy9zdHJwdGltZS5j
YyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
bGliYy9zdHJwdGltZS5jYyBiL3dpbnN1cC9jeWd3aW4vbGliYy9zdHJwdGlt
ZS5jYwppbmRleCA3YzZjYzIwMjQuLjA4MWFjYTM4NSAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9saWJjL3N0cnB0aW1lLmNjCisrKyBiL3dpbnN1cC9j
eWd3aW4vbGliYy9zdHJwdGltZS5jYwpAQCAtNDEzLDEzICs0MTMsMTUgQEAg
bGl0ZXJhbDoKIAkJY2FzZSAnRic6CS8qIFRoZSBkYXRlIGFzICIlWS0lbS0l
ZCIuICovCiAJCQl7CiAJCQkgIExFR0FMX0FMVCgwKTsKLQkJCSAgeW1kIHw9
IFNFVF9ZTUQ7CiAJCQkgIGNoYXIgKnRtcCA9IF9fc3RycHRpbWUgKChjb25z
dCBjaGFyICopIGJwLCAiJVktJW0tJWQiLAogCQkJCQkJICB0bSwgZXJhX2lu
Zm8sIGFsdF9kaWdpdHMsCiAJCQkJCQkgIGxvY2FsZSk7Ci0JCQkgIGlmICh0
bXAgJiYgKHVpbnQpICh0bXAgLSAoY2hhciAqKSBicCkgPiB3aWR0aCkKKwkJ
CSAgLyogd2lkdGggbWF4IGNoYXJzIGNvbnZlcnRlZCwgZGVmYXVsdCAxMCwg
PCA2ID0+IDYgKi8KKwkJCSAgaWYgKHRtcCAmJiAoY2hhciAqKSBicCArCisJ
CQkJKCF3aWR0aCA/IDEwIDogd2lkdGggPCA2ID8gNiA6IHdpZHRoKSA8IHRt
cCkKIAkJCSAgICByZXR1cm4gTlVMTDsKIAkJCSAgYnAgPSAoY29uc3QgdW5z
aWduZWQgY2hhciAqKSB0bXA7CisJCQkgIHltZCB8PSBTRVRfWU1EOwogCQkJ
ICBjb250aW51ZTsKIAkJCX0KIAotLSAKMi4xNC4xCgo=

--------------F9740A478F32883F8CF74303--
