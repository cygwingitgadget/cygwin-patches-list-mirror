Return-Path: <cygwin-patches-return-5286-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1341 invoked by alias); 24 Dec 2004 05:24:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 983 invoked from network); 24 Dec 2004 05:23:54 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 24 Dec 2004 05:23:54 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id C78A71B401; Fri, 24 Dec 2004 00:25:26 -0500 (EST)
Date: Fri, 24 Dec 2004 05:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041224052526.GB22543@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org> <41C9C088.9E9B16E3@phumblet.no-ip.org> <3.0.5.32.20041223182306.00824b60@incoming.verizon.net> <3.0.5.32.20041223215420.0082b790@incoming.verizon.net> <3.0.5.32.20041223230550.0081e100@incoming.verizon.net> <3.0.5.32.20041223235959.0081ba80@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041223235959.0081ba80@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00287.txt.bz2

On Thu, Dec 23, 2004 at 11:59:59PM -0500, Pierre A. Humblet wrote:
>At 11:35 PM 12/23/2004 -0500, Christopher Faylor wrote:
>>I don't think you need it.  You just need to tell a process which is
>>about to exec after having been execed to make sure that its
>>wr_proc_pipe is valid.
>
>Yes, that's the key. So the question is only about method. Either the parent
>guarantees that the child has a valid handle, or the child must check
>that it already has a valid handle or wait until it does. 

I have just implemented code which causes an execed child to wait for the
parent to fill in its wr_proc_pipe if it is going to exec again.  It uses
a busy loop but I think it's unlikely that the loop will be exercised too
often.

I'm testing it now.

cgf
