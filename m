Return-Path: <cygwin-patches-return-2204-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26924 invoked by alias); 22 May 2002 10:05:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26873 invoked from network); 22 May 2002 10:05:48 -0000
Date: Wed, 22 May 2002 03:05:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygpath.cc
Message-ID: <20020522120546.B10218@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1264BCF4F426D611B0B00050DA782A50014C22D4@mail.gft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1264BCF4F426D611B0B00050DA782A50014C22D4@mail.gft.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00188.txt.bz2

On Wed, May 22, 2002 at 09:29:32AM +0200, "Schaible, Jörg" wrote:
> Hi Corinna,
> 
> >AFAICS, the patch is ok.
> 
> Fine.
> 
> >Just two question:
> >
> >- The -s and -l options are only valid with the -w option.  Shouldn't
> >  either the usage reflect that or the -s and -l options imply -w
> >  automatically?  It's not *that* obvious for the user that s/he
> >  has to use `cygpath -w -l ...'.
> 
> I always had in mind that it would be great to implement the options once
> for -u, too.

I see and that's a good idea, IMHO.  However, for now I have
applied your patch and just tweaked the usage output slightly.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
