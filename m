Return-Path: <cygwin-patches-return-2156-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6083 invoked by alias); 6 May 2002 10:06:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6009 invoked from network); 6 May 2002 10:05:56 -0000
Date: Mon, 06 May 2002 03:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Security patches
Message-ID: <20020506120554.H9238@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020309192813.007fcb70@pop.ne.mediaone.net> <20020314133309.Q29574@cygbert.vinschen.de> <3C90B0D7.EB06F222@ieee.org> <3CB58D37.52F084E@ieee.org> <3.0.5.32.20020505114157.00815a40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020505114157.00815a40@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00140.txt.bz2

On Sun, May 05, 2002 at 11:41:57AM -0400, Pierre A. Humblet wrote:
> 2002-05-05  Pierre Humblet <pierre.humblet@ieee.org>
> 	* spawn.cc (spawn_guts): Move call to set_process_privilege()
> 	to load_registry_hive().
> 	* registry.cc (load_registry_hive): ditto.
> 	* fork.cc (fork_parent): Call sec_user_nih() only once.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
