Return-Path: <cygwin-patches-return-5100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24822 invoked by alias); 30 Oct 2004 17:39:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24813 invoked from network); 30 Oct 2004 17:39:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 30 Oct 2004 17:39:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 0780B1B3E5; Sat, 30 Oct 2004 13:39:43 -0400 (EDT)
Date: Sat, 30 Oct 2004 17:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] unlink
Message-ID: <20041030173942.GD1556@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4182BDCF.3C04BAF8@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4182BDCF.3C04BAF8@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00101.txt.bz2

On Fri, Oct 29, 2004 at 06:01:51PM -0400, Pierre A. Humblet wrote:
>Here is a patch that should allow unlink() to handle
>nul etc.. on local disks.
>
>It's a cut and paste of Corinna's open on NT and the
>existing CreateFile.
> 
>It works on normal files. I haven't tested with the
>special names because I forgot how to create them !
>Feedback welcome.
>
>XXXXX This should NOT be applied in 1.5.12 XXXXXX
>
>Pierre
>
>2004-10-29  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* syscalls.cc (nt_delete): New function.
>	(unlink): Call nt_delete instead of CreateFile and remove
>	unreachable code.

Corinna suggested something similar to me a couple of months ago but I
wanted to wait for things to settle down somewhat after the original
use of NtCreateFile.

On reflection, however, wouldn't it be a little easier just to prepend
the path being deleted with a: \\.\ so that "rm nul" would eventually
translate to DeleteFile("\\.\c:\foo\null") (I'm not using true C
backslash quoting here)?  I don't know if that would work on Windows 9x,
though.

cgf
