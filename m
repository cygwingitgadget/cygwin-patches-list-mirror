Return-Path: <cygwin-patches-return-2193-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14996 invoked by alias); 17 May 2002 09:32:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14944 invoked from network); 17 May 2002 09:32:52 -0000
Date: Fri, 17 May 2002 02:32:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: set_errno() fixes
Message-ID: <20020517113250.H7555@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020516205822.007f7b20@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020516205822.007f7b20@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00177.txt.bz2

On Thu, May 16, 2002 at 08:58:22PM -0400, Pierre A. Humblet wrote:
> 2002-05-16  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler_raw.cc (fhandler_dev_raw::open): Replace set_errno()
> 	by __seterrno_from_win_error(). 
> 	* security.cc (open_local_policy): Ditto. (get_lsa_srv_inf): Ditto.
> 	(get_user_groups): Ditto. (get_user_primary_group): Ditto.
> 	(create_token): Ditto. (subauth): Ditto.
> 
> I have also removed some debug_printf() when the printf()'s from
> __seterrno_from_win_error() are unambiguous.

Thanks, applied.  I've just fixed the above ChangeLog entry.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
