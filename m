Return-Path: <cygwin-patches-return-6177-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15438 invoked by alias); 23 Nov 2007 00:22:33 -0000
Received: (qmail 15427 invoked by uid 22791); 23 Nov 2007 00:22:30 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 23 Nov 2007 00:22:26 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D00512B352; Thu, 22 Nov 2007 19:22:24 -0500 (EST)
Date: Fri, 23 Nov 2007 00:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Resource Temporarily Unavailable workaround
Message-ID: <20071123002224.GC29996@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4745B152.3070704@st.com> <20071122170051.GA29996@ednor.casa.cgf.cx> <20071122170518.GA30136@ednor.casa.cgf.cx> <4745C279.3030708@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745C279.3030708@st.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00029.txt.bz2

On Thu, Nov 22, 2007 at 05:55:05PM +0000, Andrew STUBBS wrote:
>Christopher Faylor wrote:
>>On Thu, Nov 22, 2007 at 12:00:51PM -0500, Christopher Faylor wrote:
>>>On Thu, Nov 22, 2007 at 04:41:54PM +0000, Andrew STUBBS wrote:
>>>>The attached patch adds a 'retry' to the fork system call.  Basically
>>>>it waits 10 seconds to allow the 'resource temporarily unavailable' to
>>>>become (temporarily) available once more, and tries again, up to a
>>>>maximum of three attempts.
>>>There is already a retry in the fork and spawn system calls.  This
>>>technique has proved to be problematic since it can mask problems and
>>>you can end up with situations where a process starts successfully but
>>>cygwin thinks it fails and restarts the process again.  For the exec
>>>case, there is also a problem with non-cygwin .exes.
>>>
>>>If you look for retry in the fork call you should see where this is
>>>supposed to be happening.
>>
>>Btw, it is likely that if you are seeing this problem that there is
>>something happening after the retry code in fork which is causing an
>>EAGAIN.  The existing retry code could be expanded to take that into
>>account if that is the case.
>
>Thanks, now I see the retry, but the code is impossible to follow
>without knowing both Cygwin and Windows backwards, and I don't have
>that much time to spend on this.  :(
>
>Clearly its retries aren't (always) sufficient.  Perhaps it isn't
>retrying enough, or retrying the right stuff, or maybe not waiting long
>enough between retries.

Yes, that's why I typed the above "Btw," paragraph.

>Unfortunately the problem isn't easily reproducible.  I can't use
>strace as it runs way too slowly and I would just never get to the
>problem.  I could instrument the whole file up so that I can trace just
>that, and then sit back and wait.
>
>Any suggestions?

You could use printf's to find where it is failing.

But, really, that's a pretty obvious suggestion.  I'm not sure what
suggestions you're looking for if you can't find the time to learn
anything more about Cygwin or Windows.

cgf
