Return-Path: <cygwin-patches-return-3929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30359 invoked by alias); 9 Jun 2003 13:30:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30254 invoked from network); 9 Jun 2003 13:30:21 -0000
Date: Mon, 09 Jun 2003 13:30:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exec after seteuid
Message-ID: <20030609133019.GK18350@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607094044.00805970@mail.attbi.com> <3.0.5.32.20030607153456.008051b0@incoming.verizon.net> <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030608173256.007c6d00@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00156.txt.bz2

On Sun, Jun 08, 2003 at 05:32:56PM -0400, Pierre A. Humblet wrote:
> 2003-06-09  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* spawn.cc (spawn_guts): Call CreateProcess while impersonated, 
> 	when the real {u,g}ids and the groups are original.
> 	Move RevertToSelf and ImpersonateLoggedOnUser to the main line.
> 	* uinfo.cc (uinfo_init): Reorganize. If CreateProcess was called 
> 	while impersonated, preserve the uids and gids and call
>  	ImpersonateLoggedOnUser. Preserve the uids and gids on Win9X.
> 
> 	* exceptions.cc (error_start_init): Quote the pgm in the command.

Applied with some minor changes, mainly a bit more comment and a slight
simplification of uinfo_init().

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
