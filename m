Return-Path: <cygwin-patches-return-3357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31359 invoked by alias); 8 Jan 2003 17:38:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31347 invoked from network); 8 Jan 2003 17:38:43 -0000
Date: Wed, 08 Jan 2003 17:38:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mk{passwd, group}
Message-ID: <20030108183840.D23921@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030107202647.00852a30@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030107202647.00852a30@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2003-q1/txt/msg00006.txt.bz2

On Tue, Jan 07, 2003 at 08:26:47PM -0500, Pierre A. Humblet wrote:
> 2003-01-07  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* mkpasswd.cc (current_user): Create.
> 	(usage): Reorganize to support Win95/98/ME.
> 	(main): Add option for -c. Reorganize to parse options for 
> 	Win95/98/ME and to call current_user. Add username in gecos field
> 	on Win95/98/ME.
> 	* mkgroup.cc (enum_groups): Print gid with %u.
> 	(print_win_error): Create from passwd.cc.
> 	(current_group): Create.
> 	(usage): Reorganize to support Win95/98/ME.
> 	(main): Add option for -c. Reorganize to parse options for 
> 	Win95/98/ME and to call current_group. 

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
