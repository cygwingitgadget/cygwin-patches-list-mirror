Return-Path: <cygwin-patches-return-5238-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20313 invoked by alias); 17 Dec 2004 17:55:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20230 invoked from network); 17 Dec 2004 17:55:44 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 17:55:44 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 8ED591B4C2; Fri, 17 Dec 2004 12:56:49 -0500 (EST)
Date: Fri, 17 Dec 2004 17:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041217175649.GA1237@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C31496.4D9140C7@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00239.txt.bz2

On Fri, Dec 17, 2004 at 12:17:10PM -0500, Pierre A. Humblet wrote:
>
>Christopher Faylor wrote:
>> 
>> On Thu, Dec 16, 2004 at 10:43:47PM -0500, Pierre A. Humblet wrote:
>> >
>> >The key point in my patch is that it's the output Win32 path
>> >that must be checked, not the input path.
>> 
>> How can that be?  As I mentioned previously, if you don't perform the
>> fixups prior to inspecting the mount table then "ls /bin.........."
>> won't work.
>
>Huh?

Huh, right back at you.  You *quoted* my article where I mentioned this
and didn't address it.

I did a little more research on XP.  I was under the impression that
windows allowed you to do something like:

dir c:\cygwin\bin.........\ls.exe

but it doesn't.

It does seem to allow

dir c:\cygwin\bin.\ls.exe

While I detest the trailing dot crap, I don't want cygwin to be inconsistent.
I don't want ls /bin./ls.exe to fail but ls /cygdrive/c/bin./ls.exe to work.

I'm not sure that it makes sense for ln -s foo "bar." to actually create a file
with a trailing dot on a non-managed mount either.  That seems to expose an
implementation detail of the way links are handled and it seems inconsistent
to me.

If we are "fixing" this (I firmly believe that the code in path_conv is never
really going to be right) then I don't want to add inconsistencies.

All of your points about your 2004/04 changes are understood.  I noted the
problems with symlinks and exe while I was scouring this code yesterday.  Some
of the conv_to and normalize functions also seem to have suffered from some
accretion so it is time for me to do a code audit.  I was changing jobs when
this code was put into cygwin in April.  I need to refamiliarize myself with
it now.

cgf
