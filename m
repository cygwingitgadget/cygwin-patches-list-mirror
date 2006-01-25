Return-Path: <cygwin-patches-return-5725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31963 invoked by alias); 25 Jan 2006 21:38:15 -0000
Received: (qmail 31953 invoked by uid 22791); 25 Jan 2006 21:38:14 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.sul.t-online.com (HELO mailout05.sul.t-online.com) (194.25.134.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 25 Jan 2006 21:38:13 +0000
Received: from fwd30.aul.t-online.de  	by mailout05.sul.t-online.com with smtp  	id 1F1sLC-0000mQ-0B; Wed, 25 Jan 2006 22:38:10 +0100
Received: from [10.3.2.2] (Gtx8AsZrYeVQbCgLKcfMmVheCmE7mvF06mbXXDFS5h7lAAJ0yk-kos@[80.137.88.190]) by fwd30.sul.t-online.de 	with esmtp id 1F1sL5-1FK2eO0; Wed, 25 Jan 2006 22:38:03 +0100
Message-ID: <43D7EFBE.5010505@t-online.de>
Date: Wed, 25 Jan 2006 21:38:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu>
In-Reply-To: <Pine.GSO.4.63.0601250907210.2078@access1.cims.nyu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: Gtx8AsZrYeVQbCgLKcfMmVheCmE7mvF06mbXXDFS5h7lAAJ0yk-kos
X-TOI-MSGID: deec136f-1196-4c23-8e54-68396ee587bf
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00034.txt.bz2

Igor Peshansky wrote:

>>[snip]
>>    
>>
>
>I wonder if it would be better to use stdin/stdout for binary data (or
>even add a -f option for set).  IMHO,
>
>regtool -b get KEY1\\VALUE | regtool -b set KEY2\\VALUE
>
>or
>
>regtool -b get KEY1\\VALUE | regtool -b set -f - KEY2\\VALUE
>
>looks cleaner than storing the hex encoding into a string...  
>

At least when regtool is used interactively, it is IMO not very useful 
to have
modem-line-noise-like output for REG_BINARY, but human readable output for
the other value types.
But this is the current behavior of "regtool get ...".


Suggest to combine the best of both worlds:

regtool get KEY\\VALUE

should always produce human readable output, in particular a hex dump
for REG_BINARY.
(But this would change existing behavior on REG_BINARY)


regtool -b get KEY\\VALUE

writes REG_BINARY as binary data to stdout.


regtool -b set KEY\\VALUE 01 02 03

sets REG_BINARY value from hex bytes in args.


regtool -b set KEY\\VALUE -

set value from binary data read from stdin


>[...]
>
>
>That said, I also think this functionality would be very useful.
>  
>

Thx,

Christian
