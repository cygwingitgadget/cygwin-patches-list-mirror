Return-Path: <cygwin-patches-return-4527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28180 invoked by alias); 23 Jan 2004 10:08:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28171 invoked from network); 23 Jan 2004 10:08:57 -0000
Date: Fri, 23 Jan 2004 10:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: 2. Thread safe stdio update
Message-ID: <20040123100856.GD12512@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40103708.1020501@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40103708.1020501@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00017.txt.bz2

On Jan 22 21:48, Thomas Pfaff wrote:
> This is an update of my previous patch. It adds support for newlibs 
> __LOCK_INIT macro.
> 
> Thomas
> 
> 2004-01-22 Thomas Pfaff <tpfaff@gmx.net>
> 
> 	* include/sys/_types.h: New file.

I'm not quite sure if that's the way to go.  I'm wondering if we
shouldn't keep newlib's _types.h and change it like this:

  #ifdef __CYGWIN__
  #include <cygwin/_types.h>
  #endif

  #ifndef __CYGWIN__
  typedef int _flock_t;
  #endif

Then we can create a cygwin/_types.h with the correct _flock_t definition.
IMHO that's cleaner than just overloading newlib's _types.h.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
