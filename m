Return-Path: <cygwin-patches-return-3337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9000 invoked by alias); 16 Dec 2002 20:00:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8989 invoked from network); 16 Dec 2002 20:00:36 -0000
Message-ID: <3DFE311E.9AE4873E@ieee.org>
Date: Mon, 16 Dec 2002 12:00:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de> <3DFE151D.B657F3EF@ieee.org> <3DFE1867.1242AEFC@ieee.org> <3DFE1AD7.76CA224D@ieee.org> <20021216193940.I19104@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00288.txt.bz2

Corinna Vinschen wrote:
> 
> On Mon, Dec 16, 2002 at 01:26:31PM -0500, Pierre A. Humblet wrote:
> > ... and thus it may merge entries for the current owner and
> > for the default owner (creator_owner). Ditto for groups.
> 
> What?  How should it?  It only merges entries with the same uid/gid
> and with the same type (USER/GROUP).  It won't never merge a user
> with the creator_owner entry.

	  && (pos = searchace (aclbufp, nentries,
			       aclbufp[i].a_type | ACL_DEFAULT,
			       (aclbufp[i].a_type & (USER|GROUP))
			       ? aclbufp[i].a_id : -1)) >= 0

For non USER|GROUP it sets uid to -1, which will match anything.

Tonite (here) I will reverify everything and put all the diffs in a single 
file as recommended. You can have a second look in the morning.

Pierre
