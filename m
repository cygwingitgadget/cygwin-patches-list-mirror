Return-Path: <cygwin-patches-return-5229-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24128 invoked by alias); 17 Dec 2004 03:25:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24095 invoked from network); 17 Dec 2004 03:25:17 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 17 Dec 2004 03:25:17 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 19E8A1B401; Thu, 16 Dec 2004 22:26:27 -0500 (EST)
Date: Fri, 17 Dec 2004 03:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
Message-ID: <20041217032627.GF26712@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041216160322.GC16474@cygbert.vinschen.de> <41C1A1F4.CD3CC833@phumblet.no-ip.org> <20041216150040.GA23488@trixie.casa.cgf.cx> <20041216155339.GA16474@cygbert.vinschen.de> <20041216155707.GG23488@trixie.casa.cgf.cx> <20041216160322.GC16474@cygbert.vinschen.de> <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00230.txt.bz2

On Thu, Dec 16, 2004 at 10:04:41PM -0500, Pierre A. Humblet wrote:
>At 11:06 AM 12/16/2004 -0500, Christopher Faylor wrote:
>>On Thu, Dec 16, 2004 at 05:03:22PM +0100, Corinna Vinschen wrote:
>>>On Dec 16 10:57, Christopher Faylor wrote:
>>>> On Thu, Dec 16, 2004 at 04:53:39PM +0100, Corinna Vinschen wrote:
>>>> >Since the mount code is called from path_conv anyway, wouldn't it be
>>>> >better to pass the information "managed mount or not" up to path_conv?
>>>> 
>>>> How about just doing the pathname munging in `conv_to_win32_path' if/when
>>>> it's needed?
>>>
>>>Erm... I'm not quite sure, but didn't the "remove trailing dots and spaces"
>>>code start there and has been moved to path_conv by Pierre to circumvent
>>>some problem?  I recall only very vaguely right now.
>>
>>One problem that it would circumvent is that currently, if you do this:
>>
>>ls /bin......................................
>>
>>You'll get a listing of the bin directory.  If you move the code to
>>conv_to_win32_path that may not be as easy to get right.
>
>The initial trailing dots and space test was put in normalize_posix path,
>not conv_to_win32_path. That was done to fix a side effect of
>NtCreateFile, without considering all the many issues.
>
>Putting it in conv_to_win32_path will forbid files ending in .lnk
>or .exe but that are called without these suffixes. 
>This should not happen:
>~: ln -s /etc 'abc . .'
>~: ls abc*
>ls: abc . .: No such file or directory
>~: rm 'abc . ..lnk'
>rm: remove `abc . ..lnk'? y
>
>It's also called during each iteration of the check() loop, which is
>unnecessary.
>
>Putting it in mount_item::build_win32 (as Mark as just done) suffers
>from the same problems, and misses a number of cases where it's needed.
>
>The attached patch puts the test at the end of check(), and only if the
>file doesn't start with //./ 
>I can't test for the moment due to the state of my sandbox.
>
>I believe that the tests for .... in normalize_{posix,win32}_path are now
>irrelevant, but I'd like Corinna to confirm (she introduced the test
>on 2003-10-25).
>Due to those tests, suffixes consisting entirely of dots are still 
>disallowed.
>
>Also, for my info, what is the unc\ in
>       !strncasematch (this->path + 4, "unc\\", 4)))
>around line 868? I have never seen that documented.
>
>Pierre
>
>
>	* path.cc (path_conv::check): Check the output Win32 path for trailing
>	spaces and dots, not the input path.

I don't see how it could be correct for the slash checking code not to
be "in the loop".  Won't this cause a problem if you've done

ln -s foo/ bar

?

I've taken a spin through the code and encapsulated the buffer+tail
stuff into one struct.  It actually seems to clean up some of the code
slightly to store the path buffer with its tail information.

I'm running this through the testsuite now but I think I've fallen
afoul of my recent process handling changes.  I should have run the
test suite on those before I checked anything in.

cgf
