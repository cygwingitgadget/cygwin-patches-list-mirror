Return-Path: <cygwin-patches-return-5684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10905 invoked by alias); 25 Nov 2005 20:34:49 -0000
Received: (qmail 10894 invoked by uid 22791); 25 Nov 2005 20:34:47 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout09.sul.t-online.com (HELO mailout09.sul.t-online.com) (194.25.134.84)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 25 Nov 2005 20:34:45 +0000
Received: from fwd28.aul.t-online.de  	by mailout09.sul.t-online.com with smtp  	id 1EfkHL-0003vH-00; Fri, 25 Nov 2005 21:34:43 +0100
Received: from [10.3.2.2] (EZMfnZZOYexytL9xX4a3agXUJqSatJC30aTMTnCgkC7veYH2cZel8Y@[80.137.90.191]) by fwd28.sul.t-online.de 	with esmtp id 1EfkH4-295wf20; Fri, 25 Nov 2005 21:34:26 +0100
Message-ID: <43877550.8090602@t-online.de>
Date: Fri, 25 Nov 2005 20:34:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Allow to send SIGQUIT via Ctrl+BREAK (patch included)
References: <43863896.4080203@t-online.de> <20051125012622.GA12798@trixie.casa.cgf.cx> <1EfYLi-05iS2a0@fwd29.aul.t-online.de> <20051125164139.GD8670@trixie.casa.cgf.cx> <4387696F.9000409@t-online.de> <20051125195256.GA11390@trixie.casa.cgf.cx>
In-Reply-To: <20051125195256.GA11390@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EZMfnZZOYexytL9xX4a3agXUJqSatJC30aTMTnCgkC7veYH2cZel8Y
X-TOI-MSGID: d31fb8d3-3845-4677-91c5-d0e5b829726e
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2005-q4/txt/msg00026.txt.bz2

Christopher Faylor wrote:

>On Fri, Nov 25, 2005 at 08:43:43PM +0100, Christian Franke wrote:
>  
>
>>OK, let's forget the patch ;-)
>>    
>>
>
>Actually, I have done some more testing myself and Windows doesn't work
>the way that I remembered.  It seems like CTRL-BREAK isn't handled by
>signal(SIGINT, ...).  So, I was wrong about this.
>

MSVCRT maps CTRL-C to SIGINT, CTRL-BREAK to an extra SIGBREAK.
So it is possible to map this to SIGQUIT with a simple hack:

#ifdef SIGBREAK
#undef SIGQUIT
#define SIGQUIT SIGBREAK
#endif

This isn't possible with Cygwin (in notty mode), because CTRL-C and 
CTRL-BREAK cannot be distinguished.

>I really should have
>tested how it worked before rejecting your patch out of hand.
>  
>

N.P. ;-)


>So, this code is probably just reflecting my misperceptions of what
>Windows was doing.  I'll add your patch as it improves Cygwin's
>functionality.
>  
>

Thanks!

Christian
