Return-Path: <cygwin-patches-return-4780-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1324 invoked by alias); 21 May 2004 17:37:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1160 invoked from network); 21 May 2004 17:37:46 -0000
X-Originating-IP: [4.18.151.35]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: [Patch] To handle Win32 pipe names
Date: Fri, 21 May 2004 17:37:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F32Fj3NAah6gz90005b96d@hotmail.com>
X-OriginalArrivalTime: 21 May 2004 17:37:45.0602 (UTC) FILETIME=[53A31620:01C43F5A]
X-SW-Source: 2004-q2/txt/msg00132.txt.bz2

Some comments are inline.

>From: Corinna Vinschen
>Subject: Re: [Patch] To handle Win32 pipe names
>Date: Wed, 19 May 2004 10:52:37 +0200
>
>Stephen,
>
>On May 17 12:57, Stephen Cleary wrote:
> > Attached is a patch against the current CVS sources, with a ChangeLog. 
>This
> > patch allows Win32 pipe names to be opened as files.
>
>that's still not quite what I had in mind.  I'd like to see as less special
>windows path handling in Cygwin as possible.  A //foo/pipe/whatever path is
>just like any other UNC path and could be handled as such, no extra code
>should be necessary.  //./pipe/whatever should also go through without any
>extra code so the whole idea would be to do exactly nothing, except the
>existing code has a bug, of course.  I really don't care for stat.  If
>Windows named pipes are recognized as files, so be it.

I agree that as few as possible changes should be made to support named 
pipes, with the smallest amount of Win32 path stuff gunking up the works...

But, while //server/pipe/name may be a UNC path, it is not a path to a file. 
And certain Win32 functions (including GetFileAttributes) do not work on 
those paths. When I say "do not work", I mean the Win32 SDK actually says 
not to call them on those paths, and when I do it on my XP Pro SP1 (with all 
updates), odd behavior ensues. This is undefined behavior. Sometimes I can 
see weird stuff at the filesystem level using SysInternals' FileMon.

So, as it currently stands, stat() and the check for symlinks are fully 
broken for Win32 pipes - they actually cause undefined behavior.

>I've just quickly stepped through the existing code and it looks like
>\\.\foo paths can be opened normally on NT.  Just stat seems to have
>a problem, since stat_worker checks for fh->exists() at one point and
>GetFileAttributes returned INVALID_FILE_ATTRIBUTES on devices.  So that
>explains your patch to symlink_info::check.  But it's not exactly right
>to circumvent this only for pipes.  Any \\.\foo path should get the
>same handling.  Wouldn't it be more straightforward to use is_unc_share
>or a slightly modified version of is_unc_share?

"\\.\" doesn't necessarily mean "open a device". It is possible to open a 
normal file using that syntax - "\\.\c:\tmp.txt" works fine. "\\.\" is just 
a placeholder for "\??\" when the call goes to the native level.

But we could just treat any path starting with "\\.\" as a device, if you 
really want to. I've never seen it actually used to open a regular disk 
file, so we'd probably get away with it.

Your thoughts?
       -Steve

_________________________________________________________________
Watch LIVE baseball games on your computer with MLB.TV, included with MSN 
Premium! http://join.msn.click-url.com/go/onm00200439ave/direct/01/
