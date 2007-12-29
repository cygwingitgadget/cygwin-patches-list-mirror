Return-Path: <cygwin-patches-return-6222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25648 invoked by alias); 29 Dec 2007 19:19:57 -0000
Received: (qmail 25637 invoked by uid 22791); 29 Dec 2007 19:19:56 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-37-220.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (96.233.37.220)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 19:19:47 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 94E442B352; Sat, 29 Dec 2007 14:19:45 -0500 (EST)
Date: Sat, 29 Dec 2007 19:19:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: Cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: BLODA update for bmnet.dll detect
Message-ID: <20071229191945.GA25723@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin patches <cygwin-patches@cygwin.com>
References: <075301c84a49$c2b3cb10$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075301c84a49$c2b3cb10$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00074.txt.bz2

On Sat, Dec 29, 2007 at 06:36:43PM -0000, Dave Korn wrote:
>Here's an update that adds BLODA detection for the ByteMobile laptop
>optimisation client that Corinna discovered causing problems.
>
>
>winsup/utils/ChangeLog
>
>2007-12-29 Dave Korn <dave.korn@artimi.com>
>
>* bloda.cc (enum bad_app): Add BYTEMOBILE.  (dodgy_app_detects[]): Add
>FILENAME entry to detect bmnet.dll.  (big_list_of_dodgy_apps[]): Add
>description for BYTEMOBILE.

Please checkin.  You don't need to ask for approval to add to this list.
Please consider yourself the maintainer of this file.

cgf
