Return-Path: <cygwin-patches-return-2893-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20774 invoked by alias); 30 Aug 2002 17:32:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20760 invoked from network); 30 Aug 2002 17:32:22 -0000
Message-ID: <3D6FAC14.5080704@netscape.net>
Date: Fri, 30 Aug 2002 10:32:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <20020830153031.J5475@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00341.txt.bz2

Corinna Vinschen wrote:
> On Fri, Aug 30, 2002 at 05:13:58PM +0400, Egor Duda wrote:
> 
>>It was a typo, sorry. Now, after double-checking, it should read
>>
>>btowc, wctob,
>>mbsinit, mbrlen,
>>mbrtowc, mbstowcs, mbsrtowcs,
>>wcrtomb, wcstombs, wcsrtombs

Corinna,

You forgot to bump the API after you added these remaining 
symbols to cygwin.din.

Cheers,
Nicholas
