Return-Path: <cygwin-patches-return-5245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23738 invoked by alias); 18 Dec 2004 17:19:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23644 invoked from network); 18 Dec 2004 17:19:39 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Dec 2004 17:19:39 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id B76AC1B401; Sat, 18 Dec 2004 12:20:53 -0500 (EST)
Date: Sat, 18 Dec 2004 17:19:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041218172053.GA9932@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041218003615.GB3068@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00246.txt.bz2

On Fri, Dec 17, 2004 at 07:36:15PM -0500, Christopher Faylor wrote:
>If /cygdrive/c/cygwin/bin./ls.exe works, then /bin./ls.exe should also work.
>Or, both should fail.  "consistent"

Thinking some more about this, there are really some inconsistencies with
the current and proposed behavior that I don't like.

Here's a table.  Please let me know if I got anything wrong:

What			   Now	       Pierre's proposal   Windows Equiv
ls /bin...		   Works       Won't work	   dir c:\cygwin\bin... doesn't work
ls /bin.		   Works       Won't work(?)	   dir c:\cygwin\bin. works
ls /lib/gcc.		   Works       Works(?)		   dir c:\cygwin\lib\gcc. works
ls /lib./gcc.		   Works       Won't work(?)	   dir c:\cygwin\lib.\gcc. works
ls /cygdrive/c/cygwin/bin. Works       Works(?)		   dir c:\cygwin\bin. works
ls /bin../ls.exe	   Won't work  Won't work	   dir c:\cygwin\bin..\ls.exe won't work
ls /cygdrive/c/cygwin/bin../ls.exe
                           Won't work  Won't work          ditto
ls /bin/ls.exe...          Works       Works(?)            dir c:\cygwin\bin\ls.exe... works
ln -s foo bar.		   "Works"*    Works**             .lnk files with dot extensions allowed

If I understand this correctly, I think "Pierre's proposal" == "cygwin's
behavior before 2004/4", on all counts.

So, in thinking about all of this, I have a radical proposal which I
have previously alluded to.

path_conv::check could detect the existence of trailing dots or spaces
in path components of the output win32 path and set ENOENT in such cases
unless the file was associated with either a managed mount or Corinna's
proposed "posix" mount.

The rationale for this is that you really can't (except in the symlink
case) create a file with a trailing dot so why should we lie and say
that you can?

This probably is too radical an idea and would result in breakage.  So,
my alternate thought is that single dots should be silently ignored in
all path components.  Multiple dots should be ignored in the trailing
path component, regardless of whether the file refers to a directory or
not, which makes cygwin slightly incompatible with windows.

I'm not sure how spaces fall out in the above table.  I'm not sure that the
same rules should be applied for spaces and dots above.

cgf

*Creates a bar.lnk file which will show up on in a directory listing as just
"bar".

**Creates a bar..lnk file when using default symlink behavior.  Shows up in
a listing as "bar."  Otherwise behaves as now(?).
