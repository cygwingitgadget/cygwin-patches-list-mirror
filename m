Return-Path: <cygwin-patches-return-5244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28604 invoked by alias); 18 Dec 2004 16:37:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28503 invoked from network); 18 Dec 2004 16:37:54 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 Dec 2004 16:37:54 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id F12B61B401; Sat, 18 Dec 2004 11:39:08 -0500 (EST)
Date: Sat, 18 Dec 2004 16:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add self to /proc (to support procps 3.2.4)
Message-ID: <20041218163908.GA5355@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <081101c4e50b$5c822310$0207a8c0@avocado>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081101c4e50b$5c822310$0207a8c0@avocado>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00245.txt.bz2

On Sat, Dec 18, 2004 at 02:10:42PM -0000, Chris January wrote:
>2004-12-18  Chris January  <chris@atomice.net>
>
>	* fhandler_proc.cc (proc_listing): Add entry for "self".
>	(proc_fhandlers): Add entry for "self".
>	* fhandler_process.cc (fhandler_process::fstate): Handle "self".
>	(fhandler_process::open): Handle "self".

Thanks, applied.

cgf
