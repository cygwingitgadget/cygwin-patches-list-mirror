Return-Path: <cygwin-patches-return-3493-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29071 invoked by alias); 5 Feb 2003 13:48:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29054 invoked from network); 5 Feb 2003 13:48:02 -0000
Date: Wed, 05 Feb 2003 13:48:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: security.cc
Message-ID: <20030205134800.GR5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030204103816.008064e0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030204103816.008064e0@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00142.txt.bz2

Hi Pierre,

On Tue, Feb 04, 2003 at 10:38:16AM -0500, Pierre A. Humblet wrote:
> This patch defines a new function get_sids_info that greatly reduces
> the number of passwd/group lookups, compared to the current approach.

this new get_sids_info() function does reimplement the functionality
of is_grp_member() in just a slightly different way.  I think that's
pretty unlucky since now we have two functions doing nearly the same.
Wouldn't it make sense to replace the remaining is_grp_member() calls
in sec_acl.cc by calls to get_sids_info(), too?

> 2003/02/04  Pierre Humblet  <pierre.humblet@ieee.org>

Could you please use the common format for the date in the ChangeLog,
using dashes instead of slashes?  Thanks.

> 	* sec_helper.cc (get_sids_info): New function.
> 	* security.cc (extract_nt_dom_user): Simplify with strechr.
> 	(get_user_groups): Initialize glen to MAX_SID_LEN.
> 	(get_user_local_groups): Ditto.
> 	(get_attribute_from_acl): Define ace_sid as cygpsid.
> 	(get_nt_attribute): Define owner_sid and group_sid as cygpsid.
> 	Call get_sids_info instead of cygsid.get_{u,g}id and is_grp_member.
> 	(get_nt_object_attribute): Ditto.
> 	(alloc_sd): Define ace_sid as cygpsid.

Otherwise applied with a minor change:

> +  if (!GetSecurityDescriptorOwner (psd, (void **) &owner_sid, &dummy))
  +  if (!GetSecurityDescriptorOwner (psd, (PSID *) &owner_sid, &dummy))

> +  if (!GetSecurityDescriptorGroup (psd, (void **) &group_sid, &dummy))
  +  if (!GetSecurityDescriptorGroup (psd, (PSID *) &group_sid, &dummy))

> +					(void **) &owner_sid, (void **) &group_sid,
  +					(PSID *) &owner_sid,
  +					(PSID *) &group_sid,


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
