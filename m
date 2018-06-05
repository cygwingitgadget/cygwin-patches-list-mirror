Return-Path: <cygwin-patches-return-9083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40225 invoked by alias); 5 Jun 2018 13:35:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39224 invoked by uid 89); 5 Jun 2018 13:35:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:4.77, Manager, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 13:35:13 +0000
X-IPAS-Result: =?us-ascii?q?A2HkAQA5kRZb/+shHKxVBAMaAQEBAQECAQEBAQgBAQEBiUS?= =?us-ascii?q?WQSmWQwuEbAKCQjcVAQIBAQEBAQECAgKBEIUrAQUjZgsYAgImAgJJAQ0TCAEBg?= =?us-ascii?q?x6pEYIchFiDaIFogQuJSoEPJIJohGA0JgWCNIJUAowujEAHAoFnjHaHeoUmkR+?= =?us-ascii?q?BV4F1cIMUgh8XjhmNaCmCHgEB?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2018 15:34:54 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1fQC6w-0001AW-07; Tue, 05 Jun 2018 15:34:54 +0200
Subject: Re: [PATCH RFC] fork: remove cygpid.N sharedmem on fork failure
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
References: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com>
Message-ID: <418776af-0c7f-af74-6a4f-67e504c7f857@ssi-schaefer.com>
Date: Tue, 05 Jun 2018 13:35:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f45c9bb0-eb52-803f-ee42-1fc52725f3b1@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2018-q2/txt/msg00040.txt.bz2


On 06/05/2018 03:05 PM, Michael Haubenwallner wrote:
> Hi,
> 
> I'm using attached patch for a while now, and orphan cygpid.N shared memory
> instances are gone for otherwise completely unknown windows process ids.
> 
> However, I do see defunct processes now which's PPID does not exist (any more),
> causing the same trouble because their windows process handle is closed but
> their cygpid.N shmem handle is not.
> 
> For example, there is no PID 1768 anywhere, although it is the parent of both
> the <defunct> processes:
> $ ps -e
>       PID    PPID    PGID     WINPID   TTY         UID    STIME COMMAND
>      2416       1    1496       2416  ?         197610   May 25 /usr/bin/python2.7
>       560       1     560        560  ?         197613   May 25 /usr/bin/cygrunsrv
>      2348       1    2348       2348  ?         197612   May 25 /usr/bin/cygrunsrv
>      1132       1    1132       1132  ?         197612   May 16 /usr/bin/cygrunsrv
>       440    2028     440        740  pty0      197609   May 29 /tools/haubi/gentoo/test/usr/bin/bash
>      3664    1768    3612       3664  ?         197610 12:25:01 /usr/bin/python2.7 <defunct>
>      2852    2704    2852       2364  ?         197612   May 25 /usr/sbin/sshd
>      2268     560    2268       2128  ?         197613   May 25 /usr/libexec/sendmail
>      2968    1768    3612       1500  ?         197610 12:25:01 /usr/bin/tail <defunct>
> S    2832     512    2832       2312  pty0      197609 10:57:51 /usr/bin/vim
>      2028    2852    2028       2000  pty0      197609   May 25 /usr/bin/bash
>      1164    1132    1164       1256  ?         197612   May 16 /usr/sbin/cron
>       512     440     512       1544  pty0      197609   May 29 /tools/haubi/gentoo/test/usr/bin/bash
>      3264     512    3264       1488  pty0      197609 12:43:35 /usr/bin/ps
>      2704    2348    2704       2856  ?         197612   May 25 /usr/sbin/sshd
> 
> That missing 1768 process for sure was started as (grand) children of 2416.
> 
> Problem is again that another fork'ed child processes with PID 1768, 2968, 3612
> and probably others fail to initialize.
> 
> But I have no idea whether attached patch is causing or uncovering this issue...
> 
> Any idea?

In the Windows Task Manager Details I can see these 4 processes:

PID   Name    Status     Description
1988  sh.exe  Suspended  sh.exe
2968  sh.exe  Suspended  sh.exe
3612  sh.exe  Suspended  sh.exe
3640  sh.exe  Suspended  sh.exe

But removing them from within the Task Manager does not change above ps output.
Interesting enough, leaving PID 440 and 512 seemed to release the defunct processes.

-- 
/haubi/
