Return-Path: <cygwin-patches-return-2743-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22739 invoked by alias); 29 Jul 2002 12:55:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22725 invoked from network); 29 Jul 2002 12:55:06 -0000
Date: Mon, 29 Jul 2002 05:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: setgroups
Message-ID: <20020729145504.A18176@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <3.0.5.32.20020726000410.00813de0@mail.attbi.com> <3.0.5.32.20020728211223.00819100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020728211223.00819100@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00191.txt.bz2

On Sun, Jul 28, 2002 at 09:12:23PM -0400, Pierre A. Humblet wrote:
> 2002-07-28 Pierre Humblet <Pierre.Humblet@ieee.org>
> 
> 	* cygheap.h (class cygheap_user): Add member groups.
> 	* security.h (class cygsidlist): Add members type and maxcount, 
> 	methods position, addfromgr, alloc_sids and free_sids and
> 	operator+= (const PSID psid). Modify contains () to call 
> 	position () and optimize add () to use maxcount.
> 	(class user_groups): Create.
> 	Update declarations of verify_token and create_token.
> 	* security.cc (cygsidlist::alloc_sids): New.
> 	(cygsidlist::free_sids): New. 
> 	(get_token_group_sidlist): Create from get_group_sidlist.
> 	(get_initgroups_sidlist): Create from get_group_sidlist.
> 	(get_group_sidlist): Suppress.
> 	(get_setgroups_sidlist): Create.
> 	(verify_token): Modify arguments. Add setgroups case.
> 	(create_token): Modify arguments. Call get_initgroups_sidlist and
> 	get_setgroups_sidlist as needed. Set SE_GROUP_LOGON_ID from auth_pos
> 	outside of the loop. Rename the various group sid lists consistently.
> 	* syscalls.cc (seteuid32): Modify to use cygheap->user.groups.
> 	(setegid32): Call cygheap->user.groups.update_pgrp.
> 	* grp.cc (setgroups): Create.
> 	(setgroups32): Create.
> 	* uinfo.cc (internal_getlogin): Initialize and update user.groups.pgsid.
> 	* cygwin.din: Add setgroups and setgroups32.

Thanks a lot.  I've applied it with some formatting changes.  Please,
don't do this

	if (expr) statement;

I found some of them in security.cc.  I took the chance to do some more
formatting changes in security.cc. 

This time I even remembered to bump the API minor version in
include/cygwin/version.h :-)

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
