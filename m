Return-Path: <cygwin-patches-return-5253-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1998 invoked by alias); 19 Dec 2004 02:42:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1957 invoked from network); 19 Dec 2004 02:42:51 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 19 Dec 2004 02:42:51 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 7DF1F1B401; Sat, 18 Dec 2004 21:44:07 -0500 (EST)
Date: Sun, 19 Dec 2004 02:42:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041219024407.GA12883@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00254.txt.bz2

On Thu, Dec 16, 2004 at 10:04:41PM -0500, Pierre A. Humblet wrote:
>	* path.cc (path_conv::check): Check the output Win32 path for trailing
>	spaces and dots, not the input path.

Ok.  I've convinced myself that doing it what I consider to be the most
forgiving way is going to be too expensive, introducing extra code for
an unlikely corner case in a routine that is time-sensitive.  So, I'm
checking in a variation of this patch.  It didn't work out of the box
and I wanted to add some extra checking so I rewrote part of the patch.

For now, I'm disallowing all use of '.\' and ' \' in a path.  It seems
more consistent to disallow everything than to allow some stuff.  I
didn't change the symlink code to disallow "ln -s foo bar..."  If someone
actually complains about this, maybe I will.

So, "ls /bin........." works, "ls /bin./pwd.exe" doesn't work and "ls
/cygwin/c/cygwin/bin./pwd.exe" doesn't work either.  Nor does
"ls c:\cygwin\bin.\pwd.exe".  I don't know if we'll hear complaints about
this one or not.

>Also, for my info, what is the unc\ in
>       !strncasematch (this->path + 4, "unc\\", 4)))
>around line 868? I have never seen that documented.

I've always wondered about that myself.  I am pretty sure it predates
me.  I've removed that test.  It doesn't make any sense to me either.

Thanks, Pierre.

cgf
