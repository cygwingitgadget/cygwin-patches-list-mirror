Return-Path: <cygwin-patches-return-4009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27423 invoked by alias); 14 Jul 2003 17:05:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27414 invoked from network); 14 Jul 2003 17:05:40 -0000
Date: Mon, 14 Jul 2003 17:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030714170539.GE12368@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030711200253.00807190@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00025.txt.bz2

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

I've applied this patch.  I've just changed the code to use
INVALID_HANDLE_VALUE instead of NULL throughout.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
