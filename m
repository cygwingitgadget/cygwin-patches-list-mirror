Return-Path: <cygwin-patches-return-2258-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26699 invoked by alias); 29 May 2002 15:30:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26653 invoked from network); 29 May 2002 15:30:18 -0000
Date: Wed, 29 May 2002 08:30:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygdev <cygwin-developers@cygwin.com>,
   cygpatch <cygwin-patches@cygwin.com>
Subject: [PATCH] Changing from __uid16_t to __uid32_t
Message-ID: <20020529173016.L30892@cygbert.vinschen.de>
Mail-Followup-To: cygdev <cygwin-developers@cygwin.com>,
	cygpatch <cygwin-patches@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00241.txt.bz2

Hi,

now I've changed to 32 bit uids the same way I changed to 32 bit gids.

Yet none of the new 32 bit functions are exposed to the public.  The
only way to retrieve the correct 32 bit uids and gids currently is
using the changed `external_pinfo' struct which now contains additional
members "uid32" and "gid32".  For an example see the patch to ps.cc.

At this point we are not *that* far away from switching over to 32 bit
ids and 64 bit file offsets.  This will be done by a change to the Cygwin
Makefile so that newly build applications will get the 32 bit functions
automagically while appliocations build with older versions of Cygwin
will still use the old 16 bit functions (see the part in the Makefile
which maps the regex symbols to the new POSIX functions).  The second
change needed is to define __CYGWIN_USE_BIG_TYPES__ in the preprocessor
stage.  Otherwise a type mismatch for off_t, uid_t, gid_t and struct
group would occur at runtime.

AFAICS, there's still something missing to be able to switch eventually.

Newlib defines fpos_t as long which isn't sufficient for 64 bit file
access, obviously.  SUSv3 defines fpos_t as a type "containing all
information needed to specify uniquely every position within a file."
So, we will have to change that as well.  Unfortunately.  This means,
we have to define our own functions fgetpos and fsetpos.  Do I forgot
something?  Well, another point is to look into newlib carefully to
find occurences of calls to the old 32 bit off_t and 16 bit uid/gid
functions.  AFAIK, there are no uid/gid related function calls but
probably calls to lseek and such.

If anybody wants to take a stab on this, I'd be very glad.  Just
reporting suspect functions in newlib would already be helpful.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
