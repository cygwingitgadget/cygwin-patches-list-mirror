Return-Path: <cygwin-patches-return-10171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36473 invoked by alias); 3 Mar 2020 20:03:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36463 invoked by uid 89); 3 Mar 2020 20:03:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mailout02.t-online.de
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Mar 2020 20:03:42 +0000
Received: from fwd01.aul.t-online.de (fwd01.aul.t-online.de [172.20.27.147])	by mailout02.t-online.de (Postfix) with SMTP id 8CBD841F4AB8	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2020 21:03:39 +0100 (CET)
Received: from [192.168.178.26] (VUfe2oZpohbggm2tPCNzvtW3ArvW0cfY81TIo-NpIFxLiK7IMOparnL99eewasUwoM@[79.228.65.18]) by fwd01.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j9DlS-15thiq0; Tue, 3 Mar 2020 21:03:38 +0100
Subject: Re: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
To: cygwin-patches@cygwin.com
References: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de> <20200303093535.f27696d9250af844c0eaec52@nifty.ne.jp>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <a4ff7dc0-0e14-28f8-373c-34ab221524ec@t-online.de>
Date: Tue, 03 Mar 2020 20:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303093535.f27696d9250af844c0eaec52@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00277.txt

Am 03.03.2020 um 01:35 schrieb Takashi Yano:

> The second argument DWORD *wn of sendOut() is not used
> outside sendOut(), so it can be covered up like:
> 
> inline void sendOut (HANDLE &handle)
> {
>    DWORD wn;
>    WriteConsoleA (handle, buf, ixput, &wn, 0);
> }
> 

I doubt that will improve much, if anything.  There are still direct 
calls to WriteConsoleA() left, working on other buffers, and those still 
use the DWORD wn defined near the top of 
fhandler_console::char_command().  So that the existing varialbe would 
have to be kept anyway.  That means the variables local to each 
invocation (!) of wpbuf.sendOut would just clutter the stack for no gain.

OTOH the MS documentation calls this DWORD* an "optional output" 
argument.  If I'm reading that right, it means it should be fine to just 
pass NULL to indicate that we don't need it:

inline void sendOut (HANDLE &handle)
{
   WriteConsoleA (handle, buf, ixput, 0, 0);
}

The same would apply to all the other calls of WriteConsoleA, it seems.
