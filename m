Return-Path: <cygwin-patches-return-4665-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24391 invoked by alias); 10 Apr 2004 19:25:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24380 invoked from network); 10 Apr 2004 19:25:38 -0000
Date: Sat, 10 Apr 2004 19:25:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rootdir
Message-ID: <20040410192536.GP26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410124817.0083fc20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040410124817.0083fc20@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00017.txt.bz2

On Apr 10 12:48, Pierre A. Humblet wrote:
> This patch avoids a couple of long strcpy. 
> 
> Pierre
> 
> 2004-04-10  Pierre Humblet <pierre.humblet@ieee.org>
>  
> 	* fhandler.cc (rootdir): Add and use second argument.
> 	* winsup.h: (rootdir) Add second argument in declaration.
> 	* path.cc (fs_info::update): Modify call to rootdir.
> 	* syscalls.cc (check_posix_perm): Ditto.
> 	(statfs): Ditto. Move syscall_printf near top.

Applied with a few changes in rootdir() itself.  It's slightly
faster this way.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
