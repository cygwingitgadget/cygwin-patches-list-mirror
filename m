Return-Path: <cygwin-patches-return-4590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18764 invoked by alias); 8 Mar 2004 22:50:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18731 invoked from network); 8 Mar 2004 22:50:07 -0000
X-Authentication-Warning: thing1-200.fsi.com: ford owned process doing -bs
Date: Mon, 08 Mar 2004 22:50:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@thing1-200
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: sigproc.cc (proc_subproc): make -j hang
In-Reply-To: <Pine.GSO.4.58.0403081552120.10530@thing1-200>
Message-ID: <Pine.GSO.4.58.0403081649340.10530@thing1-200>
References: <Pine.GSO.4.58.0403081435020.11361@thing1-200>
 <20040308211814.GB1389@redhat.com> <Pine.GSO.4.58.0403081552120.10530@thing1-200>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q1/txt/msg00080.txt.bz2

On Mon, 8 Mar 2004, Brian Ford wrote:

> BTW, did moving the ProtectHandle1 call at line 349 outside the lock cause
> a race with the ForceCloseHandle1 at line 516 in proc_terminate?  My
> limited testing shows much greater stability when it is moved back in.
> Just curious.
>
Same hang, it just took 1162 iterations this time.  Ugh!

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
