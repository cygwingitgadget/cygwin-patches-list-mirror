Return-Path: <cygwin-patches-return-5547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20809 invoked by alias); 1 Jul 2005 13:59:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20796 invoked by uid 22791); 1 Jul 2005 13:59:04 -0000
Received: from vms046pub.verizon.net (HELO vms046pub.verizon.net) (206.46.252.46)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 01 Jul 2005 13:59:04 +0000
Received: from PHUMBLETLAP ([12.6.244.2])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IIY008AGC6A9UM3@vms046.mailsrvcs.net> for
 cygwin-patches@cygwin.com; Fri, 01 Jul 2005 08:58:59 -0500 (CDT)
Date: Fri, 01 Jul 2005 13:59:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [PATCH]: cygwin_internal
To: <cygwin-patches@cygwin.com>
Reply-to: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Message-id: <044501c57e45$06cba620$3e0010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00002.txt.bz2

The situation is that exim has the concept that some groups
are privileged and can have write access to the configuration file.
They are normally initialized to hard values set at compile time.

The Cygwin port of exim fakes things up so that the gid of Admins
(obtained from cygwin_internal) is put in the list of exim's privileged
groups.
The  problem is that the gid obtained by cygwin_internal (from the
Admins sid) may not match the gid reported by stat, which is obtained by
cygpsid::get_id () from the same Admins sid.

Pierre


----- Original Message ----- 
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
To: <cygwin-patches@cygwin.com>
Sent: Friday, July 01, 2005 9:36 AM
Subject: Re: [PATCH]: cygwin_internal


> The situation is that exim has the concept that some groups
> are privileged and can have write access to the configuration file.
> They are normally initialized to hard values set at compile time.
>
> The Cygwin port of exim fakes things up so that the gid of Admins
> (obtained from cygwin_internal) is put in the list of exim's privileged
> groups.
> The  problem is that the gid obtained by cygwin_internal (from the
> Admins sid) may not match the gid reported by stat, which is obtained by
> cygpsid::get_id () from the same Admins sid.
>
> Pierre
>
> ----- Original Message ----- 
> From: "Corinna Vinschen" <corinna-cygwin@cygwin.com>
> To: <cygwin-patches@cygwin.com>
> Sent: Friday, July 01, 2005 4:42 AM
> Subject: Re: [PATCH]: cygwin_internal
>
>
> > On Jul  1 00:52, Pierre A. Humblet wrote:
> > >
> > > The patch below uses cygpsid::get_id to implement CW_GET_UID_FROM_SID
> > > and CW_GET_GID_FROM_SID in cygwin_internal. Thus the sid is first
> > > compared to the user (or primary group) sid, before looking up
> > > the passwd (or group) file.
> > >
> > > This can make a difference when a sid appears multiple times in the
> > > passwd or group file, e.g. when one has both 544 and 0.
> > > This difference can cause exim (and perhaps others) to fail (it did
> > > happen to me).
> >
> > Can you please describe the exact situation?  I think I see it, but I
> > want to be really sure.  I'm not keen on accidentally breaking
Cygserver's
> > authentication routine.
> >
> >
> > Corinna
> >
> > -- 
> > Corinna Vinschen                  Please, send mails regarding Cygwin to
> > Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
> > Red Hat, Inc.
>

