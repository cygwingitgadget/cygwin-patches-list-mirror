Return-Path: <cygwin-patches-return-5237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20022 invoked by alias); 17 Dec 2004 17:17:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19982 invoked from network); 17 Dec 2004 17:17:12 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 17 Dec 2004 17:17:12 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I8VMOM-00009Y-PG
	for cygwin-patches@cygwin.com; Fri, 17 Dec 2004 12:17:10 -0500
Message-ID: <41C31496.4D9140C7@phumblet.no-ip.org>
Date: Fri, 17 Dec 2004 17:17:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <20041217032627.GF26712@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00238.txt.bz2



Christopher Faylor wrote:
> 
> On Thu, Dec 16, 2004 at 10:43:47PM -0500, Pierre A. Humblet wrote:
> >
> >The key point in my patch is that it's the output Win32 path
> >that must be checked, not the input path.
> 
> How can that be?  As I mentioned previously, if you don't perform the
> fixups prior to inspecting the mount table then "ls /bin.........."
> won't work.

Huh?
In a normal Cygwin install, /bin... uses the mount point for / and is
translated to c:\cygwin\bin... 
Windows maps this to c:\cygwin\bin, and we can fix the output path
in :check() so that NtCreateFile does the same.

Note in passing that "ls /bin..." "works" in a rather strange way:
CYGWIN_NT-4.0 usched40576 1.5.12(0.116/4/2) 2004-11-10 08:34 i686
<snip>
ls: /bin.../znew: No such file or directory
This has always been the behavior.

Continuing on your example, ls /usr/bin... only "works" (as above)
since the 2004/04 changes. Before that date, one could mount
c:\cygwin\bin -> /usr/bin
c:\something -> /usr/bin...
and ls /usr/bin... would list c:\something
If you try that today, ls /usr/bin... lists c:\cygwin\bin, but 
ls /usr/bin.../somefile lists c:\something\somefile !!!
I think we should revert to the old behavior, i.e. try to be as
Posix like as possible.

Before 2004/04 one could also have an executable "abc...exe" and typing
"abc.." would invoke it. Again I think we should revert to that behavior
Yesterday I gave a similar example with symbolic links.
They show that the input tail isn't always the same as the output tail.
Windows only cares about the output tail, and so should Cygwin
(but only when Windows does). 

Pierre
