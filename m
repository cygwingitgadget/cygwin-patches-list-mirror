Return-Path: <cygwin-patches-return-1727-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31884 invoked by alias); 17 Jan 2002 10:47:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31869 invoked from network); 17 Jan 2002 10:47:09 -0000
Date: Thu, 17 Jan 2002 02:47:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: fnmatch
Message-ID: <20020117114707.L2015@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D2A3E@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2A3E@cnmail>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00084.txt.bz2

On Wed, Jan 16, 2002 at 09:58:25PM -0500, Mark Bradshaw wrote:
> All right.  With blessings all around I'll do so.

So, if I understood correctly, you're going to contribute strptime().

I've just added fnmatch() from OpenBSD to Cygwin.  The only change
needed was adding a

  #include "winsup.h"

at the beginning to correctly use symbols from <ctype.h>.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
