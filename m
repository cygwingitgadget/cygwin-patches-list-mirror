Return-Path: <cygwin-patches-return-3379-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12431 invoked by alias); 12 Jan 2003 11:41:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12419 invoked from network); 12 Jan 2003 11:41:27 -0000
Date: Sun, 12 Jan 2003 11:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec: inheritance, sec_acl and chown
Message-ID: <20030112124114.B11397@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030108223142.00833940@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030108223142.00833940@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2003-q1/txt/msg00028.txt.bz2

On Wed, Jan 08, 2003 at 10:31:42PM -0500, Pierre A. Humblet wrote:
> 2003/01/07  Pierre Humblet  <pierre.humblet@ieee.org>
> 
> 	* sec_acl.cc (search_ace): Use id == -1, instead of < 0, as wildcard.
> 	(setacl): Start the search for a matching default at the next entry.
> 	Invalidate the type of merged entries instead of clearing it.
> 	Use well_known_creator for default owner and owning group and do 
> 	not try to merge non-default and default entries in these cases.
> 	(getacl): Recognize well_known_creator for default owner and group.
> 	(acl_worker): Improve errno settings and streamline the nontsec case.
> 	* security.cc (write_sd): Remove the call to set_process_privilege.
> 	(alloc_sd): If the owner changes, call set_process_privilege and return
> 	immediately on failure. Change inheritance rules: on new directories add
> 	inherit only allow ACEs for creator_owner, creator_group and everyone. 
> 	Preserve all inheritances through chmod and chown calls. Introduce 
> 	isownergroup to implement the uid == gid case, to keep the inheritance 
> 	code simple. Do not initialize owner_sid and group_sid and stop using 
> 	the variable psd.

Finally applied.  Good work, IMHO!

Let's test this a week before releasing 1.3.19, ok?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
