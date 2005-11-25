Return-Path: <cygwin-patches-return-5682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11974 invoked by alias); 25 Nov 2005 19:44:00 -0000
Received: (qmail 11964 invoked by uid 22791); 25 Nov 2005 19:44:00 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout06.sul.t-online.com (HELO mailout06.sul.t-online.com) (194.25.134.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 25 Nov 2005 19:43:58 +0000
Received: from fwd28.aul.t-online.de  	by mailout06.sul.t-online.com with smtp  	id 1EfjU9-0006TZ-02; Fri, 25 Nov 2005 20:43:53 +0100
Received: from [10.3.2.2] (TbKoCUZ1Ze-8zwZOnE-3BoMlntv9U7cJ3OMjD0UQZv9nza+Lh2Ircs@[80.137.90.191]) by fwd28.sul.t-online.de 	with esmtp id 1EfjU2-0sPTzk0; Fri, 25 Nov 2005 20:43:46 +0100
Message-ID: <4387696F.9000409@t-online.de>
Date: Fri, 25 Nov 2005 19:44:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
References: <43863896.4080203@t-online.de> <20051125012622.GA12798@trixie.casa.cgf.cx> <1EfYLi-05iS2a0@fwd29.aul.t-online.de> <20051125164139.GD8670@trixie.casa.cgf.cx>
In-Reply-To: <20051125164139.GD8670@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TbKoCUZ1Ze-8zwZOnE-3BoMlntv9U7cJ3OMjD0UQZv9nza+Lh2Ircs
X-TOI-MSGID: bdf87dfa-f2aa-43b0-b1c9-9669d4387a8f
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00024.txt.bz2

Christopher Faylor wrote:

>[...]
>It is (or should be, since I haven't checked it recently) supported if you
>set CYGWIN=tty, though.  There is a lot of functionality that isn't available
>with the normal windows console that is available with CYGWIN=tty.
>

Oh, Yes.

I tested this some time ago and it didn't work as expected, but now it 
works.
Hmm... must have missed something during first test, sorry.


>Since
>the only precedent for the behavior of CTRL-BREAK is MSVCRT, I am very
>reluctant to change it.
>  
>

OK, let's forget the patch ;-)


Christian
