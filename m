Return-Path: <cygwin-patches-return-5242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20153 invoked by alias); 18 Dec 2004 00:35:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19299 invoked from network); 18 Dec 2004 00:35:03 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Dec 2004 00:35:03 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 572281B401; Fri, 17 Dec 2004 19:36:15 -0500 (EST)
Date: Sat, 18 Dec 2004 00:35:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041218003615.GB3068@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net> <20041217032627.GF26712@trixie.casa.cgf.cx> <3.0.5.32.20041216224347.0082d210@incoming.verizon.net> <20041217061741.GG26712@trixie.casa.cgf.cx> <41C31496.4D9140C7@phumblet.no-ip.org> <20041217175649.GA1237@trixie.casa.cgf.cx> <41C36530.89F5A621@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C36530.89F5A621@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00243.txt.bz2

On Fri, Dec 17, 2004 at 06:01:04PM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>
>> While I detest the trailing dot crap, I don't want cygwin to be inconsistent.
>> I don't want ls /bin./ls.exe to fail but ls /cygdrive/c/bin./ls.exe to work.
>
>Assuming a normal install, the first one is c:\cygwin\bin.\ls.exe,
>which would NOT fail, while the second is c:\bin.\ls.exe, which would
>fail as expected (not due to dots).

Ok.  Yes.  I had a typo.

If /cygdrive/c/cygwin/bin./ls.exe works, then /bin./ls.exe should also work.
Or, both should fail.  "consistent"

>>I'm not sure that it makes sense for ln -s foo "bar." to actually
>>create a file with a trailing dot on a non-managed mount either.  That
>>seems to expose an implementation detail of the way links are handled
>>and it seems inconsistent to me.
>
>Perhaps, but nobody has complained about it over the years!

And, until now, no one has complained about the current behavior for
months!

>> If we are "fixing" this (I firmly believe that the code in path_conv is never
>> really going to be right) then I don't want to add inconsistencies.
>
>I agree that path_conv is never going to be "right". I would 
>not reduce functionality nor open new holes merely to reduce 
>inconsistencies due to Windows.

And there we disagree.

cgf
