Return-Path: <cygwin-patches-return-2480-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23489 invoked by alias); 21 Jun 2002 04:57:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23473 invoked from network); 21 Jun 2002 04:57:43 -0000
Date: Thu, 20 Jun 2002 21:57:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: uinfo.cc & environ.cc
Message-ID: <20020621045824.GB15661@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020621000918.007f9dc0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020621000918.007f9dc0@mail.attbi.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00463.txt.bz2

On Fri, Jun 21, 2002 at 12:09:18AM -0400, Pierre A. Humblet wrote:
>Chris,
>
>just a few nits.
>
>2002-06-20  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* uinfo.cc (cygheap_user::ontherange): Use env_name for NetUserGetInfo.
>	(cygheap_user::env_logsrv): Verify env_domain is valid.
>	* environ.cc: Include child_info.h and keep spenvs[] sorted.
>	(environ_init): Check child_proc_info instead of myself->ppid_handle.

Good nits.  Applied.

Thanks,
cgf
