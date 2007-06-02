Return-Path: <cygwin-patches-return-6109-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28159 invoked by alias); 2 Jun 2007 16:11:50 -0000
Received: (qmail 28149 invoked by uid 22791); 2 Jun 2007 16:11:49 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.sul.t-online.com (HELO mailout05.sul.t-online.com) (194.25.134.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 02 Jun 2007 16:11:47 +0000
Received: from fwd28.aul.t-online.de  	by mailout05.sul.t-online.com with smtp  	id 1HuWCe-0005e9-01; Sat, 02 Jun 2007 18:11:44 +0200
Received: from [10.3.2.2] (TEEOxgZDwecWWLSOJQAYzalZIM0VPTwvPl6WwNE6KvZ3c2Qkw+OGZh@[217.235.219.152]) by fwd28.sul.t-online.de 	with esmtp id 1HuWCX-1bfP2u0; Sat, 2 Jun 2007 18:11:37 +0200
Message-ID: <466196BE.30700@t-online.de>
Date: Sat, 02 Jun 2007 16:11:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
References: <466183F3.5020900@t-online.de> <20070602154156.GA19696@ednor.casa.cgf.cx>
In-Reply-To: <20070602154156.GA19696@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TEEOxgZDwecWWLSOJQAYzalZIM0VPTwvPl6WwNE6KvZ3c2Qkw+OGZh
X-TOI-MSGID: 0c36a8e9-f195-4d02-a9e2-6383885274d4
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00055.txt.bz2

Christopher Faylor wrote:
> ...
>   
> Thanks for the problem report and test case but this is pretty clearly
> not the right way to deal with the issue.  Putting a special case catch
> of "./" around a function call which is intended to deal with paths is
> pretty clearly a band-aid.
>   

Yes.


> Let me rephrase the problem:
>
> "cygpath does not properly deal with the current directory"
>
>   

It depends. Removing "./" from a path is usually OK. Except when 
application search should be enabled if a path is missing.

I don't know whether this current behaviour of path.cc:cygpath() is 
required somewhere else
(cygcheck.cc, dump_setup.cc ...).

Thats the reason why I didn't modify cygpath() itself and used this 
(workaround|hack) instead.

Christian
