Return-Path: <cygwin-patches-return-4194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23115 invoked by alias); 10 Sep 2003 07:54:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23100 invoked from network); 10 Sep 2003 07:54:35 -0000
Date: Wed, 10 Sep 2003 07:54:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Part 2 of Fixing a security hole in mount table.
Message-ID: <20030910075433.GB5268@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030909235426.008236c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030909235426.008236c0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00210.txt.bz2

On Tue, Sep 09, 2003 at 11:54:26PM -0400, Pierre A. Humblet wrote:
> 2003-09-10  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* shared_info.h (shared_info::initialize): Remove argument.
> 	* cygheap.h (cygheap_user::init): New declaration.
> 	* uinfo.cc (cygheap_user::init): New.
> 	(internal_getlogin): Move functionality to cygheap_user::init.
> 	Open the process token to update the group sid.
> 	* shared.cc (user_shared_initialize): Get the user information
> 	from cygheap->user.
> 	(shared_info::initialize): Remove argument. Call cygheap->user.init
> 	instead of cygheap->user.set_name.
> 	(memory_init): Do not get the user name and do not pass it to
> 	shared_info::initialize.
> 	* registry.cc (get_registry_hive_path): Make csid a cygpsid.
> 	(load_registry_hive): Ditto.

Looks good to me, except for:

> -  char name[UNLEN + 1] = "";
> +  char name[UNLEN > 127 ? UNLEN + 1 : 128] = "";

Huh?  Why that?  UNLEN is defined as 256 in lmcons.h so I don't understand
the reasoning behind that complexity.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
