Return-Path: <cygwin-patches-return-4972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6199 invoked by alias); 22 Sep 2004 13:44:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6185 invoked from network); 22 Sep 2004 13:44:09 -0000
Date: Wed, 22 Sep 2004 13:44:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
Message-ID: <20040922134608.GA26453@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00124.txt.bz2

On Tue, Sep 21, 2004 at 09:58:40PM -0400, Pierre A. Humblet wrote:
>It's a safe time to take care of a few nits...
>
>While testing, I noticed in dir.cc that __d_dirent->d_ino
>is always set by hashing the pathname :(

This has been discussed many times throughout the years.

>2004-09-22  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (normalize_win32_path): Only look for : in second position.
>	Avoid infinite loop with names starting in double dots.
>	(mount_info::conv_to_win32_path): Do not worry about a trailing dot. 

Why not worry about a trailing dot?  Is it handled somewhere else?  The
intent is to make the inode of /foo/.  == /foo .

cgf
