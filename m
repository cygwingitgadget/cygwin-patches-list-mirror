Return-Path: <cygwin-patches-return-4701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13989 invoked by alias); 4 May 2004 15:15:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13979 invoked from network); 4 May 2004 15:15:06 -0000
Date: Tue, 04 May 2004 15:15:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
Message-ID: <20040504151506.GA5531@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040410233707.00846910@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00053.txt.bz2

On Sat, Apr 10, 2004 at 11:37:07PM -0400, Pierre A. Humblet wrote:
>2004-04-11  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (normalize_win32_path): Detect components with only dots.
>	Remove a final . if it follows '\\'.
>	(slash_unc_prefix_p): Remove redundant tests.
>	(mount_info::conv_to_win32_path): Only backslashify the path
>	when no mount is found.
>	(chdir): Do not look for components with only dots.

Corinna indicated to me in private email that she had no problems with the
removal of her code in chdir, so I have checked in the below patch with
minor modifications to is_unc_share.

Thanks,
cgf
