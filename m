Return-Path: <cygwin-patches-return-5181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8285 invoked by alias); 4 Dec 2004 17:33:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8192 invoked from network); 4 Dec 2004 17:33:06 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 4 Dec 2004 17:33:06 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 84D2E1B492; Sat,  4 Dec 2004 12:33:33 -0500 (EST)
Date: Sat, 04 Dec 2004 17:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041204173333.GE15990@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00182.txt.bz2

On Sat, Dec 04, 2004 at 11:45:28AM -0500, Pierre A. Humblet wrote:
>At 12:43 AM 12/4/2004 -0500, Christopher Faylor wrote:
>>I wrote a simple test case to check this and I don't see it -- on XP.  I
>>can't easily run Me anymore.  Does the attached program demonstrate this
>>behavior when you run it?  It should re-exec itself every time you hit
>>CTRL-C.
>
>That test case has no problem, but the attached one does. 
>Use kill -30 pid

Sigh.  Works fine on XP, AFAICT.

I'll try harder to get WinMe working later today.

cgf
