Return-Path: <cygwin-patches-return-4589-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17460 invoked by alias); 8 Mar 2004 22:03:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17387 invoked from network); 8 Mar 2004 22:03:11 -0000
X-Authentication-Warning: thing1-200.fsi.com: ford owned process doing -bs
Date: Mon, 08 Mar 2004 22:03:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@thing1-200
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: sigproc.cc (proc_subproc): make -j hang
In-Reply-To: <20040308211814.GB1389@redhat.com>
Message-ID: <Pine.GSO.4.58.0403081552120.10530@thing1-200>
References: <Pine.GSO.4.58.0403081435020.11361@thing1-200>
 <20040308211814.GB1389@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q1/txt/msg00079.txt.bz2

On Mon, 8 Mar 2004, Christopher Faylor wrote:

> On Mon, Mar 08, 2004 at 03:05:12PM -0600, Brian Ford wrote:
> >While trying to analyze my own strace example of a "make -j hang" ala this
> >ugly thread:
> >
> >http://www.cygwin.com/ml/cygwin/2004-03/msg00376.html
> >
> >My last strace output from the hung make process was:
> >   69 1576822 [proc] make 6724 proc_subproc: pid 7524[0], reparented old
> >hProcess 0x698, new 0x63C
> >
> >So, looking there, I stumbled onto the following:
> >
> >2004-03-08  Brian Ford  <ford@vss.fsi.com>
> >
> >	* sigproc.cc (proc_subproc): Only call sync_proc_subproc->release()
> >	once for exec().
> >
> >I'm not sure this is a bug, and it doesn't appear to fix the make hang I
> >was looking at, but I thought it deserved a quick review by someone who
> >knows that code :).  Thanks.
>
> While it probably shouldn't be doing what you discovered, the only effect
> your fix should have is to bypass a no-op call to muto::release.  Once a
> muto has been released, calling release again should have no effect.
> So, calling release twice should not be a problem.  If this was truly a
> problem then every exec would have a problem.
>
Yeah, I know.  Like I said, it doesn't fix my problem.

Just practicing my "stupid patch tricks" again :).  I'm getting good at
them.  Now, if I can just get good a "really useful patch tricks", that
would be great!

> What seems to be happening in the CVS version of cygwin is that cygwin
> routines are getting incorrectly interrupted during the function
> execution instead of after the function returns.
>
You still see this behavior after your fix?  I think the problem has
now changed to the 0% CPU make hang, as others have stated.

BTW, did moving the ProtectHandle1 call at line 349 outside the lock cause
a race with the ForceCloseHandle1 at line 516 in proc_terminate?  My
limited testing shows much greater stability when it is moved back in.
Just curious.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
