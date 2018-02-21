Return-Path: <cygwin-patches-return-9029-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122071 invoked by alias); 21 Feb 2018 21:56:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122061 invoked by uid 89); 21 Feb 2018 21:56:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=Hx-languages-length:1653, para, claims, HTo:U*cygwin-patches
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Feb 2018 21:56:30 +0000
Received: from [192.168.1.100] ([24.64.240.204])	by shaw.ca with ESMTP	id ocNHe9ShELkozocNIes545; Wed, 21 Feb 2018 14:56:28 -0700
X-Authority-Analysis: v=2.3 cv=OeS28CbY c=1 sm=1 tr=0 a=MVEHjbUiAHxQW0jfcDq5EA==:117 a=MVEHjbUiAHxQW0jfcDq5EA==:17 a=N659UExz7-8A:10 a=b4eMD0GmHX_ZvWjD-W0A:9 a=pILNOxqGKmIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <dbe0ccb9-4752-cd76-e90b-8d88b5899302@SystematicSw.ab.ca>
Date: Wed, 21 Feb 2018 21:56:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221213714.GB7576@calimero.vinschen.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPqOVP5qUXnBfAmjx8hOQSLLY6DkYeum2V9YODwt+b//k0BPFXZ1m4dqFlu1ijaebMuspM6m4Gnkvp3i7PnteZWZOQ2tFp4LblVXZyMNdfjkH5P6XUra Ra4iDAOVwbe8ljEjPvO+Yd5u/8l5k+Gi+z9ZeMypTMKYMoM11WsrnzeSY5vkoXtJ1tnCaap1HKtVh1ansY9QihCiT8FcBBlk1N0=
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00037.txt.bz2

On 2018-02-21 14:37, Corinna Vinschen wrote:
> On Feb 21 14:20, Brian Inglis wrote:
>> On 2018-02-21 14:05, Corinna Vinschen wrote:
>>> Hi David,
>>>
>>> On Feb 21 18:09, David Macek wrote:
>>>> ---
>>>>  winsup/doc/ntsec.xml | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
>>>> index df1d54930..03293591b 100644
>>>> --- a/winsup/doc/ntsec.xml
>>>> +++ b/winsup/doc/ntsec.xml
>>>> @@ -914,7 +914,7 @@ This is not valid:
>>>>  </screen>
>>>>  <para>
>>>> -Apart from this restriction, the reminder of the line can have as
>>>> +Apart from this restriction, the remainder of the line can have as
>>>>  many spaces and TABs as you like.
>>>>  </para>
>>>> -- 
>>>> 2.16.2.windows.1
>>>
>>> The patch is malformed.  It claims to contain 7 lines (6 lines context,
>>> one line changed), but actually it has only 4 lines context.  Please
>>> check your git settings.
>>
>> "It's an een-justice!" -- Calimero
>> Check your mail client blank line squishing settings; I see:
> 
> I'm using mutt which is usually sticks to the original.  I checked again
> and when looking into the message with vi I see this:
> 
>   </screen>
> =20=20
>   <para>
> [...]
>   </para>
> =20=20
> 
> Why are the spaces decodes as =20 in these two lines?
> 
> In theory the decode-copy command should retain the empty lines
> and it did so before.  Why not now?!?

I see exactly the same in TB view source, but the message appears as expected.
I can see why you strenuously request git format-patch/send-email attachments ;^>

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
