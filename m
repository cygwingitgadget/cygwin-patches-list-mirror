Return-Path: <cygwin-patches-return-5106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3137 invoked by alias); 31 Oct 2004 15:19:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3071 invoked from network); 31 Oct 2004 15:19:32 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.203.248)
  by sourceware.org with SMTP; 31 Oct 2004 15:19:32 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I6GG0O-001MQR-JG
	for cygwin-patches@cygwin.com; Sun, 31 Oct 2004 10:22:00 -0500
Message-Id: <3.0.5.32.20041031101448.0082c630@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 31 Oct 2004 15:19:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] unlink
In-Reply-To: <20041031033651.GA12853@trixie.casa.cgf.cx>
References: <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
 <4182BDCF.3C04BAF8@phumblet.no-ip.org>
 <4182BDCF.3C04BAF8@phumblet.no-ip.org>
 <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00107.txt.bz2

At 11:36 PM 10/30/2004 -0400, Christopher Faylor wrote:
>On Sat, Oct 30, 2004 at 10:30:54PM -0400, Pierre A. Humblet wrote:
>>At 01:39 PM 10/30/2004 -0400, you wrote:
>>>On Fri, Oct 29, 2004 at 06:01:51PM -0400, Pierre A. Humblet wrote:
>>>>Here is a patch that should allow unlink() to handle
>>>>nul etc.. on local disks.
>>>>
>>>>It's a cut and paste of Corinna's open on NT and the
>>>>existing CreateFile.
>>>> 
>>>>It works on normal files. I haven't tested with the
>>>>special names because I forgot how to create them !
>>>>Feedback welcome.
>>>>
>>>>XXXXX This should NOT be applied in 1.5.12 XXXXXX
>>>>
>>>>Pierre
>>>>
>>>>2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>
>>>>
>>>>	* syscalls.cc (nt_delete): New function.
>>>>	(unlink): Call nt_delete instead of CreateFile and remove
>>>>	unreachable code.
>>>
>>>Corinna suggested something similar to me a couple of months ago but I
>>>wanted to wait for things to settle down somewhat after the original
>>>use of NtCreateFile.
>>>
>>>On reflection, however, wouldn't it be a little easier just to prepend
>>>the path being deleted with a: \\.\ so that "rm nul" would eventually
>>>translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
>>>backslash quoting here)?  I don't know if that would work on Windows 9x,
>>>though.
>>
>>That would work on NT, but then one would need to check if the input
>>path didn't already have the form //./xx, worry about exceeding max 
>>pathlength, etc...
>
>Other than being able to delete special filenames is there any other
>benefit to using NtCreateFile to delete files?

I can only think of speed. But I don't see a downside either, given that
we use it in open().

>If path length was an issue we could use '//?/' instead since the length
>restriction is a lot larger there.  So, it would be something like:
>
>  char *path;
>  char newpath[strlen (win32_name) + 4] = "\\\\?\";
>  if  (win32_name[0] != '\\')
>      path = strcat (newpath, win32_name);
>  else
>      path = win32_name;
>
>and then you'd use path throughout from then on.

Have you tried it? According to MSDN you need to use the Unicode version
if you do that.
<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/base/createfile.asp>
"In the ANSI version of this function, the name is limited to MAX_PATH 
characters. To extend this limit to 32,767 wide characters, call the Unicode 
version of the function and prepend "\\?\" to the path"

Pierre
