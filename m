Return-Path: <cygwin-patches-return-5104-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32708 invoked by alias); 31 Oct 2004 03:36:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32687 invoked from network); 31 Oct 2004 03:36:49 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 31 Oct 2004 03:36:49 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id E4A151B3F8; Sat, 30 Oct 2004 23:36:51 -0400 (EDT)
Date: Sun, 31 Oct 2004 03:36:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] unlink
Message-ID: <20041031033651.GA12853@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4182BDCF.3C04BAF8@phumblet.no-ip.org> <4182BDCF.3C04BAF8@phumblet.no-ip.org> <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041030223054.008277e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00105.txt.bz2

On Sat, Oct 30, 2004 at 10:30:54PM -0400, Pierre A. Humblet wrote:
>At 01:39 PM 10/30/2004 -0400, you wrote:
>>On Fri, Oct 29, 2004 at 06:01:51PM -0400, Pierre A. Humblet wrote:
>>>Here is a patch that should allow unlink() to handle
>>>nul etc.. on local disks.
>>>
>>>It's a cut and paste of Corinna's open on NT and the
>>>existing CreateFile.
>>> 
>>>It works on normal files. I haven't tested with the
>>>special names because I forgot how to create them !
>>>Feedback welcome.
>>>
>>>XXXXX This should NOT be applied in 1.5.12 XXXXXX
>>>
>>>Pierre
>>>
>>>2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>
>>>
>>>	* syscalls.cc (nt_delete): New function.
>>>	(unlink): Call nt_delete instead of CreateFile and remove
>>>	unreachable code.
>>
>>Corinna suggested something similar to me a couple of months ago but I
>>wanted to wait for things to settle down somewhat after the original
>>use of NtCreateFile.
>>
>>On reflection, however, wouldn't it be a little easier just to prepend
>>the path being deleted with a: \\.\ so that "rm nul" would eventually
>>translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
>>backslash quoting here)?  I don't know if that would work on Windows 9x,
>>though.
>
>That would work on NT, but then one would need to check if the input
>path didn't already have the form //./xx, worry about exceeding max 
>pathlength, etc...

Other than being able to delete special filenames is there any other
benefit to using NtCreateFile to delete files?

If path length was an issue we could use '//?/' instead since the length
restriction is a lot larger there.  So, it would be something like:

  char *path;
  char newpath[strlen (win32_name) + 4] = "\\\\?\";
  if  (win32_name[0] != '\\')
      path = strcat (newpath, win32_name);
  else
      path = win32_name;

and then you'd use path throughout from then on.

We could use a technique like this for other things, like rename, to enable
it to manipulate accidentally-created special files.

OTOH, I just had an idea about how to use //?/ on NT so that we could
have longer path names.  I have to mull it over a little to see if it
would work or not, though.  I have an airplane trip tomorrow that would
be perfect for this kind of mulling.

cgf
