Return-Path: <cygwin-patches-return-7112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16202 invoked by alias); 22 Sep 2010 05:50:35 -0000
Received: (qmail 16188 invoked by uid 22791); 22 Sep 2010 05:50:32 -0000
X-SWARE-Spam-Status: No, hits=0.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,TW_GF,TW_HG,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 22 Sep 2010 05:50:26 +0000
Received: by fxm7 with SMTP id 7so182700fxm.2        for <cygwin-patches@cygwin.com>; Tue, 21 Sep 2010 22:50:24 -0700 (PDT)
Received: by 10.223.113.71 with SMTP id z7mr4905429fap.3.1285134624336;        Tue, 21 Sep 2010 22:50:24 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id k25sm4039724fac.17.2010.09.21.22.50.22        (version=SSLv3 cipher=RC4-MD5);        Tue, 21 Sep 2010 22:50:23 -0700 (PDT)
Message-ID: <4C999916.7080609@gmail.com>
Date: Wed, 22 Sep 2010 05:50:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de>
In-Reply-To: <20100914093859.GB15121@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00072.txt.bz2

Hi,

 > I'm not exactly concerned about Linux being way faster accessing an NTFS
 > drive.  After all it's the OS itself and comes with it's own NTFS driver
 > which obviously is streamlined for typical POSIX operations.

I did not test & compare to using the Linux NTFS, rather I compared with 
Linux on VMWARE using the same Windows NTFS.SYS (via the same 
kernel32.dll APIs):

Cygwin: "C:/cygwin/bin/ls.exe /bin" -> cygwin1.dll -> kernel32.dll -> 
NTOS kernel -> NTFS.SYS driver -> HD

linux: "/bin/ls /mnt/hgfs/C/cygwin/bin" -> glibc -> linux kernel -> 
VMWARE hgfs driver -> vmware_player.exe (on Win32) ->  kernel32.dll -> 
NTOS kernel -> NTFS.SYS driver -> HD

As you can see the VMWARE path is much longer than Cygwin, and it passes 
the same APIs and NTFS.SYS driver, and yet it executes much faster.

This helps us understand that there is a lot that still can be done in 
Cygwin's filesystem performance.

Yoni


On 14/9/2010 11:38 AM, Corinna Vinschen wrote:
> On Sep 13 13:45, Yoni Londner wrote:
>> Hi,
>>
>>>> Abstract: I prepared a patch that improves Cygwin Filesystem
>>>> performance by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms -->   1.7.5
>>>> patched 120ms). I ported the patch to 1.7.7, did tests, and found
>>>> out that 1.7.7 had a very serious 9x (!) performance degradation
>>>> from 1.7.5 (1.7.5 vanilla 530ms -->   1.7.7 vanilla 3900ms -->   1.7.7
>>>> patched 3500ms), which does makes this patch useless until the
>>>> performance degradation is fixed.
>>>
>>> The problem is, I can't reproduce such a degradation.  If I run sometimg
>>> like `time ls -l /bin>   /dev/null', the times are very slightly better
>>> with 1.7.7 than with 1.7.5 (without caching effect 1200ms vs. 1500ms,
>>> with caching effect 500ms vs. 620ms on average).  Starting with 1.7.6,
>>> Cygwin reused handles from symlink_info::check in stat() and other
>>> syscalls.  If there is such degradation under some circumstances, I need
>>> a reproducible scenario, or at least some strace output which shows at
>>> which point this happens.  Apart from actual patches this should be
>>> discussed on the cygwin-developer list.
>>>
>>
>> First of all, even your results of 1200-1500ms (1st time) and
>> 500-600ms (2nd time) is still way way way too long. On linux with an
>> NTFS mount of C:/cygwin, this took<2ms!
>>
>> And even on Win32 CMD.EXE this same operation will take you less
>> than 100ms. which is 5x to 10x faster.
>>
>> The main reason for the difference: the Windows CMD.EXE does not
>> open file handles, which make the NTFS file system to actually go
>> and read each file's first 16KB of contents (even though you did not
>> ask for it!).
>
> I'm not exactly concerned about Linux being way faster accessing an NTFS
> drive.  After all it's the OS itself and comes with it's own NTFS driver
> which obviously is streamlined for typical POSIX operations.
>
> And then there's Win32 which can go through a dir much faster as well,
> since it doesn't have to care for POSIX compatibility of the result, and
> the OS function calls coincidentally match what a cmd "dir" call needs.
>
> If you're looking for a fair comparision, why don't you look for
> Interix?  I did, and what I see is pretty much the same thing we do in
> Cygwin.  Actually, with the last Cygwin from CVS an ls -lR on a
> non-marginal directory tree is already faster than the same operation
> under Interix.
>
> That doesn't mean I won't look for more ways to enhance Cygwin's
> performance, but it won't be by adding CYGWIN environment switches
> or by neglecting correct information in stat.
>
>
> Corinna
>
