Return-Path: <cygwin-patches-return-4791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5198 invoked by alias); 30 May 2004 04:55:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5179 invoked from network); 30 May 2004 04:55:37 -0000
Date: Sun, 30 May 2004 04:55:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make add_item smarter
Message-ID: <20040530045535.GA13144@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040530002148.0081b840@incoming.verizon.net> <3.0.5.32.20040530004813.00812b90@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040530004813.00812b90@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00143.txt.bz2

On Sun, May 30, 2004 at 12:48:13AM -0400, Pierre A. Humblet wrote:
>Yes, we need to remove the final slash, it can be present at the
>output of normalize_path
>
> 150  761725 [main] mount 671605 mount_info::add_item: c:/gggg/[c:\gggg\],
>/hagfsfd/[/hagfsfd/], 0xA

But wouldn't it be faster to just query *tail?

cgf
