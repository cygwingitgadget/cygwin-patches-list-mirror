Return-Path: <cygwin-patches-return-5131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11652 invoked by alias); 16 Nov 2004 02:58:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11594 invoked from network); 16 Nov 2004 02:58:46 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 16 Nov 2004 02:58:46 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 1862D1B3E5; Mon, 15 Nov 2004 21:59:07 -0500 (EST)
Date: Tue, 16 Nov 2004 02:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading the registry hive on Win9x
Message-ID: <20041116025907.GB15971@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041115212136.00817700@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041115212136.00817700@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00132.txt.bz2

On Mon, Nov 15, 2004 at 09:21:36PM -0500, Pierre A. Humblet wrote:
>This patch is the first of two to also load the registry hive on
>Win9x during seteuid, and to apply the method recommended in
>MS KB 199190 to avoid using HKCU.
> 
>This will yield the correct user mounts under ssh, telnet, etc...
>
>Using the new method cygheap_user::get_windows_id() also streamlines
>some aspects of Cygwin, e.g. in shared.cc below and more tomorrow.

Ok.  Please check in.

Thanks.

cgf
