Return-Path: <cygwin-patches-return-4005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4118 invoked by alias); 12 Jul 2003 08:31:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4109 invoked from network); 12 Jul 2003 08:31:03 -0000
Date: Sat, 12 Jul 2003 08:31:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030712083102.GI12368@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00021.txt.bz2

Hi Pierre,

On Fri, Jul 11, 2003 at 08:02:53PM -0400, Pierre A. Humblet wrote:
> 2003-07-12  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* cygheap.h (enum impersonation): Delete.
> 	(cygheap_user::impersonation_state): Delete.
> 	(cygheap_user::current_token): New.
> 	(cygheap_user::issetuid): Modify to use current_token.
> 	(cygheap_user::token): Ditto.
> 	(cygheap_user::deimpersonate): Ditto.
> 	(cygheap_user::reimpersonate): Ditto.
> 	(cygheap_user::has_impersonation_tokens): Ditto.
> 	(cygheap_user::close_impersonation_tokens): Ditto.
> 	* security.cc (cygwin_set_impersonation_token): Always set the token.
> 	(verify_token): Change type of gsid to cygpsid.
> 	(get_file_attribute): Use the effective ids.
> 	* syscalls.cc (seteuid32): Modify to use cygheap_user::current_token.
> 	* uinfo.cc (uinfo_init) Do not set cygheap->user.impersonation_state.

thanks for the patch but it has a problem.  You're comparing tokens against
NULL while the correct "NULL" value for tokens is INVALID_HANDLE_VALUE. 
Unfortunately I saw for the first time that you already did the same for
external_token and internal_token.  So currently the code sometimes
compares with NULL and sometimes compares with INVALID_HANDLE_VALUE.  Could
you please change that to always use INVALID_HANDLE_VALUE?  This implies
to initialize current_token, external_token and internal_token all three
to INVALID_HANDLE_VALUE.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
