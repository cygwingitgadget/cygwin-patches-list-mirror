Return-Path: <cygwin-patches-return-3333-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24432 invoked by alias); 16 Dec 2002 18:39:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24423 invoked from network); 16 Dec 2002 18:39:42 -0000
Date: Mon, 16 Dec 2002 10:39:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: security.cc and sec_acl.cc (ntsec, inheritance and sec_acl)
Message-ID: <20021216193940.I19104@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>
References: <3.0.5.32.20021205222631.007d3920@mail.attbi.com> <20021210112403.B7796@cygbert.vinschen.de> <3DFDF1C4.575D6360@ieee.org> <20021216184320.H19104@cygbert.vinschen.de> <3DFE151D.B657F3EF@ieee.org> <3DFE1867.1242AEFC@ieee.org> <3DFE1AD7.76CA224D@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFE1AD7.76CA224D@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00284.txt.bz2

On Mon, Dec 16, 2002 at 01:26:31PM -0500, Pierre A. Humblet wrote:
> ... and thus it may merge entries for the current owner and
> for the default owner (creator_owner). Ditto for groups.

What?  How should it?  It only merges entries with the same uid/gid
and with the same type (USER/GROUP).  It won't never merge a user
with the creator_owner entry.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
