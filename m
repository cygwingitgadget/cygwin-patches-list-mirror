Return-Path: <cygwin-patches-return-5847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30161 invoked by alias); 8 May 2006 15:20:15 -0000
Received: (qmail 30136 invoked by uid 22791); 8 May 2006 15:20:12 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 08 May 2006 15:20:06 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 29E8913C01E; Mon,  8 May 2006 11:20:05 -0400 (EDT)
Date: Mon, 08 May 2006 15:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Adding ".." may not work in readdir()
Message-ID: <20060508152005.GB28038@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <445F58D3.3050509@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F58D3.3050509@t-online.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00035.txt.bz2

On Mon, May 08, 2006 at 04:42:27PM +0200, Christian Franke wrote:
>Both else-if conditions at the end of readdir() are identical, so ".." 
>case will never be executed.
>
>The attached patch for fhandler_disk_file.cc 1.183 may fix this
>(untested blind patch, sorry ;-)

Thanks for the patch.  I've checked it in along with a changelog.

cgf
