Return-Path: <cygwin-patches-return-2294-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19102 invoked by alias); 3 Jun 2002 17:07:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18590 invoked from network); 3 Jun 2002 17:07:00 -0000
Date: Mon, 03 Jun 2002 10:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Name aliasing in security.cc
Message-ID: <20020603190657.B22554@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020530215740.007fc380@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00277.txt.bz2

On Thu, May 30, 2002 at 09:57:40PM -0400, Pierre A. Humblet wrote:
> a) keep lookup_name() as it is?
> b) remove it entirely?
> c) call it whenever a SID is missing from a passwd/group entry, using
> user independent search rules (except if a user looks up itself)? 

I think b) is the way to go.  IMHO we should deprecate using ntsec
w/o SID in the passwd/group files.

> 2002-05-30  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* security.cc (lsa2wchar): Suppressed.
> 	(get_lsa_srv_inf): Suppressed.
> 	(get_logon_server_and_user_domain): Suppressed.
> 	(get_logon_server): Essentially new.
> 	(get_user_groups): Add "domain" argument. Only lookup the
> 	designated server and use "domain" in LookupAccountName.
> 	(is_group_member): Simplify the arguments.
> 	(get_user_local_groups): Simplify the arguments. Do only a
> 	local lookup. Use "BUILTIN" and local domain in LookupAccountName.
> 	(get_user_primary_group). Only lookup the designated server.
> 	(get_group_sidlist): Remove logonserver argument. Do not lookup
> 	any server for the SYSTEM account.
> 	(create_token): Delete logonserver and call to get_logon_server.
> 	Adjust arguments of get_group_sidlist, see above.
> 	* security.h: Delete declaration of get_logon_server_and_user_domain
> 	and add declaration of get_logon_server.
> 	* uinfo.cc (internal_get_login): Call get_logon_server instead of
> 	get_logon_server_and_user_domain.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
