Return-Path: <cygwin-patches-return-8971-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16526 invoked by alias); 15 Dec 2017 14:16:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16506 invoked by uid 89); 15 Dec 2017 14:16:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=abroad, H*Ad:U*corinna, eyes, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 15 Dec 2017 14:16:07 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id A240D721E280D	for <cygwin-patches@cygwin.com>; Fri, 15 Dec 2017 15:16:02 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 4A9FC5E038B	for <cygwin-patches@cygwin.com>; Fri, 15 Dec 2017 15:16:02 +0100 (CET)
Received: from [192.168.131.2] (unknown [192.168.131.2])	by calimero.vinschen.de (Postfix) with ESMTP id 61EBBA80348	for <cygwin-patches@cygwin.com>; Fri, 15 Dec 2017 15:16:02 +0100 (CET)
Date: Fri, 15 Dec 2017 14:16:00 -0000
User-Agent: K-9 Mail for Android
In-Reply-To: <Pine.BSF.4.63.1712141707080.37987@m0.truegem.net>
References: <20171214065430.4500-1-mark@maxrnd.com> <20171214130348.GA24531@calimero.vinschen.de> <Pine.BSF.4.63.1712141707080.37987@m0.truegem.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Implement sigtimedwait
To: cygwin-patches@cygwin.com
From: Corinna Vinschen <corinna@vinschen.de>
Message-ID: <57C240C1-A67A-4783-97F1-EBCAD68C4464@vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00101.txt.bz2

On 15 December 2017 02:09:42 GMT+01:00, Mark Geisert <mark@maxrnd.com> wrot=
e:
>On Thu, 14 Dec 2017, Corinna Vinschen wrote:
>> Hi Mark,
>>
>> Thanks for sigtimedwait!  Two questions:
>>
>> On Dec 13 22:54, Mark Geisert wrote:
>>> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
>>> index 69c5e2aad..0599d8a3e 100644
>>> --- a/winsup/cygwin/signal.cc
>>> +++ b/winsup/cygwin/signal.cc
>>> [...]
>>> +	}
>>> +      cwaittime.QuadPart =3D (LONGLONG) timeout->tv_sec * NSPERSEC
>>> +                          + ((LONGLONG) timeout->tv_nsec + 99LL) /
>100LL;
>>> +    }
>>> +
>>> +  return sigwait_common (set, info, timeout ? &cwaittime :
>cw_infinite);
>>
>> Would you mind to change the name of cwaittime to waittime
>throughout?
>> The leading "cw" actually puzzeled me for a while since I
>misinterpreted
>> it as one of the cw_* constants.  No idea if it's just my bad eyes,
>but
>> dropping the leading c might raise readability a bit.
>
>I don't mind.  What I was attempting to communicate with "cwaittime"
>was a=20
>wait time in "cygwait units" of 100ns.  But I wasn't happy with it
>either.
>
>Revised patch correcting both points is on its way.
>Thanks much,
>
>..mark

Hi Mark,

thanks that looks good.  I'm abroad today so pushing this will have to wait=
 'til Monday.

In terms of the name, it was clear what you meant.  It was just a minor thi=
ng, I was just puzzled a bit while reading the patch so i thought it might =
be better distinguishable without the leading c.

Thanks,
Corinna
