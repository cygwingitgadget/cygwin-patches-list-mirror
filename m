Return-Path: <cygwin-patches-return-4738-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31986 invoked by alias); 9 May 2004 15:12:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31956 invoked from network); 9 May 2004 15:12:40 -0000
Message-Id: <3.0.5.32.20040509110941.007fc4b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 09 May 2004 15:12:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Improving the anonymous ftp environment.
In-Reply-To: <20040508182651.GA28834@coe.bosbc.com>
References: <3.0.5.32.20040508141216.00803820@incoming.verizon.net>
 <3.0.5.32.20040508141216.00803820@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00090.txt.bz2

At 02:26 PM 5/8/2004 -0400, Christopher Faylor wrote:
>On Sat, May 08, 2004 at 02:12:16PM -0400, Pierre A. Humblet wrote:
>>On Fri, 7 May 2004 22:55:29 -0400, Christopher Faylor  wrote:
>>>The memory leak is a good point (and has mildly bothered me since
>>>implemented this) but aren't you essentially opening a mechanism to
>>>access things outside of the chrooted environment with this patch?
>>
>>I don't think so.  spawn uses path_conv::check, which will bomb if the
>>program is outside the chroot area, no matter the Windows PATH.  One
>>has to be careful not to put any Windows program in that area, as it
>>won't honor the changeroot.  DLLs may open files outside of the chroot
>>area, but that's independent of the DLLs locations.
>
>Ok.

Well, I decided to check what I wrote, and it's more complicated.
It turns out that find_exec uses the Windows PATH (although there
is a FIXME about that, in spawn_guts), and then it calls 
perhaps_suffix(), which uses path_conv::check. 
So there is no security problem. However because the PATH contains
Win32 paths, the mount flags are not picked up. 

I also noticed something weird, running from a DOS shell:

Compare
C:\Home\Pierre>sh -c "env -u PATH echo yes"
env: echo: No such file or directory

and
C:\Home\Pierre>env -u PATH echo yes
yes

find_exec finds the path in the second case! That has something
to do with caching in the win_env. The Windows PATH is still set,
perhaps because the program manipulates the environment directly
or because unsetenv doesn't clear the cache.

case 1: 
15670  168943 [main] env 644047 find_exec: find_exec (true)
  163  169106 [main] env 644047 getwinenv: can't set native for PATH= since
no environ yet
  155  169261 [main] env 644047 find_exec:  = find_exec (true)

case 2:
 4116   37022 [main] env 49536259 find_exec: find_exec (true)
  171   37193 [main] env 49536259 getwinenv: can't set native for PATH=
since no environ yet
  160   37353 [main] env 49536259 find_exec:
PATH=C:\WINDOWS;C:\WINDOWS\COMMAND;c:\progra~1\cygwin\bin


Pierre
