Return-Path: <cygwin-patches-return-4720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32317 invoked by alias); 6 May 2004 17:45:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32308 invoked from network); 6 May 2004 17:45:55 -0000
X-Originating-IP: [4.18.151.35]
X-Originating-Email: [yjfwhhvvvhzk6wdy@hotmail.com]
X-Sender: yjfwhhvvvhzk6wdy@hotmail.com
From: "Stephen Cleary" <yjfwhhvvvhzk6wdy@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: Patch to handle Win32 named pipes as file names
Date: Thu, 06 May 2004 17:45:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F7x9DBFoxhYaf70000ae59@hotmail.com>
X-OriginalArrivalTime: 06 May 2004 17:45:55.0118 (UTC) FILETIME=[FB370CE0:01C43391]
X-SW-Source: 2004-q2/txt/msg00072.txt.bz2

Corinna -

Thanks for your helpful response. I have a question below on how would be 
the best way to proceed.

>From: Corinna Vinschen
>
>while I really appreciate the effort, that's not what we expect from
>an fhandler to do.  Cygwin is a POSIX layer.  An fhandler should at
>least try to come up with a POSIX-like translation of a Windows
>capability, in this case, converting Windows named pipes into POSIX
>FIFOs on the API level.  What your code is doing is just allowing to
>use Windows named pipes untranslated and treating them as FIFOs in
>stat().

OK; I will try to modify the fhandler_base/fhandler_disk_file to handle 
Win32 named pipes instead.

>The ability to open/read/write/close WIndows named pipes should already
>be available without much of a code change.  Paths like //./pipe/foo
>should go through untranslated, just treated like normal files.  If that
>doesn't work, feel free to fix the code snippets which accidentally 
>disallow
>that.

It is a bit more complex than first appears. The problem is that some 
functions (e.g., SetFilePointer, GetFileInformationByHandle) have undefined 
behavior when used on pipes (or other special Win32 files). Further, there 
is no way to determine the type of HANDLE after the fact (GetFileType may 
work "well enough", but it may not be specific enough for future use).

So, I think it may be necessary to keep some "handle type" enumeration along 
with the HANDLE value. I want to make this change in such a way that it'll 
be easier to add other types (volumes, mailslots, etc.). There's a couple 
ways to do this that come to mind:
1) Define a "Win32 file" major device number, with a minor device number for 
each HANDLE type.
2) Keep the single "Win32 file" device type, and add an enum that determines 
the handle type. Since this would be based off the file name, it makes sense 
to me to add this to path_conv instead of fhandler_base.
3) Just use GetFileType, which will work to distinguish pipes from disk 
files. This has minimal code impact now, but may not be sufficient for 
future work.

What do you think is the best way to go?

>However, if you want to contribute code to Cygwin, we need a copyright
>assignment from you, filled out and snail mailed to Red Hat.  Please
>see http://cygwin.com/contrib.html for details.

I will get this in the mail.

>I hope that's not too discouraging,
>Corinna

Not at all. Thank you for your response!

        -Steve

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar  get it now! 
http://toolbar.msn.com/go/onm00200415ave/direct/01/
