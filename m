Return-Path: <cygwin-patches-return-2953-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11887 invoked by alias); 11 Sep 2002 14:12:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11873 invoked from network); 11 Sep 2002 14:12:54 -0000
Date: Wed, 11 Sep 2002 07:12:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: initgroups
Message-ID: <20020911161252.V1574@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com> <20020911123808.Q1574@cygbert.vinschen.de> <3D7F4284.46484222@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D7F4284.46484222@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00401.txt.bz2

On Wed, Sep 11, 2002 at 09:17:56AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> 
> > > P.S.: Why is there a need to define ILLEGAL_GID? It
> > > is never used to set a value.
> > 
> > It's used in chown_worker() to check against gid -1 on input.
> 
> O.K, it's used to check against -1, but -1 is never used as
> a reserved value. In other words, why is the largest possible
> gid value forbidden? 

It's not forbidden in the first place, it has a special meaning
when used as parameter to chown(), see
http://www.opengroup.org/onlinepubs/007904975/functions/chown.html

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
