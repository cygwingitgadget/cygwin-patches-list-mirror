Return-Path: <cygwin-patches-return-2912-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18376 invoked by alias); 2 Sep 2002 11:01:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18358 invoked from network); 2 Sep 2002 11:01:17 -0000
Message-ID: <3D7344EC.1020701@netscape.net>
Date: Mon, 02 Sep 2002 04:01:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <20020830153031.J5475@cygbert.vinschen.de> <3D6FAC14.5080704@netscape.net> <20020902124941.J12899@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00360.txt.bz2

Corinna Vinschen wrote:

>On Fri, Aug 30, 2002 at 01:32:04PM -0400, Nicholas Wourms wrote:
>
>>Corinna Vinschen wrote:
>>
>>>On Fri, Aug 30, 2002 at 05:13:58PM +0400, Egor Duda wrote:
>>>
>>>
>>>>It was a typo, sorry. Now, after double-checking, it should read
>>>>
>>>>btowc, wctob,
>>>>mbsinit, mbrlen,
>>>>mbrtowc, mbstowcs, mbsrtowcs,
>>>>wcrtomb, wcstombs, wcsrtombs
>>>>
>>Corinna,
>>
>>You forgot to bump the API after you added these remaining 
>>symbols to cygwin.din.
>>
>
>Not this time.  I didn't bump it since the additions where within a
>few minutes.
>
Well for some reason, the don't-forget-to-bump-the-api thingy (Egor's 
script) came into action while trying to compile, causing the build to 
fail unless I bumped the api.  Perhaps this has to do with the fact that 
I'm compiling from a branch(cygdaemon-branch) rather then HEAD?

Cheers,
Nicholas
