Return-Path: <cygwin-patches-return-2201-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27016 invoked by alias); 21 May 2002 14:59:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26968 invoked from network); 21 May 2002 14:59:45 -0000
Date: Tue, 21 May 2002 07:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygpath.cc
Message-ID: <20020521165943.R23036@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1264BCF4F426D611B0B00050DA782A50014C228E@mail.gft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1264BCF4F426D611B0B00050DA782A50014C228E@mail.gft.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00185.txt.bz2

On Tue, May 21, 2002 at 09:02:00AM +0200, "Schaible, Jörg" wrote:
> Hi,
> 
> as already announced here is the next patch for cygpath.cc supporting -l
> option to convert file names to Windows long format. Unfortunately this
> works not for strict mode, since functions cygwin_conv_to_win32_path and
> cygwin_conv_to_full_win32_path will return an error for a Windows short
> path/name.

AFAICS, the patch is ok.

Just two question:

- The -s and -l options are only valid with the -w option.  Shouldn't
  either the usage reflect that or the -s and -l options imply -w
  automatically?  It's not *that* obvious for the user that s/he
  has to use `cygpath -w -l ...'.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
