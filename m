Return-Path: <cygwin-patches-return-4841-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18279 invoked by alias); 18 Jun 2004 01:22:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18269 invoked from network); 18 Jun 2004 01:22:31 -0000
X-Originating-IP: [4.18.151.35]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: [Patch] To handle Win32 pipe names
Date: Fri, 18 Jun 2004 01:22:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F157vDcPp2APfr0006fd52@hotmail.com>
X-OriginalArrivalTime: 18 Jun 2004 01:22:31.0177 (UTC) FILETIME=[B9E36790:01C454D2]
X-SW-Source: 2004-q2/txt/msg00193.txt.bz2

Sorry for the tardiness of this reply -

>From: Corinna Vinschen
>On May 21 13:37, Stephen Cleary wrote:
> > But, while //server/pipe/name may be a UNC path, it is not a path to a
> > file. And certain Win32 functions (including GetFileAttributes) do not 
>work
> > on those paths. When I say "do not work", I mean the Win32 SDK actually
> > says not to call them on those paths, and when I do it on my XP Pro SP1
> > (with all updates), odd behavior ensues. This is undefined behavior.
> > Sometimes I can see weird stuff at the filesystem level using 
>SysInternals'
> > FileMon.
> > So, as it currently stands, stat() and the check for symlinks are fully
> > broken for Win32 pipes - they actually cause undefined behavior.
>
>Shouldn't Pierre's observations from yesterday clear this up a bit?
>Are the attributes set to 0x20 or -1 respectively?

Not necessarily. GetFileAttributes behavior is not defined for pipe paths. 
So it cannot be called on those paths. I believe it returns -1 on my XP 
system - after it opens and closes the pipe, changing the semantics for the 
server! But there's no guarantee what it would return on other systems.

What we're up against here is a failing of the Win32 API:
1) GetFileAttributes cannot be called on a pipe path.
2) There is no function that can tell you that a path is a pipe path unless 
you actually open it and use GetFileType - which changes server semantics.
3) Therefore, you have to detect pipe paths and avoid calling 
GetFileAttributes.

>Yes, that's right.  However, what I'm trying to say is this:  Getting
>Win32 pipes working "untranslated" is not exactly what Cygwin's main
>job is.  It's enough if open/read/write/close work.  Stat doesn't
>necessarily need to return something meaningful.  Actually a native
>Win32 named pipe isn't a POSIX named pipe.  If stat returns that info
>for a Win32 named pipe, it would even be misleading, since the behaviour
>isn't POSIX like.  But that's what a POSIX application would expect from
>such a named pipe.

The problem with not at least somewhat supporting stat is that all of the 
common GNU command-line utilities (cat, etc.) have special code that depends 
on stat to check for multiple input files referencing the same physical 
file.

The behavior of one end of the pipe is close enough. The main differences 
between Win32 pipes and POSIX pipes is how they're created and how the 
different ends interact together (POSIX pipes blocking on open). But if an 
application is just using one end of a pipe (i.e., it was passed a pipe name 
as a file name), the behavior between Win32 pipes and POSIX pipes should be 
close enough to work. At least, I don't know of a way an application would 
fail.

        -Steve

_________________________________________________________________
MSN 9 Dial-up Internet Access fights spam and pop-ups  now 3 months FREE! 
http://join.msn.click-url.com/go/onm00200361ave/direct/01/
