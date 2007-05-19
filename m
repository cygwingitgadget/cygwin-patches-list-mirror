Return-Path: <cygwin-patches-return-6094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28245 invoked by alias); 19 May 2007 16:29:48 -0000
Received: (qmail 28229 invoked by uid 22791); 19 May 2007 16:29:47 -0000
X-Spam-Check-By: sourceware.org
Received: from ug-out-1314.google.com (HELO ug-out-1314.google.com) (66.249.92.168)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 19 May 2007 16:29:38 +0000
Received: by ug-out-1314.google.com with SMTP id j40so591377ugd         for <cygwin-patches@cygwin.com>; Sat, 19 May 2007 09:29:36 -0700 (PDT)
Received: by 10.66.242.5 with SMTP id p5mr1959364ugh.1179592175932;         Sat, 19 May 2007 09:29:35 -0700 (PDT)
Received: from ?62.169.93.183? ( [62.169.93.183])         by mx.google.com with ESMTP id 34sm2934678uga.2007.05.19.09.29.32;         Sat, 19 May 2007 09:29:34 -0700 (PDT)
Message-ID: <464F25DB.3030105@portugalmail.pt>
Date: Sat, 19 May 2007 16:29:00 -0000
From: Pedro Alves <pedro_alves@portugalmail.pt>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Christian Franke <Christian.Franke@t-online.de>
CC: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]   ddrescue  1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de>
In-Reply-To: <464EE7C1.3000709@t-online.de>
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
X-SW-Source: 2007-q2/txt/msg00040.txt.bz2

Christian Franke escreveu:
> Pedro Alves wrote:
>> Christopher Faylor escreveu:
>>> On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>>>> Hi,
>>>>
>>>> Cygwin 1.5.24-2 segfaults on unaligned lseek() on raw block devices 
>>>> with sector size >512 bytes.
>>>>
>>>> Testcases:
>>>> $ dd skip=1000 bs=2047 if=/dev/scd0 of=/dev/null
>>>>
>>>> $ ddrescue -c 1 /dev/scd0 file.iso
>>>>
>>>>
>>>> This is due to a fixed 512 byte buffer in fhandler_dev_floppy::lseek().
>>>> It is still present in HEAD revision.
>>>>
>>>> The attached patch should fix. It should work for any sector size.
>>>> (Smoke-)tested with 1.5.24-2 (too busy to test with current CVS, 
>>>> sorry).
>>>>
>>>> 2007-05-18  Christian Franke <franke@computer.org>
>>>>
>>>>     * fhandler_floppy.cc (fhandler_dev_floppy::lseek): Fixed 
>>>> segfault on
>>>>     unaligned seek due to fixed size buffer.
>>>>
>>>
>>> It seems like this could be done without the heavyweight use of malloc,
>>> like use an automatic array of length 512 + 4 and calculate an aligned
>>> address from that.
>>>
>>
>> Or use alloca instead?
>>
>> -  char buf[512];
>> +  char *buf = (char *) alloca (512);
>>
> 
> Yes, thanks.
> 
> Makes the new patch really simple, see attachment.
> 

Actually, I also thought you were talking about memory alignment,
and since alloca has the same alignment guaranties as malloc, it would
avoid doing the + 4 + alignment calc.

I'm just looking at fhandler_floopy.cc for the first time,
but, isn't there the possibility that bytes_left can be a bit too big
for alloca?  It looks like that the raw_read call is there to
advance the position by the needed amount (moving back is forbidden
a bit above).  Perhaps it would be better to read in a loop with
read amount limited by the size of the buffer:

while more bytes
do
     read minimum of bytes left or size of buffer
     if couldn't read, bail out. (oooops internal state broken now).
done

Cheers,
Pedro Alves

