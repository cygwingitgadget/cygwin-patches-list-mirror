Return-Path: <cygwin-patches-return-5108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9624 invoked by alias); 31 Oct 2004 23:47:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9614 invoked from network); 31 Oct 2004 23:47:25 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 31 Oct 2004 23:47:25 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 79E951B3E5; Sun, 31 Oct 2004 18:47:30 -0500 (EST)
Date: Sun, 31 Oct 2004 23:47:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] unlink
Message-ID: <20041031234730.GA4220@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041030223054.008277e0@incoming.verizon.net> <4182BDCF.3C04BAF8@phumblet.no-ip.org> <4182BDCF.3C04BAF8@phumblet.no-ip.org> <3.0.5.32.20041030223054.008277e0@incoming.verizon.net> <3.0.5.32.20041031101448.0082c630@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041031101448.0082c630@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00109.txt.bz2

On Sun, Oct 31, 2004 at 10:14:48AM -0500, Pierre A. Humblet wrote:
>At 11:36 PM 10/30/2004 -0400, Christopher Faylor wrote:
>>On Sat, Oct 30, 2004 at 10:30:54PM -0400, Pierre A. Humblet wrote:
>>>At 01:39 PM 10/30/2004 -0400, you wrote:
>>>>On Fri, Oct 29, 2004 at 06:01:51PM -0400, Pierre A. Humblet wrote:
>>>>>Here is a patch that should allow unlink() to handle
>>>>>nul etc.. on local disks.
>>>>>
>>>>>It's a cut and paste of Corinna's open on NT and the
>>>>>existing CreateFile.
>>>>> 
>>>>>It works on normal files. I haven't tested with the
>>>>>special names because I forgot how to create them !
>>>>>Feedback welcome.
>>>>>
>>>>>XXXXX This should NOT be applied in 1.5.12 XXXXXX
>>>>>
>>>>>Pierre
>>>>>
>>>>>2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>
>>>>>
>>>>>	* syscalls.cc (nt_delete): New function.
>>>>>	(unlink): Call nt_delete instead of CreateFile and remove
>>>>>	unreachable code.
>>>>
>>>>Corinna suggested something similar to me a couple of months ago but I
>>>>wanted to wait for things to settle down somewhat after the original
>>>>use of NtCreateFile.
>>>>
>>>>On reflection, however, wouldn't it be a little easier just to prepend
>>>>the path being deleted with a: \\.\ so that "rm nul" would eventually
>>>>translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
>>>>backslash quoting here)?  I don't know if that would work on Windows 9x,
>>>>though.
>>>
>>>That would work on NT, but then one would need to check if the input
>>>path didn't already have the form //./xx, worry about exceeding max 
>>>pathlength, etc...
>>
>>Other than being able to delete special filenames is there any other
>>benefit to using NtCreateFile to delete files?
>
>I can only think of speed. But I don't see a downside either, given that
>we use it in open().
>
>>If path length was an issue we could use '//?/' instead since the length
>>restriction is a lot larger there.  So, it would be something like:
>>
>>  char *path;
>>  char newpath[strlen (win32_name) + 4] = "\\\\?\";
>>  if  (win32_name[0] != '\\')
>>      path = strcat (newpath, win32_name);
>>  else
>>      path = win32_name;
>>
>>and then you'd use path throughout from then on.
>
>Have you tried it? According to MSDN you need to use the Unicode version
>if you do that.

Yes.  I created and deleted a file using '//?/d:/nul' from the command line.

cgf
