Return-Path: <cygwin-patches-return-4560-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9146 invoked by alias); 6 Feb 2004 10:37:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9134 invoked from network); 6 Feb 2004 10:37:27 -0000
Date: Fri, 06 Feb 2004 10:37:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: well_known_sids
Message-ID: <20040206103727.GP26148@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040204221719.007ce3f0@incoming.verizon.net> <20040205103858.GB9090@cygbert.vinschen.de> <402268A4.243CE18E@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402268A4.243CE18E@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00050.txt.bz2

On Feb  5 11:00, Pierre A. Humblet wrote:
> 2004-02-05  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* uinfo.cc (cygheap_user::init): Use sec_user_nih to build a
> 	security descriptor. Set both the process and the default DACLs.
> 	* fork.cc (fork_parent): Use sec_none_nih security attributes.
> 	* spawn.cc (spawn_guts): Ditto.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
