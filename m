Return-Path: <cygwin-patches-return-3297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27245 invoked by alias); 10 Dec 2002 12:45:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27225 invoked from network); 10 Dec 2002 12:45:28 -0000
Date: Tue, 10 Dec 2002 04:45:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Internal get{pw,gr}XX calls
Message-ID: <20021210134526.D7796@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021129184501.E1398@cygbert.vinschen.de> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com> <20021129184501.E1398@cygbert.vinschen.de> <3.0.5.32.20021201000321.0082b440@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021201000321.0082b440@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00248.txt.bz2

On Sun, Dec 01, 2002 at 12:03:21AM -0500, Pierre A. Humblet wrote:
> 2002-11-30  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* pwdgrp.h (pwdgrp_check::pwdgrp_state): Replace by 
> 	pwdgrp_check::isinitializing ().
> 	(pwdgrp_check::isinitializing): Create.
> 	* passwd.cc (grab_int): Change type to unsigned, use strtoul and 
> 	set the pointer content to 0 if the field is invalid.
> 	(parse_pwd): Move validity test after getting pw_gid.
> 	(read_etc_passwd): Replace "passwd_state <= " by 
> 	passwd_state::isinitializing ().	
> 	(internal_getpwuid): Ditto.
> 	(internal_getpwnam): Ditto.
> 	(getpwent): Ditto.
> 	(getpass): Ditto.
> 	* grp.cc (parse_grp): Use strtoul for gr_gid and verify the validity.
> 	(read_etc_group): Replace "group_state <= " by 
> 	group_state::isinitializing (). 
> 	(internal_getgrgid): Ditto.
> 	(getgrent32): Ditto.
> 	(internal_getgrent): Ditto.

I've applied the initial patch plus this one.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
