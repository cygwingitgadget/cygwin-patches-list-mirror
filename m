Return-Path: <cygwin-patches-return-4607-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19613 invoked by alias); 14 Mar 2004 15:50:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19604 invoked from network); 14 Mar 2004 15:50:50 -0000
Date: Sun, 14 Mar 2004 15:50:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rmdir
Message-ID: <20040314155050.GA18411@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040314104606.00800590@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040314104606.00800590@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00097.txt.bz2

On Sun, Mar 14, 2004 at 10:46:06AM -0500, Pierre A. Humblet wrote:
>
>2004-03-14  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* dir.cc (rmdir): Construct real_dir with flag PC_FULL.
>	Use a loop instead of recursion to handle the current directory.

Looks good.  Please apply.

Thanks,
cgf
