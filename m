Return-Path: <cygwin-patches-return-2199-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21718 invoked by alias); 21 May 2002 14:50:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21674 invoked from network); 21 May 2002 14:50:41 -0000
Date: Tue, 21 May 2002 07:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: lsa handle in security.cc
Message-ID: <20020521165039.P23036@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020519132851.007f2b80@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020519132851.007f2b80@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00183.txt.bz2

On Sun, May 19, 2002 at 01:28:51PM -0400, Pierre A. Humblet wrote:
> The invalid value for an lsa handle in security.cc
> is inconsistent. It is initially NULL, but in 
> close_local_policy () it is INVALID_HANDLE_VALUE.
> Calling LsaClose(NULL) causes a fault, at least in gdb.
> 
> The patch uses INVALID_HANDLE_VALUE uniformly, instead of 
> NULL. The converse would probably work as well, not sure
> which is better.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
