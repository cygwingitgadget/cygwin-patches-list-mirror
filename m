Return-Path: <cygwin-patches-return-5362-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26671 invoked by alias); 2 Mar 2005 15:57:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26258 invoked from network); 2 Mar 2005 15:56:30 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 2 Mar 2005 15:56:30 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 7ADCB1B55F; Wed,  2 Mar 2005 10:56:48 -0500 (EST)
Date: Wed, 02 Mar 2005 15:57:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygstart patch
Message-ID: <20050302155648.GB15633@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D88D820A7BC0479A7B0932D4219EFE1A4BC7@NAEAPAXREX04VA.nadsusea.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D88D820A7BC0479A7B0932D4219EFE1A4BC7@NAEAPAXREX04VA.nadsusea.nads.navy.mil>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2005-q1/txt/msg00065.txt.bz2

On Wed, Mar 02, 2005 at 10:47:40AM -0500, Derosa, Anthony  CIV NAVAIR 2035, 2, 205/214 wrote:
>I found a small bug and added a feature to the cygstart utility, which
>is part of the cygutils package.  The feature that I added removes the
>limit on the length of the command line arguments passed to the target
>application, which was previously limited to MAX_PATH.  The bug I fixed
>was in regard to freeing the variable "args" instead of tyring to free
>"workDir" twice.  A patch and change log follow below.  As this is my
>first contribution, please correct me if I did something incorrectly.

AFAICT, the patch looks fine but this mailing list is for patches to the
cygwin DLL.

Please send your patch to the cygwin mailing list.

cgf
