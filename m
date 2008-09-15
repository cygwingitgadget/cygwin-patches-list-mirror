Return-Path: <cygwin-patches-return-6352-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 689 invoked by alias); 15 Sep 2008 22:29:08 -0000
Received: (qmail 679 invoked by uid 22791); 15 Sep 2008 22:29:08 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-61.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.61)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 15 Sep 2008 22:28:33 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id EECD935C2E; Mon, 15 Sep 2008 18:28:31 -0400 (EDT)
Date: Mon, 15 Sep 2008 22:29:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix unlink for Cygwin 1.5.25-15 -- unintended data 	loss with symbolic file links
Message-ID: <20080915222831.GA10709@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <003801c9177a$5debc030$19c34090$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c9177a$5debc030$19c34090$@com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00015.txt.bz2

On Mon, Sep 15, 2008 at 02:31:07PM -0700, Jason wrote:
>Please consider the patch below for inclusion in the Cygwin 1.5 branch which
>corrects the deletion of symbolic link file types (Vista file reparse
>points).
>
>The problem is that CreateFile will open the target and not the link.  See
>the MSDN page
>http://msdn.microsoft.com/en-us/library/aa365682(VS.85).aspx#CreateFile for
>a more detailed description of Vista's symbolic link handling.

Sorry but we're not anticipating any new releases of Cygwin 1.5.x.

cgf 
