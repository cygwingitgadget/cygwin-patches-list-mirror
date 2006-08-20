Return-Path: <cygwin-patches-return-5957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4560 invoked by alias); 20 Aug 2006 05:39:19 -0000
Received: (qmail 4526 invoked by uid 22791); 20 Aug 2006 05:39:18 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 20 Aug 2006 05:39:17 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id E266213C049; Sat, 19 Aug 2006 17:44:58 -0400 (EDT)
Date: Sun, 20 Aug 2006 05:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pread bug fix
Message-ID: <20060819214458.GB8981@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200608191811.AA01438@k7.kit.hi-ho.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608191811.AA01438@k7.kit.hi-ho.ne.jp>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00052.txt.bz2

On Sun, Aug 20, 2006 at 03:11:37AM +0900, Hideki IWAMOTO wrote:
>When current file offset is not zero, pread from disk file always fails.
>
>
>2006-08-20 Hideki Iwamoto  <h-iwamoto@kit.hi-ho.ne.jp>
>
>	* fhandler_disk_file.cc (fhandler_disk_file::pread): Fix comparison
>	of return value of lseek.

Applied.

Thanks for the patch.

cgf
