Return-Path: <cygwin-patches-return-2972-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21546 invoked by alias); 16 Sep 2002 08:30:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21532 invoked from network); 16 Sep 2002 08:30:16 -0000
Date: Mon, 16 Sep 2002 01:30:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: initgroups
Message-ID: <20020916103014.A6942@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D7F4284.46484222@ieee.org> <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com> <20020911123808.Q1574@cygbert.vinschen.de> <3D7F4284.46484222@ieee.org> <3.0.5.32.20020911204241.00810100@mail.attbi.com> <20020913104233.C1574@cygbert.vinschen.de> <3D81F339.6766E6CD@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D81F339.6766E6CD@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00420.txt.bz2

On Fri, Sep 13, 2002 at 10:16:25AM -0400, Pierre A. Humblet wrote:
> Good point. But that's due to the transition from 16 to 32 bits (when do
> you plan to complete it?) and it depends on the user's perspective.

The transition to 32 bit uids/gids is functional complete AFAICS.
Originally I planned to switch over to 32 bit uids/gids together with
64 bit off_t/fpos_t in one go but for the latter step I'd need to
change newlib.  I simply have not enough time and can't be bothered
to change this.

So, if we want 32 bit uids/gids ASAP, we either have to use other
define in the header files (__CYGWIN_USE_32_BIT_IDS__ and
__CYGWIN_USE_64_BIT_OFFS__ instead of the one __CYGWIN_USE_BIG_TYPES__)
and then we'd need to change the Cygwin Makefile to use the 32 bit
funcs and define __CYGWIN_USE_32_BIT_IDS__.
Or somebody else cares for getting newlib into 64 bit off_t/fpos_t
shape.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
