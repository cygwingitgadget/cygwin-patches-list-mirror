Return-Path: <cygwin-patches-return-5178-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8877 invoked by alias); 3 Dec 2004 02:49:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8850 invoked from network); 3 Dec 2004 02:49:11 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 3 Dec 2004 02:49:11 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 3A5431B491; Thu,  2 Dec 2004 21:49:33 -0500 (EST)
Date: Fri, 03 Dec 2004 02:49:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041203024933.GE762@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00179.txt.bz2

On Thu, Dec 02, 2004 at 09:13:11PM -0500, Pierre A. Humblet wrote:
>- Non cygwin processes started by cygwin are not shown by ps
>  anymore and cannot be killed.
>
>- spawn(P_DETACH) does not work correctly when spawning non-cygwin 
>  processes.
>  This is due to using a pipe to detect process termination. 

The above are both unintentional and fixable.

cgf
