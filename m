Return-Path: <cygwin-patches-return-2579-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27539 invoked by alias); 2 Jul 2002 09:03:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27522 invoked from network); 2 Jul 2002 09:03:42 -0000
Date: Tue, 02 Jul 2002 02:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Windows username in get_group_sidlist
Message-ID: <20020702110340.H23555@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020629191915.0080d930@mail.attbi.com> <3D1726E7.4EC19839@ieee.org> <3.0.5.32.20020623235117.008008f0@mail.attbi.com> <20020624120506.Z22705@cygbert.vinschen.de> <20020624130226.GA19789@redhat.com> <20020624151450.G22705@cygbert.vinschen.de> <3D1726E7.4EC19839@ieee.org> <3.0.5.32.20020629191915.0080d930@mail.attbi.com> <3.0.5.32.20020701231704.0080f800@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020701231704.0080f800@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00027.txt.bz2

On Mon, Jul 01, 2002 at 11:17:04PM -0400, Pierre A. Humblet wrote:
> To imitate Windows, line 495 in security.cc       
> grp_list += well_known_system_sid;
> should thus be replaced by 
> grp_list += well_known_authenticated_users_sid;
> 
> (just do it if you like it, it's not in the patch).
> 
> Pierre
> 
> 2002-07-01  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* security.cc (get_logon_server): Interpret a zero length
> 	domain as the local domain.
> 	(verify_token): Accept the primary group sid if it equals
> 	the token user sid.

Applied including the authenticated users patch.  I've just changed
a comment.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
