Return-Path: <cygwin-patches-return-4588-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16908 invoked by alias); 8 Mar 2004 21:18:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16899 invoked from network); 8 Mar 2004 21:18:16 -0000
Date: Mon, 08 Mar 2004 21:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: sigproc.cc (proc_subproc): make -j hang
Message-ID: <20040308211814.GB1389@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0403081435020.11361@thing1-200>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403081435020.11361@thing1-200>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00078.txt.bz2

On Mon, Mar 08, 2004 at 03:05:12PM -0600, Brian Ford wrote:
>While trying to analyze my own strace example of a "make -j hang" ala this
>ugly thread:
>
>http://www.cygwin.com/ml/cygwin/2004-03/msg00376.html
>
>My last strace output from the hung make process was:
>   69 1576822 [proc] make 6724 proc_subproc: pid 7524[0], reparented old
>hProcess 0x698, new 0x63C
>
>So, looking there, I stumbled onto the following:
>
>2004-03-08  Brian Ford  <ford@vss.fsi.com>
>
>	* sigproc.cc (proc_subproc): Only call sync_proc_subproc->release()
>	once for exec().
>
>I'm not sure this is a bug, and it doesn't appear to fix the make hang I
>was looking at, but I thought it deserved a quick review by someone who
>knows that code :).  Thanks.

While it probably shouldn't be doing what you discovered, the only effect
your fix should have is to bypass a no-op call to muto::release.  Once a
muto has been released, calling release again should have no effect.
So, calling release twice should not be a problem.  If this was truly a
problem then every exec would have a problem.

What seems to be happening in the CVS version of cygwin is that cygwin
routines are getting incorrectly interrupted during the function
execution instead of after the function returns.

cgf
