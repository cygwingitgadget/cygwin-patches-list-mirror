Return-Path: <cygwin-patches-return-5257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4323 invoked by alias); 20 Dec 2004 15:16:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4018 invoked from network); 20 Dec 2004 15:15:56 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Dec 2004 15:15:56 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id A0E3A1B401; Mon, 20 Dec 2004 10:17:16 -0500 (EST)
Date: Mon, 20 Dec 2004 15:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041220151716.GA1175@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <3.0.5.32.20041219215720.0082da20@incoming.verizon.net> <20041220102329.GL9277@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220102329.GL9277@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00258.txt.bz2

On Mon, Dec 20, 2004 at 11:23:29AM +0100, Corinna Vinschen wrote:
>On Dec 19 21:57, Pierre A. Humblet wrote:
>> At 09:44 PM 12/18/2004 -0500, Christopher Faylor wrote:
>> >
>> >For now, I'm disallowing all use of '.\' and ' \' in a path.  It seems
>> >more consistent to disallow everything than to allow some stuff.  I
>> >didn't change the symlink code to disallow "ln -s foo bar..."  If someone
>> >actually complains about this, maybe I will.
>> >
>> >So, "ls /bin........." works, "ls /bin./pwd.exe" doesn't work and "ls
>> >/cygwin/c/cygwin/bin./pwd.exe" doesn't work either.  Nor does
>> >"ls c:\cygwin\bin.\pwd.exe".  I don't know if we'll hear complaints about
>> >this one or not.
>
>I guess we will.  The trailing dots are not removed from the POSIX path
>in case of chdir, but the chdir itself succeeds.  That leads to an
>unexpected result:
>
>$ cd /bin...
>$ pwd
>/bin...		<- This was printed as /bin before
>$ ls sh.exe
>ls: sh.exe: No such file or directory
>
>In terms of consistancy it should be impossible to chdir already,
>shouldn't it?

If we're allowing trailing dots then I guess we should strip them from the
posix path as well as the windows path.

>> Do you intent to remove the dot checking code in normalize_xxx_path?
>> It now seems to be useless and even counterproductive.
>
>AFAICS, this code could go.

We're talking about this code, right?

              else if (src[2] && !isslash (src[2]))
                {
                  if (src[2] == '.')
		    {
		  /* Is this a run of dots? That would be an invalid
		     filename.  A bunch of leading dots would be ok,
		     though. */
		    int n = strspn (src, ".");
		    if (!src[n] || isslash (src[n])) /* just dots... */
		      return ENOENT;
		    }
		  break;

cgf
