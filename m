Return-Path: <cygwin-patches-return-2431-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6536 invoked by alias); 14 Jun 2002 11:36:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6521 invoked from network); 14 Jun 2002 11:36:57 -0000
Date: Fri, 14 Jun 2002 04:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020614133654.F30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com> <3D04C62B.E7804DC0@ieee.org> <20020611022812.GA30113@redhat.com> <20020612053233.GA21398@redhat.com> <20020613160337.K30892@cygbert.vinschen.de> <3D08B663.21AF56C2@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D08B663.21AF56C2@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00414.txt.bz2

On Thu, Jun 13, 2002 at 11:12:35AM -0400, Pierre A. Humblet wrote:
> Corinna,
> 
> Among the stuff that I sent last night, I think that the change to 
> syscalls.cc is non controversial.  It avoids calling internal_getlogin
> [...]

Please let's have a break.  I have to find a bug first and then
we're going to apply Chris' changes and some of yours.  I don't
know exactly which of your changes Chris want to apply.  Anyway,
we have to work from a new state then.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
