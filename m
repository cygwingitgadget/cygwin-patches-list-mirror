Return-Path: <cygwin-patches-return-3522-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10474 invoked by alias); 6 Feb 2003 14:06:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10445 invoked from network); 6 Feb 2003 14:06:18 -0000
Date: Thu, 06 Feb 2003 14:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends
Message-ID: <20030206140616.GF5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030205114159.00800620@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030205114159.00800620@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00171.txt.bz2

On Wed, Feb 05, 2003 at 11:41:59AM -0500, Pierre A. Humblet wrote:
> 2003-02-05  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* security.h: Introduce names UNKNOWN_UID and UNKNOWN_GID and delete
> 	declaration of is_grp_member.
> 	* uinfo.cc (internal_getlogin): Use UNKNOWN_GID.
> 	* passwd.cc (pwdgrp::read_passwd): Use UNKNOWN_UID.
> 	* grp.cc (pwdgrp::read_group): Change group names to provide better
> 	feedback.
> 	(getgrgid): Use gid16togid32.
> 	* sec_helper.cc (is_grp_member): Delete.

Applied with changes:

> -      char group_name [UNLEN + 1] = "mkgroup";
> +      char group_name [UNLEN + 1] = "run mkgroup";

I didn't commit this change.

> +      if (myself->uid == UNKNOWN_UID)
> +	strcpy (group_name, "run mkpasswd"); /* Feedback... */

I've changed that to just "mkpasswd".

I don't like to introduce group names with spaces in it.  And since they
are longer than 8 chars, they'd get truncated by ls anyway.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
