Return-Path: <cygwin-patches-return-3978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32430 invoked by alias); 30 Jun 2003 13:07:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32412 invoked from network); 30 Jun 2003 13:07:53 -0000
Date: Mon, 30 Jun 2003 13:07:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems on accessing Windows network resources
Message-ID: <20030630130752.GB12317@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030611230336.00807a30@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00205.txt.bz2

On Wed, Jun 11, 2003 at 11:03:36PM -0400, Pierre A. Humblet wrote:
> 	* cygheap.h (enum impersonation): New enum.
> 	(cygheap_user::token): Delete.
> 	(cygheap_user::impersonated): Delete.
> 	(cygheap_user::external_token): New member.
> 	(cygheap_user::internal_token): New member.
> 	(cygheap_user::impersonation_state): New member.
> 	(cygheap_user::issetuid): Modify.
> 	(cygheap_user::token): New method.
> 	(cygheap_user::deimpersonate): New method.
> 	(cygheap_user::reimpersonate): New method.
> 	(cygheap_user::has_impersonation_tokens): New method.
> 	(cygheap_user::close_impersonation_tokens): New method.
> 	* dtable.cc (dtable::vfork_child_dup): Use new cygheap_user methods.
> 	* fhandler_socket.cc (fhandler_socket::dup): Ditto.
> 	* fork.cc (fork_child): Ditto.
> 	(fork_parent): Ditto.
> 	* grp.cc (internal_getgroups): Ditto.
> 	* security.cc (verify_token): Ditto.
> 	(check_file_access): Ditto.
> 	(cygwin_set_impersonation_token): Detect conflicts. Set 
> 	user.external_token. 
> 	* spawn.cc (spawn_guts): Use new cygheap_user methods. 
> 	* syscalls.cc (seteuid32): Rearrange to use the two tokens
> 	in cygheap_user.
> 	(setegid32): Use new cygheap_user methods.
> 	* uinfo.cc: (internal_getlogin): Ditto. 

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
