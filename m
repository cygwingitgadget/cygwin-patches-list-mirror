Return-Path: <cygwin-patches-return-5373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31040 invoked by alias); 7 Mar 2005 16:27:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30975 invoked from network); 7 Mar 2005 16:27:32 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 7 Mar 2005 16:27:32 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 2BD821B55F; Mon,  7 Mar 2005 11:28:07 -0500 (EST)
Date: Mon, 07 Mar 2005 16:27:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Timer functions
Message-ID: <20050307162807.GC4591@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net> <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net> <3.0.5.32.20050306234015.00b5a598@incoming.verizon.net> <003401c52331$a412c3b0$ac05a8c0@wirelessworld.airvananet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003401c52331$a412c3b0$ac05a8c0@wirelessworld.airvananet.com>
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q1/txt/msg00076.txt.bz2

On Mon, Mar 07, 2005 at 11:20:40AM -0500, Pierre A. Humblet wrote:
>----- Original Message ----- 
>From: "Pierre A. Humblet" 
>Sent: Sunday, March 06, 2005 11:40 PM
>Subject: Re: [Patch]: Timer functions
>
>
>> At 11:00 PM 3/6/2005 -0500, Christopher Faylor wrote:
>> >I am puzzled by a couple of things.
>> >
>> >Why did you decide to forego using th->detach in favor of (apparently)
>> >a:
>> >
>> >      while (running)
>> > low_priority_sleep (0);
>> 
>> These are not directly related. I got into this issue because of the bug
>> where cygthreads were not reused. I replaced th->detach by self_release
>> because that seemed to be the most natural and efficient way
>> to fix the problem. 
>
>Also that frees the cygthread when the timer expires, not when it's 
>rearmed (if ever).

The design was that the thread is associated with the timer for as long
as the timer exists.  The fact that it wasn't being detached when the
timer was deleted is a bug.

I don't see any reason to reinvent a less efficient way of detaching
from the thread when detach should do the job.

cgf
