Return-Path: <cygwin-patches-return-5129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30175 invoked by alias); 14 Nov 2004 18:45:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30141 invoked from network); 14 Nov 2004 18:45:38 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 14 Nov 2004 18:45:38 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id D26DA1B3E5; Sun, 14 Nov 2004 13:45:54 -0500 (EST)
Date: Sun, 14 Nov 2004 18:45:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041114184554.GC13076@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041114123430.008289b0@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <3.0.5.32.20041114123430.008289b0@incoming.verizon.net> <3.0.5.32.20041114132359.00829ca0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041114132359.00829ca0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00130.txt.bz2

On Sun, Nov 14, 2004 at 01:23:59PM -0500, Pierre A. Humblet wrote:
>At 01:03 PM 11/14/2004 -0500, Christopher Faylor wrote:
>>On Sun, Nov 14, 2004 at 12:34:30PM -0500, Pierre A. Humblet wrote:
>>>At 12:11 AM 11/14/2004 -0500, Christopher Faylor wrote:
>>
>>>BTW, have you ever tried using select, having a connection from the
>>>parent to the child?
>>
>>select involves polling or setting up other events to track end-of-pipe
>>conditions.  I don't think that's a win.
>
>I meant the Windows select, on sockets.

Use sockets rather than pipes?  Given all of the problems that we have
with sockets, I don't think we want to go down that path.

cgf
