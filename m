Return-Path: <cygwin-patches-return-5254-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32572 invoked by alias); 20 Dec 2004 03:02:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32432 invoked from network); 20 Dec 2004 03:02:31 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 20 Dec 2004 03:02:31 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I903AL-002BYH-8W
	for cygwin-patches@cygwin.com; Sun, 19 Dec 2004 22:06:21 -0500
Message-Id: <3.0.5.32.20041219215720.0082da20@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Mon, 20 Dec 2004 03:02:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Patch to allow trailing dots on managed mounts
In-Reply-To: <20041219024407.GA12883@trixie.casa.cgf.cx>
References: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
 <20041216160322.GC16474@cygbert.vinschen.de>
 <41C1A1F4.CD3CC833@phumblet.no-ip.org>
 <20041216150040.GA23488@trixie.casa.cgf.cx>
 <20041216155339.GA16474@cygbert.vinschen.de>
 <20041216155707.GG23488@trixie.casa.cgf.cx>
 <20041216160322.GC16474@cygbert.vinschen.de>
 <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00255.txt.bz2

At 09:44 PM 12/18/2004 -0500, Christopher Faylor wrote:
>
>For now, I'm disallowing all use of '.\' and ' \' in a path.  It seems
>more consistent to disallow everything than to allow some stuff.  I
>didn't change the symlink code to disallow "ln -s foo bar..."  If someone
>actually complains about this, maybe I will.
>
>So, "ls /bin........." works, "ls /bin./pwd.exe" doesn't work and "ls
>/cygwin/c/cygwin/bin./pwd.exe" doesn't work either.  Nor does
>"ls c:\cygwin\bin.\pwd.exe".  I don't know if we'll hear complaints about
>this one or not.

Excellent decisions. 
Although ls would work with 'bin./', NtCreateFile couldn't open the
file and things requiring a handle (like the inode) would be 
reported incorrectly.

Do you intent to remove the dot checking code in normalize_xxx_path?
It now seems to be useless and even counterproductive.
 
>>Also, for my info, what is the unc\ in
>>       !strncasematch (this->path + 4, "unc\\", 4)))
>>around line 868? I have never seen that documented.
>
>I've always wondered about that myself.  I am pretty sure it predates
>me.  I've removed that test.  It doesn't make any sense to me either.

Thanks. I made some progress on that one, looking at 
path_conv::get_nt_native_path.

\\.\unc\computer\share indicates a remote share. So apparently the intention
was to add a final \ in that case, but not on \\.\c: (according to the
comment) nor on \\.\c:\somedir   (why not??), and never with PC_FULL.
Is there ever any reason to add a \ to a Windows path?
 
Now, I checked (on XP Home) that "dir \\.\c:" does NOT work, while "dir \\.\c:\"
does work, which seems to contradict the intention in the comment.
Also "ls //./c:" does not work, but neither does "ls //./c:/", because Cygwin
strips the final '/' and it's needed for GetFileAttributes (fails with WinError 87).
path_conv will probably never be completely right!  

Pierre
