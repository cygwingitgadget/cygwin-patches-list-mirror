Return-Path: <cygwin-patches-return-5250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29551 invoked by alias); 18 Dec 2004 22:07:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28985 invoked from network); 18 Dec 2004 22:07:01 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Dec 2004 22:07:01 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id A9E911B401; Sat, 18 Dec 2004 17:08:16 -0500 (EST)
Date: Sat, 18 Dec 2004 22:07:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041218220816.GA11307@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org> <20041218003615.GB3068@trixie.casa.cgf.cx> <Pine.GSO.4.61.0412172132500.2298@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0412172132500.2298@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00251.txt.bz2

On Sat, Dec 18, 2004 at 04:12:17PM -0500, Igor Pechtchanski wrote:
>On Fri, 17 Dec 2004, Christopher Faylor wrote:
>
>> On Fri, Dec 17, 2004 at 06:01:04PM -0500, Pierre A. Humblet wrote:
>> >Christopher Faylor wrote:
>> >
>> >> While I detest the trailing dot crap, I don't want cygwin to be
>> >> inconsistent. I don't want ls /bin./ls.exe to fail but ls
>> >> /cygdrive/c/bin./ls.exe to work.
>> >
>> >Assuming a normal install, the first one is c:\cygwin\bin.\ls.exe,
>> >which would NOT fail, while the second is c:\bin.\ls.exe, which would
>> >fail as expected (not due to dots).
>>
>> Ok.  Yes.  I had a typo.
>>
>> If /cygdrive/c/cygwin/bin./ls.exe works, then /bin./ls.exe should also
>> work. Or, both should fail.  "consistent"
>
>If I may chime in, I think there are at least three separate possibilities
>for accessing each directory:
>
>1) via a managed Cygwin mount;
>2) via a regular Cygwin mount;
>3) via a /cygdrive-prefixed path; and maybe
>4) via a Win32 path.
>
>There's a need for consistency in each of the above cases, but not
>between cases.  Each may justifiably have different behavior.  We
>already default to textmode for 4), and 2) and 3) may have different
>textmode/binmode behavior.

2 and 3 don't have different textmode/binmode behavior.  You use mount to
control the behavior.

>It could be argued that as you go down this list, the POSIXness
>decreases, so it's ok to distinguish trailing dots, e.g., in the first
>two cases, and ignore them in the latter two.

So, you're saying that 2 should always say "file not found"?  Non-managed
mounts can't reliably distinguish trailing dots.  Unless you want to make
every file a symbolic link to the "real" file or always issue an ENOENT
when a pathname component has a trailing dot.

I don't see a difference between /cygdrive or a mounted drive.  Both are
cygwin inventions.  I don't see a logical explanable reason for what they
support to be different.

That is another case that I didn't specify.  Should /cygdrive./c work?
I think I'm coming back to my ENOENT for all trailing dots argument...

>Just my $0.02.

Using past behavior, which has certainly changed in the last six months
and undoubtedly changed a couple of times prior to that, or
extrapolating from the behavior of textmode/binmode to justify this is
really not an argument that I'm interested in.  You can cause cygwin
programs to control the behavior of textmode/binmode with appropriate
flags to fopen or open or by specifying the explicit use of mount.
There is no easy way for a cygwin program to figure out what to do with
trailing dots.

cgf
