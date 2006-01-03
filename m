Return-Path: <cygwin-patches-return-5692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31237 invoked by alias); 3 Jan 2006 15:49:47 -0000
Received: (qmail 31220 invoked by uid 22791); 3 Jan 2006 15:49:46 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 03 Jan 2006 15:49:44 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 36A1713C49C; Tue,  3 Jan 2006 10:49:43 -0500 (EST)
Date: Tue, 03 Jan 2006 15:49:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix readdir version 2
Message-ID: <20060103154943.GA3178@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20060103T162947-375@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060103T162947-375@post.gmane.org>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00001.txt.bz2

On Tue, Jan 03, 2006 at 03:30:23PM +0000, Eric Blake wrote:
>2006-01-03  Eric Blake  <ebb9@byu.net>
>
>	* dir.cc (readdir_worker): Update saw_dot* flags in version 2.

I've applied this but it didn't apply cleanly.  You apparently somehow
munged the indentation, AFAICT.  Also, I added a new ChangeLog entry
since I didn't know what "version 2" referred to.

Thanks for the patch.

cgf
