Return-Path: <cygwin-patches-return-3795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2700 invoked by alias); 9 Apr 2003 13:02:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2636 invoked from network); 9 Apr 2003 13:02:38 -0000
Date: Wed, 09 Apr 2003 13:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mkpasswd and mkgroup
Message-ID: <20030409130236.GD1928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030404195241.007f4a40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030404195241.007f4a40@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00022.txt.bz2

On Fri, Apr 04, 2003 at 07:52:41PM -0500, Pierre A. Humblet wrote:
> 2003-04-05  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* mkpasswd.c (current_user): print uid and gid as unsigned.
> 	(enum_users): Ditto. Do not free servername.
> 	(usage): Update to allow several domains and improve -p.
> 	(main): On Win9x limit uids to 1000. Only print specials
> 	when -l is specified. Add a loop to allow several domains
> 	and free servername in the loop.
> 	* mkgroup.c (enum_groups): Do not free servername.
> 	(usage): Update to allow several domains. Change uid to gid.
> 	(main): Only print specials when -l is specified. Add a 
> 	loop to allow several domains and free servername in the loop.

Ok with me.  Please apply.

Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
