Return-Path: <cygwin-patches-return-4559-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2731 invoked by alias); 5 Feb 2004 17:43:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2722 invoked from network); 5 Feb 2004 17:43:06 -0000
Date: Thu, 05 Feb 2004 17:43:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: well_known_sids
Message-ID: <20040205174304.GK26148@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net> <20040205103858.GB9090@cygbert.vinschen.de> <402268A4.243CE18E@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402268A4.243CE18E@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00049.txt.bz2

On Feb  5 11:00, Pierre A. Humblet wrote:
> > > 2004-02-04  Pierre Humblet <pierre.humblet@ieee.org>
> > >
> > >       * security.h (SID): New macro.
> > >       (well_known_*_sid): Change type to cygpsid.
> > >       (cygsid::init): Delete declaration.
> > >       * sec_helper.cc (well_known_*_sid): Define as cygpsid and initialize.
> > >       (cygsid::init): Delete.
> > >       * dcrt0.cc (dll_crt0_0): Do not call cygsid::init.
> > >       * security.cc (get_user_local_groups): Change the second argument type to
> > > cygpsid.
> > 
> > What about this definition of SID instead:
> 
> Wonderful!
> I assume you will apply everything.

Done.  I was a bit surprised that the below patch works as expected,
though.  I want to give it a test first.

> 2004-02-05  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* uinfo.cc (cygheap_user::init): Use sec_user_nih to build a
> 	security descriptor. Set both the process and the default DACLs.
> 	* fork.cc (fork_parent): Use sec_none_nih security attributes.
> 	* spawn.cc (spawn_guts): Ditto.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
