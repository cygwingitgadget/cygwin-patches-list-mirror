Return-Path: <cygwin-patches-return-6090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8880 invoked by alias); 18 May 2007 20:23:53 -0000
Received: (qmail 8867 invoked by uid 22791); 18 May 2007 20:23:52 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout03.sul.t-online.com (HELO mailout03.sul.t-online.com) (194.25.134.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 18 May 2007 20:23:50 +0000
Received: from fwd30.aul.t-online.de  	by mailout03.sul.t-online.com with smtp  	id 1Hp8zK-0006VX-02; Fri, 18 May 2007 22:23:46 +0200
Received: from [10.3.2.2] (TETUsEZH8ed2-Watq+GdDjRcy1OTzUIQuRswLh1dEOC6QKVLruIJ0L@[217.235.243.100]) by fwd30.sul.t-online.de 	with esmtp id 1Hp8zA-0EdALQ0; Fri, 18 May 2007 22:23:36 +0200
Message-ID: <464E0B4D.8020602@t-online.de>
Date: Fri, 18 May 2007 20:23:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  	ddrescue  1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx>
In-Reply-To: <20070518194526.GA3586@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TETUsEZH8ed2-Watq+GdDjRcy1OTzUIQuRswLh1dEOC6QKVLruIJ0L
X-TOI-MSGID: 084f1fec-0c51-4d22-ae8c-774bc851b71d
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00036.txt.bz2

Christopher Faylor wrote:
> On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>   
>> ...
>>
>>
>>     
>
> It seems like this could be done without the heavyweight use of malloc,
> like use an automatic array of length 512 + 4 and calculate an aligned
> address from that.
>   

Sorry, no. "unaligned seek" does not refer to memory here.

It should mean "seek position not aligned to raw device sector size".
This is 2048 for CD/DVD and results in a segfault.
Windows may even report larger sizes in DISK_GEOMETRY_EX.BytesPerSector.

Possible slow speed in the unaligned case is IMO a minor issue .
For maximum speed, the related tools like dd can easily be configured to 
read (a multiple of) sector size.

Christian
