Return-Path: <cygwin-patches-return-6092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11025 invoked by alias); 19 May 2007 10:09:37 -0000
Received: (qmail 10997 invoked by uid 22791); 19 May 2007 10:09:34 -0000
X-Spam-Check-By: sourceware.org
Received: from ug-out-1314.google.com (HELO ug-out-1314.google.com) (66.249.92.168)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 19 May 2007 10:09:23 +0000
Received: by ug-out-1314.google.com with SMTP id j40so549473ugd         for <cygwin-patches@cygwin.com>; Sat, 19 May 2007 03:09:20 -0700 (PDT)
Received: by 10.67.31.17 with SMTP id i17mr1725390ugj.1179569360476;         Sat, 19 May 2007 03:09:20 -0700 (PDT)
Received: from ?88.210.122.164? ( [88.210.122.164])         by mx.google.com with ESMTP id 34sm2600169uga.2007.05.19.03.09.17;         Sat, 19 May 2007 03:09:18 -0700 (PDT)
Message-ID: <464ECCBA.3000700@portugalmail.pt>
Date: Sat, 19 May 2007 10:09:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  	ddrescue  1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx>
In-Reply-To: <20070518194526.GA3586@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00038.txt.bz2

Christopher Faylor escreveu:
> On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>> Hi,
>>
>> Cygwin 1.5.24-2 segfaults on unaligned lseek() on raw block devices with 
>> sector size >512 bytes.
>>
>> Testcases:
>> $ dd skip=1000 bs=2047 if=/dev/scd0 of=/dev/null
>>
>> $ ddrescue -c 1 /dev/scd0 file.iso
>>
>>
>> This is due to a fixed 512 byte buffer in fhandler_dev_floppy::lseek().
>> It is still present in HEAD revision.
>>
>> The attached patch should fix. It should work for any sector size.
>> (Smoke-)tested with 1.5.24-2 (too busy to test with current CVS, sorry).
>>
>> 2007-05-18  Christian Franke <franke@computer.org>
>>
>> 	* fhandler_floppy.cc (fhandler_dev_floppy::lseek): Fixed segfault on
>> 	unaligned seek due to fixed size buffer.
>>
> 
> It seems like this could be done without the heavyweight use of malloc,
> like use an automatic array of length 512 + 4 and calculate an aligned
> address from that.
> 

Or use alloca instead?

-  char buf[512];
+  char *buf = (char *) alloca (512);

Cheers,
Pedro Alves

