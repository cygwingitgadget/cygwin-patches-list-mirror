Return-Path: <cygwin-patches-return-5422-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7349 invoked by alias); 4 May 2005 01:20:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7322 invoked from network); 4 May 2005 01:20:16 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 4 May 2005 01:20:16 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id EDDF413C7E2; Tue,  3 May 2005 21:20:15 -0400 (EDT)
Date: Wed, 04 May 2005 01:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix startup race in shared.cc
Message-ID: <20050504012015.GE23476@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d593nc$uam$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d593nc$uam$1@sea.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00018.txt.bz2

On Tue, May 03, 2005 at 05:11:44PM -0700, Usman Muzaffar wrote:
>Still seeing incorrect "version mismatch" messages for processes
>starting simultaneously on dual-processor systems; I believe this
>patch to the recent locking work in shared.cc fixes the "user shared
>memory version" errors I'm seeing.

I don't believe that your patch goes far enough to ensure the
consistency of the shared memory before checking things.  I've checked
in a change which should ensure that the area has been initialized
before it is used.

Thanks for the patch and for pointing to the location of the problem.

cgf
