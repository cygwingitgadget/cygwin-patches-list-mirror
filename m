Return-Path: <cygwin-patches-return-2467-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30768 invoked by alias); 19 Jun 2002 12:56:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30716 invoked from network); 19 Jun 2002 12:55:56 -0000
Date: Wed, 19 Jun 2002 05:56:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020619145552.Y30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020616051506.GA6188@redhat.com> <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com> <3.0.5.32.20020617224247.007faad0@mail.attbi.com> <20020618134102.A23980@cygbert.vinschen.de> <3D0F5CB6.58140BD3@ieee.org> <20020619091814.X30892@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619091814.X30892@cygbert.vinschen.de>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00450.txt.bz2

On Wed, Jun 19, 2002 at 09:18:14AM +0200, cygpatch wrote:
> I'm going to test your small testapp as soon as I can.

Ok, I could test it now.  You're right.  I've logged in
using a domain account.  The machine has no local account
with the same name.  Your application showed the brutal truth:

Server: ret 0           <- NetUserGetInfo(server, ...) call ok
herbert                 <- usri3_name
Herbert Mayer           <- usri3_full_name
\\M31FGO\homes\herbert  <- usri3_home_dir
NULL: ret 2221          <- NetUserGetInfo(NULL, ...) returned with err
                           2221: "The user name could not be found."

This means, we can actually trash the NULL call.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
