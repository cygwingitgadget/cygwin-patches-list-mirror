Return-Path: <cygwin-patches-return-5913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1734 invoked by alias); 6 Jul 2006 00:24:12 -0000
Received: (qmail 1722 invoked by uid 22791); 6 Jul 2006 00:24:11 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Jul 2006 00:24:09 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id JAA16652; 	Thu, 6 Jul 2006 09:24:06 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k660O6d17515; 	Thu, 6 Jul 2006 09:24:06 +0900
Message-ID: <44AC584F.1050408@oki.com>
Date: Thu, 06 Jul 2006 00:24:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
References: <44A0C650.6060001@oki.com> <20060627055956.GA30923@trixie.casa.cgf.cx>
In-Reply-To: <20060627055956.GA30923@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00008.txt.bz2

Christopher Faylor wrote:
> On Tue, Jun 27, 2006 at 02:46:56PM +0900, SUZUKI Hisao wrote:
>> # I should have posted this message to this list from the first.
>>
>> I made a patch to cygwin1.dll to support UTF-8.
>>
>> It allows you to use all of characters and file (or path) names
>> allowed in Windows, while keeping binary-compatibility with the
>> current Cygwin.  It is fairly perfect except for lack of locale
>> support etc.  So it may remind you of the good old BeOS.  See:
>>
>> http://www.okisoft.co.jp/esc/utf8-cygwin/
> 
> Yes, we heard.
> 
> The contribution guidelines are here:
> 
> http://cygwin.com/contrib.html
> 
> We'd appreciate if you could give them a look and use them as the basis
> for your contribution.  The first step is that you'll need to fill out
> an assignment form.
> 
> cgf

Yes, I have filled out the assignment form and have sent it to Red
Hat.  I hope you can adopt and adapt the patch without any legal
fears now ;-).


P.S.

Based on Cygwin 1.5.20-1, I have updated the UTF-8 patch.

In fact, I have just "diff -c"'ed the old ones and have patch'ed the
results to cygwin-1.5.20-1-src, except for sys_wcstombs() in
miscfuncs.cc.  Its definition differs from what is in cygwin-1.5.19-4.
I have just done a few lines of tweaks on it.

Though I have not looked into the details yet, it seems working fine.
Please try it:

http://www.okisoft.co.jp/esc/utf8-cygwin/

-- SUZUKI Hisao
