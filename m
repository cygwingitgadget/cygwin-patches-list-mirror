Return-Path: <cygwin-patches-return-5367-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17468 invoked by alias); 4 Mar 2005 13:27:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17431 invoked from network); 4 Mar 2005 13:27:42 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.154.17)
  by sourceware.org with SMTP; 4 Mar 2005 13:27:42 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id ICTX8G-0002GS-PA
	for cygwin-patches@cygwin.com; Fri, 04 Mar 2005 08:27:07 -0500
Message-Id: <3.0.5.32.20050304082707.00b439b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 04 Mar 2005 13:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Timer functions
In-Reply-To: <20050304051345.GB11743@trixie.casa.cgf.cx>
References: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
 <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q1/txt/msg00070.txt.bz2

At 12:13 AM 3/4/2005 -0500, Christopher Faylor wrote:
>On Thu, Mar 03, 2005 at 11:45:45PM -0500, Pierre A. Humblet wrote:
>>- the mu_to was not reinitialized on forks (non-inheritable event).
>
>I just spent at least ten minutes looking for a "mu_to" in cygwin,
>trying to figure out what you were referring to.  I'm not sure why
>you're putting an underscore in the middle there.  Maybe you're thinking
>that the "mu" and "to" have separate meanings but they really don't.

Good question. Perhaps because it was late and there is an _ before
the muto in new_muto.

>Did you actually see mutos not getting created?  Looking at the code
>now, it seems like there would be a new muto created every time
>there is a new instance of timer_tracker, which was certainly wrong but
>it is different from mutos not being created after a fork.

As far as I could see, the muto was only created by the constructor of
ttstart and not recreated after a fork. But perhaps you are right and it
was created every time. At any rate it should be OK now.

Pierre
